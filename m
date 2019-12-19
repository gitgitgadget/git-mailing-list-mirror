Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D1CC2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF632467E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmOUFjJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfLSWVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41823 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfLSWVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so3869134pgk.8
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMKCNtVrFuUR6GRfj2YvDoumjSCaOdhEwxsJVghCcZk=;
        b=TmOUFjJjHFBNWrdT6m79fMkcEc/fx/QLF58+hMxPKv/Lp9CpRTrVy8dRTquKdXzq69
         QPO2Y2W4j1cE7hGUdPBBBeOcHU8rEaNStFGyd28Q+wWAkOIKwfrl2XeK23AfKICzIdMN
         vWrWVl74zRUkM93F+RzPxAvLuMDBcKNRwAbERF0h40YiMGts+TsHT98HMqT5TqYGplnh
         WisM00usd27mTjrXyt1L2dRjaZcUy6S+RxIAieB5f6NoX1mx6Jsv5bA/O5axxNeV5HXN
         AbqaN84jrFodQD2S7gZQB1ZA42Dr41HuHECoywZJ0YGQytaqnxqp922hOm/Jj4g3u4e2
         /A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMKCNtVrFuUR6GRfj2YvDoumjSCaOdhEwxsJVghCcZk=;
        b=tWK7Q4jUY8djKEdvgKvhyviJK1vdaR26XTldsloLONUve+itNk8vR5lWLHUNrXAC+9
         z8aykchAhua4bmn13uH/1TDKapRNNENbJ+3HKrubvBSuOar6Mekb8yqbK2baTvRq/kjD
         a5+DnAcL16htJi0yfiF5P3Aduq0zfjMhGa9srw3AWzzT0So6+nd79JPXFnVPVmdKRPGS
         wQxAmbWdNmaWx4c4XrwGfKb4GfFIOwU9X9JZzRgkk/OypKlZS+tlWJJakWb2O6/kMo4v
         NPvr3omfPYnbXAvTlWCUzdUyuj1kUz9soAcuynDb+nk/8N4yn5wPdtjgEgHQE+oXMTre
         4Zbw==
X-Gm-Message-State: APjAAAVDzqBGslWh1p/e8yh+g4IMIVMbm5fHmZvXYH08f6Ixwz28nGlX
        1MTM4aqlZpq9ivBuByHAgg4QI80D
X-Google-Smtp-Source: APXvYqx8jOQctmxapK8fbeqfhquUPm8/YDg9ByDOPMf6W/vVgqLHHT+14X8BTcjumPd9P7e1g++aEg==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr11754052pgt.208.1576794105372;
        Thu, 19 Dec 2019 14:21:45 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:44 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/16] t1409: use test_path_is_missing()
Date:   Thu, 19 Dec 2019 14:22:47 -0800
Message-Id: <eacf4e0fb499ab7dd4b7dad4826b1ea73d120ebc.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we should assume that external commands work sanely. Replace
`test_must_fail test -f` with `test_path_is_missing` since we expect
these paths to not exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f74d890e82..be12fb6350 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -27,15 +27,15 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'do not create packed-refs file gratuitously' '
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $A &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $B &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $C $B &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref -d refs/heads/foo &&
-	test_must_fail test -f .git/packed-refs
+	test_path_is_missing .git/packed-refs
 '
 
 test_expect_success 'check that marking the packed-refs file works' '
-- 
2.24.1.703.g2f499f1283

