Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B15F20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbdKVWaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:30:16 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39968 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdKVW25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:28:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so13093663wmd.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZjMyDkMFouBT9lXFTmoKsAQN4pO1vIHDTVzGTzbJcK0=;
        b=ubBJX5Q9n8QfNjfp0QUNArg3U/3uue0m/IZxs3jOloQeaz8mi1x/qCJaF8X7uu32Il
         dZQOORqrgiRc580PAvIWKGVJB2RlM5gQ2G1rNedfFC9M/wbGhfYEpXjcQqCl1g1gIqD8
         TRigBstEaRqx3z9tUD0b4Qwd448nKnMHsBEj1Z/cQrclTCHGdmhKAjtKYCBAxcQt8m+l
         RAHlneEm/J/swLPtI5h+fdUeCB1j1EoCN4qcuuRUVuyejize6OehzwXs65gKpLeNQ3cZ
         X7uQdYXBSr8R7T7siqDKO/Lg1ryz97BGU0MsaUsOBhqNuxpWz30LMdXqmLmcYHJUpqgn
         cmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZjMyDkMFouBT9lXFTmoKsAQN4pO1vIHDTVzGTzbJcK0=;
        b=tFo2sgrUO4tOQh+6Ks6v/L/6duOfpsuZTe4fTfPONYeKpCVabdmiIBQKFczgD10t94
         r5NPtjhzVJsvfhCuIj3DqDXzvSMfgnt3EwlzPUYSM56gzMWvMpsrWua7A77dKKf+ZTSZ
         +pCEoldDKi7Iqc0vlBWOGI7/EpD9cLX83nXyRi/UWC0079RsP6O++9JKhqEbg8Ww8jku
         6pJXEKPNlCXyrnlYeFOIvAhXJmVXijIruW2LRZXkzbOwKVOF2mlBi+KP24ZStWggzcdl
         ebk1vmuiZUcO22nbSGlDr/iMnY1+NIcoiWzSNzVuxVlpbLF+ZQZR9uPncS88DCYJNLBN
         jo2g==
X-Gm-Message-State: AJaThX51znJhv+pO4jWkvKSDA3yl3A/XcUMV2JM2ofDXan332XDtyk3p
        S9ZBP+/+M1wgPdioOh9vsmEKb6UZ
X-Google-Smtp-Source: AGs4zMaQUeu0TC14h8sZLNhEPKHbML+8d020RI6rYaj+/QhmJtyFJpAJQ3cfdUInYbvWS1oV7gxw3A==
X-Received: by 10.28.238.135 with SMTP id j7mr2445677wmi.140.1511389735818;
        Wed, 22 Nov 2017 14:28:55 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i192sm4330880wmf.46.2017.11.22.14.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:28:54 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 3/4] worktree: make add <path> <branch> dwim
Date:   Wed, 22 Nov 2017 22:30:19 +0000
Message-Id: <20171122223020.2780-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171122223020.2780-1-t.gummerer@gmail.com>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path> <branch>', errors out when 'branch'
is not a local branch.   It has no additional dwim'ing features that one
might expect.

Make it behave more like 'git checkout <branch>' when the branch doesn't
exist locally, but a remote tracking branch uniquely matches the desired
branch name, i.e. create a new branch from the remote tracking branch
and set the upstream to the remote tracking branch.

As 'git worktree add' currently just dies in this situation, there are
no backwards compatibility worries when introducing this feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  7 +++++++
 builtin/worktree.c             | 16 ++++++++++++++++
 t/t2025-worktree-add.sh        | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 798a642f84..45642d3b7f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,6 +52,13 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<branch>`; it is synonymous with `@{-1}`.
 +
+If <branch> is not found, and neither `-b` nor `-B` nor `--detach` are
+used, but there does exist a tracking branch in exactly one remote
+(call it <remote>) with a matching name, treat as equivalent to
+------------
+$ git worktree add --track -b <branch> <path> <remote>/<branch>
+------------
++
 If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8f9446d43c..e9cc3f3872 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "checkout.h"
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
@@ -390,6 +391,21 @@ static int add(int ac, const char **av, const char *prefix)
 		opts.new_branch = xstrndup(s, n);
 	}
 
+	if (ac == 2 && !opts.new_branch && !opts.detach) {
+		struct object_id oid;
+		struct commit *commit;
+		const char *remote;
+
+		commit = lookup_commit_reference_by_name(branch);
+		if (!commit) {
+			remote = unique_tracking_name(branch, &oid);
+			if (remote) {
+				opts.new_branch = branch;
+				branch = remote;
+			}
+		}
+	}
+
 	if (opts.new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 53042ce565..ea144938a9 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -369,4 +369,25 @@ test_expect_success '--no-track avoids setting up tracking' '
 	)
 '
 
+test_expect_success '"add" <path> <non-existent-branch> fails' '
+	test_must_fail git worktree add foo non-existent
+'
+
+test_expect_success '"add" <path> <branch> dwims' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		git worktree add ../foo foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_upstream foo &&
+		git rev-parse repo_upstream/foo >expect &&
+		git rev-parse foo >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.15.0.345.gf926f18f3

