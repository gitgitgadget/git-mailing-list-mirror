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
	by dcvr.yhbt.net (Postfix) with ESMTP id C197E1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405195AbfJWMEB (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:04:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44698 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405189AbfJWMEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:04:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so9982760pll.11
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxuKgLWTlou5NIbIdnFQfMyBFabePKf2qEq0cblINUQ=;
        b=s3/Nid89iEL1yHxkX1A2S/yG3L5spyoDQBplfynDGvfr6viiE760Nl2Xc/I1sIVD3F
         BaMsXP/5pySBHYanvJtFORDwUW+oB2kugH9pgvnaJsd3c6x+Er21cRhcUYR+mG6Iliw2
         3B3Dd3aHi5oJ7SKoD4Bq2Q4Q/QooWs4bVIz0j5yekkfsOVsVOfUQ79RDUC3CgCy8KZR9
         TbS6GTaLHvpvfcYnTXmTzbwz9u6a+04/rimglbwuvT+QUI44KXd+CspbPQRbYmthiV8E
         +5xYYJcPKdqEiUNG2/M1SqW7O6VL/ZEJi6+1q/IYOgEt5/Sa0yA1gIpRl5HHVEOH4mzz
         AR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxuKgLWTlou5NIbIdnFQfMyBFabePKf2qEq0cblINUQ=;
        b=tp1RS5U3RWiOfbw/zmpkEhoG70ICkIU8AfvNKI+AsIx915W6Mzjxx6AJEmBIF7Oq/n
         EM1Y5Gr7iSIQqvzWcdiX7/N5U//uUwnFh10J7mLZUeuSdOVq/N6kod/fCz6aUMX1caqW
         EF9767s4Ovx04PjIooKEwBngCXkqodAKpzBXBEhoiAooCUXcYtdsjRQsTfdpbFppdTVC
         HBwpkmcw/KKpsdOpJaLAcVvfmWCcasSccleo+9oMUKe54sq/2e4BDDBU6hrv3CnLBUkJ
         GaZawDuhnQdHB4p2q8phJpqRRC/WIaRVvEQP9oA57WYPVVw5yoTrSdoWR5SRDho8qTMh
         h09Q==
X-Gm-Message-State: APjAAAWA0pNY+fE3RZ8ypgMryvZZO6uWfUaSR7ohO6PSNJhT+tNe/4j2
        pyfgdqLH05J814baf5J8GFNgzjxj
X-Google-Smtp-Source: APXvYqxGFHlrgEp1RaYGF4r543DO0XSZhGO880Z1X0QYHTWI8Agi7xyKH7MDj8rzD9BHB+vlv4ouaA==
X-Received: by 2002:a17:902:b485:: with SMTP id y5mr9100005plr.292.1571832238788;
        Wed, 23 Oct 2019 05:03:58 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id 27sm8801328pgx.23.2019.10.23.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:03:57 -0700 (PDT)
Date:   Wed, 23 Oct 2019 05:03:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] t4108: demonstrate bug in apply
Message-ID: <5feddf15978e77b19d8b3e2e5761e394e0bda3e7.1571832177.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571832176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, apply does not respect the merge.conflictStyle setting.
Demonstrate this by making the 'apply with --3way' test case generic and
extending it to show that the configuration of
merge.conflictStyle = diff3 causes a breakage.

Change print_sanitized_diff() to also sanitize `|||||||` conflict markers.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 58 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 3615256492..84347fc178 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -8,7 +8,7 @@ print_sanitized_diff () {
 	git diff HEAD >diff.raw &&
 	sed -e '
 		/^index /d
-		s/^\(+[<>][<>][<>][<>]*\) .*/\1/
+		s/^\(+[<>|][<>|][<>|][<>|]*\) .*/\1/
 	' diff.raw
 }
 
@@ -46,28 +46,42 @@ test_expect_success 'apply without --3way' '
 	git diff-index --exit-code --cached HEAD
 '
 
-test_expect_success 'apply with --3way' '
-	# Merging side should be similar to applying this patch
-	git diff ...side >P.diff &&
-
-	# The corresponding conflicted merge
-	git reset --hard &&
-	git checkout master^0 &&
-	test_must_fail git merge --no-commit side &&
-	git ls-files -s >expect.ls &&
-	print_sanitized_diff >expect.diff &&
-
-	# should fail to apply
-	git reset --hard &&
-	git checkout master^0 &&
-	test_must_fail git apply --index --3way P.diff &&
-	git ls-files -s >actual.ls &&
-	print_sanitized_diff >actual.diff &&
+test_apply_with_3way () {
+	status="$1" &&
+	shift &&
+	description="$1" &&
+	shift &&
+	preamble="$1" &&
+	shift &&
+
+	test_expect_$status "apply with --3way ($description)" "
+		$preamble &&
+
+		# Merging side should be similar to applying this patch
+		git diff ...side >P.diff &&
+
+		# The corresponding conflicted merge
+		git reset --hard &&
+		git checkout master^0 &&
+		test_must_fail git merge --no-commit side &&
+		git ls-files -s >expect.ls &&
+		print_sanitized_diff >expect.diff &&
+
+		# should fail to apply
+		git reset --hard &&
+		git checkout master^0 &&
+		test_must_fail git apply --index --3way P.diff &&
+		git ls-files -s >actual.ls &&
+		print_sanitized_diff >actual.diff &&
+
+		# The result should resemble the corresponding merge
+		test_cmp expect.ls actual.ls &&
+		test_cmp expect.diff actual.diff
+	"
+}
 
-	# The result should resemble the corresponding merge
-	test_cmp expect.ls actual.ls &&
-	test_cmp expect.diff actual.diff
-'
+test_apply_with_3way success default true
+test_apply_with_3way failure 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
 
 test_expect_success 'apply with --3way with rerere enabled' '
 	test_config rerere.enabled true &&
-- 
2.24.0.rc0.197.g0926ab8072

