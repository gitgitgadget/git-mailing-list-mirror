Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531EC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiGSUr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbiGSUrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A15288C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so69442wmb.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcsqlTdM3tal+bD3QS+UnJ/R4fvMGRjb1E6JIGbDRiA=;
        b=kGkw+TdEB+LTlS5oW2ERVhCTaLomCgVeHrVAzL/l7NKIIAXbRDiSD/kMcUNi5fkJ2v
         Mbx709wkhRkkWeBeF/H1zvZ3u+PbVWi+qt6Q3xgpMdsEcLk6FR/J/kScpYSjRs4RtLxC
         0RN70HWwmkiIbZPePQwWnDf7PXg7etPydK/SDHi+h/tGiqd+SKQ3j5hbMydiRAv63mRj
         nKoXc+A9/D4RMrnTPCXJ73Uo+d5cKeYrkJCl1TA98Ent0Oe2x1NCHRsCc0jDCBqUrtkl
         XFDWB/6FWrLfwTAwgffYv9HjdS1FTwrqwMw+DKIlMzZyrAurxrHd7fJ/4+hhyFsgvycR
         KFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcsqlTdM3tal+bD3QS+UnJ/R4fvMGRjb1E6JIGbDRiA=;
        b=Dr9eKXOe6PF1ZGJGH0c8WFv6zd8BjuWeo3/UB0yFplUdRXVW9fHPDSP6xRvikU8gqV
         f3V+6pOgBU2tu+QxOgk+xr5/H/fgITTIOQ2jqYbtraGeKTX2JDfo4gnV8uA7n0Zln9TI
         Zv2ZzWK9pkATt6Nj6AIbQrNRERN7ISk1Fsi228L2sQ8CVfZI9moAQlp9TsvKhJtQ7MOA
         g5IhafG+HlNsbg8u9oKt3KGWb8iVSxfOCHgHzkHSZkNA8VthHSeynv4QRnu/flR4mHhC
         5/t1Y5DrhEwkfFgQp3+/XOrdgUpDVmFTSRoJaEzoykuiGr++s9YrjL+ZD2ieGfAJ1wsT
         W56A==
X-Gm-Message-State: AJIora/RCW9VoaGYXXa1XGyDzJbtV0hZqhyD++bQ9z/luZN+3FaaXTWv
        BbHWZnrd2jLxDI8drB6tmccpsETH39IWpg==
X-Google-Smtp-Source: AGRyM1sZcnw2d1Fa0nrPA8ryitel18DpOiL9euzSpvCh5POtwtGuhrmD9ifrPcY8XxiZY015rzqZvw==
X-Received: by 2002:a05:600c:4f91:b0:3a3:1e79:4441 with SMTP id n17-20020a05600c4f9100b003a31e794441mr918751wmq.16.1658263657537;
        Tue, 19 Jul 2022 13:47:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/24] submodule--helper: fix a memory leak in get_default_remote_submodule()
Date:   Tue, 19 Jul 2022 22:47:04 +0200
Message-Id: <patch-v2-13.24-f8ededcdf77-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the get_default_remote_submodule() function added
in a77c3fcb5ec (submodule--helper: get remote names from any
repository, 2022-03-04), we need to repo_clear() the submodule we
initialize.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 339ba94e658..cef8f14efb5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -62,9 +62,13 @@ static char *repo_get_default_remote(struct repository *repo)
 static char *get_default_remote_submodule(const char *module_path)
 {
 	struct repository subrepo;
+	char *ret;
 
 	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
-	return repo_get_default_remote(&subrepo);
+	ret = repo_get_default_remote(&subrepo);
+	repo_clear(&subrepo);
+
+	return ret;
 }
 
 static char *get_default_remote(void)
-- 
2.37.1.1062.g385eac7fccf

