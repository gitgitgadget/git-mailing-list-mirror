Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC8C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiCYRas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiCYR2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8466FFDE2C
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n35so4828575wms.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkDMEKQV0K5G6pSyzUsLAN/m07ZVZib5Oh5BqdPdAK8=;
        b=X16hhsnUtbvyBV78b07WY5V2IztdMw09GdZs57yQdiVGow3Z+FDqtASYp18wrizfKJ
         ueRMWDpEQvN30d2Jir8ulN7GLI3cdu6oqfLtvgw0TYdyAhrAEcc+Ay9XTdl+RqAToekk
         W2ycLFrJVzsiS6tT+Bclubk2Flwejo8Mtdx9FpciMVMqOXQBKRvIbyk/i1Z1/EXFJE5V
         h+HDNUsljnnOj9ugjWRiqwKBZan1VOR3jk9BH+A/QXPsBN0Q/5Um7IAXZTUKrRL6oZC4
         9MrBvdeZm7eIPi5rPEe8G14BvDdXTABB7vHWxcDbZL06EUGJqsEwtOCh4qnM47lLlenz
         ygTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkDMEKQV0K5G6pSyzUsLAN/m07ZVZib5Oh5BqdPdAK8=;
        b=B5Lx87XJuox81PvXwThQ0LeB/E6tolSUAyXOSR/k6bQbndis4iz9dhw0c7EhgxXSMQ
         7OnxZ9skOw+J14cBMKjJCfIUO633WY7AsTCcKOMRMLTVSGKmJJKj5bpkNtMUw10kdECR
         8OBl+vuhzUxnm3BpcEBLVkxeaKOJY32vNwvgC5XdxfiCnuR+9+JVdOnktz55cuoZTqxu
         NxvskBquszho0t/RZRGo1GLI8j4BBNrDoMRBAPUKDTtjXBaaAKFiJJHcT/owQ7HaISxA
         /CJ3xIP0i4aFbJR4wgUTvgwopb0lXMUHeja/pUm5SmJIh312fei02o0StIutzvZ8SmQK
         8ceQ==
X-Gm-Message-State: AOAM53163IN+nlAsxPfDO1kdFHOGONPOdCcOPWBQ5IyJwu8UNyPpqS90
        YHpNsbdgzOpF/VSGmWdR+jhjLui0lixfsQ==
X-Google-Smtp-Source: ABdhPJy0D8t81wya8nz4BZ5tWKf873tnLN7W6vxOxDn7NKFYOpl8QGdtuTMQQiPZYiX/y+NzazDMjA==
X-Received: by 2002:a05:600c:3785:b0:38c:9b55:a477 with SMTP id o5-20020a05600c378500b0038c9b55a477mr10830590wmr.164.1648228790576;
        Fri, 25 Mar 2022 10:19:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:49 -0700 (PDT)
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
Subject: [PATCH v3 20/27] revisions API: have release_revisions() release "grep_filter"
Date:   Fri, 25 Mar 2022 18:18:44 +0100
Message-Id: <patch-v3-20.27-26163e5e754-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index 55f2f4291f2..da7e6356e68 100644
--- a/revision.c
+++ b/revision.c
@@ -2957,6 +2957,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1509.ge4eeb5bd39e

