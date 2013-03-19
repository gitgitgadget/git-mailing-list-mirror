From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v1 27/45] Convert run_add_interactive to use struct
 pathspec
Date: Tue, 19 Mar 2013 10:58:23 +0000
Message-ID: <20130319105823.GB2283@serenity.lan>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-28-git-send-email-pclouds@gmail.com>
 <20130318182602.GA2164@serenity.lan>
 <CACsJy8AMcfwx5UurNQs1-uJLw_Xt+PAHFU_Tjizf2zOsYECyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHuFv-0004Jl-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab3CSK6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 06:58:32 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:60254 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3CSK6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:58:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A8850161E1C8;
	Tue, 19 Mar 2013 10:58:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qbogRe2fErWn; Tue, 19 Mar 2013 10:58:29 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7BE02161E1A2;
	Tue, 19 Mar 2013 10:58:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AMcfwx5UurNQs1-uJLw_Xt+PAHFU_Tjizf2zOsYECyvg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218503>

On Tue, Mar 19, 2013 at 08:58:23AM +0700, Duy Nguyen wrote:
> On Tue, Mar 19, 2013 at 1:26 AM, John Keeping <john@keeping.me.uk> wr=
ote:
> > On Fri, Mar 15, 2013 at 01:06:42PM +0700, Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy wrote:
> >> This passes the pathspec, more or less unmodified, to
> >> git-add--interactive. The command itself does not process pathspec=
=2E It
> >> simply passes the pathspec to other builtin commands. So if all th=
ose
> >> commands support pathspec, we're good.
> >
> > This breaks "git reset --keep" in a subdirectory for me.
> >
> > I ran "git reset --keep <branch>" in a subdirectory and got:
> >
> >     fatal: BUG: parse_pathspec cannot take no argument in this case
> >
> > Bisecting points to this commit.
> >
> > The simplest test case is:
> >
> >     ( cd t && ../bin-wrappers/git reset --keep HEAD )
> >
> > which works on master but not pu.
>=20
> Beautiful. I got messed up with C operator precedence. This should fi=
x
> it. I'll check the rest of parse_pathspec calls later.

Yes, this fixes it.  Thanks.

> diff --git a/builtin/reset.c b/builtin/reset.c
> index ab3917d..b665218 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -219,7 +219,7 @@ static void parse_args(struct pathspec *pathspec,
>         *rev_ret =3D rev;
>         parse_pathspec(pathspec, 0,
>                        PATHSPEC_PREFER_FULL |
> -                      patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
> +                      (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
>                        prefix, argv);
>  }
>=20
> --=20
> Duy
