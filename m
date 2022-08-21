Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A3C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiHUOCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHUOBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A813D69
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k9so10325689wri.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZCKY8kboi08sOtEvX1Nz4fBVuDySO9b3FEZ3slAOpuc=;
        b=DGhhbJmUAcM6VqGPj5ppI/oRL5VoRHZ7Z6nWaJCRh7/5Xd0YKfLluazKk9/kWbQxTd
         It7S/8FjTf7lFSok+8265nVUD71rimU/+YiZHAAI5k+lDQP7E3vxyVOQNCq2zmiyj6yI
         iqx7fdzLUK8ZvOSp6i4Pk0Zw+ARZIjbEuoyORVx1mRaTF5JWvQwzZRo/Gaag6EmxMK7h
         OMCGUPpczA1Ew/fkiZSc31MG8xMF2llLHIQGVVI5ViF3mi3H6/xgztLpX/73twMWTPPw
         2YE4L+amTHZ5grG2XOGWK9KgqgcotcdaldOdUzhObBVm4j2mxGOnG7wJF6v2YbdNyQDA
         iPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZCKY8kboi08sOtEvX1Nz4fBVuDySO9b3FEZ3slAOpuc=;
        b=E7W8LHZ33CPSQKiy8TRq0VFSfsOuLwmVUPWP7dFVA4XLcvJHgXaeROeSsMDUbwwn+w
         ns33xugaCiCbSL0O32A/AX5SahkHAhQ2UKOl8K7zKU9JfEN3WVlhxR+7isSC9iI6ZBcz
         xoMyUJ8dBytverNSCjGUTnpT5x1kZ/F6cJ3uAyvwT74mz+mtDTWAr8G6UZ2f9a15PNHv
         9TlmYLIWKYBPhKoS4yTb0XLKn3yMAAy6eElW81iHZvpXuw1xx0gUWhHZD5tpRM4JFepi
         Z/VkwUUfh+a7tTI6NQ40LDZoReoRKYqoD4fLmsUL/7I7bv25fVb4qqWCv4t/SbYBjARn
         ACiQ==
X-Gm-Message-State: ACgBeo2jOTo5RTTWxoKe8nkzsRIawsSLmf666Ndgpei+Dnx0ntpI9y56
        /4H1yB83UxH26vveXXt+IiHn3qdlvUdoO4GQ
X-Google-Smtp-Source: AA6agR6btjDH+JUO2ULngtMiuy9WRXSeZGxrpBxQ+FFstSVGErJYHzjeCh7oBl3BOCpThrtbcSbCKA==
X-Received: by 2002:adf:d087:0:b0:225:2252:3af2 with SMTP id y7-20020adfd087000000b0022522523af2mr8688314wrh.388.1661090480521;
        Sun, 21 Aug 2022 07:01:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 16/17] submodule--helper: free rest of "displaypath" in "struct update_data"
Date:   Sun, 21 Aug 2022 15:59:40 +0200
Message-Id: <patch-v6-16.17-a99a7736fab-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
index dbbe412b24e..070e435b13e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2485,13 +2485,6 @@ static int update_submodule(struct update_data *update_data)
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
@@ -2565,6 +2558,24 @@ static int update_submodule(struct update_data *update_data)
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
@@ -2597,7 +2608,7 @@ static int update_submodules(struct update_data *update_data)
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		code = update_submodule(update_data);
+		code = update_submodule_outer(update_data);
 		if (!code)
 			continue;
 		ret = code;
-- 
2.37.2.1279.g64dec4e13cf

