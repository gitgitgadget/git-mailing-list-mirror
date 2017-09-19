Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EEE2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdIST2p (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:45 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751462AbdIST2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BNqblqzBm+I5zpkJC+o+2WGflyjH1sgLM6TCcJq3n5c=;
 b=LA0svURObIsAXosliOSUXiSxIxboLe/5vy2wRzBWpBeHkwRF1rSEefMVJHL5cqKzpVHF1Z/+QfHHwOhc3nHfMdxQJnawxvc7CIxFlICvZSWNmuDukI/xQKs3bXZhZLKOswBBlvVR2vGHHWImA8NnaRsTbHH8Gsiy78MjqQHpy1E=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:36 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 08/12] fsmonitor: add a test tool to dump the index extension
Date:   Tue, 19 Sep 2017 15:27:40 -0400
Message-Id: <20170919192744.19224-9-benpeart@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e6b17c9-7e79-4783-cfe8-08d4ff94a033
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:zPN1mUur+QRlaOUV5zF4JZDXTw6W1IbwTniSvFFhasy1ZVWrw2sgvCN6F8KI/Qizv8H8rtN0i507ALSeWCSeQed+uP0B2kTOFNBAfmnNzofsFh0dihVgOouBv8YmAsMErWozMSU0ILlKHYtEsFylLxO50cWSAkQGqhJRAGmaoH52EgTCaNRlI44HSezFVwWcGidz0MaOo+KKd7ntwZgLdMgFKvcg6yBTe/gAwHxqBse81E8cLUhUyZUhni7rftPp;25:Re4SxTSYsUeSHAfaPmzxCvFTheG5itVah+dsnMbYTEOylQVdZi3zxUFgekBFfxOg0mvQTKSZltWFV/5nbBxyQFnREGVpI6B7spGyts5bGgZ6hGY2vXph9Otz4G2F5yRn3dwOwIZXyZRKahSQbaZUgFPFKW4CBrRl3u+9TM7NNpvHT+POrIj/w6AE9Yy9w4XB+M8yKdinJM25HAOFpdWHmyv9cxj64NVQSbKsAePzYbDC4aoHZBgomSM/gxwZcFYNVJwIeMUulcWb2lQ54hjsc8ZZQjeorQlIIQxpbdZFA1LBeaNHAtVT4kKemeJAFoRXjKa2TCeN6JTzCOCh/2rxew==;31:mBZMHS45pAO5rIuR/X2k78UHb0RRhCRB/0AOXcbKTF0VUeZ+TXBImVS9ie4P6Ey7p4wggeAR3W4U92BKdwfLAoOYEKpl5hX0It2OSEfkq7PuSlMQpOyNYogKBki6LSRWzjG990vQERq1XdEqzc2ll044W8bi8iUPKL2YhnvwJ0Ub1ioBo/RCcfAerCssVbeVjpvmSnFHy2A/47VVmFHuRgdyN0CiKwpHWLm6YXYyGNs=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:qeBmsH8m159uhU/q5bZydlqt+vtrXC9+HWuq40CfLJxY5fCiWyruKp96ow0ONuEGoba9KDRUN0cBKJIMhB1s2z/ME4/djnwJUV6/y54BXTGBUUboHKBzaGa7S7SGc16G8QM4vAz+JjwrijABXNVZJCCZZF5BRrUspF0/SBMSN732Dk6wbiX2QCOZCfET7QEl4bnHaZJOu1VD1vFNn85YxxtEAwWQr4G85p5OBJYZxC8rRGZ73fOBYCodW+iyIeUCCC174NPMi6lEYtXGBofF2IFb2z44vEASn84B0twQzIpNAf2txRGgaNQ116JHUqnjtEeF/XE7mwn6DOdclI5YhfZsJyaaN1MzhnVx2qdtIlYpncr11xY7CCbLltwBg9kE1Hm9n8RCVSyvL4DQttjdmcFsCCc39hnHzxnUz66i8pJv11nEnqJdeHUiBmgw6+6Xrmk6GFzbicQlqnhUPIS8p2aTqVz+tDnipMb2Imqu3G7f5JuDjmoGWKaoXgYJI7AI;4:t01XMz3bmyfNT1sWqp/IvLEsci5wb1aXGghbrG9rm1mCkitsxJF0Cdb0O+Z47zce2UxuCWB6bNvnUDZYZchD9yLQDIFxFiHqUs+TzAkStZNzRfc+u4foeE9//Zwx3/qUS83XD4S6mkd2a8BypjjTsd40hjxLEkMbMNfil7XWC5qUfScLDTLExPp/nxqfETeaedZSCVDk90G6tvdmw1BLayK/1Gazc6DwILQ9ppqTQ5ZPDJ7mWq1B0Yvki4qo87ysXb2exkZ3OaCyfgt+zscpnTHX22UHfcoKcQaxiF/JDf4=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471D46C3B72AE4C54CA7FBCF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:ESHAbKUwTuihl9+9jVc3qOWp9noq5jaGkmBDPVnas?=
 =?us-ascii?Q?1N7pVP+ntPCtxHA3cUPA8SvlRH4kYNedOeRpsrU4lkxsQOWj+pML36Z4v+Tl?=
 =?us-ascii?Q?tOc/9QprPDLb/ojQ9s3RINdMEynCR5PQmER8aE+7XRVq9wgD/3ZQSJTNqU4Y?=
 =?us-ascii?Q?4rk2oMH1Mf01AgZjhHHUpnzEO2+mYzuzsJkbu4JCg+PLkOdDKkX0GQI7A96F?=
 =?us-ascii?Q?Oz49gz+Zjxhud6vqY70lkVf5aAKZJl1EDMBh1vU2sotCBwTOEVVCIWvOfgVu?=
 =?us-ascii?Q?jnM3KOEYM6/3HzqbB7wwUQ2aPdszvk8vSNYdIcK2S6N80BQUtyIzTOl+e8kQ?=
 =?us-ascii?Q?uT7nUS/z2n/T6j/c3J7cpAN1n4OPR6q3ocMBXoMfUOGy/pqIVaUi/fTY845R?=
 =?us-ascii?Q?HaKlfels/xCJAvinkXA5cixrCAEwsponi+nQ1vr1RZkUey/Hr0j5+dKPuF+/?=
 =?us-ascii?Q?snQUU95Moq+tvjK4tr+o30EvoopK9R5EubJg0+9QSRxZ9BKvXHtQOj4w/Psu?=
 =?us-ascii?Q?lFgJmCgHNHsLh+Y37m6r8LDQzlueOxcZtXkTxQt0Rp68N0aJNyd4l441qgi8?=
 =?us-ascii?Q?Iqxljgc0hD3Me9ixwTC4L8f+Gqfpts4IYAbj4Cbo4HXc/4UuZ7BkPu0t5jVK?=
 =?us-ascii?Q?pG+MJLtmyiwYxSVN3McnFiZATUQy6ONnKluIQe/Zt0pqIlNHOdZ+yu0jI9oo?=
 =?us-ascii?Q?hW2UWptgU1ScMiz0BrcBtgI11J6v26No+xaHMoK+/F6A5jlCutiEHbXKcOab?=
 =?us-ascii?Q?AlMj4hChyXyO68iXXFOAIA2+utcMfGLVym6pqvlKKUmqIbjurpl/kb/9jE5+?=
 =?us-ascii?Q?u49Y/FGZ5JpjVrnMtLolfdXykAKXvkMCyNEsrlYNYd55SmVKb7LBTzbG/4Ku?=
 =?us-ascii?Q?J8/FQbzeuk+rwJ8e7Xllr+uzQy1nUQepXhy0/t+7cQWbNniU43NmwsTY1TFI?=
 =?us-ascii?Q?OWqQghCQsfIm2yfI4iMAeOou0mNyDTFA5kvfpchrc1wB6iqk7zqcEfmB9qqS?=
 =?us-ascii?Q?XBQQZfDA1+HA2doYU2fUeBZqFbTihuJyho5rmyOH6JZYpmLN/gNa+rgBrUnK?=
 =?us-ascii?Q?2SmrE/yr+67X4H7Ub0/15X7FAG2xTSOLop1BdM10yZrYN5AuLV4OS22S47q3?=
 =?us-ascii?Q?V20ySdfZKxQkkA6BKDreDVKGWnArIxLaxX9cXcoZbwkKfpUSyCv23euU+Hwy?=
 =?us-ascii?Q?faerCh3LHrlv0ZipGitc/Fke8NwqLTn2x3ox2GeDZfUBv2+Fd8E641cAUgyc?=
 =?us-ascii?Q?c4iEUsy9u5n135DvnNE1Kv0nbjUL5/9ePwfcqT++y86utNZpJjFrmmJ4eB21?=
 =?us-ascii?Q?+xZD5IoxXSnaItlHVPOf40csUOnQVNozJdIsTyIz+XBqQXAsixhwqCDoxXgc?=
 =?us-ascii?Q?Vlo9/rXyH8qp190qNHxb/CSp7rZkuVOsQJsFuJrxSUR1Y8SrfNQLw7mDZAKr?=
 =?us-ascii?Q?UHwvJePxRjJIHJEoRsBPknREMEgmAQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:N1NvtD8lgZk4qM/tGeZzYI+/b5FLwiHTQtdthwDwe6nNuGGQF9sHlKplHQJ9HyMUqayWc1EP69VvjZDxiGUvb55BtURd+opV9e8KL2mSUSsqFeqiOnR9O4YXrSbMeYIraR3g6H+GgO/RrSRt2xMoE+wvvXRk/b39sdn4jOJoZhxVKLDAOj6osTjnWp+UH21TjdTOhOGUidDY4VOe6uBYYppZYIyoOORAkPRzuzACEd3vSeJI5jQPHsChv1nSL3XaUya2hAA9lNJg9oMVXsuSZOX8NFmGVWKgA1w8H8Y1lDKDRRfB+5otSNeSginnosfeZvcXDClbq9jvWc6fXnsi9w==;5:lfSkknbZA8cfwat5RiMFWBs3qwCWHeM4qShd3Ncw1+LpE2I35C/tWBvjkFsZe7zoWGevCOA9CPSGmkvTeO/fiSGwGRW/3gO669Xosk/PRGnD9qoEcfFXHUT57uVoAhtkwrVdzBZNaOmnUc/DRgsf9A==;24:QiEnXUdri59uns8KyJ7ts/r35Bpq9kM69D0RjLnWPdWros9zJ8IS+IAPxfQJY5x/przWDR+AOXhfDCUDgqmYHHW/xDC0vOzDUhtx0rNZndw=;7:iYwhsELbOsD8L9u4T+OvQB3QIT56jl15/439GF43Y1Fi+bO3oydSn6lhS4FASyza+Mmww61BBzTyfk/dTeCmdfBWuUCl6fblLWmJkGw8jsM/RzkjW4nMWlUwpGl6uoLNzAYprTsJKg2ldaXsJ8ebIq7EeinWgLXgbP2AIqbyf40fpC/gs/gXH/mN8KLTWpFa7zN8y6jLMCqH0mPcQdqubKPvMHkSwsgPzT2slzaP4jQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:36.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test utility (test-dump-fsmonitor) that will dump the fsmonitor
index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile                       |  1 +
 t/helper/test-dump-fsmonitor.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 t/helper/test-dump-fsmonitor.c

diff --git a/Makefile b/Makefile
index 9d6ec9c1e9..d970cd00e9 100644
--- a/Makefile
+++ b/Makefile
@@ -639,6 +639,7 @@ TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
new file mode 100644
index 0000000000..ad452707e8
--- /dev/null
+++ b/t/helper/test-dump-fsmonitor.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+	struct index_state *istate = &the_index;
+	int i;
+
+	setup_git_directory();
+	if (do_read_index(istate, get_index_file(), 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update) {
+		printf("no fsmonitor\n");
+		return 0;
+	}
+	printf("fsmonitor last update %"PRIuMAX"\n", (uintmax_t)istate->fsmonitor_last_update);
+
+	for (i = 0; i < istate->cache_nr; i++)
+		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
+
+	return 0;
+}
-- 
2.14.1.windows.1

