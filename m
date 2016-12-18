Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D9C1FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 12:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbcLRMhZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 07:37:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35618 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbcLRMhX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 07:37:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so13792296wme.2
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fSEr7RB3qwm9OCXP4f4d1jWOnnPtpD2n55d1q1fdtN4=;
        b=u2bpZ93hTcRPdb0lsaGLUoN8JlNdJtvRalsC6VtA+P5o4gVxodDCYINU14XsJlCX4n
         oZYLxCMM/8BJfFLbsgEOqptfw4Mb9e6rKs44aIcLb6nLLJeCzNYx+Y4r8wS7OMqSEaKi
         s6XCkiNs/UKYs7fxyNIuQxj7a4P9IwjWWMEz6C6/4vr4M9AazchG8oFIokFrEzRnHwJ/
         3ddkl01Y8AXiYL3xURfgdg5JHcuta2+Nwb9D4VJ4yAa3sAxdEbc3syNYqa1rQynvhapF
         dH2Wcsyup/p2vyQr7+i1w5Oo57obRMbVeu5njOMQnnP6sGbRebPf9Bc55rWvGisa6ugW
         YDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fSEr7RB3qwm9OCXP4f4d1jWOnnPtpD2n55d1q1fdtN4=;
        b=GwhUGjcKjJ7bReAN1kpXuSLF66y1Q53Ch+DRIEfA4k09OSG+OZLZRgaVk7rRUuUrjM
         O3X+G34ZiEl7ql6ge2V0H8ScboC771xrLYQfljq8/KPE5qu2CREsl+OS1T1GIrgOI5DH
         OZ2IPr+XtIt6zZVNRC5KNJN6/epVPq+ENW/HqlvJx4B3JPBJestYlzRmilcuK02kxhNx
         B0e7gjYMtul/csIk+jqeJTiG29fXPHdBzp8kUjgxzDKJ9+oCPIGcDW0fH5xAFJJzRn2X
         AR+JLpcQi8DgpZyiU2RpveWTDssCr51AAKCxst2a1ekIrLNbKivlQS/0lntAOAw/dxi7
         JXjQ==
X-Gm-Message-State: AIkVDXJTysfehI7xXhkYgnlzbUVNAdn5DtNURTxZ9o4m9l5fqyhpXGmE9awZZewTXbX94w==
X-Received: by 10.28.113.76 with SMTP id m73mr9094220wmc.114.1482064642288;
        Sun, 18 Dec 2016 04:37:22 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box ([93.219.100.150])
        by smtp.gmail.com with ESMTPSA id vr9sm15818999wjc.35.2016.12.18.04.37.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 04:37:21 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, peff@peff.net, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] t0021: fix flaky test
Date:   Sun, 18 Dec 2016 13:37:48 +0100
Message-Id: <20161218123748.72101-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <B3D96792-047D-4C91-8DCC-60C800B2861B@gmail.com>
References: <B3D96792-047D-4C91-8DCC-60C800B2861B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

t0021.15 creates files, adds them to the index, and commits them. All
this usually happens in a test run within the same second and Git cannot
know if the files have been changed between `add` and `commit`.  Thus,
Git has to run the clean filter in both operations. Sometimes these
invocations spread over two different seconds and Git can infer that the
files were not changed between `add` and `commit` based on their
modification timestamp. The test would fail as it expects the filter
invocation. Remove this expectation to make the test stable.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: f8bf8f2a7b (next)
    Diff on Web: https://github.com/git/git/compare/f8bf8f2a7b...larsxschneider:9d88b66e03
    Checkout:    git fetch https://github.com/larsxschneider/git filter-process/fix-flaky-test-v1 && git checkout 9d88b66e03

 t/t0021-conversion.sh | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6f16983d3e..161f560446 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -377,22 +377,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&
 
-		filter_git commit -m "test commit 2" &&
-		cat >expected.log <<-EOF &&
-			START
-			init handshake complete
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
-			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
-			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
-			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
-			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
-			STOP
-		EOF
-		test_cmp_count expected.log rot13-filter.log &&
-
+		git commit -m "test commit 2" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 
 		filter_git checkout --quiet --no-progress . &&
-- 
2.11.0

