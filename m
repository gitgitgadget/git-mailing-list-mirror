Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A35E1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeHTVlU (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:41:20 -0400
Received: from mail-sn1nam01on0119.outbound.protection.outlook.com ([104.47.32.119]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbeHTVlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pv7T1AiER5hDYVBGncJ3DSh74O8iWAS+ixsNDWW8iw=;
 b=TQCx21ovTVlF4Z2jXxo/l3nB41AVm2Uk5pkKKpflQkHPLsOjTD3/upuBT/GjtTYViZLlnmUfGU3BASKJ/qGDEu/GAfiIX/OYGc9xNSpqlklJhrKU+6oV7HbDajRSgMAAzl45i2ZBaiS8yRUENeuZbXwzTnRgXAeYFUwBJt44sao=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Mon, 20 Aug 2018 18:24:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:30 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 6/8] commit-graph: not compatible with grafts
Thread-Topic: [PATCH v2 6/8] commit-graph: not compatible with grafts
Thread-Index: AQHUOLMIlnJs6e+LWEC/WQ84Divr2g==
Date:   Mon, 20 Aug 2018 18:24:30 +0000
Message-ID: <20180820182359.165929-7-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:oK/NTZyI0bF3L2CDWT2safLp0FC9eflLnamsEvmx7p9Vq91MIQUH20sC7+jBkE5ZjTU08p4R8HaPga08g7ZbpQpk9OG/sZ6lMmvmdUfj0pLxVGCRcQARxwFFSzsjUJv2MHgCWw3MH328h3MGG/h6O38/9XsmiANxA+rF2bhbM8HvPW7PnHYMP0U/CWJPjL7tpWh6kMlJmr0mNCWuOnjFKOvzDH8aOK8vOIKcxXs//XwHAHEc99qtmM+FdW5Ifo8XTvIBQ5RP1WCFlMwHjlGTerOnP7Gn2ZnABAapC7tb2hDgX4Ai5dYeJX198tLYMEFuoDVzd19mGuAstz/HO0/U+5BazwV8rKBwN8YPsgDWwa6aFMz2TBElCJ1YagbM4sqLv2wQsxEkeagkjbcPbUN9kbiMUHLufka6IfDCgQ5CySuMt+o6ZNpmfooS72qeON7O0TOsOlWtpCPA2vY9Hjlx4A==;5:OHVpk9562NAbpJbGsNhU/rZvX14j+w2YenY4wCl7Se25PgSZcDyeNPzo0yhn4dzd8wQXmRE2Jdj/UqYxKTlUh4qQVi/2Kk5b94ZDqj+ZLr21xKPoCMwjwIbM1s0xvKXVVj9doWb+tuyzIyhFAEAZABCW+GHMSA+1+1Fiekuy7fc=;7:x9kK6RfJ6fNXPpSszWeVLo8vhuHOA62z7vJ0zf/pxd7wpuvUZlaKTLHMAu1uZrdZxmn4CLGoBcoWuTCzaJe50sC82P8BGmmOS8/4URvjHdRmVcDYB+7Uju8PrNljV0otAxepNrBfI2NHvo2kLWHy9FNqN2HKOS0TcRPRO8hoTuLq5U7EKw2LmYiVJqd6sgtGzf0DShdnLGXnYPCoEf9q84/h2TOCb+T4Wedf246MYDw8cmi9FHn7YA2XINCZkqB6
x-ms-office365-filtering-correlation-id: 60ffedd0-7d84-44de-f2e2-08d606ca2b19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
x-microsoft-antispam-prvs: <BL0PR2101MB0929C052428A4C370BD2642DA1320@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(2501003)(305945005)(6916009)(256004)(86612001)(6486002)(14444005)(14454004)(86362001)(4326008)(25786009)(1730700003)(8676002)(22452003)(81156014)(39060400002)(107886003)(316002)(575784001)(76176011)(7736002)(99286004)(52116002)(54906003)(81166006)(5250100002)(478600001)(386003)(186003)(46003)(6506007)(102836004)(6436002)(97736004)(10290500003)(6116002)(68736007)(106356001)(53936002)(1076002)(105586002)(5640700003)(10090500001)(2906002)(2900100001)(36756003)(8936002)(2351001)(446003)(6512007)(6346003)(476003)(2616005)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: dXXKpVNMOh8Fz3bxmIvLxrU23V4HPJklJ07XVCEK6uQ+FrbkKp88llC195Gr4+4RC8PovugWV4UrvWqoOFC8io4IdkFfcQNZ46+cyuJLskckaoPELzPeC4me1NqCw06n+e0+8TUM5XvUaffy2FbnbhJrsv/tjRsWag8wIfiRV2h9QhhdzN7scxQdR9asgQP1s+Nca+6xs1aJsYhfe8IxxT+C9uh5Y3uCdDbVy/fxWMgrj6rnGAbKqCCHLalgNqnSOZhZWf3JFlZPrnxQWVpViZsXHRqshwiuo0uGZhNeMB7xabMM5r4ttw5gX3Dm0hb9XDZaIWgK22O7Lf4EUyKG/NsUJOIfO0wLRvfDpn0D5Oc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ffedd0-7d84-44de-f2e2-08d606ca2b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:30.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Augment commit_graph_compatible(r) to return false when the given
repository r has commit grafts or is a shallow clone. Test that in these
situations we ignore existing commit-graph files and we do not write new
commit-graph files.

Helped-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          |  6 ++++++
 commit.c                |  2 +-
 commit.h                |  1 +
 t/t5318-commit-graph.sh | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2c01fa433f..c4eaedf4e5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -68,6 +68,12 @@ static int commit_graph_compatible(struct repository *r)
 			return 0;
 	}
