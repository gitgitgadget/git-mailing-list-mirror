Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD4C2070F
	for <e@80x24.org>; Wed,  7 Sep 2016 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757364AbcIGLVO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:21:14 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35032 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757367AbcIGLVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:21:04 -0400
Received: by mail-pa0-f66.google.com with SMTP id pp5so794304pac.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThDv+FGMNa4eB98LJfNVT2Ez/YnCAG5Gje16SzUMnSE=;
        b=Q6Hmiuxd26NLiGj2bYYV70AKpZlpsOxRhqZA5MmYg3RfLe6s0M2l3CAjmvJ8c4ZRd7
         6gBo6ojPzhXrlo2wR0V9mQjWDUUMsZNy1KzB1OKRzjdxXLaJUf6kFhjVNvIBCbkhE1cc
         di9f+qtWe1EGg3SLUVYzGU2N2tP+ljSqakdtQwOrLsS6X0WfaDje+ivkGsVJ4Stj4aOf
         ycvcTAI7jX1Ebke9B+RoJY1drROz5lS/3O44h1xYCozDosxxvLJNE2WWWAzw6G7T4fAh
         fMkD/EloXhlVd/lQt/yIpkiZf6s9ZWyCVB2xM5rLK4SPe5li51P1icxhNaC8J2KnvB5x
         S7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThDv+FGMNa4eB98LJfNVT2Ez/YnCAG5Gje16SzUMnSE=;
        b=U2Wt9H/XEm8gP0y4TLiaHoXLNDjKmF8CV623IpNCUn2L2gHl8TqPuvxyfWoavVCv2A
         tojTa7SfM43TBuXj7s6Yu4VK0R+IuibKo72POGbDhrNdZ82N32iwEpa0lhnUXBGX00a7
         0XuIAawrK7VHOUAgNG5sHFW8nUXvXv1RrAtfhOwUxKWMSJVmz8t+f/zRYJ11vhV5iIk9
         20YhaFplhr6rngG1s2gBm7duq4oUTHRLMEvJcU/ytiETur2tinKcBaxzU9FD9Kh68KAD
         NiKDu2H6jFjVYCbreayrI6jVgSS3ZvYOJZorxsMUT7tdwvux5Y9UP1lrPw3l4IFJC4kF
         3ktw==
X-Gm-Message-State: AE9vXwPA4kJantbeOAxg7FALSyHgVfxDks8j/I/6suKHGozQ3PwalSDzp2+mKcK04z0uuw==
X-Received: by 10.66.26.113 with SMTP id k17mr6669680pag.100.1473247258491;
        Wed, 07 Sep 2016 04:20:58 -0700 (PDT)
Received: from ash ([115.76.139.213])
        by smtp.gmail.com with ESMTPSA id ty6sm48280608pac.18.2016.09.07.04.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 04:20:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:20:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] checkout: fix ambiguity check in subdir
Date:   Wed,  7 Sep 2016 18:19:41 +0700
Message-Id: <20160907111941.2342-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160907111941.2342-1-pclouds@gmail.com>
References: <20160822123502.3521-1-pclouds@gmail.com>
 <20160907111941.2342-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two functions in parse_branchname_arg(), verify_non_filename and
check_filename, need correct prefix in order to reconstruct the paths
and check for their existence. With NULL prefix, they just check paths
at top dir instead.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c            |  4 ++--
 t/t2010-checkout-ambiguous.sh |  9 +++++++++
 t/t2024-checkout-dwim.sh      | 12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1f71d06..53c7284 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -985,7 +985,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
 		if (!has_dash_dash &&
-		    (check_filename(NULL, arg) || !no_wildcard(arg)))
+		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
 			recover_with_dwim = 0;
 		/*
 		 * Accept "git checkout foo" and "git checkout foo --"
@@ -1046,7 +1046,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 * it would be extremely annoying.
 		 */
 		if (argc)
-			verify_non_filename(NULL, arg);
+			verify_non_filename(opts->prefix, arg);
 	} else {
 		argcount++;
 		argv++;
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index e76e84a..2e47fe0 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -41,6 +41,15 @@ test_expect_success 'check ambiguity' '
 	test_must_fail git checkout world all
 '
 
+test_expect_success 'check ambiguity in subdir' '
+	mkdir sub &&
+	# not ambiguous because sub/world does not exist
+	git -C sub checkout world ../all &&
+	echo hello >sub/world &&
+	# ambiguous because sub/world does exist
+	test_must_fail git -C sub checkout world ../all
+'
+
 test_expect_success 'disambiguate checking out from a tree-ish' '
 	echo bye > world &&
 	git checkout world -- world &&
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 468a000..3e5ac81 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -174,6 +174,18 @@ test_expect_success 'checkout of branch with a file having the same name fails'
 	test_branch master
 '
 
+test_expect_success 'checkout of branch with a file in subdir having the same name fails' '
+	git checkout -B master &&
+	test_might_fail git branch -D spam &&
+
+	>spam &&
+	mkdir sub &&
+	mv spam sub/spam &&
+	test_must_fail git -C sub checkout spam &&
+	test_must_fail git rev-parse --verify refs/heads/spam &&
+	test_branch master
+'
+
 test_expect_success 'checkout <branch> -- succeeds, even if a file with the same name exists' '
 	git checkout -B master &&
 	test_might_fail git branch -D spam &&
-- 
2.8.2.524.g6ff3d78

