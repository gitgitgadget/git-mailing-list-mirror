Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA73C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347372AbiFCSjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbiFCSjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A8613EBB
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so4762875wmz.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kQaq8aoN2KquAKRvLv3TfTAXf6cBsSa7ll9ndy6N+s=;
        b=ROxqI+OTEy2I2wWIJqlp6aPb0axwzduAq6T+XguyPsKSA1+XPopjEJx13Q0YXdfTP5
         6sov9sQ4m43/hllpcVZ4krR0R5xHNJeqC1BOSxNSF57GzKWaP9LiuBGsbNeNVNEU681U
         Uk/YrQkw71lU9+MoiQlLc8fdMZK/uHhyg0izAj3ekZ1vHY8JzQRxgmBfFpowKj+WWU1J
         pmjJ6+Wa5fDxxYQHcotvlcb9yYUGXhcF9zHvoxAhSxA6zNj+B3lV5yBdBOhn81W+M8/x
         aXl5RhFHBIeguDcBhfn1203mCXjp/Hcq/Y6isx45Uq8Pcm2heRXSp9+G3funaSaTW4X3
         RHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kQaq8aoN2KquAKRvLv3TfTAXf6cBsSa7ll9ndy6N+s=;
        b=VT736gFWRY33YCKDRKucL/P/cd9iBW/wvBu64mJYTpphWiZDjSRCQLpZuwi5CuHLCl
         gmgkBXyErvd/E1cNaBHE0N2pElHseBlSLwnQyzRjf3/MutcJP558NQ49fXcYCXDL9Hz2
         ThW7sl3YI+dP/jVI5UB6kNX+TRSW1WSegwgJqZB9KrYBCW7LQB6VKpk9n0A0JvIeSouo
         9KYMui6UyJhUEnq0dVLayy9UGEQMyfXYvAF6sPq5gNBB35Fgvj7i6/bRY6VjanAKlEsH
         Abm4gQhtoPFhipHYZCD8g/gch4OpOQKeps2aeVV/iYEqvIonI7eFUvBNT6zXZb/jJl4n
         eISw==
X-Gm-Message-State: AOAM531eefxKQGyzeHkgNr9Ri3kPurVBj+K/Lypx2DIRDWf9F8Lpm6ql
        vneIfbiSCkNdBelpc3jWxyu8rADy7uTwRA==
X-Google-Smtp-Source: ABdhPJxu+UL17f9N8JOHHh43rjnBNrcKk+muw5CPrcNtXW+xpbMRw88zrqU0Jikbmn2MR8qODR1rcw==
X-Received: by 2002:a05:600c:3b9a:b0:397:60e7:2774 with SMTP id n26-20020a05600c3b9a00b0039760e72774mr9918500wms.120.1654281483240;
        Fri, 03 Jun 2022 11:38:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed malloc()
Date:   Fri,  3 Jun 2022 20:37:40 +0200
Message-Id: <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return NULL instead of possibly feeding a NULL to memset() in
reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:

	reftable/publicbasics.c: In function ‘reftable_calloc’:
	reftable/publicbasics.c:43:9: error: use of possibly-NULL ‘p’ where non-null expected [CWE-690] [-Werror=analyzer-possible-null-argument]
	   43 |         memset(p, 0, sz);
	      |         ^~~~~~~~~~~~~~~~
	[...]

This bug has been with us ever since this code was added in
ef8a6c62687 (reftable: utility functions, 2021-10-07).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reftable/publicbasics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index 0ad7d5c0ff2..a18167f5ab7 100644
--- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -40,6 +40,8 @@ void reftable_free(void *p)
 void *reftable_calloc(size_t sz)
 {
 	void *p = reftable_malloc(sz);
+	if (!p)
+		return NULL;
 	memset(p, 0, sz);
 	return p;
 }
-- 
2.36.1.1124.g577fa9c2ebd

