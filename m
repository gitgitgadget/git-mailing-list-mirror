Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD1020248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCLhp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41107 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so8186240pgs.8
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMiXl1MxKUOko0eG2ftuaNwMJYbmJV8Dmae7pks8mVA=;
        b=ZfYFHJcnzGZEp6M94/DwARrSp68tLMfuURg52pQav6n5cy7dIkgfYXCfIAE3KWFcHw
         Dh/kq8jytNMb9jDU8MUJ47pCmKWun3o/rcT5JSrdlN2QY4I67jKAH0HSkQqESKzeaAyS
         UTMnErXWYxsX1oO22HxzRk/AGO7sdeTBzEcMDcpBtnpsEqcE7uo8WShs70z163WRTwlb
         27yHoB9m87Bg1rP1Ha/mbsM6m19tbp92lfMBf06jfjt52egGkCY6ByTPY1oPXmUo8f4C
         /1sP6T9IR7KeIoZzRkbeib5N9Jia8TDtTwuzPWHHLH97ObdUNGzdL4gn2z0tIwjbg45W
         Ak8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMiXl1MxKUOko0eG2ftuaNwMJYbmJV8Dmae7pks8mVA=;
        b=F8rAerDPk4RtB2j/iBU9E/6VLzztsegXO7l71PP/WScCaiBuCPy+Vvh/kOyt9HSZ2y
         vBkrokFqi0wM5s+fkcMk0dYBw0gIxaY9FLUhQmtr3B5bAlwxxnTRF+Y77NgFtXNT1Juq
         NDaUTvBRTHF7rKlLK1ZPXHbY2pnBO7RLYwW+0bHAkbgBMzWjAS8hX3Pk/MaqLs3B7nNG
         g0vR2QNR79wb8TB39njI7ZuKLgF2ipHI7IUHKLxiOreAkP+srZImNsT6RtYota03yWG9
         uyBxzq73vVMt5TEpqqh5zNvKU64lW16stmrQDqUPi2rZjAcD7YrvM5xco07BM4EhTfUr
         KHEA==
X-Gm-Message-State: APjAAAXl9WISH7han/W0WVfQtJ/64i69leTOY4JNLlGKpfOQC13ZCwlk
        2Vk3we52oxrdMfAA8KwPQlI=
X-Google-Smtp-Source: APXvYqyy8i4lerx7/ZqWDnEtIJhhdiwtwoX/oD/vCr4Y08w9g/Ihz47/f7K9o1gDBpdmXyfJuvS9ig==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr35483494pfo.20.1554291464231;
        Wed, 03 Apr 2019 04:37:44 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id s15sm19097055pga.71.2019.04.03.04.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 29/32] submodule-config.c: use repo_get_oid for reading .gitmodules
Date:   Wed,  3 Apr 2019 18:34:54 +0700
Message-Id: <20190403113457.20399-30-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 76e9bdc437 (submodule: support reading .gitmodules when it's not
in the working tree - 2018-10-25), every time you do

    git grep --recurse-submodules

you are likely to see one warning line per submodule (unless all those
submodules also have submodules). On a superproject with plenty of
submodules (I've seen one with 67) this is really annoying.

The warning was there because we could not resolve extended SHA-1
syntax on a submodule. We can now. Make use of the new API and get rid
of the warning.

It would be even better if config_with_options() supports multiple
repositories too. But one step at a time.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule-config.c                 | 20 +++++++-------------
 t/t7814-grep-recurse-submodules.sh |  6 +-----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 66653e86b9..4264ee216f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -625,23 +625,16 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		const struct config_options opts = { 0 };
 		struct object_id oid;
 		char *file;
+		char *oidstr = NULL;
 
 		file = repo_worktree_path(repo, GITMODULES_FILE);
 		if (file_exists(file)) {
 			config_source.file = file;
-		} else if (repo->submodule_prefix) {
-			/*
-			 * When get_oid and config_with_options, used below,
-			 * become able to work on a specific repository, this
-			 * warning branch can be removed.
-			 */
-			warning("nested submodules without %s in the working tree are not supported yet",
-				GITMODULES_FILE);
-			goto out;
-		} else if (get_oid(GITMODULES_INDEX, &oid) >= 0) {
-			config_source.blob = GITMODULES_INDEX;
-		} else if (get_oid(GITMODULES_HEAD, &oid) >= 0) {
-			config_source.blob = GITMODULES_HEAD;
+		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
+			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
+			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 		} else {
 			goto out;
 		}
@@ -649,6 +642,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		config_with_options(fn, data, &config_source, &opts);
 
 out:
+		free(oidstr);
 		free(file);
 	}
 }
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index fa475d52fa..134a694516 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -380,11 +380,7 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 	fi
 '
 
-# Recursing down into nested submodules which do not have .gitmodules in their
-# working tree does not work yet. This is because config_from_gitmodules()
-# uses get_oid() and the latter is still not able to get objects from an
-# arbitrary repository (the nested submodule, in this case).
-test_expect_failure 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
+test_expect_success 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
 	test_when_finished "git -C submodule checkout .gitmodules" &&
 	rm submodule/.gitmodules &&
 	git grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-- 
2.21.0.479.g47ac719cd3

