Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BEC433ED
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9616196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhC1NQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhC1NQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4CAC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b9so10137175wrt.8
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNi1udXeUGRIX8wlJkitrCqQ9K65xVgAqu0JxdZxWtI=;
        b=b54NjVHJ2b5G5cuP7kZKq/x9ARJwwl/rBgcjYISWm/oraNMbfPv0cbrQqgvKTWE7Yl
         tF0FFoQqfJ5E+3hmvUyKivpmdhRzdyR5z+Rq4kHMWF4dYdpcTrarvvWj+y2yVlzLlopn
         /lEW43Wp1gpU01TtT0bCqy2z9Bt9SeHt0MoxzT86MT6Eaiwx/Ner2AvPFzFNIwB5uGCB
         nsBF1NL/+iiYS1729eLIGYfmNf3YfLT5Ehozyi8IIT8IcBwsXPB7qW+sSdqQY4RixxOW
         CjtCZ/bmLWK5CM4/akpJOYSzu3iEUN/Rn0PCvBCRSJmR7TADZ6r2bOrYE+Dp5RREGUJm
         nMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNi1udXeUGRIX8wlJkitrCqQ9K65xVgAqu0JxdZxWtI=;
        b=b8jlLxs/4dLqfwLxqCQGxpDbOv9z4Qt+bTyI4ilP7y1uvVmbz30+9qM6JJUEncJvzR
         yZoDicsQFiwY0TQNYXxN4ExvCxEhTFkcttxfuRAzP+ZAYKd0RK8FcuqMXmSXclKre4ZT
         k9lbP/Ro99hEWzxyYljcI/BdkLpaHG+qL4nafsf1MrI/YcQ8QipIJ64mcQfUhNN/50qf
         mH0/udrO1uUUq/tv7O4oi6Lc+TrVLI+6wd7pMnI9w7Mm+LrxfxQeYBdQEF+718qgqO3V
         dDVrquvkQRo1wvMDerSmUjNtR3Thh4iRr3llil4Ya51ZZxoytOZDcv6zZU1pp9KffYYi
         lZjA==
X-Gm-Message-State: AOAM532j9ZXLZbBtyykxBL9CZV47HgHFICWb1PZDyyTs6+E8PaqUiFfD
        Wo7NdudXbcgjBFLbQVeOuYB0uKIphaS5Yw==
X-Google-Smtp-Source: ABdhPJxBU6nBU4wRcNGPxAHiXzhM3fhlUtNnuhprrA1S+M0bGgi/fJdYSA48+59zp5VoxHyldtoKQQ==
X-Received: by 2002:adf:c641:: with SMTP id u1mr23731290wrg.332.1616937365150;
        Sun, 28 Mar 2021 06:16:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 13/19] fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
Date:   Sun, 28 Mar 2021 15:15:45 +0200
Message-Id: <patch-13.20-1b42aea3a64-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the FOREACH_FSCK_MSG_ID macro and the fsck_msg_id enum it helps
define from fsck.c to fsck.h. This is in preparation for having
non-static functions take the fsck_msg_id as an argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 66 ----------------------------------------------------------
 fsck.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/fsck.c b/fsck.c
index 31c9088e3f7..150fe467e43 100644
--- a/fsck.c
+++ b/fsck.c
@@ -22,72 +22,6 @@
 static struct oidset gitmodules_found = OIDSET_INIT;
 static struct oidset gitmodules_done = OIDSET_INIT;
 
