Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8FC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiCWUeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344745AbiCWUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B408CD90
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so3797570wrg.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oU0NeVqDT3klzVUzDgz80upd/AenWyAq/n7MNDrCq4g=;
        b=Cr7h9K4ZKoVn5bZHxMT4IURQpIBiGl4yfUXnVlgeDj1PInnHuZsIZb4j0iavSau0XX
         44hwmi2wFAko5H7hweC3NU+AAV1EiB6i5CzxQdQfKqUMbU45wG+Li6gjmNsUNZm4NLjt
         SzbO/d8L9RsmPjr0a3N+NqOe2ax1vgakEK3xC/CiFuPp4r79AgSZcj8GO8G92yRxcn+t
         tK5WgUWpqH8mP7+Tej45BsmG7f0SpFGVE8bkXS54I8No4WKoBm+kZS/YTKAyPfNh9oiB
         RflPj4QyNj4PO4xeQtEzD+vhl9Vh9zgWvk9HnrZZcWd5MoCmD7RB9Oemi5nrbgUhnk1+
         BW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oU0NeVqDT3klzVUzDgz80upd/AenWyAq/n7MNDrCq4g=;
        b=6FuIoTIm6pZ++5BjsPknjAwjeUYv/c5v5bWFSKKGmACbJqKz3UIoz/xCeqSJ+AyhHp
         Q+hj6VP0+w4U026xYZOcZhqWdtXVw8FzFNc6MfvzgLg9XeDVv1+Bo4DdOZYD7Q1tvgSO
         WapkQueaTovyYmtX7NC4mfs8VS/i8A5e96tPSZyRjRETI/otgM2DEPiPKRwb7eyMBvDG
         Cm0EEaufijBis1JxBLHAoyVHLV7gmeJ/J99WuUM4YBCtQfFUg7er+vPe7LatSaFGTXYI
         JDn16IVg/UHaYi5HboA4yf+WndhkpUAG8+6XaQwj4jq7s1aaMzefZNp2im+bcVPVeDrv
         iVWg==
X-Gm-Message-State: AOAM532fWwc1nzom0DXzRinTUHH8F2tmOGdW12QzRAV8khDf6LlK8sQs
        ihT41Jw3XF1EiPs8qP4qg4Yw6OAyHwjFwA==
X-Google-Smtp-Source: ABdhPJwaG3ObYBuWe+2zsYfe26iUF/SCzsLY/RKSZ7Bm0MqoRWcId3N5w7xh9CwX3LVV6ZbdJ3CndQ==
X-Received: by 2002:adf:e483:0:b0:203:f946:396 with SMTP id i3-20020adfe483000000b00203f9460396mr1595925wrm.548.1648067557247;
        Wed, 23 Mar 2022 13:32:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/27] revisions API users: use release_revisions() in builtin/log.c
Date:   Wed, 23 Mar 2022 21:32:02 +0100
Message-Id: <patch-v2-12.27-74818bc372f-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for having the "log" family of functions make wider use
of release_revisions() let's have them call it just before
exiting. This changes the "log", "whatchanged", "show",
"format-patch", etc. commands, all of which live in this file.

The release_revisions() API still only frees the "pending" member, but
will learn to more members of "struct rev_info" in subsequent commits.

In the case of "format-patch" revert the addition of UNLEAK() in
dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16), and
which will cause several tests that previously passed under
"TEST_PASSES_SANITIZE_LEAK=true" to start failing.

In subsequent commits we'll now be able to use those tests to check
whether that part of the API is really leaking memory, and will fix
all of those memory leaks. Removing the UNLEAK() allows us to make
incremental progress in that direction. See [1] for further details
about this approach.

1. https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c          | 20 ++++++++++++--------
 t/t4126-apply-empty.sh |  2 --
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6f9928fabfe..c40ebe1c3f4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -295,6 +295,12 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	cmd_log_init_finish(argc, argv, prefix, rev, opt);
 }
 
+static int cmd_log_deinit(int ret, struct rev_info *rev)
+{
+	release_revisions(rev);
+	return ret;
+}
+
 /*
  * This gives a rough estimate for how many commits we
  * will print out in the list.
@@ -558,7 +564,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	return cmd_log_walk(&rev);
+	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
 static void show_tagger(const char *buf, struct rev_info *rev)
@@ -677,7 +683,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
 	if (!rev.no_walk)
-		return cmd_log_walk(&rev);
+		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
@@ -732,8 +738,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			ret = error(_("unknown type: %d"), o->type);
 		}
 	}
-	free(objects);
-	return ret;
+	return cmd_log_deinit(ret, &rev);
 }
 
 /*
@@ -761,7 +766,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
 
-	return cmd_log_walk(&rev);
+	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
 static void log_setup_revisions_tweak(struct rev_info *rev,
@@ -792,7 +797,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	opt.revarg_opt = REVARG_COMMITTISH;
 	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	return cmd_log_walk(&rev);
+	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
 /* format-patch */
@@ -2289,8 +2294,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
 	free(rev.ref_message_ids);
-	UNLEAK(rev);
-	return 0;
+	return cmd_log_deinit(0, &rev);
 }
 
 static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 33860d38290..66a7ba8ab8f 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,8 +2,6 @@
 
 test_description='apply empty'
 
-
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.35.1.1452.ga7cfc89151f

