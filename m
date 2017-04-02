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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA5F20966
	for <e@80x24.org>; Sun,  2 Apr 2017 20:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdDBUFX (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 16:05:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36652 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdDBUFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 16:05:22 -0400
Received: by mail-qt0-f196.google.com with SMTP id n37so16594507qtb.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=Ho1VTTITXUVJSrnfWw/z5wYaHRmXOX3DzYcXJ/mNW9VNqxQc9lAZ+V0X1iGOQqQtt8
         zRpMqO948oUokfroG0GaiulMXrkFaD+9odyEI9vSxknz+eNh/pWvsPI4diXrreTcW7l4
         UHFG58lt1slCAqU5b4DeMZ9FPo8L6jwcJvFgLKkXZ8px0Do/wHMHnB0QMIHUlsrPDY7K
         x2My//AW/KXR600D00tDIXI43c1gLgkK3UhBRxPXm0vHjtgb8WJLdbnuu0rCkovglahs
         6c6CXKjiVtPpK/MwU+KC8jp2P2y6B7xuDxlyX9sj3yK1JRcgCgqnz9iYcCoEY+cP8XHs
         btew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=ovMUr7cdKvy/1aFwT48TriSEIKK7uMtEh5tzgTMvu3OoM5dVe5szb4FssFw35qEGCn
         KKGVijJmBvCFS5pz8dqfXqwOesPvHlNwgH919rvA6JBbcw/Iomr9eY2dCZFJbBSeDFdp
         s5RytqCTwU8r+g7rXNdCoOd6cWLUiUyUo4KoI1VRgDDFT2DBMedWenhvmaGnL7V6O/wb
         06CFTAQN3W6ZYy1zkhWPteYrQjZfrkkR3DMUMffJbqeZ0rNX1v+5xV/snaljc3+EMSR0
         JnGQchXrVFb05kM4INffLoDZK+/P0kASelneo8zmuhALkroYkAWj57Zb5jCVNCY94Vzf
         0aog==
X-Gm-Message-State: AFeK/H3k8UdS34BcXxjiekpMWiUl649mUB62c7aTir5iAgkFID0UAqIOxpSiQOc48USv4g==
X-Received: by 10.200.45.137 with SMTP id p9mr13289339qta.201.1491163521978;
        Sun, 02 Apr 2017 13:05:21 -0700 (PDT)
Received: from localhost.localdomain (186-245-85-163.user3g.veloxzone.com.br. [186.245.85.163])
        by smtp.gmail.com with ESMTPSA id 137sm8162258qkd.19.2017.04.02.13.05.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Apr 2017 13:05:21 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v7 2/5] remove_subtree(): test removing nested directories
Date:   Sun,  2 Apr 2017 17:03:05 -0300
Message-Id: <1491163388-41255-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
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

