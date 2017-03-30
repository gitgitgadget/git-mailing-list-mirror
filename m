Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9010F20958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbdC3Dcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33650 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id r45so4671992qte.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=f5qtA0YvLab6a399wIA1OEizvscqFy74en1PqxknkBcMVySxhobBzA1ossiS3zPvRC
         Vq4gunKQFzB4Tm80G9wln1fNRC1bjS5HW+MnV47DXWe+E7SyzXj0Erj4UvJqoCELFqZn
         WRldZimMc8qS/TrmkEP59qR76NEs9DzZwdEeA/Y7KtkCxpFyDjGpOWccBA213A57BKF+
         m/fNymbmARSBEm85NFdUi47aaQxV5Ho2/kKWsxg0ouhsVJgSFyZHorFtXFI0qhs6QToy
         fCBW7gaszq3MS8h6u+Ns11Q0ZvElRRPSQIjAAbaMi1BpviJthL2DcBTj7rWbhSRCEW2a
         v08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=gl7h8eYuilbGhlg0QZoB0+BoaYJj0GoU1d8NdCDea1XtSLksVt08qnmT8uYKurbhB/
         7f8/jhoNvJvcMTslIRESrG76DuLkMAgGrePmpVFt2HsrtAjuQhEM8uUorkWPRcvo8NxZ
         L/Rgo1OE5jVxsLKGbBQ+DFsaWzdj4XRkPfIyUZockHm0+8S9weIADn3Jaqb3lU9YYIRv
         EcBNIdxDwWmZT36nU2DtlkkB+qPB3m59l2lSGbAc43pDBBJTi9BKayKwL7NlgNAIO9+1
         hxPSM7P/NaMeqhfyfFodpIAMJRwksu9SW0+HLJfSS+50wzHkdm5rHT1IZ2fPLg0V7Urw
         Uv0Q==
X-Gm-Message-State: AFeK/H0n/ypcNUMiqaE5uX54mqBQTXnNvAgkec28hnlJldUzs4MGaVY3e3WgY4cQjsMxyQ==
X-Received: by 10.237.51.5 with SMTP id u5mr4480614qtd.247.1490844765940;
        Wed, 29 Mar 2017 20:32:45 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:44 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 6/6] remove_subtree(): test removing nested directories
Date:   Thu, 30 Mar 2017 00:32:10 -0300
Message-Id: <1490844730-47634-7-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
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

