Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703CCC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiHBPzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiHBPy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52CC19C28
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a11so7423936wmq.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CnPB7ev8Zltt6mKNZY5o27O6N9JdTersH1rqYJQ86uk=;
        b=LbvlXd6YcnY3kk8d3m6OrqwmKJ59IrBmQNfMCw3VPU8cwGcIADUOMHgLVjj1Z4CIQX
         p5qKo6jFSZYCTTT26aff13OgdnoTCUDn7q/MsXA/KOUTnyU4KcKpe5Oqd99CCnY6r7wb
         U1VYejfTtmfGF7NziL8CXG7iik2opsDWlELL5cmyV9Pvr7HkEOmuzSB0YJLXyxvbRLqA
         H5sd0L5Qlov1+aLJQzwJw5d/MJFBoe0gLss0pINPVcKm3i8ldz+r0MlVhOfANj/GKyt5
         vGLLLe9R/kRC0Kv5aWOsquQfizG0CwqJ2/xiP7tOAY+muOIa4+heNhrCk5DwXQ1Q8Gu8
         8/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CnPB7ev8Zltt6mKNZY5o27O6N9JdTersH1rqYJQ86uk=;
        b=6To5ieNoX4siqRJlF9C6SxjUIO7jffaCefYSmWHVhQsXnbW/g94VVuiFNjnnEzrEau
         Ec+CexWuaEzaY8IZxdNnr4eoW9aXXri9XlG4kfsBb4duXtYwmf1wpFdbASNmDuDR06f2
         9p5vyvCaGycJsA0wR/oifDKOvZlRDy3klfLYEqF2vectiDaCheno8vf2JwQiKOY2BFxg
         7jxWYq9OLky2qgqE34ymczK3F0ponRQGtyO3jpOx2+sA58jfOYohlmheE5p4gaWQOl3s
         eDckcu4uKCCwDurz7Fn69Apjs93BQaRYbSTaWHOSFXYY/stOAu/o1c0/gvevvhdskRRz
         fj2A==
X-Gm-Message-State: ACgBeo2q6f51dobXDpKP88hdDBMUp8cqsyvwlrIpqatD1pQLfuYqBkgD
        +H/5cO5FyjjU0aW/H9VcLJemZxHHJLYdLw==
X-Google-Smtp-Source: AA6agR4w22G8P84DDx1Fi/488OpLlstWoPA6kvHgTjgBdiwrtyFl1oFqx0/dO2DRAISf+EyLvkVt8Q==
X-Received: by 2002:a1c:1901:0:b0:3a3:1be3:4df2 with SMTP id 1-20020a1c1901000000b003a31be34df2mr84240wmz.146.1659455694959;
        Tue, 02 Aug 2022 08:54:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/17] submodule--helper: fix a memory leak in get_default_remote_submodule()
Date:   Tue,  2 Aug 2022 17:54:34 +0200
Message-Id: <patch-v5-10.17-38345ec76bc-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index 4e964a2c29c..902349976da 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -62,9 +62,13 @@ static char *repo_get_default_remote(struct repository *repo)
 static char *get_default_remote_submodule(const char *module_path)
 {
 	struct repository subrepo;
+	char *ret;
 
 	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
-	return repo_get_default_remote(&subrepo);
+	ret = repo_get_default_remote(&subrepo);
+	repo_clear(&subrepo);
+
+	return ret;
 }
 
 static char *get_default_remote(void)
-- 
2.37.1.1233.ge8b09efaedc

