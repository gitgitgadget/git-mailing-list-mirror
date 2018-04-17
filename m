Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA4F1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeDQRAp (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:00:45 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:14256
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754017AbeDQRAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l8+u46LW1Uu/gOLi9rg4WyNJlwGj3AZUg/DcZKAu6a4=;
 b=HqidgmzHH3kOp6a5CqRGztMNBX5zQC/bYqUk7a02wIwo4ydA+lwTQn+CjqxjSeK4gLp8/BqNogcSvUcQq6irPmDHhw38bfQOVUhyky1vbcu5f0viX2JMLCs3/GiQIyFTb7ZAhAivPAvoKvWiq1xtZReLxx8HU35yMhutGLaBim8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 17:00:38 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 17:00:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 9/9] merge: check config before loading commits
Thread-Topic: [PATCH v3 9/9] merge: check config before loading commits
Thread-Index: AQHT1m2cQ5YpLUuz3UihtyOs9fpjIA==
Date:   Tue, 17 Apr 2018 17:00:38 +0000
Message-ID: <20180417170001.138464-10-dstolee@microsoft.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:ThUBXy62icRPEps76n6FdBwwAz1TZG8RbBMgGldWlyeiJdHLfkH33zqPJD4oNMSHZz3EjpRXqjPTMDbw7h+h7jqP1GaeGik8FQd7LVf9m9jw4tbCkdqZIXVKPPe5aIX8M21MawWuPARYpt/ukixt8ddjzTILI+yRhq0Rsk815k3qbxZJpV9bNYAsu03TBiK01UeLuRuZkyHzscNixXj1+hsVDvusT0BpNpCHgtSXhAo/I4XpeKi0nU5z6lnh27pX;20:1S3jhJUrNwBF4qH8yPlJSurcJZ9zH3cEnHzLwjkyxVtLaETMH5MO5HMqHH7YTRPVeLI1HEwfk+VX+fREmjxP59FLkGJADfbQorZt3ENoXdszSYzvuWZ+7NauCkmIU3LMDkuukb51FXwJtMUcsAQu5Bc2JP4xVXxbnWrFpYc6HKI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1074A03EF884B3D8C2DC2832A1B70@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(102836004)(10090500001)(7416002)(6916009)(2906002)(99286004)(10290500003)(386003)(186003)(6506007)(86612001)(5640700003)(14454004)(5660300001)(8676002)(97736004)(3280700002)(105586002)(4326008)(52116002)(86362001)(486006)(8656006)(6116002)(2351001)(11346002)(476003)(106356001)(46003)(2616005)(2900100001)(316002)(36756003)(446003)(54906003)(2501003)(22452003)(478600001)(68736007)(25786009)(3660700001)(107886003)(39060400002)(6486002)(53936002)(305945005)(1730700003)(1076002)(6436002)(81156014)(8936002)(81166006)(6512007)(5250100002)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2YdmWqAU6NR5oJVgdr62F/NvVYhgcMKRxU5iX/73q+C5xl7fVwTmwaJ3l0NHtXBXzCTYKHsetktAoQbOSNXtcnYxBwHO9F5nMk0tjc3sj3DEkupaB60zse944f9vxk+uU8D/Ksz12HXl3uL3Tof8WrxeTV/xMZP3R1zSFQmH+8qbsRo7D5BkRWZ6sNSTiAcb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a5a570ec-c72f-4ba8-9b28-08d5a484be63
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a570ec-c72f-4ba8-9b28-08d5a484be63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:00:38.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
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
 builtin/merge.c         | 5 +++--
 t/t5318-commit-graph.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5e5e4497e3..7e1da6c6ea 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1148,13 +1148,14 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 	branch =3D branch_to_free =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
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
=20
 	if (branch_mergeoptions)
 		parse_branch_merge_options(branch_mergeoptions);
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

