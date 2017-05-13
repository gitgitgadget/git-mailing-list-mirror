Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0E4201B0
	for <e@80x24.org>; Sat, 13 May 2017 16:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbdEMQDd (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 12:03:33 -0400
Received: from mout.web.de ([212.227.17.11]:55569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753030AbdEMQDc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 12:03:32 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGAG3-1dC1ZC3xI7-00FEaN; Sat, 13
 May 2017 18:03:26 +0200
Subject: [PATCH 4/5] p0004: don't abort if multi-threaded is too slow
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Message-ID: <871f5f29-feb3-5c69-7ddd-f92819a76cce@web.de>
Date:   Sat, 13 May 2017 18:03:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:EQoxazdDFpYD9FUVAwlPqidBX7OM1iIzmAClrmBcLOKr1xLOsn5
 A53VvRnlLmpmMZqBCAt+njvwfAH36XEQPQkbiH+sPZhVFQ+XDQIXZll6SutPmUJDsNVZ3q3
 pbSQ9NNq6jHjQixC5kUjRbUrBrVL7+yVQNv2B70HWHWPQlfI3M8eChqyMObY/7r3H4gIG61
 JAlTyXGbw352YR6C8g9hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W+KwwqinYqY=:tUj+ycT5epkxCTuFwgy1OL
 RTW8N0dak4ishNlSb4eE7OAZq3lATY9rCLlWGB/vc24h8l2nYEPqeIqxSQ2DnZebS1YNUYjCp
 cK5fnUqHTfehb+pp9gZjk6qBCxmDvOXkyUGx73PZVUtJ4PYjXQ0//5E5KqtuyLunt8iAYcgdZ
 CGHr/xioWe06qkMfutLkN0uXpqyzOQUaHPl2UtDVRpMMSyv7znIXej8UKKPug8G1KCM1oVvER
 hYleAj5W/e7+CmpOINFaWUDCf3ITsUtsDjyeRw9S/6+cl++MvOzAQhdSn10vw0fTWiP8DGt3+
 CJlnsDdMljZTe6n6Pk0ACxe8vM36N+XYXpxYqD7kh1Q/cl2qTg9ZAU/2Oh4jnaWqUmijm0tsP
 Wp2kQQjPo9uEdYYe8a1bePmWpUcV7i1k9FjeSMT4iNMbQoTqABTkrdaESLVdel4YwKncda8Oa
 1j49MRGrq300B3SCBxJ43nNb6GpZwcCDyszzgHIezoxNk3/cywo2A/wYVPMbM4Ag/Ir2yvKhb
 n/hFpyrksm1GBoATAJ2QMmZbqU4lPykhkJiV7p1U5/7mAgrzWpF0wxHa6Tg6fLXhuHbs61pjQ
 Lg1fk9UI5BLqjkAgbICWT8gk0382LsmobmYhLiMLNSwidJ1S0PgPVkL/oJvtrP1cWIsX9o+j7
 oA2b6zWUxi10G7t290oFO23TT6Lmik72p2eSEnPFH1MP2HA/Ha5HtjsECRSgDw/4MNyjcfhSI
 n3QQslkuXjICPo09GxqZJcetK/UCOn0E5hD4hAQ7kIgyaR5HZfuRdNsau3h4mP06A5bbhj2Jp
 UsRyaRH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the single-threaded variant beats the multi-threaded one then we may
have a performance bug, but that doesn't justify aborting the test.
Drop that check; we can compare the results for --single and --multi
using the actual performance tests.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p0004-lazy-init-name-hash.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index d30c32f97b..3c2135a185 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -14,10 +14,6 @@ test_expect_success 'verify both methods build the same hashmaps' '
 	test_cmp sorted.single sorted.multi
 '
 
-test_expect_success 'multithreaded should be faster' '
-	test-lazy-init-name-hash --perf >out.perf
-'
-
 test_expect_success 'calibrate' '
 	entries=$(wc -l <out.single) &&
 
-- 
2.12.2

