From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 11/45] cherry-pick: don't barf when there's nothing
 to do
Date: Sun, 9 Jun 2013 21:21:43 +0200
Message-ID: <20130609192143.GC12122@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	iveqy@iveqy.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ull8y-0007uq-Lw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab3FITTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:19:04 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:43268 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab3FITTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:19:03 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2970658lbi.12
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0lkLNUWVWmV5PqmbLdPaZhIb01Igd/uUtG1a2LOD7ug=;
        b=aaPPPfohCQ6HrKvM6IE9ZbxxkVj8m0N0XVLLq8zOwSq7SzHxLX9eJ7rThZ2/r+xEn8
         GuGnsg1UXDE6Dhhlf78rRQKyzWHoKBLO2wUc0VPkiOphp58MyYcUhdiESYsOS5j1DucJ
         t2WKrtOnkiwzZe0dG5XvyDBTNmELFMvmhxFFJkIQPlwAnPaYri0BfzDSVlbH3FO7hYcz
         mJ9DMMVuGzFB74V5SgH21xstU/nExQsQiCaFULJGMCWMU60lPb7ZvaHJaks0xrFpDXTL
         gJkpWHdvN74E+c3WrYRnMuMyZJnEiR/QwkVhnf5SrOZ1Ksya67dnBbgh/Y13hmyxRs/V
         yCxQ==
X-Received: by 10.152.88.105 with SMTP id bf9mr1808826lab.38.1370805541605;
        Sun, 09 Jun 2013 12:19:01 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id zo6sm4459447lbb.9.2013.06.09.12.19.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:19:01 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UllBP-0003F0-35; Sun, 09 Jun 2013 21:21:43 +0200
Content-Disposition: inline
In-Reply-To: <1370796057-25312-12-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227105>

On Sun, Jun 09, 2013 at 11:40:23AM -0500, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/sequencer.c             | 4 ++--
>  t/t3510-cherry-pick-sequence.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/sequencer.c b/builtin/sequencer.c
> index 23b01b7..4d7dc8b 100644
> --- a/builtin/sequencer.c
> +++ b/builtin/sequencer.c
> @@ -565,8 +565,8 @@ static void prepare_revs(struct replay_opts *opts=
)
>  	if (prepare_revision_walk(opts->revs))
>  		die(_("revision walk setup failed"));
> =20
> -	if (!opts->revs->commits)
> -		die(_("empty commit set passed"));
> +	if (!opts->revs->commits && !opts->quiet)
> +		error(_("empty commit set passed"));
>  }
> =20
>  static void read_and_refresh_cache(struct replay_opts *opts)
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-se=
quence.sh
> index 7b7a89d..33c5512 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -472,7 +472,7 @@ test_expect_success 'malformed instruction sheet =
2' '
> =20
>  test_expect_success 'empty commit set' '
>  	pristine_detach initial &&
> -	test_expect_code 128 git cherry-pick base..base
> +	git cherry-pick base..base

Shouldn't this result in the error "empty commit set passed"? If so,
shouldn't that be checked to actually print that error?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
