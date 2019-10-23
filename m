Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B42A1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408051AbfJWXck (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:32:40 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43887 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbfJWXcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:32:39 -0400
Received: by mail-pg1-f169.google.com with SMTP id l24so8110623pgh.10
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=10YvjY7Ta9Jm6OaROgx1hG/5XbFCaRDQ+WuYUk/GN3E=;
        b=L2tyjdX7AL6jplyVPYAd3fK0tz/9kKugBKnu5oXUaZy2jOTNuFzon3bQObwcpULQnn
         U0jLauXiyaR8kRohjbHcKr+/LF+5imyByWbPuQM38I17Qx8A1OqyEwlTwH6EMb06GVWV
         tspa7YG97G8wMgPUa9hqRXFtlYo+PwlIbhjqknumKfa4GTLLoyKpCrmeWwc8XlibYxnO
         MKrE3KHcA6Ku4E8ZDMV2aKxehC9Ce3cJ1wcE2aPreQr3dZsiU9pyfAKVQhtOP1fhHj3n
         hP4OkO5hJK7Onhp4QqdYi3m0LvlrFyBDXtf9j87/R/x+0LDsVgo/k24jNLYYLtje/IwC
         GeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=10YvjY7Ta9Jm6OaROgx1hG/5XbFCaRDQ+WuYUk/GN3E=;
        b=BdfbZUTnxnDNzIe4vHb/lBjGvfS+kKzYE2fsiNinu/+BEanuahBXN0izaG/RgeG7Og
         MtrPLNKAmhvtJyAabrp6Ia8S3KSZaW+wi7P/Vf910x7pZUaA3RIQmJgSLumwHun034r0
         RA23Ru+b9rhmTtM8PoOYGOPqSdz1Fuh0xk5Q4LirvE7TxVGrYVpItt/7btcKT8vxKfv1
         rSM/ulcBq0YLABQQXxHaEVh8rMEABXPwwv+pD2Kg2pSY85Wc9IJiC/zCJEdg27xPJe1G
         FptZXWme/SQjN/LJb75/TyITwueu+CimF+nd2t41jJgvvXopL+AzRQFN6b5sgJaUueXz
         gPCQ==
X-Gm-Message-State: APjAAAXgKn/NMvKAHM4/Pz2XHxb+XnkYw/gJljE6NZcSgjimiuAUC5h4
        yMcOgHyVOkWJjPDbBUzchLXXqeRh
X-Google-Smtp-Source: APXvYqx9AagpDhuE/QWkFvB29WUbGoC526MpcVj5RNJPnyYUJZ8LitXxN4MOBhtOWId7mnGMZEPPAg==
X-Received: by 2002:a62:b504:: with SMTP id y4mr13684564pfe.124.1571873558743;
        Wed, 23 Oct 2019 16:32:38 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id o15sm333923pjs.14.2019.10.23.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:32:38 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:32:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] t4108: demonstrate bug in apply
Message-ID: <58d32e2618420e22a5418f87cd474a9347386098.1571873435.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
 <cover.1571873435.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571873435.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, apply does not respect the merge.conflictStyle setting.
Demonstrate this by making the 'apply with --3way' test case generic and
extending it to show that the configuration of
merge.conflictStyle = diff3 causes a breakage.

Change print_sanitized_conflicted_diff() to also sanitize `|||||||`
conflict markers.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 7f96ae9101..bffe37f1ba 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -8,7 +8,7 @@ print_sanitized_conflicted_diff () {
 	git diff HEAD >diff.raw &&
 	sed -e '
 		/^index /d
-		s/^\(+[<>][<>][<>][<>]*\) .*/\1/
+		s/^\(+[<>|][<>|][<>|][<>|]*\) .*/\1/
 	' diff.raw
 }
 
@@ -46,7 +46,7 @@ test_expect_success 'apply without --3way' '
 	git diff-index --exit-code --cached HEAD
 '
 
-test_expect_success 'apply with --3way' '
+test_apply_with_3way () {
 	# Merging side should be similar to applying this patch
 	git diff ...side >P.diff &&
 
@@ -67,6 +67,15 @@ test_expect_success 'apply with --3way' '
 	# The result should resemble the corresponding merge
 	test_cmp expect.ls actual.ls &&
 	test_cmp expect.diff actual.diff
+}
+
+test_expect_success 'apply with --3way' '
+	test_apply_with_3way
+'
+
+test_expect_failure 'apply with --3way with merge.conflictStyle = diff3' '
+	test_config merge.conflictStyle diff3 &&
+	test_apply_with_3way
 '
 
 test_expect_success 'apply with --3way with rerere enabled' '
-- 
2.24.0.rc0.197.g0926ab8072

