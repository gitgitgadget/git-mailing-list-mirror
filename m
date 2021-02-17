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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0891DC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB01A64E45
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhBQTo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A829FC061794
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id do6so13900757ejc.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuIYzRSGitAdsT6HIXKE4maNWma1eEAs9VfuEa76VbU=;
        b=CeU88Xu2UtFVhqVvVxZiz5FHuIarWnybO6TLr87yj/oSzMD2rDcCFvC/vg9aHulsEB
         WVa+1HYQMco6f8lrGdKu/FLVoWK+v73FPcDPQmhZTuRO4cMFEJUjQFydyuoz4FyXSuir
         f2PDgIs1k+TZGg3trqPAfxPZMwERkYHy/ZnjNrUeDFq1fze4EUF2ckRzkcjuqaonEkKW
         M2+qVbKaOQYLeCT+p6YpRvmB00dbO+bfRQvS2mAEd6IULvp4Ss7J/p4BAMsCSnlZyMsY
         VJ649BtIIpB1YysasSXFeigfa1j9X0sv9++b3GW/5JWq7sNBtL3PZzgITiZ+q5op1K2a
         nXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuIYzRSGitAdsT6HIXKE4maNWma1eEAs9VfuEa76VbU=;
        b=NbZcajbBsioY+akOixLWK0MW7R7BHW2P3H4F4rBL8mqRAZtsE0zvUfK9Ls3yPNYh5l
         cYkvHpQR86SP4m/wuZGABpESyQIFrUj65PzpclKsB54of4vUmyQlcz2oFtsKa1V9EiPs
         XYnfSVDRUYQ5CUROuckjojDopstQumkficAh0yXarhubEzn6o2GqifC1pEzAmqHbYH1e
         6uQSmndCB8ZlU5cbvWjY7GZi9Qo3aZxff4S5cWgeeFBZj/lzYYcdEiYbooV9Mv4a4uMN
         IbGSCtX7M3A8Z7Ej3Bw8wYN+Nrk+UyzT8WS381VKqrDCB38rEdUVwTwLD+Z0i5z4/XwU
         xx/w==
X-Gm-Message-State: AOAM533Vw5qdmJdRAvSrx/Mu/oH+NmiB7xugw7irkA/3Rlj732S8yJFY
        twuXaS7K9oE6y2uC+Kah0Sk0/pBl0paWSw==
X-Google-Smtp-Source: ABdhPJycEj5TWCjMPoMthNaUsGAbMNK2JnEkowuQoTw6kviioWHnSleHuDbR6D0T6HyVumBBNhJy0A==
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr514842eji.153.1613590991067;
        Wed, 17 Feb 2021 11:43:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/14] fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
Date:   Wed, 17 Feb 2021 20:42:42 +0100
Message-Id: <20210217194246.25342-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
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
 fsck.c | 66 ---------------------------------------------------------
 fsck.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/fsck.c b/fsck.c
index 1730acd698d..980ef2cb8fa 100644
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
index c77e8ddf10b..b4c53aaa08c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -10,6 +10,73 @@ enum fsck_msg_type {
 	FSCK_WARN,
 	FSCK_IGNORE
 };
+
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
2.30.0.284.gd98b1dd5eaa7

