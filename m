Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E2DC433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhLJMe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbhLJMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BAFC0617A2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so6536941wmb.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsSQv7yV3f1BLzog7Pz0aAeDAkApLfY5NLcOyaRwLSA=;
        b=JWO2MnroRKbisBFV7+Nen5GPe6rp3+w0sKXvP+OOiRZk2xRayFuGXv9Cl1WBxt4Vip
         bXKAmoCSnnlNLSTBq+cqP1Q0EkxVqwylWdNnjP8/WyjQfiWVHYmGrxLYZjde6Tal2j7e
         nKTd6Gi3AhddcBm5J0EzP2jcYkkmxqIUQxlJKYhuUd5D1r0S/V4SWxg3JxBp952UZwt5
         kAeU2CAKhuZR39WiHrYSHb3mSVdkK6GJZat/z/AHbExvpGAw6LkOsr/W3MwjqxA8mIXR
         qNjAznoBFNawCGOVppTILL3gaHGjBUD0AbOKs6rGPJWoTmYR2rmGkRVGpojlmPie+HPg
         XGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsSQv7yV3f1BLzog7Pz0aAeDAkApLfY5NLcOyaRwLSA=;
        b=Zri/GXiaX/8LvxgKsQ2SAYNLxobioOJulPVBpLsVqldpcjSLwtqdpnbyiL5w19SwKc
         v89He25KI6HaGqkBwvG//U0RmTuXpciRTuueSOj1/aig+0VB+vPT72fa2TGwfoOr4Emj
         gOLRiOaWd/FGm4y3pMQrAswwPK6ffYnzL4tQEElFbm45c0/NBSRUbSJeww26fyIetO/j
         Xv09clCCKnLw5iEU2jF3er8JYf4XHW+HdXr+oWu8e0S6wXNLxhR1EKnywB1QrHEO7fX9
         HI8GY8gZDx6IrJEAM4CmgNe4AA+WpmKfJT/ZoAg6t+nngyCnceMFje2O0hc/u53+Ovxp
         /Q2g==
X-Gm-Message-State: AOAM531C3mjKdcUI6x/qU8PwNViB/92mvDPVuXUWxPYXSNXBm4EEPj49
        FUdk3dAlsbFWv210OEwLxoMudEJWUkk8gQ==
X-Google-Smtp-Source: ABdhPJydVJ1mdupr2HPdY+44xsgFtvCkwlFcHDWeRSJE1GcUEPXEs3hriej1v7Zr5cDUBqItFQSdZQ==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr16262158wmi.46.1639139449891;
        Fri, 10 Dec 2021 04:30:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm11898982wmq.38.2021.12.10.04.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:30:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 4/5] range-diff.c: rename "n" to "column_count" in get_correspondences()
Date:   Fri, 10 Dec 2021 13:30:41 +0100
Message-Id: <RFC-patch-v2-4.5-f8bbe1954fc-20211210T122901Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for using the COST macro in linear-assignment.c rename
the "n" variable, it assumes that the "n" in "a + n * b" is named
"column_count".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index b2fcc6f66e0..b2e7db2c954 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -308,13 +308,13 @@ static int diffsize(const char *a, const char *b)
 static void get_correspondences(struct string_list *a, struct string_list *b,
 				int creation_factor)
 {
-	int n = a->nr + b->nr;
+	int column_count = st_add(a->nr, b->nr);
 	int *cost, c, *a2b, *b2a;
 	int i, j;
 
-	CALLOC_ARRAY(cost, st_mult(n, n));
-	CALLOC_ARRAY(a2b, n);
-	CALLOC_ARRAY(b2a, n);
+	CALLOC_ARRAY(cost, st_mult(column_count, column_count));
+	CALLOC_ARRAY(a2b, column_count);
+	CALLOC_ARRAY(b2a, column_count);
 
 	for (i = 0; i < a->nr; i++) {
 		struct patch_util *a_util = a->items[i].util;
@@ -328,13 +328,13 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 				c = diffsize(a_util->diff, b_util->diff);
 			else
 				c = COST_MAX;
-			cost[i + n * j] = c;
+			cost[i + column_count * j] = c;
 		}
 
 		c = a_util->matching < 0 ?
 			a_util->diffsize * creation_factor / 100 : COST_MAX;
-		for (j = b->nr; j < n; j++)
-			cost[i + n * j] = c;
+		for (j = b->nr; j < column_count; j++)
+			cost[i + column_count * j] = c;
 	}
 
 	for (j = 0; j < b->nr; j++) {
@@ -342,12 +342,12 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 
 		c = util->matching < 0 ?
 			util->diffsize * creation_factor / 100 : COST_MAX;
-		for (i = a->nr; i < n; i++)
-			cost[i + n * j] = c;
+		for (i = a->nr; i < column_count; i++)
+			cost[i + column_count * j] = c;
 	}
 
-	if (n > 1)
-		compute_assignment(n, n, cost, a2b, b2a);
+	if (column_count > 1)
+		compute_assignment(column_count, column_count, cost, a2b, b2a);
 
 	for (i = 0; i < a->nr; i++)
 		if (a2b[i] >= 0 && a2b[i] < b->nr) {
-- 
2.34.1.932.g36842105b61

