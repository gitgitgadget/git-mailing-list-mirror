Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9CC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGUTOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiGUTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A198AECC
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so3633114wrc.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+xqvdEZrR975tP4VoKUrffJo7UeeReNihPY1zsJ67A=;
        b=UNZ5i8+B25+SII8x0UrMOFDbG0fevDRTDpgP8jQgUEDulRLraYJwFu4Yxron1oujcd
         elzLo5J/SleQiF1o+hF2gQkMlgKmNt4bxgkdxc3/N/6d9GI2DauHUnBNLFuJXjq6W+zB
         Niot6yeB7wIAMUT/JHwK4Op9zQdS92YWewUDAYYqhNihVTnbsdekNIktQ4CGrJgKTYqV
         pKOyXHLiLVafR7hSaSe5JVEhw9Mr4zifWTFanFLsRqIxnoJmalMrsThSDaHH1twhjaTp
         9GlC6rkSa2uABhGtkwTslGvejESYSU16YCtrICOzuyJSmAL8a91VtiIrDmhBQu4rPkSR
         UTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+xqvdEZrR975tP4VoKUrffJo7UeeReNihPY1zsJ67A=;
        b=ULnicOcApNVTwGuRHtxcZRFZfMfBuRD/f5vo7sBrVSz2b01hXh1zXH1dT7vH5t+U/Z
         YrPAt4RkFTsr4plFEbJl7XVMhFTq4P64cM0l/FM8bzGTMrZoD0/by/rLAT0Q20VqKeAg
         w82fXialDdRO0p3EKwxn2wSaEHh3YPwXLh4MA2ncWS8DJXWCCPglojjoNM4UtmplMKrR
         ADDzBK+dNgDsTGgQwGd25QBZTNPWh5O8SGSnPEa9KtB7V9iAR+eRUajuE1X5pNGN/nex
         nTB1ahMGtzL9FsmOWL8oJF1MfzxNl8j+hlNMikKfFs+IPX90B8hn4ywSk4Wqhsu1nPcL
         BCVw==
X-Gm-Message-State: AJIora94rIeVdX4IPc9k73zgv/jFcLam7XUbRozNYqA3vtW3BjT5kL5m
        UEdu7phrS1OohlPhqY3IUueHzuNwm9JWJw==
X-Google-Smtp-Source: AGRyM1tM+ckkc4ailJdbX71uvWdt0fzGlfA85a/fZPTPKUIhNXyuTYjvkBAM2xHCzxo1E2TNgVzExw==
X-Received: by 2002:a05:6000:180c:b0:21e:47f3:7e51 with SMTP id m12-20020a056000180c00b0021e47f37e51mr8037345wrh.226.1658430824918;
        Thu, 21 Jul 2022 12:13:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/26] submodule--helper: "struct pathspec" memory leak in module_update()
Date:   Thu, 21 Jul 2022 21:13:03 +0200
Message-Id: <patch-v3-07.26-325aa1521e2-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The module_update() function calls module_list_compute() twice, which
in turn will reset the "struct pathspec" passed to it. Let's instead
track two of them, and clear them both.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a60dc6af178..f317236f016 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2602,6 +2602,7 @@ static int update_submodules(struct update_data *update_data)
 static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec = { 0 };
+	struct pathspec pathspec2 = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2692,7 +2693,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0) {
+					&pathspec2, &list) < 0) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -2715,6 +2716,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 cleanup:
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
+	clear_pathspec(&pathspec2);
 	return ret;
 }
 
-- 
2.37.1.1095.g0bd6f54ba8a

