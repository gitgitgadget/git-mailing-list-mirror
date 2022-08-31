Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D39ECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiHaXSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiHaXSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92BDB028D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j26so8129993wms.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lwUXQcRR7izX2Bon4Yk4V5Fu13Y/6sAUgfkKPWKYrgU=;
        b=P5bwHz/wxqAEk6ZaY0SLgnNOFEY3AaP4iKI7+Ozk+7c6gjTUx7DY4iqewXm4cgh3do
         cUGFS/zyr6wKcmGM6vsFTbWcbetvCKcPs6khfS7nPB0HkuhSenaB9uJINxaf/oAYZg6m
         opj1UiABjnfVWQV2wvyw+G9YDqyRdPK7ruuYzUtYlFUMDjcwR5+suRBDaGBxnRCtJWpu
         HZm0zlUjWWHwcj/kZqfknRK2YmNaw1jJPCrsqGm/OSdptMUdkwfQTA/7ks5cooYVfdVr
         eAKLTus0Uzeb7RP9qa8d7duZc5dbGJj0JhdeojlFtDoR4k1ok4omq5QqK83tpjh1wVUB
         G8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lwUXQcRR7izX2Bon4Yk4V5Fu13Y/6sAUgfkKPWKYrgU=;
        b=MnUM90kV121PGJ0Do6cJSfbza1NX6rT4BmUAPxjNRdYjtM51QXHDW6cEafrvaFM3B3
         i9DnWKrOLXgWmFggSPWpDdvIEvM8jr7apxHe7Myr4AkiDacSQTixDmwehJACI1VIP5L4
         4xlduNaSi5bzQOHVmwCeeoINIatryBiE0EOd6jSEZ+lhaMPugIDHkTBu/lyOyraWyuo5
         YtGlnq3dA3nNoyxZhvSzbscwjhIFfa+9tFelqiHGRhPpryOWYPtMi4H45zIA7+AntY8L
         h7eZOy2fPW/6kGiBQev2Yc+kgRDYpCgEEG2NkXqyynzCVaNa09YrHcX9jUunsplhsoqz
         QDVg==
X-Gm-Message-State: ACgBeo2/uIztgUfjO/olZeUyc37W8ydxoHY4JFpWKn2X7pmdc3loRCRC
        sR7cr8ijkowt+TWOx20y3QB34Tjnqz42cw==
X-Google-Smtp-Source: AA6agR7tg+fVdEJ9GB9wKdHJG7TwhiQG7qPGshlSqqtj6nemXxnDaa+/jec8JC1DNhYCOeJNuIw5Ww==
X-Received: by 2002:a05:600c:1d16:b0:3a6:1fa1:41f7 with SMTP id l22-20020a05600c1d1600b003a61fa141f7mr3160067wms.103.1661987902108;
        Wed, 31 Aug 2022 16:18:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/33] submodule tests: test for "add <repository> <abs-path>"
Date:   Thu,  1 Sep 2022 01:17:44 +0200
Message-Id: <patch-v4-02.33-a015be8e89a-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
2.37.3.1420.g76f8a3d556c

