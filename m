Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC2C4741F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FCB2225C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyc0zU99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKATeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgKATeP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42488C061A48
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:13 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so14659291lfc.7
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BverbUAkP36+LGnu0GHncDk3ADsANENXDrz9A+qMhKE=;
        b=Oyc0zU99Z6IVcy5OG1jTWL0SWaEHcuSzNVXMydmrywL4TJ7TUA9w+cwZOaRkAWXQ6f
         kkZgVroGK8QG/scqh86Jwe7Rupxcx39P++OSKRKTW/HBU3wHoQaw0LttOmb2/WSyIJ96
         4nfpRNEsBWVBLVIQ7ly5RVumR47R70ueVZVyARL8CI7vYxx0DnkTYt8Xm6iR7MxtLClt
         JlfqrmgNj/rk8QKzjZTe/QFjzZABX+z2giLrdpRAbESO7XeYfq0Wig/OejpqDOl03KSl
         iHbqCM34SOxR+zwcUQMgL8x8rWtUGZjW3/H8PlrMLMBXE/cOG30i7/vniPR+AFnTfS5u
         x9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BverbUAkP36+LGnu0GHncDk3ADsANENXDrz9A+qMhKE=;
        b=e1JeK0uky8KhLMhA81WzSMn6vusdgsMnz87AHFpYX1RGMENwLiOPkRxs58AVz+Zqa6
         3rQHIlM3k3VGLgzZB0UaRc5p3NuN/QZqDC3wkCEKa9EkfNqD0N83vJbXbOKuWdgqtTwt
         iXLyuSb8ieV/d1DaS9Ut+2rOxnVtx3EPFNUnd+GweP01F6EhltpZHeFtobUBXgCMq8W2
         L0bNb+cTUXaKNCyDSAeh8RnXqXU5hA74i0Lmv1NbV0sNfBPYWL32usqTytwQH7Xy9OX6
         3D/vZ+y9czq5ARwpmC/9vZdn+2z+C9ZTxyBFS320fkLH2H/eTGZfamOcdydVumtcCkPS
         CvCQ==
X-Gm-Message-State: AOAM533NJxHaQoWJ5tVy786EM3xfA65cbwWTRPzwzyTO+rOQBCIlPosX
        FLAWQVYyP3Vvto2eOBERjZc=
X-Google-Smtp-Source: ABdhPJyPVzSE3m6c3cpYfC/QlAhw+qJEua+TboxhVtuyqqVafAHO4NLLNP4JewVCnq7CPsnfcckdtQ==
X-Received: by 2002:a19:6b0b:: with SMTP id d11mr4856681lfa.295.1604259251821;
        Sun, 01 Nov 2020 11:34:11 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:11 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 09/26] diff-merges: re-arrange functions to match the order they are called in
Date:   Sun,  1 Nov 2020 22:33:13 +0300
Message-Id: <20201101193330.24775-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For clarity, define public functions in the order they are called, to
make logic inter-dependencies easier to grok.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 24 ++++++++++++++----------
 diff-merges.h |  7 +++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index bb08a92e3b36..8536941e0b56 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,10 @@
 
 #include "revision.h"
 
+/*
+ * Public functions. They are in the order they are called.
+ */
+
 void diff_merges_init_revs(struct rev_info *revs) {
 	revs->ignore_merges = -1;
 }
@@ -44,16 +48,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	return 1;
 }
 
-void diff_merges_setup_revs(struct rev_info *revs)
-{
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
-}
-
 void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
@@ -68,3 +62,13 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs) {
 		}
 	}
 }
+
+void diff_merges_setup_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
diff --git a/diff-merges.h b/diff-merges.h
index 20b727bd734f..4b023c385d00 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -7,11 +7,10 @@ void diff_merges_init_revs(struct rev_info *revs);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
-void diff_merges_setup_revs(struct rev_info *revs);
-
-void diff_merges_default_to_dense_combined(struct rev_info *revs);
-
 void diff_merges_default_to_first_parent(struct rev_info *revs);
 
+void diff_merges_default_to_dense_combined(struct rev_info *revs);
+
+void diff_merges_setup_revs(struct rev_info *revs);
 
 #endif
-- 
2.25.1

