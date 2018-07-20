Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B479D1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbeGTRWe (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:34 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731000AbeGTRWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyzROlD+mp2gBOmjo8Mq1SvXToSGUnh7aW7JAQy90NM=;
 b=h/Ivm3ZUOxAM7+tHRwl07hkKMQiVu07D9hDEf2BtwTJ0JN/KMw3PuSf44fUmZsQXV+zRXlImb0P7J8McEpw50rVQcjtGqA4AOj6pyirjHHt5YmXFvA9v3JUKyNCcVuRUJjrZ/3OFcsEoK0G9LDqh31Ic7f55bdyqsXgBgGzP6Co=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:15 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:15 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 09/18] test-reach: create new test tool for ref_newer
Thread-Topic: [PATCH v2 09/18] test-reach: create new test tool for ref_newer
Thread-Index: AQHUIEdbE+78aNDOl0mkIEFPMFkbVg==
Date:   Fri, 20 Jul 2018 16:33:15 +0000
Message-ID: <20180720163227.105950-10-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:hdDwMvpAwRORVphieFfEe7L9f68WRYuxHp/8iZJFDqP0Yl4ELUFsLbqWnw/wXQNjirUvS4n8lQ//H67dPffP5MCcCYJgm6eU5PBJi4BYKcfVIN5/0G07BW+td3RVTvx63ReyESCZdCQJWC+YXAJkATGHTAFVdO/KmcdaPax1izYmnFnNeh0g1/oqgtKR3oukeJE5b8con+Zyk/fNDJgUeQBPn19C8qNTzoroIjeV9okUXeHeZF6uuPRLWd0rts2323C42ONRXv4LxtLolBV31au9Ef8slfFrTuUScFjj1ir42UqIwIYgOhBO3fhgUPG3bKfZkjGsHF10BbCleq0Z1Ma/f83HUN9Mvpvpn40cwp++ExUYjzZa8alvFCYdMlY2uTPTTT9vC3VZ6MbZy+Gc+OkRMog94C2+FyM7PfztQr3fVfga7AiZvxL+5JWXyAv8y51X6dALlk+gioMDPfB9Rw==;5:pGiPfIGtAKghYk2ReKAoua8iJc6qAjm2E/6V5ezFiQ7f958W+8gfa82BtIWTRz/jO1Upy7Pa4akxAyq6caVT3F3uek++jLuRqW7Jl4i+eyEkn0M6V6lPdcGdnployLP6NQAK3mSI7nYhDdXgS1KcPXTEsRVDKLWNxtgXr9GrnPQ=;7:7+V+0FIg3nNF4OGeAgyDpGQTtvEQ+B/XcnsYhzFdSEO+qLnmIf3csM7GkZB42qFarUR3aPOaA7deHjFycvsjohV0NKxBNLwkjI2B0xFlLim1Q6rtQFmW7s8lvO1TMlcvaujWd3jSyUkzP4fX72DVGr6MSmzrkfg209Dd8SvUzcKew+BXcOT4DJpB9zaaMVfSnxlVr/CYPzXXWawk/jJ7fppcAFciJ34ZuSvo5GMWZg566GB1DC82safK7EoVgDrO
x-ms-office365-filtering-correlation-id: 0b815e74-32b5-49a6-08a4-08d5ee5e7ddd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929F337D87118D67D501386A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(14444005)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w1p6lMtrCN4B76gn+XEgA+TU4kdPnYZ9JpGaW9fyecEG4Gb1ATmqI9hdYCTDNpwVs9GjmwQp1q3x37PzmVqbQYRZqxVYhSqQoC9qfIa4PJ5+i/IrpVzTvfE4GIunw9srruD9arPuhj7uwMNIokl+RW0gVPDKi23AhG/5YK6vHD9TrDtshYlNgmXg71nPVWLRQbBMUH0l/AFxtv2Ptz0sEPrfg/23zNDSm26QcHJ4iKyOBqo8S3mBDy4l3QJiG67y45fLWPPWOkcPRNMb4GE/Y4t7iElZ22TNGUcBuqfN2TERYjbuYWPzSmFxl+gwzNe/vD1NkOEDl5AARToSdTFBtLVYQ9L8oxPK9TnZnRE3FWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b815e74-32b5-49a6-08a4-08d5ee5e7ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:15.4071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we prepare to change the behavior of the algorithms in
commit-reach.c, create a new test-tool subcommand 'reach' to test these
methods on interesting commit-graph shapes.

To use the new test-tool, use 'test-tool reach <method>' and provide
input to stdin that describes the inputs to the method. Currently, we
only implement the ref_newer method, which requires two commits. Use
lines "A:<committish>" and "B:<committish>" for the two inputs. We will
expand this input later to accommodate methods that take lists of
commits.

The test t6600-test-reach.sh creates a repo whose commits form a
two-dimensional grid. This grid makes it easy for us to determine
reachability because commit-A-B can reach commit-X-Y if and only if A is
at least X and B is at least Y. This helps create interesting test cases
for each result of the methods in commit-reach.c.

We test all methods in three different states of the commit-graph file:
Non-existent (no generation numbers), fully computed, and mixed (some
commits have generation numbers and others do not).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile              |  1 +
 t/helper/test-reach.c | 63 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 t/t6600-test-reach.sh | 86 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 t/helper/test-reach.c
 create mode 100755 t/t6600-test-reach.sh

