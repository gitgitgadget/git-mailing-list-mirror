From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Thu, 13 Mar 2014 22:16:41 -0400
Message-ID: <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
	<1394742059-7300-1-git-send-email-zhaox383@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Yao Zhao <zhaox383@umn.edu>
X-From: git-owner@vger.kernel.org Fri Mar 14 03:16:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOHfz-0003f5-OB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 03:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbaCNCQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 22:16:43 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:49102 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbaCNCQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 22:16:42 -0400
Received: by mail-yh0-f48.google.com with SMTP id z6so1947495yhz.21
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hY/4p2/3u4w577jQrAtRFkPVhxUAMkFnNYqCHPj+jDg=;
        b=XMB/VIXHN0HtYyKMib/N9Eu0C/LWRzJUeC8qn6TOvSU4Bmt2JEe4UctRGzGQ4BXPEX
         pKQ0kRB66cIRn1UWAXDx3j19bVA8JFp2ecNBuD6YBYPYTt+xorH9A0fs2xiDQadKuPiC
         aszc/Ya/tLPoL9ZPAAsEbTVFviPbEaYyCNrK/rvT+6WnRRv0lAT9Jgie1G4VPhgsHkUR
         yTrDAn+MANukigkEpCHnruDUjFk9HJW0bQ7C8OJooXgJqX+ebBnLmVN/70AdKfSO/A9h
         us5qYlEKnGi9RFX2eWbUBZ5Uwmpn+KM4+nXgXPiZEXcFLrzv7WiB2dDC9WLiIJKBYgiY
         G2dA==
X-Received: by 10.236.114.43 with SMTP id b31mr7253999yhh.30.1394763401893;
 Thu, 13 Mar 2014 19:16:41 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 13 Mar 2014 19:16:41 -0700 (PDT)
In-Reply-To: <1394742059-7300-1-git-send-email-zhaox383@umn.edu>
X-Google-Sender-Auth: oKC1GOV67nwOY0W2Q1GlscG0xf0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244069>

Thanks for the resubmission. Comments below.

On Thu, Mar 13, 2014 at 4:20 PM, Yao Zhao <zhaox383@umn.edu> wrote:
> Subject: [PATCH] GSoC Change multiple if-else statements to be table-driven

It's a good idea to let reviewers know that this is attempt 2. Do so
by saying [PATCH v2]. Your next one will be [PATCH v3]. The -v option
for "git format-email" can help.

When your patch is applied via "git am", text inside [...] gets
stripped automatically. The "GSoC" tells email readers what this
submission is about, but isn't relevant to the actual commit message.
It should be placed inside [...]. For instance: [PATCH/GSoC v2].

> Signed-off-by: Yao Zhao <zhaox383@umn.edu>
> ---
> GSoC_MicroProject_#8
>
> Hello Eric,
>
> Thanks for reviewing my code. I implemented table-driven method this time and correct the style
> problems indicated in review.

Explaining what you changed since the last version is indeed good
etiquette. Thanks. For bonus points, also provide a link to the
previous version, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243919

>  branch.c | 72 ++++++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 22 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..6451c99 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,10 +49,43 @@ static int should_setup_rebase(const char *origin)
>
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> +

Unnecessary insertion of blank line.

>         const char *shortname = remote + 11;
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> +       int size=8, i;

Style: whitespace: size = 8

