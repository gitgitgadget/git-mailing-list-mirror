Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CED5C4361A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A95664FEA
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCFLFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhCFLFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB9C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:06 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo828439wmq.4
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SmDMo8tF/8xs+LdEzQyhAMcNEwPNnJN8xKj4q7L4RA=;
        b=WuM+l4/ww0USiSUw+aMt324mmkNJOaDKYtm4NgKkYWI0D6arxfNrguWU8jAp9BNtg4
         PxMIRBV+cZQcs/lUM9f32q1au3YftzjpLOlhJ0M4K4qctjIXiBLk9pxvx6KQdODT674U
         GhFBQr0VND9mvcuD8jQThNbI7sUtVZBde0sQo2eS+x2wkMTcLITsEh1QBm8YMvSSisuC
         QFk4dwJiuC8W6oKrMaa4mBD0r/F9UPdhhol0QLsfWjA4umjtrfjTk1N435fArXg3DyX2
         wltr32BgYaItPDJdy3bHdFqyBFkY6OiWLECwS5jQtUtbXGSKX43uEUKD+TPJSQt8Jagv
         9ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SmDMo8tF/8xs+LdEzQyhAMcNEwPNnJN8xKj4q7L4RA=;
        b=Edv3cPavx6TvUbUGsWJFqDW22sxapmS4E+VEotSL2xnzrnOGhBVGLN1cYgcufFgaAk
         MSj+S8j1b9i84Z+F04/4GahBCOHrGYthEdwWPaup86zP9kKx6suiPuGglgvKM9ErZ7J3
         oFO4P/BLvyslL9t6zi+ZkxyDFWB7WG/BB1Q2COWTwfxqI6y7l+7fhG1K95+frI2/fUjd
         8voyMdCntzvGfOzWORJ8onZMEXXYzmcrx5EmT0TARNmHJ86U7mRF82EPMPvE3Dh9/RSV
         1OyrmXT9/93SlV6LvA5NjEUM99nWR+ahVP+V2tq7NtEgdMmT+n94+XVE5NonS4CkNpdj
         25Yg==
X-Gm-Message-State: AOAM531PuCTIgej0pyBwpm5IqNylPTs1y+QGU3siii5ru9CJHlAiS2yQ
        9MYdT9jTeesXSGaxvCiRS54NUJ1ac+7MnA==
X-Google-Smtp-Source: ABdhPJz++QEIdG0s1rixYZ0DUzhNljPNsFCWrtnw5bO0LHfmALyrKPM3d2AlYzZVBue7pp82BRtK7w==
X-Received: by 2002:a1c:318b:: with SMTP id x133mr13199433wmx.154.1615028705115;
        Sat, 06 Mar 2021 03:05:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/22] fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
Date:   Sat,  6 Mar 2021 12:04:33 +0100
Message-Id: <20210306110439.27694-17-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
index 6fbc56e9faa..8a66168e516 100644
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
index fce9981a0cb..c3d3b47b88b 100644
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
2.31.0.rc0.126.g04f22c5b82

