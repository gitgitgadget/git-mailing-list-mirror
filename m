Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E3C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiG1Qa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiG1QaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B02654D
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i10-20020a1c3b0a000000b003a2fa488efdso610581wma.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QN5g+Fa5PM3RH4LwhXA74J0vuej8lFThEevT2870LC4=;
        b=bT0Dsc8LwVqlCmb6kEkfa9RGBA1+ySNeA1rVk+vnw4Yeb0SwvLj+3p8PfUvWH3WuHk
         PAPsQu/vZvCwFplGFHcflM+MxMoyBP2xLIzKXxEozkFT5PXQYT9A85+BwHotqt7MUZbx
         TxX/RMA125Yuwirg7P/OqDtKOLBpPqUpQ8Pmo+L1JjroFY9cqhzI57mZHQzxt76nPfsl
         XdeP9MkYBvthW70bCp5+jZ8rCl4/Vj+68pc0KKaByB8ktHVBdOlRBL+sqQpzL1fDcwec
         MdP8KOsURvmlFn5PbZOv3GsyhmBDLj3TvzNNdFwdtSFcbPuj+cZeG/tOYJYmW/ryr2s3
         6dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QN5g+Fa5PM3RH4LwhXA74J0vuej8lFThEevT2870LC4=;
        b=nLe5pqXh9Fpi2rP6UxLLfeo3D49bcydFat9NKMDu2UD9sBCDIt6+CdGGU45SBve2sp
         fYZ0Yl9X4EdoLonXmzr+y2gj0sD6pQfYmWyOfp7fAI+QoEed37xFHZqrKaWjyH6TG2e+
         zTDw0fOd+6dBPqJmYdKgkbcmk+GRzCqDl8UaK86rZIEogPekPXp4F9jsxQKXeCZQRXi7
         qJj1Z6q+Q8wLHHs6DXqT6rHRQVyaQwyN7WA8Kdj0gm4ZeRJcMMsOawQUrwhH3eQTbHFH
         jxNM0w5ZW+GuhRzB0Wz5MFnFAoomcMU38q9w5rGr0BL0iS75AEnGz0aoYL2B+ki4pb3e
         m65g==
X-Gm-Message-State: AJIora+KgGfUQmjL/Ip+xVt44oelTTyB1hrjF/qx9134I3Ja0bpUANsG
        7Vtqy36W/7Yp43vhwmMGZGuFGdWwVx5Hpw==
X-Google-Smtp-Source: AGRyM1s1GMsu2Tp+v1Wz5ePTJxFovBGOhPLUztI2DJnPOHdkQz+FCESYEV5WgG0ugKGAnSkBEPFwGw==
X-Received: by 2002:a05:600c:3ac8:b0:3a3:63ad:d53b with SMTP id d8-20020a05600c3ac800b003a363add53bmr158184wms.104.1659025818695;
        Thu, 28 Jul 2022 09:30:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/17] submodule--helper: fix trivial get_default_remote_submodule() leak
Date:   Thu, 28 Jul 2022 18:29:56 +0200
Message-Id: <patch-v4-02.17-390c5174e17-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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
index d3dd47588d5..d452af40d2d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2410,6 +2410,8 @@ static int update_submodule(struct update_data *update_data,
 		const char *branch = remote_submodule_branch(update_data->sm_path);
 		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
+		free(remote_name);
+
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-- 
2.37.1.1197.g7ed548b7807

