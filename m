Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5FC20966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756616AbdDFBjp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:39:45 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33486 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756561AbdDFBjn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:39:43 -0400
Received: by mail-qk0-f195.google.com with SMTP id p22so4056807qka.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=VpPx6TuvHGB81ngrAWyDdBPs94+5cw5pj1pEUCyXYPfx/YQyX57t4AauyhV3j1vzi0
         90nb7R3UnmLTLkcIEvRcRUuWYM/DbzAHzVnXxuK88p2vH9DvSm+SgeD8SH4kMbSGEvDq
         9vBGM+b91U1UAzbEtiejnxhOtRqyLdlSESkCOqUO+Fyiu9iuUF+ft1cmiwQE0NdbGGEs
         bi7AKyCA71ze8CKjhzaVt2TB6mZ0T2SaSFIkyA4KDGepumdfKL0f6QTBKnGoVujB739d
         8sQfzDUSAgv1snwRPqbUg4XvyGIF/nTJB81RGDxI3QoEWUz6YCZl0jLPzlC0jK3P8sLF
         qrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=e7BIIztA40AtT7lakzQLSL7iIV0mqzsAgPz/I3+QPtaKPU8KvhI46wEIl5bV407hTA
         00wZCGaXk/m0+WrYe4z7rMrSz+/y5AyanUHaPhLU1RfSUH5BJgqlvzLFaj7d8Nl7CFcQ
         2mSxMoOMAWyvNDUEUa/Ql3Vw3rCyT3nyhEvlxsT8yoH5zfirlfn10beN4mdrGAj1Klbr
         FKdkqSYP/VKsLFu/huabQqQ+Mj+8nS8Mxnw2tZcCNSdD63wYPyZ6rG2X05dv+au7H2Nk
         ywNlGKMeCtbW665Ew8CnFnzYIz7tlmPKlRSI30mWYu+gzST9GSA71DOpLwnbze1Abbg0
         AVfQ==
X-Gm-Message-State: AFeK/H0t9InQsWZ/RGCr8tVX9iSujNrDX/gX//jEpmN79+MKWoGTdTpUz0rcRAL7LVUsFg==
X-Received: by 10.55.221.8 with SMTP id n8mr19612716qki.76.1491442781572;
        Wed, 05 Apr 2017 18:39:41 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id b78sm58718qkc.50.2017.04.05.18.39.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:39:40 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v8 2/5] remove_subtree(): test removing nested directories
Date:   Wed,  5 Apr 2017 22:39:24 -0300
Message-Id: <1491442767-54068-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test removing a nested directory when an attempt is made to restore the
index to a state where it does not exist. A similar test could be found
previously in t/t2000-checkout-cache-clash.sh, but it did not check for
nested directories, which could allow a faulty implementation of
remove_subtree() pass the tests.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 t/t2000-checkout-cache-clash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index de3edb5..ac10ba3 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -57,4 +57,15 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	git checkout-index -a -f --prefix=there/
 '
 
+test_expect_success 'git checkout-index -f should remove nested subtrees' '
+	echo content >path &&
+	git update-index --add path &&
+	rm path &&
+	mkdir -p path/with/nested/paths &&
+	echo content >path/file1 &&
+	echo content >path/with/nested/paths/file2 &&
+	git checkout-index -f -a &&
+	test ! -d path
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

