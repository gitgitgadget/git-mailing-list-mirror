Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15865C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiHUOCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiHUOBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C807248EE
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso6404537wmh.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YD9uqL9QbtJEF3anroflghb2Td52DUadeIU+YTx9/ZU=;
        b=IQkxyJB89AjytGpdQvLIPRo1aDcDTuE/tpIk2bdrFui1BQHVizagCyBB7QylM/EYk3
         o4gfCx807mYZ3/V3hl52baGVyFexiChU4EEE54pDYHHBypWkuHmQRoe8Mszv+xS2W+rP
         aBwhFQkhgWhx359WDPAhCpJMoILKfAjrWV/EZRLcD3kc8hfCxZGj5gf9gx2Hd/DX2IAW
         I4rFeKe7jUqFbcWBuPlAMIqMeiit4WAAYMPtm+Z+bvKFwaRXsAZVR7jJyPePDrkefFdl
         OCpA5b5gktAEnS0Qp2nsCUL3UI2wHuFwPFecnUY5PpL4AV6cB0O1CQlnYfok/eicVP+d
         bVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YD9uqL9QbtJEF3anroflghb2Td52DUadeIU+YTx9/ZU=;
        b=R1JryIgbvFpooqU2gI9YGVRuzrOMYSgNWkKAsMKF6rVurNZ/yN0sCOIFpzeryvnGlg
         1mYIw85OLD15qxv3ykOymQcaN76Lm3H6Nyk7eFdhuOyN8aJXVTUWNQud20VJlxita5/i
         jQKU6Lu5VyuoP/H8L/FvcZoEeXbWqXkkwjrcPriUiYnXDXGSiLzvRDgbJj6ds5epIn9w
         62dioygnPT30/OGP3IfxmoP8x7UHV9ixeZOamuD/GO1090aOfxkSvFJdm6gbxSBAiynC
         I2Un8o6/N1kZSTSo+EGWkMfGsdDBchIjJyfymFrButHxAUgYdiokP4FWiXOR3BKZU0a1
         ETWg==
X-Gm-Message-State: ACgBeo2Y8GOGZJclUvDIWxIsipO+AXi79iJWh03htFubG/n2C+KWyGLW
        qq0a5vf4UrkGuzJzZeVKVcHZ/JtShnjyhHMg
X-Google-Smtp-Source: AA6agR5LBgpg9A9C6oUAfGJBPJ/XIfWXg45kX2X1t9Qr3L4hEqfAArhmtMU6xkP31xjFKguAJlTptg==
X-Received: by 2002:a05:600c:1084:b0:3a6:150d:b92 with SMTP id e4-20020a05600c108400b003a6150d0b92mr13132392wmd.151.1661090463807;
        Sun, 21 Aug 2022 07:01:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/17] submodule--helper: fix trivial get_default_remote_submodule() leak
Date:   Sun, 21 Aug 2022 15:59:26 +0200
Message-Id: <patch-v6-02.17-c14e00f39cb-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in 1012a5cbc3f (submodule--helper
run-update-procedure: learn --remote, 2022-03-04), we need to free()
the xstrdup()'d string. This gets e.g. t/t7419-submodule-set-branch.sh
closer to passing under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2774f1884b0..da9e0016509 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2449,6 +2449,8 @@ static int update_submodule(struct update_data *update_data)
 			return code;
 		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
+		free(remote_name);
+
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-- 
2.37.2.1279.g64dec4e13cf

