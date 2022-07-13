Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EEDC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiGMNQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiGMNQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C559590
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f2so15453733wrr.6
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PT4r1yzmQUrvMOnCokcj/QQVnA1aOOX56hdxJnDk4Qo=;
        b=kTMWsw9FCxekf8M6M02jLc/dw0FziEkqL6eRtcA/4r8+dLZ5Krj+0sSauNbVxjAklW
         WQW5DHKNeujebrEyS6/GFDnUdKU+xVG659/BGCztARyU+Tqby2FqzYUvPJwIVMgVVPHE
         48h9NeyWMzzOx6Ir3My3/gdfWqWlfNnQkXNijYxemRlQaJrsJ5YDjK+pEXg0LTM2VsL2
         usmFaKpsHiZkVvlkvPd5qud5REmczacHI2nwr6YkMDfewBD9ZPlpGVkIjbOE35eOKk7l
         NDyJEZCVL7npb06TlNAp3nk5HuPCCWSKX80FBuxOsx5r/4bDzxPhs20RkWf0gcJPVpQn
         A3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PT4r1yzmQUrvMOnCokcj/QQVnA1aOOX56hdxJnDk4Qo=;
        b=4ju0uAubLxeInGo3or0B95Z2oU5izqaARyxylQAnLNX5hl9XPDbln4r/7XVh3e45J9
         /7un3DUsXtVLbS1vXr7/4RxsRwXxW035VevN0Xuybu+JrzyIRoON5qzyVHVLZfUrZsoL
         tL47So64Ll9OqwcyHgHKcS8sCJKSPkjSPc6pp9rz4H2zq8sevmQ9LCfLAN5hCh88m0DW
         fsGgre0EO/L7r1FLFFQf/tj2R5UHm+4LvBQlAH/PNU7LxaPkhYTH9FLHoOuwpFiAHKRZ
         Bv5Q387wuRufnAHEAot9z+tELUFHB4VkqtKTWYChzfZDQx6cdaEnTSol9hJVWtG8gMFR
         SFyg==
X-Gm-Message-State: AJIora+yDLemAYk5A4iw8PHZ4xf8bF24NRigwHrn3dxmwn1gjQBSUjNH
        +aF2UZhbQMS513bEnnh1Ko6icJyr7BD69A==
X-Google-Smtp-Source: AGRyM1tjvBdeWfS3FsW8ZC9dWh2TflJzndamu/lH9XsYlmJ8JN9xB/O0j/2iyUni8XmfW0sYESYhSw==
X-Received: by 2002:adf:f38f:0:b0:21d:66b5:21c with SMTP id m15-20020adff38f000000b0021d66b5021cmr3288449wro.144.1657718190488;
        Wed, 13 Jul 2022 06:16:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/11] submodule--helper: free() leaking {run,capture}_command() argument
Date:   Wed, 13 Jul 2022 15:16:10 +0200
Message-Id: <patch-05.11-76eab92c8b6-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the "dir" member of "struct child_process" that various functions
in submodule-helper.c allocate allocates with xstrdup().

Since the "dir" argument is "const char *" let's keep a
"char *to_free" variable around for this rather than casting when we
call free().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a8e439e59b8..2099c5774b2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2198,27 +2198,36 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf rev = STRBUF_INIT;
 	char *hex = oid_to_hex(oid);
+	char *to_free;
+	int ret;
 
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(path);
+	cp.dir = to_free = xstrdup(path);
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
 	prepare_submodule_repo_env(&cp.env);
 
-	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
-		return 0;
+	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len) {
+		ret = 0;
+		goto cleanup;
+	}
 
-	return 1;
+	ret = 1;
+cleanup:
+	free(to_free);
+	return ret;
 }
 
 static int fetch_in_submodule(const char *module_path, int depth, int quiet, struct object_id *oid)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
+	char *to_free;
+	int ret;
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(module_path);
+	cp.dir = to_free = xstrdup(module_path);
 
 	strvec_push(&cp.args, "fetch");
 	if (quiet)
@@ -2232,7 +2241,9 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 		free(remote);
 	}
 
-	return run_command(&cp);
+	ret = run_command(&cp);
+	free(to_free);
+	return ret;
 }
 
 static int run_update_command(struct update_data *ud, int subforce)
@@ -2240,6 +2251,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
 	int must_die_on_failure = 0;
+	char *to_free;
+	int ret;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2273,7 +2286,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	}
 	strvec_push(&cp.args, oid);
 
-	cp.dir = xstrdup(ud->sm_path);
+	cp.dir = to_free = xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
@@ -2301,11 +2314,14 @@ static int run_update_command(struct update_data *ud, int subforce)
 			exit(128);
 
 		/* the command failed, but update must continue */
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
-	if (ud->quiet)
-		return 0;
+	if (ud->quiet) {
+		ret = 0;
+		goto cleanup;
+	}
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2329,7 +2345,10 @@ static int run_update_command(struct update_data *ud, int subforce)
 		    submodule_strategy_to_string(&ud->update_strategy));
 	}
 
-	return 0;
+	ret = 0;
+cleanup:
+	free(to_free);
+	return ret;
 }
 
 static int run_update_procedure(struct update_data *ud)
-- 
2.37.0.932.g7b7031e73bc