-#define FOREACH_FSCK_MSG_ID(FUNC) \
-	/* fatal errors */ \
-	FUNC(NUL_IN_HEADER, FATAL) \
-	FUNC(UNTERMINATED_HEADER, FATAL) \
-	/* errors */ \
-	FUNC(BAD_DATE, ERROR) \
-	FUNC(BAD_DATE_OVERFLOW, ERROR) \
-	FUNC(BAD_EMAIL, ERROR) \
-	FUNC(BAD_NAME, ERROR) \
-	FUNC(BAD_OBJECT_SHA1, ERROR) \
-	FUNC(BAD_PARENT_SHA1, ERROR) \
-	FUNC(BAD_TAG_OBJECT, ERROR) \
-	FUNC(BAD_TIMEZONE, ERROR) \
-	FUNC(BAD_TREE, ERROR) \
-	FUNC(BAD_TREE_SHA1, ERROR) \
-	FUNC(BAD_TYPE, ERROR) \
-	FUNC(DUPLICATE_ENTRIES, ERROR) \
-	FUNC(MISSING_AUTHOR, ERROR) \
-	FUNC(MISSING_COMMITTER, ERROR) \
-	FUNC(MISSING_EMAIL, ERROR) \
-	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR) \
-	FUNC(MISSING_OBJECT, ERROR) \
-	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
-	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
-	FUNC(MISSING_TAG, ERROR) \
-	FUNC(MISSING_TAG_ENTRY, ERROR) \
-	FUNC(MISSING_TREE, ERROR) \
-	FUNC(MISSING_TREE_OBJECT, ERROR) \
-	FUNC(MISSING_TYPE, ERROR) \
-	FUNC(MISSING_TYPE_ENTRY, ERROR) \
-	FUNC(MULTIPLE_AUTHORS, ERROR) \
-	FUNC(TREE_NOT_SORTED, ERROR) \
-	FUNC(UNKNOWN_TYPE, ERROR) \
-	FUNC(ZERO_PADDED_DATE, ERROR) \
-	FUNC(GITMODULES_MISSING, ERROR) \
-	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_LARGE, ERROR) \
-	FUNC(GITMODULES_NAME, ERROR) \
-	FUNC(GITMODULES_SYMLINK, ERROR) \
-	FUNC(GITMODULES_URL, ERROR) \
-	FUNC(GITMODULES_PATH, ERROR) \
-	FUNC(GITMODULES_UPDATE, ERROR) \
-	/* warnings */ \
-	FUNC(BAD_FILEMODE, WARN) \
-	FUNC(EMPTY_NAME, WARN) \
-	FUNC(FULL_PATHNAME, WARN) \
-	FUNC(HAS_DOT, WARN) \
-	FUNC(HAS_DOTDOT, WARN) \
-	FUNC(HAS_DOTGIT, WARN) \
-	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN) \
-	FUNC(NUL_IN_COMMIT, WARN) \
-	/* infos (reported as warnings, but ignored by default) */ \
-	FUNC(GITMODULES_PARSE, INFO) \
-	FUNC(BAD_TAG_NAME, INFO) \
-	FUNC(MISSING_TAGGER_ENTRY, INFO) \
-	/* ignored (elevated when requested) */ \
-	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
-
-#define MSG_ID(id, msg_type) FSCK_MSG_##id,
-enum fsck_msg_id {
-	FOREACH_FSCK_MSG_ID(MSG_ID)
-	FSCK_MSG_MAX
-};
-#undef MSG_ID
-
 #define STR(x) #x
 #define MSG_ID(id, msg_type) { STR(id), NULL, NULL, FSCK_##msg_type },
 static struct {
diff --git a/fsck.h b/fsck.h
index a7e092d3fb4..66c4a71139a 100644
--- a/fsck.h
+++ b/fsck.h
@@ -13,6 +13,72 @@ enum fsck_msg_type {
 	FSCK_WARN,
 };
 
+#define FOREACH_FSCK_MSG_ID(FUNC) \
+	/* fatal errors */ \
+	FUNC(NUL_IN_HEADER, FATAL) \
+	FUNC(UNTERMINATED_HEADER, FATAL) \
+	/* errors */ \
+	FUNC(BAD_DATE, ERROR) \
+	FUNC(BAD_DATE_OVERFLOW, ERROR) \
+	FUNC(BAD_EMAIL, ERROR) \
+	FUNC(BAD_NAME, ERROR) \
+	FUNC(BAD_OBJECT_SHA1, ERROR) \
+	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_TAG_OBJECT, ERROR) \
+	FUNC(BAD_TIMEZONE, ERROR) \
+	FUNC(BAD_TREE, ERROR) \
+	FUNC(BAD_TREE_SHA1, ERROR) \
+	FUNC(BAD_TYPE, ERROR) \
+	FUNC(DUPLICATE_ENTRIES, ERROR) \
+	FUNC(MISSING_AUTHOR, ERROR) \
+	FUNC(MISSING_COMMITTER, ERROR) \
+	FUNC(MISSING_EMAIL, ERROR) \
+	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR) \
+	FUNC(MISSING_OBJECT, ERROR) \
+	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
+	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
+	FUNC(MISSING_TAG, ERROR) \
+	FUNC(MISSING_TAG_ENTRY, ERROR) \
+	FUNC(MISSING_TREE, ERROR) \
+	FUNC(MISSING_TREE_OBJECT, ERROR) \
+	FUNC(MISSING_TYPE, ERROR) \
+	FUNC(MISSING_TYPE_ENTRY, ERROR) \
+	FUNC(MULTIPLE_AUTHORS, ERROR) \
+	FUNC(TREE_NOT_SORTED, ERROR) \
+	FUNC(UNKNOWN_TYPE, ERROR) \
+	FUNC(ZERO_PADDED_DATE, ERROR) \
+	FUNC(GITMODULES_MISSING, ERROR) \
+	FUNC(GITMODULES_BLOB, ERROR) \
+	FUNC(GITMODULES_LARGE, ERROR) \
+	FUNC(GITMODULES_NAME, ERROR) \
+	FUNC(GITMODULES_SYMLINK, ERROR) \
+	FUNC(GITMODULES_URL, ERROR) \
+	FUNC(GITMODULES_PATH, ERROR) \
+	FUNC(GITMODULES_UPDATE, ERROR) \
+	/* warnings */ \
+	FUNC(BAD_FILEMODE, WARN) \
+	FUNC(EMPTY_NAME, WARN) \
+	FUNC(FULL_PATHNAME, WARN) \
+	FUNC(HAS_DOT, WARN) \
+	FUNC(HAS_DOTDOT, WARN) \
+	FUNC(HAS_DOTGIT, WARN) \
+	FUNC(NULL_SHA1, WARN) \
+	FUNC(ZERO_PADDED_FILEMODE, WARN) \
+	FUNC(NUL_IN_COMMIT, WARN) \
+	/* infos (reported as warnings, but ignored by default) */ \
+	FUNC(GITMODULES_PARSE, INFO) \
+	FUNC(BAD_TAG_NAME, INFO) \
+	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	/* ignored (elevated when requested) */ \
+	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
+
+#define MSG_ID(id, msg_type) FSCK_MSG_##id,
+enum fsck_msg_id {
+	FOREACH_FSCK_MSG_ID(MSG_ID)
+	FSCK_MSG_MAX
+};
+#undef MSG_ID
+
 struct fsck_options;
 struct object;
 
-- 
2.31.1.445.g087790d4945

