Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E98C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiGUTOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiGUTOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616AB8D5DE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a18-20020a05600c349200b003a30de68697so4201083wmq.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yh+6/9bceYfLosADtVBmxs+gkRvxO4rQNtsDR0A5RNM=;
        b=Xkq1wr/PSazox3M4pxnua/JCx2zJDMAuWcnDU28gk/6PFEeEypSR22xhvQHGCQiyfa
         mygDYoRvW/leLAsLRg+ckTxHCxkDIExhdTs04YwAjODZaseYGUb/fQrMQDBhhEfVWTG4
         MPLFTmFXVq9hvWzwjFJqUwWlKxz/WEUV6jd+OPPwhb/+Q5e3QnzOu+Bdyl1Fzxwd2vtL
         3k4q67T1CLS4nbfXXng3ON5R9xUyVk4Jrpvtv3HjeXPrtt7Lc0CJVgp0Q3up8qvTc6bK
         YSld/c/2bvEfMwKI7+nxGSFr5rS7YtFYH8paMHmYURliSzCK2McVFosIJnYpcfpxgy5N
         vx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yh+6/9bceYfLosADtVBmxs+gkRvxO4rQNtsDR0A5RNM=;
        b=d/4SCezZYF7exHIyc3oPHQqmYhDuZbXtrE6861jEvY8EVzQ2mHfJ/9tx+H+T/LA7w1
         ugNV70GUZrCPNhOn13nFhm3/wba2eH9j/MPmLH1sq9zIi5hlsX1HxVNQR1rCZ3bdxSaP
         E3k5gLd1uP3IXRpHfj9Un3ewQTqqeIrwZ1rHMu2NAI9w9XS/qlG9av32Q+2Gr3DlytP+
         LtXf6JXQnVt2fBvGPJZQ+3t5KxS8sxlq8I2VvuhOD1cF2N2QNWRF/LuXPq4cB8m7g8zn
         joB7dYIVJZrm4uEuJS+8FzvxMujBQZGFvM4qaZDYvlqfL81DvQ6jdfMk/ClWSdLwSTq6
         J+VQ==
X-Gm-Message-State: AJIora/m/L0tcECaykDKRawCzMM1dNjX+czO5Xxmnxksg8Zekt8pJY/x
        LxcCaxYR+tznRROLJ01Vo/fBUlozBhAGHw==
X-Google-Smtp-Source: AGRyM1v5RPTC+JGSYnLKq760kiHGRtLQPfhK4/RYxStUGPuzjtx0v8iGUpvESYpMVfSO+TeQvFZG7A==
X-Received: by 2002:a1c:241:0:b0:3a3:142d:b65 with SMTP id 62-20020a1c0241000000b003a3142d0b65mr9392041wmc.171.1658430846508;
        Thu, 21 Jul 2022 12:14:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/26] submodule--helper: fix a memory leak in get_default_remote_submodule()
Date:   Thu, 21 Jul 2022 21:13:11 +0200
Message-Id: <patch-v3-15.26-abfd61f9f05-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index a3de17754fd..fe490c8d44d 100644
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
2.37.1.1095.g0bd6f54ba8a

