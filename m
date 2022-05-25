Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB2C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbiEYKEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557196D94A
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so3023493wmz.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyO8MT9SvBP/RX9AuLl9N3flkPYsp1/wEZuSabJg8eU=;
        b=QDVx+wfSy+9pNQC3tl0E4IsJln8NtvoUSyCqI0LIz014VBRx2eDkJEgCuiOSkzOmws
         OcvU6kfX4Gs9pw0Jfs4x3fKtPBQlpOXE30OfB4nEsM/73UDCO8+EeOhC5ErjL82mbjm3
         F+sktc8iOVoTj3wpxScuVO7jj1N7kj+b287LIcwZxd9LN7oJB569eDPl375pj/NPCdKp
         Hpjwz817+5xjlf33IMcTwZCkw/4pVEhJPAzts4sbdIBv0lkhCubrLyk51xCVTHMUSj0r
         9YzsOeVCwRfIIQb+ofbrngT+stt8RolQfvckcIm5PkiM0b7g0maipRRROc2WYq+b+FKh
         eAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyO8MT9SvBP/RX9AuLl9N3flkPYsp1/wEZuSabJg8eU=;
        b=DQShAn0acGCNGIgHpfYijOanitcGREyB7wARjOQJBKONg4Q2/HybxiD7BkQp9dP+nr
         kasuW7S/Tbso2dX2pjit2U56XDmpASjEP4mj8Mc3z38rZnzoL5SVYUI2veUPfs/opdRF
         tzPE2n5dngJE6xMjpwWWSTDfXWSPdzdnvjhJqwPfVLsWSrt2J2+o4wxyHKuMvR3bBkpq
         9vPnFueEdsNVaE2zLB+YW7ibRunKMJyglAymUsSSK45J5sRI3bDRaN9AlCYfjmGmvE6T
         /knyytLCF2P5Z62HFOjVWzJC7P2zZOFkaueiXx1yXLvjNnDD06VcP46dxWU484CbdqU/
         mUMA==
X-Gm-Message-State: AOAM532VA/IZTtV0u0btUYVT87rVKnEtMFVRmYXrEiUw6JmFDJN4ENSg
        Qz4w0OAnDcww1ML7aRd6ATXaylM+3iNQ8g==
X-Google-Smtp-Source: ABdhPJy+AH6RDnyi3oFElnRLOHwJCsmOg2Jc0kxc8C4KWpPYk9GyON/eUyEcZRGb03EgXplGoNiWBw==
X-Received: by 2002:a05:600c:1986:b0:394:867f:984c with SMTP id t6-20020a05600c198600b00394867f984cmr7543236wmq.20.1653473052726;
        Wed, 25 May 2022 03:04:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:12 -0700 (PDT)
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
Subject: [PATCH v6 01/29] CI: run "set -ex" early in ci/lib.sh
Date:   Wed, 25 May 2022 12:03:40 +0200
Message-Id: <patch-v6-01.29-25cb08ad06c-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 86e37da9bc5..57121dd664a 100755
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
2.36.1.1045.gf356b5617dd

