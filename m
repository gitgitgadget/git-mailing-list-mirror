Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0DAC2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4792467B
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csP68ywX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLSWVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47047 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfLSWVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so3190324pll.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SR1Way5k+Wj+6Ue6ejt0y/lCWjpKuXZoBOUBpag+XqM=;
        b=csP68ywXsTzWE88I/Ly7nHCH/3SDs1R1D5hqSYCHSkNagFZq9HPKmvhyLC0pmpX6GO
         QL8ReUZwLGi/QO+xMJf8lwKXGEsSHLVD9d+yZj5IqfDrefz6Z6N+snhGnuHSjg86rYP/
         BYRYyNlgRS6C/VrV3JwdXqbLAbDa4bX/MoXbGDuBYuvke1psYIiThFwLATbt7oCm/+vH
         H1s9UwGvg1dAuQPKXo+8NDD7Mtf8brrsEhksJTYgLUEpmwuBYr6PLNORtJxjTRoEEnsr
         JI9DDhLVNzec11bX1mb+7f9vxGH9VFC/zUwlTWrcQABFApIvOfhRYvwsfFrp9zyJsoUj
         sPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SR1Way5k+Wj+6Ue6ejt0y/lCWjpKuXZoBOUBpag+XqM=;
        b=ZaeI13Ig1fJsVrU4fT+i1fs5VGOvhrkM4mQUVlWO/4FVrBIV2Y2ZfA+tbiqk3qh2di
         /2MHMdWhKgc/VfZ1PbSrbkGaeWBO0rJSAnUgzuaexxzfF1XMnMSXNNG+wuiNBfR+w5JJ
         PZvExdFOVt9NvLcg+9wa6F9mGJftol066rpOdoZAX8eAZNY9my36g9SrAdvR0K1rB1Yh
         n7KHZFj5nb7n8SukoWv88G5r3tG/NQcaxRiSrln4swOLCOBmVvqsc5aqo3buJScOntp0
         4yfmoGNikgybBBnX9DsSrq8Va9IcQMxpouPTyWDouXVEaWbKKRUolk7jOej/+DBO87Bt
         1ZKw==
X-Gm-Message-State: APjAAAW04rN+aorxYHsATDI8sV0qVsgxXs38FwS2Gbwfw4CrtF+6/Hhu
        ZjrdbLld4Iqa3fFEsTMHbHDbYqQw
X-Google-Smtp-Source: APXvYqzd1m7Ok+5JmIyvr/LgCYokMUWNiEmFPqunHTMohmKbvnnxiuc7Tq++XieiV1uXOfrEaj13mw==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr11667197plt.332.1576794097263;
        Thu, 19 Dec 2019 14:21:37 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:36 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/16] t/lib-git-p4: use test_path_is_missing()
Date:   Thu, 19 Dec 2019 14:22:37 -0800
Message-Id: <3d64837af1bc2af972ae1415502bbbde26ee3784.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, cleanup_git() would use `test_must_fail test -d` to ensure
that the directory is removed. However, test_must_fail should only be
used for git commands. Use test_path_is_missing() instead to check that
the directory has been removed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 547b9f88e1..5aff2abe8b 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -175,7 +175,7 @@ stop_and_cleanup_p4d () {
 
 cleanup_git () {
 	retry_until_success rm -r "$git"
-	test_must_fail test -d "$git" &&
+	test_path_is_missing "$git" &&
 	retry_until_success mkdir "$git"
 }
 
-- 
2.24.1.703.g2f499f1283

