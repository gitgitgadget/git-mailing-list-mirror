Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1322B209B5
	for <e@80x24.org>; Fri,  8 Sep 2017 18:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756651AbdIHSBq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 14:01:46 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:32016
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756294AbdIHSBf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 14:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sLqxtBlHPY6j80HEzLYYYD0T7AuaGKt9aILaVEfYk24=;
 b=CbtWboF1IHh9E+IGefRcVyuQQtQOAenP9ta3Xsdh/JgksFxkfFqBQEt8hOIckEOfi0Zu28naLsisu5+9eKJhEOX2d6+Y1xX/xXsA6WME7nzl6BurciKdTzB4AaakCRy72/sn1Ju3K3z76WtRkPT5JmZ/8fUJMTYN4w3chcwoiPI=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 CY1PR21MB0008.namprd21.prod.outlook.com (10.161.168.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.0; Fri, 8 Sep 2017 18:01:32 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, pclouds@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 0/1] reset: fix mixed reset when using sparse-checkout
Date:   Fri,  8 Sep 2017 12:00:49 -0600
Message-Id: <20170908180050.25188-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.474.g4443e2d25a
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR0101CA0031.prod.exchangelabs.com (10.171.218.44) To
 CY1PR21MB0008.namprd21.prod.outlook.com (10.161.168.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30646cf7-f279-48fb-cbf3-08d4f6e3a37b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY1PR21MB0008;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0008;3:/L4IGd5nxM9QO1kwjywFZjFYRri+VGfyBaGGU1UvcqOa1KfrZGZ5ba/JADhWIAXm3bnMyXMfo5Vo1H/0B8ajoNzOKg+hVpUlBVgWxrPdU4mhAT6XRohqvRU4O+jNSf9qBM8H6TBgI6kgoN17/8K4Ym1roEqZeEpDJBhHNoplOCOd7G9VOT1DCdqMr8zZif9akZCM2r4vO54F5D6BNHsNXx3Pja7ECR5pWKK+88fluf6xSdt2KKIm1V4ut2IGNkHJ;25:jGfC06qNOWQIse2rFbNo9+LJ4cazXAZRuysalIK6ZkaEhBUNhvYDi6uL9wnOGV1zfv7gUuXci9v1BUAqpJmo08V2tLUEmcKmw3F2iql3h+TrryQuzBI4C1++8Edme96vwfWcj8bFqBr5ep24iYU/yLBtYPxhhKnPK03d5Zl6DIBOkrjZKQW8A2HAiuefQ+A/eih8PZCLyubhtH9jSCamGBuFDDMhxBXwLsk4uWMZI8CawWCsKQD2lw33oCcBDTqL3mtruFRgBG1HnkGLt9hCgZ73f+Ph7qJNFAyix/zVZDbYBRT53ygtSH4i1dZ6yiO6a3UTxkI1zklyQv7Q9cWicA==;31:UiXwcasRBtCN3Qv/edk/fEWYNeCzyrOH1KtGhtj+77Eqzf4fZ6wCifm9lANOawAoUaeOB/lI8NrZ/l2fxdxyjY8yz2JFJRxxVVv0kmgOMab6cHgGeupp5DXvI1DHinTmOBb1gyOGbaGmDKUmxJK5+0J5nMJYBu9Yhm56soQ2nPZI6gqeuP0K4YqVze5Eplv8hZfetMIJxXD1Wne7AkuyjE6GQqSQkRNYo7yLVtKulWk=
X-MS-TrafficTypeDiagnostic: CY1PR21MB0008:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0008;20:GnEoa/OtKzQ7Ch1uiKHA4tuml0xvype4xYReVIJQL1V2V2MZjduf5qsxJfAerQ0I8Le9wNPSDwlBrss2nmeSt+Bz0H8MNd3xHMG3qY4bLbga4xTbaeZ80gbkDIeaWYCXX06UFP/FxVWCZlySrW02BjMzYPazjeC5hlmOtab4zA63EBUFhm/e9FLcFUzVWPR6bBczoy7XeOFNMDilJ3NZcfx1uLdZ9Y7Vx3JQXV4bL8lHiu4lddTE8roXMADvl7LMO+Ko6P1CChlsN0SypCp7UQJocp5i7VObpHIfwQ5BYtXW0hORjwgn+ZO1wQpqPdfEomWpcQ/xlQwU+Rn8fdqaaTkpF73L2bQYxD4WFaI7RmOWX+AedoMZtt0V4c68JAcTlDOWI7azHKKpybbK2DFNbZRihjZeZxRtVlsE7uvYrmBJLhReTuvpavc+P9F2zLHrk/UbT4EZuONuqU4pGSJwwM58ul7oTJ0REyQs3OXcrqI13g7gEAASa6e5ukXq94vv;4:ulf16NZ6jajT4xEhVFctOLz65D4A3LzrYmJTKz7KJzAAgeacZ8Qe9P8iNV8HTLjLcDG/ao6Ofq/HJEOxmsnvBHDOxnCVnfGR/2jkCxhLmvAqY5FarTxiGSot/uvt3zJWVlj4ixSRabZJKMuHhdWfhat1V+D7XfaxqDnOm34pxW3YFL1KBJTquUpA+vFnOoeUTPRBGM8BswAd/ER23fMnOsEB9DPyRSMa4YYZmp8BKmD3Y7fx7jzxdQ7Zm2KHQK3cp6x8KieHx9gpix0DX22HwDAiWbHREHjdrD/3nWYE38g=
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Microsoft-Antispam-PRVS: <CY1PR21MB000804CDBD9D1DA15C14331CB7950@CY1PR21MB0008.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123558100)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY1PR21MB0008;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY1PR21MB0008;
X-Forefront-PRVS: 04244E0DC5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(2361001)(110136004)(107886003)(5003940100001)(189998001)(39060400002)(42186005)(4326008)(10090500001)(86362001)(86612001)(2906002)(8656003)(6116002)(3846002)(6666003)(6486002)(6916009)(1076002)(53936002)(478600001)(6306002)(66066001)(47776003)(68736007)(81166006)(106356001)(8936002)(48376002)(105586002)(7736002)(5660300001)(25786009)(8676002)(81156014)(2351001)(305945005)(50466002)(97736004)(36756003)(22452003)(966005)(33646002)(10290500003)(101416001)(50986999)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR21MB0008;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR21MB0008;23:nq3FCuo9pPYIb6qP8fsbxssKBfQeN44LskhiCZNMY?=
 =?us-ascii?Q?rqOSD7v0+UQ4+vpFWKKAOX3ZZB+b8fpsYPr8slbNusoT7cLnIlmQAt9iMXmG?=
 =?us-ascii?Q?CLKyZA3ORd05lJ8RZMmlu6FPmNi1Z8iD9KURDP+QqFbbRMbsqNoaFoKG0uob?=
 =?us-ascii?Q?iksXlFMOGTuckkgn1JG/6QNnDrsCEi+iC23BclAqCtyts5iOIIw/O+5GGv9E?=
 =?us-ascii?Q?fxfWXqTNXQW8OW+D9GtygJKQ15l8/WrdeDzV/slIFGTpz7eBFsHEdDVH80ES?=
 =?us-ascii?Q?lfK9fLPVk2atibU1TeLUoli/ho0Y0ep9fMpFakld5S1HCElGmb1Nq2C1G199?=
 =?us-ascii?Q?bMbZuctgv29YbSZCo28iVNXa1Tg6TOpr7oRrZX1H2slVyakV5+G5MlcsQnJm?=
 =?us-ascii?Q?BnysvhV2BKJ4y0rqCTw4DmbbHxPgroIWveLtTEKf6EEsR3Lhsppj50BFRjMX?=
 =?us-ascii?Q?YgOn75SSnDuOHX79rEyKNJxO/1kqTATvJkK/1IBZvwHSzS+Y+E302XXrMhbl?=
 =?us-ascii?Q?GpOHIz2MkIxVgpRIIuT74KHKFy6wpZESpvZW5wX0krmH6gbcrwIYfRPhzmB4?=
 =?us-ascii?Q?yRfJyqLcFj8vcUE9IcV2ymqNWZ2NVDHJpEMKLdc1/jXBTaZUpgnLwhTuqTOi?=
 =?us-ascii?Q?alFMwPepDI1QAz2xJrzaoDbkTYsLpnSNyyWL6Sy2ARZdEBQ6OdSWvABBfjzV?=
 =?us-ascii?Q?VoKXWEaQ56jpmQabwdWGTcSKYgui0gaDSnLMrFc7AVe0G1S0y95ddOSGCpZI?=
 =?us-ascii?Q?bpTGKzfvS/yM1Np2d8WvOkgLDRcR7jt0D1Rnr3KfQLn0fFa3DCw8mGXRAz9w?=
 =?us-ascii?Q?nvyGfAX0O1GP+NtYD2V6jdJlWzwDI+YNOEn5oVH7rRQ32/Imm2FFn12LvtMv?=
 =?us-ascii?Q?2h3CAdmlp6XIrwr8zN8DZ80cMuBhNpudC6RideQy36f2ers/Am7XFMgVkEDp?=
 =?us-ascii?Q?chVXlITrpvOfXRSxLURd3UobuVRmjTmX3qroMUiAGs1wEmecc002/9JzIRBN?=
 =?us-ascii?Q?UBZA8yL+bXsOin49oHgdd4WrtdDNGqoPvmw3AuqAKrdwKuIo0XqBBqeAsbSy?=
 =?us-ascii?Q?criAwOWmPTFkImPy8eroQZXlnOdEBpqAX7t4gdHwi/y2wT+Pj0olGykx4vUg?=
 =?us-ascii?Q?WqF+RobMBnFkrawVXvPh+j/WTtqcTaeAoB8GgUTFcasSfLtITX+Nf543BcPl?=
 =?us-ascii?Q?ciTvvUCbHQWcMjbBKOnulKt5j8ECAuyCTHMoBJp6czQ2RSuVz7TL5eMWcX4N?=
 =?us-ascii?Q?sMfQ+RFbfwEcROJUew=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0008;6:q/kpJafF7GYDyeGBimmQ2WYnD3JyIRYHD9Ddg0lArkSEfD1MiQKOTTOGWERBKilENfZZ8e2kRycEPYGtQ3F4DRQIItek5YPSKmHr25lLK3ctP17qZoE4qJFA8RKz42OD76xwk3HgVnc9N80lSvN8m0K5rI21TeFntSGbf0ng/NmDq1yGlhycpax0OdvZYo4wWWMxPgRl8sxQk7q2lcrw9gKundd01sSGh2VwZSmY79EKKjJNcdKzFBegCx2SlF1wE7JqZpYtXNWbT10anik64Eeen9eZK8xc9AYN4tVsxg5cNmr3t9p+a4mIz/JoFRzOV6Gb6YyplCATy6To0FjDXw==;5:OU6faXbpofj2FqTkX6fKWRkcd/C4r9ELTTSJrPFhdLwelr/ZK3Bj/1Gv6oUk/ZOCEBIbfFA9l71Rv0+TnvJvRX+x47bSuQSQgzLtWMds6nL86zPE+t7vRCg+VFCbG8+z17ki1bCs3SLiyTYr0cGZcQ==;24:76QLPkTjwCExT0Sb9fweCoHvfrK8tWPGywp/SJGAuMjIiMPkpZxQhBhzrXFDP9gvHSYoAt8ST2tPxnGmXcoatEfyPp00MQaCyjARea7dTNY=;7:HR9fToIMu+h5L19u7j+qlz76gD0GfmZFPffo4LhKIVQml4J3AMbuX62R3izZsnFrKdOMFX2fE+2zI7yOZuiCwxC/ouQHK7DZ3gshWN1xLfLEYUfaP1F6O0KykabL/ygJYXcmhZK5cjjjYyjma8n4NrrUmyjEDJiNSuvWTYoXi4ygjI13vZSlbaBiKEYzFnj6ImKNUOa+4+xhyhUrJ3bWZ9SZ+PAhXfqttf+L4Ol7Xvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2017 18:01:32.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR21MB0008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original discussion is here
https://public-inbox.org/git/20170407192357.948-4-kewillf@microsoft.com/

When running a reset mixed and using the sparse-checkout the working
directory needs to be updated so that there is not data loss when the
index is updated.  This is because the index is getting updated
potentially removing entries without changing the working directory.
When using the sparse-checkout feature the entries removed might not
be on disk and are lost.

This patch writes the before version of the file to disk if the mixed
reset is going to change the index of a file that had the skip-wortree
bit so that the file contents before the reset is preserved on disk and
status will reports the correct results.

Kevin Willford (1):
  reset: fix reset when using the sparse-checkout feature.

 builtin/reset.c                  | 25 +++++++++++++++++
 t/t7114-reset-sparse-checkout.sh | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100755 t/t7114-reset-sparse-checkout.sh

-- 
2.14.1.474.g0558484247.dirty

