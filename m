Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A296C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiL1SAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiL1SAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7D17E05
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso8541414wms.5
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TISjA0apihEl3pCG1zbo4y5xSb4rixiX32mGlnAjcE=;
        b=AoHRWeLyFfxGZGoTm0iAidVCXnguHM1pRrKJub6+u46mpxH3bfoeZ1BOCCCehqG44+
         ib5+LSQbrz9TKHbAdPoTiDlUc5GgPvGKenTMNZzPD5hanZ6XJBCYpWJsrNwmXF5uKoNX
         8SWIZ4ak3iO9DXUIzsBJSKDc/IMc+3OmffZzcGcMCchlRjHWWqRW8S0UV1DwaxPe3EDW
         dsagkOti0jRtVYJfYumPeAuZe9TQFCfSooJJQy2pPyEjbbPQ9p5gFh9ph/QPqmtVZytO
         Z+d/XlQ26t4ZQkrF4Fg/RiPm15BcmeRkfdP26KvRnShMPba87OFAdNRTcfz5pKTmyxfN
         0eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TISjA0apihEl3pCG1zbo4y5xSb4rixiX32mGlnAjcE=;
        b=cVKSZzmJyiRAGgcYa3vSu5NRkBzQODkYEc9jiFsWt7CFacVKxiTxgMsTxD3gtMerm+
         F6w9+KxeBzKJwCKVLuxne/sQCWi5JjFva40e58T7nqF2ww0tHMvNQUiEYhSU7zdEqCKI
         UY+K8dW7YaawcHL5xvJ3vokrBAB9pgG72aP1eWMNmDogC+9w+Cf3FW0vu0ULTPdodywI
         xnqWeuASN/57HZIszIpuWzqfvME9f4vakAolr6GBcOqPjj+SC5Np5fQBx66l4NkXcpsC
         eHCybIq2d9/J6KMPjdeLFFzfg2HKJwKl46dADNvznNpnEI1xRYr3JaDfvMhlSihaw4Fz
         OBDQ==
X-Gm-Message-State: AFqh2koLAAsEo6DFxz04IZUTMAANtaIjgiibKHHYs91o/oBxdwWJL71b
        pSNQB9x/Xg5I50+HqoZ8zZuyzHTh2KPEMQ==
X-Google-Smtp-Source: AMrXdXtYzXzFUoV5ZA7ijUGnRz/TGfg9leX2OF7fqqeezT4wduEwGESw6/23takYo5EYSoxc8oCNww==
X-Received: by 2002:a05:600c:1604:b0:3d5:b222:20a with SMTP id m4-20020a05600c160400b003d5b222020amr18466976wmn.32.1672250431205;
        Wed, 28 Dec 2022 10:00:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/20] clone: use free() instead of UNLEAK()
Date:   Wed, 28 Dec 2022 19:00:05 +0100
Message-Id: <patch-05.20-49e6714939d-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
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
index f518bb2dc1f..48156a4f2c2 100644
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
@@ -1392,7 +1393,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-	UNLEAK(repo);
+	free(repo_to_free);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
-- 
2.39.0.1153.gb0033028ca9

