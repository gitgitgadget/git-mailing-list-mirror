Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA071C4332F
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiEYKHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiEYKFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3C868FB0
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so29435607wrc.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFNU64t9l9NKVz5+L5HcRhgpnKRYfDA/2HV6zPPBjIo=;
        b=QEFopy13SJS9ihY0iLVFRquVGC45WL62AMQ/KWkNopkpO2tRvKiNVnQcOdToYSToa5
         ccbyNwg/ujUeTmgfFnXClvzkyyiWhuKKm2B/mmp10XHRoGQBoSZOHj/vpPi+c6jCrRg6
         QER5AEw4SjJsYqAs+eR886tMvwzXUKKONKyDzwNi74jwKq61jgs2CCz3lM6iBU7Q4mMB
         FouCa7etscxInegnRAlWns5H34qioVihl83ojSdzcJ77xTnRct8jbzT9z3i8ftfwl6IG
         36pHTg/XgC1V1qR0QefEWnPLLDauxSkAyYZga8ba+ECcq7L2qtmt1pvBCX2+xjQ2TA0e
         1udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFNU64t9l9NKVz5+L5HcRhgpnKRYfDA/2HV6zPPBjIo=;
        b=ujDadNTKx3sfcAm8NDelsqBL1VqN6B6JQpH5nXY3FwD8ukls/QfLzOYzA03ZtR2JKU
         JeW3wwG+7UHqyICB+8/31E4oLfziVlXmiNHWSmwhJVLM5o5lPDBCXZSaMWr/5Xw0I1ZY
         9HKU2prRb/FNHleVE/tefGXibtyqk+bViMxmkuF4IS+pgibidPe+gn7nizD6aQwzZ2ZR
         uDQ9NGaQMjKxQgmSWBUZAuKB530pcWTQS0HKGUVMlH2k6OzMM3tsdvCGWBfHbyc/4ayR
         tUL9TIpdRxWe58BP2UOgqFFwFt7UyUmgfKAeF/iwJ0oCKIxqYSm3TRInSNWBBEkJ9fZi
         9tPw==
X-Gm-Message-State: AOAM531tlrAhbD7ZxefzS2sI41Yab1EAFXhizn+KqqHyZABUXAXdUr1I
        hK3/fsQhINWVX8TYOd4MfnkCtEsHtED03Q==
X-Google-Smtp-Source: ABdhPJyt56IKskrKa4sIjoQgPojgO3/4LqojkC9eYbtNYA/vloO703cF4BGAAKHWbn6P833yK7RKeg==
X-Received: by 2002:a05:6000:791:b0:20e:615c:aae4 with SMTP id bu17-20020a056000079100b0020e615caae4mr26536539wrb.206.1653473103000;
        Wed, 25 May 2022 03:05:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:02 -0700 (PDT)
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
Subject: [PATCH v6 20/29] ci/run-test-slice.sh: replace shelling out with "echo"
Date:   Wed, 25 May 2022 12:03:59 +0200
Message-Id: <patch-v6-20.29-bb5960355fe-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
2.36.1.1045.gf356b5617dd

