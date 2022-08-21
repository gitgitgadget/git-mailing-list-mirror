Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D6C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiHUN6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHUN6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B27331
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n7so10297065wrv.4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QzSFAnmN90nqAoOi8T1Xe9XNleKMDBcGXw3m6NCagAQ=;
        b=bytV50PnSTBd1dYdfAUKLSqh0iwslf+oq/totkc1LutF2cNDEn+ZopyE7ogcX4Tm+P
         RIi+PxJHCxQKIBMQAANqYfAgaNv0wy1HB5KnDX+Hmm0Re1tgNwBbC0tHKVd4qcf039cy
         hR/pLxnIarOh77mxJlWj6/Kt0wU2xCueYlOEzaXkI9JfpkCRnGeVuwQoe7TF3rbtpamp
         yl7GIj4GLxwZ7WbymYl3zqRPA6BLcjAXzpSIJp3P732km9dYdifE7x1W5Jm6wDYDfWgv
         tl+/rv8eb3zFx3lZShfrYtzEqhuFV8GDFtHLSSSzcTQFroy8yZh1OGRrQbPHbWHQyC3e
         8Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QzSFAnmN90nqAoOi8T1Xe9XNleKMDBcGXw3m6NCagAQ=;
        b=X2iMXPDrq/FZdtioXSu8HlFwIHi3hSXON0zVyNuzovFwupRw1lJT3n6ku2UNbHQdJg
         D3M0HB8FySVtA6bvL8yslhU0j44J6a8PUAPxHOaSYfpNzbP/OIlskwNsGJOVlsdnMq5T
         V+7j33DLhCPUubOivUKBhJ9JUv3uaat1Z/zVR0ijNURi73snGrIK+bx7vmrZ7tzhgOUT
         rKlND6WfgV2mQCrZd7dFGT1u/7iMWuIOobDEhNUf6rJhFwgVFczHLsTMR4E+R0wbJkXN
         XMROeiYt8RIdx1AttHqolsBqjCMZ5k23EpPdddM9lBZuPo9kLr07t+Pby/mBHiDkxSmn
         EJFQ==
X-Gm-Message-State: ACgBeo1MjlQu1bBfJOStuRvHhVh5sHKX4uPXtVmqz7YMri7eSbH+Wva7
        0HEOepo0mfuKGFKiWLpdRWZtiNqSZDYhupFz
X-Google-Smtp-Source: AA6agR5JvMC9Nan8P78yoiZcbvHif9L936sjnTZ8NYTQFeaJMFc6ixzNOyLDO69zs1ZdtLtscllmtA==
X-Received: by 2002:adf:c803:0:b0:225:3d30:27db with SMTP id d3-20020adfc803000000b002253d3027dbmr5700513wrh.454.1661090306908;
        Sun, 21 Aug 2022 06:58:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/32] submodule tests: test for "add <repository> <abs-path>"
Date:   Sun, 21 Aug 2022 15:57:11 +0200
Message-Id: <patch-v3-02.32-7425f0025da-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for ""add <repository> <path>" where "<path>" is an
absolute path. This tests code added in [1] and later turned into an
"else" branch in clone_submodule() in [2] that's never been tested.

This needs to be skipped on WINDOWS because all of $PWD, $(pwd) and
the "$(pwd -P)" we get via "$submodurl" would fail in CI with e.g.:

	fatal: could not create directory 'D:/a/git/git/t/trash
	directory.t7400-submodule-basic/.git/modules/D:/a/git/git/t/trash
	directory.t7400-submodule-basic/add-abs'

I.e. we can't handle these sorts of paths in this context on that
platform.

I'm not sure where we run into the edges of "$PWD" behavior on
Windows (see [1] for a previous loose end on the topic), but for the
purposes of this test it's sufficient that we test this on other
platforms.

1. ee8838d1577 (submodule: rewrite `module_clone` shell function in C,
   2015-09-08)
2. f8eaa0ba98b (submodule--helper, module_clone: always operate on
   absolute paths, 2016-03-31)

1. https://lore.kernel.org/git/220630.86edz6c75c.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7400-submodule-basic.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b858871a953..6a77d817a82 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -178,6 +178,11 @@ test_expect_success 'submodule add' '
 	test_must_be_empty untracked
 '
 
+test_expect_success !WINDOWS 'submodule add (absolute path)' '
+	test_when_finished "git reset --hard" &&
+	git submodule add "$submodurl" "$submodurl/add-abs"
+'
+
 test_expect_success 'setup parent and one repository' '
 	test_create_repo parent &&
 	test_commit -C parent one
-- 
2.37.2.1279.g64dec4e13cf

