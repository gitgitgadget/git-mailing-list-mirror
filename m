Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6343ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiHaXS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiHaXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978784C636
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u17so865910wrp.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OcIYZF5IzBdevD92f3nHXcWZ8HO3OrAOxU6KNABBfRQ=;
        b=EFuSBrgZv65eYzsqCdkgSkyLYxP6PLbQ842v1v6m6U+a2w9TF+/bzxwX9O944K1diS
         yD2II0SxqhT9viv+JekCzwMDuuO/t/8uz3YtThKGuwuy9dNFj6DNZRCcoo1gp8TsBs8x
         O+gD/Gi1N8hrhpdwZq36nwgq6eW5kYEfKvPxOEaVRiCVUY2yFvwHAG+P9viYZQCATm9s
         4Ah9v+BMKJ+V0EgPym85qv/e2JrmMkUhEmDC9EgeAC5CHIpPw91h2idJ1WNbMoUXm9da
         kOIx7rXiPAodFQpE63cP8gceSVRhxrmMtZFZ2bzl2dPVmILmDBtgocxq968YWmcWPvT6
         OlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OcIYZF5IzBdevD92f3nHXcWZ8HO3OrAOxU6KNABBfRQ=;
        b=Zd5iDjDKQtxzkdwfSENcBNucy8kdMDvZXmJvvb1rLhivJ528R1ha2IjlEJ4Lb1rM8d
         RWye/1XzZlvDUv+1NsxWhf7wek8B15Mso4SNOYy31PTaqJeCPviQJ6vgR5ZOJAnS2YXn
         OqgmI/dYiWHFDqIYcA3x92/f3SbPfDRKFsCOkNljIO4zdqPI/8Hgl/chiShIrS5pqVQ5
         ujeGHE9Q43zEAMyI7LcA3G7uERkHQnxMjO/ozuYY92//UJwZGEnhWgtUGMX8Dsa0AfMt
         1BzWTLLFMC8Z1CgC2RV55YOpTcleVFwqLMBvwctS8JFcNTh8rxiuqj+ndm16jZhoaSAm
         xqBg==
X-Gm-Message-State: ACgBeo3n2lFieau089ZFTs9RVAdET0Dd8EGmF5UivcA7qYAKHfP/Dvu3
        4ci9LiNBY6eZ52Tn7hnlaCch/YJnZEPvWA==
X-Google-Smtp-Source: AA6agR4voYPeZvhpEvHN3PS/qGGUJGLR1c7+YkvQBzRpgLAU9bTOAlLP19T6ls3lBECOkPBra3uGhg==
X-Received: by 2002:a05:6000:1888:b0:222:c96d:862f with SMTP id a8-20020a056000188800b00222c96d862fmr12502688wri.706.1661987910021;
        Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/33] submodule--helper: use xstrfmt() in clone_submodule()
Date:   Thu,  1 Sep 2022 01:17:54 +0200
Message-Id: <patch-v4-12.33-84504a86a72-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use xstrfmt() in clone_submodule() instead of a "struct strbuf" in two
cases where we weren't getting anything out of using the "struct
strbuf".

This changes code that was was added along with other uses of "struct
strbuf" in this function in ee8838d1577 (submodule: rewrite
`module_clone` shell function in C, 2015-09-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7eb9fb2f00f..c7833bae81e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1571,12 +1571,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
-	if (!is_absolute_path(clone_data->path)) {
-		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data->path = strbuf_detach(&sb, NULL);
-	} else {
+	if (!is_absolute_path(clone_data->path))
+		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
+					   clone_data->path);
+	else
 		clone_data->path = xstrdup(clone_data->path);
-	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
 		die(_("refusing to create/use '%s' in another submodule's "
@@ -1628,14 +1627,16 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    clone_data->url, clone_data->path);
 	} else {
+		char *path;
+
 		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
 		    !is_empty_dir(clone_data->path))
 			die(_("directory not empty: '%s'"), clone_data->path);
 		if (safe_create_leading_directories_const(clone_data->path) < 0)
 			die(_("could not create directory '%s'"), clone_data->path);
-		strbuf_addf(&sb, "%s/index", sm_gitdir);
-		unlink_or_warn(sb.buf);
-		strbuf_reset(&sb);
+		path = xstrfmt("%s/index", sm_gitdir);
+		unlink_or_warn(path);
+		free(path);
 	}
 
 	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
-- 
2.37.3.1420.g76f8a3d556c

