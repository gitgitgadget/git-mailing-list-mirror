From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH] builtin/clean.c: Fix some sparse warnings
Date: Fri, 21 Dec 2012 23:31:03 +1100
Message-ID: <CAKJhZwSLSbR2pTB67-KLtrtuFsq6HtBGdHbN8h6tLiXBKynQzg@mail.gmail.com>
References: <50D35A13.9080605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 21 13:31:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm1l7-0008RK-R9
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 13:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab2LUMbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 07:31:08 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37682 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2LUMbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 07:31:05 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so6016841ieb.6
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3dW+rDKj6I9gh3ZZVuHG0IsCKtFsBaEQb3Kk6Wya7fc=;
        b=nOyQDEuuyXRjGAWA6p4yvJZ1F1TtA1khxYlKa82ogyzAZLch1LpDNrV5IGPDIo6hxl
         OI19UlQ4IwsYT6QrXBvKjEKGkXp4lgqRkBnpS9oLtoAHclD+wMrt9ks9iESLDLXwC+7U
         ujCdqhhl8j0TT/3N4I8TAyJHNc6skIIJq6Im+XhlxXp6tQYElzoqwvgs1jHUW5sasaRH
         NNeratfjx86RXPFzEVQg9ofWLeO5aCR5SVYnSnUCCnjrm8khq3ZtXeyhHLpCMjJGxsHW
         8rLEFRG//c5rfRbjVNgQl0IWm930ZconEbcphV1/AI4bRe4Stcm8xcj6H/xHzfiO0aqa
         mW+g==
Received: by 10.50.159.165 with SMTP id xd5mr8789575igb.82.1356093063629; Fri,
 21 Dec 2012 04:31:03 -0800 (PST)
Received: by 10.50.13.104 with HTTP; Fri, 21 Dec 2012 04:31:03 -0800 (PST)
In-Reply-To: <50D35A13.9080605@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211967>

Thanks, Ramsay. I am rewriting the whole patch to do things a better
way (as kindly suggested by Junio). So the print_filtered() function
is going to disappear, but thanks for pointing out the problems with
the existing code.
Cheers,
Zoltan

On 21 December 2012 05:33, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
> Sparse issues two "Using plain integer as NULL pointer" warnings
> (lines 41 and 47).
>
> The first warning relates to the initializer expression in the
> declaration for the 'char *dir' variable. In order to suppress
> the warning, we simply replace the zero initializer with NULL.
>
> The second warning relates to an expression, as part of an if
> conditional, using the equality operator to compare the 'dir'
> variable to zero. In order to suppress the warning, we replace
> the 'dir == 0' expression with the more idiomatic '!dir'.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Zoltan,
>
> If you have already updated your patch and made this redundant
> (it's been a few days since I read the list or fetched git.git),
> please ignore this. Otherwise, could you please squash this into
> the new version of commit 16e4033e6 ("git-clean: Display more
> accurate delete messages", 17-12-2012).
>
> [BTW, in the same conditional expression you have an strncmp()
> call which doesn't quite follow the style/conventions of the
> existing code.]
>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  builtin/clean.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 1c25a75..0c603c8 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -38,13 +38,13 @@ static void print_filtered(const char *msg, struct string_list *lst)
>  {
>         int i;
>         char *name;
> -       char *dir = 0;
> +       char *dir = NULL;
>
>         sort_string_list(lst);
>
>         for (i = 0; i < lst->nr; i++) {
>                 name = lst->items[i].string;
> -               if (dir == 0 || strncmp(name, dir, strlen(dir)) != 0)
> +               if (!dir || strncmp(name, dir, strlen(dir)) != 0)
>                         printf("%s %s\n", msg, name);
>                 if (name[strlen(name) - 1] == '/')
>                         dir = name;
> --
> 1.8.0
>
