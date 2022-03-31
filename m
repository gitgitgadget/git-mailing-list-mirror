Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACDC433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352342AbiCaBOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352294AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC866C8B
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r128-20020a1c4486000000b0038ccb70e239so226413wma.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppH81pK/kPQ10z1gUCe0dBvavOO0UBZGJm8f6FHgj7M=;
        b=X1Yxj5xo35HwO9SD3GmAEhpSKkijG21R7yPalye40hgzBJvmw7KsQF8a1CEYIxqiC6
         0DAUASVCo9oTOVwpROPOTRjDuzlP4nok9s2LE5CV4i0w+eprdi6UL8W1u9Gj0bfHfZJv
         d4qcBGYp55xt1dA+075bAZWIIs8jjCP44Up/r1zgQPoxOvWpvLw7MCLzQRYsWGE05a9j
         QoSL4RHfMhZqhjUxj3LE3MLUzLLyziSHAFnIPMWKePgrqIXtV3hJG3lAAQCA4GymrZJq
         HilpRePEh1VGmvmSgBgvSrpMFv63vkmjqfHxAmfT9yChSTB+FVTBM3AwZY+/Sf6B71nu
         C5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppH81pK/kPQ10z1gUCe0dBvavOO0UBZGJm8f6FHgj7M=;
        b=m5HliXA2Lwny9F4hjZH/YJL202qMcWWh6+szlw2Y8IVulR5/l+qjFZRLKuJYgxYg/v
         bS4kXrabwPX+9Vrp6oRubaEL+6kzQos/dO6GAWWw8xuAA3zxnFwBTu7HKSJ3yRIU6Nai
         xlNWhn/uD6FNMZGR4DBTiCdT4DyGv9h5wT+roC68HQOoeIrOq41vVNmi1g/W/UK78Bex
         znGZ9onh+0JBOCh87NN4SUvK2BTS6L87ZuqZkq/Hoz4unnQe1C/fMzLMZWnDlzQhqqHJ
         L3U1nwf/jsPpPnP99H5/lH9QNncWwYv0uCZgfKhA1qXw2FcXgBNRXlZzNlMIGdPbQ+L+
         Co9Q==
X-Gm-Message-State: AOAM533SoWfIoRot+wTdCE7pmnVQuXQLEorWbmk8MwlZY/qUqn3H/74v
        qSnnIyBBsP3WCB6KRUioTf6U1KMWaRsqpA==
X-Google-Smtp-Source: ABdhPJzlDbZtiuyOyhHRn/FNmGmHrqtqz8anmM1wk060RYk+/36FB38pTpNHdH0SvSc1z9Z3GoFKww==
X-Received: by 2002:a05:600c:4f82:b0:38c:9185:1ecd with SMTP id n2-20020a05600c4f8200b0038c91851ecdmr2364446wmq.130.1648689143000;
        Wed, 30 Mar 2022 18:12:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 20/27] revisions API: have release_revisions() release "grep_filter"
Date:   Thu, 31 Mar 2022 03:11:25 +0200
Message-Id: <patch-v4-20.27-806fef06b87-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"grep_filter" in the "struct rev_info".This allows us to mark a test
as passing under "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c               | 1 +
 t/t9151-svn-mergeinfo.sh | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2d52f1b518d..349c3f77536 100644
--- a/revision.c
+++ b/revision.c
@@ -2961,6 +2961,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	release_revisions_mailmap(revs->mailmap);
+	free_grep_patterns(&revs->grep_filter);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 85221d439bd..c93a5beab25 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,7 +5,6 @@
 
 test_description='git-svn svn mergeinfo properties'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
-- 
2.35.1.1557.g4e3e9cdb5e0

