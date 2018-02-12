Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE411F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbeBLASZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:18:25 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45826 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeBLASZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:18:25 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id l1p9eISASykf2l1pAe74ym; Mon, 12 Feb 2018 00:18:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B8mXLtlM c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=kmC7ijDzF47jIYV_hCQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
Message-ID: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 00:18:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOy3mwDXBFuUz/GqkLAxtoiWLmpzNZOYsp7zW8CuiZ8eU5EQekBs2muNvovv896mCBqQ3us7yV9QBLuUcg27Z5vSbfe8Y7XOweiCInqczlb94eB4iTHs
 iSnw4LYBFuyv7P5Yx03n5Gkgxyxi16GVmnh0vkQGz+Rt8TPyg03m8XBFMG31nKct70tBpGpEEaePzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Attempting to grep the output of test_i18ngrep will not work under a
poison build, since the output is (almost) guaranteed not to have the
string you are looking for. In this case, the output of test_i18ngrep
is further filtered by a simple piplined grep to exclude an '... remote
end hung up unexpectedly' warning message. Use a regular 'grep -E' to
replace the call to test_i18ngrep in the filter pipeline.

Also, remove a useless invocation of 'sort' as the final element of the
pipeline.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t5536-fetch-conflicts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf331..38381df5e 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -22,7 +22,7 @@ verify_stderr () {
 	cat >expected &&
 	# We're not interested in the error
 	# "fatal: The remote end hung up unexpectedly":
-	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
+	grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual &&
 	test_i18ncmp expected actual
 }
 
-- 
2.16.0
