From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 02:52:09 -0400
Message-ID: <CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:52:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axqfT-00037p-4f
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337AbcEDGwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:52:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36608 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbcEDGwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:52:10 -0400
Received: by mail-io0-f194.google.com with SMTP id k129so4963098iof.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hgOuQG9TZdmbrtJvpNu9PWW3RepYhgLC/YPRGnRVRB8=;
        b=xnt3cZAbnatII618HfY1vTE0O4Ayp9xCxe3U4EzKqKFjMT2Hio0rBcxVRlq79MRvBN
         3NZrIOpCrWdwj8j5O3u+ZPm1sEsiITonWMPIgYiyRtw//gDn6/PGWBVHh8j4sicFmWn7
         GAjX8+bboFId7tt/kumzHAIoekYY/LoQnJZFQIZl7URZYHkl55vy3MKhb98aPa21uddI
         96T8dKdQb303NoWHjbV5MoEBoLK2rIcySEVZRrw8ymL4tDKIDZmJ+WdzjSLx0j9GrWKF
         ezt4HpQAWBuOL+S1ZCdwRurpCLAfPjuSWwNlzdLZnhSS1Alq/q0kQnboMAVL4uCZIWnj
         gIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hgOuQG9TZdmbrtJvpNu9PWW3RepYhgLC/YPRGnRVRB8=;
        b=F+WpicIwNEBpTo0nfdP1afO7L8zAFfL4+UxbeQSjs0Ao+/5H08FNzvDZDcTD1siLuz
         BLe8Yzd6yDSHvBvSHQRFuJVidD4VXaz46Z7gKYKENgD0icfXWDrI5JG5WnJvXlFFGKq6
         l7wNqjLNEIhE1hZ4gMp/oYjQRG0ZO0VUI8Tlak4fgLzVq2x7kcchzEEKLLIFCvl9GdJk
         e4d9S5D6ZUvtrRZLxnWd3Umn49Qf0W48xgR82CrZqNx4OpDyzAVzyWWcfAG72xAkGi7o
         A7YpS3lDmXpjuzGeuRsBmYjMlCS0b4l2+RnMLB0Wv/nWNSLT+7n9bOrmGxgzQ2PLVH0n
         cOrQ==
X-Gm-Message-State: AOPr4FXawDPaPOfFNkv8OHoUXXXvJkfp1YFFk9F5iCsVv+CMXlyMm1F7cQkNZzubP/342nj8FDjovGUtOrobvQ==
X-Received: by 10.107.25.13 with SMTP id 13mr7703396ioz.104.1462344729103;
 Tue, 03 May 2016 23:52:09 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 23:52:09 -0700 (PDT)
In-Reply-To: <1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: Mf48xm50sttgjgtyovk1o_pnUOo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293501>

On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> This reimplements the `check_term_format` shell function in C and adds

s/This reimplements/Reimplement/
s/adds/add/

> a `--check-term-format` subcommand to `git bisect--helper` to call it
> from git-bisect.sh

s/$/./

Okay, I'll bite: Why is this a good idea? What does it buy you?

It's not as if the rewrite is especially faster or more easily
expressed in C; quite the contrary, the shell code is more concise and
probably about equally as fast (not that execution speed matters in
this case).

I could understand this functionality being ported to C in the form of
a static function as a minor part of porting "git bisect terms" in its
entirety to C, but I'm not imaginative enough to see why this
functionality is useful as a standalone git-bisect--helper subcommand,
and the commit message doesn't enlighten. Consequently, it seems like
unnecessary complexity.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -2,16 +2,66 @@
>  static const char * const git_bisect_helper_usage[] = {
>         N_("git bisect--helper --next-all [--no-checkout]"),
> +       N_("git bisect--helper --check-term-format <term> <orig_term>"),

Could this be shortened to --check-term or would that be undesirable?

>         NULL
>  };
>
>  enum sub_commands {
> -       NEXT_ALL = 1
> +       NEXT_ALL = 1,
> +       CHECK_TERM_FMT
>  };
>
> +/*
> + * To check whether the string `term` belongs to the set of strings
> + * included in the variable arguments so as to make the code look
> + * clean and avoid having long lines in the `if` statement.
> + */

Is this a (long) sentence fragment? Code cleanliness is an obviously
desirable trait, thus talking about it in the comment adds no value;
it's just noise.

> +static int one_of(const char *term, ...)
> +{
> +       va_list matches;
> +       const char *match;
> +
> +       va_start(matches, term);
> +       while ((match = va_arg(matches, const char *)) != NULL)
> +               if (!strcmp(term, match))
> +                       return 1;

Is it wise to return here without invoking va_end()?

> +       va_end(matches);
> +
> +       return 0;
> +}
> +
> +static int check_term_format(const char *term, const char *orig_term,
> +                            int flag)

What is 'flag' for? The single caller only ever passes 0, so why is this needed?

> +{
> +       struct strbuf new_term = STRBUF_INIT;

'new_term' is being leaked at every 'return' statement in this function.

> +       strbuf_addf(&new_term, "refs/bisect/%s", term);
> +
> +       if (check_refname_format(new_term.buf, flag))
> +               die(_("'%s' is not a valid term\n"), term);

Why does this die() while the other "invalid" cases merely return
error()? What makes this special?

Also, drop "\n" from the error string.

> +       else if (one_of(term, "help", "start", "skip", "next", "reset",

s/else //

> +                       "visualize", "replay", "log", "run", NULL))
> +               return error("can't use the builtin command '%s' as a term\n", term);

This should be wrapped in _(...). Also, drop the "\n".

> +       /*
> +        * In theory, nothing prevents swapping
> +        * completely good and bad, but this situation
> +        * could be confusing and hasn't been tested
> +        * enough. Forbid it for now.
> +        */

This would be a bit easier to read if re-wrapped to fit within 80
columns rather than 53 or so.

> +       else if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||

s/else //

> +                (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))

This can be more efficient by doing the strcmp() before the expensive one_of():

    if ((strcmp(...) && one_of(...)) ||
        strcmp(...) && one_of(...)))

> +               return error("can't change the meaning of the term '%s'\n", term);

This should be wrapped in _(...). Also, drop the "\n".

> +       return 0;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>         int sub_command = 0;
> @@ -19,6 +69,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         struct option options[] = {
>                 OPT_CMDMODE(0, "next-all", &sub_command,
>                          N_("perform 'git bisect next'"), NEXT_ALL),
> +               OPT_CMDMODE(0, "check-term-format", &sub_command,
> +                        N_("check format of the ref"), CHECK_TERM_FMT),

What "ref"?

>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>                 OPT_END()
> @@ -33,6 +85,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         switch (sub_command) {
>         case NEXT_ALL:
>                 return bisect_next_all(prefix, no_checkout);
> +       case CHECK_TERM_FMT:
> +               if (argc != 2)
> +                       die(_("--check-term-format should be followed by exactly 2 arguments."));

Drop the period. Possible reword:

    --check-term-format requires two arguments

> +               return check_term_format(argv[0], argv[1], 0);
>         default:
>                 die(_("bug: unknown subcommand '%d'"), sub_command);
>         }
