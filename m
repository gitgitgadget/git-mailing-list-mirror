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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600AC4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C867E65119
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhCPQSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhCPQSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F77C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso1797495wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86wOUpqgY1AI409imnR0FBW39DXCAtH+DIkXM2heYs8=;
        b=iIVHce+u1gvFzm3Ulr+oRQHjgmvXISdW+xk6G0g9fyNKAnJO/C5p0atwBYIPlJ6x4b
         mLsmtNAbuEf2ZzjFU04tyfhexrID8Ou87GqCLPmGC7485/ObLne5E/GG+OXgUJYGzmkn
         oFxMKPVKFojt7K/R1Au6cgw+mApWydEz4MDF67ajyYnVqfoMJOZVHcv1KEIkS/p3+777
         2BrCVdqhQ1ommmfCS/cDizsYz3FmR5ytQrutqJN/bMMncqCcHiHtQ8IoPfgXp8+Hws8q
         8vMGSNxGiuYwKS7RSn+3B0dMrElmUXJc0+n9KuenGWpPtqp7MKo70SOdlqHd4bx9VWmo
         VVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86wOUpqgY1AI409imnR0FBW39DXCAtH+DIkXM2heYs8=;
        b=EVmslPCaUuuzM/Pw0FGOOwedR7nIpQ6H0+04+mhpPDzZ10FQ/7CREpaij1DofH2Hhm
         9aNFIbdRVDKG3amzA/0tHqZ1xdhevmhCZu1XLhv6KW39dkvniAMTfnzgXbleyu+M7UW9
         CaTKTVN8lKZcaafV5MTFNkrHAA7HlzPi5M0n+a9sYYKU1hPq2vq4xOmL5adUlrIH7JZd
         dgS1wf+k4sXgjrqeu53z3qIsrU+ogc/uelfA+VSmgSEI7dGK2qn32EH6X0IhBl6dQ9G2
         HzOnv0LuU3sC/SEJ0IpjRIHUNBv0rTicqoZIXzPeYxcJtOQs6IbiO//a5PZL9sjf/EZS
         R+mQ==
X-Gm-Message-State: AOAM5318Bm/ddPu9WlL/OxH6sSHg7OJSBq0V8JW4Lcp63flw4BtvLx+y
        gePdNJOuwn+9fYhdwxzHgTAOFLGjriFh7Q==
X-Google-Smtp-Source: ABdhPJwWtFgi8zgyn4Qt65+C4xWPQE0UcS+Ft7Tkg+NM4EdWhZI664Cp92v2OiCOpzkyTuEkYstZhQ==
X-Received: by 2002:a1c:e208:: with SMTP id z8mr361330wmg.111.1615911487739;
        Tue, 16 Mar 2021 09:18:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/22] fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
Date:   Tue, 16 Mar 2021 17:17:32 +0100
Message-Id: <20210316161738.30254-17-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index 6fbc56e9fa..8a66168e51 100644
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
index fce9981a0c..c3d3b47b88 100644
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
2.31.0.260.g719c683c1d

