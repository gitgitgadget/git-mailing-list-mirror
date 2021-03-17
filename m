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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375DC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4EA64F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhCQSVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhCQSVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so2834209wra.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UH1WJ+qdg2KSq2/MhZ8gfhLaVf5mTg3uZPIoqOb3gp4=;
        b=jKBdkRBsZzi55LXTf/24FSJ+969mp+aIZ9QA5cc5euosayMMMflJ2SoiHR1+gd02vq
         crQwc6T8gowSN3cFbaOXHxDdz+c411sTaG0DvPH6zjfYHz0sWwHjzCbN7RsKWoXp/SQs
         87CxkKFF9uMLvlx/QjDJEYbPxnjJPxowXz+FbRRNSLwCsm+aPazm5aavCp7xsH5dENUl
         lQXglOgr/MTKs+3ca09Sinlr8oumDBhU5S5a41KpS+YBg/6z66dr6zlE42Ctpy1CDnJX
         Usi1jU67p1ZVwrkh2mVIJy6p94hedvii7SZMm6QMae0PiUfqC5phFKuSVL1jsUVmZQhU
         RpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UH1WJ+qdg2KSq2/MhZ8gfhLaVf5mTg3uZPIoqOb3gp4=;
        b=tKOU7gl067bpQY9PPRsgolE06moue81NE3AUnYFS5aC8TWkr5DouGXW1bsE1yk+k5d
         sfK+becxYKUnkseqhjEhk2b2F/o3Fz/+jK97VgVyRzpGsKFzSLovBh68y1boM/dH08jd
         ofnH1kC9GkrbNPSuOHI3TvfwkD/9jFoX/SIiOSdZ/AlI0PDZsVjEXchT92fHn4Q5yq2+
         cRYgWNbuRjgsbYrOuOzdGHfSMws2mvVZ27YED/i1NgRNppF1g9kHs58i2/0Z6e6oFNuq
         TkIVLgwGc4YIoFOXbHFb0MIk6cIZ3ThgJDleoyQo79yZzDISCS0eT6etJL3E98PYBFWm
         o28w==
X-Gm-Message-State: AOAM530IcQgbcKN3mksXmzHJbhcilKpHEGBWbjlApRFUmJA7sSkjHHVf
        HuFR3ISPQOzFRaeQfAkzigqotgBhtaxNCg==
X-Google-Smtp-Source: ABdhPJwb48kJw0uwMqQS3cd5ru1XNxR44CNxHFGcUZObLXJRnvmveI4dC7KIGAL89QzBuB3W49dWtw==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr5781429wrz.74.1616005280814;
        Wed, 17 Mar 2021 11:21:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/19] fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
Date:   Wed, 17 Mar 2021 19:20:48 +0100
Message-Id: <20210317182054.5986-14-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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
index b64526ea35..49208ec636 100644
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
index 25c456bbd3..7c868410eb 100644
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