You can use ARRAY_SIZE(print_list) to avoid hardcoding 8 (and then you
don't need the variable 'size').

> +       typedef struct PRINT_LIST {
> +               const char *print_str;
> +               const char *arg2;
> +               //arg1 is always local, so I only add arg2 and arg3 in struct

This commentary should be placed below the "---" under your sign-off
(or dropped altogether since it's pretty obvious).

Also, in this project avoid //-style comments.

> +               const char *arg3;
> +               int b_rebasing;
> +         int b_remote_is_branch;

Strange indentation. Use tabs for indentation, and set your editor so
tabs have width 8.

> +               int b_origin;
> +       } PRINT_LIST;

Read below for some commentary about b_rebasing, b_remote_is_branch, b_origin.

> +       PRINT_LIST print_list[] = {
> +               {.print_str = _("Branch %s set up to track remote branch %s from %s by rebasing."),
> +                               .arg2 = shortname, .arg3 = origin,
> +                                        .b_rebasing = 1, .b_remote_is_branch = 1, .b_origin = 1},
> +         {.print_str = _("Branch %s set up to track remote branch %s from %s."),
> +                               .arg2 = shortname, .arg3 = origin,
> +                                        .b_rebasing = 0, .b_remote_is_branch = 1, .b_origin = 1},
> +    {.print_str = _("Branch %s set up to track local branch %s by rebasing."),
> +                               .arg2 = shortname, .b_rebasing = 1, .b_remote_is_branch = 1, .b_origin = 0},
> +               {.print_str = _("Branch %s set up to track local branch %s."),
> +                               .arg2 = shortname, .b_rebasing = 0, .b_remote_is_branch = 1, .b_origin = 0},
> +               {.print_str = _("Branch %s set up to track remote ref %s by rebasing."),
> +                               .arg2 = remote, .b_rebasing = 1, .b_remote_is_branch = 0, .b_origin = 1},
> +               {.print_str = _("Branch %s set up to track remote ref %s."),
> +                               .arg2 = remote, .b_rebasing = 0, .b_remote_is_branch = 0, .b_origin = 1},
> +               {.print_str = _("Branch %s set up to track local ref %s by rebasing."),
> +                               .arg2 = remote, .b_rebasing = 1, .b_remote_is_branch = 0, .b_origin = 0},
> +               {.print_str = _("Branch %s set up to track local ref %s."),
> +                               .arg2 = remote, .b_rebasing = 0, .b_remote_is_branch = 0, .b_origin = 0},
> +};
> I am confused here: I use struct initializer and I am not sure if it's ok
> because it is only supported by ANSI

This commentary should be placed below "---" after your sign-off.

Indeed, you want to avoid named field initializers in this project and
instead use positional initializers.

Translatable strings in an initializer should be wrapped with N_()
instead of _(). You will still need to use _() later on when you
reference the string from the table. See section 4.7 [2] of the GNU
gettext manual for details.

[2]: http://www.gnu.org/software/gettext/manual/gettext.html#Special-cases

>         if (remote_is_branch
>             && !strcmp(local, shortname)
> @@ -75,31 +108,26 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>                 git_config_set(key.buf, "true");
>         }
>         strbuf_release(&key);
> -
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> +               for (i=0;i<size;i++)

Style: whitespace: for (i = 0; i < size; i++)

> +               {
> +                       if (print_list[i].b_rebasing == (rebasing? 1 : 0) &&
> +                                                               print_list[i].b_remote_is_branch == (remote_is_branch? 1 : 0) &&
> +                                                               print_list[i].b_origin == (origin? 1 : 0))

Style: whitespace: (x ? 1 : 0)

Assigning &print_list[i] to a variable would allow you to reduce the
noise of this expression a bit.

On this project it is more idiomatic to say !!rebasing,
!!remote_is_branch, !!origin to constrain these values to 0 or 1.

An alternate approach might be to use a multi-dimensional array, where
the boolean values of rebasing, remote_is_branch, and origin are keys
into the array. This would allow you to pick out the correct
PRINT_LIST entry directly (no looping), thus eliminating the need for
those b_rebasing, b_remote_is_branch, and b_origin members.

> +                       {
> +                               if (print_list[i].arg3 == NULL)
> +                                       printf_ln (print_list[i].print_str, local, print_list[i].arg2);

Style: whitespace: printf_ln(...)

Reminder: wrap _() around print_list[i].print_str

> +                               else
> +                                       printf_ln (print_list[i].print_str, local,
> +                                                       print_list[i].arg2, print_list[i].arg3);

This logic can be simplified. Hint: It is not an error to pass more
arguments than there are %s's in the format string.

> +
> +                               break;
> +                       }
> +               }
> +               if (i == size)
>                         die("BUG: impossible combination of %d and %p",
>                             remote_is_branch, origin);
> +

Unnecessary insertion of blank line.

>         }
>  }
>
> --
> 1.8.3.2
