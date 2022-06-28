Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02584C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiF1KGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344723AbiF1KGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE402EA30
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k129so5621029wme.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unuGGN27MGn/Pd8qliKYczAijAiplWFLo+NCfdXHqHg=;
        b=fQi/8eprrqsls9eZTUrAj1gs7HXMgoCDo2NSYlfT5RQoOOSY6M2wTJKqrRocExpdoh
         KTfioJmQ81vOxXbhOpLzM1CepW1k15+JWwGWqco/s1dB41ISmvIJun2CFCofYUwZMlHG
         pQLDM4vCfjjFa/0OTax0xC9L1VoIafBHzZicfzHXLephX9h7Ygu1hpGkImQjdLDBi907
         wf6VvnkIdaIsKD+ztSXnsmunhTEKVBl5BAcntGKvds8KrKQzoWaDN5nQdtbJXHw8567/
         RlmErImDcj7RwWWn41ZqBa8TEM0drcYZu08AsTl1j0sOoENSMDnU+u60vHEvoBq5DMQz
         tp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unuGGN27MGn/Pd8qliKYczAijAiplWFLo+NCfdXHqHg=;
        b=hEphu8Bgf76HDUCEpYZfCZFg5Dl9nhm5H27Xvg2ScZUJUDcJILsRRG01pFiHriiCCv
         ovls/NQR5cA4vsxmlWwNFeJK8pED6HsNJjPE6s7w+iAmbS8JEgYmhvoPFDw02/l5FrQy
         opUzpwxrEdO3U8kUccNgnpN08yLEfjp+/Z4d2rQE65kBAtBCrY+93bKt/nU1Ct8JTszC
         BLuYY6+O+kLmACwrLiii8qqNe3AbEAixul3BzGPg3aAnie6dmkfWYRQplnylYIBOFV0w
         puiO3lWUvVdyrZGatEtBFwAhkkUVjUyv5B5o49OIfLr1IdB7Z9nioflCOKRpBfvB8KHf
         wLqg==
X-Gm-Message-State: AJIora/E2KFRBcc4dqXKahmDJdm6bfz1q9orr+nuHNWrD+arYBwVdg8i
        EggcSqG0Gh+cB6b5Ufpb9U9WFYhFXOC4/g==
X-Google-Smtp-Source: AGRyM1v7CS8w2W8e0LRNYDuhUi9lKh7L2wdnPFifA6+Ot3EkPAV7Os/LT1NCqMOu+hZPIpO/Nf02lg==
X-Received: by 2002:a05:600c:4e92:b0:3a0:4f34:8fd6 with SMTP id f18-20020a05600c4e9200b003a04f348fd6mr5816809wmq.63.1656410774452;
        Tue, 28 Jun 2022 03:06:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/12] submodule update: remove "-v" option
Date:   Tue, 28 Jun 2022 12:05:28 +0200
Message-Id: <patch-v4-06.12-ad5aad8fed7-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e84c3cf3dc3 (git-submodule.sh: accept verbose flag in cmd_update to
be non-quiet, 2018-08-14) the "git submodule update" sub-command was
made to understand "-v", but the option was never documented.

The only in-tree user has been this test added in
3ad0401e9e6 (submodule update: silence underlying merge/rebase with
"--quiet", 2020-09-30), it wasn't per-se testing --quiet, but fixing a
bug in e84c3cf3dc3: It used to set "GIT_QUIET=0" instead of unsetting
it on "-v", and thus we'd end up passing "--quiet" to "git
submodule--helper" on "-v", since the "--quiet" option was passed
using the ${parameter:+word} construct.

Furthermore, even if someone had used the "-v" option they'd only be
getting the default output. Our default in both git-submodule.sh and
"git submodule--helper" has been to be "verbose", so the only way this
option could have matter is if it were used as e.g.:

    git submodule --quiet update -v [...]

I.e. to undo the effect of a previous "--quiet" on the command-line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh            | 3 ---
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5b9683bf766..0df6b0fc974 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,9 +241,6 @@ cmd_update()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		-v)
-			unset GIT_QUIET
-			;;
 		--progress)
 			progress=1
 			;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 43f779d751c..06d804e2131 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1074,7 +1074,7 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	 git submodule update --rebase --quiet >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err &&
-	 git submodule update --rebase -v >out 2>err &&
+	 git submodule update --rebase >out 2>err &&
 	 test_file_not_empty out &&
 	 test_must_be_empty err
 	)
-- 
2.37.0.880.gf07d56b18ba

