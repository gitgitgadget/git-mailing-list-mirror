Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB872C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiCJN6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiCJN6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13A0141FF6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i66so3281532wma.5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OV/oEB8EmP/cEtCwmJ2WBG66N1H/py1ld3DUjHPv6sI=;
        b=G50xftEhYsah9HeEsDQ9OkVjTZ6KzxBFlrpaUzq62pW3s6sCrfw4Jn2D7fWnXjLf9M
         vm/1xoui4AKVMz9ITJ95HeZvCcX6XNCBS75YOi0cXKnhetvrJ+483zbQNJH4Jl+c1hIk
         fJUeWqA0qUJLJTrv7rU+wrzUB09R54aMoHHYmY2OMBra+Pzs8knNxdnB5oZBNX63jmY9
         Kf5y2VRdmQoTl63XSEhrlkkbrm89/CafiEbMZFnyB51Y9NK2fTqmalPxPMuT1v0KcNkU
         iyxqWrvqOzDeGHdxmUdEi7ihYdQqD4n1G7Of6RxaZrgr+OXQWl6QiLZOq6FIiaH5l/LC
         pFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OV/oEB8EmP/cEtCwmJ2WBG66N1H/py1ld3DUjHPv6sI=;
        b=eotQ13X5LVuuxrErHTYBbaLWLHN5sgdQw0vj4OHrixdsfR5pLpLFrFda9P5Wj1tWCZ
         sVvnM7x/nUZwtybCKmL47j3hcld1hrTG5PolHymGwLvrsztka8EZ2OVHegi+PDzpgjZj
         6iMttSPR82EJobejE8iaJcaGA1gS6bRldKaT87YPWRbwXWwVloOtmSNofY2ch1Koy2Ve
         sT5Dwz8GVQs8jmMEM9ELj8cUNTH8kZcn00AZC9be7LKyzFqe1TOb3TA1sOmJFixgXU5f
         Mt5hO/d9yFUJwaQB+KjFN8SXThrIvyHSVHIBsMlI5x+RZeEiXJaZJ1benaLucPKHMUf+
         9I0A==
X-Gm-Message-State: AOAM530+1C2s8IJAgQoJjVGiMBz45M/i0zB9wSNqjGDfTLcLZ7GwAMwB
        dmssnAit26AgRWxDGFL27WhYefNhxkx/Sw==
X-Google-Smtp-Source: ABdhPJyItrBOP+VMScSWkWFwLrHNnygLfM0R81qFxB75OWMjP51J4ne0iMH0Xm/nRWpeyacZclJ85A==
X-Received: by 2002:a05:600c:1d18:b0:389:cda6:f39f with SMTP id l24-20020a05600c1d1800b00389cda6f39fmr8535696wms.69.1646920628749;
        Thu, 10 Mar 2022 05:57:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 1/7] ls-tree tests: add tests for --name-status
Date:   Thu, 10 Mar 2022 14:56:57 +0100
Message-Id: <patch-1.7-953a20f5844-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --name-status synonym for --name-only added in
c639a5548a5 (ls-tree: --name-only, 2005-12-01) had no tests, let's
make sure it works the same way as its sibling.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3101-ls-tree-dirname.sh | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 05fde642259..217006d1bfb 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -201,31 +201,34 @@ EOF
 	test_cmp expected check
 '
 
-test_expect_success 'ls-tree --name-only' '
-	git ls-tree --name-only $tree >current &&
-	cat >expected <<\EOF &&
-1.txt
-2.txt
-path0
-path1
-path2
-path3
-EOF
-	test_output
-'
-
-test_expect_success 'ls-tree --name-only -r' '
-	git ls-tree --name-only -r $tree >current &&
-	cat >expected <<\EOF &&
-1.txt
-2.txt
-path0/a/b/c/1.txt
-path1/b/c/1.txt
-path2/1.txt
-path3/1.txt
-path3/2.txt
-EOF
-	test_output
-'
+for opt in --name-only --name-status
+do
+	test_expect_success "ls-tree $opt" '
+		git ls-tree $opt $tree >current &&
+		cat >expected <<-\EOF &&
+		1.txt
+		2.txt
+		path0
+		path1
+		path2
+		path3
+		EOF
+		test_output
+	'
+
+	test_expect_success "ls-tree $opt -r" '
+		git ls-tree $opt -r $tree >current &&
+		cat >expected <<-\EOF &&
+		1.txt
+		2.txt
+		path0/a/b/c/1.txt
+		path1/b/c/1.txt
+		path2/1.txt
+		path3/1.txt
+		path3/2.txt
+		EOF
+		test_output
+	'
+done
 
 test_done
-- 
2.35.1.1295.g6b025d3e231

