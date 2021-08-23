Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD44C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF756137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhHWMOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhHWMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C8C0611DD
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i6so2206467wrv.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGvUj1X7+OJ3BO4VNd4j2yGyTEdbncVWEGKsZntaQ0s=;
        b=e0wKE+U39H5hmVbYXsgbmWPWU2GlnDZMqy5w0SEFw78p0bs5hckkM1SlC9lVAKVWWq
         IKHY7h0z2WLLsxd3FtSRFOOn0S4ILSzyVu2Zo3NJ2LwkHeuvWWIVzxWQwm09/BWm080K
         DANBS39RGuNQx0TH5fuVyL1J5swargc1kbBZKwWH/iVrKo2ih44n4ygmP8n/7+r4RWss
         PibQyXoBHYJBmQIinWPfE89l9WSyhn0VHECMJsb3JV1QG83ZUSMotEbuDQs6yRqBN7ts
         ZhVQaMEXLv7aSOi8/uschreGeOnpHquoGWdEGimkblyP0g3VqWPELCSaMTPYKuODtsOV
         5bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGvUj1X7+OJ3BO4VNd4j2yGyTEdbncVWEGKsZntaQ0s=;
        b=lb4zagmeH6tucvQfod+2YlXkuSdkEtsBwa3WFjsAWx4RYf0oNZUbG6gTIJcITanG5b
         2ZFdB1BkzIkml4mbqQVmLfjXFsDDKRbKIeuTXNsHXxV/P/fL4RSE8xyAjKodexgTAXkK
         ClCKRCSDTy2NL7KUVHO2M5lRPzO9qYUU5ko/YSDZ00YhN4ieyzntRJGgJZwfRa5AczPs
         uxDCBaPY+taAldCgpZshkfteCThLO5vnKkWRLmR/XuPS0i8COdw2/PnWNFhX5GQ77Tv4
         SR6MyY0Vq137eJBRY9vRxBih5ArhAcMyvWZwD+6yvLOPmi0cv4ilDJ4cLc84oQuhjNcq
         /m6A==
X-Gm-Message-State: AOAM530fVSKs3bMBuzyO9rJfJWakn3XkczGVzv300Js6oUvEEl6AwijU
        w5KUydnpa7gYGPvEhXdGTU7qbPNUxR/TEsVj
X-Google-Smtp-Source: ABdhPJzH9Pa1LSIUXPj/U26WhUHigE75zGFER8BHLMmnOo1cNon/9z455Z2ycdzhL8YCy7iOEgHdGA==
X-Received: by 2002:adf:f750:: with SMTP id z16mr13101872wrp.384.1629720795317;
        Mon, 23 Aug 2021 05:13:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 23/28] t1301: document what needs to be done for reftable
Date:   Mon, 23 Aug 2021 14:12:34 +0200
Message-Id: <patch-v4-23.28-6b62a8c52ae-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1301-shared-repo.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 84bf1970d8b..a5755b4a434 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -22,9 +22,10 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	)
 '
 
+# TODO(hanwen): for REFTABLE should inspect group-readable of .git/reftable/
 for u in 002 022
 do
-	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
+	test_expect_success REFFILES,POSIXPERM "shared=1 does not clear bits preset by umask $u" '
 		mkdir sub && (
 			cd sub &&
 			umask $u &&
@@ -114,7 +115,8 @@ test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
 	test_cmp expect actual
 '
 
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
+# For reftable, the check on .git/reftable/ is sufficient.
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
@@ -201,7 +203,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 	test_cmp expect actual
 '
 
-test_expect_success POSIXPERM 'template can set core.sharedrepository' '
+test_expect_success REFFILES,POSIXPERM 'template can set core.sharedrepository' '
 	rm -rf child.git &&
 	umask 0022 &&
 	git config core.sharedrepository 0666 &&
-- 
2.33.0.662.gbaddc25a55e

