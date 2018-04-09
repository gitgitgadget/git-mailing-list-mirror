Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9141F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeDIQmA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:00 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53973
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeDIQl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v5ojGTW/3ze2m1++zTA4fynT/NJ6zDAdYBM1sSNNaXA=;
 b=iOPFGsQu82DSK507Q3fKD0y7TdZe3i1hVQmOSwcFSnuhDqXz7dTmTnlmxVVvCMzf/dvtw8j1upXubcvVf0p/fcmXT62XKVGQ/oi9hWhE76WlPuUVhRMPLsBJO4eEa87m8ijHZm3fJiL6UADjCj1w8DGfj0EC8F0a2m0eNA1q5EQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:41:58 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:41:57 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 02/10] merge: check config before loading commits
Thread-Topic: [PATCH v2 02/10] merge: check config before loading commits
Thread-Index: AQHT0CGr1OWc2sFXkkejASdbsFOhnw==
Date:   Mon, 9 Apr 2018 16:41:57 +0000
Message-ID: <20180409164131.37312-3-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
In-Reply-To: <20180409164131.37312-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:903:99::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:UL9OawG+jUikiUpAZ9pUiiZizirdNFUrx7WuROHp2+qx/VNkAY+wSytR+wkgRree5uUqLxU6RkcK8OmoOn6qldVzqIZZa/w2j0GwfCzg2UA7m8Xruwe2F0Pqk9AVcxbNQijFJmMf/kpjaOZn6Jo0ITtdrD44QanCrAgza9vhr0n+e1CxyQ2qeZRTB4ABaq2iOTiYgoUpYIScLsbKtQZdTFUkBcZraErs5WTjnMWzOZl0YIky2j1g+28SlwJc8+rU;20:GXpl8LuqBJyfDbotVLXDVpn/h8R1MRZT9lR6uEdOEi3Nx6fOsYBDfBgkv73SA7RAQjJEAdiTRzXI9M5xlmUpwoMqNBamq/N/iEqZubAPKJC8TRrQ9SEI/o3x0H/WpZx7JBI1xzF0C6J6kD9IwaMyRjjCYMbWuUVrJEGsOkVBGEY=
X-MS-Office365-Filtering-Correlation-Id: e117d867-28da-4caf-8aa0-08d59e38ce22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962E9E4CD1F3559E9B1F8B4A1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0+MVewBSseVBjUUFr7KkkROn/bJRuie1/RzyCJQCFChv856utWyZQA2dS1K0DA7oqD3KhKMs6QclVpJW0UsXI7LKO8Ymw1BDXoJmgJA2dnzBt4lxTZc/da8I/Wy85w+B2b59W8sMF3xFNMifBzCMiQgAod7xiGsE9eJkfo7ry8WLxBziHCrXnEWliXEXhIscM1E3lGqMQe0ivZXmvnVVOd5sC1oVy+XkVVB6JmNBXIM9YEzwbs1X1D9qcCC502EqLVWcSCuhQQwVdkYf/BjKu1+Pb3Vfb09Z8PxRVzfCv67ok/1vXZI7X4rI1S/G7WZz+lkhcbamv5D7vd3lQ5mwAecOIPvAhumEvnNBY4ha9+dNUjNCXmraTJWwnH+yqqeM3hY43FJpx5eSS0lIakDfVOk8dDHGIRApi9HkWAnrO3s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e117d867-28da-4caf-8aa0-08d59e38ce22
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:41:57.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of using generation numbers from the commit-graph,
we must ensure that all commits that exist in the commit-graph are
loaded from that file instead of from the object database. Since
the commit-graph file is only checked if core.commitGraph is true,
we must check the default config before we load any commits.

In the merge builtin, the config was checked after loading the HEAD
commit. This was due to the use of the global 'branch' when checking
merge-specific config settings.

Move the config load to be between the initialization of 'branch'
and the commit lookup. Also add a test to t5318-commit-graph.sh
that exercises this code path to prevent a regression.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge.c         | 5 +++--
 t/t5318-commit-graph.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ee050a47f3..20897f8223 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1183,13 +1183,14 @@ int cmd_merge(int argc, const char **argv, const ch=
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
2.17.0

