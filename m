Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8850D1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 12:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfIOMDp (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 08:03:45 -0400
Received: from mout.web.de ([212.227.15.4]:41457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfIOMDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 08:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568549021;
        bh=JQC5r/L9XntOooLcFW42LxU9axx2HICqrrQXyxoOjH8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=q3UxTjOuEaplVWVGNHqaw1xEvnjYrEDh8R2VJCHI+zLMJrFmj4ZFSfDOekCbf5JGZ
         tarpfdoXcYmVLrOnlA0nmGTOCYGXIbVVZbm5r1RWvLM9j4SXqmGxCUcSegTHipDEB5
         i2xE+4dKOc1Xsfr8O1jiVfI7Wm/RY8a24soZIklU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MW6Ib-1hcnBM0ydN-00XJ0R; Sun, 15
 Sep 2019 14:03:41 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] rev-parse: demonstrate overflow of N for "foo^N" and
 "foo~N"
Message-ID: <c43610f2-a51f-7333-a200-a76930a0b705@web.de>
Date:   Sun, 15 Sep 2019 14:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oQ6WVmtw/tJEe7Gm9m7FUXyPcfqTEb8Z0MfYsvcjsYqMyo/X+Hi
 nwVGr3A7fwxjSB5KUc9UPIYBSlniyBvq04oFRMBfWxFfdOEJDSKZnn/1Xiy6ru7nxE1kINS
 NH4YNYVJlPc6f16wlvimWRNnCo5fymIsHldi4DROwDL7p4tOGYHrK7cu3Dulj5HYQ/j67W+
 qsEZpa30y7RI1pxPvS0lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdwLIodKwBc=:naaeTL7AML2eBOzfHeenn7
 dSe66/1E7cZNEK10qtCwgzZ3/kP32bwAGHfRPN4sMu2902RyHSL3sBKSAIi0oGOZJVq1ZinrL
 fSCG7ttHB2+2B99cCox6HWQZilKwy8Lr+JBki4DqpFggXRw+V9EHMARaqRjcfc2tuTWcipY+a
 j0DAEVrgLmcbtVzGKWqVqFVTBjouBOGDug3xB54R18+/rHY3Gasz0E3/5LqVyfccvbuMiqlRu
 oCbn1lgVBc7TFDto4nqKk8i7ne6U17IoL/gbDobFyfdrG4Ygd6aD8gjdSCanQOA2ZGChkLWX7
 jG9XRg8isyOl6nhmvR6ugNPb9KuZmP5aamrUdsdV8OF8Yxxpf2+LCesdxfkVMQvbbn1UBgjAy
 6xVZWqDXhNcib3JH2+vt2YiUQQh9RYeT7NCDYRguNkxWC68v1RNKHijjV4DnWu166TvdjzSZW
 M7dj0GsPLB0JAke3UmrjWjot+H16y/5DQhPpcZnm295DY4xhvT0nsubxhAAYhdc3VZ3+Cl9j1
 gSDakJIj4pZ1OBe81BF/bkDPOfIOc6NPgiqeo687qKlkksdXDgvBDz0AjdKUtJyLWJvYYC1NM
 DDas6jOiWdnXH4TzTLZ9QNgR2x6TvlUzcCICh89F6IHFv4Y8ye7Rd5QsejnG3BN6HVaMJ8TmE
 Z9X/HjXcELnxalOk2hpm9qNzoBTX/+lX5KVi47VmbjOWm2+599T01Cqc6zf3j6gJ46U3BkXmP
 d1xtqAN1G7tEjMkiLgpdwjjEiR9lbteBfdW2E2FYQjBIIqLl29GwRmXKfvuKPTVl4Mp+h1BRF
 M1pXIaBQHZI0xmRpVxdzFi7TWmFg+pNAdtDIdsCr99A8ffKLoLb5FRZmJXqBxB16KMGEcDa3Z
 3qfhwP5tpNq0xSnO+eNuyx25jHL5v7IROqlFiJsbMVkHI9EovJspunGVdLZNqsulB7b5pNudl
 P02LT9Vw/2+Q5AD+jtYRw0N7ARvnbq429RFWSchqlwWviJhdJfwBpPOF0TNCsE1OjLt2p02qk
 TJX08ATiM6G0R7FzZ50JuQBnFBDhdizbo0rmsRYI90SqY4o7BTsbUIyPcbu6jd/0xlG10IZ46
 RTNORCRDSmWiwLoKX+JYSEYJNPZvhbtfIdldC6HCDdr5/4cGXy3xPegwgI54o5VHZe/s65w0H
 ajMMfSpFMY9jot6jUuw96eaJUUu0mxPOOb5dZjSXb0FGy52jNqCvHVAsvh6kvBSlQCtjeA9LG
 vFHkixSEqxGAqzBTc0/sXorZlKyQIAv0W6aDaUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the number gets too high for an int, weird things may happen, as
signed overflows are undefined.  Add a test to show this; rev-parse
"sucessfully" interprets 100000000000000000000000000000000 to be the
same as 0, at least on x64 with GCC 9.2.1 and Clang 8.0.1, which is
obviously bogus.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1506-rev-parse-diagnosis.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.=
sh
index 4ee009da66..5c4df47401 100755
=2D-- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -215,4 +215,12 @@ test_expect_success 'arg before dashdash must be a re=
vision (ambiguous)' '
 	test_cmp expect actual
 '

+test_expect_failure 'reject Nth parent if N is too high' '
+	test_must_fail git rev-parse HEAD^100000000000000000000000000000000
+'
+
+test_expect_failure 'reject Nth ancestor if N is too high' '
+	test_must_fail git rev-parse HEAD~100000000000000000000000000000000
+'
+
 test_done
=2D-
2.23.0

