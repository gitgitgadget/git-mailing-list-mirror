Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B029FCCA473
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354644AbiFUWer (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354498AbiFUWef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472BB654F
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m1so13083906wrb.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0oSdohpO3qGXHk8coVTQclDrmp5AnR46JqB/ivlLeE=;
        b=b2kk1s1BBs40yUD3bpKMRInEGqKXChLKrCX/NzhVQVzQFl3kAmPWDXBnJ5yIw3UUqu
         35WFM8SxgJesj0NonRvK4fW40asuHuoscLtINErGNY5XLVz7jnINBZJq7tI8Lihg1zp6
         4ZecRZxDtA2PjqF1fI8v1y/dIoYIEMgGMjs5JHOoOnyzV6CwPROpLgzoMmzkyj+Jwmtc
         N9rmGNrsfYNJ7P1g/sKo/uXIYo7P3l+R+4RIYe3S+4hR29o1V2w+AY/B4IsXqbvHVqyx
         LPlpoGVBofBKPdWPAq8dp/ZKLSiWJKsnLOhzhIJb1cDs0DicbFALAbLFy6VFhm6/PVtT
         Ub7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0oSdohpO3qGXHk8coVTQclDrmp5AnR46JqB/ivlLeE=;
        b=XAANr6WGAuQr6QI8JXUN7tFyKQfzIyWIRrzyxYqgnfaz+qwXcl20UYqqUDvVVLrmk2
         MD4twRy7sTPb1EFCB45X5kITwLLfftOCbhtfAp1vidI4RuJxrGRJT9uueF2pUIsevmR/
         rn9xGeTv2I9b5tr6x0yuQRRVom5jzVGs2UA+xMyBH0pMPcXT+Ih01OquNC33WO92SpVn
         CSe9yu2wOBhiM1AlC6UhNvvhL4eFxlR1y7WHJNa4kZsEaCNR3+xKbsrxwols8ZhpNpbj
         agWHNwbP/rqXhR4rzqMlWfjET8S+4iz2rW/saYe2ZIWq7ubX63RwHvM81yTZQCpBweIt
         20Sg==
X-Gm-Message-State: AJIora8FEyvEz4EQHfCaDPglrfQdrVmBocC1DOMMw9VqRT8oHhi78WPS
        cVqqy5wn9Xtfm0MUpDOUR6NiYNG8zd9t+A==
X-Google-Smtp-Source: AGRyM1uj0JtxBMYTTbvulttgz+g9xDmZVljH/zzreM5/IaSbvBkU2eTlpu+V0pJtIHxtZVp5w/JVIA==
X-Received: by 2002:adf:a51a:0:b0:21b:823c:ae02 with SMTP id i26-20020adfa51a000000b0021b823cae02mr212925wrb.25.1655850871335;
        Tue, 21 Jun 2022 15:34:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] fetch tests: pass a list, not a string of arguments
Date:   Wed, 22 Jun 2022 00:34:18 +0200
Message-Id: <patch-06.10-65c35361f88-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up on the preceding commit where we've started to intercept
these arguments as "$@" and pass them as a list, not as a string,
before we'd only have a "$@" equivalent to "$1".

