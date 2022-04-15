Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B4C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 10:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiDOKYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbiDOKYK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 06:24:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A95BB0A1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:21:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e21so10160094wrc.8
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i33Rk3t+f7NKdQvsc3YnzsT1trsZ5GrLP2+FA0vU8rY=;
        b=E57teY0vIfY4Hr8QqAlpmCkwjQGYkKJysDj+a/sqdblrWNbTdQ4zWRAZuPDE8wjirX
         Z02HYpUFKe2meV1voDN0LL7bY7LjWeujl2LHIpy97WfQ/7M/ReZSGcrheOCCkK6cct+0
         WDjqTHuXptRaZr37HTVsWB81ZNtjqClCxXjsSRQk7ovpaRhB0IJeicDfpRfwIsqImdZQ
         UhkXpvnhFrSrhgweZXNlNR/Oekcb8ZQwl1I6p8yw0fkZt0OP3Xch3J+IhYGUsILxmAmB
         NfmEBb8x91fpcCeYz2ovkDog/IMaiu5runs5bp9RW/NShvyQbrcK0j9gpsO1byEcNf7V
         oZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i33Rk3t+f7NKdQvsc3YnzsT1trsZ5GrLP2+FA0vU8rY=;
        b=EkDnhPVu9vGmCsPiPIn8OPoQXaSJEuWyFoaMc25pmnUkMUcWH1Avs5gTZKoPlVSrf4
         Lh+B8+7xUUqD4BQITAJIL91fplxVDLPiptqmFjb1FGMsmxgiy4rGw8/JGrpURkJWl5I2
         tLl2rT+SGZRLG5uF+vCwDaxm+qyV+PyIQHDfp+WnLdfvdRe4zTeOqsXCvrfyXc5sN1oC
         g1+VExo8U2KKlEQUUalCkGez1rtx9dPHuyKlZ70Dl4yO1etujZdBWqnnIFbYgy9dWaQI
         TcwUaNJwW7OTk66XJfqH5AxpMP2gYqdpI7Scc2982m84UQDugkyI9dnLTPHXGhcvE2Yn
         Bt+g==
X-Gm-Message-State: AOAM5324z+nGPDYtUALGVu8owoo2A96XoNWZWpSoisOwfms4wTJ9YFL1
        ntvbw/76g0HNzT1bDag0yESzAqtnJPe0ug==
X-Google-Smtp-Source: ABdhPJxlikG94uVDv4mNDDpe2goG5P1CLjw9iE2koDWhRNTPmSdLmthpALD2YsBfvgcdpe0VfImndw==
X-Received: by 2002:a05:6000:1ac9:b0:205:8461:5664 with SMTP id i9-20020a0560001ac900b0020584615664mr5053485wry.123.1650018100726;
        Fri, 15 Apr 2022 03:21:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c186-20020a1c35c3000000b0038e6c6fc860sm4585791wma.37.2022.04.15.03.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 03:21:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed malloc()
Date:   Fri, 15 Apr 2022 12:21:36 +0200
Message-Id: <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.863.gfc2c14e3b91
In-Reply-To: <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
References: <20220415083058.29495-1-carenas@gmail.com> <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
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
2.36.0.rc2.863.gfc2c14e3b91

