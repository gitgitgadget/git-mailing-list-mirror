Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E0C433E2
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1CA6194E
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCUMk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUMj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 08:39:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1DCC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:39:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k128so5542625wmk.4
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyuCJo9MzlNtvp92IxAF1YwRao2qNA8nrrrdCMWz5hE=;
        b=ZH4hikmmu/BEmSPFaKlkiV14lBlBzfn9xhWro8h1Q9AgtmBrZSlmYCNnG/yMFMz8yl
         /POx2KCR4pXLBb7nTxTx1vyBAbu3SL1imdftHczg2RkAlElUl8N2RvD3T/q69fis+wRG
         oITe5t/DMqK6TB/+WQOJMKgctu41Xh19lz/dil5kcUma/ZgUUOIKQHhtcD9GHm9eVjxd
         uyQjeAON+SyMNC8leT8Kje9ocmhD16bIfpk/+QeAPbOC/XqbaI1h7S6kguzO4frVDyDY
         P1xwyNcGI9Ad9XYE3twEVgvazNaaEeGdym6WOmbAgacCG859XZyjw6OSWKJ9jQIeajHu
         NvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyuCJo9MzlNtvp92IxAF1YwRao2qNA8nrrrdCMWz5hE=;
        b=IaFYmSClJJE72wM06i4h7PPpDjcGaXesaXnHr58lhapx/io8fHJ+sDPEtbpX7861WG
         1FY4CB8W/kqMQGl+be6SIKh7GV+eHt8M0Fdb32Uu6CgQ9IhaFRATFHKEeDXputYmALxq
         Fs8lxC9wELum6i7iovUxMby4zHTZ5mmeA/zqAE22YRU3zVC/LNN0zBmhhnNf02FeSo/O
         dVb97ANLpdBtecLCBTM11RQWEAxfKmcG4caH8G/b1UmX1qJJWuyvuJ6hlA4FDE4vmD88
         Xwe3AWJ6QLWx8MU7EksRaiVLvN9neGJ7JMFnifrIN6KzRopLZhx5uOw/ImpNB7BSJvge
         yB7Q==
X-Gm-Message-State: AOAM530wTxUDthe8/r4JLFqCRhsJdHMBHEWyu3z3Ky3+UVGRMiSfkJ8h
        4oTGGUB3nwdFUHFKaXjlND27IbmKFgQO0A==
X-Google-Smtp-Source: ABdhPJwkEp050yrT7fncEFQZZQ5BY7b+EqHGVYxSJjJ89O02xw+bmVA4P1WJg7GHiZGafRqM0qZQ8g==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr12093788wme.114.1616330395458;
        Sun, 21 Mar 2021 05:39:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m17sm16633279wrx.92.2021.03.21.05.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:39:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] diff --no-index tests: test mode normalization
Date:   Sun, 21 Mar 2021 13:39:23 +0100
Message-Id: <2dcc8bccf9733c6cc072bdb55a5104f16084e5c3.1616330120.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616330120.git.avarab@gmail.com>
References: <87wnu0r8tq.fsf@evledraar.gmail.com> <cover.1616330120.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git diff --no-index X Y" is run the modes of the files being
differ are normalized by canon_mode() in fill_filespec().

I recently broke that behavior in a patch of mine[1] which would pass
all tests, or not, depending on the umask of the git.git checkout.

Let's test for this explicitly. Arguably this should not be the
behavior of "git diff --no-index". We aren't diffing our own objects
or the index, so it might be useful to show mode differences between
files.

On the other hand diff(1) does not do that, and it would be needlessly
distracting when e.g. diffing an extracted tar archive whose contents
is the same, but whose file modes are different.

1. https://lore.kernel.org/git/20210316155829.31242-2-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4053-diff-no-index.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 9b7a8ebfd3f..6fae18612fc 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -149,4 +149,34 @@ test_expect_success 'diff --no-index allows external diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index normalizes mode: no changes' '
+	echo foo >x &&
+	cp x y &&
+	git diff --no-index x y >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'diff --no-index normalizes mode: chmod +x' '
+	chmod +x y &&
+	cat >expected <<-\EOF &&
+	diff --git a/x b/y
+	old mode 100644
+	new mode 100755
+	EOF
+	test_expect_code 1 git diff --no-index x y >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'diff --no-index normalizes: mode not like git mode' '
+	chmod 666 x &&
+	chmod 777 y &&
+	cat >expected <<-\EOF &&
+	diff --git a/x b/y
+	old mode 100644
+	new mode 100755
+	EOF
+	test_expect_code 1 git diff --no-index x y >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.282.gcc1ec606501