We're still not doing anything really useful with these, but this is
getting us towards fixing the quote handling in
"test_configured_prune_type()".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 116 +++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 477b6dd4953..c56a00f1a17 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -940,82 +940,82 @@ test_configured_prune () {
 # $4 config: remote.<name>.pruneTags
 # $5 expect: branch to be pruned?
 # $6 expect: tag to be pruned?
-# $7 git-fetch $cmdline:
+# $7... git-fetch $cmdline:
 #
-#                     $1    $2    $3    $4    $5     $6     $7
-test_configured_prune unset unset unset unset kept   kept   ""
-test_configured_prune unset unset unset unset kept   kept   "--no-prune"
-test_configured_prune unset unset unset unset pruned kept   "--prune"
+#                     $1    $2    $3    $4    $5     $6     $7...
+test_configured_prune unset unset unset unset kept   kept
+test_configured_prune unset unset unset unset kept   kept   --no-prune
+test_configured_prune unset unset unset unset pruned kept   --prune
 test_configured_prune unset unset unset unset kept   pruned \
-	"--prune origin refs/tags/*:refs/tags/*"
+	--prune origin "refs/tags/*:refs/tags/*"
 test_configured_prune unset unset unset unset pruned pruned \
-	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
+	--prune origin "refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 
-test_configured_prune false unset unset unset kept   kept   ""
-test_configured_prune false unset unset unset kept   kept   "--no-prune"
-test_configured_prune false unset unset unset pruned kept   "--prune"
+test_configured_prune false unset unset unset kept   kept
+test_configured_prune false unset unset unset kept   kept   --no-prune
+test_configured_prune false unset unset unset pruned kept   --prune
 
-test_configured_prune true  unset unset unset pruned kept   ""
-test_configured_prune true  unset unset unset pruned kept   "--prune"
-test_configured_prune true  unset unset unset kept   kept   "--no-prune"
+test_configured_prune true  unset unset unset pruned kept
+test_configured_prune true  unset unset unset pruned kept   --prune
+test_configured_prune true  unset unset unset kept   kept   --no-prune
 
-test_configured_prune unset false unset unset kept   kept   ""
-test_configured_prune unset false unset unset kept   kept   "--no-prune"
-test_configured_prune unset false unset unset pruned kept   "--prune"
+test_configured_prune unset false unset unset kept   kept
+test_configured_prune unset false unset unset kept   kept   --no-prune
+test_configured_prune unset false unset unset pruned kept   --prune
 
-test_configured_prune false false unset unset kept   kept   ""
-test_configured_prune false false unset unset kept   kept   "--no-prune"
-test_configured_prune false false unset unset pruned kept   "--prune"
+test_configured_prune false false unset unset kept   kept
+test_configured_prune false false unset unset kept   kept   --no-prune
+test_configured_prune false false unset unset pruned kept   --prune
 test_configured_prune false false unset unset kept   pruned \
-	"--prune origin refs/tags/*:refs/tags/*"
+	--prune origin "refs/tags/*:refs/tags/*"
 test_configured_prune false false unset unset pruned pruned \
-	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
+	--prune origin "refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 
-test_configured_prune true  false unset unset kept   kept   ""
-test_configured_prune true  false unset unset pruned kept   "--prune"
-test_configured_prune true  false unset unset kept   kept   "--no-prune"
+test_configured_prune true  false unset unset kept   kept
+test_configured_prune true  false unset unset pruned kept   --prune
+test_configured_prune true  false unset unset kept   kept   --no-prune
 
-test_configured_prune unset true  unset unset pruned kept   ""
-test_configured_prune unset true  unset unset kept   kept   "--no-prune"
-test_configured_prune unset true  unset unset pruned kept   "--prune"
+test_configured_prune unset true  unset unset pruned kept
+test_configured_prune unset true  unset unset kept   kept   --no-prune
+test_configured_prune unset true  unset unset pruned kept   --prune
 
-test_configured_prune false true  unset unset pruned kept   ""
-test_configured_prune false true  unset unset kept   kept   "--no-prune"
-test_configured_prune false true  unset unset pruned kept   "--prune"
+test_configured_prune false true  unset unset pruned kept
+test_configured_prune false true  unset unset kept   kept   --no-prune
+test_configured_prune false true  unset unset pruned kept   --prune
 
-test_configured_prune true  true  unset unset pruned kept   ""
-test_configured_prune true  true  unset unset pruned kept   "--prune"
-test_configured_prune true  true  unset unset kept   kept   "--no-prune"
+test_configured_prune true  true  unset unset pruned kept
+test_configured_prune true  true  unset unset pruned kept   --prune
+test_configured_prune true  true  unset unset kept   kept   --no-prune
 test_configured_prune true  true  unset unset kept   pruned \
-	"--prune origin refs/tags/*:refs/tags/*"
+	--prune origin "refs/tags/*:refs/tags/*"
 test_configured_prune true  true  unset unset pruned pruned \
-	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
+	--prune origin "refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 
 # --prune-tags on its own does nothing, needs --prune as well, same
 # for fetch.pruneTags without fetch.prune
-test_configured_prune unset unset unset unset kept kept     "--prune-tags"
-test_configured_prune unset unset true unset  kept kept     ""
-test_configured_prune unset unset unset true  kept kept     ""
+test_configured_prune unset unset unset unset kept kept     --prune-tags
+test_configured_prune unset unset true unset  kept kept
+test_configured_prune unset unset unset true  kept kept
 
 # These will prune the tags
-test_configured_prune unset unset unset unset pruned pruned "--prune --prune-tags"
-test_configured_prune true  unset true  unset pruned pruned ""
-test_configured_prune unset true  unset true  pruned pruned ""
+test_configured_prune unset unset unset unset pruned pruned --prune --prune-tags
+test_configured_prune true  unset true  unset pruned pruned
+test_configured_prune unset true  unset true  pruned pruned
 
 # remote.<name>.pruneTags overrides fetch.pruneTags, just like
 # remote.<name>.prune overrides fetch.prune if set.
-test_configured_prune true  unset true unset pruned pruned  ""
-test_configured_prune false true  false true  pruned pruned ""
-test_configured_prune true  false true  false kept   kept   ""
+test_configured_prune true  unset true unset pruned pruned
+test_configured_prune false true  false true  pruned pruned
+test_configured_prune true  false true  false kept   kept
 
 # When --prune-tags is supplied it's ignored if an explicit refspec is
 # given, same for the configuration options.
 test_configured_prune unset unset unset unset pruned kept \
-	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
+	--prune --prune-tags origin "+refs/heads/*:refs/remotes/origin/*"
 test_configured_prune unset unset true  unset pruned kept \
-	"--prune origin +refs/heads/*:refs/remotes/origin/*"
+	--prune origin "+refs/heads/*:refs/remotes/origin/*"
 test_configured_prune unset unset unset true pruned  kept \
-	"--prune origin +refs/heads/*:refs/remotes/origin/*"
+	--prune origin "+refs/heads/*:refs/remotes/origin/*"
 
 # Pruning that also takes place if a file:// url replaces a named
 # remote. However, because there's no implicit
@@ -1033,15 +1033,15 @@ test_configured_prune_type_branch () {
 	test_configured_prune_type --mode name "$cfg_fp" "$cfg_rnp" "$cfg_fpt" "$cfg_rnpt" pruned "$arg_tag" "$@"
 	test_configured_prune_type --mode link "$cfg_fp" "$cfg_rnp" "$cfg_fpt" "$cfg_rnpt" kept   "$arg_tag" "$@"
 }
-test_configured_prune_type --mode name unset unset unset unset kept   kept   "origin --prune-tags"
-test_configured_prune_type --mode link unset unset unset unset kept   kept   "origin --prune-tags"
-test_configured_prune_type_branch unset unset unset unset - pruned "origin --prune --prune-tags"
-test_configured_prune_type_branch unset unset unset unset - pruned "--prune --prune-tags origin"
-test_configured_prune_type_branch unset unset true  unset - pruned "--prune origin"
-test_configured_prune_type_branch unset unset unset true  - pruned "--prune origin"
-test_configured_prune_type_branch true  unset true  unset - pruned "origin"
-test_configured_prune_type_branch unset  true true  unset - pruned "origin"
-test_configured_prune_type_branch unset  true unset true  - pruned "origin"
+test_configured_prune_type --mode name unset unset unset unset kept   kept   origin --prune-tags
+test_configured_prune_type --mode link unset unset unset unset kept   kept   origin --prune-tags
+test_configured_prune_type_branch unset unset unset unset - pruned origin --prune --prune-tags
+test_configured_prune_type_branch unset unset unset unset - pruned --prune --prune-tags origin
+test_configured_prune_type_branch unset unset true  unset - pruned --prune origin
+test_configured_prune_type_branch unset unset unset true  - pruned --prune origin
+test_configured_prune_type_branch true  unset true  unset - pruned origin
+test_configured_prune_type_branch unset  true true  unset - pruned origin
+test_configured_prune_type_branch unset  true unset true  - pruned origin
 
 # When all remote.origin.fetch settings are deleted a --prune
 # --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
@@ -1052,8 +1052,8 @@ test_expect_success 'remove remote.origin.fetch "one"' '
 		git config --unset-all remote.origin.fetch
 	)
 '
-test_configured_prune_type --mode name unset unset unset unset kept pruned "origin --prune --prune-tags"
-test_configured_prune_type --mode link unset unset unset unset kept pruned "origin --prune --prune-tags"
+test_configured_prune_type --mode name unset unset unset unset kept pruned origin --prune --prune-tags
+test_configured_prune_type --mode link unset unset unset unset kept pruned origin --prune --prune-tags
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.36.1.1239.gfba91521d90

