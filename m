Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08DC433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 16:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiACQ4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 11:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACQ4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 11:56:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9AEC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 08:55:59 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u25so16871445edf.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 08:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EV5FpxX0ywnRR41MPF8VHjR7KjXLhP1JQhZPgihHlNQ=;
        b=YOAztOf+nVQTBRaqVDRU57B2EC/g3mhmsuKVu+wrsPb9hsRdQsAvXQ6VfgrzmIr1oc
         4Yd/htSyH5p5aKoMjpMOMMundKqq4/jy3x9h6lyQRX6d2FVg50URWldXCcICbbPa2Ix6
         jbkAs1lwwZ9TeB09pv5bGem9xj5JKeJpOfdSOy+JSpOq03GZW+AA+6iHDhx0/t9zOlbw
         qgdceUYF1nFH1xFHr3cRMx7REIvoaky43jJpjI6cPSGEsKuQfYL7QS2uiKpnGZuFv9XU
         vISw8q57aQcPKyYvi0OmU3a4SMdO28JVVX9t8+deMp+iH/k68ShlzCT+Glh2K1cxbQSl
         DW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV5FpxX0ywnRR41MPF8VHjR7KjXLhP1JQhZPgihHlNQ=;
        b=OyHZU5ycpz60dFNjfIJe9h7VdktXz6/nb+2q7mof1ClHnSJJWmeJWwaJviCGK4vRVh
         S5enmXcwxU81YY0CwyDskBb/nTE7THKywERd+rV8AvQ8UmpcjMrV/FGLXb++sFh1K3Fn
         d1Z9a95lUX09rhedZleejmCen9gwnh8Bx3RlV5S0B6qFXaXL0tIMBotBvPh8tSJUlROQ
         9rINlo5b03BwqPDFkZAEMhHyzVGi4lTnFlL9V8lPfnYPD3i8kSm6BHZX73Gg+xB+/yCX
         4yEGrORUNsmiSrPC8w37K7fL11wgImk5xIfz/RVPB+h5KbPqkzFF28T7B3ePR09OMZrA
         /E8w==
X-Gm-Message-State: AOAM531OSytHNcnI87AO9IEReRYsyPQOoKqNsIbnCYW5H5sAXzgOV8lf
        xUMcmZpYB4NX5yRNT1NqPojOFzELjFELzRSR/Es=
X-Google-Smtp-Source: ABdhPJxEVMIcvUBKgLx/0vQb87AME6hMPTsWMKFu2fgF7K6QeDTaxcMsXqok3OI0rh7rl7/F0+n9LCtX08cHATc1vFM=
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr46093812edc.359.1641228957863;
 Mon, 03 Jan 2022 08:55:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
 <20220103123539.kldjq3hrcagqjzwc@fs>
