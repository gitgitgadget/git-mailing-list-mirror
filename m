Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D107C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 07:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4237F611AB
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 07:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGIHsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhGIHsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 03:48:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB1C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 00:46:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h3so9334329ilc.9
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FkHkCoMq1uZ00BfwteknuiC6jGHPnvnWJGJnPbBvkB8=;
        b=rLK3FxWfzBf/EcYkSbOHB+KQSOmLaqKTSjKlbsWNXKxXXSnVjbKnxJ9CepLF9C6nh3
         9U6c24R09wHr3K1YfXNzqSCaWxI8mseC+C76p06pi3SxCod+ZCMJ0lu86jfSlp2lBSQH
         FaRcer0T30w6i1UWDCiV3sL8N94X7oidcASU1FdBoyLpCKinkiaY6WwL5lRVnPBTqnii
         JTq4WmTbafmZJraPpqTQnjw3VfOtAVg5U/BX8MCqJohZVL3Oo8qLyUuK0EdPH0KxJBTq
         RW5su71jo1nWQt4NrlvsA8ZN9bTT+FpzpH4RWIw7siYtQwLDUd2N6WUoTSYieejq+0mJ
         +Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FkHkCoMq1uZ00BfwteknuiC6jGHPnvnWJGJnPbBvkB8=;
        b=b5PyBCdwry+/O8ksLW+L28uTQ4WbNC2++IyusnW07qCDuVtpwRXt5Lqgb4EZDGvdLO
         dcOGflXc6CjXxHKE5W/RWvYKcUfrxde/qQ/gPLslT/NwhpuGfV9Y/3xQ4Xx1o3il1ueS
         WIgvESlQOiQi/kEWNst+Fp9dEfyDSjueclko+bi5AKvspL4z11ln5WUXTU/BI2B9tsh6
         ZD/lTWIb8u0SkB+ZO10pArXXGA6V2qJOXLIWITEG04jF1A5Hk24VnY+zNz8ot7wK2WNF
         iOKoikDbPR7w4VTYi4O8hQo5dwHmv0UF1wsqy/nLIgPkz5Sdz1Thw3didBrtRYyT35gf
         kUIQ==
X-Gm-Message-State: AOAM532o49lmKT0CTj15qkijnRKyGjZCVgAcRkb0b0XLJiCRS5JJbjhY
        YCtPCr7sj9mT+8xoGJPDenM=
X-Google-Smtp-Source: ABdhPJwjzl70TsZv13ebXC69uezEROlBWyYY93egnGMRht1AsMZct89VHsf4wyLixdDOSieuYNt9Hg==
X-Received: by 2002:a05:6e02:1a69:: with SMTP id w9mr26438087ilv.120.1625816763483;
        Fri, 09 Jul 2021 00:46:03 -0700 (PDT)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id d13sm2399541ilv.34.2021.07.09.00.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 00:46:02 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Fri, 9 Jul 2021 03:45:56 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stephen Manz <smanz@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] worktree: teach add to accept --reason with --lock
Message-ID: <YOf+tANuox4LRD7d@flurp.local>
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
 <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 08, 2021 at 03:50:40PM +0000, Stephen Manz via GitGitGadget wrote:
> The default reason stored in the lock file, "added with --lock", is unlikely
> to be what the user would have given in a separate git worktree lock
> command. Allowing --reason to be specified along with --lock when adding a
> working tree gives the user control over the reason for locking without
> needing a second command.
>
> Changes since v1:
>
>  * Split changes into 3 commits. The first commit is removal of git
>    rev-parse in the test above the ones I'm adding. The second is wrapping
>    the "added with --lock" string with _() to mark it for translation. The
>    third commit is the main change.
>  * Reworked the if-else-if-else to if-else if-else
>  * Added test_when_finished ... command to unlock the working tree
>  * Changed test_expect_failure to test_expect_success and embedded
>    test_must_fail and test_path_is_missing commands

Thanks, all these changes make sense. Aside from a missing `_()` in
patch [2/3] mentioned in my review of that patch, everything looks
fine.

> Note: I don't see how to disambiguate --lock with no --reason from no --lock
> at all. I still think that the original keep_locked boolean is needed along
> with the new lock_reason char array. If I don't add lock_reason and change
> keep_locked to a char array, it will start as NULL. But it will remain NULL
> if --lock alone is given or if --lock isn't given at all.

The reason I suggested re-purposing `add_opts.keep_locked` is to avoid
polluting that structure with members having overlapping meaning, thus
reducing the confusion-factor for clients of that structure (assuming
that a tri-state `keep_locked` is indeed less confusing). That doesn't
preclude adding a new variable or two local to the `add()` function to
facilitate keeping `add_opts` pure. For instance, it might be as
simple as the below patch.

Anyhow, it's a minor suggestion and the sort of thing which can be
dealt with later if someone deems it important. Moreover, it's
subjective enough that it should not be a blocker for this patch
series if you don't do it that way. As mentioned above -- missing
`_()` aside -- the entire series looks reasonable as long as people
feel the UI choice is sound. (I, personally, still favor
`--lock[=<reason>]`, but I'm just one reviewer...)

--- >8 ---

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 976bf8ed06..22df2b60f2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -30,7 +30,7 @@ struct add_opts {
 	int detach;
 	int quiet;
 	int checkout;
-	int keep_locked;
+	const char *keep_locked;
 };
 
 static int show_only;
@@ -304,6 +304,8 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	if (!opts->keep_locked)
 		write_file(sb.buf, "initializing");
+	else if (*opts->keep_locked)
+		write_file(sb.buf, "%s", opts->keep_locked);
 	else
 		write_file(sb.buf, "added with --lock");
 
@@ -475,6 +477,8 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
+	int keep_locked = 0;
+	const char *lock_reason = NULL;
 	struct option options[] = {
 		OPT__FORCE(&opts.force,
 			   N_("checkout <branch> even if already checked out in other worktree"),
@@ -485,7 +489,9 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create or reset a branch")),
 		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
-		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
+		OPT_STRING(0, "reason", &lock_reason, N_("string"),
+			   N_("reason for locking")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
@@ -500,6 +506,10 @@ static int add(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
+	if (lock_reason && !keep_locked)
+		die(_("--reason requires --lock"));
+	if (keep_locked)
+		opts.keep_locked = lock_reason ? lock_reason : "";
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
-- 
2.32.0.372.g085311d9fa
