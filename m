Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8157EC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC5922BEB
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igRixIyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHCR5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCR5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:57:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A986C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 10:57:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so6150315ljk.6
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhO1rhzunSAIM7Nd9k5QeMf9oDL8zvXfQ22y/dibB7w=;
        b=igRixIyiUx+EVte1LRpFResvOkd8nQ9+elIQYsjBbzaFYz/7+2cpKHHEcGbIhURFFa
         V/z+s77/7AEw5co0hN6iz9dFNdyAfi1WcmDtldLwcczH8O/uOD5ldD3/wzeJds0tkUX7
         2fgZgr8V/9YX+gawIFf0+mObo2cRKuwhkUY8uKMwoxkP6dsXhXZzZ+LnX3eBHqAmeQ3O
         a8FRJfwscD+/V+AlrT9/PgAhKysPBUEeh4S0/bxWdIsT2olbH47Y6+NuY/3KToQwkzjv
         DC9k4NggiZYAW+5GMNDb5VNDr/ag20ir8zMSEYHPr32m0vGq2PhmyHeokjNcKzpMMcBB
         yshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhO1rhzunSAIM7Nd9k5QeMf9oDL8zvXfQ22y/dibB7w=;
        b=FGtTjON9NaQd0dpUNtSbswSJrg29ZNHYVDGZGHAsLCcoHSAhjVWUE2guVXdR8StoG2
         JcDUNToYfHSRJb7k8IEgk1gzsiOcW/ik4kAfKvFU8iyuCMZxvVeZe0/uVum48EXJC4Hb
         huiNirE/2oglj/vlTcRJSZIwgDBJ2B0noZex/UPozlYPrnfGfgVH4ehZtRoUjGDYCAiw
         1wWc5IEOSCOesIj7OdTxF217Ws46bw9WDqxMVMuHmD1xzrQSfXEXeCHfyVnGLtsfZhBn
         +ZAhOR8SG3Xhw2exb4+IkP3qCKdo4f4b+CtNS76osMkH9+xGsv0u3DBFE+em/HFhHhds
         mRhg==
X-Gm-Message-State: AOAM530Jyqq4EBZPIL6MOsvMtB4VKsAT3dvEdAAHRs1GbNflzO8gxPvV
        UqCqGkpfXOAwkgymzUqMeCzoRH7T
X-Google-Smtp-Source: ABdhPJyo5+oR4rSw47ds+w0M/XgFNfFh8gOMj+iifqeFcrebE48pfANRoqAgw40VJ59TrjgyJgPQ5Q==
X-Received: by 2002:a2e:b306:: with SMTP id o6mr7536048lja.361.1596477456822;
        Mon, 03 Aug 2020 10:57:36 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id q3sm4466281ljm.22.2020.08.03.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:57:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] git-worktree documentation cleanups
Date:   Mon,  3 Aug 2020 19:57:17 +0200
Message-Id: <20200803175717.7465-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803053612.50095-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Aug 2020 at 07:39, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This series fixes some problems I ran across in the git-worktree
> documentation while working on another worktree-related topic. Since
> these fixes are distinct from that topic, I'm submitting them
> separately.

All of these look correct to me. Thanks for polishing the docs. Extra
thanks for injecting a "$" where we talk about the actual value of an
environment variable.

I offer the following suggestions on top. If you agree with them, or
some of them, you might want to squash them into the various patches.
But it's not like these are critical, I don't think they need to block
this.

Martin

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 260bfe9105..2000a08075 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -25,8 +25,8 @@ Manage multiple working trees attached to the same repository.
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
 tree is associated with the repository.  This new working tree is called a
-"linked working tree" as opposed to the "main working tree" prepared by "git
-init" or "git clone".  A repository has one main working tree (if it's not a
+"linked working tree" as opposed to the "main working tree" prepared by linkgit:git-init[1]
+or linkgit:git-clone[1].  A repository has one main working tree (if it's not a
 bare repository) and zero or more linked working trees. When you are done
 with a linked working tree, remove it with `git worktree remove`.
 