In-Reply-To: <20220103123539.kldjq3hrcagqjzwc@fs>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Jan 2022 08:55:46 -0800
Message-ID: <CABPp-BHGRaJX=fqfQ5vHDGzVJiNHpuU4dZY9h3AN=iPPc90pAA@mail.gmail.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 4:35 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
> >From: Elijah Newren <newren@gmail.com>
> >
> >When running `git merge-tree --real`, we previously would only return an
> >exit status reflecting the cleanness of a merge, and print out the
> >toplevel tree of the resulting merge.  Merges also have informational
> >messages, ("Auto-merging <PATH>", "CONFLICT (content): ...", "CONFLICT
> >(file/directory)", etc.)  In fact, when non-content conflicts occur
> >(such as file/directory, modify/delete, add/add with differing modes,
> >rename/rename (1to2), etc.), these informational messages are often the
> >only notification since these conflicts are not representable in the
> >contents of the file.
> >
> >Add a --messages option which names a file so that callers can request
> >these messages be recorded somewhere.
> >
> >Signed-off-by: Elijah Newren <newren@gmail.com>
> >---
> > Documentation/git-merge-tree.txt |  6 ++++--
> > builtin/merge-tree.c             | 18 ++++++++++++++++--
> > t/t4301-merge-tree-real.sh       | 18 ++++++++++++++++++
> > 3 files changed, 38 insertions(+), 4 deletions(-)
> >
> >diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> >index 5823938937f..4d5857b390b 100644
> >--- a/Documentation/git-merge-tree.txt
> >+++ b/Documentation/git-merge-tree.txt
> >@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
> > SYNOPSIS
> > --------
> > [verse]
> >-'git merge-tree' --real <branch1> <branch2>
> >+'git merge-tree' --real [--messages=<file>] <branch1> <branch2>
> > 'git merge-tree' <base-tree> <branch1> <branch2>
> >
> > DESCRIPTION
> >@@ -21,7 +21,9 @@ The first form will merge the two branches, doing a full recursive
> > merge with rename detection.  If the merge is clean, the exit status
> > will be `0`, and if the merge has conflicts, the exit status will be
> > `1`.  The output will consist solely of the resulting toplevel tree
> >-(which may have files including conflict markers).
> >+(which may have files including conflict markers).  With `--messages`,
> >+it will write any informational messages (such as "Auto-merging
> >+<path>" and conflict notices) to the given file.
> >
> > The second form is meant for backward compatibility and will only do a
> > trival merge.  It reads three tree-ish, and outputs trivial merge
> >diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> >index c5757bed5bb..47deef0b199 100644
> >--- a/builtin/merge-tree.c
> >+++ b/builtin/merge-tree.c
> >@@ -389,6 +389,7 @@ static int trivial_merge(const char *base,
> >
> > struct merge_tree_options {
> >       int real;
> >+      char *messages_file;
> > };
> >
> > static int real_merge(struct merge_tree_options *o,
> >@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
> >        */
> >
> >       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> >+
> >+      if (o->messages_file) {
> >+              FILE *fp = xfopen(o->messages_file, "w");
> >+              merge_display_update_messages(&opt, &result, fp);
> >+              fclose(fp);
> >+      }
>
> Something else I just wondered. Can the user differentiate between the die()
> in xfopen() and a failed/unclean merge?
> Both just exit(1) don't they?

xfopen() calls die_errno(), which calls die_routine(), which will be
pointing at die_builtin() since we don't change it in
builtin/merge-tree.c, and die_builtin() calls exit(128).

So, a different error code.

But good question...perhaps I should mention exit codes other than 0
and 1 in the documentation of merge-tree for other failures.

>
> >       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> >-      merge_switch_to_result(&opt, NULL, &result, 0, 0);
> >+
> >+      merge_finalize(&opt, &result);
> >       return result.clean ? 0 : 1;
> > }
> >
> >@@ -451,15 +459,18 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> > {
> >       struct merge_tree_options o = { 0 };
> >       int expected_remaining_argc;
> >+      int original_argc;
> >
> >       const char * const merge_tree_usage[] = {
> >-              N_("git merge-tree --real <branch1> <branch2>"),
> >+              N_("git merge-tree --real [<options>] <branch1> <branch2>"),
> >               N_("git merge-tree <base-tree> <branch1> <branch2>"),
> >               NULL
> >       };
> >       struct option mt_options[] = {
> >               OPT_BOOL(0, "real", &o.real,
> >                        N_("do a real merge instead of a trivial merge")),
> >+              OPT_STRING(0, "messages", &o.messages_file, N_("file"),
> >+                         N_("filename to write informational/conflict messages to")),
> >               OPT_END()
> >       };
> >
> >@@ -468,8 +479,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> >               usage_with_options(merge_tree_usage, mt_options);
> >
> >       /* Parse arguments */
> >+      original_argc = argc;
> >       argc = parse_options(argc, argv, prefix, mt_options,
> >                            merge_tree_usage, 0);
> >+      if (!o.real && original_argc < argc)
> >+              die(_("--real must be specified if any other options are"));
> >       expected_remaining_argc = (o.real ? 2 : 3);
> >       if (argc != expected_remaining_argc)
> >               usage_with_options(merge_tree_usage, mt_options);
> >diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> >index 9fb617ccc7f..42218cdc019 100755
> >--- a/t/t4301-merge-tree-real.sh
> >+++ b/t/t4301-merge-tree-real.sh
> >@@ -78,4 +78,22 @@ test_expect_success 'Barf on too many arguments' '
> >       grep "^usage: git merge-tree" expect
> > '
> >
> >+test_expect_success '--messages gives us the conflict notices and such' '
> >+      test_must_fail git merge-tree --real --messages=MSG_FILE side1 side2 &&
> >+
> >+      # Expected results:
> >+      #   "greeting" should merge with conflicts
> >+      #   "numbers" should merge cleanly
> >+      #   "whatever" has *both* a modify/delete and a file/directory conflict
> >+      cat <<-EOF >expect &&
> >+      Auto-merging greeting
> >+      CONFLICT (content): Merge conflict in greeting
> >+      Auto-merging numbers
> >+      CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
> >+      CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
> >+      EOF
> >+
> >+      test_cmp expect MSG_FILE
> >+'
> >+
> > test_done
> >--
> >gitgitgadget
> >
