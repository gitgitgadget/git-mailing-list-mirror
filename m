Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4DCC6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 18:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCMSPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCMSPo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 14:15:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C367838
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 11:15:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i5so13945173pla.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678731342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osWuBNYstEELe8+8CtB5S3rFevdV/mCeRTIiiE5XLFA=;
        b=JjZdwdNsxWnxITnR1zIH6oLx95YlRPl+lO8k21LPYo8DAL4FvkZL0NfnvNV/OZE3Om
         qUssYU9NMWRpcIL7DLW7XE6amzmXKlTH8m5O7uBVHAiYcg3wXZQ0DQKMl4+umc8TMt/E
         QtSyrfgaA79qno0rNdj6Pxqr7ywjqPuLVpKzQvwXXU83IF0HFCaC/UdUbiw4aEV/fVhj
         R5CGSAMPRUZIWUeAsarm2yVgEREDMqeUX3S7x6g9i/fQ299VOGTK6ttZCsnOGFodMECK
         1auKZjA/528j+a08uAwOSTChpzIK9Abysh7WXhRi0pdzTqC8CjvCxgoXkmY4k+rEOlcq
         36Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osWuBNYstEELe8+8CtB5S3rFevdV/mCeRTIiiE5XLFA=;
        b=yWYg77euY0s34SKUaYYGKk5H2WpWQ9/F1pp8xuwztY9XjuzEDN97Pa/JRtope8tO5W
         IuMBKSfJ2lViu44pCm4zytc/3AS1w2sKfX2MIKBWGjFEFeR5rl4BbihRPBBNOkQuw9QU
         hLyn4lE+jt3+s7jUTva8N7EuEjrEk7YjPg0MQ7chByk6K9EWSqX2bNETH8alAMuTAuRg
         va9OmfDoiH33ytYzGdJMbfTWSYUhr2AhtteWpautiAtp/uByiw6BH2Xg2pCISSef2/uw
         n66epKKPpMkyRJXzkDz1E/VB7fEWHL2056ERaMZJukT5qNKMwBAfXcuyGnLtlXdcGOIf
         DQzg==
X-Gm-Message-State: AO0yUKVTkx32/NNr+axHjyxqwqEX04T2coZiQgNMSfhUkCBhfEJH35bc
        YpePY15UJsx99bG1w0GcgCezCobTqiijxw==
X-Google-Smtp-Source: AK7set8Ai1zd279OO9ML3wUJsvw823pU56D/NaBmOdHcA0Bfu1CMMykbMRskv7QCknl82SeSIsFzKg==
X-Received: by 2002:a05:6a20:7349:b0:cc:9b29:f5ff with SMTP id v9-20020a056a20734900b000cc9b29f5ffmr35987053pzc.35.1678731342344;
        Mon, 13 Mar 2023 11:15:42 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.150.111])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78195000000b0058173c4b3d1sm44702pfi.80.2023.03.13.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:15:41 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathanmy@google.com, gitster@pobox.com, fve231003@gmail.com,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3] index-pack: remove fetch_if_missing=0
Date:   Mon, 13 Mar 2023 23:45:18 +0530
Message-Id: <20230313181518.6322-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310183029.19429-1-five231003@gmail.com>
References: <20230310183029.19429-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A collision test is triggered in sha1_object(), whenever there is an
object file in our repo. If our repo is a partial clone, then checking
for this file existence does not lazy-fetch the object (if the object
is missing and if there are one or more promisor remotes) when
fetch_if_missing is set to 0.

This global was added as a temporary measure to suppress the fetching
of missing objects [1] and can be removed once the remaining commands:
 - fetch-pack
 - fsck
 - pack-objects
 - prune
 - rev-list
can handle lazy-fetching without fetch_if_missing.

Hence, use has_object() to check for the existence of an object, which
has the default behavior of not lazy-fetching in a partial clone. It is
worth mentioning that this is the only place where there is potential for
lazy-fetching and all other cases [2] are properly handled, making it safe
to remove this global here.

[1] See 8b4c0103a9 (sha1_file: support lazily fetching missing objects,
		   2017-12-08)
[2] These cases are:
    - When we check objects, but we return with 0 early if the object
      doesn't exist.
    - We prefetch delta bases in a partial clone, if we don't have them
      (as the comment outlines).
    - There are some cases where we fsck objects, but lazy-fetching is
      already handled in fsck.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 builtin/index-pack.c     | 11 +----------
 t/t5616-partial-clone.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6648f2daef..8c0f36a49e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -800,8 +800,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed =
-			has_object_file_with_flags(oid, OBJECT_INFO_QUICK);
+		collision_test_needed = has_object(the_repository, oid, 0);
 		read_unlock();
 	}
 
@@ -1728,14 +1727,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	int report_end_of_input = 0;
 	int hash_algo = 0;
 
-	/*
-	 * index-pack never needs to fetch missing objects except when
-	 * REF_DELTA bases are missing (which are explicitly handled). It only
-	 * accesses the repo to do hash collision checks and to check which
-	 * REF_DELTA bases need to be fetched.
-	 */
-	fetch_if_missing = 0;
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f519d2a87a..fdb34a0b50 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,34 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collsions' '
+	rm -rf server client another-remote &&
+
+	git init server &&
+	echo "line" >server/file &&
+	git -C server add file &&
+	git -C server commit -am "file" &&
+	git -C server config --local uploadpack.allowFilter 1 &&
+	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
+
+	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
+	git -C client config extensions.partialClone 1 &&
+	git -C client config remote.origin.promisor 1 &&
+
+	git clone "file://$(pwd)/server" another-remote &&
+
+	echo "new line" >server/new-file &&
+	git -C server add new-file &&
+	git -C server commit -am "new-file" &&
+
+	git -C another-remote pull &&
+
+	# Try to fetch so that "client" will have to do a collision-check.
+	# This should, however, not fetch "new-file" because "client" is a
+	# partial clone.
+	git -C client fetch "file://$(pwd)/another-remote" main
+'
+
 test_expect_success 'lazy-fetch in submodule succeeds' '
 	# setup
 	test_config_global protocol.file.allow always &&
-- 
2.25.1

