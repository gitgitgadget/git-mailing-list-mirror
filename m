From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Add command `git bisect state` that checks if the current
 bisection process has reached the first bad commit.
Date: Fri, 16 Aug 2013 00:17:27 -0400
Message-ID: <CAPig+cTfdnMRT61NQoHcF9-tt-wHABKPHi8HBXijQeB-jb1VyQ@mail.gmail.com>
References: <1376606112-1712-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Mattias_Andr=E9e?= <maandree@operamail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 06:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VABTh-0003nI-GC
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 06:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab3HPER3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 00:17:29 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:55607 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab3HPER2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 00:17:28 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1120295lab.28
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=h0wOMv8SN1HoIwNKUpC7FEWwuKSUZQYKde87n0vSHRk=;
        b=EeLXjoYtDv9LXtjTc6c3S9g7wwYUlJ1gbuROAo61UvpGj7QVN9tRAZu0zwsE+qTu8F
         mLuCp4OMDLhhUK4HX9xEPFcJyGU7Fh4a3GwDK2TwlEFC5zbZMKnhUeNom8U8G0s5rC8j
         EkMcuDYbOipJDjdNehKlCxKA8HoMisjRLQnEJBPRbpG8lIJb0Jh+TAPO4TEweQPWHTiL
         Sp975XoQYSoK1ij9+dEESnO+cgumDJkoDh78Ueatzf7hiGQGiq1RWuYO6Mz+5NkGRLXy
         kOtb903F+CCQVzNQxIqRu71zEzhT0/BZqUoEaf24tjAUqdIX5N157GK7tHbUESij80i2
         A3WQ==
X-Received: by 10.112.74.20 with SMTP id p20mr28083lbv.36.1376626647206; Thu,
 15 Aug 2013 21:17:27 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 15 Aug 2013 21:17:27 -0700 (PDT)
In-Reply-To: <1376606112-1712-1-git-send-email-maandree@operamail.com>
X-Google-Sender-Auth: ZLhO0cb42RaiK4u6Ke5n8ehLqf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232398>

On Thu, Aug 15, 2013 at 6:35 PM, Mattias Andr=E9e <maandree@operamail.c=
om> wrote:
> This can be used for automated bisection without a check script.
>
> Signed-off-by: Mattias Andr=E9e <maandree@operamail.com>
> ---
>  Documentation/git-bisect.txt | 13 +++++++++++++
>  git-bisect.sh                | 11 ++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.=
txt
> index f986c5c..ca8c09d 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -25,6 +25,7 @@ on the subcommand:
>   git bisect visualize
>   git bisect replay <logfile>
>   git bisect log
> + git bisect state
>   git bisect run <cmd>...
>
>  This command uses 'git rev-list --bisect' to help drive the
> @@ -104,6 +105,18 @@ For example, `git bisect reset HEAD` will leave =
you on the current
>  bisection commit and avoid switching commits at all, while `git bise=
ct
>  reset bisect/bad` will check out the first bad revision.
>
> +Bisect state
> +~~~~~~~~~~~~~~~~
> +
> +To see the bisection process has finnished, issue the following comm=
and:

s/see the/see if the/
s/finnished/finished/

> +
> +------------
> +$ git bisect state
> +------------
> +
> +Exit successfully (i.e., with return code 0), if and only if the cur=
rent
> +bisection has reached the first bad or possible first bad commit.
> +
>  Bisect visualize
>  ~~~~~~~~~~~~~~~~
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 9f064b6..6ddda34 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|r=
un]'
> +USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|r=
un|state]'
>  LONG_USAGE=3D'git bisect help
>         print this long help message.
>  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec=
>...]
> @@ -23,6 +23,8 @@ git bisect log
>         show bisect log.
>  git bisect run <cmd>...
>         use <cmd>... to automatically bisect.
> +git bisect state
> +       check if the bisection is complete.
>
>  Please use "git help bisect" to get the full man page.'
>
> @@ -491,6 +493,11 @@ bisect_log () {
>         cat "$GIT_DIR/BISECT_LOG"
>  }
>
> +bisect_complete_state () {
> +       cat "$GIT_DIR/BISECT_LOG" | tail -n 1 | grep -E '^# (possible=
 |)first bad commit:' > /dev/null
> +       exit $?
> +}
> +
>  case "$#" in
>  0)
>         usage ;;
> @@ -519,6 +526,8 @@ case "$#" in
>                 bisect_log ;;
>         run)
>                 bisect_run "$@" ;;
> +       state)
> +               bisect_complete_state ;;
>         *)
>                 usage ;;
>         esac
> --
> 1.8.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
