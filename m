Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45311202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbdIVQgm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:42 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:2304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752506AbdIVQga (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kAFZnGkSazav5NdgfxprH75InwY6PGvcuEuly/pG9ps=;
 b=CtNeOtpaILAXfQWTy3GQaYUI+5ZMAGiJfU1pbY0MN0idURWNGD8bnGUE02PD9c3KhbK2SF76RiDleEZjwgGox7y9bBvAbN24WwPXGMbbNBdoMokGMP+0P+7g34HvP/3RF+u/xbO0MXBBz0UbXlIhlRyy3ljsTjdj+Ngbed945ZE=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:15 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 10/12] fsmonitor: add test cases for fsmonitor extension
Date:   Fri, 22 Sep 2017 12:35:46 -0400
Message-Id: <20170922163548.11288-11-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b943b922-69be-4e2a-f257-08d501d80b9c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:hz3yC/TOaDOY4T7E/42lyzZqpaluA+uZTPP4ndI9gIh8Hd/rLS8x3GISm2dBbD+IO0/Fi0AEt+rHLU/xzydVrXynyKbC/tmRZ4+ig2whZlEEoJCJbDFDjexH4MsYtcShxGkGRXvRjWm/au9T3AWGdeIQCQuU4OTUrs2641WC3OjWiOeAzS4Jz0AvW3ou5VS9/zw3e85+9FXNn1i+PDvfW7QBDuM8YeiGdslGOFy6Y3BYRLnMm2nnkSQiNNM6fY3R;25:Jj2Ld6GwnDtNDVsJh+no121edtnTsHXZJEo4Z5QR7h+pzaN6dHpkvwo8yUKddzXTScdZGlQbyk0rtXJ4OQBcOm32w9PZdDPGQj0rfW9RndwOk1OQYIL32CeUcehpQxomLr9ufEsJJjO5+dnmakugR68ZRQ9q9szKJ5OeqHjnkr4T9HAtwPL7JahKSChJbkqeMA46xZqLXYQ4jptOyfOMGxb6b4lPSnrMiT+VLiIGYdWQbVy1lel4GNZbhKCnZpa/pvpRTpBWWG98fHTM9AlZhlBmheQKIFXyxtHgp8mkeNA/dDrvx3v2yWRSnlDYgrb5eHleMc0tF22mgZlateZZhw==;31:P0FEnBnrjXhADRnBbLnoVueY/7t1cEvEhD3Z+tILVkyAEFWfOkKj0PrsoZRd4Yo3CLwVH7nuqXd2JjBmpykYQQu3HpNu6P2rWoeaAwIz/DspFvfV3KpC4FQ2QBVbPWYWcQbIuF0t44u4i6UA45LP96Tt5vK7uGGra5OT0/NaRz50kRcl2JkgQETxxf45MbXNqs+LXWOMdzwbj8OyqZB7xj18YVc9l1+9yrGIw9kIpQM=
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:wfXKFGUZnLQAJtT5psr1wBAcLadNc0bcfgyks6/0D1AzFv43NLeQTPMf4EO6jcdb5BoUXstB5n/Vgqoq9kwCqCG8WCw2GQT6H4+hGqaCpk8/7VJIHlqq/kdeZeGOVtMS7qCKst72m1fQtZ25v1zVjpTxtVxVvvup42Uf80MiXKBxcP3bzYM5QeOccjDiDtHK2DFAaJ6NflEWs/O1fsS/UOoyZRPAR5TYZXX2DKIJpiMfPQRfv4h3OwjRLtG5EJpzoz8NU/pfMmmxMhFNEYm7iNv0bnLMWYbPc6hiWbuavuuUGaoVsOlB2l/eiptDswB3RbaT/AhK/NTLC6p/7yGwKww/cHqWYZR6P3u2b3r9W9n6Yu8zuA0PsVXv94hGYMBxBf5vYnlM8yqNzBm6pkXqC3qDm3kKOu/GDzTf8OnTDu1m4M7V3Cwb6ocCn7ZJzv/sKOTgyYn6m0qoe8pG7pdppspD/JjHI/hMTb3H4fzwA1Vu5OIMMtpdmlmN1Yy6vh06;4:+31uwCIc3LYP5mo/BQgsve1KDoKh0cnFsCnRt/KyLCPKo2BQRmiMeq5FgKUXm8d4dTtvlCOUhzCV0NfmTssD4ZQAxJkeNvxab7QPKaCRnUoxP+8g0af7bf+cZc26sfYmbvzNThLPaJuSk8G0m+Kj6SmSzQedSVjEI+4ImeCMPhGxYJQPAwj0yg3oklUBGzbI1aZwOTAAL/Loi6QaXk57fOOWp+wtcixoz+WyF+uC6bsMzz0FqZSrLoAocd81eMfxg0/TN+A8CwpQBjIMdHAyXudSwF2Cw6XJ/7hOrKR9zozlIGCPy++hhBnZixfNkc2aB6oGggrKxdfa4+iUK4wN3A==
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB0466B2301F2E4E5161C9DC44F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(6306002)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:RizKBXgvaT25nyRDFmOn/TrKJToQ5kSAnLKkoaEfh?=
 =?us-ascii?Q?ewtIhTYCpgtzWPWTw4W4WDNsSoLF/7iSAWd7au3vVAzKRxBQHuao9yKUKUeo?=
 =?us-ascii?Q?Vgn7/mPENuOckSRcb/8SBLZNXNN5Z453swK9K3Ud4eV41G+WAS27ZKzUc7fJ?=
 =?us-ascii?Q?pq51ZdjfnEE2dDL532a/QfHhQS5HfifvGE8280y6Xw/toS7qIr4m1nBjf1+y?=
 =?us-ascii?Q?0z1G+bh9Ki/kgtE6fZwNNWeg83EPy4Fme+ZTl+KbIDEyt2IEnZbNLWgYAykY?=
 =?us-ascii?Q?C1pcKJCLKBNR6TTDbl/Ielx4UQxfhpQzvGeKurMNBsiY1Q6oGLLRerjTzxVy?=
 =?us-ascii?Q?naQGek2jWTZ/PR7hoKFosKFf5NwyOW4Kb+t6K4mTF+djdwaV6jW2M4jFg0SD?=
 =?us-ascii?Q?zjvay14LluUmdSdrSqBYWcixsmhpGaioIh0HYLwuKYQ0KPVD3I3mc7zRVwen?=
 =?us-ascii?Q?GB8x0+rzsCH6JuY2h82q8n1Jx+WuLthJQCSAHYfHImnl0syY2To+mKVNjtXw?=
 =?us-ascii?Q?dbwt/AY8cwybZuDNcf7l6BRpaHvk1bcJMyUkxnJpL+UOAEpvIGhjLd5ARTSz?=
 =?us-ascii?Q?cHx+HyrDyMtaTgqs3OEVLQO49RHhLOmdKFCh6JU4bSIrU8h5DI2ajQ73vn8/?=
 =?us-ascii?Q?0JSKjb/83qs7kkcKZuLgojjPlA+7JaLZKAqdFQcP95OTHau12j2Z3UT/nJ6W?=
 =?us-ascii?Q?XbJSlpLshT4wMzgvl0E7au4qt1gPFSwYhsKa7lEmO7aTwk7nVLhuFzObxJzI?=
 =?us-ascii?Q?eBL3A7KyP79ahcppwuU2jInlk/Zj3rUwjSc4hnZFOKKG9UvogXdHXAU++Rrx?=
 =?us-ascii?Q?VGKvs8/ZPGYHYr2yNWQIaAmxXf6uYWSK02VvNbPlbAknUCr/vxF7nsUXAo7e?=
 =?us-ascii?Q?0K40tSb0LUQkq+XVLQyojHH0XrECOCH3YjBmj+Tj+Ib0KJyXewcJoeVHdEHq?=
 =?us-ascii?Q?Tlp72vsM1mGKChW6nG1//n3f9/KUk1ylBVzgWASAaZRjgqaMGrZGd9KQW5qh?=
 =?us-ascii?Q?LArf2g9w28a4Q1f1yrBmpw7qU4JkaXXKhrJYx7UvPVJjcQcIQzm/Ug0tmSFL?=
 =?us-ascii?Q?1vLyA8ku2eAz3w5odiX6qco77ucF1tcqo+3oJ/JZiSb86cUpeAZv7SYBZqRX?=
 =?us-ascii?Q?Tv7omw+/KwjX+JdTzu8hJyNWJn7VBhqvdjpj5vS91RGzOSD5ccjDRx4bDJEL?=
 =?us-ascii?Q?2Of6gVAZsXda0R+HDQkdEFz714odNGKXvTUdT9CMBD30a1LurJAPG/2zr93L?=
 =?us-ascii?Q?auQlJXvePiR9kHC10IjbpZnDVDkaUmFvvjPkFNRXi3Dw3KWf3MN6MiSYr+tk?=
 =?us-ascii?Q?vt2kHWa8YYBT8IFcaG9cmwEdxmtHnhYHB7gu5D14OpOG7bucItyzpKKTZXjh?=
 =?us-ascii?Q?1NfZvUZGc+HoTlW6XY/HpmcGrYCbsiMhM9KSJp1E3BtHzKxvULI4/0xDh2kF?=
 =?us-ascii?Q?0uSfq9PCVfDasieTMZX/9S44bmL9wAunlrGy45obUY7OpMgaOzO?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:jL4Q0kvNoVspXWNtLBEiU4dn1qIMg0cxhalm1TnRUODMTq+g3s9JHzVbJbqJeNfu3oJd3fbPI+SAgDqBgm9su8mJ96wlb8BGkezSNjOJXgW6Fs23tgdL41iiw/J/jYwcbAPV5zXgt+KR2dQSyqCesc6fPGpWr+tJoB7PJKbVf/EJ2reL6rhQSwJIuOgWyf9IGT4KrfMstpCxsTcVSgfOgrrErnl1UM/bKmsDBm1p4Aj+mfkVzUJE4jRbYMcr24ANoFFHW3x/iKHRgoXklKeIjdeBfMVp2Kd6rQlMWFQmhPR5XPj4zRJnngszv0At8DBxGVb0sDG+tVR+j3DG+U8sYg==;5:AEYlUQiksSczUj18RqDyMF7J2nqUT064YAnGIB5L/I5icl1KiHFhuIonPeen7VNZEOawrhITIVydK8iMEFCqZ2ovHGYxoICXDj8Suc6ey3lwkuqV8iYHsCgBw8Y07LuNQCaDytUQejh7x4KiMsYKnQ==;24:mz9tUZsIxsWnLu6W2pIBaI5arUctEJ1SoaJmnG4bb2Umk5evlpiT+iMCvyrtCQ56j766AFPiqq8X7BXCCx9kpdzB2qCyH1XUBz2aH9+/1tc=;7:6hyM0mvQIQVGUtxjeE++yBPwP3yawPp/wMarurIdqndEekNeOVyJA1anZNKnGRoNcVfx3jJxSlK1lh8Nw4eoTA8yt00rbNEzaMd/xYUlGXKjurTyaKEyIkYPb/dGmGHzgRyTcVGCzOkD/VdmisCtaV7r65zL+tO1Rd1Ahz3SPe4yuDfnSzrkYCZE4FMz5gmPiWegFSmPBwPjzelwGzZKDXW8ur2cYLHLp20QT/2FPmE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:15.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the ability to add/remove the fsmonitor index extension via
