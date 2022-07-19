Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87BC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiGSUrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiGSUra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE05288C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so62168wmb.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvhsmefBi0EQL68fvpDTYoP0qq5T3aSKS9dm5jTh7T8=;
        b=Q3V1y7/ZvQy19K3ZjBDYrsTGaSjAB3EDioUkFSFBXYtSLJgv3C6x1dVD8ids2XH6Z4
         IZTA8UQSS7tZsTDsXoH1swlnzPwTJAjgDHqhIz/n91KuC83l5bHtddHdP1qrLFC3zjQo
         iVYkkk93tQVitjAw7QnaSH+7pbG8AErWFBozyEM7FydFwhzEQ1aRkJ/0wTBwoGZYmGcA
         omqbIYuD0SKHsyfsMRmltpyFPP3p0XyRF0pSZOQI/wo30qCBoFk7WSbMQZuTThsENeAR
         233n2Vb3ZeN7SXuu/CdTDQo1+Cu5p41Q0K2wTx9mOeOto1A17i/x+obmwet1UAWaR+qm
         Hv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvhsmefBi0EQL68fvpDTYoP0qq5T3aSKS9dm5jTh7T8=;
        b=kBbsBv9GXyMi0799oYjNc/TnYUifbD5KVu5YR2PIrc7LnW2lWGRWD3zmO0iS6WqQJt
         DuEzRCXUFXbBaJvu6l/arVRZfdA5ZS2MX6aiadL0OQqyXugp4NvXMEHGLe0Jh1RBaZVX
         cZA41LbK71eq4efAUlX8KbQvQ711m1CprumKor44atn13tlr4+THquBZNyH8NWQTn1nt
         O8lGEC1DYriDJPIcHDYxXEoMj7b0fMhywdPK4iuvTpOtf2tre8s5RDiHU0pxOhUIQpuK
         48mPLS52EKBTdx5BreCX+HcyAWKGt0h6ALvBNUaMqNhuE3dIc6dKngwFwkU+Opx3UORf
         8X1A==
X-Gm-Message-State: AJIora8dirAnwKcFmky9mk8GXC15OfZqA43z/hJNoRWScFhGahr/m1o5
        B0lf/0qDhuUqelF1ioiJ7lsxCPFLjDU//w==
X-Google-Smtp-Source: AGRyM1u9hFL2HfyzWep4x7tcUeHz9s1SP/MkWBlxpGMIzo01L4B6hiMhksiBQYjvUQreILs6B4rmhg==
X-Received: by 2002:a05:600c:3c8a:b0:3a0:4ad8:d3c4 with SMTP id bg10-20020a05600c3c8a00b003a04ad8d3c4mr907331wmb.43.1658263647165;
        Tue, 19 Jul 2022 13:47:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/24] submodule--helper: fix trivial get_default_remote_submodule() leak
Date:   Tue, 19 Jul 2022 22:46:54 +0200
Message-Id: <patch-v2-03.24-25e17bbb058-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
index 4155d2450e0..b36919b66c5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2473,6 +2473,8 @@ static int update_submodule(struct update_data *update_data)
 		const char *branch = remote_submodule_branch(update_data->sm_path);
 		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
+		free(remote_name);
+
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-- 
2.37.1.1062.g385eac7fccf

