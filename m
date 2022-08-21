Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76611C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHUN6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHUN6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A19DFCC
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d5so4362220wms.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QzytqYsDc5k+qrEFl5M7MTJCwbRB7Ji7zsl2SqIbLUE=;
        b=Mcp6EBCzOM/6VpLgg4nu9PSxDHzEglXaCFeJdmYo1+B88lBNSzdPM0t6IVpZIBO7jy
         3yGW3yIOOdEPS+I1wJW14bpBnqb0cekeDeZyvvbTvkhoWKFRGGmfbTaQKtXMeLhBBhri
         oxkVHaPBFQo1M8fHl6XwhRnZJEn/x+/QhoD7a2uYNG1x9nrhc4lHHt1IopZbEPKJnXAN
         l9LvNyM0tzklv+O0KNrdUsAkhjeYnsexz/BPDukPdP3LPU7qUElmxzQt3qFa/eh1vdCr
         HF0nVSd9Ha4Bmqm5cPs+2kR1EzC4NtVws4MbWgOJ1gDZGtU4/dXnmqyooUdVylFAc6Ms
         levw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QzytqYsDc5k+qrEFl5M7MTJCwbRB7Ji7zsl2SqIbLUE=;
        b=FlI4X8G0y8wXMuADB7MRzJzT9VxpehyJVArD2o66IIOQwOrpS4hzLpHE/6NsE3jvYg
         OvYViqDgeQoQYvQe8eGa1xTpVgisWuvQX8xrmzQ+h0eTdo0LY5h1rC149SWlNp8cNPsm
         ZoNNRNNGs6myMbu2otzXTwEMvcQE0br3zetpABrvqtovL/XgPheUXFdZ4P/c7zz0bE6c
         jc5WU13XEYumh6wxua53u2VXVfJPMxfinulrkSuZ4PkaaRN99NrSP6sBlb4A5b5sc54w
         pOJf501EyHph6tz5qc3TcF1g16ozbXpqPH9a0g0CJIyrBTuSbTJSOZAt5t4ys/4r9iUD
         1dsg==
X-Gm-Message-State: ACgBeo13dSrC8Ae/Gx/zNDT2dOwDvBHwPfIu7weogCsx26X5DHnEiua9
        vLFvinPgb+F+UYlFBOFVyZqb/r0Xtv918Fbo
X-Google-Smtp-Source: AA6agR7wCLkuU/CuzeLqHhK7dlp7GywMKCASkeXx3LP1NNosCMJK0nEhIg6kb+A7SKGKQdf6L1yB0w==
X-Received: by 2002:a7b:ce89:0:b0:3a5:cefe:80f6 with SMTP id q9-20020a7bce89000000b003a5cefe80f6mr13583300wmj.113.1661090308085;
        Sun, 21 Aug 2022 06:58:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/32] submodule--helper: remove unused "name" helper
Date:   Sun, 21 Aug 2022 15:57:12 +0200
Message-Id: <patch-v3-03.32-1be48c0b22f-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "name" helper has not been used since e83e3333b57 (submodule: port
submodule subcommand 'summary' from shell to C, 2020-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b63f420ecef..fc4d2779da6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -771,24 +771,6 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int module_name(int argc, const char **argv, const char *prefix)
-{
-	const struct submodule *sub;
-
-	if (argc != 2)
-		usage(_("git submodule--helper name <path>"));
-
-	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
-
-	if (!sub)
-		die(_("no submodule mapping found in .gitmodules for path '%s'"),
-		    argv[1]);
-
-	printf("%s\n", sub->name);
-
-	return 0;
-}
-
 struct module_cb {
 	unsigned int mod_src;
 	unsigned int mod_dst;
@@ -3362,7 +3344,6 @@ struct cmd_struct {
 
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
-	{"name", module_name, 0},
 	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
 	{"update", module_update, SUPPORT_SUPER_PREFIX},
-- 
2.37.2.1279.g64dec4e13cf

