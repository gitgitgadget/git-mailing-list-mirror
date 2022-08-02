Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8661FC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiHBPrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiHBPqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B919C3A
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso7142405wmq.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cyB0mlSLLQytoQq5Br7kwXLQZI2uyJwNlEeeW6EIhT0=;
        b=SQH5GjXScqnSegEhEcR/uOE9P+oYpBnqTVLvpArd2U03Vhgky65aCkQ0Yn8rht7vNY
         HL/ONIYgwHz77BLq1q6poWpeSwvazypj9LSP1dCrkbh/VwZ7VJd1O6wEgpebzGvrUz4B
         YNBemuAhzyL1Yi2vrqpaK8OG5g9grgmliazncgYa6ROBQNzs/1j5iRvUVDOITWzA9Twk
         uF6Mjhd/8liyvmBPHXsJu4x/JNYoC4QNgn8XX+e7carttZXatHuDuXKbkdQCIhEI7MIS
         ZFv6wAwOQEPxe/N/JqeElHC8xllt7URdnchD/sQIFv/w/TGoazRbFqUz42pNnI83F1ea
         l5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cyB0mlSLLQytoQq5Br7kwXLQZI2uyJwNlEeeW6EIhT0=;
        b=QlZVIWqREcB0FnVnbcYtE0fNxzmfZVkBBxBY7S1ww7IackRA40AL/SNnjrxkqHeEor
         C/vZ/kL4Z/Gz05d+w2GA8umzGCi9kY0UnJJYi4Kcm3RXSCkBkO3vskg/qTRUBH2Sxb81
         HpT85X5xzwgbFqAFndbtIRGwctnEQjPz4hlos2rWloAE/qnKo8hEe6kyht+/BndUAz92
         M8u+2v45EB8MjPtT00rWjps1M5zWOWbcca95Xphic+lVE/BczHaRn0F0L9A8mTj0GrZh
         /ZTsyWeqpzYbVbKDoNp1OR5nDGWGXYmNQZCCJt8gtIr6GYOrgbAl6VSibqyVGfNkczqq
         pb2g==
X-Gm-Message-State: ACgBeo0CUPOjxR2UOuEViK5jBIU41UIalk4hhlaZ2hyLdqT+DPB++noU
        /R6ZFGODX4hGAeuWmIeEYEwN5WrEEKNtzg==
X-Google-Smtp-Source: AA6agR4OMIsJ++lUNeVQ4J0ZixZ+U5uvooiwpHazlp8Uak52p6fm22OJh/Arih2e0bRfrvGcDTQhCA==
X-Received: by 2002:a05:600c:348e:b0:3a3:5515:98b1 with SMTP id a14-20020a05600c348e00b003a3551598b1mr70338wmq.110.1659455191813;
        Tue, 02 Aug 2022 08:46:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/28] submodule--helper: add "const" to copy of "update_data"
Date:   Tue,  2 Aug 2022 17:45:59 +0200
Message-Id: <patch-v2-15.28-1ff380ec7b5-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add a "const" to the copy of "struct update_data" that's tracked by
the "struct submodule_update_clone", as it neither owns nor modifies
it.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6b4ee8a31bb..1391316cde2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1777,7 +1777,7 @@ struct submodule_update_clone {
 	int current;
 
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
 
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -1862,7 +1862,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud = suc->update_data;
+	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-- 
2.37.1.1233.ge8b09efaedc

