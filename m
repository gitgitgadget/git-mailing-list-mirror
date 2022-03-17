Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91876C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiCQSKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiCQSKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64412C6E2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p9so8438821wra.12
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0k8nEPsjImGLJAhZ9MyoboZ86eZ8kNukohoS1X9Hlc=;
        b=FZbtB6hTJa5duZxtAcFpfjAcotClFowJwpQNBBeiPvzcSoUl3qL15KjUr2gePfVzRC
         ePMXa9/WhVr/Whz6Iudk48TBnj9nv70CsN3uPaZoJ6wfX1YHIgpW5wdsn9kf7d/awQ09
         u0HIbaf19CVCk7s+rTldouI9F/jAUaaIzzBaJ3tlaYuzM2wz/mN/7zEqFzUhu6jaFw6i
         vCSKprJNmbj0xYSgTJ5+kCnX9P3Cf0U1hrZ7pcTzYuDx1ZK8P9YyX+o35wYZZhKH+qZY
         BJP6Yzjzas1dBpX62RnXAoWmYW8c3VToG+KBVJOP2fVu9Q0dE2rZFllbb7OzI8EpBd1i
         TfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0k8nEPsjImGLJAhZ9MyoboZ86eZ8kNukohoS1X9Hlc=;
        b=K8Bv7xAhHz4CIUItjmCOqnhsDNt5UagloykD1LbgwO6IJSZqeoCb0wxSwIMxQZYVj+
         3IhkNiOMIG8HwKq/BxP1l1y+yCzXBSAaDN5VUfiYLwH6Y3Tjfu6Ma5vU0QKZf1OuHUYj
         iLAx0VAWLaHMAqbcrG3os44AgvzfMHgWC8//a6j03W5kalymarY+jkQqWSEqnyPCaeP6
         VIVbA4/+q8v6TS/s3MPNEGq+ZM0COwxj6q4IZxPtyXSX3ou6faig861TOSVv1g0j+A4A
         ZOacoRqnAzsUWmhOSy8KXbe38j0wiJ9t3dIFXXiLRgcY0yl4a1NrbK9PXNHpOoHMrIu4
         LHkA==
X-Gm-Message-State: AOAM530kLDBnB/gZVtKnIl01BXBUxXQj1+4dXB/dwVkc7Q+htjKz/z37
        ooZAp/JfFQkVA6OsFVNoK4deWiJGS176gQ==
X-Google-Smtp-Source: ABdhPJyfAKP5F5ZZ39rjMnQUqcPeYQ8t9/zqbRNsbDSfzw5pwvldExCH9ln2bzCgUz+lnwyAJgVLSQ==
X-Received: by 2002:adf:fd44:0:b0:203:f45f:ce92 with SMTP id h4-20020adffd44000000b00203f45fce92mr666807wrs.45.1647540538190;
        Thu, 17 Mar 2022 11:08:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] reflog: move "usage" variables and use macros
Date:   Thu, 17 Mar 2022 19:08:36 +0100
Message-Id: <patch-4.8-f54f1ea3118-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "usage" variables in builtin/reflog.c to the top of the file,
in preparation for later commits defining a common "reflog_usage" in
terms of some of these strings, as was done in
8757b35d443 (commit-graph: define common usage with a macro,
2021-08-23).

While we're at it let's make them "const char *const", as is the
convention with these "usage" variables.

The use of macros here is a bit odd, but in subsequent commits we'll
make these use the same pattern as builtin/commit-graph.c uses since
8757b35d443 (commit-graph: define common usage with a macro,
2021-08-23).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c864f276308..25313d504a9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -5,8 +5,31 @@
 #include "worktree.h"
 #include "reflog.h"
 
+#define BUILTIN_REFLOG_EXPIRE_USAGE \
+	N_("git reflog expire [--expire=<time>] " \
+	   "[--expire-unreachable=<time>] " \
+	   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] " \
+	   "[--verbose] [--all] <refs>...")
+
+#define BUILTIN_REFLOG_DELETE_USAGE \
+	N_("git reflog delete [--rewrite] [--updateref] " \
+	   "[--dry-run | -n] [--verbose] <refs>...")
+
+#define BUILTIN_REFLOG_EXISTS_USAGE \
+	N_("git reflog exists <ref>")
+
+static const char *const reflog_expire_usage[] = {
+	BUILTIN_REFLOG_EXPIRE_USAGE,
+	NULL
+};
+
+static const char *const reflog_delete_usage[] = {
+	BUILTIN_REFLOG_DELETE_USAGE,
+	NULL
+};
+
 static const char reflog_exists_usage[] =
-N_("git reflog exists <ref>");
+	BUILTIN_REFLOG_EXISTS_USAGE;
 
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
@@ -147,14 +170,6 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char
 		cb->expire_unreachable = default_reflog_expire_unreachable;
 }
 
-static const char * reflog_expire_usage[] = {
-	N_("git reflog expire [--expire=<time>] "
-	   "[--expire-unreachable=<time>] "
-	   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
-	   "[--verbose] [--all] <refs>..."),
-	NULL
-};
-
 static int expire_unreachable_callback(const struct option *opt,
 				 const char *arg,
 				 int unset)
@@ -304,12 +319,6 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static const char * reflog_delete_usage[] = {
-	N_("git reflog delete [--rewrite] [--updateref] "
-	   "[--dry-run | -n] [--verbose] <refs>..."),
-	NULL
-};
-
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
 	int i, status = 0;
-- 
2.35.1.1384.g7d2906948a1

