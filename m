Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33529C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbiDRQb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiDRQby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6432FFDE
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q3so18493679wrj.7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEqlY6U6PlCUIzLdeezxOgI6odMhWBJsQI3JUpwa+QY=;
        b=TGQwbPZ64aQ7NejaVqtEiyGOpkg3nBZ1sJiGUABYO5VqypDa9Szp5I7YgowKYdBwNp
         Y7YWZEKCaG8Ic0n2RylT6nbIOsD/bHK9CRdYAWvL2Q5U2ZIme8ed+xnni2TYCMit0C/l
         D4sVbS+YkqsZu//dmAAT/UlFRiKxPzpTEvuLBwTFU/EcYKx1aMrHmr0tgpPJqEs2NZfa
         JMEY8GA8cuTUidnW6qPkk3+55r9J2bh+sSGCLmzG8Rv1C0PYNNeOfrZ+VJwJCG38Pa1r
         NH899DyH4FKrNLRBsZeNORq2jNBVS9GYBobNW+HRle55t8ocqnpZfYNcMup8U6t86dvp
         1kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEqlY6U6PlCUIzLdeezxOgI6odMhWBJsQI3JUpwa+QY=;
        b=VQyeqMI7Sykq+2vSuLWwwbSDVoTse6FlEgFUx1InSXNC9aKUqxkO1FZ2kuwn7wtUKU
         VVUW7mV0McOq+TDdGC+QWwgfLobehOM41iEqH3x48IItfoylqWMCVQA+EFdGh3bm51ma
         wD/1dnYzStfYPwzmbmG7rLVwYo2YCJo5jxP4p4UcaZjqAw5Ga2PRXW4spBX0KDOpRbIu
         scaROLLKjyBaKZK83zvDXQe/1xTVV2voi45rKIJgLA8rVwgJjWmS4eoWh9RaLyXe9/W9
         SjIqXL/MUQ12S4Yxn1se2ZtYLM1lr6CpQiNSLOiTCY6wxHRDQTRsDzXIR0oAbx7Qos9n
         9zBw==
X-Gm-Message-State: AOAM533Zv5wVBRm+0FmYxPBw5qbq9T871L9GGYunTFmfLfrVjTvHE9w+
        Hs5EuNbRN9JVnoruHITlavNlwU+UMQE=
X-Google-Smtp-Source: ABdhPJylgF0TRXQeeHfzYMaTShE2v3CA/1NcfwwmJsQA/AjCBFDTfcn12rigDSrIg91trDAgZ6P1VA==
X-Received: by 2002:a5d:47c3:0:b0:20a:94e6:9efb with SMTP id o3-20020a5d47c3000000b0020a94e69efbmr4925287wrc.75.1650299352652;
        Mon, 18 Apr 2022 09:29:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:11 -0700 (PDT)
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
Subject: [PATCH v4 01/31] CI: run "set -ex" early in ci/lib.sh
Date:   Mon, 18 Apr 2022 18:28:38 +0200
Message-Id: <patch-v4-01.31-ed27ca0b7e7-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change ci/lib.sh to run "set -ex" before it does anything else, before
this we were omitting a few "export" commands in our trace output that
happened before we enabled tracing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index cbc2f8f1caa..57141d38a85 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,11 @@
 # Library of functions shared by all CI scripts
 
+# Set 'exit on error' for all CI scripts to let the caller know that
+# something went wrong.
+# Set tracing executed commands, primarily setting environment variables
+# and installing dependencies.
+set -ex
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -85,12 +91,6 @@ export TERM=${TERM:-dumb}
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-# Set tracing executed commands, primarily setting environment variables
-# and installing dependencies.
-set -ex
-
 if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
-- 
2.36.0.rc2.898.gdf6bbac50ff

