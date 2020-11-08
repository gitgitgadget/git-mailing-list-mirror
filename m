Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF5C63699
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97D420656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9PM34QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgKHVlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgKHVla (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:30 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CFEC0613D4
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:30 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y25so6928954lja.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BverbUAkP36+LGnu0GHncDk3ADsANENXDrz9A+qMhKE=;
        b=a9PM34QKeEX6cqAI2elKJ7w2zLVMylu2uHwY9qNb1umIHFAc9KYny4A2VZuwNyW5bE
         HBEcZBG22bINXHYjF49dvAaSAOmOtq36n8cKNi+Sr+9Np9MYUkjr7bnCBbdQewFYS6X2
         F8COF+AGiHkzQEuvVPbfcqEBR/7bSlOT/qgLoCCV5cRtRzlO36dQQNeM3rTDgcRBWah1
         fSDRN2BQD2a5wyHTlTlG0nXcp8t4Urwf7cTXnE1uCPiPExfBttQnd7nC7hM8k5l62FX+
         YeQR70sbJ2+djkzoVHn4fK8jwO1RkUvZODixKQR1F8A7LxCDPM8LA5NXSJhN/FJ3Zdmp
         OevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BverbUAkP36+LGnu0GHncDk3ADsANENXDrz9A+qMhKE=;
        b=YRuhsmHEaahlirFesFGm9O9EGJkA0WlDFeXCWsm5JjGNgW1U2zXLPcQbWCvyuC+gYU
         nDhjkvsfNf9rCV8Dvm2k2bY2cTNpb+HcG92InzkLvyvXtsgNUXaoysDje+iVxGlHwfHV
         6SLxcBFjQ4nFFjhjaSrEiAMoe7giyErKwgArsC8fGUoBfRPXKH7/9NqnT4ilYTTnrfY3
         rcji0HVtms6S1Apy4SEKHaYYvZgyN8Kb/08mUnFR7SmEcZJ16sBorUPNLQUztGVefyqU
         JuWETlwkSUN6M/8bF0bjHZYW6thRfKtOf7tmfQZBFbsBopUc2FiLP2/X+WSgihXbjaNh
         nAgA==
X-Gm-Message-State: AOAM530srJcuA0a0VFnCYaUBbGK7qrdDSVWzTbR3DqggUdh0g2jIRlE5
        k6uje3rUPwUcoc/RB9XzymU=
X-Google-Smtp-Source: ABdhPJwQneY0KPig+hti+ILgACz4KXAD4JbY4atCAr8kFJYNZVbsGakesPfqv6gfcVeWH6eIG7gaYA==
X-Received: by 2002:a2e:b619:: with SMTP id r25mr5131752ljn.465.1604871688641;
        Sun, 08 Nov 2020 13:41:28 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:28 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 09/27] diff-merges: re-arrange functions to match the order they are called in
Date:   Mon,  9 Nov 2020 00:38:20 +0300
Message-Id: <20201108213838.4880-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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

