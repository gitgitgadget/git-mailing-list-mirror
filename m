Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D175C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352266AbiCaBO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352263AbiCaBOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BAD66600
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so849962wmb.4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8o72rRZ3FyCuz0D5G61bdzdVczinb70ARlQbOEFV3g=;
        b=GuSNDqBtc0vrBJhzHfUnTM0qLOwlAuBmX5g6DIx2RTf76gAY4cr0/5H4kjKjuRFZ4w
         +uAn0upnZoyI27Zuh3Xsu1tRA06DJX8P1claiWbVeSgKAfTU2s4bNijfPY9IEuDE69u0
         i683P1w+O8UuwjmnoR5xJGzxd2JExae22TRLOdR84Ls5OTJFUwNFqrTTge0WNYoRXx7y
         CFUvTkQPsdsvpoU40tu/+L2Lf8RbKnNfvfe+4nJlaWCByKWx2+MdKY0ha/mqJLyWXQ8/
         5bXxE54257bSXqwG99mjYkdVo9k4IJI3hahgL616LOUgO4BOK+BDUee1+J6IWI9w64P3
         KTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8o72rRZ3FyCuz0D5G61bdzdVczinb70ARlQbOEFV3g=;
        b=S4L1RuhzPqV5LJscVFXdhmkzSDnrFwhiftajrljZUgA6svcOwz0nTGtZ1r1eA9CYMg
         fGEzdc08bHAPPfJn3dR955t5qQjWNSAchGWH1k1VQYmmhzQmMllLv5k/kNqELWZXfQCX
         y8aHNLLGPwUW2N+CoU81MlJOcMouYBzEjKm5c5aqmcF6pkeRqbh2gXV1ILrQ/Q+/hZh1
         OabmCNtZz/6vk6eZDp38hL5oAcdMXRxCtyBs4AP5YYm2SSlRbWWD+sm+SvF+oyacVdUZ
         DRdJymK8hGJXfJ7srn/0sciWqyD7UskCc8Uch3RifrPJbg0PfOzZ1104sA5/YXgA/oax
         p+2g==
X-Gm-Message-State: AOAM530DEvzom3XPCqptyo4q13cKeE9K/uaSpkHaJpKsv5gkKr9fWZZ3
        BMQOEx2ticuELRyIKc1wwVuaBHUXK2/9NQ==
X-Google-Smtp-Source: ABdhPJwFdw6j3nAVfLDUwNcLsE1OMfzJQkoLkSCb/phPA3AtfWODYfx9WPpj2j2aZ0u+m4YfKBE4Vg==
X-Received: by 2002:a05:600c:4fd5:b0:38c:ca19:1be2 with SMTP id o21-20020a05600c4fd500b0038cca191be2mr2285534wmq.167.1648689136898;
        Wed, 30 Mar 2022 18:12:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:16 -0700 (PDT)
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
Subject: [PATCH v4 13/27] revisions API users: use release_revisions() in builtin/log.c
Date:   Thu, 31 Mar 2022 03:11:18 +0200
Message-Id: <patch-v4-13.27-02ca92660af-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
2.35.1.1557.g4e3e9cdb5e0

