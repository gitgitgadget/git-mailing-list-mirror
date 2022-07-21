Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD6C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiGUTPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiGUTOa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811358D5FA
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z13so3591591wro.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mql5+u/XqNeByiUP0iOQP0yFNSEZMBXbVpoUl3NXryk=;
        b=mkMy7Jwbe5le3XrTCleU6CZ4oZqDsN6+3Elrt29t6DyhVqQrl4dcPZtjSQzBF32i03
         HsviJuIujuZAYLtEjdLeQEw3P/HVOZ8PLRo7L3Zbau7gLAfh22kxZnTOn5oS3RB5pUT2
         wfGA7AlDqO2vv/HKYYSBa7AUhVBJVU6SCmZSDt078/NJ+w8pqqvsquiqCGg3hJ12ZTEi
         LTsA3EqTCEZSNVROTOHbqBpuzprsaNSArCf0wU9oeUJc4iwqLZWq/6C6QD9sW+GyrTUN
         g/9yAeAfHyDfCWH+ttdOgdvTp6vb/7spZbdD3w+UCobZQHrBctHjirWv8N3eZ5q8h6pE
         av/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mql5+u/XqNeByiUP0iOQP0yFNSEZMBXbVpoUl3NXryk=;
        b=z+d6A5E0zhMW/UUNnwTMuJK9PERghLQHvMg+T26LAhOzC18kSMeyyBOygj+0dZC1gy
         Jk6vbhQM1aIC/ppot91tAxN3EITr/M68jbmpQaUqmTdhrXcYKWXIjlGJAKtmftMYrz90
         sudF/n/3o/fLJfNnoK4sa/cRD+tU8ICZYqYj5O6yTymSMbnL1jagM2ckIHCHDms4tiKz
         h28NpNBNsi1oNOy9CJxICf0so+HOn0ETZMDdte2Jnh8qAlfB4yBTZdj/w4XDMjGfpSTY
         YrqZC0fyoSYjFgoTzZkbRwdiHrS5C78tf9nmnYWAJW54mWv1iq3qQEPzUOrr3H/TyKNp
         vMGQ==
X-Gm-Message-State: AJIora/wN9gt0yV9WOJPAd0GkdRjvqHrWYc1MkW8K+rtH9kkYiI28jfY
        josAN0YXNyM41BNUxERXohK8E1qQnccaig==
X-Google-Smtp-Source: AGRyM1tAa69tbDKtydSLeE6YeBhUNJ5ZWgMoQeUMRjaWikpTgqL9ox6RU0rG9dp9LYOilT5PzVru+Q==
X-Received: by 2002:a05:6000:18c1:b0:21e:4712:b284 with SMTP id w1-20020a05600018c100b0021e4712b284mr8583894wrq.545.1658430859548;
        Thu, 21 Jul 2022 12:14:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 22/26] submodule--helper: add skeleton "goto cleanup" to update_submodule()
Date:   Thu, 21 Jul 2022 21:13:18 +0200
Message-Id: <patch-v3-22.26-af83925046b-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a skeleton "goto cleanup" pattern to update_submodule(), rather
than having branches in it "return". This is in preparation for doing
something useful with the "cleanup" label, but for now we're using it
as the equivalent of a "done" label.

The "exit()" branch is not handled yet, and neither is the exit() that
run_update_procedure() might invoke. That'll be handled in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 94eec34c595..790f0ccb82e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2545,6 +2545,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
+	int ret = 1;
+
 	ensure_core_worktree(update_data->sm_path);
 
 	update_data->displaypath = get_submodule_displaypath(
@@ -2581,14 +2583,14 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
 		if (run_update_procedure(update_data))
-			return 1;
+			goto cleanup;
+	}
 
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2602,16 +2604,20 @@ static int update_submodule(struct update_data *update_data)
 		/* die() if child process die()'d */
 		ret = run_command(&cp);
 		if (!ret)
-			return 0;
+			goto cleanup;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (ret == 128)
+		if (ret == 128) {
 			exit(ret);
-		else if (ret)
-			return 1;
+		} else if (ret) {
+			ret = 1;
+			goto cleanup;
+		}
 	}
 
-	return 0;
+	ret = 0;
+cleanup:
+	return ret;
 }
 
 static int update_submodules(struct update_data *update_data)
-- 
2.37.1.1095.g0bd6f54ba8a

