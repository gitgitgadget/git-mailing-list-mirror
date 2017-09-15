Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8C920281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdIOTWF (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:22:05 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbdIOTVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jlhUBEPhWjPEjmzHxDG8HDJObLGWIZeTGGu9yLIMbyg=;
 b=Awz1BIGkubbLn9s2vDDK+FdTq/jKptbu+4b1vpkYcHbON+Qy1u2fXG9dlVd0GVeAW7TvoSYBy7wY2DWloi+uf41/ILpKMPegxblBC55MVFHz2fKyyQSSVXgXSObkYJjuGylOkd02RJS7hXum+ZeV+ipC6nbmlsHXSNUNumEOpXA=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:33 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 09/12] split-index: disable the fsmonitor extension when running the split index test
Date:   Fri, 15 Sep 2017 15:20:40 -0400
Message-Id: <20170915192043.4516-10-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09cc9757-25f2-4fc1-0207-08d4fc6efa4c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:G7Bu4jLsofhAIabwtwM3DqWtRMHDaSVZ7A7ShwfO43XAxgc4doEZgOki0ludFpOZfGMz+bre5QcyWxXaEbCIgp7tSY2pMgwj1srAHMq7gmLzWHtlQdpgYDR7OclClft46suOrkxsz+04Wqwz/WcXNqWgOw96Fxxm1XD2kXKTdzyp+dvdYEnvbhogfUWXJzlr+SqbWPCwzC7fEkjyHvyuXAkXdSWpS67swnbYIRZ/Hdt6nCxcdXUfqwMJrcLCiXer;25:xvOFoqKOBgM2tMT0FORaH6t4yI752ArKd5E5F1+ol9KRbDwko3497Ddp3Nin9/ZGG1JVM9721xZBWDCllInzP3C+g41/86ByEyM1+yMt2CEy285r6h6bCsnmCn5jGyvi+9or0ABD1J47rQmwPhVY/5CUsQEILWX4m99m/nCh5PxgmASnpsXDPk4rneZmPAWdXYZZl50nJLL2urDKT7g589rlUnPABRnfrN4xXSV8Wy1qbNmLEzzq/101zHsBoesc4vCsdzAP+qYdQCQvsIo6KeVjIO1Ib+LB8Z/m0Z4bareXaQ23LFr5E2pthvSkGH+p1eIP3lfhbt5jQ2wpwFPY2A==;31:2p/o+ci7DvEzkG7os8Q3fVK6LhObTfGSRI/l9WVjcz9T1gYM36W3fIZqBuabG0SRF+zryid868TJF5gHzAHrNJgY9z7FoXS0g7bf6iaY02xTOQDS472UjvrC0GYT/usX8+S3oHZZxtxDZXs+j+loEjIaBsVxobbZjHtmmAnk/t7uhqtX71ECf0Ssb0ZvQdBZHLUoZlydv6/viiJgMojU/aZz2lfnamwFTqQt2PUL0Hc=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:P3vkH6K28Y5dCaUVq+TxeKYI20SrnKti8K9IblQ+yvCi4VoZTF3dI0Lz/Dd5e0YsF4LtfKM0W5guSS3po+g2E4v7QpyTOJEUumX+V1PWR8yFHbHrNRagPMtcwlukFMSITLJ8SUG7j9nVwDtWDOM6zzSEfwo2CPekEsSYIxkZg1ENTxp651fYd384X/X0ovUfo3xyPPXQ/ZRjWXIKL4s+mgK9chCLIsxQn9DNh9KD4/ib84aOBEA0d/1hmldbIqTcISG3Z3ZBn9I0/i146GXZ31q+qwjiNVjhXrov3p/ErJ9DJBE42IE1tIZ5oNX6fFsM53DuNZ4jp0367cSYM5kkwT1AnTR1e/UJUQ3kAjTEe+NhWMhKrDNOKNIzAFZav7eJAp3p9kr1L0HTkPObiwCuSvfAK7dEsj34oTn3eDHbS8mP4hQs1f+qzTjz9WQt4gUGbA+xrCfxhygzdPBtPYsWB/hCBDh8O2xgIcRVbPVppvITBtlLkvyPiGmClhSntA6x;4:rgbC1MTZd8NXcohub/5pIaOJHpnJ0t0kp6NPkik89eoSFPntoitPMAT9InFbvJVB9BaRouPulx9GJj1vaylUWwm9I3qMQMHktny2BXiWfnnJChYMgKEEJsnd41TBg1+23xgBacUf9YQN2FkdlEOuKMeFYcc2dgW1ZBNdvSI1XVOALzrRtZFfJ1fQQeMH95jQtsgR86MQlS/lZp+PR6ZNqhnMy430VPbks7EVYCoNvjyjkTboqtFR7Cv6IYB9M8YdFBD3abFhYRe7g+2h199KtN6VjmTvV4mSfrldLDkL+6o=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04696BE66F841B3CC7DD6230F46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:SBIwXEI4GthlaT9uGaCB1juIKcq7jt6XQVzEmTiYP?=
 =?us-ascii?Q?jjj1kcVgt+BVODcMi+3182o2rC7BJYqibstAXSlqUmac3gZilLeRLWxm3U4a?=
 =?us-ascii?Q?AvBXt5PxF+sFornbuq/cWbaL114PDrsgEpMLP9+YB/hmr2K1GfF+qnsTIw3o?=
 =?us-ascii?Q?vr5v6/MPv4kXMn7nhFmHVziVl2gL4pDmXk8vyeYqrVyfOUmRtEKrGA0ik4fD?=
 =?us-ascii?Q?nOG+e4mi7fadW3BZ+RQX7r60AuOJaniyjb+M27hvuKiqW2y5BR92jHk09e5l?=
 =?us-ascii?Q?3sWaTAw9y3eqH5NcMutE24z91I6jcIw5qT2/IIaqmAf1I19Xy4/7iOsLfojo?=
 =?us-ascii?Q?nuAbPZUd24DDrsyHy69SrRgae4wYiZsNF/ZrmTM75FZkzZsm2nWUUXO+rG4l?=
 =?us-ascii?Q?4d6jxuhXqJsdcB0PN7IEEeQ5CCutX8RkMmJgbY5t+xuvvlAZ3cj/vBZw7Q2H?=
 =?us-ascii?Q?qyzFxUyQTXtdEbKM206A+IgOwCvO5Um3xLYOZJQ/Sk1MDpmgLSImiY1xqP0a?=
 =?us-ascii?Q?TCfrqlOXauKyNAQKE84LVa6I7TomRYGN905nBtLOi902e3Qnb3Y+l1fr9hZC?=
 =?us-ascii?Q?5QrbMBZTZGLUYsN+WrOLDXipTaZTgiwFPQGC/QBK0xxjwcgjWrRF+7jdoWMI?=
 =?us-ascii?Q?Iyxg/Bk0XWQbzrP5j3dEjcroLLK9dj6jczgmWu62xTMeZfyxAMB8Jqv0+y+d?=
 =?us-ascii?Q?7QJj+0ebrCmdKn82S9Wpge0zQ5FbEZ7evpEMJXo5vSB4SxhTOK/iXdtWc0gT?=
 =?us-ascii?Q?DIAh/8GbGQtJLOGWqvqkUuB2BEA2ul/Vn1kf7Y0b9sC6PqwrBryZVuQDYw6I?=
 =?us-ascii?Q?IRZFpCo6F5yRQ3x1ro6s+BMU097FbmS+CsHijxfulrKiFEAK6YWmdeUxmqGA?=
 =?us-ascii?Q?sxbrp/cfj7fCYCpJdJHtxV2epNkW/tR3ZjFA24pNoxxrk+Z7UH9KNvMN8Nj2?=
 =?us-ascii?Q?OE5eItPNh4Ft7pqjB+qq24y7Yk+2l/VMomWeUtOdo3IoVM/3sG4+rkFWlfvu?=
 =?us-ascii?Q?EVbjBPBJ9yABDFEDLtNM5Gu3lv9p4YJ4tUaEQNPEnzIVsl/l5bU0vTKeis3m?=
 =?us-ascii?Q?UEaqXf6Kb/AJl6TJuqnCqxzBaViTJZwohqIeyviw3CYWCqKyftF31XJLSVe1?=
 =?us-ascii?Q?gd0akHyed1Nhvg62Z+aPwU2d/Lk6vAj8oSpPD6En53NGpv7QbFSm+U5H+GTf?=
 =?us-ascii?Q?zL7tD4lvDE5Q5X9iBYHCeJfYMipUPlUR4HTm4RglZ1JojuTSc+18HuUvTMIO?=
 =?us-ascii?Q?D613ELD2/VBq3BvDJche3Wk2xRW7QfMujIPeqM5kDrtt4iRSb4RN3oVWTiAT?=
 =?us-ascii?Q?knl7GiXWQJEAAmltPelMrOrcz/bxLSYOFSx5WjAWqOiIeY+1slG7stJyBSHG?=
 =?us-ascii?Q?qcvo4GhLkHyF234Zkshc+6q6pPH8TBCGQMxgy02LUoYOBtXIdJ/bSNwQWh6e?=
 =?us-ascii?Q?YgXy+DIetiC8/sC4iUTm0fy3UveabNoTwYWV8WZdO3TJyJX0/X4?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:Vh50ooLDNPb637X3S4jUISlowolKgD75pQ389ZZMDaMV0QozeZ6XdQ8wFXN8m8lJkTYpXMgU/dyTK0sQe+MmlNosK7+8/riEi3tH2kqsfTfPTZQMRHXrPx0U94vp7mbvGPiNlt+Veq7/Hn9vaO8Ov2nkpUwyQSokBS6W3pNOJTgDhUpw4h8mgsS0/pGBZrRrHXMPQJ/KOccHj63Txe859d6ID84vLG/awdy7UW6ZxL/qOg1mWCa0sdRLx14+VWoCghDFXBj+dDv+za0qnlsYymIz51ZsLB3s3S8R5pZO+IiANTjK0tdpNEjM5ZPyufbJrUpbz43MoGZYd8LCYhUf9w==;5:GNP7jcM0pcBEKSmInpMC8+O+DwvYbVET6jdaO4qNxH8QakZspinXKSNLtGsZiS5ZWUjCuS445gjeQ/14cp25ZC6WNobqA6AiSMOo/a2wgeQdJrGpiqXUPmxGt810LBSgXygkPQ7w97E5D1h7BAH/Xw==;24:5gu0P1KcFoJorgPTw/DvGWY1NwpRlRaKHcdmJmc7l25vts+At+iL/jdWVFqRgrRfJZ2Ochb3lfEHJC30Kj2ujkjBUbFaqwWWKZCXx7tqtHA=;7:NpIt2DjJkWcTkGG0pd94By+cPw4XP/+43vKi25DrX8XLtaNwq1B56E+wKhOldV94XntdjJcTjcuwlwwWgt1nGoUsT07+Ynlv2M/4owDzBd2q7YCXqq7kYrMSqWlc35/EbT+CqIJvVyR6h704872f6L4vw4N3Llom7+fccQc2ROLW0ltqJIvEiWYSRSHqe0xiyrZeFsT4mL/mko2OLCk5ZZMh0E2/3dBihGVUWtqlxEE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:33.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
2.14.1.548.ge54b1befee.dirty

