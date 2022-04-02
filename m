Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B6CC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354559AbiDBKwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354506AbiDBKv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88910140763
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d10so893048edj.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6Th4p+AfBUYtrHL8XgyQFRFmOHPrk7V106k9ZPn7m4=;
        b=DdLrWS1UWCylWKe0erNttb2VDFZp6NkOSJIoUkdPsdw0c97puI7nI18Ypo3bYnMM2O
         I3QYC/Vu4rUK98bFCa4vOf0bNSPe3tgPN2NKjXoR0dzrS1z+5MgedJLgTavCoPnUMiI7
         YkLD3d54n9PBurb5iDrN87N8/XIoRCGSpplKxU1VwepGyqWd+DWEEbJjhg1wpX7f93tK
         0TTTJj3e15T2mxCYZk+ln2qQMmz0sreDB648L/iOYdkTsKVrVfkHH7C1VHuy4px7hnMy
         oHdb3Y9ryj3dZIv9MBmdMtPR3E+2HvNyMrdDP/07/3COHB/gvFPDXlaW9EOvkLAJceOB
         ifjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6Th4p+AfBUYtrHL8XgyQFRFmOHPrk7V106k9ZPn7m4=;
        b=w6rqsoZcDrreYTncZmuycnA9CuLyk9YQ1sOsTsLJi9/m6AWm5pFtsU7xclzmMgHjqW
         LOik+lGR3l5La1IgLQE4PGHymT8FyOVmwsMgcSBJ0USRJWEzKQ7k4fcZwTU/UaB1yq9C
         DXnsSjxEvWN4gG6HW7hEnSnqjxWLLzk0aG2/trSIATJ2JfuwZO1YQHj8tGAIAqmwihIK
         R+cZccEv1AnRfIlC+ucxZiqdkV08oV8hbSUQHeggBkTkmr0vQJuIuBlRJHYGtNVfvcpb
         FTCQO+3xoiG7AkMFpSZgSBdg3lPqyk7iy/5pkDbq/2AEGP7bbyWu5KkfTKcpyMEeL9yl
         NEzw==
X-Gm-Message-State: AOAM533rVK7wwgt2/GFEd1jWblCbl1HR60Vqr96PDvUv637cEPHM5Ot1
        Y9ffC2lC1TCCZNOvIej9b4mKUEBIv1S0EA==
X-Google-Smtp-Source: ABdhPJw42xKKN6HzuFzPWHs7RxZiNOvkplSDLOXghCVoUpo6LiqvnlaGGE0+JSHmnJirVnpi1yAAgw==
X-Received: by 2002:aa7:c258:0:b0:41b:7bd5:3cb3 with SMTP id y24-20020aa7c258000000b0041b7bd53cb3mr10928330edo.385.1648896597773;
        Sat, 02 Apr 2022 03:49:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/27] revisions API users: use release_revisions() in builtin/log.c
Date:   Sat,  2 Apr 2022 12:49:27 +0200
Message-Id: <patch-v5-13.27-6a02b7aae4e-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
will learn to release more members of "struct rev_info" in subsequent
commits.

In the case of "format-patch" revert the addition of UNLEAK() in
dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16),
which will cause several tests that previously passed under
"TEST_PASSES_SANITIZE_LEAK=true" to start failing.

In subsequent commits we'll now be able to use those tests to check
whether that part of the API is really leaking memory, and will fix
all of those memory leaks. Removing the UNLEAK() allows us to make
incremental progress in that direction. See [1] for further details
about this approach.

Note that the release_revisions() will not be sufficient to deal with
the code in cmd_show() added in 5d7eeee2ac6 (git-show: grok blobs,
trees and tags, too, 2006-12-14) which clobbers the "pending" array in
the case of "OBJ_COMMIT". That will need to be dealt with by some
future follow-up work.

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
2.35.1.1585.gd85f8dcb745

