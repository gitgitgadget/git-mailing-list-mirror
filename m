Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164BC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C6364F2B
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBYR6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 12:58:18 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:46642 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhBYR5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 12:57:41 -0500
Received: by mail-ej1-f50.google.com with SMTP id r17so10295553ejy.13
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 09:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRstrEK86XjIgGFJvT0VTFNesMxugNe2REdGn2Q/kpI=;
        b=l48odXjVCtgS3eC0GQ1LrzyLeRantN0COBsnb0/e9vkTxLYnCJSBmQaqIXAQlCXY+Y
         idzLJ8ezHkjU3X+QaaG1LMN1z5Jvcqxfc5EzHERcWOREikrvnnGVyV352HrxHNqtrjH7
         auIQqkWB0gF7JffcE+wwwAL4pgpZFfdRRXTdXq+cAmamrP8rFngMJlcCDwWsO34fBUif
         tI713M9NMD7f0V6stvbP5ewZVkal0VfBY/RDbGVDYlmLnajT1L2ymGvB0/GHmhT+qwj6
         nMyEX3zPLu79HXZRBz/iyxkaa9pNFYxEuUskdAEjNX7RoyJq1z8lY3S2BWBmowH4gWYn
         M4EQ==
X-Gm-Message-State: AOAM5316tddfTR1K5oH/Ikvf37YiTABDz8yMg7QEv4u62SAv6py+ha+f
        OAbzsie6mRL6I3qeiUiH1WJ9T6JkdoCYgQbKfoDTAfhHW9g=
X-Google-Smtp-Source: ABdhPJzz+B1QhxWXjtkavoQRBgK+lIOvaE0boLtWIYQghAFqBdGreovlXGlueJEq0GVnLJlZEExYbbI+bc/wxwRjQwM=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr3828217ejx.168.1614275819454;
 Thu, 25 Feb 2021 09:56:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Feb 2021 12:56:48 -0500
Message-ID: <CAPig+cQcyJJnuOq9wtJjgEi7OgO39wBf+hHkVxaQ4z-RehvgNA@mail.gmail.com>
Subject: Re: [PATCH] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 11:19 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Usually we can only use `format-patch -v<n>` to generate integral
> version numbers patches, but if we can provide `format-patch` with
> non-integer versions numbers of patches, this may help us to send patches
> such as "v1.1" versions sometimes.

On the Git project itself, fractional or non-numeric re-roll "numbers"
are not necessarily encouraged[1], so this feature may not be
particularly useful here, though perhaps some other project might
benefit from it(?). Usually, you would want to justify why the change
is desirable. Denton did give a bit of justification in his
proposal[2] for this feature, so perhaps update this commit message by
copying some of what he wrote as justification.

[1]: I think I've only seen Denton send fractional re-rolls; other
people sometimes send a periodic "fixup!" patch, but both approaches
place extra burden on the project maintainer than merely re-rolling
the entire series with a new integer re-roll count.

[2]: https://github.com/gitgitgadget/git/issues/882

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> @@ -215,12 +215,12 @@ populated with placeholder text.
>  -v <n>::
>  --reroll-count=<n>::
> -       Mark the series as the <n>-th iteration of the topic. The
> +       Mark the series as the specified version of the topic. The
>         output filenames have `v<n>` prepended to them, and the
>         subject prefix ("PATCH" by default, but configurable via the
>         `--subject-prefix` option) has ` v<n>` appended to it.  E.g.
> -       `--reroll-count=4` may produce `v4-0001-add-makefile.patch`
> -       file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> +       `--reroll-count 4.4` may produce `v4.4-0001-add-makefile.patch`
> +       file that has "Subject: [PATCH v4.4 1/20] Add makefile" in it.

I'm not sure we want to encourage the use of fractional re-roll counts
by using it in an example like this. It would probably be better to
leave the example as-is. If you really want people to know that
fractional re-roll counts are supported, perhaps add separate sentence
saying that they are.

> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1662,13 +1662,13 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
> -static const char *diff_title(struct strbuf *sb, int reroll_count,
> +static const char *diff_title(struct strbuf *sb, const char *reroll_count,
>                        const char *generic, const char *rerolled)
>  {
> -       if (reroll_count <= 0)
> +       if (!reroll_count)
>                 strbuf_addstr(sb, generic);
>         else /* RFC may be v0, so allow -v1 to diff against v0 */
> -               strbuf_addf(sb, rerolled, reroll_count - 1);
> +               strbuf_addf(sb, rerolled, "last version");
>         return sb->buf;
>  }

There are a couple problems here (at least). First, the string "last
version" should be localizable, `_("last version")`. Second, in
Denton's proposal[2], he suggested using the string "last version"
_only_ if the re-roll count is not an integer. What you have here
applies "last version" unconditionally when -v is used so that the
outcome is _always_ "Range-diff since last version". If that's what
you intend to do, there's no reason to do any sort of interpolation
using the template "Range-diff since %". What Denton had in mind was
this (using pseudo-code):

    if re-roll count not specified:
        message = "Range-diff"
    else if re-roll count is integer:
        message = "Range-diff since v%d", re-roll
    else:
        message = "Range-diff since v%s", re-roll

However, there isn't a good reason to favor "Range-diff since last
version" over the simpler generic message "Range-diff". So, the above
should be collapsed to:

    if re-roll count is specified and integer:
        message = "Range-diff since v%d", re-roll
    else:
        message = "Range-diff"

> @@ -2080,7 +2080,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> -                                            _("Interdiff against v%d:"));
> +                                            _("Interdiff against %s:"));
> @@ -2099,7 +2099,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> -                                            _("Range-diff against v%d:"));
> +                                            _("Range-diff against %s:"));

If you follow my recommendation above using the simplified
conditional, then you don't need to drop the "v" since you won't be
saying "last version".
