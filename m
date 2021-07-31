Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0AC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425E860EC0
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhGaCmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGaCmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9854C0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d9so7809448qty.12
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QR2byZ0ioJNuyLLImqT1+1HcGOWnBsSGex0fWFBzfts=;
        b=EpmqaZ2BW+K8CdU/ltqTsODRuf4srlkVSGNTPHJ6qIyXDXibNZxJLrz9wXT9Rgf6K3
         9NCAMLlxX82/sTdBc+Ugs4/LKJzT5pOKJ2X9pxAVBHzfbtNwqv43uEO4wFMgYD8ebiTI
         CKPzcOOway2DUlhOM6biT8EttXdEWvXHTvbsMTmP9/o9V22h8VCPxflxaWoskzJ5giWI
         7x5hW5oINV9cOOybuIqJLoznxdMGfqpwDrskmcb40L7BRIrASRv2FbnRmkFa2pChGazx
         UjjJxS3CRp6Mxp7SaJXyEY0tp3z6nTdfdi7DVYhek5cMUzab+EDUyVbsttIirITMAsAU
         +2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR2byZ0ioJNuyLLImqT1+1HcGOWnBsSGex0fWFBzfts=;
        b=R2CkrST2lnq8LeDFSoyepqpJSADHBzMe2IjQTINoflq38c0JM9kToBfuD01h9CjlpD
         B35qNtITUsiHNplL6yr5Qz2kh1O7In4y3WTyLUG3HqPHmXJWq2a36NGP0/6g/4ELjjXc
         ok0VpLJZYsnuJSKH/cwW3jrOP/VPdAnXm2RQvGioz4DzdhFLtGI4l9r64jxs88oO4fK6
         Ny9D5fipL2T9/FcwoE+02kSFdKkt2tA53uk9PkDjKoa2OLn9tAQ+cSEmMQhJKEjF2aFD
         EuAZxbg6ux5qfo9gaPWg335c4az0KY8mEy/P0TnxNlnTUzVNPzZH1BY+DMoaOh17ROUQ
         64WA==
X-Gm-Message-State: AOAM533I04Ls62Z7dfb4k5t7lHz8KpIY4z1lQ0f2QP8QiVEnaHssR/95
        A/3/scg02YdVViIXJeEtcsQlX02HGu4g+A==
X-Google-Smtp-Source: ABdhPJzPaZzrFndDRFidalI0/fHzGwgn0/EMXZMnRoUXBQRLH7G3CZNeJLhf1FGvjIzFL/JEIr3ZXA==
X-Received: by 2002:ac8:6611:: with SMTP id c17mr4986300qtp.392.1627699349906;
        Fri, 30 Jul 2021 19:42:29 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id d25sm1452881qtq.55.2021.07.30.19.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:29 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 1/6] branch: move `git_default_branch_config` to `branch.c`
Date:   Fri, 30 Jul 2021 22:42:16 -0400
Message-Id: <20210731024221.2113906-2-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731024221.2113906-1-mathstuf@gmail.com>
References: <20210731024221.2113906-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows branch-specific variables to be tracked locally in
`branch.c` instead of globally in `environment.c`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 branch.c      | 32 ++++++++++++++++++++++++++++++++
 branch.h      |  5 +++++
 cache.h       |  1 -
 config.c      | 30 ------------------------------
 environment.c |  1 -
 5 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..1ef52db89d 100644
--- a/branch.c
+++ b/branch.c
@@ -9,6 +9,38 @@
 #include "commit.h"
 #include "worktree.h"
 
+static enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+
+int git_default_branch_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "branch.autosetupmerge")) {
+		if (value && !strcasecmp(value, "always")) {
+			git_branch_track = BRANCH_TRACK_ALWAYS;
+			return 0;
+		}
+		git_branch_track = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "branch.autosetuprebase")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "never"))
+			autorebase = AUTOREBASE_NEVER;
+		else if (!strcmp(value, "local"))
+			autorebase = AUTOREBASE_LOCAL;
+		else if (!strcmp(value, "remote"))
+			autorebase = AUTOREBASE_REMOTE;
+		else if (!strcmp(value, "always"))
+			autorebase = AUTOREBASE_ALWAYS;
+		else
+			return error(_("malformed value for %s"), var);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
+
 struct tracking {
 	struct refspec_item spec;
 	char *src;
diff --git a/branch.h b/branch.h
index df0be61506..801ff25f92 100644
--- a/branch.h
+++ b/branch.h
@@ -17,6 +17,11 @@ extern enum branch_track git_branch_track;
 
 /* Functions for acting on the information about branches. */
 
+/*
+ * Parses branch-related configuration options.
+ */
+int git_default_branch_config(const char *var, const char *value);
+
 /*
  * Creates a new branch, where:
  *
diff --git a/cache.h b/cache.h
index ba04ff8bd3..6ea1ea5854 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,7 +1030,6 @@ enum push_default_type {
 	PUSH_DEFAULT_UNSPECIFIED
 };
 
-extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
 
 enum object_creation_mode {
diff --git a/config.c b/config.c
index f33abeab85..840be51710 100644
--- a/config.c
+++ b/config.c
@@ -1574,36 +1574,6 @@ static int git_default_i18n_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_branch_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (value && !strcasecmp(value, "always")) {
-			git_branch_track = BRANCH_TRACK_ALWAYS;
-			return 0;
-		}
-		git_branch_track = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "branch.autosetuprebase")) {
-		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcmp(value, "never"))
-			autorebase = AUTOREBASE_NEVER;
-		else if (!strcmp(value, "local"))
-			autorebase = AUTOREBASE_LOCAL;
-		else if (!strcmp(value, "remote"))
-			autorebase = AUTOREBASE_REMOTE;
-		else if (!strcmp(value, "always"))
-			autorebase = AUTOREBASE_ALWAYS;
-		else
-			return error(_("malformed value for %s"), var);
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
-}
-
 static int git_default_push_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "push.default")) {
diff --git a/environment.c b/environment.c
index 2f27008424..5d45152731 100644
--- a/environment.c
+++ b/environment.c
@@ -60,7 +60,6 @@ int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
-enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
-- 
2.31.1

