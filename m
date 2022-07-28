Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907DC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiG1QTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiG1QSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF66E89D
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so2858602wrh.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cOUsJa+Ebw0/2v168OtAZgDUmXcqsm5VnYlVgWpp7yY=;
        b=dJbvD+TcTYEwvWsaWTkKKfXJvrmsXGoQJ2JxOU9mWHhZVFHbP9BPjqK5mgQcEsa3WL
         o3hpf+uz3Lfjxjk4bzIP26sF+OcBSdG1cvcReTkkdwCcLxwb2JoFdHHbHtIGnXJs9LJ7
         0hoV0RTtNKn0Nin++LV+Ox7T+kvFLSH5EPzEzmh9BDhYo4k2YBlLXF5nTXREIXX5acKu
         lpQYJNPjrzXd0YwHeAUMTdUUgqBhHB2MWUpcI/n5oPkD8RP+w3P1zCBDeKZzcfFbZEwB
         LaUBHiXoSJZt/vh8sSSS9iZZOW+lkxJGtKcxYuW1/AjoJ2i1zORSYNUccut2flCiujUN
         gx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cOUsJa+Ebw0/2v168OtAZgDUmXcqsm5VnYlVgWpp7yY=;
        b=KBMoMO1w8S3yqKvK7BfpBO0pTFt4qxCC/DpY/LIsxHem1A1wrm91bCRxSRa1daSIWi
         koTTGIm8GFJTB/HHayq//QLNZYynIAc55sChquGinNCspF50D9/Doq2EMk2Cpn3jfP03
         O2U6Kq14/5jqXenGO14gaKQVP3knCIa6aVtjJAFVa8BFkC7B2yjhmCnh9Nx1RvHoEYmF
         n37RBkGDqYKzamubfLA3jyTn9NDclN+GRTiOQblR7/4Sh+uvmFEOWjk3JtvIrwaO47IP
         p4c954B4oMnUWi9dtainqRHJTDekubmnmL5UWQ4oIzMyzrHuuYxbAj9w/FW/mmUD8TEt
         zEsw==
X-Gm-Message-State: AJIora8XNvy3toAP6GPC1rYypqgY0KfsGox01PiXirVsT+T31ot+jUf6
        bb9RTkv0+tfFUEyGWxVq0R/yitsCcZFrRQ==
X-Google-Smtp-Source: AGRyM1vJISoXEEcCSP7NqO3UrrNfT13uTFMCselK/YwpVZTV25/NIfu+n16WXCbG/C13ktTGXMwzew==
X-Received: by 2002:a5d:6d0b:0:b0:21d:9f54:efa2 with SMTP id e11-20020a5d6d0b000000b0021d9f54efa2mr17420974wrq.607.1659025083569;
        Thu, 28 Jul 2022 09:18:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:18:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/20] submodule--helper: rename "int res" to "int ret"
Date:   Thu, 28 Jul 2022 18:17:02 +0200
Message-Id: <patch-17.20-e8aacb55a18-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "res" variable added in b3c5f5cb048 (submodule: move core
cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
in the rest of this file.

Eventual follow-up commits will change this code to a "goto cleanup"
pattern, let's have the post image look consistent with the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f451704af79..349fe7f269c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2424,7 +2424,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int res;
+		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2436,14 +2436,14 @@ static int update_submodule(struct update_data *update_data)
 		update_data_to_args(&next, &cp.args);
 
 		/* die() if child process die()'d */
-		res = run_command(&cp);
-		if (!res)
+		ret = run_command(&cp);
+		if (!ret)
 			return 0;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (res == 128)
-			exit(res);
-		else if (res)
+		if (ret == 128)
+			exit(ret);
+		else if (ret)
 			return 1;
 	}
 
-- 
2.37.1.1167.g38fda70d8c4

