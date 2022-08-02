Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E692C3F6B0
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiHBPqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHBPqV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDD61573B
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk11so8549761wrb.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=chxJsskFM4pw3Zk2pCY3J60HA6hMmmfw2Qk963gExso=;
        b=Jbe2zkqQsFRW5d2hAT5C2YoOl+2qTTpRVws0NxwNThgQ9KqKmdv5qUutHj/OyP2urC
         Rt26W5gNGGZ9/Kkyo1NPwubi/otcK5uGynCmjWmGDWz+sIWXnpV84IExNsAkYojQRWE1
         80vpt8O7QgnbR7Ebq/Ki/oDwYIvMtx03pzVXSTPFSvDPxPW4P46FPW5dyDBNgmZZ3h1r
         J37DYOQnm+RYk9wXpG9XX1ove4hoy5+Of6ehu026Hwc/QAmddQQvUCh08iosXRDeix4A
         i2koYByDeOjxSzsSKW06xikBdgdXH2tnirNkZ39TB12E9wDLXOxqVC7tn5sJEgJxT3sQ
         wQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=chxJsskFM4pw3Zk2pCY3J60HA6hMmmfw2Qk963gExso=;
        b=H7RQ2cAxvvVl1Y8HIM3mC7gqb9st2oyL9NTJhn2vbj/Xb+NNMWlMtluc9gIdZReG6F
         c8QK6NMmljyYon6UdSZjsYMm9E+qCDRB0ICnaSuKDhIOkDG/+/Gjfk9Qiw939uW3jgh4
         rnRuYKoQ45pHuiBDWZQUTVTphCcxk7hmaXSHIdx08irwvSvIZl6Xupn5IQV2OC5qxkvC
         50QoNBMoLnMtRbVfU5TZv9zjOLtNzSW8A2dkS7LIMuhJ0UbCHJOe9CVsv52axmQQ3o2E
         LEDt9kCRJR2sfNIyrcwW0bHhDrDSuPtSiQGC+3bQEMLEpzsa7UFpR7GKFZdFTHk+fPSX
         NyGw==
X-Gm-Message-State: ACgBeo3GdYP7YcpEep6Tq8QO/9GzbHpYA4oFxJMOr9rY/JANxlC5b1N+
        yFAyIASPNlySBLfa/CyIDNSsc5tAHOq8lw==
X-Google-Smtp-Source: AA6agR6ME8azWTRI/rYlDHjkCHcpGfKG6rm+F6O6m9Ojmd2nvs2v3j9d1tuAwlAINkeFvyVNeOkpFQ==
X-Received: by 2002:a5d:5223:0:b0:21e:fc10:b818 with SMTP id i3-20020a5d5223000000b0021efc10b818mr13766017wra.676.1659455178903;
        Tue, 02 Aug 2022 08:46:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/28] submodule tests: test for "add <repository> <abs-path>"
Date:   Tue,  2 Aug 2022 17:45:46 +0200
Message-Id: <patch-v2-02.28-9d920326df3-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
2.37.1.1233.ge8b09efaedc

