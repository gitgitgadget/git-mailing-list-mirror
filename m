Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583B52047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbdIST2s (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:48 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751390AbdIST2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JumafZzZw/8s1mUvrn5JWnIChs7MJE+Jxo0dCQFiI5Q=;
 b=JafltKbQWohyXpJVMdfkuD5fcG5bqky4MA0Y50TVHfkVs5LZgkkoXgVKRK8AFYEYgnlvP0pr8jhCbtE2F3m18B0l5TAYSsyU9nuB2d3NmowuglKoJPV6/+6WIM38YY408p0Qvw24v+CRdTQTwmSj14S1f9DUuRPuqFBaT+K8VSE=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:37 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 09/12] split-index: disable the fsmonitor extension when running the split index test
Date:   Tue, 19 Sep 2017 15:27:41 -0400
Message-Id: <20170919192744.19224-10-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974bb2fb-82de-4447-9c23-08d4ff94a143
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:Iqc4cuwvaam+9CrDXCYR2HVZLL5brdNPyyYVZFr2N8k4YF9Q6GdiLmqyzHDVq0XjekWIeRlx2sTlmaCvNUgwpPHJSTsgrl5866Woz0b4VJm/9fUAd0ZUbInNKkAs89i8B/y3sJ5Ui5jreb8nm2TK/aRPzw871JhCQEsRfQ2Rd+pDuYFR2TkBYQANlE2Vb1Ek89XHYbauK9MVL/2u0wGtGAgHPOVHZ2klJg7DFtfNG13oT9RJDdM/vqXDpaCbK7SA;25:Prj9x2GKmx7zToBwiFU0C36h6HRErab0GUXgF+VUBWr8HM9WWazFXyG9F5mA0vdzYiP0MqtdAvCDrQmme3Ocuf57tv/B+OO3BqZTNF6yw2bpdRX9CD3ViFt8tv3ajM71f2wnHXmaOHZPcmgAg7NqbBJnk2ZGjXAKlzToIhc+EkbBIjwn0UpTUOVYiKxZhD8BdLNpn0FeBXOeuR/ZVXO9c6ZHEZZ6IN0yIfWif94fx4tAKMTdK3sRaW455rTm8wHEqtjrm6oWYs5XxqnlFB4IKmUkPdf4aCAU+BIDc8UNDCXOYFCN2eN8us9El6vJToGKUBBk48pZQhd1Az+KThJViQ==;31:b39ocnZWma5LwbIsF/PeC0fjBS3M/ubQzXJjxB/36Wt/SjcIAlKXzUmfCOfLBDYF7m92XISeCA3IzsHa0j33JJpuR6K+RLKXbw0MvPn03GJFfEKSKed17zgW8DoOkj/gvgelPdvZ3K4LHRx8+RIvmfQfft6pLn2DHfvsD3k3yEK34O4ucVqId9BMOzEM6O57kbAi/zXEHqVgV8kJbPSAyE2ohUI+JmnkzXADnxjKCQ4=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:dE/ZHCdi2YbTWldGYsnfR14xG9TozUZgnWrXfpDTt33xjqvsFvcWD+bLyKG7/cQYUqsWdXy2PSH8eq8WpM8mTgp5zWICOt1Zb+TSd03NjBUhG+o+1yJO+BvVi87UBNvs7uqIg4cgbIHqMeFHf6Oqtf+xsz2GiDgsm2QPkVe+yVA3LdLu0jmPCBY1M9RWzqv8OEdf580ukwm7UlZAcUOWLrFEfU9+/zt9zMukiazttje6oZYcwX0F6mX8zcFk4kPn8Ggy7QTk9DEkuxtxpItG5s+BcAkNKtb1iypx+2gV6WNhU0f4k4okt/do72Wg1cesopYWCUkIb+1iKV2AzS9eFcFTxw1A+Qa9C/bq+HjRm6YsjFiXL/n/aFDzwlV4ZmtEtImXGC5PcQzOPyg9MKC7ccSaYPpgN15S7i9j4OiY9VgVGVb4lsueBuq6LrUNfwFj9F+Y/hlmUKkicIHp+vwlabpPbuH5ZcrUakk0yfwM+D/FcYq5KMFls22J0jslt6Eq;4:yahfUcbFNTJhjE0I7QfgieMk+M06SGWumW8NbYBjpNxBSguSk8UhMQYra08RQ/Y3tFl67ime6fuHw1bhVZPfao5LQInfBUBqaoeWMeNGl3E7+mk5v1FsAP9oLERdAFBhbJz18Q7DZyx2ExefeqMsdD2w/hmqfseS2wzen6/qenCmJAUE/jlMbNMKuPSATNZTYLoV/bYAsLq7qsQ2vhPw/lh8FmPpvvRRAKcR378gKKY1qDJVCzj327qMl4klH0HZD/FSXIy5A1dJl5yKzlNRhHvC5vKo5TDff7tbi9Kahu8=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB047146057D135B81C72F47A4F4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:GMPW99JltLOuuzbH9yIcTs4bBmFgrGdpXqHV4vvCF?=
 =?us-ascii?Q?kMDIogVuQW6EuQNGhlsDUALR4Edmmh73JgrIz20FvTf61EsdD58D5MROD96c?=
 =?us-ascii?Q?2Z1P5ExTxb7YoQAN5eBs0MIt1Xtm5Rc7dZUlan82b56NCbKPtD5KKuoVhOa9?=
 =?us-ascii?Q?tdENSuseb/kWv+EhH+JfugzpPoPpMoMZSPhmSaQ9mG2zjah+JSmo1vu96wHa?=
 =?us-ascii?Q?gOorJnIk9oBug2irykuOV5o8U/evrB6rnZH9eVx81XHT4W8rHCut1RNXEO/L?=
 =?us-ascii?Q?/r32eBYai5SgWRLKiDTmqTJaF3wFEBb2Mj4pHEFZFtHnOM1+YJKI9VYNevcq?=
 =?us-ascii?Q?sD7YYntVzAv8e62eKIjSj71VwOQuhWPKaSFlaFS9vk5YmsVfbv3CenQGYRL7?=
 =?us-ascii?Q?z9t9WlnQxG36E2WRHhswkl3gSCIr4jhcsc+R/4HylnZgveFDPLJjdYdXcpdh?=
 =?us-ascii?Q?CWuR2hSRWEysXIi53K7VSFXTDkpAN1YB+XhIq/d9ISU0+NxHWGkP+hw0n/SN?=
 =?us-ascii?Q?xgYFeVzpHPBPHKlVgFEyG8XZ1G6s1hnre2JcODMaHi7N/0hTkiN3Y8oyYa2I?=
 =?us-ascii?Q?1HIvMal4M8yudAXrRfnaIoOq7BdHX6H1pq2U8e64MUSbQAbQ4i2MEWv6/yk+?=
 =?us-ascii?Q?4TOMJGwpSZThKbzBPZ8BBEjQLEa5UNXyR1ureKbXnr216nKS1cF+8aTSzxcZ?=
 =?us-ascii?Q?edjboNbF1LC5K7X9s1u5gILmDGFmowQT1n/OELR58WYPShd/dPGCSRoCXpdL?=
 =?us-ascii?Q?QgwH8VT2QAVnohD0Dh4BF5/YUJYE6HfyQmHMu8jamCAZgGA55LFRbVvT+/7h?=
 =?us-ascii?Q?F7i/wvYrQ4D+nqYjWFBkujtX98Jpm3kPT75LJax5Vax/IaGsAq3fVX7PtoUM?=
 =?us-ascii?Q?cCefytnwWFBzZSnMng0USJthDMXpCbafoVceIeEIKqDxNXFnAkGhJnD7cDha?=
 =?us-ascii?Q?ldQ2pl5FvXmWV1vATm1ZAk2dgmI4Rg+CVcqZPwVJLaHxrR8ScfPIeUd53Zy3?=
 =?us-ascii?Q?IM3F4JOcaCRTybrFp48ocv4Pv8tUqN2aE4X68hzoogJrwbKlqgx++lEq8GL9?=
 =?us-ascii?Q?ws7CsY+NVimBVnk6VcI9e+dM0B3tMN3GSL270bCLg/oO4dy68ErYFNdDlzcz?=
 =?us-ascii?Q?xeIhLBe5xtJGA4viMQuz09LZeDBTvkgESpfQ12xzIKV+O+GUBvxRarNp0IlM?=
 =?us-ascii?Q?YSXxICSVVxIUGY4YaRTLjUTtrDAmraJH8HLbupMWlwEp0d+Kw9d9juWGNNEo?=
 =?us-ascii?Q?wba8775b/QcTtNNHlD+PJaaS4h+jfLBjycXNxRCHR4i6dLb5VRg2rCa4lOQj?=
 =?us-ascii?Q?LEGZdD9OgcYgZ/88/7izkEH0czXMGdE0W0UKT+dt//XrLkJBQ9lXxloQkEPf?=
 =?us-ascii?Q?Aq6WHtbBLUhCrGd6x0kLlZpaN8bwCvZeN9HPysNKEO3inLNGeG1pfgHr2eSs?=
 =?us-ascii?Q?z9KF1xYfiFlLNHcgXmeOwrlN7eFn9s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:Dd6OJeLtlDp+nDspBJAlKPaZDsF0tkA7TSb4JrMa2fjqr3SG7KIC4US13wUuhz12X/0yigAeM2mBzw9aZC0p5ddSy+7BqKOBKNYR6GKA7Pi1FfaYmLZPSHgCgOHsXguaUkSEPKVcAvr6KZTZ1E94Kf18lK9f8XKhjw0LB7f1i1kBQKEHIJqpGrzgscrAogHGSMxCpGxsR99+2thWGA79MYho+bJJyT6fput+lKMlmnnjQoel/bU+bC2cTzNBKuANF53cOwW8rjWOY2KkvdtBaUtZmxX7OQftC4K8z6RjBsrkdOGGZEeJuhlJnOBxfojyU0GaCcaLcu33Xyn1TV6lrQ==;5:tdzfA+xmpyioGvMkY9tmDI03aSfTBy4LD9gvSAcCLmPZb++DXvPhlOZblhJwOngIUKUzqGniDbjbHfw99g2iKDpF0+XHejI0Kme+fSncg9Ktz9aWP8Szcb17S1pPJjRhH4o1m8REvyqcVL0+ZVMmlg==;24:JeEqXYTPbofVuGm/mEwQMXowh3i2Lqo6JqqjT5Mreb+NKdPnrfZ/kap0WeEQ4TBYemXyGfb1O0Oac+o62qWXdTEB3DtZPoFe5KpsrtVOIA0=;7:SbojYJjrIMuyVmNXVVIZ8ZussdHQlkYjF7gniK5mgmaug8G6km+LLDHUs0g58yJITvyZOp2y++XRRhlKTjFUhESYvku8aiv6HGL+Fm3OTZKiuS8oEgG6AVNAcF3u6Ra6LpBaT4ZkYs/dgjqZMCuOLwropCx/RkgcYfqCQBbZ1IZjRqST6dobL7+SGF7eMIn0rYd+KaYubQsEvJ8+VunnDZQH2fKOMS57o64xMIamF3Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:37.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The split index test t1700-split-index.sh has hard coded SHA values for
the index.  Currently it supports index V4 and V3 but assumes there are
no index extensions loaded.

When manually forcing the fsmonitor extension to be turned on when
running the test suite, the SHA values no longer match which causes the
test to fail.

The potential matrix of index extensions and index versions can is quite
large so instead disable the extension before attempting to run the test.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t1700-split-index.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 22f69a410b..af9b847761 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,6 +6,7 @@ test_description='split index mode tests'
 
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
+sane_unset GIT_FSMONITOR_TEST
 
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
-- 
2.14.1.windows.1

