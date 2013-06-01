From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 21:03:31 +0700
Message-ID: <CACsJy8BRYHkSj1YR9mW=_tdKX_+xKNxpVx+RNYEdoW3S36w=8Q@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimPg-00052K-UV
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab3FAOEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:04:05 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54721 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3FAOED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:04:03 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so4833100obb.33
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kb1f6SSdW8PUeOaGO8CnLJMv9mnNc02IcJnPqYAs7IA=;
        b=l8XvDG9PknxVFTq0PxnjIQ8ZK+Diz0ptZevHJSm8RW508Dct39YkZ8Qr8e9smIQbFT
         QTCxWfGmkZ9kF5CA9DzJftgc7ryjoK52/zb/YBo7XzHa8cozHVk92z+ZiD8kl9TxxuWw
         ++18FrlifpUOGtEQSi0Kf5Mk9d/TBobuNs+oD4m5/Y91OPLJMxbH8ghXdqzvE2I1a+db
         S/HHEDwGauHeTJXc/VcY/yvYadH5ciQXQ32MdiXys/2A/vDwjbz+t60+XCHyfv/9hJhy
         IdpymIAk77p1CSe2+uWD53fnKvVSeqvlFQRr3EyxK14I1PteqR8hXunYRJ2XVw1a0CUF
         O/xA==
X-Received: by 10.182.134.231 with SMTP id pn7mr7365523obb.11.1370095441995;
 Sat, 01 Jun 2013 07:04:01 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Sat, 1 Jun 2013 07:03:31 -0700 (PDT)
In-Reply-To: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226127>

On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Nobody is checking for specific error codes; it's the errno that's
> important.

Have you just disregarded the in-code comment you just removed with
one statement? Did you check all its callers?

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  run-command.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 1b32a12..e54e943 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -244,21 +244,11 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>                 code = WTERMSIG(status);
>                 if (code != SIGINT && code != SIGQUIT)
>                         error("%s died of signal %d", argv0, code);
> -               /*
> -                * This return value is chosen so that code & 0xff
> -                * mimics the exit code that a POSIX shell would report for
> -                * a program that died from this signal.
> -                */
> -               code += 128;
>         } else if (WIFEXITED(status)) {
>                 code = WEXITSTATUS(status);
> -               /*
> -                * Convert special exit code when execvp failed.
> -                */
> -               if (code == 127) {
> -                       code = -1;
> +               /* convert special exit code when execvp failed. */
> +               if (code == 127)
>                         failed_errno = ENOENT;
> -               }
>         } else {
>                 error("waitpid is confused (%s)", argv0);
>         }
> --
> 1.8.3.358.g5a91d05
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Duy
