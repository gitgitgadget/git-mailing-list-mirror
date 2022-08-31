Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D005ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiHaXPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiHaXO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A626A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso429704wmq.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ShTHgaNE6xXKX0jsipPBvSt4Te3BNeZ8p2MOAsFRmmI=;
        b=IkZ4qpmhPiLi4ppCzehSOTiGfzEVuomEAHnisVMCpRznUYZKPo3eUb2IptyrUxWchy
         MERBj2H8r6+VyiHSkG/mg3oTDaPorn8qeNsk4CKRIkZWewlO4l8wIHJgxykKMC4V7/4k
         AJRGk2Us4yArZsgcOzVL/9ducsR/XnPwOE+s1Nxvtgs1PhuyScB4NwarHoH3G9+eYy8C
         0pt1z2cmBB4aXvQRN6a+EOM+i8sARPNtBcoXq32stmJSvgBM1GWDrkzyCr+8ekDiHPTO
         dXkXn+cHCPsI83Gbt9snyAs8J6WfzKfnn2RmjYI5JkE8kQNd3hDous+WTWcBlXKPL2LO
         9eXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ShTHgaNE6xXKX0jsipPBvSt4Te3BNeZ8p2MOAsFRmmI=;
        b=HRL04YeyxFVfDV9kenWFzskHZfw6SeRYYB9iln32sjqALZwTIROquKXkD/DYXTzBrn
         eGAGfVKHJvzeWY8FKg1OeGYRMt0RKeeVUcUBK9vzLaltat9unuBFl1JiPZsF4SI8tgre
         2Y0fgmLdso09zSrdGitwWbTE8PleyQ782qcUiYPWJf/4HszAD5qKcLaGZGIJAjlhclPj
         MRgkMbe3iEuxwuOY0fOOd3yeURNyIQE6ec6OLcEaE7VelphSpdlNAcy22uefItITyb6+
         mlI1fwiD1P/JklnvWmPDE1BIWHy7uNwr3L9YlpNvA4J3cxXEB1d57gwJn3KUDWp4OpS9
         qvdw==
X-Gm-Message-State: ACgBeo0aOhjRYdJmNDTbzoTFt8Qry+tHAzJmO5Msnx6EeBWjPaG6jqWr
        oReLiAZ8EIVuMNIuJvnFutM5fc0JWuVKPw==
X-Google-Smtp-Source: AA6agR70rwFnAoALmqhtDL22GL7HvIa/cAFE572CQnZ0TAxQLIbXPtr7mevJOq2beWh5sVl8t3Ir2A==
X-Received: by 2002:a05:600c:1e05:b0:3a5:b441:e9c with SMTP id ay5-20020a05600c1e0500b003a5b4410e9cmr3335630wmb.24.1661987693795;
        Wed, 31 Aug 2022 16:14:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 10/17] submodule--helper: fix a memory leak in get_default_remote_submodule()
Date:   Thu,  1 Sep 2022 01:14:17 +0200
Message-Id: <patch-v7-10.17-8a016f3d58c-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
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
index 9a277057012..9f9e5f05094 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -65,12 +65,16 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
 	struct repository subrepo;
+	int ret;
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
 				null_oid()) < 0)
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
-	return repo_get_default_remote(&subrepo, default_remote);
+	ret = repo_get_default_remote(&subrepo, default_remote);
+	repo_clear(&subrepo);
+
+	return ret;
 }
 
 static char *get_default_remote(void)
-- 
2.37.3.1420.g76f8a3d556c

