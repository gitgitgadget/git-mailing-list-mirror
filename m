Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D0EC0502C
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiHaXSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiHaXSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E5D9C8E5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso452371wmb.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=InnZePy7Y7sqcPPEART2wCG/ftc5e+6x04/S1MVaTBY=;
        b=YOZ3tlLWLVRQFTw7q/zf5LaGkmb664ou8PL1PERpI1qDx/4zuZ4runGENbY9la5NAG
         KEQ647q+pSS1+GylhxrqYf8Z0SMw6cG1hrMWGE1X+Dsy0UmWIjLjMzPx6NMljyN2tLVr
         GY1ld7ZGJuxaKQdBEOjYWkXw9UHtt5MuxYRCEBj3Tp4+TjYofGf0BjG8a0q33Xq6pw8X
         NzHw8kEG6kA25BYOsp88srRUybm/mbpK16W8UEN0SrlK4pB7BXZxvv+8kyR/+kAgCdqw
         Qwr9nc8TgXfgM5xWuFkKw+2KaQVPIbkdPFd91HO03CLG5GcduIj00HEqJh4I86/mg6YV
         OvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=InnZePy7Y7sqcPPEART2wCG/ftc5e+6x04/S1MVaTBY=;
        b=PtSjeMgzHqRK3J2yv05wSADXqVblZ6ftzerp7hLbUNdiRUxMgVkW0dpyPr/Me8YLTo
         dMjENac/n8mKTtAGBB68/QP8Uca0SA4jJsB7Coskz2rIDjraC0bKo+g9lhF+NDEiLJNV
         s1Dy8BpwlAvCyNHHqYaTnMSS3aSRJQguD5MTKO7Ifom1Bcd9eeAr4/9Q3Gk2faT2zPWi
         y4uhD3UumVty6UlY2qsjcVTy/2wuU391AVCGdu1DphK+CXswb0NeYAHQ7nyPMVKU5qHA
         1/LUy2CYUM9vzTM//OXY7Lkv1+KBjRqQnq85qmUHqw87uhzzKjvgl+K3G2bBQ1m/nM+S
         bgwQ==
X-Gm-Message-State: ACgBeo1Vf3vgTDlKZr3b3eq5Etx2sAMF0ti2Dc/pXeu/+kn3KVDfauvB
        FDuE23LpKQm4iMDFC0INvA/NrJa3/Tbi8A==
X-Google-Smtp-Source: AA6agR4/PMiCxYQACZWKDrlfRCyGSkCyUjcEDjFfPNhK5wN9ct/t6orezh2BRSAaMmlazrQvytADxg==
X-Received: by 2002:a05:600c:358c:b0:3a5:dac0:dc3 with SMTP id p12-20020a05600c358c00b003a5dac00dc3mr3167970wmq.60.1661987902900;
        Wed, 31 Aug 2022 16:18:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/33] submodule--helper: remove unused "name" helper
Date:   Thu,  1 Sep 2022 01:17:45 +0200
Message-Id: <patch-v4-03.33-27a455d231a-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
2.37.3.1420.g76f8a3d556c

