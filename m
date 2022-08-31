Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A43ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHaXPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiHaXOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52540DF1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r204-20020a1c44d5000000b003a84b160addso392280wma.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vRxWElH2jM/mIQMTkiaDRlEwvo+aI4aVcwyDfJthgeA=;
        b=FwBsMZhZMrm0zLDt+jX0NdJuVSlCpxG69CJmdTsGIJ4v8D5Z4UUGCOeDfkZ6E7WFVD
         wpuwclS9J4ALR31DkDIuBrYlmu3yfihZxXpVaB72TDHN8tTC3rRaJhs0fcNxmi5DsSUp
         tFc42QpJsaZJMqWhapyIutV0SgcUNPmcmdOL+1DLAr62ei2VqGr9kvH9YyYQfMj93GTM
         E+n2MtEtdkBXLBuQ2ybEg6c0/oFXgwzrTHKBpse/xmpXS/ComI5EEXYLEFJpqZM5pxNu
         POL344D1z8E7HEuFqmuqQtMh3TfobZ58/kY+fsJ1qugh6O6B3xKTkM797tISR3ObOAGQ
         GN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vRxWElH2jM/mIQMTkiaDRlEwvo+aI4aVcwyDfJthgeA=;
        b=V9xYyVez76dIqByzDa3v8KZ5Ky44wQwnczcksWuzPxz91JcZFlUV6AgvmLRKRK1hNY
         zZ/xSBSBr6mx29RYDjHZrECv4sGIytjemJcMa5Z4QZxLtJjkqMTVRtVzS3YH/hfa1f4Y
         MmcibpRuwYF4g3HmAGyypuLwgEtxHogbWVt6HZBDsS5kdfsmzPTBmcoL0Ay/a1wF7V3G
         f6SISQaFBQrdMfZH7xr0QgNNL3b4jnbAPVLir3WgqtV/69Xk10ZoapjENyisTF7ADaYi
         x39l8H5hOXWt6EY/N3LLNHqX1HIbkJr/AwwCMIM/5/CBk3ge4yU2DcJpkMuJlg8lZliG
         a+2w==
X-Gm-Message-State: ACgBeo1ibYWiQq3n84XkXMLf1Ez1Y3l9eXBq9hAb5m582B5vvmrSVx9R
        dBT0ETTRmZ9HgT2BMW0PFvulIQ3YNOfpqw==
X-Google-Smtp-Source: AA6agR5T7OXOLkOKvIRa4stgJBn7Aqg/pF3GWpXqYHqzyFKp2T7nBeVBGAcyi8MKxEuuZ453zIyAJA==
X-Received: by 2002:a05:600c:2311:b0:3a5:af18:75c1 with SMTP id 17-20020a05600c231100b003a5af1875c1mr3273884wmo.90.1661987687893;
        Wed, 31 Aug 2022 16:14:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 05/17] submodule--helper: don't leak {run,capture}_command() cp.dir argument
Date:   Thu,  1 Sep 2022 01:14:12 +0200
Message-Id: <patch-v7-05.17-41672ffa55c-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
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
index e8bc6f17330..0c23dd93d96 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2129,7 +2129,7 @@ static int is_tip_reachable(const char *path, const struct object_id *oid)
 	char *hex = oid_to_hex(oid);
 
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(path);
+	cp.dir = path;
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
@@ -2148,7 +2148,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(module_path);
+	cp.dir = module_path;
 
 	strvec_push(&cp.args, "fetch");
 	if (quiet)
@@ -2201,7 +2201,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
 	}
 	strvec_push(&cp.args, oid);
 
-	cp.dir = xstrdup(ud->sm_path);
+	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
 	if ((ret = run_command(&cp))) {
 		switch (ud->update_strategy.type) {
-- 
2.37.3.1420.g76f8a3d556c

