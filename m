Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B377DC35263
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EB121D90
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO7dG8ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIQHpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgIQHol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3158C06178C
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so693835pfd.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwgGylpO7ks+X6wOeUVcLzhd8gOOrgR17ZYrOeA7Dtw=;
        b=jO7dG8ceY32uRTa4w6IeYKQWIEBsSIylXXg6v2GKx5DVfSHX1szVUhaI2GkjCmr/UE
         v4c6c/VeP5OgPXVaUdYhUI0I9Pm/XvMBEjHwXxefsmkqgb5RMBMJ2nncSIZDAE80E5JM
         RT8RhIuoOuZBoUDxGecQCCOnFPV/uIFHl1wruXSZSO/md71v27yJtjdMwp2rq+4fdjoy
         p70/ELJ5hs0mhXytYq/bL3jxgaJenHUtDWWl4zmDCLOxPy+za48BbnwsTlzpMwg0Ef4j
         0e1i343AV4q5BAKbK2mDtDHS0JnPoejDeeJVbDvJIuph/b5ya4rzb0tG1JZV5GgRlUEt
         LG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwgGylpO7ks+X6wOeUVcLzhd8gOOrgR17ZYrOeA7Dtw=;
        b=o7SXdEmPoVSAUnmUFSzEwAKdgIhbR2YvHi5M0tgbHaXUW3A/YcUnm8WlmTDz+ZKcBY
         GwbWD/E5GbkOirJof9lZwT1+1Z+Hnp6ddi8mv1A8TffZmZSnB0CCg9snlPQJrO6/SWCO
         hxsNbEJSa+/KKxbKoR7qDGzBaLeD2Y8sFqjD0EsdoJ0yva14Emc+iFoKrBk2zR8pyjoI
         L9CXkXsNKlvAliTElKkQIIzhrNcXKjGL65Bq4jYZ5rC4QVDHPs14eigT3Fnp15rezPO9
         griYD82Z3ZXkP8Jztqhae54zR2Ex+K5k/ZktpvKGLTAZmD4UuRt2jOppwLC7p9thVL6b
         2tqw==
X-Gm-Message-State: AOAM532v2UtV51UjMMNvPV4VU7jIf3thJChx2YYVg0BD1iwVJXVGRRAD
        iLTjGlzOIozxyftmrfGURzoD2lBTxsKGKg==
X-Google-Smtp-Source: ABdhPJymHzSpyMYxiG23Gp5q5PuV1i8kWVyPRp25FKAUrsi4CTDXR3daqAvlsRWsl/rPAyu+3T6C6g==
X-Received: by 2002:a63:4746:: with SMTP id w6mr21851157pgk.412.1600328680134;
        Thu, 17 Sep 2020 00:44:40 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:39 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/10] t4068: add --merge-base tests
Date:   Thu, 17 Sep 2020 00:44:11 -0700
Message-Id: <c9225a04404f1e1aa0b5146bddef77ecca69ebe3.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we will be adding more --merge-base tests to this test
script. To prepare for that, rename the script accordingly and update
its description. Also, add two basic --merge-base tests that don't
require any functionality to be implemented yet.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 ...ymmetric.sh => t4068-diff-symmetric-merge-base.sh} | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
 rename t/{t4068-diff-symmetric.sh => t4068-diff-symmetric-merge-base.sh} (86%)

diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric-merge-base.sh
similarity index 86%
rename from t/t4068-diff-symmetric.sh
rename to t/t4068-diff-symmetric-merge-base.sh
index 60c506c2b2..bd4cf254d9 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='behavior of diff with symmetric-diff setups'
+test_description='behavior of diff with symmetric-diff setups and --merge-base'
 
 . ./test-lib.sh
 
@@ -88,4 +88,13 @@ test_expect_success 'diff with ranges and extra arg' '
 	test_i18ngrep "usage" err
 '
 
+test_expect_success 'diff --merge-base with no commits' '
+	test_must_fail git diff --merge-base
+'
+
+test_expect_success 'diff --merge-base with three commits' '
+	test_must_fail git diff --merge-base br1 br2 master 2>err &&
+	test_i18ngrep "usage" err
+'
+
 test_done
-- 
2.28.0.618.gf4bc123cb7

