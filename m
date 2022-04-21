Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7A8C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391320AbiDUS2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391345AbiDUS1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3D4B846
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg25so3003299wmb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOJciQByR0PpEVFPL6yjCiXMxNdJ38bge9UgYcT26Ec=;
        b=LycUbstx1XgjfEkcqcZmXw1XHtzmHyF3q6yEx/L8P9v2ZxnYnQhzmOBQVNxY9b+dhx
         lzxC5YldAy+seYzWgr68wOidMtBBb/dxRKh3GvsYfHxfap/ckmqQltHYrn2R5PLi0o/D
         DUd/SIwZskVeyMS/fKX+da2Y3V5kOXg5uFJYy3D2p0vWJyDSVbiV2fD68G9npPsvAL/6
         jGNYw+wqQljOIG481jxUpJYqUgKf9Tx0ad4PXGyhTtIVy+ORGYvyyPtYwQCq4egjbqLL
         YQLP1bq4kwHtC5dzoyOGL7wzNRxX+p+P+1Qgdz9U+rvdW0R4xNzv0Sm5nk49KMrYEfn9
         GAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOJciQByR0PpEVFPL6yjCiXMxNdJ38bge9UgYcT26Ec=;
        b=QQ7lWgsW8tinax2qNOUOyZgy4IUyNay+H8L2npr/JYY2DjOLgZUnnNTBIPhVSM+j9I
         6oYMea0bE5T+an0e3zbTRmuAcCLoe83Cj8xm6heHdm+hQwhVHggnJvywWsXifNMhC4Nw
         uxm6XrsdnqIZsxi9+sWNbEJa1m0Uxj0fNXwBwypXP8S+yB1h9DtSt8Tkd/d8gAftFeuB
         THy83hZntE3rrWgLX4HFCTdXJaVahGx+cej0YUJ5gRESUd9PmabKdkBtCL+IDJQ36FoD
         3KSm+ifr/Dz+TrZesAnfXZeCH5Q6YzSiT2wSaH659k8FjAf6BJOY8EdZ/ZrYoNNa/83R
         JIbQ==
X-Gm-Message-State: AOAM532lkWynFz0HTq2aYK1+5498YPxrc/0r+Ptjg+eC0Fiiby/gZw9w
        8ptm0UaXLaH8vphfsn/8jjQdnn2DXzLf+A==
X-Google-Smtp-Source: ABdhPJymJEHig+OleuB5ra8reOZjtRdUuHkerG9tbWVGjKFvjJqVssKhcJKh4Q1LStd8NhF7Yg7mcA==
X-Received: by 2002:a05:600c:410c:b0:38e:d2b5:ef2a with SMTP id j12-20020a05600c410c00b0038ed2b5ef2amr560098wmi.91.1650565434374;
        Thu, 21 Apr 2022 11:23:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 20/29] ci/run-test-slice.sh: replace shelling out with "echo"
Date:   Thu, 21 Apr 2022 20:23:15 +0200
Message-Id: <patch-v5-20.29-fd0e1610577-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend this code added in b819f1d2cec (ci: parallelize testing on
Windows, 2019-01-29) to stop shelling out to "tr", all we're trying to
do here is to turn '\n'-delimited output into a ' '-delimited list. To
do that we can just use "echo".

None of these files will contain the odd characters using "echo" might
choke on in the general case (i.e. '\'-escapes and the like).

This has the added benefit of not adding a redundant ' ' to the end of
the T-parameter, which didn't matter in practice, but as we'll see in
a subsequent commit makes for slightly nicer output, as we'll show
this variable using a GitHub CI-native feature.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/run-test-slice.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 70326961454..1de6a18ca47 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,6 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-make --quiet -C t T="$(cd t &&
-	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')"
+tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
+	t[0-9]*.sh))
+make --quiet -C t T="$tests"
-- 
2.36.0.879.g3659959fcca

