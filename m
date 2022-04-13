Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F2C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiDMTyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiDMTyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75D2FFED
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:51:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q8so1527041wmc.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AT93aekwZkrFPALjFFzKF49BVsnvhcFhM5GfPgohGI=;
        b=es3uANGuCpeXLxiivy9CPOW6K4IY+g8/n67cYQmrfy0qMyPnp7MbmSFL4oNZgE0UxW
         vMLDlMPuiQ5UoSG4Nh0hnOBrzd3oZv5nSAoGnsep0CkZu10jDzg9GD2hMhJF6Q8qKFcA
         U7Uvb57tGUke3aJn9zsECte4+h6rmZ5KLAKQGOr40uJmQCZIGzkFQPbjOBLGYMxqt2tw
         JIJZhmIYSM9cA9+IvaI9Dt58WDrd0qvyk/ivo3HJ7YGgxGF/rsLeIWe0R7BcdgWM1kI/
         PM97KNqMOTcsHuVf5ugzG1LsSV/yy8/55PuiqbePxgzwDqPEX/BMTLCgj3gmWu6TVpAc
         g0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AT93aekwZkrFPALjFFzKF49BVsnvhcFhM5GfPgohGI=;
        b=o1PAp255VHvAW7VU5WczKYrU+LNHN/7H8xwq2rdeXhMGxlYnoT/B3gcxUqVcSSV9ii
         e7K+DUgglTW92hF1wwDgjuXVocnYAHNs0ogZUNMT3IjCD+Nf3dEXX3UowrwD5Yx7VX4Y
         CJhAReo22VaJMZ9dNztq6Gzh/2nGLOIm1XbsxZ6EzEXlzTtQnTg/OBehPwI5/Yyxr6ps
         T9IP5vBokLl/N3hT0bklW7n/p4LjTCDvD3nwJC+djdXitlblSdzRLZZoCBNmAcDIzU/2
         BIoKHBzvXKk47mW/3qH/7HDMfcQnZZOkuWzSR7l0jF478Q9Jwa3dtKyPw6eae7ObMBy4
         aYhA==
X-Gm-Message-State: AOAM532XHL8nWfaAWCjOs2SipwaRTOsK8RaT4Y5pV+fzs80I8xlxGiG9
        eUt42PPLDVGJS5y+ccBAri6aS7C+Qr1lCw==
X-Google-Smtp-Source: ABdhPJy7cC6kYFYRjZ4vftrpkTwHKB/FmnBJQDc/s2wPhNJ4R9hiJtdDVMJyA4HC77uGe7fsFYu/rQ==
X-Received: by 2002:a05:600c:5122:b0:38e:bf28:58d8 with SMTP id o34-20020a05600c512200b0038ebf2858d8mr258541wms.107.1649879514396;
        Wed, 13 Apr 2022 12:51:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:51:53 -0700 (PDT)
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
Subject: [PATCH v3 01/29] CI: run "set -ex" early in ci/lib.sh
Date:   Wed, 13 Apr 2022 21:51:14 +0200
Message-Id: <patch-v3-01.29-3cb4749c5ea-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

