From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/9] builtin: check pager.<cmd> configuration if 
	RUN_SETUP_GENTLY is used
Date: Tue, 13 Apr 2010 07:29:00 +0200
Message-ID: <u2ufcaeb9bf1004122229l72de0e55i8dbd993d6cb16d2b@mail.gmail.com>
References: <20100413021153.GA3978@progeny.tock>
	 <20100413023003.GH4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 07:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Ygc-0007a1-MW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 07:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971Ab0DMF3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 01:29:05 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:58633 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0DMF3D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 01:29:03 -0400
Received: by ewy20 with SMTP id 20so2342361ewy.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9Ay9kKxXbfz0982QWOmuAZ41CJN/A1JFx6wyRsQlWHw=;
        b=IyQuBxlaG4lk4DUFJd7dbdIGBjx129r60faaiRD03DBuV2aDLZpuCa1wqWr1SaJaES
         dczolNzz/EbKochPxAjAacRCka1Kcb//1RWpybcjbFDUIRIcXwvULvwqOX4+yvdphVEs
         i0y1Oi2sVfZ9FY1OsIqTQNAKqamsVu3wfYZSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eTKfZ1FdWgB3NmzFiQLDAnlfQ9O52NWjq9BHJnoD5n1l26gmNKqZyWnOmfy7EgyaK8
         pg4qgrZ6zZCisdVJDhfqCQvLSMiMvE8U8fc8kPJLO2zEBJQ7ljlsHj8bw/xUMmtGRs6W
         Of7C3kzARC0Hlcy4L51j+q7vAbV7xBgcHGVrI=
Received: by 10.213.21.197 with HTTP; Mon, 12 Apr 2010 22:29:00 -0700 (PDT)
In-Reply-To: <20100413023003.GH4118@progeny.tock>
Received: by 10.213.63.74 with SMTP id a10mr2928062ebi.41.1271136540968; Mon, 
	12 Apr 2010 22:29:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144790>

2010/4/13 Jonathan Nieder <jrnieder@gmail.com>:
> Eventually, all git commands should check their configuration at
> start-up. =C2=A0For now, reading configuration before repository disc=
overy
> is dangerous because it could cause a pager.<cmd> setting from the
> current repository to be neglected.
>
> But for commands with RUN_SETUP or RUN_SETUP_GENTLY set, it is safe.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0git.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git.c b/git.c
> index 20e9bfc..56e93cf 100644
> --- a/git.c
> +++ b/git.c
> @@ -251,7 +251,7 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0prefix =3D setup_git_directory_gently(&nongit_ok);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (use_pager =3D=3D=
 -1 && p->option & RUN_SETUP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (use_pager =3D=3D=
 -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0use_pager =3D check_pager_config(p->cmd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (use_pager =
=3D=3D -1 && p->option & USE_PAGER)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0use_pager =3D 1;

This still leaves a chance of going wrong: when user explicitly gives
"--paginate", use_pager will be 1, but commands like "git init" does
not have RUN_SETUP*. So when setup_pager is called later on, it will
mess things up. This could be solved completely (indeed I have a patch
under testing), but it would require unset_git_directory(), making
this series a bit longer :(


--=20
Duy
