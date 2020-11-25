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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0567C64E90
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21E82075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsP7A6ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKYD35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:56 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964BCC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:56 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 92so994396otd.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCbiIjvrPL4MR84lIt92POutCrsCfn3bAgBiU+QO3ko=;
        b=EsP7A6ikiGco3xWykBAqMNHBVkna1YEFUyLLzaHnaPXwnYP3guPnyQvOO8yQrRHugQ
         8B1lwIfHCw37OEmyagJHb8V8EfNpKLgHpD555dpvoGR5m8ANiWxfSpYFDKEvRUXyBeMa
         Aw80i1HMQTRDvdu/kS5cGN7D8XCNEDhpZX+OVi3kUKePhFt3E1kVXI452m3hZE5z9H9X
         pcZoaYdV4a/l2/peTsCI9W3EbbM8TvVrezAbs8Dey9m72MGkbtwV7HpezK2+Cyscp5Px
         T+U9GqWxHowqbgYK1b9W7Jcs/1xJJzWwXwqI1EkYXunII+dqOptE6bv/ux3w+SZU0umx
         7rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCbiIjvrPL4MR84lIt92POutCrsCfn3bAgBiU+QO3ko=;
        b=O3jiO0P6NS6plHSLBjwOS2uIHRFFaBVvuei+IxCbbRlQeBydTgzlWqKywlzJLSQfVK
         4BjA2/pjFL/nq0lcsxkoH3AoKXh3flSHEYcaixKaLSRXm8fzJJRGTaTklpxsyc/FcU13
         YjRWjRxFavfYPwOL53p/NGssN5F1oIQ/ZzBeITlLlj2sYQKmzfqJb2dAoYxw0FoBtG3P
         GbJlsfh48Tzpnl5mZSmL/ud/On0yYUw3MA+EyYU1tDj8xmPd4DF6c7wQ4Xh4X1VFBylC
         OO9gxdbY0o5saV1/y29ttv7jh6PELpiKzng+h7AP76qaw+oA8bMjJGCio1xYBqrwvygd
         JHdA==
X-Gm-Message-State: AOAM531qJCp2U3g0fNED3FmboyGv9a+kJhJAdS48vjeY6X7fKZ1tXKfI
        QuxAPeyatkjuO41qdf4kIndognIetwU0Xg==
X-Google-Smtp-Source: ABdhPJyxcPW0yYtPRC4xYkkykCBoosx582TXMFbFMRW+3Bg4SAMcj01BYwFFZFOC/6nx8jZUaPZY8w==
X-Received: by 2002:a9d:1f5:: with SMTP id e108mr1387354ote.309.1606274995638;
        Tue, 24 Nov 2020 19:29:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k5sm649551oot.30.2020.11.24.19.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:54 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 09/10] pull: add pull.mode=ff-only
Date:   Tue, 24 Nov 2020 21:29:37 -0600
Message-Id: <20201125032938.786393-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
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

  pull.mode = ff-only.

Later on this mode can be enabled by default.

For the full discussion you can read:

https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  2 +-
 Documentation/config/pull.txt   |  2 +-
 builtin/pull.c                  | 10 +++++++--
 builtin/remote.c                |  3 +++
 rebase.c                        |  2 ++
 rebase.h                        |  3 ++-
 t/t5520-pull.sh                 | 36 +++++++++++++++++++++++++++++++++
 7 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 94510a5184..39f60cd8f7 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -99,7 +99,7 @@ for details).
 branch.<name>.pullmode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	'rebase'. See "pull.mode" for doing this in a non
+	'rebase', and 'ff-only'. See "pull.mode" for doing this in a non
 	branch-specific manner.
 
 branch.<name>.description::
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 2606515fe4..daa14f1170 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -32,7 +32,7 @@ for details).
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	and 'rebase'. See "branch.<name>.pullmode" for doing
+	'rebase', and 'ff-only'. See "branch.<name>.pullmode" for doing
 	this in a non branch-specific manner.
 
 pull.octopus::
diff --git a/builtin/pull.c b/builtin/pull.c
index feb9a7f6ee..3aa7f56142 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -980,7 +980,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!mode) {
-		if (opt_rebase)
+		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
+			mode = PULL_MODE_FF_ONLY;
+		else if (opt_rebase)
 			mode = opt_rebase >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
 	}
 
@@ -1065,7 +1067,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"\n"
 			"  git config pull.mode merge    # (the default strategy)\n"
 			"  git config pull.mode rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
+			"  git config pull.mode ff-only  # fast-forward only\n"
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
 			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
@@ -1073,6 +1075,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"invocation.\n"));
 	}
 
+	if (mode == PULL_MODE_FF_ONLY && !can_ff)
+		die(_("The pull was not fast-forward, please either merge or rebase.\n"
+			"If unsure, run 'git pull --no-rebase'."));
+
 	if (opt_rebase >= REBASE_TRUE) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
diff --git a/builtin/remote.c b/builtin/remote.c
index 51b1e675e3..34d3ea9d38 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -335,6 +335,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		case PULL_MODE_REBASE:
 			info->rebase = REBASE_TRUE;
 			break;
+		case PULL_MODE_FF_ONLY:
+			info->rebase = REBASE_TRUE;
+			break;
 		default:
 			info->rebase = REBASE_INVALID;
 			break;
diff --git a/rebase.c b/rebase.c
index bdfca49886..c6233e888f 100644
--- a/rebase.c
+++ b/rebase.c
@@ -40,6 +40,8 @@ enum pull_mode_type pull_mode_parse_value(const char *value)
 		return PULL_MODE_MERGE;
 	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
 		return PULL_MODE_REBASE;
+	else if (!strcmp(value, "ff-only") || !strcmp(value, "f"))
+		return PULL_MODE_FF_ONLY;
 
 	return PULL_MODE_INVALID;
 }
diff --git a/rebase.h b/rebase.h
index 5ab8f4ddd5..432bcb55c4 100644
--- a/rebase.h
+++ b/rebase.h
@@ -17,7 +17,8 @@ enum pull_mode_type {
 	PULL_MODE_INVALID = -1,
 	PULL_MODE_DEFAULT = 0,
 	PULL_MODE_MERGE,
-	PULL_MODE_REBASE
+	PULL_MODE_REBASE,
+	PULL_MODE_FF_ONLY
 };
 
 enum pull_mode_type pull_mode_parse_value(const char *value);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index eb0086bd1c..ba78c16d73 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -861,4 +861,40 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+test_expect_success 'git pull fast-forward (ff-only)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode ff-only &&
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
+	test_config pull.mode ff-only &&
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
+	test_config pull.mode ff-only &&
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

