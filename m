Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497E0215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbeEAMra (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:30 -0400
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:51343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755580AbeEAMr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CKI6wzzymoqb7DzTXVxg1jAGdnBPaQqsRX5VXYwNCPs=;
 b=YVDnq7W25sFmxBHKpbmOjxgWPT7zNMzRrZuY8BXQbrtWRMSSwXRH6h4PPVJOohpEooW4PVz+AiwZdEjZPr9LdaFSBeNtbGzCDFgceMqNa8m9/HUc2ZYKBtXTmiZDTcl4adhSep203Ai8pj+cpkSgsbrc2yYCbO6N3ZStr1pcyyk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1042.namprd21.prod.outlook.com (52.132.24.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:23 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:23 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 10/11] merge: check config before loading commits
Thread-Topic: [PATCH v5 10/11] merge: check config before loading commits
Thread-Index: AQHT4UqM7yoHKO8MSEad4mkk7B4/pQ==
Date:   Tue, 1 May 2018 12:47:23 +0000
Message-ID: <20180501124652.155781-11-dstolee@microsoft.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
 <20180501124652.155781-1-dstolee@microsoft.com>
In-Reply-To: <20180501124652.155781-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:403:2::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1042;7:2caHNewWUA3LGahIsdioRBUnrD571OnAEmxYCwwvpUxXeQAibkHiUDCmGcwWTjbE9BKcOmN4H+ZTEF6CIoVNqkPdWluuvmiJGqa8FP8NuFcXLZLPEt/VEja2NbXCRMTkdwGYXC7Y9N+bDSftV21ROPa4azZwPJzLvt8dlvBIfigS8lLC1LjQzmhJHB7eVYEh4bdqmbsw9pz9whM9/NxbR3H2AEgnGbxFdT3AW0HdIOmHpks8B57NTnhM322/05Sw;20:BIya8pDJYhRVqKR0b1eB814QRqyiUa3VzBvMR78GVnLqIeNscUc2Sw3TA+evPH4q/aoSxxEzgZ1XsCGPf7bqkdyOCHA+uAZtX4RJfeFqKUmGIXqIwilqXCrE0j56GP+6ja4I9/HB4OQ8sxeqN4HwY5utY554XkhY17UAWzsn7mo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1042;
x-ms-traffictypediagnostic: BL0PR2101MB1042:
x-microsoft-antispam-prvs: <BL0PR2101MB104217715B727EB2E104D4B9A1810@BL0PR2101MB1042.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1042;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1042;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(22452003)(86362001)(316002)(39060400002)(36756003)(5660300001)(8936002)(81156014)(6486002)(97736004)(68736007)(6116002)(10090500001)(11346002)(81166006)(5250100002)(2501003)(186003)(446003)(6512007)(1076002)(3660700001)(4326008)(10290500003)(3280700002)(46003)(6346003)(386003)(6506007)(478600001)(102836004)(105586002)(53936002)(25786009)(2616005)(2906002)(2900100001)(107886003)(486006)(305945005)(2351001)(54906003)(5640700003)(7736002)(86612001)(106356001)(1730700003)(14454004)(8676002)(6436002)(8656006)(476003)(99286004)(6916009)(52116002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1042;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: DJCTXTcFTTNmkpB3jKGO1NoJ6QiHBegOtRuPzte2SQLHLRIU8Pvnawnpr91arGyQ72XUK2cNLqTwppG5wJxCrVrMzYpd1HI18NgQEFJnfcnhwbcmIIRz5Jj0xI9Wjij+bNAB/HbiUgYleZcssNC7lCRPsrjOJ0Q9f+CYQWLrCJityzpw0FqhtqD6djU/zsML
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: df25b409-124f-4a71-001e-08d5af61af51
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df25b409-124f-4a71-001e-08d5af61af51
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:23.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we use generation numbers from the commit-graph, we must
ensure that all commits that exist in the commit-graph are loaded
from that file instead of from the object database. Since the
commit-graph file is only checked if core.commitGraph is true, we
must check the default config before we load any commits.

In the merge builtin, the config was checked after loading the HEAD
commit. This was due to the use of the global 'branch' when checking
merge-specific config settings.

Move the config load to be between the initialization of 'branch' and
the commit lookup.

Without this change, a fast-forward merge would hit a BUG("bad
generation skip") statement in commit.c during paint_down_to_common().
This is because the HEAD commit would be loaded with "infinite"
generation but then reached by commits with "finite" generation
numbers.

Add a test to t5318-commit-graph.sh that exercises this code path to
prevent a regression.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge.c         | 7 ++++---
 t/t5318-commit-graph.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5e5e4497e3..b819756946 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1148,14 +1148,15 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 	branch =3D branch_to_free =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
+
+	init_diff_ui_defaults();
+	git_config(git_merge_config, NULL);
+
 	if (!branch || is_null_oid(&head_oid))
 		head_commit =3D NULL;
 	else
 		head_commit =3D lookup_commit_or_die(&head_oid, "HEAD");
=20
-	init_diff_ui_defaults();
-	git_config(git_merge_config, NULL);
-
 	if (branch_mergeoptions)
 		parse_branch_merge_options(branch_mergeoptions);
 	argc =3D parse_options(argc, argv, prefix, builtin_merge_options,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a380419b65..77d85aefe7 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -221,4 +221,13 @@ test_expect_success 'write graph in bare repo' '
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commit=
s/8 merge/1
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commit=
s/8 merge/2
=20
+test_expect_success 'perform fast-forward merge in full repo' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git checkout -b merge-5-to-8 commits/5 &&
+	git merge commits/8 &&
+	git show-ref -s merge-5-to-8 >output &&
+	git show-ref -s commits/8 >expect &&
+	test_cmp expect output
+'
+
 test_done
--=20
2.17.0.39.g685157f7fb

