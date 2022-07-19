Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEFC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiGSUrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiGSUri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B06558F1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id id17so2573579wmb.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMSEy/5uk7vR8DTQygob2MD5Y0S+hC3qH7CQdFM44uY=;
        b=SSsXpshMVzGfY2Z5HUhNBhy0FaetEUm1mcMPdydyMkI5iNv5FDQ8ROG/fz/3Tk5HpS
         KJq9lUPE/RNoJ92PUI9C53E3qwtiqtv6ZzpWQRNECy8C/LPw/LaCJ9Wvtxks2fbPRIBY
         TTIzsBD1D3i3n23cgAwABpR7DuD2/XV6BbI2xBAY8uCH/UNHFXCWUAGWp3Oi5/VIga7y
         n2qKBeX9BtJctFerZHzbMnybCZUb2pG9ykGm7lmuLddZSoS3NoUzmkycHrEzoY6HlFjF
         dr9AslI87A7DE4yc9WkCcWCgh9Tlm8xcc3Dlq2v/5xsFgxS6Dn9h0ZLH2H477GNJFW7z
         ZEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMSEy/5uk7vR8DTQygob2MD5Y0S+hC3qH7CQdFM44uY=;
        b=4ZmXsVODpXhO7iIJ2HSRi95cfDmN7znhbwO5/R6CaV0rHx+jmBj8R53vffBUTDVHT/
         oaHM4a8g93qtGvzZpMH2d+HKERBF+ahTV+QnfiUuoJsjKNUWwL4ctDbOoltY12YYdG11
         2I7/Hf9YOv4stCUDQ7ra8xGCxS75ON1sVNCqtktQpHgLMR+Muzk2HB2nq3GSU+o6M/on
         XOcn3j7V1QGeV8CVtyA7wF2ObY4ZwjKV3yws11zszDWuhOYa3acZgCHM0wMbuaLHuwma
         toa9qvECvEFT5ydZOrukBMWfNQQr/um/jxjt0x6g4KALIJeD72+zWzeUYvpya+RFtxT6
         AK1w==
X-Gm-Message-State: AJIora/Pxin2FtEC6n76gnoaHc+0j849G3KXl3/0UEAiaqOgl82fLOLx
        /tNQL5e2R6pWf8Vbq74PcvLnX91bnX7p2g==
X-Google-Smtp-Source: AGRyM1vBnc6foaBc40ifecbOBl6i2OYIrPGFmiah75zoQM/3JRsP62OGLBoDWHX2pTxfw+ilkuDi6A==
X-Received: by 2002:a05:600c:2e48:b0:3a3:1ce3:3036 with SMTP id q8-20020a05600c2e4800b003a31ce33036mr863391wmf.188.1658263650439;
        Tue, 19 Jul 2022 13:47:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/24] submodule--helper: don't leak {run,capture}_command() cp.dir argument
Date:   Tue, 19 Jul 2022 22:46:57 +0200
Message-Id: <patch-v2-06.24-7925db18b33-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24) and 3c3558f0953 (submodule--helper: run
update using child process struct, 2022-03-15) by not allocating
memory in the first place.

The "dir" member of "struct child_process" will not be modified by
that API, and it's declared to be "const char *". So let's not
needlessly duplicate these strings.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7466e781e97..3d32fdb3960 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2194,7 +2194,7 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	char *hex = oid_to_hex(oid);
 
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(path);
+	cp.dir = path;
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
@@ -2212,7 +2212,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(module_path);
+	cp.dir = module_path;
 
 	strvec_push(&cp.args, "fetch");
 	if (quiet)
@@ -2267,7 +2267,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	}
 	strvec_push(&cp.args, oid);
 
-	cp.dir = xstrdup(ud->sm_path);
+	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
-- 
2.37.1.1062.g385eac7fccf

