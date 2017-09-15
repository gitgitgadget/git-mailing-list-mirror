Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30A220281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdIOQ6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:58:21 -0400
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:18560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750838AbdIOQ6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 12:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BvGweayYv9WAQA5/Uzc9mgncbW4vzovc+Qf5eEAzl3k=;
 b=EDdXJU18twbCGUsLcS0YN+luyEpWaxzwBh/k82axe3UBdWyqXRiJ7x9fvqRjRP2jMF3tuUqAsEdpEPTLhWRmn+9iRBLKJSV0rf1e6KkudwmjCIubZvdyLfRjV3CzBfjGgnXVynfu+G4vVRttvuyF6Aq5efZhpcDhEuy3pOKYa70=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.77.4; Fri, 15 Sep 2017 16:58:14 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, git@jeffhostetler.com,
        kewillf@microsoft.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/3] sha1_name: Create perf test for find_unique_abbrev()
Date:   Fri, 15 Sep 2017 12:57:48 -0400
Message-Id: <20170915165750.198201-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170915165750.198201-1-dstolee@microsoft.com>
References: <20170915165750.198201-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: SN4PR0501CA0038.namprd05.prod.outlook.com (10.167.112.143)
 To BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14)
X-MS-Office365-Filtering-Correlation-Id: 5236a564-6bcf-4382-5327-08d4fc5af4c8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BY2PR21MB0082;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;3:eQ44s+ycEm2QUv5b2ulypjE81K6gUvtWOfdADigZnnaCfENIC8aycdlvHZV16zHqpxedeWJV3HPT+QicxVpM6Cy+5xw+BSDTXMlY7ti3nuYnY4lDa3pT702EDoh9Ge3dvS2FGN1Itg3RA/3xV3tg6cHHEH6FXtuUq0No1YH5yig0GkPItN0P7IVd+BUXDI09A8/FuFr7yh8eba6Rm3N1KbjcaPfjxjr87KLQbUMdE7V4WMVnBhF6yGdtt6CpVl/G;25:vz1AbmK+hA+zbbBPBAMZo9879aBE8AwXBwD2WtmVEA4vQyM7Uu9hRmwO2i4mveq20WyDF1uF3RdrRT53qXU9FxvZTe6YSq7m161pQTPYyRWMU1DSFj57xUT5fTiUkOJNog24omkkE8Wi3fQboh6zK/LlyWlMN1R68kJlbf0LwQPPAEGS+25CIpBwMO99AYorpMNQ1uasa/qY4VE69djPZH8w88TgbBDqZ9X/wrT3dtIVdmSjZZ979msfuehHPCyjLYuOG0PCaEIEbzxvCUA/BXMNSd3NKfcWfFn8/d/2jsiM0lGfBfVNK5KTRyA8K5oBIiofUTC5vPlE6UoXa6sv3w==;31:OZ4NA6I8//i3TfpTC+QRak68uywVoDbLiqYRHLraokTehGewi/yi0RM5c+gzmVp3afJ9yaxTY5bs+Bk/4oDTHyK4scOAwvGYmGh17pkaN/ynKbUh9sVL/JNSSLkNT8diV7MFYjKIphjKK48dbzSZl+dttMxVguWRCDfNpWMAK5KZz6UMzr5fHpV+O1oSUVqkLiG1GZcEMbdIFOYiFbriECNut15cbuEw26vXYZI2s1w=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY2PR21MB0082:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;20:+jQXAQxkSF+kwyeTJKX06883/CCBX4++OgrG2w3HLAyXqLpw1r2mcQcnS+LmcdWHCkr/8Qo7Ib/ZxGs/NjXI94CcsFC0vpf3/AaeG2z0Im5G1XJV4KJUukhidRMe/OktQunMbzRJ4Sd/ZU/3MViau5ZbEhjGSWhZeO3vwmznzaQlz1a77agd4+3CFAhZtUWrw2ygqVnKZSJhhCc7N6+06Ek50kg2UDBNND8Z2ddVwF4tu4mTBYQQ9qnuEsdMegLZmCpdcHoY/2xC2J7/sF+hWk0Jmse28MT35zaslHC7JOwft3LjEtKCLIBZwpKy1gjJnc3esSWpWfP57a9TmnX8nmKdNRA4wDXfU7mrA6NvKjvMfJbvPEHU35zzhJmQvpU60b5E7tK6n/nW8exCDcokOpNNjJltsEt7in9c7GOXFerVUiuOsGrX1Tku700+2VOPz3Z46b1McN+VNL8JTcITkSQdiN6yK9wjzgmh8iv8f21BCft/xJu3xlK+yJc/G5dA;4:WVx/2TfJAQs0/udYbz4wAxma6WvANp19Ts1Vf2MTqRCQ5LbabSvYxO1rngGDZ4K5vr3+deB0Cztujcw4Vl4AYegX8teHF+TQtNN+tQIl1g+09JpxTxgYSPdx6XjCugjgrPSDMgFqw9QxJ764xAg7B4BlBn40WNAa285hXtfZESxeqTxIQCHuD61st1tCrXdE0PcdEyJc0jnq42SIHPO1tFJVkq9VEdNCvxLE4v6fH2A2atPe6lTFcYOtcmgsscHUfLa+/jCTdYaFLGBfeK7RfKETeh7HdLmgDMwG3uSXhPA=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BY2PR21MB0082D37765E3865ECAC19F8AA16C0@BY2PR21MB0082.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BY2PR21MB0082;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BY2PR21MB0082;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(47760400005)(199003)(189002)(8676002)(5660300001)(81166006)(81156014)(7736002)(50226002)(305945005)(68736007)(47776003)(8936002)(101416001)(189998001)(76176999)(50986999)(86362001)(86612001)(561924002)(48376002)(50466002)(2906002)(36756003)(105586002)(106356001)(2361001)(2351001)(33646002)(1076002)(4326008)(53936002)(25786009)(110136004)(107886003)(5003940100001)(6486002)(10290500003)(6116002)(478600001)(316002)(6666003)(10090500001)(97736004)(2950100002)(16586007)(6916009)(22452003)(8666007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR21MB0082;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR21MB0082;23:rMComiGqfHPrtKdCZWDT8Xk0iopBttdoJiFgI7J/R?=
 =?us-ascii?Q?nfTiS2S/qqKxpdHJPUa3Hy0llVOSn4ERXKLEfNA5JKPDMFUo81gkOteFdTHm?=
 =?us-ascii?Q?UJ08eGl6lmWw9aylbnkbBv9o0ARA0RvrWvD+OtcxyDYkbQ5F+ImWpQB8QmTU?=
 =?us-ascii?Q?TykKrRKfzQSL3nVrslnh4W40qmB6hjvylKoH9BZMMxnEhSjulIN9kre41OPL?=
 =?us-ascii?Q?OH8+UOPPfMsJ1NwBN3IJW2dtk2tDRo7YmMxfolT3S2eZbbN9PIFGB07H6esW?=
 =?us-ascii?Q?+zg7Qkev7oelOEMvQ+oMvP0WPp0O3WRlwKKpgiLT+WLzWf5LFS5Wv9bN5f8G?=
 =?us-ascii?Q?q2KH3N3twSbEUhgom0QXh6TFGAJFRSHU7YcCtMPGt9e/0dVeTQIWQqJvBz3t?=
 =?us-ascii?Q?/jQNzXLSLpZQj86ML6Ev3ExcGKmNuCix9CjN4vlvELotXahAuRnfZ/lekbdT?=
 =?us-ascii?Q?fHN4sJeB3Kb6PsdL9EjK6OI6xNM5RnPMAun1N01Wif++1fUCVq1Q1Wswl4mT?=
 =?us-ascii?Q?cqjW+m/acOj0uf71MeoazIk1s6lXRFcBAtA16iOsuu/fByejquPat01x6JYF?=
 =?us-ascii?Q?reZlTud7oAWSP3ISCqsyWJCfAXaWPHMhPLBxZ8EkjDM57AUsHaKoB2hcA8PF?=
 =?us-ascii?Q?ogD4KJ6VRnc4av3cH9lNDESn2xEw/efkbCWeCDKkxLCq6ec+rd0Lb4pEKlXm?=
 =?us-ascii?Q?FwVN2uRnxZt7R/T0FTWIRgKsHxpwpmvW2iHJbSESAS1hdQPwWifBD8//r3od?=
 =?us-ascii?Q?KZOs9ffIkTGG+J3jjU/lLGJWXn8eXux6qCz5xyTQsXHxHoX+OF7phZksuPsI?=
 =?us-ascii?Q?fm8LVbN6hHRvZca5+KH1tN+O1RhO5CW8S0YsxjVpfI9lpcFjVU7MY/duMC3s?=
 =?us-ascii?Q?v6P3Af1lzfAAKiiLzgaAc73sdmtcIHGiCimBW357qCutQZ/J/oeJEOAFG4jQ?=
 =?us-ascii?Q?cRd0BHrFVUalvLSk7Hhi1p3UIthBI50kysLmSdF/i5bzhInwds2Nb3H9+6m7?=
 =?us-ascii?Q?CAUELJ4/yCI9kw1o2injWFXRi2k6XZXVP2cWetkU1Ma8yumuKYWycBRb/bGG?=
 =?us-ascii?Q?3Zo4HyCQpmtZZDWfkqftOnCsnCfuOyZeE77xfvf1tYyFrzyjEgMCaq2QpATS?=
 =?us-ascii?Q?yPIzbUAgHuFlf5d2znhZzcPZlGzu7g6lSwt2wRfiSzluaXNzQlQN/JC0XZ2y?=
 =?us-ascii?Q?J2C+wmPUAHEle0skGoNUFHTwLRO2Y7jQhZZnHQVr1R8vqR0gjqvWt9nPmDGj?=
 =?us-ascii?Q?mDq+/ncJ9WUY/EGX08=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;6:wfmp5XzD859OYHUWkKT8Yqryddnn3bWUjUEl9x7uWhCTkdxumUbxTFwGvn48lUhF45qo2XLy0T+uFwW+okQaUNGaLSFXsvlvQZ2TucjxmkP8NW/C7U5WCuzisAc7wLTBMn5iWu3xGmC3Jl5wFzvrB/FeABwmUvnu9xrVniWxHVYv9gWDyQtnZxDLvC2e5rj7ZuzLf7MqfzJLK7VoogD/yQQUOk8kcsHpwwAZJAxwGLNAP6FGT8F3Xo15Gz8vlap6AG7d1UozMxKHeCBuU9xl/TG+3nRBaEjUCNPwr0ZBGMWjpGvHQDOMvJgO4cW5cZMbbOysISrDGX/TXG4xSqhFrg==;5:F1AcSsHUwVMcToJZTUx+Yks4k6vmAADWvM6sGUVfqDyyqDAbRuOBm1N9guezGy7eLtnwcTCkk2HHPsf+mn/oTCsdSUz8jJnaldgZEHMeomIUfCoqs1Q75Z477a2TXppfJgz2BiJ73duXNfZJIpLn/A==;24:cwO1QMcQOaHJaiSfAPD6OVSzHHVvRadxzN+7QgOx+2bx2l+KWf7cRZ31Gn/F0LdWh2kFqxpJarOf8Gi7Lx8YSh3ZC0L8AJUyHA/O8Be8H1U=;7:6nTJBjuLmFJ2FuKTLvG0WeSOdDV9pqPzqelph/3XVUylFnE6hn333zKUPA2m+pfqA280YZ9OG+9Hnjg993mEEDD5EzJDS0bJSDA5oAOXp1UxQOkzRNUk7PnQKTMzuEXwCFRlITtx+evTQB+AUjsIyKslLbo+JSIvuur8Q6Mrw1A8Xo22A6C4zA9NbHKpbEbYCPMb0hYFvulYhKqZmK6hUT7RdAhVZ96+fvVQqRttORk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 16:58:14.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR21MB0082
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create helper program test-abbrev to compute the minimum length of a
disambiguating short-sha for 100,000 object ids. The ids are created
by iterating an unsigned int hash_base by a constant hash_delta and
copying hash_base five times across the sha1. Iterating by hash_delta
does not create a duplicate value for over 10,000,000 iterations.

