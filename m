Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E875C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 09:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5B46139A
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 09:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhGJJbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhGJJbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 05:31:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D80C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 02:28:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 17so11137659pfz.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzqE8eWgOETa/WfmjCb1LFa5EPg4O4XY5/Owf4o/QZ0=;
        b=S2slc6aCLyjZ8O3DC1051gDlv++5cR9W9dCgOIxWOqxd1m1JD1di4VkwH5TVdHEg7t
         /TjjY5bl397RvhBy6kyKFAznGPFXrsf0O9SbIfgEzkfEm0dJaTGbSK9NR2CAN/NEqOcv
         euFPFbmolJ/1sxirX/W7dpG2q28b7bDzl7Yr3mEiwI3d6zc6smj4bgCyXmJ3Dajxhn/l
         M+Jwzl9yb9iTCVW1CnJHDOEl1a3Ib2nQbk1UHAt8BuOmQnUfuU1R0k4UO6KdjNmRIzlo
         Ug3R5pur4+8Stu8uZYTAmExA7RK8l/N34E7mNAZjmQcNYJo1s+5APKeoZMd8Pha24Kzk
         VLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzqE8eWgOETa/WfmjCb1LFa5EPg4O4XY5/Owf4o/QZ0=;
        b=euuqLna+rr/RmYs1nthf03Dq4KHHAGpBABYwn0g4OTrfmy43qx66BjRx+hUobkcNj4
         X4B9Zo8NpanjTcxgVaIL1cbAtYb15e/6Pg1TTdD1BPlfwfcYC2A7950u0rFJVmGMUcMy
         1HSzSCKCSoXXuDqR6M/MNmIz1UVgbdv7+gwxB1ZUqeke6YkEraePSeula82otROKQX7s
         +U5SEOuQyEeUF9td5i446kMpkKAIh2HyWYLyNcsnHXh+94691bN1ksvT8ALyBqS3+a/w
         t/Fff4Asl/6YGkqZSpbGICVwXeI5v9spucpw8qzlOp6HAyiKAEHZ+OIEceQoK0xQRLb/
         8WNA==
X-Gm-Message-State: AOAM5326D3mH6DiiqQpl52op/JsvEpGHBEtK3BCm+6aoeRi3w/zgCxSx
        IoUtp6/uztkcg/22JHuSvyKRh1ovUvw=
X-Google-Smtp-Source: ABdhPJzCvkfMuVlObhDCpcsFDv4f7z4Lk3WVkiJrfvkrAI0ck2jUXzDxbgfNILGQGhXnHls+mCb3lA==
X-Received: by 2002:a63:f346:: with SMTP id t6mr42932697pgj.277.1625909318402;
        Sat, 10 Jul 2021 02:28:38 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.15.234])
        by smtp.gmail.com with ESMTPSA id l10sm14755604pjg.26.2021.07.10.02.28.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 02:28:37 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] git-diff: fix missing --merge-base docs
Date:   Sat, 10 Jul 2021 02:28:31 -0700
Message-Id: <f0e7ef2433e2836fed579f2765654c5f97d5d778.1625909286.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.186.g3cb6fa43cd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git diff --merge-base` was introduced, the documentation included
a few errors.

In the example given for `git diff --cached --merge-base`, the
`--cached` flag was omitted for the `--merge-base` example. Add the
missing flag.

In the `git diff <commit>` case, we failed to mention that
`--merge-base` is an available option. Give the usage of `--merge-base`
as an option there.

Finally, there are two errors in the usage of `git diff`. Firstly, we do
not mention `--merge-base` in the `git diff --cached` case. Mention it
so that it's consistent with the documentation. Secondly, we put the
`[--merge-base]` in between `<commit>` and `[<commit>...]`. Move the
`[--merge-base]` so that it's beside `[<options>]` which is a more
logical grouping.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff.txt | 10 +++++++---
 builtin/diff.c             |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 7f4c8a8ce7..6236c75c9b 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -51,16 +51,20 @@ files on disk.
 	--staged is a synonym of --cached.
 +
 If --merge-base is given, instead of using <commit>, use the merge base
-of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
-`git diff $(git merge-base A HEAD)`.
+of <commit> and HEAD.  `git diff --cached --merge-base A` is equivalent to
+`git diff --cached $(git merge-base A HEAD)`.
 
-'git diff' [<options>] <commit> [--] [<path>...]::
+'git diff' [<options>] [--merge-base] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
 	use HEAD to compare it with the latest commit, or a
 	branch name to compare with the tip of a different
 	branch.
++
+If --merge-base is given, instead of using <commit>, use the merge base
+of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
+`git diff $(git merge-base A HEAD)`.
 
 'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 2d87c37a17..dd8ce688ba 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -26,8 +26,8 @@
 
 static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit>] [--] [<path>...]\n"
-"   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
-"   or: git diff [<options>] <commit> [--merge-base] [<commit>...] <commit> [--] [<path>...]\n"
+"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>]\n"
 "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
-- 
2.32.0.rc1.186.g3cb6fa43cd

