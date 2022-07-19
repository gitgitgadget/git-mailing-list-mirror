Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A93C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiGSUrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiGSUrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544F54078
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so69193wmb.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXxGKabuApVWDrefmQAxHABErebb0fQdkGERdu6XkEA=;
        b=A3PSTbqxJU0fThc9ktzSvQX4b/mHedlohs/CsBXOdlwNNx3V4vLDUEAU7CzQG0NAxn
         5ilBYnD7zM9M2VSpsN2hdY9WX/0sjUprSoGAl/3/N0TrENSX3KJ2rXT4XK9x1YoX+YWK
         mTUFnTP9lIH+WjnRMq3N19X/IAG+BlqlIGFh6f8bfXa4WwSje+K0GBxb8M4RAU8b3Bfd
         GH4yaVrCOPaCTkADNvxpsm+RUSIfnZPTKs9xToVBpCQ9MQCr1lu85y6ylNAvx67XbfCn
         kqt9NrhE5W3wuTljcP/iV/dQVQYV1bdSPHi7zEh+JQCSyDbflqbgOoK6mDY56odwMb+Q
         BxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXxGKabuApVWDrefmQAxHABErebb0fQdkGERdu6XkEA=;
        b=VIsnc5TE61UturF62P4Khjmk+p5v15HL6n6Fk/6HjfFp9AcPnFlx2wTSxDF1M+h8eZ
         ugMjcYm0+wUCLMqDo64McdFWwqeCcG4LE7znwipTu3+elj3srHIrXmli0wISnOpOpDGN
         M8bR32ti/Q3SXAtX6ttm7QVbJ4JIIZUFfbs1dXxqLnNY/mx9AwJYAa0c6xlwXFewKEsK
         vygLIBsY5ickT8+x63sTSpu8uNEL3XGJC3D/5/f8iR4MRBRA3Uf1+JQlpcTkQNc4qcli
         YZGD3BS7cDLT5ttGJDF3SpCmFUiljnwikvaLdICbXGSV7rKTT/GnWMSVxdbM0q0MoVVM
         eM/w==
X-Gm-Message-State: AJIora+DEXUc/f8GNr7AA3FUy54CO9dKmIeBrSOsIZZJwiqwTPzkg46/
        Xsvb/a8ZUKc3tmdLvmBkW4GfeBgU6TXbqQ==
X-Google-Smtp-Source: AGRyM1tKEZcjlHc8F+vUwv5OjUp/Ojbqq7QD1FUDAZL4xlkhuM3nhU0Wnpr+C1Kz39nYy19PcuJrmg==
X-Received: by 2002:a05:600c:1d1b:b0:3a3:e2:42d1 with SMTP id l27-20020a05600c1d1b00b003a300e242d1mr863568wms.137.1658263649141;
        Tue, 19 Jul 2022 13:47:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/24] submodule--helper: "struct pathspec" memory leak in module_update()
Date:   Tue, 19 Jul 2022 22:46:56 +0200
Message-Id: <patch-v2-05.24-a4672aa9c94-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
index 28c5fdb8954..7466e781e97 100644
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
2.37.1.1062.g385eac7fccf

