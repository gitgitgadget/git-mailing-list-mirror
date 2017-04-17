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
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F5B20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 20:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbdDQUvy (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 16:51:54 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36587 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbdDQUvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 16:51:53 -0400
Received: by mail-qk0-f194.google.com with SMTP id v75so21109976qkb.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=IIiux+UtrsjeAEHLGzUuXRGFobODts2NnwecPr+nbdzIuWEKd6kzNijCx6fEoDdUwT
         gD+xGkP54agH1wQ5k6Ay68mMbjMiLVNW6Lz21ARtWQMmbGl+cg8qn8CUIXlaanHrP0j9
         hyW1LfPuv/z8l9XH6TmfFP0DfzDzC0WGp+AhO7B38gq5SvriR0Y/a7kXA9bk+TGOUA71
         ZpgckYEhRJ5nySRV+jHKTc3hYZgTFKN/QYUSLkb1JgeuDuFyzwX5MKVOhnm5Tqf9Y0qS
         RjURGGiIN1U/J1+SXnL+B4XRmDb8mokQTvR+50hw+f0N2ETTXcr159EWlJsXj/fvbNJg
         CG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=FGT0K/P/rnMlTjlUbbLzRE3tlOIsJdL7Pla+I0HmJPDUt62UD/THu7+WZxb5kdFJHd
         2xj8qvIWxCrnN8l1cPK0aoe8G9KGidAERnD4JZ+4eoECUvzewNoyNTk1PW+ZgDodEqwo
         FOb4l76m22aXgPD5PEqL7LdMgtCIAYMSWuVdlQtNQDPZWPf/ocN51A4DSVuMfqpTZvlp
         rQtCm7ca3w0jr0Hxxb+sAtCWplF3b3VPTyZL79CeSWWJAH+WF3dBaMnvLF6SVMjRKQg+
         HiU9EugfL1rnigxlLdOOPe7NKmGi2alBWKFwLT4UBrol18WMb87zZsoRLgyCn0mYGbUr
         COgg==
X-Gm-Message-State: AN3rC/4aU8llwtJPuYE0aK2WFGEGoHmjL5y2qNE0eSd8CDGQaifvZ3p4
        5bgMGuCi8bX3EA==
X-Received: by 10.55.204.157 with SMTP id n29mr9575905qkl.73.1492462312218;
        Mon, 17 Apr 2017 13:51:52 -0700 (PDT)
Received: from localhost.localdomain ([179.222.191.2])
        by smtp.gmail.com with ESMTPSA id f203sm8093848qka.11.2017.04.17.13.51.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 13:51:51 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v9 2/5] remove_subtree(): test removing nested directories
Date:   Mon, 17 Apr 2017 17:51:33 -0300
Message-Id: <1492462296-4990-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
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

