Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19485C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjBBJxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBBJxH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982859E5
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg26so949614wmb.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOtckYi8qxV59qg3momEzfXfGro8Sqx42RrYuErg3SY=;
        b=UephVU5IfxITva7Zys9/ZAw+lSuC0Pl3XAy6qp0hkJAVC45ZnBFNdAvg4O0xdanWhv
         IkcsOBLD9/EF05l/FvmwX8c1XdT6GZQDTukkWesc3fhJTA5FSREIpxgGLedyPbWlxWXk
         ajYxrdjM6ptcGjH3OaNtJ9+irzaX3eihrr+ZVL1IyiGdwJaZJARfhTj8vlQ6bhOe6Cod
         TesftkUPt4dVZrpNyf+kNEAAITIIyI5bwi4/1LgjW0MVjHgBp+HaNfq9JJyS06mKkm2N
         19l89gar+swCmZxry7qsHxjWcdeLjaidbV1V0eusnJJWTSrEVsRoY1/nW3SMhvWZbdQK
         sTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOtckYi8qxV59qg3momEzfXfGro8Sqx42RrYuErg3SY=;
        b=bJ0Gn/2+qeNMpRhO10nEg1lhnebJdyrjbZCtAZjk1ALxyaNdR/QFQVBonjqctAC2Ir
         t05ikdOefscJxrIn5FuHmCSS2dmD+vMab9YAnIMqH/CP5sSsTWpKRGKmuHXn2VAtGCea
         iodnPvGBtIBr8QToshqH5Leju1cM9/H7/bWfC8cG3eCMAEtruqb2iOf1+OryBs70vsI7
         oJEZWNNoO/BweFBfdUOR6EhcLUV5SXrjZugKtOhceJga1GmvtOwXhRYYv/7WIonu6RyS
         a3euGJstJHuRdE5GCl/JEKN4FxuroxGDA07+jyUQ1DV/jcmzLjySBYy/jMn+Cizw93mn
         RbCQ==
X-Gm-Message-State: AO0yUKXof5/g0p1rn/lBLB5H7Xb2F68ZNn7dKUnAIsE1EVxmc9sQ15RS
        Ltgif8NAbJ0jALlQjkkb/fNVo2itP7rhRvfc
X-Google-Smtp-Source: AK7set+hg9IOkzyooT3SK4KhS9L/Jfz7fQEs8rg5u4nC045h8TI/TrtxscOsMQ8YJxFdLz19/ipQMw==
X-Received: by 2002:a05:600c:1f10:b0:3dc:4356:533c with SMTP id bd16-20020a05600c1f1000b003dc4356533cmr5194736wmb.5.1675331579613;
        Thu, 02 Feb 2023 01:52:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:52:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/19] clone: use free() instead of UNLEAK()
Date:   Thu,  2 Feb 2023 10:52:35 +0100
Message-Id: <patch-v6-04.19-0430c1fec1b-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an UNLEAK() added in 0c4542738e6 (clone: free or UNLEAK further
pointers when finished, 2021-03-14) to use a "to_free" pattern
instead. In this case the "repo" can be either this absolute_pathdup()
value, or in the "else if" branch seen in the context the the
"argv[0]" argument to "main()".

We can only free() the value in the former case, hence the "to_free"
pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5453ba5277f..ba82f5e4108 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -892,6 +892,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int is_bundle = 0, is_local;
 	int reject_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
+	char *repo_to_free = NULL;
 	char *path = NULL, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
 	const struct ref *refs, *remote_head;
@@ -949,7 +950,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path) {
 		FREE_AND_NULL(path);
-		repo = absolute_pathdup(repo_name);
+		repo = repo_to_free = absolute_pathdup(repo_name);
 	} else if (strchr(repo_name, ':')) {
 		repo = repo_name;
 		display_repo = transport_anonymize_url(repo);
@@ -1413,7 +1414,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-	UNLEAK(repo);
+	free(repo_to_free);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
-- 
2.39.1.1392.g63e6d408230