diff --git a/Makefile b/Makefile
index 59781f4bc3..d69f9d415d 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ TEST_BUILTINS_OBJS +=3D test-mktemp.o
 TEST_BUILTINS_OBJS +=3D test-online-cpus.o
 TEST_BUILTINS_OBJS +=3D test-path-utils.o
 TEST_BUILTINS_OBJS +=3D test-prio-queue.o
+TEST_BUILTINS_OBJS +=3D test-reach.o
 TEST_BUILTINS_OBJS +=3D test-read-cache.o
 TEST_BUILTINS_OBJS +=3D test-ref-store.o
 TEST_BUILTINS_OBJS +=3D test-regex.o
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
new file mode 100644
index 0000000000..620bb46041
--- /dev/null
+++ b/t/helper/test-reach.c
@@ -0,0 +1,63 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "commit.h"
+#include "commit-reach.h"
+#include "config.h"
+#include "parse-options.h"
+#include "tag.h"
+
+int cmd__reach(int ac, const char **av)
+{
+	struct object_id oid_A, oid_B;
+	struct strbuf buf =3D STRBUF_INIT;
+	struct repository *r =3D the_repository;
+
+	setup_git_directory();
+
+	if (ac < 2)
+		exit(1);
+
+
+	while (strbuf_getline(&buf, stdin) !=3D EOF) {
+		struct object_id oid;
+		struct object *o;
+		struct commit *c;
+		if (buf.len < 3)
+			continue;
+
+		if (get_oid_committish(buf.buf + 2, &oid))
+			die("failed to resolve %s", buf.buf + 2);
+
+		o =3D parse_object(r, &oid);
+		o =3D deref_tag_noverify(o);
+
+		if (!o)
+			die("failed to load commit for input %s resulting in oid %s\n",
+			    buf.buf, oid_to_hex(&oid));
+
+		c =3D object_as_type(r, o, OBJ_COMMIT, 0);
+
+		if (!c)
+			die("failed to load commit for input %s resulting in oid %s\n",
+			    buf.buf, oid_to_hex(&oid));
+
+		switch (buf.buf[0]) {
+			case 'A':
+				oidcpy(&oid_A, &oid);
+				break;
+
+			case 'B':
+				oidcpy(&oid_B, &oid);
+				break;
+
+			default:
+				die("unexpected start of line: %c", buf.buf[0]);
+		}
+	}
+	strbuf_release(&buf);
+
+	if (!strcmp(av[1], "ref_newer"))
+		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
+
+	exit(0);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index dafc91c240..582d02adfd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] =3D {
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
+	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 80cbcf0857..a7e53c420e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -20,6 +20,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
new file mode 100755
index 0000000000..966309c6cf
--- /dev/null
+++ b/t/t6600-test-reach.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description=3D'basic commit reachability tests'
+
+. ./test-lib.sh
+
+# Construct a grid-like commit graph with points (x,y)
+# with 1 <=3D x <=3D 10, 1 <=3D y <=3D 10, where (x,y) has
+# parents (x-1, y) and (x, y-1), keeping in mind that
+# we drop a parent if a coordinate is nonpositive.
+#
+#             (10,10)
+#            /       \
+#         (10,9)    (9,10)
+#        /     \   /      \
+#    (10,8)    (9,9)      (8,10)
+#   /     \    /   \      /    \
+#         ( continued...)
+#   \     /    \   /      \    /
+#    (3,1)     (2,2)      (1,3)
+#        \     /    \     /
+#         (2,1)      (2,1)
+#              \    /
+#              (1,1)
+#
+# We use branch 'commit-x-y' to refer to (x,y).
+# This grid allows interesting reachability and
+# non-reachability queries: (x,y) can reach (x',y')
+# if and only if x' <=3D x and y' <=3D y.
+test_expect_success 'setup' '
+	for i in $(test_seq 1 10)
+	do
+		test_commit "1-$i" &&
+		git branch -f commit-1-$i
+	done &&
+	for j in $(test_seq 1 9)
+	do
+		git reset --hard commit-$j-1 &&
+		x=3D$(($j + 1)) &&
+		test_commit "$x-1" &&
+		git branch -f commit-$x-1 &&
+
+		for i in $(test_seq 2 10)
+		do
+			git merge commit-$j-$i -m "$x-$i" &&
+			git branch -f commit-$x-$i
+		done
+	done &&
+	git commit-graph write --reachable &&
+	mv .git/objects/info/commit-graph commit-graph-full &&
+	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
+	mv .git/objects/info/commit-graph commit-graph-half &&
+	git config core.commitGraph true
+'
+
+test_three_modes () {
+	test_when_finished rm -rf .git/objects/info/commit-graph &&
+	test-tool reach $1 <input >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	test-tool reach $1 <input >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	test-tool reach $1 <input >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ref_newer:miss' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	B:commit-4-9
+	EOF
+	echo "ref_newer(A,B):0" >expect &&
+	test_three_modes ref_newer
+'
+
+test_expect_success 'ref_newer:hit' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	B:commit-2-3
+	EOF
+	echo "ref_newer(A,B):1" >expect &&
+	test_three_modes ref_newer
+'
+
+test_done
--=20
2.18.0.118.gd4f65b8d14

