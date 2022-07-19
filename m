Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FBBC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiGSVFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiGSVFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9914843E6D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so126413wme.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FdEJkb/Vg6aEK6PvHy3vwNokIoArp09HN6CE6g5Hi4=;
        b=U0caAvHv9nQBkK6BG9VCNr2d6OjK74FDl/SFsfUABbIFU9RQ01b6QRRwm/IouwBf7/
         OA4qdy5P+SmKqo0a+LC3r8fb/qd5Laq3eaLiSt+paJ2zAKeQgla8C4fXo1ZGR741D3ft
         Dd5f5rXsrS8A3C1k9+y4LgMaO0Yf2+9wDIV2RxDDRmkrbf0kLNFOeP+6oRJlvDeIDP9z
         rjSLcUVsqqkJiLyPYMu9GZDiKKPjuifKNs0fe+RLQQDVszHkzcHYGHw4dbTGJQ3Ts4e1
         uevD+9WS85MJ8CPsDEVRTvNY5ZFvFdM5BY5MRg5yh7VsJhdaKuATQIjqVe0rrKsycX+3
         /69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FdEJkb/Vg6aEK6PvHy3vwNokIoArp09HN6CE6g5Hi4=;
        b=CQVwS99r0950X/M+VapVhvbWarmhEB4AHSvz36yqXUPYBCELd1i2h4LZBsWJNfReOl
         f9U2FIB3CZJmhObGSQ1MJwaUixY5HA7XKLwma0xMRX9MhlEMv0rrSBl6fkNoymbQjgcm
         s4/Gz2Vaw8IxHd5nwD4wbzc3JltaNqhkphEbRQtc2hehxiyZ4e2yDOg6InLcM11cTloF
         nMR9oKdgG6JCbjTwO8UoLkA8FAAv2N+DcGbMZ6vAE8zlWZsEDPVrSpqj/s9QnhDz94Y9
         HcCbp768n7/CJgtgcsqIQYXlOlxDbxRX/2pHWPHF/WtnAxm8F1DHCkocRKM1fFx9BG6G
         3ayw==
X-Gm-Message-State: AJIora9Mc7Ql6hl3LmaOPZlLJ9wNyT9EV0rKrtpo58RxsgC+fQuzrxFX
        M9Eduol/EKXoGSUYMTcOHNOwNvJOwnX8PA==
X-Google-Smtp-Source: AGRyM1vu8rgnQNTD0mu8grvVAyzBUsQxgGE25ZA/CwwWtQkdLBQFtMH0hOd9OY5VT6oHNSwKGqsR4A==
X-Received: by 2002:a05:600c:3512:b0:3a3:f39:5735 with SMTP id h18-20020a05600c351200b003a30f395735mr964432wmq.165.1658264734874;
        Tue, 19 Jul 2022 14:05:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] test-lib.sh: don't set GIT_EXIT_OK before calling test_atexit_handler
Date:   Tue, 19 Jul 2022 23:05:16 +0200
Message-Id: <patch-02.10-c228308c121-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the control flow in test_done so that we'll set GIT_EXIT_OK=t
after we call test_atexit_handler(). This seems to have been a mistake
in 900721e15c4 (test-lib: introduce 'test_atexit', 2019-03-13). It
doesn't make sense to allow our "atexit" handling to call "exit"
without us emitting the errors we'll emit without GIT_EXIT_OK=t being
set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f11ce35112..c8c84ef9b14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1169,12 +1169,12 @@ test_atexit_handler () {
 }
 
 test_done () {
-	GIT_EXIT_OK=t
-
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
+	GIT_EXIT_OK=t
+
 	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
-- 
2.37.1.1062.g385eac7fccf