=20
+	prepare_commit_graft(r);
+	if (r->parsed_objects && r->parsed_objects->grafts_nr)
+		return 0;
+	if (is_repository_shallow(r))
+		return 0;
+
 	return 1;
 }
=20
diff --git a/commit.c b/commit.c
index 30d1af2b20..ef9a2cbb23 100644
--- a/commit.c
+++ b/commit.c
@@ -209,7 +209,7 @@ static int read_graft_file(struct repository *r, const =
char *graft_file)
 	return 0;
 }
=20
-static void prepare_commit_graft(struct repository *r)
+void prepare_commit_graft(struct repository *r)
 {
 	char *graft_file;
=20
diff --git a/commit.h b/commit.h
index da0db36eba..5459e279fe 100644
--- a/commit.h
+++ b/commit.h
@@ -202,6 +202,7 @@ typedef int (*each_commit_graft_fn)(const struct commit=
_graft *, void *);
=20
 struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int=
);
+void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struc=
t object_id *oid);
=20
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct com=
mit *rev2);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e0c3c60f66..6aee861f78 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -281,6 +281,44 @@ test_expect_success 'replace-objects invalidates commi=
t-graph' '
 	)
 '
=20
+test_expect_success 'commit grafts invalidate commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	test_when_finished rm -rf graft &&
+	git clone full graft &&
+	(
+		cd graft &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph &&
+		H1=3D$(git rev-parse --verify HEAD~1) &&
+		H3=3D$(git rev-parse --verify HEAD~3) &&
+		echo "$H1 $H3" >.git/info/grafts &&
+		git -c core.commitGraph=3Dfalse log >expect &&
+		git -c core.commitGraph=3Dtrue log >actual &&
+		test_cmp expect actual &&
+		git commit-graph write --reachable &&
+		git -c core.commitGraph=3Dfalse --no-replace-objects log >expect &&
+		git -c core.commitGraph=3Dtrue --no-replace-objects log >actual &&
+		test_cmp expect actual &&
+		rm -rf .git/objects/info/commit-graph &&
+		git commit-graph write --reachable &&
+		test_path_is_missing .git/objects/info/commit-graph
+	)
+'
+
+test_expect_success 'replace-objects invalidates commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	test_when_finished rm -rf shallow &&
+	git clone --depth 2 "file://$TRASH_DIRECTORY/full" shallow &&
+	(
+		cd shallow &&
+		git commit-graph write --reachable &&
+		test_path_is_missing .git/objects/info/commit-graph &&
+		git fetch origin --unshallow &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph
+	)
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
--=20
2.18.0.118.gd4f65b8d14

