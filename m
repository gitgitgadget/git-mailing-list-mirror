Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D275CCA485
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiGUTOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiGUTNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455128CE8C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk26so3601079wrb.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFCx+F/awxgEXhNSY8bBlS+abGVNw9yviB0kveRTiN0=;
        b=dh/jzfkDHJD5/NiQ1BA4MFJLSxZKfnykkx1C5gEEDyQyj2BjEXJzjdfod8b7el7Zqp
         oPqzVv1RYUVoswx35TjRacBRENjPaR9NpxJxwHm1EKujCZIoyiDzzARw0GAuRV0+jEHP
         nzC8ZCbYYPMDvWndVVRN4URKWVN2QgOX8C6VVmfp/5dDLym24+emeFH0qMlVLJPOUilG
         +421r6p+r8s/6HX7NXD5rC8RLgiO3o5vsSMPyLZWOFxW+Ps/zpPn+OJ2B+NAUjfFlWli
         B4cwQIp/8bhXMjYyzlpIHS0ufYLu75gReqUwG93K6ArvMz7p+QyCC2CQr5xog5ibSzMh
         25GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFCx+F/awxgEXhNSY8bBlS+abGVNw9yviB0kveRTiN0=;
        b=h/b5zMjLSyl+hs2sgMMeW2VDbsejNl8/WB2QphOjs1O9TTjyVDRYJDMx/ajNUYhco0
         +AWf6909KjtMrLVel2j/NDT5NY6+OFykBpwsFRVHMUsoxQcfqAwfJJCZpOhp81f3BjqZ
         dK6hwff/dctGbCHa7bx+DFVCoNutAmKghSgwGYWxVmx35JpAhqs6VCpfUR1Uf7igvkRV
         SU7m1B+kYMIjXt5K1jUBHoD/SeWhjwv5KR+r9Y0TFULkLthUxK4ZCx1Jcss30Y44MqJX
         IX3mBnsQxBbVPDXbRzjvNGDaIYmS2CIuEcmNPJBDa+coNVdiwp7ACrfSMuGwgl3lxQuD
         TuQA==
X-Gm-Message-State: AJIora+huvc/dCTxViVSSegbHNO+3368k4fkMIaArb2swePy8t7FObCO
        +yMertem2EoziVmPfFf+TN9W4BVT/AnDMw==
X-Google-Smtp-Source: AGRyM1s+zpUxPPGjMjUVedS3OT9X6LBo+EHXwJX1hEh7G6241cMIeLV33/ufaLhhZN7snvzmG4780Q==
X-Received: by 2002:a5d:69ca:0:b0:21d:640c:79f6 with SMTP id s10-20020a5d69ca000000b0021d640c79f6mr35861712wrw.309.1658430827257;
        Thu, 21 Jul 2022 12:13:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/26] submodule--helper: don't leak {run,capture}_command() cp.dir argument
Date:   Thu, 21 Jul 2022 21:13:04 +0200
Message-Id: <patch-v3-08.26-424b24961b5-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index f317236f016..fb3102f024f 100644
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
2.37.1.1095.g0bd6f54ba8a

