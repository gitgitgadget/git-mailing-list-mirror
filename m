From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 2.6.0: Comment in rebase instruction has become too rigid
Date: Tue, 29 Sep 2015 11:30:45 -0700
Message-ID: <xmqqeghh9iy2.fsf@gitster.mtv.corp.google.com>
References: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
	<vpqr3lhb719.fsf@grenoble-inp.fr> <vpqzj0588i2.fsf@grenoble-inp.fr>
	<xmqqk2r99jjp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nazri Ramliy <ayiehere@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:31:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgzgS-0007gJ-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 20:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbbI2SbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 14:31:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33337 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935445AbbI2Sar (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 14:30:47 -0400
Received: by pacex6 with SMTP id ex6so13367639pac.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4KoCGMa5YrNWT5tIlJdAE0GWpMfUJTt3sVxYLYmKtHU=;
        b=U1M2X666pTP7xQtQFVb9baTGlZE22SpYomSu2hIhjEK+vhuP9J+DmUHszeULSixAUM
         Mq1dDL+GZ8rokXi9NSJGpaaLT7I/8wa3q67ylr8E85S3ifkvcWeNC7/ojPR8VoL6F9IE
         1ERCFymaso7KXBWPkDUViTB3uXsfXejlcTm5VvFM28ei4Wu3DuGvZTG/8ZSZgNQV+tDc
         beFeiPyyxAocJusfK2qq8l7/+/fE+tB2eY/XGwmsCdjqfwtngqNbJDbcrOUM85GJyTr8
         WdRlgvvwI//UcboMm4TMFSaiCnoB2bmAtLIRpFgTgzMErBhgWI0r3WhpKbKlyZBsy+hZ
         SvOA==
X-Received: by 10.68.137.35 with SMTP id qf3mr34353358pbb.89.1443551446855;
        Tue, 29 Sep 2015 11:30:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b19c:d31d:b45e:3f4e])
        by smtp.gmail.com with ESMTPSA id xz5sm26888509pbb.12.2015.09.29.11.30.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Sep 2015 11:30:46 -0700 (PDT)
In-Reply-To: <xmqqk2r99jjp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Sep 2015 11:17:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278832>

Junio C Hamano <gitster@pobox.com> writes:

> I know you alluded to preprocess what is fed to stripspace, but I
> wonder if we can remove the misguided call to stripspace in the
> first place and do something like the attached instead.
>
>  git-rebase--interactive.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f01637b..a64f77a 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -886,7 +886,6 @@ check_commit_sha () {
>  # from the todolist in stdin
>  check_bad_cmd_and_sha () {
>  	retval=0
> -	git stripspace --strip-comments |
>  	(
>  		while read -r line
>  		do
> @@ -896,7 +895,7 @@ check_bad_cmd_and_sha () {
>  			sha1=$2
>  
>  			case $command in
> -			''|noop|x|"exec")
> +			'#'*|''|noop|x|"exec")
>  				# Doesn't expect a SHA-1
>  				;;
>  			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)

Nah, that would not work, as I misread the "split only at SP" manual
parsing of $line.

I shouldn't be responding to the git list traffic on my vacation
day, especially before my first caffeine X-<
