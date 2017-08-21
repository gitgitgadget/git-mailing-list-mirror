Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EF9208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 21:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbdHUVQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 17:16:57 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:19104
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753548AbdHUVQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 17:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U/fQo5QgvdvsZFTeJCFvxaSAn1c5d+uCqLcMZUkCkws=;
 b=HsK9Of4dHcP0GsiQhP2YSyxNeJKCYA/5dz6FPxQantqwhwcliv/X7bgxMo2B7lPbswrfWSkuKZqbpFNoCVO8W1Nkr+oB5f2QMTj9LH/DFLwVpeslvpg1XAdp0sMdQP2F1/1XEGv2gO0yPr3cB1wWLCPlE822nJVDHvJtnbziv2w=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.13.0; Mon, 21 Aug 2017 21:16:51 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 0/3] read-cache: use stack ondisk struct when writing index
Date:   Mon, 21 Aug 2017 15:24:29 -0600
Message-Id: <20170821212432.47364-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: MWHPR20CA0017.namprd20.prod.outlook.com (10.171.151.155) To
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145)
X-MS-Office365-Filtering-Correlation-Id: 1e622484-b256-4d86-ea24-08d4e8d9f177
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0047;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;3:KLC5wdQOKIrXxYPyWhwpPQbgoMIDxVH95bay5AbmtunfPQOEDCz/uQAnY8ybDrTmwuDQ0oc1oShED8Tt03XaX7GJkrsS427/QVQo70g+gcAcFCWs3UlXq7nBVCURDMNosn6ur2sbQI44BwiJ4jsbpE6uYnaqJtB/BTk+sELm9OXm9UeJtZvMTTmT/c1C7Sk2cuZ6XvzBckx3JdsOGS5nvwjIWBZSP2iazMzDHhfIaYGYbicZW+2uCCqEBRHOd/wI;25:drPVAk/LUzycXXMdnGG5X0mteKZ5u9QHw5Qdm6g207JNM0FIBu0UhrwZT2Qwy3ppV7xMjHAdCfvEcvgDT84cJ0BONcLT73rlzBWiEjXBkbLhCR+fDSbIa7M+uhXrxET8A2ZCA7kMfvWyzkEmrOSrTHh7g1kMuM3ztyc5LgTyFoCV7JEMMLNlJr7n+0cTgtrUDqEVo4wxB8VKQRWI1yL1pJX5FCX9KFxDKQuZpRSCk02jmvtmp3eFOQjdHTp8rNAyuLhaIAMhELLkVTzSOeihPIkmBjDt+I7agWJMqe2nYEBs9kRibBUBOdifEkKN/o8VdBMpB8W+ohkDzqLWsvEJtg==;31:FSN59Xob/TGTh07vRskJG1iZmdAT/GIDpLf6zQ0YHzM/KofcWzVgZuVpzaAyp3CsTaG1Io/UYvRQZJQr2xXzkxaiiKjv9cUNqkp3jlmw1sOPTm4Wlk9fKhk5ZOt0AIPrgfekYxnCLGEcvAVwOF9prOGpBmgVmwCKrTCFOz/trH11yz+xzUZDAE2xBlpBT3O7dUBT/5F0FBmeurJvicsF3uH0jPX/adcs2ra9zLkSSOU=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR21MB0047:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;20:wP60qf5qzgsm2RWx0UvNiTLxGd7kuWkYV0XxrXjaYJrqR2D9jdTZhxuOHNsY2wqWOchtDCArGLBS0ciHZkPyrFm0+KgXetYBaLoKzH21NO7++o9kLq1naCcELxOPmRlkMWZSD8+TVXn9a08sgFT3XZuFoeZIOjYNSS7GVb/oysjsE+BTrobdlpNW54fbg+yMbGaT0VamixNtyYyNef64cNb+Yp0gWQxLAy0H2y98uMaX+FvDlLsavRoj9YsvWE5GqipCWlSkSdE63F+mLVp+BRoMM3l0RJlL7MuyWPGn8pjehBChnYfXISWJWV8zmK/Qr3IYQPO7Cup6V52qmF4RHBvandKWSLR9YifCR8faAhwt4GCVlk0K4Xc0BEbp97DR7o0eb6zPm1QE0tDK8+bZ8+sKgtgmc44l752zViz6SLeVyjqZiXS/rmeCEZEyJqbF6PlCLMMa3qQgtsY8o1k9kPcVE/9ayxwcbwoz7rQcTgyZkyR9D+pNhrAWyWgQt3hD;4:fyjskA7IXSMlBuP/WTCxcQjWNrY9vOKGMT/KfFCJnr+rcMej9+uYqrav/s20iB0Mm288plMQZldQxyNEbBdIMG9FNFX70vDcqQAlXM19kSKtIJcUknF13ydRGsu1iQtbqL/XWvTKSAjtYCu/A/bBE4Nah1YTYu8Lw45UNp626eLxXeBLctpP8Mhrl9qfYCbm93dDipYMv1O1Z0JAEPu+67ERDNd1nC7vtSbgWDcBkdjRnUjL2r+X3y1kq3fmBWO9
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN1PR21MB0047B5297E6E313ADEC7108DB7870@SN1PR21MB0047.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6055026)(6041248)(20161123564025)(20161123558100)(20161123560025)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0047;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0047;
X-Forefront-PRVS: 040655413E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(7370300001)(6009001)(39860400002)(47760400005)(189002)(199003)(6486002)(33646002)(5003940100001)(305945005)(7736002)(5005710100001)(53936002)(110136004)(107886003)(86612001)(6916009)(86362001)(81166006)(81156014)(8676002)(36756003)(6666003)(50226002)(4326008)(3846002)(6116002)(97736004)(5660300001)(25786009)(189998001)(47776003)(7350300001)(8656003)(66066001)(2906002)(48376002)(105586002)(50466002)(50986999)(10290500003)(10090500001)(478600001)(101416001)(1076002)(106356001)(68736007)(2351001)(42186005)(2361001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0047;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0047;23:F0b+1VbD623RHByNDlzyaf/qHYS74wdm+ScIRQREx?=
 =?us-ascii?Q?ODZVAMfvHlM2+eoUHp0zvsWGkicMdQ8dgMjoeZdjm9FkYvhuChjifxabjAbM?=
 =?us-ascii?Q?iP/DklEsTuV1lZ8RxH8x6iG4TniikZ8Oia/uGkkoQhR180SxaL4+dQ1ie+ka?=
 =?us-ascii?Q?goSwVZhyiKQr16+jqZ5uzJZVeUKRBlF9r/B/PvI9If6ogvhxmQvShxTFpRCv?=
 =?us-ascii?Q?WwZyLzyPZeEK+ofIf2R6/Lyhuph01PP+WwI0UmbLCsz9gSZEilbpVA/ViDYm?=
 =?us-ascii?Q?LuNesdkE5X0l7ldvIgXOUWpWO31N2uoY3isZI6OSk82JxggvHRjDsVGRHhZH?=
 =?us-ascii?Q?hYXVMV4tirpNQ/NQEm6Gtqso2PBHfBnSuiqXcFU6OpqytJFinsz+x3PVfVgN?=
 =?us-ascii?Q?zvQmeLi2r4M/0OhTMHymOoEuAhtLI0rGK7lPSxJ9A+2IdEgqc6zZ2SeDqzTU?=
 =?us-ascii?Q?TF7mbCYsH7sBTFHLN6PN/xOKgRS+CiVw4RjUliIsFI2lGi5K5xsVd/sEVvFN?=
 =?us-ascii?Q?ASUOG3UELXe84DfuLy6VMedKqjeu98s2FiO21fUGmFBG/X9SWsP2dBnmp+CV?=
 =?us-ascii?Q?ufg1k44Zbw8VbFI97cbkH4ueJtabdGldz/8TQZucBZoLl8WN0+IBWy5BmrLX?=
 =?us-ascii?Q?f8CTdTnwr8DZMWUF5GrovwLKn4jMCs/1oQzPUu6C8DUQKgi3p5cbGmBYneDt?=
 =?us-ascii?Q?AUFB6dLeO0yoYp73r0aok+gLVuMSjyS3KCAmtb+QkAGAmzEzSqge5OsUf9tN?=
 =?us-ascii?Q?S4pv25gztw/LpUU6kQvKnPxQeEHk0qFWXWrNeBzaadU6+iVThqHh30W2kWcj?=
 =?us-ascii?Q?l9w1QXU6HLATopZ6CFEiRO6k6z9imSZs1vxrRzl+OUp8XoeL3tK+dBPSTXEg?=
 =?us-ascii?Q?wSkP92yoH3Gg2o3BoT3oaOtKHBym76Tij+HrN2KSNyU2TZmDIQ/qFHbrAfmq?=
 =?us-ascii?Q?83WTyEEXOg4F6nhDxrcpKrPFYLvQwpkIDP1uRArfd/4AStrDs932gSkWYoIX?=
 =?us-ascii?Q?mc5WhNifgolNir91NcaGmjOyK7eFaAdQ1q+9qkF1pE0yhUCb7UVgiXVZs3xB?=
 =?us-ascii?Q?oVMP2GZMlJifFbh38n/nMyZGRji4yiN09X05rDFPVns5C0yCOLcnFJLC8+yD?=
 =?us-ascii?Q?6ZwaYPgajeK/sCzZaBzuAWJ1ORivCk/KgKcuyKrsesnKcflKGFKs9GRNR1se?=
 =?us-ascii?Q?MOQDGxFKbfvnL/R7GDpPjPQAZPnYlnuNr/hDIMP2ZjkctyvV/YbSYyc8o/WY?=
 =?us-ascii?Q?765tUmrJUpZcXJmxkI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;6:rdXS4kH0gEHutLnM3HPoAxs7xLsWtKjIa+T92sPMS9kCA2M+HhMlyPGT8gTKjsTqY+LffPqZQbD5PTvewHtRR/I+DiZAQzchVc2WNd6YyaoCECxMWFxEkQLnrOUGE2rCtwEijjhkiBTBKk3WSKNTn03uMePGzldIis8x2qP+vIfVxysqfJ525/lqbWPiEt6XPAQ+CnDcefw3t2HcU0OtV835+P853Wel4XbZvpQ6bLXF2ALRoWjdKzsLD/MW9jEEAxZ3QwN2Pc9Dm+c/lAc9XpPt1Or2NFU3yS40Zy2JJTiIMaVLKd91GBuMeXjfEwuD6J9vU8YyDDG4/E4isdis5Q==;5:hHCwmdSjwW4oqvku8Q5o/016fKXoZjVrueSw/ToTLTsIaYXUik9nv9Ol40MSbgD7KeWR2dL81uCn9fhBucPeivTcWQwgQIyswDinTcv1hcidN+zHKIjEvaQEe4Y/qmuiuNhO6ro3uKh+vVIHJR85Vw==;24:X24BhnXqjxU1RLheUAXM4PqdrdQ/5Ar9xrOqwxDQZcEloiSg9GWnMWw8Kdn+CgTjlByihxnnEC/eLQWKwfkjYHSydoYpLb4AnPcFAXkkSYU=;7:GzxH52SCUF0iPPvRkAF14wyMMhrBqrmwSsBtLHbCZ+hgHw6SvZdna0sn6ddv261xT1nbC99E4EGQzy1F0rECz3qTAE7xDNZ7u9uEitQSnM+LmxqAc3wpon6REiHKtxiXK5mTnyi23lbYHnkZFvCqegcugoUy12L1LoaHMWtl38rwudzKTUQvRnIO9hrkTadKw2sgcvWP5lWksnzK68CpX4UkMKXj73Vbf8JaqGuf45o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2017 21:16:51.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0047
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing out the index, the ondisk struct was being allocated and freed
within the loop of cache entries.  A better way would be to use a ondisk
struct on the stack and reuse it avoiding the alloc and free calls.

A test has been added to measure the performance of writing the index
(p0007-write-cache).  Running this test on smaller repos showed no
degradation in performance.  On larger repos there was ~3-7% improvement.

0007.2: write_locked_index 10 times (1000001 files)   5.98(0.00+0.04)   5.75(0.01+0.04) -3.8%
0007.2: write_locked_index 10 times (1000001 files)   6.20(0.00+0.06)   5.86(0.01+0.03) -5.5%
0007.2: write_locked_index 3 times (4394531 files)   10.29(0.04+0.03)   9.75(0.04+0.01) -5.2%
0007.2: write_locked_index 3 times (4394531 files)   10.52(0.00+0.04)   9.79(0.03+0.03) -6.9%

Kevin Willford (3):
  perf: add test for writing the index
  read-cache: fix memory leak in do_write_index
  read-cache: avoid allocating every ondisk entry when writing

 Makefile                    |  1 +
 read-cache.c                | 62 +++++++++++++++++++++++++--------------------
 t/helper/test-write-cache.c | 23 +++++++++++++++++
 t/perf/p0007-write-cache.sh | 29 +++++++++++++++++++++
 4 files changed, 87 insertions(+), 28 deletions(-)
 create mode 100644 t/helper/test-write-cache.c
 create mode 100755 t/perf/p0007-write-cache.sh

-- 
2.14.1.205.g2812f3410d

