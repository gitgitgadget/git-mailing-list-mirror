Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C20C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiKCRHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiKCRHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0378D1E706
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x2so4062703edd.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcLrNtHkZnJ42IpLSwJUjX4Mv4cmRMT3/OGf4Zo4VBA=;
        b=j5Q7WNZ8iADejQlO8mK2Pu8QIwjtGC828eDpm5G4cEs02fRbm3nNLt1mNiIj9nTFzh
         JNrlKY3UkITu1cq+hJ1kr0PRZT/1EaulBobiBtwGa4t9YUy5Pyp22ns6sK4d+hdXOCUv
         0PudyxlnDwyqQMjZt76nHUFiEwrko1nZEWQ7t/Un0cn7B4YTcpXuCIwJSfJm5UMxvqrE
         3rgl/uhO0LxOFSN3u+ZSzmCyBwktsYk5YkF2w+RbprR3kbMm8BieFjQX3HNZRFZA/VN2
         39Vtygvj31WZfWYSFAjZiuUS4pAL93A5qE9StfswO5mpV4h7m2Lw+k9msyA8Iaw0vl/e
         53zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcLrNtHkZnJ42IpLSwJUjX4Mv4cmRMT3/OGf4Zo4VBA=;
        b=F3t1/x19F9m2CF0lkvBsNzxQkzIF3FQQrxfZgNFUgJYS3leBUQIx7D6o3VtBYvKEMW
         XnOe2zmtAIc4JqHxhZeoYUr4IZ/iCCn7roZLJXnCgjpyHlucJr6F+kyJLAzZEl539bMF
         anxZU3N+z2wzkRx8dMEamETn7SAcc1boesOBYyu19U/SZ5UWWTt55FHZiAyVclI/nzbH
         OFKYrmhTqRJyZzbBQlOfTIMvA/6eEaUfGsDPDwjscOIEvokzFWnOmIwls8jXPBpUiEDw
         4TwyJHvtwJt8kYeWoAhnYEWB0dZUKuIiRKwnRq11wqn8Mbvo4MUNzzEfB8pkwwRXFEtx
         I20w==
X-Gm-Message-State: ACrzQf1j3nCyiS4+0+r2cC3VvhF4InFlAtXi8rJossXIulWlmVG+RonI
        kTJ3nymdZniNZ0Uou4wM+dg70UtJBj4OKw==
X-Google-Smtp-Source: AMsMyM6vBLQbkfFBgiN1HwQPN86CcGeBmfasRO6qaG1xqq/6l/vzVbyWCl9gDKJIbULE/pmDttGBng==
X-Received: by 2002:a05:6402:42d0:b0:457:d16e:283d with SMTP id i16-20020a05640242d000b00457d16e283dmr30879437edc.395.1667495188231;
        Thu, 03 Nov 2022 10:06:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/17] ls-files: fix a --with-tree memory leak
Date:   Thu,  3 Nov 2022 18:06:08 +0100
Message-Id: <patch-09.17-d592439760e-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in overlay_tree_on_index(), we need to
clear_pathspec() at some point, which might as well be after the last
time we use it in the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c            | 1 +
 t/t3060-ls-files-with-tree.sh | 2 ++
 t/t9148-git-svn-propset.sh    | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a236483..a03b559ecaa 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -613,6 +613,7 @@ void overlay_tree_on_index(struct index_state *istate,
 	if (!fn)
 		fn = read_one_entry_quick;
 	err = read_tree(the_repository, tree, &pathspec, fn, istate);
+	clear_pathspec(&pathspec);
 	if (err)
 		die("unable to read tree entries %s", tree_name);
 
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 52f76f7b57f..c4a72ae4462 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -8,6 +8,8 @@ test_description='git ls-files test (--with-tree).
 This test runs git ls-files --with-tree and in particular in
 a scenario known to trigger a crash with some versions of git.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index 6cc76a07b39..aebb28995e5 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn propset tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup propset via import' '
-- 
2.38.0.1451.g86b35f4140a

