Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7971F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIOBaN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:30:13 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbeIOBaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZEp9HEY0KmtE2jjsJ1KSjYVZrAZTWYlvAVyHlArm48=;
 b=JPr7kCTZG35+6lpBaLG57OqiObvSk9kfJ7SD6NZRHWbylsj11XzJ+qBw4wWKqAfV+ffu/WgKZdkOkIMXqxIM7RESk3dYOXlb9a4qDA0RCYTiaSFPvzmf4PP4iwpx4S7LCjkJ7vg3wTDFRSiSmdcl/04kzmg0ZFjHam5vHUaNQ9Q=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Fri, 14 Sep 2018 20:14:05 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 20:14:05 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>
Subject: [PATCH v2 5/5] preload-index: update GIT_FORCE_PRELOAD_TEST support
Thread-Topic: [PATCH v2 5/5] preload-index: update GIT_FORCE_PRELOAD_TEST
 support
Thread-Index: AQHUTGd8B/zk/fLBFE6usoNc6Ny9/A==
Date:   Fri, 14 Sep 2018 20:14:05 +0000
Message-ID: <20180914201340.37400-6-benpeart@microsoft.com>
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
 <20180914201340.37400-1-benpeart@microsoft.com>
In-Reply-To: <20180914201340.37400-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY1PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::29) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:71SH1mYl/3juF5GHfWU8OKtK7AbRa87SDclDYLpjxsI8jvc9IN0OBPF5kcMKgUIVcX6k4AOY/Nq1zan5Y4YuG3l3LDj2aY4KYMRVkZoN+1z9C3bOFfdYq8S1m6Ne4MZxUW6SC/Y1eEizlvF1PsqKlz5ZBFGCIepiEh69wKeDecsI0yJ7/zl2CwV2uTIajJ1Tcxtj9DCJ5LlN9XQs7l0nRzAD/yKOWgjVGfKYQeoWgvSYGI6ZYaq/XIZTnoVABBojXtYUXx3lyrBugXAVtXU+EnXwp6T7nnqUaQaujN9juLf0S+3+QzGRby70ubBs7Z0Epy4wPQJpmixpu/bsP+TZk65ae215dSdCJDKnRToUxUSURSgcqqsOxGzdc9VE8tQ7smdpYfxghnRuFuQveKYXGVWliJfYr7DMwJSOS3EM/rEgj6TjtMVnxaTx5RSboln0psRW51h69ajmWQ8PsglsXA==;5:tTwdGYSqxcN03OmYH8/Um2Lp/lwCxuTwCGp73Vt1UFlHPxuZ2eotURKN3X74OKzUxzZWc9t8BMNnf1fE8GHXtbt+f0C9mkk9ShIH6f3hAo0c05AmmY72j8X+8xwPWkQur5e3t/q+sWuuANSTArm8f48+xk19fmvOXOwkwkCgf8s=;7:KNBaSwTKSJ51YymExcSVO9epF4woPh2kRQwobjkAp2OlRwpimWx55H0WvgZ/dJBbnibBaVIBBQTzdPu79ZAZRcOBIE2gUBS81GQr9yzcC+w7CwUSjBxk4dupo1mET+HBRlKY0s56b0O8b50B128v9bBoEHrCyn/JC64sQGNQs5CI3iTGDEupDoKzEnShlQNZa/RfM7E9lCkuP7lt/EZGgwJ+lCexcwO8sBC8cEwjVmKVmn0yNJfV5GR7Ay7a1T6e
x-ms-office365-filtering-correlation-id: 95906d79-4b5a-49d3-2add-08d61a7e9e80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1083AC8E5E761AF117D73771F4190@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(54906003)(478600001)(36756003)(2351001)(81166006)(81156014)(386003)(1730700003)(6506007)(8676002)(4326008)(316002)(8936002)(97736004)(22452003)(102836004)(1076002)(6116002)(3846002)(106356001)(1361003)(72206003)(25786009)(50226002)(105586002)(305945005)(14454004)(7736002)(1411001)(99286004)(86612001)(2906002)(15650500001)(76176011)(52116002)(10290500003)(5660300001)(6916009)(39060400002)(5250100002)(6512007)(486006)(186003)(6436002)(11346002)(476003)(2616005)(6486002)(446003)(26005)(5640700003)(2900100001)(10090500001)(2501003)(66066001)(53936002)(68736007)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rAfprYdNxECA57MU3woNdSTnGj5eON0s1P8gUjtwFvf8OafOVBMvXWOAvDfQqVvZs/KMoVFKbC9Tc64Q70XugxIeHyJGDkfIQIFj2+iroK5mUct0yw+6PKa2u+MjAqXfVdYglVwTXsiJu0vFKcQOSPfT/a65r21Py+95puxlFJ1FVUD1XtsUF1wKnWdnHq41QxhctSKJ4ACOzYx1aFrpP08/y0gx6VXsXy8EmhzDkKBtwvfu16UxxqaktRJoJSMfUQtRaQRkp6Tjh+hiOtnrPupiDNjBftQEKJNjcTne9hPUL2hKrJQ8j2WDJxUBpyHi9ubym9TsCe1xqiENWLFSPsT4ymvXm5hRA+YeBOwKBac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95906d79-4b5a-49d3-2add-08d61a7e9e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:14:05.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FORCE_PRELOAD_TEST to GIT_TEST_PRELOAD_INDEX for consistency wit=
h
the other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give a warning when the old variable is set t=
o
let people know they need to update their environment to use the new
variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 preload-index.c             | 2 +-
 t/README                    | 3 +++
 t/t7519-status-fsmonitor.sh | 4 ++--
 t/test-lib.sh               | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 0a4e2933bb..a850e197c2 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -85,7 +85,7 @@ static void preload_index(struct index_state *index,
 		return;
=20
 	threads =3D index->cache_nr / THREAD_COST;
-	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_FORCE_PRE=
LOAD_TEST", 0))
+	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_TEST_PREL=
OAD_INDEX", 0))
 		threads =3D 2;
 	if (threads < 2)
 		return;
diff --git a/t/README b/t/README
index 9b13f6d12e..5670c7aad0 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,9 @@ GIT_TEST_INDEX_VERSION=3D<n> exercises the index read/w=
rite code path
 for the index version specified.  Can be set to any valid version
 (currently 2, 3, or 4).
=20
+GIT_TEST_PRELOAD_INDEX=3D<boolean> exercises the preload-index code path
+by overriding the minimum number of cache entries required per thread.
+
 Naming Tests
 ------------
=20
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d77012ea6d..8308d6d5b1 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -245,9 +245,9 @@ do
 		git config core.preloadIndex $preload_val &&
 		if test $preload_val =3D true
 		then
-			GIT_FORCE_PRELOAD_TEST=3D$preload_val; export GIT_FORCE_PRELOAD_TEST
+			GIT_TEST_PRELOAD_INDEX=3D$preload_val; export GIT_TEST_PRELOAD_INDEX
 		else
-			unset GIT_FORCE_PRELOAD_TEST
+			sane_unset GIT_TEST_PRELOAD_INDEX
 		fi
 	'
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 397eb71578..17a56f44ad 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -160,6 +160,7 @@ check_var_migration () {
=20
 check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
 check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
+check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
=20
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
--=20
2.18.0.windows.1

