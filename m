Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8223C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiHBPzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiHBPzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:55:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053523CBCC
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:55:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so18432718wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NDPid9KX2i7MTtqJHUUCGEAfMzv2bpvBj0LeffJxpEE=;
        b=Dwlgdch5TzDAO4eY+CMqdcDdvRdcUW9B3T7zOOlTyMtlPbfLxCrCRNkxTroD1WOX5u
         FS2SrklcWUiph6vz8hXr9ZpPJNgW9UgajagWv7/x712Gbiza5tt4YonBJMzjtckLcD0O
         Bv8ohUP4Ux0dc0hRZLhjgsFof30eSKji0EwSLd1/flnn0RdYn9tg22ESc4XBFA0kg10d
         IAIrAnN3E/fPrHUTcK7tO0g4+J0Of8cva+4vBu1mAW4S603GVkxXjEVXQVPuaIzbmjGS
         D7nuGgwQneu7izcoM6EufFa2g5/x/uEYCYP5CKXloAIGRg8E3lyW3dErSLABBzIm/yz4
         zUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NDPid9KX2i7MTtqJHUUCGEAfMzv2bpvBj0LeffJxpEE=;
        b=Xwwz8EpimlHIVY7NqqF6CcIAI0uaYVVAjo5BMR0jTtXBEKE4mGCwZebt+i1G7Ygbfa
         5Y6MtpzqFye/yvQ0+VQNJbOYzRXnQ5KkPP9xzDL9KOz+lvtDneg8Ml+82CmFwUIP7Je/
         Xadxp5s6fxZQneVpim6++gw3Qvy/riqsTCDIPSiKXdySoYSIbr+lWKsKMKz++rIdsObj
         tcX0aAmpJpc+K5Ouit1/5A+JXHGHWkgqo9HyD3iWd4IykMjYLHmHfBUYMftD0BM4a/ae
         oJvbQnS2buDbQUmYWET++3Y5hVNQEuMmZMRVQ5TqEGqRUdbKM9nkgYB2ugXXFC/bMDVO
         2Dhw==
X-Gm-Message-State: ACgBeo1uoO9hLZBP5JJKu/LcQgPKVFSa2oTkUZCZJPWq81MYaCFXlWxh
        lAp+HTRs59Vqr7L74ACNjIdoQrwwTS3a9w==
X-Google-Smtp-Source: AA6agR6euLSpfi+a0DCSKayjAKSedok4j7YtgVG0kZLaN/O2N6NYIOW1SOT7Nzk5nI2QzPVEGAFsqg==
X-Received: by 2002:a5d:4308:0:b0:21e:4855:f369 with SMTP id h8-20020a5d4308000000b0021e4855f369mr13284976wrq.706.1659455701168;
        Tue, 02 Aug 2022 08:55:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:55:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 16/17] submodule--helper: free rest of "displaypath" in "struct update_data"
Date:   Tue,  2 Aug 2022 17:54:40 +0200
Message-Id: <patch-v5-16.17-8f150a81507-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24), we clobber the "displaypath" member of
the passed-in "struct update_data" both so that die() messages in this
update_submodule() function itself can use it, and for the
run_update_procedure() called within this function.

To make managing that clobbering easier let's wrap the
update_submodule() in a new update_submodule_outer() function, which
will do the clobbering and free(to_free) dance for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 79eca6c439b..cc8f42ae6df 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2482,13 +2482,6 @@ static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
-	ret = ensure_core_worktree(update_data->sm_path);
-	if (ret)
-		return ret;
-
-	update_data->displaypath = get_submodule_displaypath(
-		update_data->sm_path, update_data->prefix);
-
 	ret = determine_submodule_update_strategy(the_repository,
 						  update_data->just_cloned,
 						  update_data->sm_path,
@@ -2554,6 +2547,24 @@ static int update_submodule(struct update_data *update_data)
 	return 0;
 }
 
+static int update_submodule_outer(struct update_data *update_data)
+{
+	char *to_free, *restore = update_data->displaypath;
+	int ret;
+
+	ensure_core_worktree(update_data->sm_path);
+
+	update_data->displaypath = to_free = get_submodule_displaypath(
+		update_data->sm_path, update_data->prefix);
+
+	ret = update_submodule(update_data);
+
+	free(to_free);
+	update_data->displaypath = restore;
+
+	return ret;
+}
+
 static int update_submodules(struct update_data *update_data)
 {
 	int i, ret = 0;
@@ -2586,7 +2597,7 @@ static int update_submodules(struct update_data *update_data)
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		code = update_submodule(update_data);
+		code = update_submodule_outer(update_data);
 		if (code)
 			ret = code;
 		if (code == 128)
-- 
2.37.1.1233.ge8b09efaedc

