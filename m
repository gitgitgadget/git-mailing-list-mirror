Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185631F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfHTVNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:13:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34990 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:13:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so38361wmg.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 14:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/04w5byfDC29uhVPL813g6zCmKh+1TkvFk9pU8RC48=;
        b=Jhka3G0ei0jBINvuM9GBs8GbiGNVdyffWBQvyjxCjJWz6EpEzFFF4CKQsQIXR91/K+
         v9Ck9NyailSncCO8IGxEXgO/fueyO4hH1rcmiN+xNVfGJUnNyIbymFEVsrRbKkwfX/td
         eGkQPfTtcfM+yRYANRP6Uvk3Wetbxn2Vk1XzUFIWyYo4YFFrKYIxrFnEtPqX8wSdi0Pm
         39DUxQz2i499YNeUcH1nRnGz5MhESBEEZd8Gyn2xLlCaj7vDZRqWvHbrWVcl14qQMiL/
         aBERnRF1KB9VrG+F5PksvQ6nRBmW/NZV+1RWgO4vdMeLH9zHyJlF6RmAU0MwF5GDk9sd
         tOaA==
X-Gm-Message-State: APjAAAUHtzksBL/atN4VhEFVt5lP8byA8OPndG3QRcXbQLBM5oPhXQdo
        Z9kyO/g4lZHpK9b4mXHnAE+1ppa/b7KPNOwVNAo=
X-Google-Smtp-Source: APXvYqwBjO4GwkRY1PwtSVlREe38HCPsJ2u+N0LCz2d1HgM9xgtQQ9q3evyv4mL/KeloYAN5yEp10B8rVI0pwads7wc=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr2022565wmg.120.1566335598010;
 Tue, 20 Aug 2019 14:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.315.git.gitgitgadget@gmail.com> <da89f7dadb0be2d4ada22dd3e2d1f5524c73f70d.1566326275.git.gitgitgadget@gmail.com>
In-Reply-To: <da89f7dadb0be2d4ada22dd3e2d1f5524c73f70d.1566326275.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Aug 2019 17:13:06 -0400
Message-ID: <CAPig+cSR-ab_8AeZ9fJX2G8h6x_V_NUG01pXWQAgF+_pgmR2fQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] commit-graph: add --[no-]progress to write and verify.
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 2:38 PM Garima Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add --[no-]progress to git commit-graph write and verify.
> The progress feature was introduced in 7b0f229
> ("commit-graph write: add progress output", 2018-09-17) but
> the ability to opt-out was overlooked.
>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  'git commit-graph read' [--object-dir <dir>]
> -'git commit-graph verify' [--object-dir <dir>] [--shallow]
> +'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
>  'git commit-graph write' <options> [--object-dir <dir>]

This synopsis shows only 'verify' accepting --[no-]progress, however,
the "usage" message in commit-graph.c itself shows 'verify' and
'write' accepting the option.

> @@ -29,6 +29,8 @@ OPTIONS
> +--[no-]progress::
> +       Toggle whether to show progress or not.

This is misleading. The --progress option does not _toggle_ the
setting. The positive form explicitly enables it, and the negated form
explicitly disables it. Try to take inspiration for the wording of
this description by consulting other existing documentation. For
instance, from Documentation/merge-options.txt:

    Turn progress on/off explicitly. If neither is specified,
    progress is shown if standard error is connected to a terminal.

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> @@ -6,17 +6,18 @@
>  static char const * const builtin_commit_graph_usage[] = {
> -       N_("git commit-graph verify [--object-dir <objdir>] [--shallow]"),
> -       N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
> +       N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> +       N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),

This disagrees with the synopsis in the documentation, as mentioned above.

>  static int graph_verify(int argc, const char **argv)
> @@ -48,16 +50,20 @@ static int graph_verify(int argc, const char **argv)
>         int fd;
>         struct stat st;
>         int flags = 0;
> -
> +       int defaultProgressState = isatty(2);
> +

You have stray whitespace at the end of the "blank" line following the
new variable declaration, hence the odd-looking diff.

> @@ -154,8 +162,9 @@ static int graph_write(int argc, const char **argv)
> -       unsigned int flags = COMMIT_GRAPH_PROGRESS;
> -
> +       unsigned int flags = 0;
> +       int defaultProgressState = isatty(2);
> +

Ditto.

> diff --git a/commit-graph.c b/commit-graph.c
> @@ -1986,14 +1986,17 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>         if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>                 return verify_commit_graph_error;
>
> -       progress = start_progress(_("Verifying commits in commit graph"),
> -                                 g->num_commits);
> +       if (flags & COMMIT_GRAPH_PROGRESS)
> +               progress = start_progress(_("Verifying commits in commit graph"),
> +                                       g->num_commits);

The progress reporting functions can safely handle a NULL pointer for
'progress'. In the original code 'progress' was assigned explicitly,
thus could not be NULL, However, in the revised code, it's not clear
from this snippet what the value of 'progress' is if
COMMIT_GRAPH_PROGRESS is not in 'flags'. If 'progress' is
uninitialized, then the behavior would be undefined. Looking at the
variable declaration, I see that it is indeed initialized to NULL, so
this code is safe. Okay.

>         for (i = 0; i < g->num_commits; i++) {
>                 struct commit *graph_commit, *odb_commit;
>                 struct commit_list *graph_parents, *odb_parents;
>                 uint32_t max_generation = 0;
>
>                 display_progress(progress, i + 1);
> +
>                 hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);

No need to make changes (such as inserting an unnecessary blank line)
unrelated to the stated purposed of the patch.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> @@ -116,6 +116,42 @@ test_expect_success 'Add more commits' '
> +test_expect_success 'commit-graph write progress off by default for stderr' '
> +       cd "$TRASH_DIRECTORY/full" &&
> +       git commit-graph write 2>err &&
> +       test_line_count = 0 err
> +'

Changing the working directory ('cd') outside of a subshell is heavily
discouraged in this test suite, however, since this particular script
is riddled with the 'cd "$TRASH_DIRECTORY/full"' idiom, this can
probably pass, however, it's not good to get into the habit of doing
it this way.
