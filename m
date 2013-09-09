From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] rebase: fix run_specific_rebase's use of "return" on FreeBSD
Date: Mon, 9 Sep 2013 14:30:17 +0530
Message-ID: <CALkWK0nbcCuEfhagT4aUzqX8iynbhUvkRO9asmRHSGmEPRYZiA@mail.gmail.com>
References: <1378716795-5420-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	avg@freebsd.org, christoph.mallon@gmx.de
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 09 11:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIxLC-0007As-7G
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 11:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab3IIJA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 05:00:58 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42986 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3IIJA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 05:00:57 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so12408149ieb.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oNW+HETteGz5aJKCTFgJ2ETUApuCs2n4OwvhfnU0Axk=;
        b=qqdjLoaRHMYv13LYBV2IgVpAYaorwZog7m7akvAkhQZ0XW4BsCahgRmhbE4qhpKOob
         swxJLoyeztsPPgMH/8v4fkgBIHXWjX1DU9dwE6OpTLHQxP3JszYfqjRwyO/DRZJXNF9o
         ShySiq8Yda3DzLzATj9N0nDOQ9SLff62SY5GkQGVlCXQK+AZgsBsVaiE3GsFCocvcw2e
         /RmeIvMWnAbGC5IZSpAxMYDcM/DcuX3YaL/J3jh1JkUKbNZCxJh5bZ0ewWRCpWmaFSaJ
         uFAfWT03jVHlYN6lawfckARqwpL+iLo76hhV0F9hG39FB5N92Cc7sJlZNeR1XA1rUXKm
         RHcA==
X-Received: by 10.50.23.16 with SMTP id i16mr7133256igf.50.1378717257415; Mon,
 09 Sep 2013 02:00:57 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Mon, 9 Sep 2013 02:00:17 -0700 (PDT)
In-Reply-To: <1378716795-5420-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234319>

Matthieu Moy wrote:
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 8d7659a..226752f 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -167,13 +167,22 @@ You can run "git stash pop" or "git stash drop" at any time.
>         rm -rf "$state_dir"
>  }
>
> -run_specific_rebase () {
> +run_specific_rebase_internal () {
>         if [ "$interactive_rebase" = implied ]; then
>                 GIT_EDITOR=:
>                 export GIT_EDITOR
>                 autosquash=
>         fi
> +       # On FreeBSD, the shell's "return" returns from the current
> +       # function, not from the current file inclusion.
> +       # run_specific_rebase_internal has the file inclusion as a
> +       # last statement, so POSIX and FreeBSD's return will do the
> +       # same thing.
>         . git-rebase--$type
> +}

Most excellent. Thanks for fixing this.