@@ -48,7 +48,7 @@ add <path> [<commit-ish>]::
 
 Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
-directory specific files such as HEAD, index, etc. As a convenience,
+directory specific files such as `HEAD`, `index`, etc. As a convenience,
 `<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
 +
 If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
@@ -72,7 +72,7 @@ linkgit:git-config[1].
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, the new working tree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
-doesn't exist, a new branch based on HEAD is automatically created as
+doesn't exist, a new branch based on `HEAD` is automatically created as
 if `-b <branch>` was given.  If `<branch>` does exist, it will be
 checked out in the new working tree, if it's not checked out anywhere
 else, otherwise the command will refuse to create the working tree (unless
@@ -137,13 +137,13 @@ To remove a locked working tree, specify `--force` twice.
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
 	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
-	If `<commit-ish>` is omitted, it defaults to HEAD.
+	If `<commit-ish>` is omitted, it defaults to `HEAD`.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.
 
 --detach::
-	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
+	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
@@ -154,7 +154,7 @@ To remove a locked working tree, specify `--force` twice.
 
 --[no-]guess-remote::
 	With `worktree add <path>`, without `<commit-ish>`, instead
-	of creating a new branch from HEAD, if there exists a tracking
+	of creating a new branch from `HEAD`, if there exists a tracking
 	branch in exactly one remote matching the basename of `<path>`,
 	base the new branch on the remote-tracking branch, and mark
 	the remote-tracking branch as "upstream" from the new branch.
@@ -166,7 +166,7 @@ This can also be set up as the default behaviour by using the
 	When creating a new branch, if `<commit-ish>` is a branch,
 	mark it as "upstream" from the new branch.  This is the
 	default if `<commit-ish>` is a remote-tracking branch.  See
-	"--track" in linkgit:git-branch[1] for details.
+	`--track` in linkgit:git-branch[1] for details.
 
 --lock::
 	Keep the working tree locked after creation. This is the
@@ -185,14 +185,14 @@ This can also be set up as the default behaviour by using the
 
 -q::
 --quiet::
-	With 'add', suppress feedback messages.
+	With `add`, suppress feedback messages.
 
 -v::
 --verbose::
 	With `prune`, report all removals.
 
 --expire <time>::
-	With `prune`, only expire unused working trees older than <time>.
+	With `prune`, only expire unused working trees older than `<time>`.
 
 --reason <string>::
 	With `lock`, an explanation why the working tree is locked.
@@ -209,12 +209,12 @@ then `ghi` or `def/ghi` is enough to point to the former working tree.
 REFS
 ----
 In multiple working trees, some refs may be shared between all working
-trees and some refs are local. One example is HEAD which is different for each
+trees and some refs are local. One example is `HEAD` which is different for each
 working tree. This section is about the sharing rules and how to access
 refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
-with `refs/` are shared. Pseudo refs are ones like HEAD which are
+with `refs/` are shared. Pseudo refs are ones like `HEAD` which are
 directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are
 exceptions, however: refs inside `refs/bisect` and `refs/worktree` are not
 shared.
@@ -225,7 +225,7 @@ former gives access to per-working tree refs of the main working tree,
 while the latter to all linked working trees.
 
 For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
-resolve to the same value as the main working tree's HEAD and
+resolve to the same value as the main working tree's `HEAD` and
 `refs/bisect/good` respectively. Similarly, `worktrees/foo/HEAD` or
 `worktrees/bar/refs/bisect/bad` are the same as
 `$GIT_COMMON_DIR/worktrees/foo/HEAD` and
@@ -243,7 +243,7 @@ already present in the config file, they will be applied to the main
 working trees only.
 
 In order to have configuration specific to working trees, you can turn
-on "worktreeConfig" extension, e.g.:
+on the "worktreeConfig" extension, e.g.:
 
 ------------
 $ git config extensions.worktreeConfig true
-- 
2.28.0

