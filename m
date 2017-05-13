Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB0B20188
	for <e@80x24.org>; Sat, 13 May 2017 16:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbdEMQEB (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 12:04:01 -0400
Received: from mout.web.de ([217.72.192.78]:57524 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753347AbdEMQEA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 12:04:00 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJkxE-1d8T3l0ASK-0018bv; Sat, 13
 May 2017 18:03:53 +0200
Subject: [PATCH 5/5] p0004: don't error out if test repo is too small
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Message-ID: <ca844223-bb04-8885-2f33-2c3e9c5a5e3c@web.de>
Date:   Sat, 13 May 2017 18:03:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Jb9YVmM8cKwAy5T422bzvToZaX7ZZ9t8hGrL0TbGbf39vBvZSXw
 qHNGlM37VddnIO0UZesJGfIDvgvIqmiwg3x4I2r4R4GBAaWjxZoYcymnTdNOCxBGZIUaQ43
 dB+HmvPC8JR3+A9e6xNwBMiRb5W6UAQXAy8qycS3/R1vUdGsSlEzWGxhipn/3K1FevGYcN1
 Ur+eRGB0BLRzzDxhALx4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nw7GrLDg8q4=:6afMpvgIy+mCpT+xOu3S4V
 Dhuh88bvTscOrqJIl2A4gjv8893b+VGwB24oOH8W3CUkkNKsYDqTurXnEUFffueYrtOapoq7w
 pSHUdNlI67QfB1CTibhUHGR6sSD7Ji7QKwbHweOyN5wtibNIdn3/OszvcXo5afQrGigGHULsZ
 6y9/vjRZqHnYoFLNrLwfNCXotpJak8VcPIOssI1oLDvou+i2XyaOf03Yq3meY2nfPdoegzs/S
 JJJTu7w3bHpWetEHPacLdG7BScCgHaDRh+Wzxo4507+Da9hetgSs5B1sP/nL6HkQ/txOYj5Sl
 SMAguTXVhd/rEfq656zkM8+S+LUR1qyAZbgGcr47WxEw+WgP2LFj2+i66yvKCeuDSe+TTAtR4
 /xJyeu/ChS7dfLWsnyQw8sh8HUEDJIYqixa2sN8QuCXEJumfjMXfAD7U8keke+Wj/svB7juv5
 Av6dPfBDShVetxjKe5taIufhSuaoyN/M3JHj2LSXFaJlYBqOpUk1We20x2DrZtizLGyw/fmIs
 wZzzIxmCCQz8CyUlD2ZRTCSBEvY72PRZOXWDG6pZ4LT20zb7Bgm+AcpU6Nu/K3XPc4cjEBJs8
 2XlTZH73kbYxHsmc7G+8taBBydWOCtWZHelgBRNR2IidC6QPzn6ql8jtD5d1YdVP+VgBJfGGw
 pNr/5namwf7EZMKjzNrPRhTM+eUxcDKqJfJMmdrGK6mLk1wmnVaUuBL48vz7Q/Zz//6OC9vn5
 do0/0RYtqF8eNq5tPojU8QNfCuRHSPDjAM3s3VeHqcO3NYLJ2lOMGTyCE1D5sotSBqob/e4b0
 tne3W9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Repositories with less than 4000 entries are always handled using a
single thread, causing test-lazy-init-name-hash --multi to error out.
Don't abort the whole test script in that case, but simply skip the
multi-threaded performance check.  We can still use it to compare the
single-threaded speed of different versions in that case.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p0004-lazy-init-name-hash.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 3c2135a185..8de5a98cfc 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -8,10 +8,13 @@ test_checkout_worktree
 
 test_expect_success 'verify both methods build the same hashmaps' '
 	test-lazy-init-name-hash --dump --single >out.single &&
-	test-lazy-init-name-hash --dump --multi >out.multi &&
-	sort <out.single >sorted.single &&
-	sort <out.multi >sorted.multi &&
-	test_cmp sorted.single sorted.multi
+	if test-lazy-init-name-hash --dump --multi >out.multi
+	then
+		test_set_prereq REPO_BIG_ENOUGH_FOR_MULTI &&
+		sort <out.single >sorted.single &&
+		sort <out.multi >sorted.multi &&
+		test_cmp sorted.single sorted.multi
+	fi
 '
 
 test_expect_success 'calibrate' '
@@ -46,7 +49,7 @@ test_perf "single-threaded, $desc" "
 	test-lazy-init-name-hash --single --count=$count
 "
 
-test_perf "multi-threaded, $desc" "
+test_perf REPO_BIG_ENOUGH_FOR_MULTI "multi-threaded, $desc" "
 	test-lazy-init-name-hash --multi --count=$count
 "
 
-- 
2.12.2

