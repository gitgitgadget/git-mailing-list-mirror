Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916FAC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391304AbiDUS0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391277AbiDUS0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DF4AE2C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso3967446wml.5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blemg6QF5VP0OGiyXKjlZppwmz1GulH6TiTTNO90amg=;
        b=o7EEBNvQlf8GUQ1JZEsSlVzXO5jbd7TGb5OF3ciHkf+KygRSagZ/d5Trv9oU2qKlw5
         XLa2LRomWfLwWFfx3Flnai/rP/BtIwyIu/YvwN8Af89RkwiBvICNS5Jh6KPZx+uCPTK8
         DLtWrAD+zin5VOrRQpv3+XKejZQHeSu/iuo20IoJKbhaA/y3B6X+OCOzvPvMllCenryG
         hZqChjgaxif++6LHCluLLiNZM2rDGz65WMqVJrNadEWxNpfmAUtNahwS6ltOq8+lqyLX
         XkyLM9+V3A+t6x9S11tZHq0AytUgLO0DS4LGMSuPbc+E8UbgMVQBbpo1S5GrjCATIFOJ
         Ykcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blemg6QF5VP0OGiyXKjlZppwmz1GulH6TiTTNO90amg=;
        b=5sv9V+iqV5yx8uFwXtdASpDTtAJkz4eRcFP91BtplLY7HTdPrCTXxpwzQsHeti4ag4
         AOP/mmNE/2chR18E5AIzzoen64W+7nue9huW4AYskTVsbd0Z4qUtkl18NosInCYnU1Vb
         XVeCXw01V+yGgTNxBAkTMJfCwcqGhHOVtgCHLCmaHnQgH36WVtkE1JAVUNnj6UXjvOPk
         58myVC7q4mBfam1dk0+9RL1Hv78CogXMYRogXfnGnIoJ5YusAJfVoB9No8wArB/wt1aX
         RpLwJ/aMHNXyvGcAIufR/SnPQBp7tXz1hZ+TgN+iuCuq6mCKwJxOvQBK/tH9OWqP9C5M
         hv9Q==
X-Gm-Message-State: AOAM533QxoKaTExRdYWdrWT4mRa38cusXg8ewaU3n677jTRLN4FVKa3a
        tV/ump7lrEuH1krvrztjlp8aUCk2MVmAdw==
X-Google-Smtp-Source: ABdhPJxrv8xNvYJKmxFwCxV9X+3ml7zDC5Muq1hdOHydo2RTw3AGrctOVoir7xtS83djIAHUocm2Tg==
X-Received: by 2002:a05:600c:1e15:b0:38f:f556:9349 with SMTP id ay21-20020a05600c1e1500b0038ff5569349mr565233wmb.3.1650565415359;
        Thu, 21 Apr 2022 11:23:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:34 -0700 (PDT)
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
Subject: [PATCH v5 01/29] CI: run "set -ex" early in ci/lib.sh
Date:   Thu, 21 Apr 2022 20:22:56 +0200
Message-Id: <patch-v5-01.29-84d8098e365-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
2.36.0.879.g3659959fcca