test-abberv demonstrates the performance improvements that will be
shown by later improvements to the find_unique_abberv(). The value of
100,000 is large enough to show the significance of the later
improvements while only taking a few seconds on large repos.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile               |  1 +
 t/helper/.gitignore    |  1 +
 t/helper/test-abbrev.c | 23 +++++++++++++++++++++++
 t/perf/p0008-abbrev.sh | 12 ++++++++++++
 4 files changed, 37 insertions(+)
 create mode 100644 t/helper/test-abbrev.c
 create mode 100755 t/perf/p0008-abbrev.sh

diff --git a/Makefile b/Makefile
index f2bb7f2f6..081ca05e8 100644
--- a/Makefile
+++ b/Makefile
@@ -633,6 +633,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_PROGRAMS_NEED_X += test-abbrev
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 721650256..80ce7d836 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,3 +1,4 @@
+/test-abbrev
 /test-chmtime
 /test-ctype
 /test-config
diff --git a/t/helper/test-abbrev.c b/t/helper/test-abbrev.c
new file mode 100644
index 000000000..cb3551df9
--- /dev/null
+++ b/t/helper/test-abbrev.c
@@ -0,0 +1,23 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+	setup_git_directory();
+
+	unsigned int hash_delt = 0x13579BDF;
+	unsigned int hash_base = 0x01020304;
+	struct object_id oid;
+
+	int i, count = 0;
+	int n = sizeof(struct object_id) / sizeof(int);
+	while (count++ < 100000) {
+		for (i = 0; i < n; i++)
+			((unsigned int*)oid.hash)[i] = hash_base;
+
+		find_unique_abbrev(oid.hash, MINIMUM_ABBREV);
+
+		hash_base += hash_delt;
+	}
+
+	exit(0);
+}
diff --git a/t/perf/p0008-abbrev.sh b/t/perf/p0008-abbrev.sh
new file mode 100755
index 000000000..7c3fad807
--- /dev/null
+++ b/t/perf/p0008-abbrev.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='Test object disambiguation through abbreviations'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_perf 'find_unique_abbrev()' '
+	test-abbrev
+'
+
+test_done
-- 
2.14.1.538.g56ec8fc98.dirty

