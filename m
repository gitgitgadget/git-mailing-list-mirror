Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FFF20281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdIOTVs (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:48 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751850AbdIOTVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w6L9QGuGJsQRHcFia9jbnII9whJc+TsVzL0MAtx4NBk=;
 b=c3kseObErZ+//dAR+SSQBbrAtJ4Nt9OrbrRoOCic4LsiMROdZVQ1zvVN7dRsMu4tvT1W0EMRnkoosOAEEaMKNuk0dOqtIbXs+wGDHTMPms3BgMHqU0XmQTkavAdDO7WOe0ynrOkdXJ+Stl47mkz1EsIm8Uukeehh+kqtFBzs6OY=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:34 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor extension
Date:   Fri, 15 Sep 2017 15:20:41 -0400
Message-Id: <20170915192043.4516-11-benpeart@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 818f7c75-351b-476c-40e0-08d4fc6efbaf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:NCGtMZ0XMPazJP8/eMR5an8VfBVW5pM4C5wgVmvaUs2TpFKSU+UXtjW0F+/N8N+r7PFg83IqvhvE16dxsYpIdyUY++cmg1BnX0x629oAaC/gNfm7uz9+EF2joXYa6FQoQxtnrxZ72HQ/b1vmMn7maO372iF481w+cPCOHiclVlqE9cQ1j/wzWhhK1hMcj8/GSO6/N0WJHR9M4QtMytgi6SRsIPAJUDOVxc8qp5emQLf6r1RODI4jI4w/VHbh/U2D;25:tvazTFHhr24rNR3MaipjznCW/J/Q/Qz0UxhI2Ud9lGXlUJFFU4OXUy8II3pqRx2pwII+nCLRs/ZwWkY1/S/ZJynMUcrTsA+kxUypDTwxC/9TovMtHETgZJjfsvVZxpvVy50QHFznAYQESvEZJ3yNonbCVc/Irbsy7uZkum81ghWB7SiKnVB+MZ0jQJ1sAgsEHNSI4YtihjLpBAR6gx3O8j6NEWFQtI6WccvoviFjBzW9kfGc7DFiMo1csvLDSDecotplyiGYbIigFVxRKKZoWacehHoQyS5Alzn646XTF4gXHNRo6vtCTBwM5+8/bstEs6I2tt2anaEEWVRmHgSkSA==;31:e7Sw0lhCgHJle0U6Y2zW1ejxEUlvvrg/6GGhKEivZvZ2ULmK4aQdNVrB5Up3kg8i21uB4ROYUf0eJBJFKyOrNhM/2yn/XENQLg3ibWNVY2je8+BTB2U7m+V8gjx3iOZVy5HKirgaRVO9RmpE7GzRknVnt+32HH8cR3qlhhCizFlmHtcq7ovmjzOQUwoIe7Ew3lH7uAT2VwthyQYMbAKEKZD9+TvnSJ4Yp8dCB5YA1YU=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:2u36QxUnpYFz4KibGATncD0RK+IBHK0HJQ0QmkyDFX4AqhSlhfmvakedBtSSgKEIXtDjlXuSs3faBk7ixemgT4h+CkgjZT/mtCqx2OsMtLM23pPOD659XqtXrLZrQkDKWEpK3s2ITn5FZsYtYH1j2cl659Sjk64NDloI7Yoe19zKvF80D4sudm7dL5iFCqF04e1tb83GXHtjss4yDmPRuK8snkY9S5ImGsi60ldJd1qRmd2FW3E3bPGJVgpr2V0syJPbYTep9lZH3lFBoqZfosOq+dHEv04AQBDAJJduugve8IJ7mZcxIJrcuptAnxZ3qcuccpqZzsQqKg8t+t0VA269H+tJrGWSweZhZ1XmQWyOoYn4jfGzpJDHfhrfOJA0zR3BsSYNePEbHOBff+XDRv40V2hpsjmCuL5BJd63OzIutsDXbDutG+QP0/IHIDlXmF5/1NheIWuvwYbOSxbIj6/EJp2B7Emqx1YvULM4EupJPLQEfaptrcoZqohUzrZi;4:SkV4ThSY00MXk87JRQOLL9y6kXp6+NVk9VDMvY4ZU8lX0ys0t1AEnTdNXYtC+Dey3y9q09T9QRM0Gr0a++qwFLUyLjE//qFr+y7juAHUCItJbnBtbG9wd8zN5hmwqJAdFnVPtqM4+9JTRj+8kVqFLOr51K1qMivTI7S6JAPRL5OOHn10yMFS0Dab+dfy+I0Dm+li+fSsy41L8zs+FVNPzz7ZYMXjeilkN2dmIrZAKs0igiKhFxwKiTvMe54j7IlzdBrnxc6+vtPi4M5dPS/Kk4wPYB7wjr8By1CX26i3eUqpRTdqBkKleDcj+nna3yJdXh3Gx2czwRzsA517/TJ+3g==
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04699C577BD84AC12494557AF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6306002)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(575784001)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:NKCrGavfRm/e9Ltwk5zheFfojPkpCRhTWsXIWvUOJ?=
 =?us-ascii?Q?EExdO0CRHuig+lNVzGTfznX7w9lOsinuq+KhoTDezpspB7k2FmvltmuigiRP?=
 =?us-ascii?Q?dqV+Hm3Zw5qiydCo8+JDBF3ogyRa0NfCeBy6NtUb3/pA7qJdAWSi25lmWuyL?=
 =?us-ascii?Q?lU9VGEApYfQONxFL8t9p4coaUxEeh3U3VNu7OJoC6GJD/Sz7IPPbW8jx+2N0?=
 =?us-ascii?Q?/3ObjEl2+UFzL1UQ/qTZMygt/oMv/cKcBkJCxURmay0QWtHx/joWxRnkOkPU?=
 =?us-ascii?Q?aYOJIgKSNW4OeSRfR4JDzjvRIYL2eVoT9h7P8lEYECd9dN0GXG5GKnjfGgxM?=
 =?us-ascii?Q?ZScaAX1F+FMaEstzQWZamt8+y6gBRPTeuaIepHOy9CVfjF3OsGTVOZcsGGuT?=
 =?us-ascii?Q?nh1n3C219WmVVORcZfDzNPqBkJoz3o5pw6RO15lYv6XufGcc+E3Psm/v5m05?=
 =?us-ascii?Q?mNn7uKIYfAVE9jvqHW81mJ1Dyc+Mi1TclFYNd3qt8jmrHyWDmcl85gLlOMi5?=
 =?us-ascii?Q?ohrsRa+WNfQl8gXpvCOB779mb0TDCrNdjaiSbURPDiKBKz2V1eDf0yVYzyr0?=
 =?us-ascii?Q?/FnkBln7h5VCK3zNM1ZVdTa1Su7H040pUpRRah874MN22PyKIVWRClr5ofse?=
 =?us-ascii?Q?diMAmXjmfuJXUv1GGEC87ga8TYyxrNS5r/emBmXZoLlZBYyL7D4NBXnQd8ms?=
 =?us-ascii?Q?sPzcahyD5almGS/VagtwExDvrehTEBIH2qbhL2t/WRCbl3fmKD48KH3QKrFV?=
 =?us-ascii?Q?sy5roS/On6swfUdiWo9oPgYjGOeH057LbiN8+4Qc1t+lT6rEFOIvGQareXCp?=
 =?us-ascii?Q?RECa+MGLnXGNZwqZFivMGH+/Q2dnMLQ0HdIOggCb6JN7/0I9iuEYMMrvV9LX?=
 =?us-ascii?Q?MaxqxJp777m0eX8Jl4c4uQqYQ/sINcHyf+by2u8bSXZJrmCNDsoVmsMqC6Q0?=
 =?us-ascii?Q?sXKqwXJXYs14LcKPMKM4+TtGpr0IhWvAy1u7ca8CE3Z0rxZesrSgjjtdH1ey?=
 =?us-ascii?Q?Q6gpbsvTQA08VDvdoph1ssbjmxsx2YF8HSioznaPdJ7v9ZdTZoGfu8V1SxNV?=
 =?us-ascii?Q?V3cOYE2+BbKMyI3aFHWA00v/238pe3RN1NrXbhO/mCbHDfjBOIvEs0LqSWo2?=
 =?us-ascii?Q?qMvyBwJN0X8oZ6c7lGoRFGA2YH4DSel2qcmcysZsXIlgbyK6mCu2ASBH0vxv?=
 =?us-ascii?Q?og1LDoJOAx6SHJ50gHNuXoa0bucOaNDbe+ONPaPCJdQhXx0nF2ZolXIAINhL?=
 =?us-ascii?Q?RZ7O/Xt+n9utwxMTR/fq+maH05lBuBj6SmtzBmKWQ5IGv5gZiKQJ7IFIuv49?=
 =?us-ascii?Q?6NYjLKUH3UQxpPSeBp7y32dqoTTzVhkBIwPlcHuGC6W35eZbl3Q401dvhgtQ?=
 =?us-ascii?Q?4Fc5cMXesC97XLLFxRiAZszSoTMb4/VFLCf2DusddFLrQ9tMn4nnCuQUqLjw?=
 =?us-ascii?Q?JDsH2ngsBMl0Pkpnf2D0kYAu3UeLaW7TbHsE5IiDclhheMiXz5jNbP+W12Gb?=
 =?us-ascii?Q?uUWZHPHrSJ+KU72+QgH7lFam7qFKkjVttc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:9bYqfscdch5n89OpZw7eqoVUIX+HRFyIyKzWMWXrmsURwV1Ueo3Uz0qduBdq2i2I4PCobr2BKHt8dnpoUzt59IlNRw5S6N/4xcIwZ8GCGgvU4vzdZpWyQJ+KXmr+OWdQ154Wyhr/wMhJ8kDUG4hHU/BZEcL0z3fIuiE6/e0yMdEaVJCJQUTmGl5Bpz2n2A6Db2iF0xtLX1mLq72CT6wdHG9qlBTL5VPtradssKWHqxf2O41QQNnmPGhzWACilv+6uJUlflH3slq76XNlEwkHEz5eO3a8xka850/XcuTSLbfJRoocluun5mb9a9Ij7tIv6f1Cm42qXlKhfVsJuvrjTw==;5:kIpb3T+X2cL3+8qF0DXM1ML2ADcBda0WUm7R1XGJLzmWUQK6sGOjO7xNt1NfcNfBtsetwiEXlRs+HszpqU7pJrO5WZHXGbqyKRXlocEthAhr8sCApTORLqdGJUkhVok2crB0QXxY0EJLIYKxGW9NnQ==;24:CBClQfmgjK0ejP1K6qzxjENtpvbdDve7YH0+O3z65nGK1zWXBbouBFwbnjXu69mBYITfTTXvcsXrI8wE7ZY+fM1tSsE7md+Sq0mP5xp++F0=;7:AnpE5B+3jgA2IGpy04xTw64d6s5LsnLpsc45Veywc02hNsgTze2Hq5ThVNj9vtZbF4c9QvPdAffxkdBq4W4OZ0LXLJnONdFAWrh0LBTc7bK4Zye5DAJDrKc933Fz8g7rTYxUcgqBeHCYIXOiOaKcEIm7GZcJL9kcY1OSGitVT9rqzaYNogQ/cTpgXx3xGbW3pSoSGAlPhkfnibLbjSTv+dDVLxomzAV5C6yggNYe0Rw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:34.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
 t/t7519-status-fsmonitor.sh | 259 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7519/fsmonitor-all       |  23 ++++
 t/t7519/fsmonitor-none      |  21 ++++
 t/t7519/fsmonitor-watchman  | 128 ++++++++++++++++++++++
 4 files changed, 431 insertions(+)
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 t/t7519/fsmonitor-all
 create mode 100755 t/t7519/fsmonitor-none
 create mode 100755 t/t7519/fsmonitor-watchman

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
new file mode 100755
index 0000000000..6aa1e4e924
--- /dev/null
+++ b/t/t7519-status-fsmonitor.sh
@@ -0,0 +1,259 @@
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
+write_integration_script() {
+	write_script .git/hooks/fsmonitor-test<<-\EOF
+	if [ "$#" -ne 2 ]; then
+		echo "$0: exactly 2 arguments expected"
+		exit 2
+	fi
+	if [ "$1" != 1 ]; then
+		echo -e "Unsupported core.fsmonitor hook version.\n" >&2
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
+		if [ $preload_val -eq true ]
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
+			if [ $uc_val -eq true ]; then test_i18ngrep ! "Untracked files:" actual; fi &&
+			if [ $uc_val -eq false ]; then test_i18ngrep "Untracked files:" actual; fi &&
+			rm -f marker
+		'
+	done
+done
+
+test_done
diff --git a/t/t7519/fsmonitor-all b/t/t7519/fsmonitor-all
new file mode 100755
index 0000000000..a3870e431e
--- /dev/null
+++ b/t/t7519/fsmonitor-all
@@ -0,0 +1,23 @@
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
+if [ "$#" -ne 2 ] ; then
+	echo -e "$0: exactly 2 arguments expected\n" >&2
+	exit 2
+fi
+
+if [ "$1" != 1 ]
+then
+	echo -e "Unsupported core.fsmonitor hook version.\n" >&2
+	exit 1
+fi
+
+echo "*"
\ No newline at end of file
diff --git a/t/t7519/fsmonitor-none b/t/t7519/fsmonitor-none
new file mode 100755
index 0000000000..c500bb0f26
--- /dev/null
+++ b/t/t7519/fsmonitor-none
@@ -0,0 +1,21 @@
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
+if [ "$#" -ne 2 ] ; then
+	echo -e "$0: exactly 2 arguments expected\n" >&2
+	exit 2
+fi
+
+if [ "$1" != 1 ]
+then
+	echo -e "Unsupported core.fsmonitor hook version.\n" >&2
+	exit 1
+fi
diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
new file mode 100755
index 0000000000..aaee5d1fe3
--- /dev/null
+++ b/t/t7519/fsmonitor-watchman
@@ -0,0 +1,128 @@
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
+print STDERR "$0 $version $time\n";
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
+my $git_work_tree = $ENV{'PWD'};
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
+	open (my $fh, ">", ".git/watchman-query.json");
+	print $fh "[\"query\", \"$git_work_tree\", { \
+	\"since\": $time, \
+	\"fields\": [\"name\"], \
+	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
+	}]";
+	close $fh;
+
+	print CHLD_IN "[\"query\", \"$git_work_tree\", { \
+	\"since\": $time, \
+	\"fields\": [\"name\"], \
+	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
+	}]";
+
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
+		# return fast "everything is dirty" flag"
+		print "*\0";
+		open ($fh, ">", ".git/watchman-output.out");
+		print "*\0";
+		close $fh;
+
+		# Watchman will always return all files on the first query so
+		# return the fast "everything is dirty" flag to git and do the
+		# Watchman query just to get it over with now so we won't pay
+		# the cost in git to look up each individual file.
+		print "*\0";
+		eval { launch_watchman() };
+		exit 0;
+	}
+
+	die "Watchman: $o->{error}.\n" .
+	    "Falling back to scanning...\n" if $o->{error};
+
+	binmode STDOUT, ":utf8";
+	local $, = "\0";
+	print @{$o->{files}};
+
+	open ($fh, ">", ".git/watchman-output.out");
+	print $fh @{$o->{files}};
+	close $fh;
+}
\ No newline at end of file
-- 
2.14.1.548.ge54b1befee.dirty

