Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666CDC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiGNTk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiGNTkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:40:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5B675A0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so3923192wrv.4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IpB1WaWFqwrOFCg2h5vGzP4eena/PfGuElhSyAnirk=;
        b=fl2gUPekHzOcPDr5FMrB226iq5iCimd3wPBgKKLJR0AaYApmigUHH6BHnveC1R48xT
         1Wd1LL1ZGlYg+p+47MFQF49VVHRJkndojlzQaDmcnAxRqmx7m0w4yWYxkzD7JjpdyU4F
         ipkBAA6uwWmifaEKFiGcV+nTnLlfYRN/RlhF7VNKmyk0dO2rZVILzlcn7kQNiVWcRLop
         XkRJEE132TC0YB5Ql52w+n6/diHBba1t+OMZOI7drGCPcD9alPjddPlFSrX2tRfVbKDi
         2lZPhqJFU9qpQC1/3h0X24PrDVqzpS69R1MRCVc3rbFGXF1rEhVK82s/mN+pVKAoDA2O
         3NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IpB1WaWFqwrOFCg2h5vGzP4eena/PfGuElhSyAnirk=;
        b=JhjYWOkakYWXRyRUvIjjpoMkqtW63NdOkZQFCbHZFGOZx/yBY+IHDbo7eqBNEm568P
         +oKyUxe/YrU3vdy92KMVSzSnnVIN+1itWdxAukNo6LRaokfiu7tA9phqMrDEG3VdUvet
         1evOXPRp0x8+fn0lNuhDyyUaT4dnB3yz13vnszE4umvkss1e2LSa3wjuL3Lwu9x0BC1Y
         hE5ge/4+YfpAdc3qL1JgyovNysJ2ZnO6qq4CcsN/lZnQsbNwKalHbS7HtmFkV9nNFKCt
         aLlW3Iu/+OsA0vIGCNYR4NKI1ILtVg5WvfCwJO3LCmUnXCLEAeR9wnygRkDIajqHhjaZ
         k+hw==
X-Gm-Message-State: AJIora9gwxVnNS7r90Ig7n5J4qaUvq01YEgz6A+xzXzf/la7S2XRNRdx
        AgpD47og82gW4nGf4mroh8gy1eHGlczWWg==
X-Google-Smtp-Source: AGRyM1uTiFzqcpCx0NsAOqknZOI7BlJ6tJlFc6qUYjVZIaevtYUA7PstxYVqF/t5jqtzOuuqnHYSAQ==
X-Received: by 2002:a05:6000:2aa:b0:21d:ac4f:587c with SMTP id l10-20020a05600002aa00b0021dac4f587cmr9832535wry.675.1657827604267;
        Thu, 14 Jul 2022 12:40:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:40:03 -0700 (PDT)
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
Subject: [PATCH 10/10] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Thu, 14 Jul 2022 21:39:47 +0200
Message-Id: <patch-10.10-5ef362505c1-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "make check-builtins" check from the "documentation" job to
the "static-analysis" job.

The "check-builtins" target added in c74390e4a1d (cherry is built-in,
do not ship git-cherry.sh, 2006-11-05) is unrelated to the
documentation, so it's odd that b98712b9aa9 (travis-ci: build
documentation, 2016-05-04) added it to the "documentation" job.

Let's just move it to the "ci-static-analysis" target, and while we're
at it improve the output with $(QUIET_CHECK).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 | 3 ++-
 ci/test-documentation.sh | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c328e190d64..c2b0a728df5 100644
--- a/Makefile
+++ b/Makefile
@@ -3520,7 +3520,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3615,6 +3615,7 @@ ci-check-directional-formatting:
 
 .PHONY: ci-static-analysis
 ci-static-analysis: ci-check-directional-formatting
+ci-static-analysis: check-builtins
 ci-static-analysis: check-coccicheck
 ci-static-analysis: hdr-check
 ci-static-analysis: check-pot
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 9e0652c30dd..41e2b126311 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -14,7 +14,6 @@ filter_log () {
 	    "$1"
 }
 
-make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-- 
2.37.1.996.g651fc6e809f

