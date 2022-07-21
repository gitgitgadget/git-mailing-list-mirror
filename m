Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiGUGv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiGUGv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA143E76
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a5so832265wrx.12
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHPlOvB9BolXygdxbu2hs/4D26c34RrvRAp87yASSEI=;
        b=CynMtHrODB5ZySz2rMNNJQB7MyqGmrNqz4zUPspD1aWUW/ZpkPv5Z368ljSXsxuehR
         SXMPHAKJQ1kjbarHR6DwhvevXhXfKq7FQ6lhjTdVkYgIbD8R6CWXVRS/aHiUOyPKXowN
         fttJfFbiDH2du64Jl5tEPN/55pjIY0A8xeRyTEx5wrhAwDbWKtuox0ZLRtFZ4/V1xyo2
         /83bTAOhtzi61MtBSNBz098mbWUNpBS7E8eyHCkDU+B3pO1pcEWAPn3KqqNktqTBFaXN
         UHZm9YvR9ippxsjgXCZal0IiMNTqTxZZqLfLnL8ANOWzWZYN5UHfym5XJqavyScVGd/3
         guSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHPlOvB9BolXygdxbu2hs/4D26c34RrvRAp87yASSEI=;
        b=X8Kq/w5hkrrqxaD67peeBy3GNMkCqw+2O4mx3x4WQDgz1WZTKKGG1aqyTkwPDuu+xo
         qa/5FF/U25RRfUxwTxoXLB9qZ5ibvvvFMtEHGaMzsoA97ZVD+N8+A+viT1vsS/T5qwGu
         ZpK2RrcNxNHWhBtiMFud1DNem06y8jSc/pqlFxtuhFcwhscufzCsvWLDW9WNwmFn/XVo
         MrlqwtJxFsQn+k93bs6CcL+WgCdoBt+JOjCdznHLmVerh6dm+hOh1K+aF65W8sLy7KoN
         NrDmY4lAyUnPu94ECVMiVvcWNg3AQGBSOkLa0rPJ2cgRmVTkLxZlKi1jO7h6hGXF2THb
         EZjg==
X-Gm-Message-State: AJIora9zw1WB1EesKIZ2qQARywd5KEpGN0Vc42aD+FWMBxSnE+90TLts
        ttkQ6qhc4G4XvJMfqDazADoV2To13cufPg==
X-Google-Smtp-Source: AGRyM1uxoCFF2RWwYKRZU1PxeGLVQjeyqEOKg+rqlxt9yEAyIH8sUyrncPAgYJJmaWDNKmzH0nj71A==
X-Received: by 2002:adf:e310:0:b0:21e:3e46:81f8 with SMTP id b16-20020adfe310000000b0021e3e4681f8mr8123784wrj.188.1658386311859;
        Wed, 20 Jul 2022 23:51:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] auto-crlf tests: check "git checkout" exit code
Date:   Thu, 21 Jul 2022 08:51:40 +0200
Message-Id: <patch-3.6-cfc1abbf7e3-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't hide the exit code from the "git checkout" we run to checkout
our attributes file.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak (the relevant "git checkout"
leak has been fixed), but in a past version of git we'd continue past
this failure under SANITIZE=leak when these invocations had errored
out, even under "--immediate".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0027-auto-crlf.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 7f80f463930..03b955b774f 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -293,11 +293,17 @@ checkout_files () {
 	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
-		rm crlf_false_attr__$f.txt &&
-		if test -z "$ceol"; then
-			git checkout -- crlf_false_attr__$f.txt
+		if test -z "$ceol"
+		then
+			test_expect_success "setup $f checkout" '
+				rm crlf_false_attr__$f.txt &&
+				git checkout -- crlf_false_attr__$f.txt
+			'
 		else
-			git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
+			test_expect_success "setup $f checkout with core.eol=$ceol" '
+				rm crlf_false_attr__$f.txt &&
+				git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
+			'
 		fi
 	done
 
-- 
2.37.1.1095.g64a1e8362fd

