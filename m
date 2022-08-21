Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89627C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiHUN7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiHUN6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40714D3C
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so2365910wms.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G999UANO/P//+oBJzGxMvACgs143Fxywo0p0bcC5tJQ=;
        b=UguXMIUhQ48qAL1zP070EubicfnfTwV7Aq4xv1Se3aALX8XGJz2vU9qlxDT4A2geMM
         TsTNAv5tvoCKrmBjA6w+hw6viJHwqB6gpcZiUnBJCsIXC4fdXCaHu3IcOfAmpnAfLGij
         Mn8L++FfNOyaNIkaZAvxufMTNviZp9Uuva3O/IfDF5dWVI3t2qx9PZNDseVpC1l29Lfe
         1YUgzMw32JWdpKTQmC+pm1FEXMY5oVE20qvphZ/fvbANQS08Y+Z2l82rMw8nDPfPO9nE
         ktihiPVd4q8OZJ6E7mJ6XhoTpz/6mgVoPQ1S+vciutAvWhkJ8YoF558WySUTggjvG3sT
         V1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G999UANO/P//+oBJzGxMvACgs143Fxywo0p0bcC5tJQ=;
        b=j1EVIUnXxMz+usGKCz1bVf/m/WjQCCo4q8YnuhdB+d2KMWIBnYOFfgrIwLoI0yCqY4
         uVqqo/krHmas5HhekK0q/+9TX+I/oX9cjIqWVjCzYsQ0YbQXsHWeWvNrumVMshuFM+z2
         bgAFu3QtG5hFVvs7cxbTP/MRpWV1CQMP+F5JiReLrIuAlsandUFjOJGKkhzd38Rb4rXM
         mEiV48Uz3mKSJdESryRYbn8383xW63m3f8njF4OJAnMxBS5PoCv62jQFFxixV0DBIr70
         1flWdXUdqUic+tvYGf75bazQ0ZfwrjREGBfsM427TPSeCTiwO/exYgrrikHd6Ci27/cE
         s9fw==
X-Gm-Message-State: ACgBeo2wKXCtXyxLKB2luF9BzXlBZFNWLXYmhby60X3FDclfWRc7N7a/
        zHfeXqtzZLMqq6wNsyCNWkyQtaHEJ/SBxZ5Y
X-Google-Smtp-Source: AA6agR6V9Ih9LP4WPID0MaFBAY+hfmkiRU369Rgw/qRPJG96GpSLLxJWNcec8qVTXATZkI0l0xmpuw==
X-Received: by 2002:a05:600c:198e:b0:3a5:d4a2:8896 with SMTP id t14-20020a05600c198e00b003a5d4a28896mr12383326wmq.140.1661090318038;
        Sun, 21 Aug 2022 06:58:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/32] submodule--helper: use xstrfmt() in clone_submodule()
Date:   Sun, 21 Aug 2022 15:57:21 +0200
Message-Id: <patch-v3-12.32-241ac5c7eee-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
2.37.2.1279.g64dec4e13cf

