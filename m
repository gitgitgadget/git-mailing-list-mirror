Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297A11F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBHP5f (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54413 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBHP5L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so10339162wmi.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWymDRR6DH8vlwgZFk1t1AGfRl1p5+mg2zmTsWwarhk=;
        b=mDtttIrBexwHNp0h8hwd3lDDUFHvtG303g595QhBXsdbve1gAlK+Fe65CXiMony9Nx
         8CQ5Bzr4REBmo007dlfHQPRLQUeC3DJ/l3sg39H4jINW7btD+3m3IkmWoSkCUhXMq3T1
         hwJSgKWSASd5vyHW9s0uar6eTfAbKzlZfzuYWVCx9zT/T/3EIAyCPCRU3s/yw1NnV/at
         t0PEZPuxcjcaDR5zVEH+1JD1HYUVq/IfzQQUEmSZNoCDZdNYH7IQ/HAsujeGFmjvKNFE
         pb8PwwuxCj+1g2zeLUlDVs4lW0m/fcUW3mUYIYVTWV/qqyO8SM3fDX+qUwYUWdzIHmNM
         0qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWymDRR6DH8vlwgZFk1t1AGfRl1p5+mg2zmTsWwarhk=;
        b=j1zxpOYWwYE5ttRpKL4zK2HeG4vgMby98jMXqaut6ci9SDKXaDStcT4MY/J+M0KYgP
         89tNswrpQuiqdVTDM+teARVE3lOW9NKozzNHtYR79VbYXSLmbd76KJ76ngCO7/jzjFkF
         Mwzdqnu7a84469cLxZRO+UxSg5xvzwmzJfVI4gldQFIatwpYUdh/gd2+4CU8RvlI3Vlf
         sQvdJxJpkBiHm4PvfZQXThp39wr/OwjHODzDXb1cNNiHZAysdGG/T0e2fGCpGJJsze8r
         dqmUA6p2nwtWxJMSx55o4ITO5qvV9QbuUSi1Ibpw9fyC+WVaJeOX8IrtUnQqiHyuQMKM
         CD7Q==
X-Gm-Message-State: APf1xPDWQxvhAJCx07apR0V2R33MzW1pFvSiJi2CV5y9XI8H+lYfT1Ql
        Zt2DHXC1lc5l4/8UagzkLyg=
X-Google-Smtp-Source: AH8x225wutRI5jLAKU1vIv0mUOvWXRdAqvTUthnueNfYaRKjWnOZtiVR+HUjsB93g295PDd0Kmk/wg==
X-Received: by 10.28.16.2 with SMTP id 2mr1508792wmq.120.1518105430434;
        Thu, 08 Feb 2018 07:57:10 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/9] t6022: don't run 'git merge' upstream of a pipe
Date:   Thu,  8 Feb 2018 16:56:50 +0100
Message-Id: <20180208155656.9831-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The primary purpose of 't6022-merge-rename.sh' is to test 'git merge',
but one of the tests runs it upstream of a pipe, hiding its exit code.
Consequently, the test could continue even if 'git merge' exited with
error.

Use an intermediate file between 'git merge' and 'test_i18ngrep' to
catch a potential failure of the former.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6022-merge-rename.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 05ebba7afa..c01f721f13 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -242,10 +242,12 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	rm -f A M N &&
 	git reset --hard &&
 	git checkout change+rename &&
-	GIT_MERGE_VERBOSITY=3 git merge change | test_i18ngrep "^Skipped B" &&
+	GIT_MERGE_VERBOSITY=3 git merge change >out &&
+	test_i18ngrep "^Skipped B" out &&
 	git reset --hard HEAD^ &&
 	git checkout change &&
-	GIT_MERGE_VERBOSITY=3 git merge change+rename | test_i18ngrep "^Skipped B"
+	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
+	test_i18ngrep "^Skipped B" out
 '
 
 test_expect_success 'setup for rename + d/f conflicts' '
-- 
2.16.1.158.ge6451079d

