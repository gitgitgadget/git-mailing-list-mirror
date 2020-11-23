Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5405C64E75
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4B420738
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlS/d6ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbgKWWq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732924AbgKWWq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:46:26 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE0C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:46:26 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n11so17530204ota.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gc4tiv1Ov5EKyyWZImNeb4SLWQv6xMIPdZIROa7rCzE=;
        b=ZlS/d6iemUKgC6582xLIGPjuMuoD5MnjltjVhRityKcREnhisLOTSXbgx7qNSdIDEw
         C/NXeMEYDAf1vNyPbhtCoLdB1Ese8GatbhuFZ9rFBeupKFibmJt07RdQfJTH30ashISE
         YrJLA1KoC2IlDZd9px/tWWwytz7XfLVRuhYQMml/rggrR8JXGBXD6EWuJ+AnsnPIwB3O
         0rMFPbJ3D/MyszmA2O9je3oQXc4/onn1TpApLF684drR4kBZQauk8zqc9O7dztNmcrEq
         TV6p0ZTAvjDQnBPm/vPtYpoafAwmQEcyRjRKEHXeR9QcOzbKGkqo+8jEFCnrULEBQgkZ
         PXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gc4tiv1Ov5EKyyWZImNeb4SLWQv6xMIPdZIROa7rCzE=;
        b=By+fJO/yNQ4oxnK1sJNnJuSv8YDWARn0Os9gxr1xJ0nf+M7vES3jULjNV3qGJILr3e
         B2RQx6xkuv95KwORhMWIbGeumeWIiq1McaVLgImuudVjTLrOZAfbC2uueTP0f+jbgLYR
         UjxHZuxocrxuklSUNfGxE1Xp8tJ3PoI6jo8XXAtdNPuXiuT2hPtUqlMZhjQcSBEcWilk
         4AlZYZfn1ZLHlBxZo8DLBFzcSDLSd+40J8WjBFfk2y4VhSpPDMMm+VlqVqCcxoUVZYRo
         Pa75au/tk7uhiho8t0D91YZgWmApw/ChGCKzNbSntNHC3hqkwfq/i+0OdyG0ZyPc11nG
         kjnA==
X-Gm-Message-State: AOAM531ClDV1kGLhuOGO/8qdEseaL4IJ4cIWcLUzUPsKR09Do5Kdwx9U
        kFcPxaFkWodujR0Z4WMNCt+lxqOPHA2xLA==
X-Google-Smtp-Source: ABdhPJwZ6Btq9bHAwxqWm+Ka87KHZt3z3uNpC5inMRnsPWeJQrZehdUAwuRZecmVfdNwjZzHI978OQ==
X-Received: by 2002:a9d:46f:: with SMTP id 102mr1240166otc.293.1606171585884;
        Mon, 23 Nov 2020 14:46:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v5sm8293312oob.40.2020.11.23.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:46:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 1/1] pull: add ff-only option
Date:   Mon, 23 Nov 2020 16:46:21 -0600
Message-Id: <20201123224621.2573159-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123224621.2573159-1-felipe.contreras@gmail.com>
References: <20201123224621.2573159-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is very typical for Git newcomers to inadvertently create merges and
worse; inadvertently pushing them. This is one of the reasons many
experienced users prefer to avoid 'git pull', and recommend newcomers to
avoid it as well.

To avoid these problems, and keep 'git pull' useful, it has been
suggested that 'git pull' barfs by default if the merge is
non-fast-forward, which unfortunately would break backwards
compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it;

  pull.rebase = ff-only.

Later on this mode can be enabled by default.

For the full discussion you can read:

https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  2 ++
 Documentation/config/pull.txt   |  2 ++
 builtin/pull.c                  |  6 +++++-
 rebase.c                        |  2 ++
 rebase.h                        |  3 ++-
 t/t5520-pull.sh                 | 36 +++++++++++++++++++++++++++++++++
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..715987c759 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -81,6 +81,8 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+When `ff-only` (or just 'f'), the rebase will only succeed if it's fast-forward.
++
 When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 5404830609..060bacc63c 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -14,6 +14,8 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+When `ff-only` (or just 'f'), the rebase will only succeed if it's fast-forward.
++
 When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
diff --git a/builtin/pull.c b/builtin/pull.c
index 17aa63cd35..ba2777c401 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1033,8 +1033,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			}
 			free_commit_list(list);
 		}
-		if (!ran_ff)
+		if (!ran_ff) {
+			if (opt_rebase == REBASE_FF_ONLY)
+				die(_("The pull was not fast-forward, please either merge or rebase.\n"
+					"If unsure, run 'git pull --merge'."));
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
diff --git a/rebase.c b/rebase.c
index f8137d859b..eba1253552 100644
--- a/rebase.c
+++ b/rebase.c
@@ -20,6 +20,8 @@ enum rebase_type rebase_parse_value(const char *value)
 		return REBASE_FALSE;
 	else if (v > 0)
 		return REBASE_TRUE;
+	else if (!strcmp(value, "ff-only") || !strcmp(value, "f"))
+		return REBASE_FF_ONLY;
 	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
 		return REBASE_PRESERVE;
 	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
diff --git a/rebase.h b/rebase.h
index cc723d4748..127febeb7c 100644
--- a/rebase.h
+++ b/rebase.h
@@ -7,7 +7,8 @@ enum rebase_type {
 	REBASE_TRUE,
 	REBASE_PRESERVE,
 	REBASE_MERGES,
-	REBASE_INTERACTIVE
+	REBASE_INTERACTIVE,
+	REBASE_FF_ONLY
 };
 
 enum rebase_type rebase_parse_value(const char *value);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..d96bdc90cc 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -819,4 +819,40 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+test_expect_success 'git pull fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.rebase ff-only &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.rebase ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.rebase ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --no-rebase
+'
+
 test_done
-- 
2.29.2

