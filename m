Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB25C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiGNTj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiGNTj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:39:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F425599
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so3922655wrv.4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1+b/mnR2nC4WSiSaWFef9CZN7ZruRY83nx+6ywzNsE=;
        b=EUWcaEYxjf+PctysJKJGEEGAnPH7Vst1KmniX2CgxEXzd8auRvlGcZji9qb1LdJBkQ
         pidWrjiEA6SyKqhmvJrnikBzAW4pW+UEkNZq0pd6EimlR2OFQWtfgxaN/T/HlIBfpsJw
         YhQYt79zHZRU/m69c4Zwce7c3exgtcdzjWdvy0FmRFjWHfj0NsPFcwKLRaR7bnDjnQ1C
         fMoMTTecnv+cIrxoicoDx+QkvS8h4DALZNYVw4JBxaGgE0QqZmr3mXYupY6f/ape+5zG
         OoSThzQyNKgcKq9ii4DgEsLSZHC42H/aDA+A/g2zYk55iPBwYy/l2NK4DlP4A79jFJij
         PeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1+b/mnR2nC4WSiSaWFef9CZN7ZruRY83nx+6ywzNsE=;
        b=ycKjMAfTrfWY8BTlxrp8i01M/3NdqNWDcVVRMHJBwVVvdjEziLwS9Ng37yEanjuHAu
         C/i+FWsTihNoNJp+xBcGIepfwMWHojo613YSO2p3fRZ4Qct77rLVfuATQkBBeCoL+FfT
         VsebG2tkeC0cKHIl68cziM9yz449KcOry33d/+4u8bH9eerAprLGss0AEHv4tvT7kNY/
         H3wbmiwJ+0rqvumdajvNTY0zr9mL8BgOm387NqufI071WYNt6FZHKyRiswZvch81wd+e
         nJydaIQwz78kpTsQuIFEacQHn83tQMN5TjOOgsJGJJpWn440hOcZrDLVU5s0N4FYHMQ0
         gQww==
X-Gm-Message-State: AJIora+RNcjJXiYi4wTr0A5dz6cFhLcpvY9hA4j4ySkDwF7lsqWibzcQ
        Wr85rXdh3plzXau58sIkYziClMBiSKWV+w==
X-Google-Smtp-Source: AGRyM1sRpNS0jk7sNSsm7fjuMSZS+vO1h6JynAeBGEui5MBaLSzvgRzx3LnuH56VOXOelW+34papiw==
X-Received: by 2002:a05:6000:1210:b0:21d:7d54:45cf with SMTP id e16-20020a056000121000b0021d7d5445cfmr9203304wrx.639.1657827592571;
        Thu, 14 Jul 2022 12:39:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] CI: run "set -ex" early in ci/lib.sh
Date:   Thu, 14 Jul 2022 21:39:38 +0200
Message-Id: <patch-01.10-905a9419267-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change ci/lib.sh to run "set -e" before it does anything else, this
help us to assert that we have no failing commands early on in the
file.

While we're at it let's fix a stray typo in
ecaba2ad4c0 (ci/run-build-and-tests: add some structure to the GitHub
workflow output, 2022-05-21), which seemingly added "#" to the middle
of a line while re-wrapping a comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index f095519f8db..4f12bcaabb9 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,13 @@
 # Library of functions shared by all CI scripts
 
+# Set 'exit on error' for all CI scripts to let the caller know that
+# something went wrong.
+#
+# We'll enable "set -x" below for tracing executed commands, that will
+# help to show how environment variables are set and and dependencies
+# are installed.
+set -e
+
 if test true != "$GITHUB_ACTIONS"
 then
 	begin_group () { :; }
@@ -44,13 +52,6 @@ else
 	begin_group "CI setup"
 fi
 
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-#
-# We already enabled tracing executed commands earlier. This helps by showing
-# how # environment variables are set and and dependencies are installed.
-set -e
-
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
-- 
2.37.1.996.g651fc6e809f