update-index.

Test that dirty files returned from the integration script are properly
represented in the index extension and verify that ls-files correctly
reports their state.

Test that ensure status results are correct when using the new fsmonitor
extension.  Test untracked, modified, and new files by ensuring the
results are identical to when not using the extension.

Test that if the fsmonitor extension doesn't tell git about a change, it
doesn't discover it on its own.  This ensures git is honoring the
extension and that we get the performance benefits desired.

Three test integration scripts are provided:

fsmonitor-all - marks all files as dirty
fsmonitor-none - marks no files as dirty
fsmonitor-watchman - integrates with Watchman with debug logging

To run tests in the test suite while utilizing fsmonitor:

First copy t/t7519/fsmonitor-all to a location in your path and then set
GIT_FORCE_PRELOAD_TEST=true and GIT_FSMONITOR_TEST=fsmonitor-all and run
your tests.

Note: currently when using the test script fsmonitor-watchman on
Windows, many tests fail due to a reported but not yet fixed bug in
Watchman where it holds on to handles for directories and files which
prevents the test directory from being cleaned up properly.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 304 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7519/fsmonitor-all       |  24 ++++
 t/t7519/fsmonitor-none      |  22 ++++
 t/t7519/fsmonitor-watchman  | 140 ++++++++++++++++++++
 4 files changed, 490 insertions(+)
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 t/t7519/fsmonitor-all
 create mode 100755 t/t7519/fsmonitor-none
 create mode 100755 t/t7519/fsmonitor-watchman

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
new file mode 100755
index 0000000000..c6df85af5e
--- /dev/null
+++ b/t/t7519-status-fsmonitor.sh
@@ -0,0 +1,304 @@
+#!/bin/sh
+
+test_description='git status with file system watcher'
+
+. ./test-lib.sh
+
+#
+# To run the entire git test suite using fsmonitor:
+#
+# copy t/t7519/fsmonitor-all to a location in your path and then set
+# GIT_FSMONITOR_TEST=fsmonitor-all and run your tests.
+#
+
+# Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
+# "git update-index --fsmonitor" can be used to get the extension written
+# before testing the results.
+
+clean_repo () {
+	git reset --hard HEAD &&
+	git clean -fd
+}
+
+dirty_repo () {
+	: >untracked &&
+	: >dir1/untracked &&
+	: >dir2/untracked &&
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	echo 4 >new &&
+	echo 5 >dir1/new &&
+	echo 6 >dir2/new
+}
+
+write_integration_script () {
+	write_script .git/hooks/fsmonitor-test<<-\EOF
+	if test "$#" -ne 2
+	then
+		echo "$0: exactly 2 arguments expected"
+		exit 2
+	fi
+	if test "$1" != 1
+	then
+		echo "Unsupported core.fsmonitor hook version." >&2
+		exit 1
+	fi
+	printf "untracked\0"
+	printf "dir1/untracked\0"
+	printf "dir2/untracked\0"
+	printf "modified\0"
+	printf "dir1/modified\0"
+	printf "dir2/modified\0"
+	printf "new\0"
+	printf "dir1/new\0"
+	printf "dir2/new\0"
+	EOF
+}
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks &&
+	: >tracked &&
+	: >modified &&
+	mkdir dir1 &&
+	: >dir1/tracked &&
+	: >dir1/modified &&
+	mkdir dir2 &&
+	: >dir2/tracked &&
+	: >dir2/modified &&
+	git -c core.fsmonitor= add . &&
+	git -c core.fsmonitor= commit -m initial &&
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	cat >.gitignore <<-\EOF
+	.gitignore
+	expect*
+	actual*
+	marker*
+	EOF
+'
+
+# test that the fsmonitor extension is off by default
+test_expect_success 'fsmonitor extension is off by default' '
+	test-dump-fsmonitor >actual &&
+	grep "^no fsmonitor" actual
+'
+
+# test that "update-index --fsmonitor" adds the fsmonitor extension
+test_expect_success 'update-index --fsmonitor" adds the fsmonitor extension' '
+	git update-index --fsmonitor &&
+	test-dump-fsmonitor >actual &&
+	grep "^fsmonitor last update" actual
+'
+
+# test that "update-index --no-fsmonitor" removes the fsmonitor extension
+test_expect_success 'update-index --no-fsmonitor" removes the fsmonitor extension' '
+	git update-index --no-fsmonitor &&
+	test-dump-fsmonitor >actual &&
+	grep "^no fsmonitor" actual
+'
+
+cat >expect <<EOF &&
+h dir1/modified
+H dir1/tracked
+h dir2/modified
+H dir2/tracked
+h modified
+H tracked
+EOF
+
+# test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
+test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
+	git update-index --fsmonitor &&
+	git update-index --fsmonitor-valid dir1/modified &&
+	git update-index --fsmonitor-valid dir2/modified &&
+	git update-index --fsmonitor-valid modified &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+H dir1/tracked
+H dir2/modified
+H dir2/tracked
+H modified
+H tracked
+EOF
+
+# test that "update-index --no-fsmonitor-valid" clears the fsmonitor valid bit
+test_expect_success 'update-index --no-fsmonitor-valid" clears the fsmonitor valid bit' '
+	git update-index --no-fsmonitor-valid dir1/modified &&
+	git update-index --no-fsmonitor-valid dir2/modified &&
+	git update-index --no-fsmonitor-valid modified &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+H dir1/tracked
+H dir2/modified
+H dir2/tracked
+H modified
+H tracked
+EOF
+
+# test that all files returned by the script get flagged as invalid
+test_expect_success 'all files returned by integration script get flagged as invalid' '
+	write_integration_script &&
+	dirty_repo &&
+	git update-index --fsmonitor &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+h dir1/new
+H dir1/tracked
+H dir2/modified
+h dir2/new
+H dir2/tracked
+H modified
+h new
+H tracked
+EOF
+
+# test that newly added files are marked valid
+test_expect_success 'newly added files are marked valid' '
+	git add new &&
+	git add dir1/new &&
+	git add dir2/new &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+h dir1/new
+h dir1/tracked
+H dir2/modified
+h dir2/new
+h dir2/tracked
+H modified
+h new
+h tracked
+EOF
+
+# test that all unmodified files get marked valid
+test_expect_success 'all unmodified files get marked valid' '
+	# modified files result in update-index returning 1
+	test_must_fail git update-index --refresh --force-write-index &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+h dir1/tracked
+h dir2/modified
+h dir2/tracked
+h modified
+h tracked
+EOF
+
+# test that *only* files returned by the integration script get flagged as invalid
+test_expect_success '*only* files returned by the integration script get flagged as invalid' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	printf "dir1/modified\0"
+	EOF
+	clean_repo &&
+	git update-index --refresh --force-write-index &&
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	test_must_fail git update-index --refresh --force-write-index &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+# Ensure commands that call refresh_index() to move the index back in time
+# properly invalidate the fsmonitor cache
+test_expect_success 'refresh_index() invalidates fsmonitor cache' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
+	clean_repo &&
+	dirty_repo &&
+	git add . &&
+	git commit -m "to reset" &&
+	git reset HEAD~1 &&
+	git status >actual &&
+	git -c core.fsmonitor= status >expect &&
+	test_i18ncmp expect actual
+'
+
+# test fsmonitor with and without preloadIndex
+preload_values="false true"
+for preload_val in $preload_values
+do
+	test_expect_success "setup preloadIndex to $preload_val" '
+		git config core.preloadIndex $preload_val &&
+		if test $preload_val = true
+		then
+			GIT_FORCE_PRELOAD_TEST=$preload_val; export GIT_FORCE_PRELOAD_TEST
+		else
+			unset GIT_FORCE_PRELOAD_TEST
+		fi
+	'
+
+	# test fsmonitor with and without the untracked cache (if available)
+	uc_values="false"
+	test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+	for uc_val in $uc_values
+	do
+		test_expect_success "setup untracked cache to $uc_val" '
+			git config core.untrackedcache $uc_val
+		'
+
+		# Status is well tested elsewhere so we'll just ensure that the results are
+		# the same when using core.fsmonitor.
+		test_expect_success 'compare status with and without fsmonitor' '
+			write_integration_script &&
+			clean_repo &&
+			dirty_repo &&
+			git add new &&
+			git add dir1/new &&
+			git add dir2/new &&
+			git status >actual &&
+			git -c core.fsmonitor= status >expect &&
+			test_i18ncmp expect actual
+		'
+
+		# Make sure it's actually skipping the check for modified and untracked
+		# (if enabled) files unless it is told about them.
+		test_expect_success "status doesn't detect unreported modifications" '
+			write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			:>marker
+			EOF
+			clean_repo &&
+			git status &&
+			test_path_is_file marker &&
+			dirty_repo &&
+			rm -f marker &&
+			git status >actual &&
+			test_path_is_file marker &&
+			test_i18ngrep ! "Changes not staged for commit:" actual &&
+			if test $uc_val = true
+			then
+				test_i18ngrep ! "Untracked files:" actual
+			fi &&
+			if test $uc_val = false
+			then
+				test_i18ngrep "Untracked files:" actual
+			fi &&
+			rm -f marker
+		'
+	done
+done
+
+test_done
diff --git a/t/t7519/fsmonitor-all b/t/t7519/fsmonitor-all
new file mode 100755
index 0000000000..691bc94dc2
--- /dev/null
+++ b/t/t7519/fsmonitor-all
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# An test hook script to integrate with git to test fsmonitor.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+#echo "$0 $*" >&2
+
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
+	exit 2
+fi
+
+if test "$1" != 1
+then
+	echo "Unsupported core.fsmonitor hook version." >&2
+	exit 1
+fi
+
+echo "/"
diff --git a/t/t7519/fsmonitor-none b/t/t7519/fsmonitor-none
new file mode 100755
index 0000000000..ed9cf5a6a9
--- /dev/null
+++ b/t/t7519/fsmonitor-none
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# An test hook script to integrate with git to test fsmonitor.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+#echo "$0 $*" >&2
+
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
+	exit 2
+fi
+
+if test "$1" != 1
+then
+	echo "Unsupported core.fsmonitor hook version." >&2
+	exit 1
+fi
diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
new file mode 100755
index 0000000000..7ceb32dc18
--- /dev/null
+++ b/t/t7519/fsmonitor-watchman
@@ -0,0 +1,140 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use IPC::Open2;
+
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to speed up detecting
+# new and modified files.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-watchman" and set
+# 'git config core.fsmonitor .git/hooks/query-watchman'
+#
+my ($version, $time) = @ARGV;
+#print STDERR "$0 $version $time\n";
+
+# Check the hook interface version
+
+if ($version == 1) {
+	# convert nanoseconds to seconds
+	$time = int $time / 1000000000;
+} else {
+	die "Unsupported query-fsmonitor hook version '$version'.\n" .
+	    "Falling back to scanning...\n";
+}
+
+# Convert unix style paths to escaped Windows style paths when running
+# in Windows command prompt
+
+my $system = `uname -s`;
+$system =~ s/[\r\n]+//g;
+my $git_work_tree;
+
+if ($system =~ m/^MSYS_NT/) {
+	$git_work_tree = `cygpath -aw "\$PWD"`;
+	$git_work_tree =~ s/[\r\n]+//g;
+	$git_work_tree =~ s,\\,/,g;
+} else {
+	$git_work_tree = $ENV{'PWD'};
+}
+
+my $retry = 1;
+
+launch_watchman();
+
+sub launch_watchman {
+
+	# Set input record separator
+	local $/ = 0666;
+
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	    or die "open2() failed: $!\n" .
+	    "Falling back to scanning...\n";
+
+	# In the query expression below we're asking for names of files that
+	# changed since $time but were not transient (ie created after
+	# $time but no longer exist).
+	#
+	# To accomplish this, we're using the "since" generator to use the
+	# recency index to select candidate nodes and "fields" to limit the
+	# output to file names only. Then we're using the "expression" term to
+	# further constrain the results.
+	#
+	# The category of transient files that we want to ignore will have a
+	# creation clock (cclock) newer than $time_t value and will also not
+	# currently exist.
+
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"since": $time,
+			"fields": ["name"],
+			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+		}]
+	END
+	
+	open (my $fh, ">", ".git/watchman-query.json");
+	print $fh $query;
+	close $fh;
+
+	print CHLD_IN $query;
+	my $response = <CHLD_OUT>;
+
+	open ($fh, ">", ".git/watchman-response.json");
+	print $fh $response;
+	close $fh;
+
+	die "Watchman: command returned no output.\n" .
+	    "Falling back to scanning...\n" if $response eq "";
+	die "Watchman: command returned invalid output: $response\n" .
+	    "Falling back to scanning...\n" unless $response =~ /^\{/;
+
+	my $json_pkg;
+	eval {
+		require JSON::XS;
+		$json_pkg = "JSON::XS";
+		1;
+	} or do {
+		require JSON::PP;
+		$json_pkg = "JSON::PP";
+	};
+
+	my $o = $json_pkg->new->utf8->decode($response);
+
+	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
+		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
+		$retry--;
+		qx/watchman watch "$git_work_tree"/;
+		die "Failed to make watchman watch '$git_work_tree'.\n" .
+		    "Falling back to scanning...\n" if $? != 0;
+
+		# Watchman will always return all files on the first query so
+		# return the fast "everything is dirty" flag to git and do the
+		# Watchman query just to get it over with now so we won't pay
+		# the cost in git to look up each individual file.
+
+		open ($fh, ">", ".git/watchman-output.out");
+		print "/\0";
+		close $fh;
+
+		print "/\0";
+		eval { launch_watchman() };
+		exit 0;
+	}
+
+	die "Watchman: $o->{error}.\n" .
+	    "Falling back to scanning...\n" if $o->{error};
+
+	open ($fh, ">", ".git/watchman-output.out");
+	print $fh @{$o->{files}};
+	close $fh;
+
+	binmode STDOUT, ":utf8";
+	local $, = "\0";
+	print @{$o->{files}};
+}
-- 
2.14.1.549.g6ff7ed0467

