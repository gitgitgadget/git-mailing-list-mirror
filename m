Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D22C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiHUN7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiHUN7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066213F0B
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b5so6015178wrr.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aU6G11qCC/BaUbqtt2q06Eo7PqmIwWLoUAtX9oWpvWM=;
        b=iKEkmldWzAjcsn+r986jFjdCOP5mCX8jLSlqaf7zPTGmvVJNEnAUBcAEKI+m5nmD5a
         qKmKiQQRG2RveBxUvvQuRgNVjSxvUE55HT4RW6HzFktc3mpaaMozht4k9Xru0xxM1SLS
         uwRQndH8ff+obIoW7uMbzPIAU3Qi+yJlCPoZm0lYLAn1tj9/oiqb8ulIy6NihJk4/lgm
         sUiWiO5bbgla69rs1T44SraVWHyIOhTX5TWVfTe0Gkw6ABn/TTnhLOSuZBiLX6hgNqZ0
         x+But4x6qyuCmKp6IO9Sk7oWE7auzzeaWKbUlZkA24Pdkx87Z6eV/JdgiT3VI5uCqt3T
         2zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aU6G11qCC/BaUbqtt2q06Eo7PqmIwWLoUAtX9oWpvWM=;
        b=6Hu+/MACsgOmaP6d1/wkwTtukN79xUTlgvlro/Dn5fWcTC6SQWYVQKdh1kHvel3Q+W
         GEAa1W6nEQNmASloymR3/IS6qqXbz5Q5aZaioMo/2TzaRireU1NjvfNQP5o2PJ+zeAyS
         qj2ZmCLiedeTjg9+gHByJWMk9yY4Om6LHNTmu8zpVwvCdMKyHq3PoKQn6i6v62+8Ohai
         nAR3ftQB3STnqdDOabj4WLX+5rNexdW+Pvfe1EeG2jGQXPbDgNDoReIsYzj1marGfjlR
         Kh7l3/35BxCUa7O+ok4sew+jIlI9+QTFv9tpS1SE6K3ocLI2cTyzxEB6ya8Vqq2yX+xh
         OMiA==
X-Gm-Message-State: ACgBeo2YBw/Tjvv0qE6V1hnl7URzjYQaYwZUIMSHggsojEtkiqxGQ6XY
        4BORYTAlLuj7/0Mi70K+mRbi4nTULSOUpSG2
X-Google-Smtp-Source: AA6agR5FXIAp7999JgekqYFShEOmyLA8yDTwW5CCoK8uUYM/88ZE67u1LAJR/xrdmyaAW/JrjE7/Rw==
X-Received: by 2002:a5d:628b:0:b0:225:4638:a7df with SMTP id k11-20020a5d628b000000b002254638a7dfmr3603460wru.98.1661090323951;
        Sun, 21 Aug 2022 06:58:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/32] submodule--helper: rename "int res" to "int ret"
Date:   Sun, 21 Aug 2022 15:57:27 +0200
Message-Id: <patch-v3-18.32-be1ffbf2e26-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "res" variable added in b3c5f5cb048 (submodule: move core
cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
in the rest of this file.

Eventual follow-up commits will change the code in update_submodule()
to a "goto cleanup" pattern, let's have the post image look consistent
with the rest. For update_submodules() let's also use a "ret" for
consistency, that use was also added in b3c5f5cb048. We'll be
modifying that codepath in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a9808224f01..fed92585a02 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2427,7 +2427,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int res;
+		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2439,13 +2439,13 @@ static int update_submodule(struct update_data *update_data)
 		update_data_to_args(&next, &cp.args);
 
 		/* die() if child process die()'d */
-		res = run_command(&cp);
-		if (!res)
+		ret = run_command(&cp);
+		if (!ret)
 			return 0;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (res == 128)
-			exit(res);
+		if (ret == 128)
+			exit(ret);
 		return 1;
 	}
 
@@ -2454,7 +2454,7 @@ static int update_submodule(struct update_data *update_data)
 
 static int update_submodules(struct update_data *update_data)
 {
-	int i, res = 0;
+	int i, ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
 	suc.update_data = update_data;
@@ -2472,7 +2472,7 @@ static int update_submodules(struct update_data *update_data)
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
 	if (suc.quickstop) {
-		res = 1;
+		ret = 1;
 		goto cleanup;
 	}
 
@@ -2484,12 +2484,12 @@ static int update_submodules(struct update_data *update_data)
 		update_data->sm_path = ucd.sub->path;
 
 		if (update_submodule(update_data))
-			res = 1;
+			ret = 1;
 	}
 
 cleanup:
 	string_list_clear(&update_data->references, 0);
-	return res;
+	return ret;
 }
 
 static int module_update(int argc, const char **argv, const char *prefix)
-- 
2.37.2.1279.g64dec4e13cf

