Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0155C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiDMTzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiDMTyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBE78912
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so3517655wmq.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IwY17bPgBCm5VQCcU1j6qM5TL4VUWFJdyOP9C2eNEk=;
        b=OV5KhclmXaeYf1Ypdp6V0MAZ/FCOeHWx9GXVltqR1pPx4vHAXCuzwvH0tfYnDNtnUB
         DOVjaTOB5z4YCoEu61GkKQbQK7xP6Vop0qHV3WkEH9iDwNXgkM0qnHxRBu37dGzMrRvm
         YpPqbS6h3smLywdsBq/c7J7a0frTtjwOONV9O2PdZMjmSMP+qyqtAGDitB4os60aNl/p
         biczNO3FZk7EPPA/GWFX2CH5jxpjqaAequKKBqnrFsN5yQRqEOiwhJoY/rmG981/oR9J
         TfttMji/WfFobc8Y/lXUPl5ZOU+lC+ojVjX8cgdmBarhc2YuMJJPpQ+4oOQ45ZatyKvF
         Pakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IwY17bPgBCm5VQCcU1j6qM5TL4VUWFJdyOP9C2eNEk=;
        b=eeqly11kCUkAhfbwYBF4z4sQeSSM+QVcQTDUjJxJu0mejZeLtePiloQ/9XcV7fKzXC
         JNuf4IQ+TOpWE7CYrAeDEtsSkWyf7V966BYCOZscvd5hm9Tg7YZh4hRxJ6oOfQpOgfGS
         gMtlSU3WRDWH2V+vocKAMl4FCPxlqoH3WGRRPl9hq56k08OUHWLKbJq1CpS1/G8O7Q41
         iPiH57vSvqR3dQ5e6KeBHQQ6e9ISh9Q3zgu6ykOPnuD50/8WAqKRY2HCvAn0hAnIZim8
         HtIBUX2Nzw3IwZ8CTULi8I3WbdxLQTt+70501Z1QwWxzLCtRtvRYyE8llVoCURcsPC4k
         gmPQ==
X-Gm-Message-State: AOAM5315vLmGCmOF/DPwjU/6b0AxdZ60rCi1vGIRITPcCKSNlH3xO1Cj
        o8EX5aQsVvs9MmIkQSSpXZH7lyfxTkOYZw==
X-Google-Smtp-Source: ABdhPJwlDJWnPoXw4OpXSF67bFRU4Hoo49dy8YM4tBWLlYT3UHo/npqZVkBEEz1bizqF2Z4UL/whZA==
X-Received: by 2002:a1c:7416:0:b0:38e:b8b7:e271 with SMTP id p22-20020a1c7416000000b0038eb8b7e271mr271753wmc.7.1649879533874;
        Wed, 13 Apr 2022 12:52:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:13 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/29] ci/run-test-slice.sh: replace shelling out with "echo"
Date:   Wed, 13 Apr 2022 21:51:33 +0200
Message-Id: <patch-v3-20.29-0a92c478d28-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

