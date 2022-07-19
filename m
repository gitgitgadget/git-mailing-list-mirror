Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC7C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiGSUsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiGSUrx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080FA5A164
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso72862wms.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwOe0wRu3B0WdZywZrZWwvJyE/lGa/CB/65pw87PaJk=;
        b=JGyjMDy3lootMCGFyDOSyYXdw+f88vSQC1dW68Kyun067M6IdxpjdwWuT4A/fAxUUo
         ie0ST1E9hF2XpR7DYO1zOy4xNlM5i4MgjKtSA1vMsJ4BKuzPaxJHa7GTdPquMedriXfr
         9/MUZhsgCTW5AYIXzWaZjJZXSFAJUL2i3leKXzIzPyxj0CB2rfacYFSi1bUry5WetC/z
         YzCSWNpG8UFW9ZOG/2AAzo/3REuio1w9CeTXf9jvSHWo+tzroozwGK/ZuqFkxEYwxU6/
         FO+gbkKTZQtEDimnkv7HI4/f9Te+MuIJbDjdp45bxKEVUlpAZxEucP9/vl0kb9aixWXF
         n7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwOe0wRu3B0WdZywZrZWwvJyE/lGa/CB/65pw87PaJk=;
        b=1Fd0HwWKOQyDpn8+PKDv+mG8ReYWNtK5BhGLAUHJWqaec9ztYocxhKEoENufFjgNxo
         JG93G6PDO+BseEQadKU7Vfc9IIx8edCEJurc6wt5HUkoL8qkOMMlMpffN00DWDBmRJEn
         n7b33BFwhPybTU7nXRJ7TgfNLw2u4V+1lltisLiutXiueWQkHbbq24cjJwCSBeNOmhBC
         OmnVdrekwSod9Y8RtEAK1FsLu6hqqIkMHqoypjL6gLEIKTI20Eu01WSAQovxzG6Q+xHl
         isMpYclBdrSb/PeXsdKdEaYHVYIB/oWvCJ8FLGJ8SYlfe0t7RoxL/OV0Qm0e/UCW8MqB
         KBTw==
X-Gm-Message-State: AJIora/McJ1oTzmzY472jufoUpUlWtOjcgq6LnTB5izTX+FLDAB1KAC/
        WlmqQlRR8PpaH+UcpOLHOtvTG1RoTLfjpw==
X-Google-Smtp-Source: AGRyM1tg8DdidEY27FdPh/Lppv6jTzqtthp91NkTIcSPabx155hPXicO4Odsw2C6jZWSQy0udOlSNA==
X-Received: by 2002:a05:600c:892:b0:3a2:fb4c:2381 with SMTP id l18-20020a05600c089200b003a2fb4c2381mr914205wmp.89.1658263665139;
        Tue, 19 Jul 2022 13:47:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/24] submodule--helper: add skeleton "goto cleanup" to update_submodule()
Date:   Tue, 19 Jul 2022 22:47:11 +0200
Message-Id: <patch-v2-20.24-7882e33cdca-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a skeleton "goto cleanup" pattern to update_submodule(), rather
than having branches in it "return". This is in preparation for doing
something useful with the "cleanup" label, but for now we're using it
as the equivalent of a "done" label.

The "exit()" branch is not handled yet, and neither is the exit() that
run_update_procedure() might invoke. That'll be handled in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 900f89f549d..3b0f46ad3f6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2544,6 +2544,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
+	int ret;
+
 	ensure_core_worktree(update_data->sm_path);
 
 	update_data->displaypath = get_submodule_displaypath(
@@ -2580,14 +2582,17 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (run_update_procedure(update_data))
-			return 1;
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
+		ret = run_update_procedure(update_data);
+		if (ret) {
+			ret = 1;
+			goto cleanup;
+		}
+	}
 
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2601,16 +2606,20 @@ static int update_submodule(struct update_data *update_data)
 		/* die() if child process die()'d */
 		ret = run_command(&cp);
 		if (!ret)
-			return 0;
+			goto cleanup;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (ret == 128)
+		if (ret == 128) {
 			exit(ret);
-		else if (ret)
-			return 1;
+		} else if (ret) {
+			ret = 1;
+			goto cleanup;
+		}
 	}
 
-	return 0;
+	ret = 0;
+cleanup:
+	return ret;
 }
 
 static int update_submodules(struct update_data *update_data)
-- 
2.37.1.1062.g385eac7fccf

