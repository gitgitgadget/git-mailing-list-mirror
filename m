Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A7C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381137AbiAaRui (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381118AbiAaRuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:50:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C831C06173B
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u15so26992843wrt.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xcVKRXO2RduFL+LG5Q8A57H9kDYp/jw3gnCqAMX3VRM=;
        b=K9gpMuNsroe22Tz2qAEfpdS0omEZNFqUmOj8LPuMk1k/y8QcErCZQvk0BNwbJrguSF
         Z9/DI1L3HtduxFSM8XoAd5DdKPAJNpB/SQSkx597SDy/DrsKunPwTWqPUfIkysAkjYBC
         GmvckVzfcRJlyLV0Cl1Opvd4vw8VqdYJ21wEXaiF2mCDX4ntGloA76jJF8x34+AR03dt
         x/1irXkeg/PaRDuDYLL4EGXyHGi1BUmc+Hq2gGwpBw7MK5S8VEJSdyfWNPK0Z7/mBUhp
         0MjSnSfNts/mB2mg0AFIwWKbA/t4yiqcp43QC8/QSGUZJULthm+SdesptIN+mOVlaAcK
         9g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xcVKRXO2RduFL+LG5Q8A57H9kDYp/jw3gnCqAMX3VRM=;
        b=JJlMbcQbJniBzcu607d1Ew/X3nMCGmvFQiFEemgdT9Ca09qvNcdgKr80YpL0TdAkJL
         iAq48X917W5J3kzYrtZe3D10BKs6BulRO/4ZXD57aSR/i6uKsw4zKXBZjVavC73V/oxN
         SSKV2Dqhde5Ss8dq5+ggy/8oLdqtB/syLeTNUCY2+A8mASkoapNL4HG9F3CvKlXKt+pl
         t8Woa8s0ufLdvnU3Yos6ky56O2g+Ofy0lT7xTqqNb/ZUnDXeMjszCM75COr3fCb2V0AT
         xM6YqhA8l2EXj9Ws8m0hgIbVFyRgHyBjwBEzGzgNDCIYfENR55PTKE2BWldX0vgZ53GT
         16oQ==
X-Gm-Message-State: AOAM530PLg+HX98qNDVtPSGphBWiMchN8c0op9uchJ38StYrOpTjG97M
        RYNtSRarbWuCPaBRqtqw+ckWdYzAA+c=
X-Google-Smtp-Source: ABdhPJyFBm0xxnXToeQNsQhOoMeEDikY4VUt/NRNLLJTwJ8EYobvyDcVq0T7LfmoVESgokXO92cdbg==
X-Received: by 2002:adf:e44d:: with SMTP id t13mr9496429wrm.248.1643651424056;
        Mon, 31 Jan 2022 09:50:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm6549890wrw.14.2022.01.31.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:50:23 -0800 (PST)
Message-Id: <b2c6e14c7e7752c9e42cb38372edc8971895932f.1643651420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 17:50:20 +0000
Subject: [PATCH 3/3] t5312: prepare for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Mark some tests as REFFILES if they rely on packed refs. Use ref-store
helper to create bogus refs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5312-prune-corruption.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index ea889c088a5..9d8e249ae8b 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -22,8 +22,8 @@ test_expect_success 'disable reflogs' '
 '
 
 create_bogus_ref () {
-	test_when_finished 'rm -f .git/refs/heads/bogus..name' &&
-	echo $bogus >.git/refs/heads/bogus..name
+	test-tool ref-store main update-ref msg "refs/heads/bogus..name" $bogus $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/bogus..name"
 }
 
 test_expect_success 'create history reachable only from a bogus-named ref' '
@@ -113,7 +113,7 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
 # we do not want to count on running pack-refs to
 # actually pack it, as it is perfectly reasonable to
 # skip processing a broken ref
-test_expect_success 'create packed-refs file with broken ref' '
+test_expect_success REFFILES 'create packed-refs file with broken ref' '
 	rm -f .git/refs/heads/main &&
 	cat >.git/packed-refs <<-EOF &&
 	$missing refs/heads/main
@@ -124,13 +124,13 @@ test_expect_success 'create packed-refs file with broken ref' '
 	test_cmp expect actual
 '
 
-test_expect_success 'pack-refs does not silently delete broken packed ref' '
+test_expect_success REFFILES 'pack-refs does not silently delete broken packed ref' '
 	git pack-refs --all --prune &&
 	git rev-parse refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'pack-refs does not drop broken refs during deletion' '
+test_expect_success REFFILES  'pack-refs does not drop broken refs during deletion' '
 	git update-ref -d refs/heads/other &&
 	git rev-parse refs/heads/main >actual &&
 	test_cmp expect actual
-- 
gitgitgadget
