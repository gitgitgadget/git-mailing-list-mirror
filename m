Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3F7215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbeEAMrT (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:19 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:52942
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755480AbeEAMrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OxAp5LnjxUU6SM+Av9W4MQHWxlP2QIKOEOLvV5x2daY=;
 b=NRBWyQn3FDw2j2dGqDvU3WOO88KNVL8ortzL6Nyh3Dwn0CG8yowIdWSx8O0ecIw7fF/wBpvMN0JJT9sdthiNY3HrjoyBicZ4+DqvGL3MjI0dzdnKCK5q5NOkuXEm6cXYVyZjEawBqCN6gq22XpjsuYFkMyNo+NcSO6YTdQEgAVU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:11 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:11 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 04/11] commit: use generations in paint_down_to_common()
Thread-Topic: [PATCH v5 04/11] commit: use generations in
 paint_down_to_common()
Thread-Index: AQHT4UqFtAtCQY7bYEyQQ9h9o9GkXA==
Date:   Tue, 1 May 2018 12:47:11 +0000
Message-ID: <20180501124652.155781-5-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:8t2csQM1mr+yvR7dHBxjWI1L7SeXaMlLvZJn6JynAZ7RHuEBxJawyKHim5DnvKgHxZJMpUO05XZMmzT875ml5fDg78NZAmMg1WXIcaueiUCbkj4zF+prH1iHlEKAfHFJrrQNJudiWQFUOVNOn6YoCUFWWnxNuwzrZx/VuNihcnCeQDCVCHY9UWiLKrNqLASjHBgX1xgWGYYJGKhHsmifaj7R2ewGVV2o9/oP78ctPWSZA5z1QRltOI+U9yHwB417;20:x9GeU5vpazWd+XJbQl56JZmUQqI81OGUWd0AlCONJHi2WjlcNByKvEfugN7CEq9Horxsm24c2aSjtgmHjOnAjitjcoMdebWJRnUadZkNh4wvaLNPeZJphhnq9FNOkCnsALOT58U0et5NO0QS2Ufyrm2ifKtA3oEqRdcCmMT5QRU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB09773E887837577706F05DBEA1810@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(102836004)(53936002)(6506007)(386003)(59450400001)(99286004)(2900100001)(54906003)(5640700003)(3280700002)(3660700001)(2906002)(6512007)(6486002)(25786009)(39060400002)(4326008)(107886003)(86612001)(6436002)(6346003)(8656006)(36756003)(52116002)(76176011)(105586002)(106356001)(5660300001)(6916009)(5250100002)(2501003)(97736004)(7736002)(68736007)(8676002)(81166006)(81156014)(10290500003)(8936002)(478600001)(86362001)(486006)(10090500001)(6116002)(476003)(2351001)(1730700003)(186003)(575784001)(1076002)(305945005)(446003)(22452003)(46003)(2616005)(316002)(11346002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: bfKWO21ATiymu49LJLUMi1tY5xBXphe0Fyzk8ackz/ZXP7sa8ZjE9lNIvmrwWemyUUjHSP3O6mWvrhGcETd86K51ZndJy9nB3fTva5qlHOTrl06c4JnccRBpovmBXjMpLoTeLQMFC8pdg6SoNknImq1aGR0wRGQy9CWEbP4azWuySaAMtXQOU4d2KsVAcgnt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 51eb650b-e4a7-48a3-c4e2-08d5af61a860
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eb650b-e4a7-48a3-c4e2-08d5af61a860
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:11.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define compare_commits_by_gen_then_commit_date(), which uses generation
numbers as a primary comparison and commit date to break ties (or as a
comparison when both commits do not have computed generation numbers).

Since the commit-graph file is closed under reachability, we know that
all commits in the file have generation at most GENERATION_NUMBER_MAX
which is less than GENERATION_NUMBER_INFINITY.

This change does not affect the number of commits that are walked during
the execution of paint_down_to_common(), only the order that those
commits are inspected. In the case that commit dates violate topological
order (i.e. a parent is "newer" than a child), the previous code could
walk a commit twice: if a commit is reached with the PARENT1 bit, but
later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
propagated to its parents. Using generation numbers avoids this extra
effort, even if it is somewhat rare.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 20 +++++++++++++++++++-
 commit.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 711f674c18..4d00b0a1d6 100644
--- a/commit.c
+++ b/commit.c
@@ -640,6 +640,24 @@ static int compare_commits_by_author_date(const void *=
a_, const void *b_,
 	return 0;
 }
=20
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_=
, void *unused)
+{
+	const struct commit *a =3D a_, *b =3D b_;
+
+	/* newer commits first */
+	if (a->generation < b->generation)
+		return 1;
+	else if (a->generation > b->generation)
+		return -1;
+
+	/* use date as a heuristic when generations are equal */
+	if (a->date < b->date)
+		return 1;
+	else if (a->date > b->date)
+		return -1;
+	return 0;
+}
+
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *u=
nused)
 {
 	const struct commit *a =3D a_, *b =3D b_;
@@ -789,7 +807,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
 /* all input commits in one and twos[] must have been parsed! */
 static struct commit_list *paint_down_to_common(struct commit *one, int n,=
 struct commit **twos)
 {
-	struct prio_queue queue =3D { compare_commits_by_commit_date };
+	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result =3D NULL;
 	int i;
=20
diff --git a/commit.h b/commit.h
index aac3b8c56f..64436ff44e 100644
--- a/commit.h
+++ b/commit.h
@@ -341,6 +341,7 @@ extern int remove_signature(struct strbuf *buf);
 extern int check_commit_signature(const struct commit *commit, struct sign=
ature_check *sigc);
=20
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *u=
nused);
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_=
, void *unused);
=20
 LAST_ARG_MUST_BE_NULL
 extern int run_commit_hook(int editor_is_used, const char *index_file, con=
st char *name, ...);
--=20
2.17.0.39.g685157f7fb

