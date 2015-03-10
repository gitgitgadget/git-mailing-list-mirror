From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Adding - shorthand for @{-1} in RESET command
Date: Tue, 10 Mar 2015 02:54:52 -0400
Message-ID: <CAPig+cRAB-LQctj6UOKUXps-MEh2C_EbSp_3=wfgxtWx6xCbhw@mail.gmail.com>
References: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:54:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVE4A-0004sk-9k
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 07:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbCJGyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 02:54:53 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:45183 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbCJGyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 02:54:52 -0400
Received: by ykp131 with SMTP id 131so8097530ykp.12
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lIdPk3hD88YdGIg0Un6ArOxjoQWKNBQpUQNzrDN1TTg=;
        b=y3dYNZvz8Uo61u9BSLti47a/J3xWZWNH1vBPjW4Ctkud5Nuoa4cygwtpswSMAR9Voq
         /FJtQ5KlPpuKx0msw9+0t9SvUqXZZ2eePFv7KR8GneCFLykGhNw6HGGkSru9Voi+KX5M
         ax4lq8r5uAUDzoL23NhBC6cmULXksv2rjQHjVc7QA6hepGXJ6bEahzmcUJO0C5Q328yO
         omRam3w9YB9KzwXv7JTLDlTq177Roo1lltNvpFqckR4Yo5iissb4U8idNpjzbfQmEOSM
         W2hP2xhbK5SVFJ+r4mRwg692vDKk3g9pcuOJSWhY7jGX666s9/5J5EnhIsWRIzSAuJX2
         yD9Q==
X-Received: by 10.236.70.100 with SMTP id o64mr30276912yhd.94.1425970492217;
 Mon, 09 Mar 2015 23:54:52 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Mon, 9 Mar 2015 23:54:52 -0700 (PDT)
In-Reply-To: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
X-Google-Sender-Auth: SsIg_sPH79lNAFw7iZZ2G6gj2j8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265213>

On Mon, Mar 9, 2015 at 4:46 PM, Sundararajan R <dyoucme@gmail.com> wrote:
> Please give feedback and suggest things I may have missed out on.
> I hope I have incorporated all the suggestions.

If you haven't already, read Documentation/SubmittingPatches. Pay
particular attention to section #2 which explains how to write a good
commit message, and to section #4 to learn where to place patch
commentary not intended as part of the permanent commit history. The
above lines are commentary, not meant as part of the commit message.
Place such commentary below the '---' line just before the diffstat.

> Subject: Adding - shorthand for @{-1} in RESET command

Prefix the first line of the commit message with the module or command
you re changing. Drop capitalization. Write in imperative mood. For
instance:

    reset: add '-' shorthand for '@{-1}'

> Signed-off-by: Sundararajan R <dyoucme@gmail.com>
> Thanks-to: Junio C Hamano

Place your sign-off last. Use Helped-by: rather than Thanks-to: and
include the person's full name and email address.

> ---

Here, just below the '---' line is where you should place commentary
not intended for the permanent commit record.

> I have attempted to resolve the ambiguity when there exists a file named -
> by communicating to the user that he/she can use ./- when he/she wants to refer
> to the - file. I perform this check using the check_filename() function.

This is important information for the commit message itself above the
'---' line, though you would want to rephrase it just to state the
facts. No need to mention "I did this" or "I did that" since the patch
itself implies that you made the changes.

>  builtin/reset.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..2bdd5cd 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
>  {
>         const char *rev = "HEAD";
>         unsigned char unused[20];
> +       int file_named_minus=0;

Style: Here and elsewhere, add a space around '='.

>         /*
>          * Possible arguments are:
>          *
> @@ -205,6 +206,12 @@ static void parse_args(struct pathspec *pathspec,
>          */
>
>         if (argv[0]) {
> +               if (!strcmp(argv[0], "-") && !argv[1]) {
> +                       if(!check_filename(prefix,"-"))

Style: Here and elsewhere, add space after 'if'.
Style: Add space after comma.

> +                               argv[0]="@{-1}";
> +                       else
> +                               file_named_minus=1;
> +               }
>                 if (!strcmp(argv[0], "--")) {
>                         argv++; /* reset to HEAD, possibly with paths */
>                 } else if (argv[1] && !strcmp(argv[1], "--")) {
> @@ -226,7 +233,14 @@ static void parse_args(struct pathspec *pathspec,
>                         rev = *argv++;
>                 } else {
>                         /* Otherwise we treat this as a filename */
> -                       verify_filename(prefix, argv[0], 1);
> +                       if(file_named_minus) {
> +                               die(_("ambiguous argument '-': both revision and filename\n"
> +                                       "Use ./- for file named -\n"
> +                                       "Use '--' to separate paths from revisions, like this:\n"
> +                                       "'git <command> [<revision>...] -- [<file>...]'"));

This seems odd. If arguments following '--' are unconditionally
treated as paths, why is it be necessary to tell the user to spell out
file '-' as './-'? Shouldn't "git reset -- -" be sufficient?

> +                       }
> +                       else
> +                               verify_filename(prefix, argv[0], 1);
>                 }
>         }
>         *rev_ret = rev;
> --
> 2.1.0
