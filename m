Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900921F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeDYOiK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:38:10 -0400
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:40160
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754484AbeDYOiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OxAp5LnjxUU6SM+Av9W4MQHWxlP2QIKOEOLvV5x2daY=;
 b=RlVWiNCx9CixWzrZD10P+DZKtyw5XtTu80SuV/pH9+Ry3wPPuFMgkHCINzdU2iJDRbf4nWy+79zOT6Kg1phhz0B+s7I9abvOYK0AA6SrB8ugSqrQLVCOrNZO1CuQjVa6sI7zn79D0FE8mQN4Jtd2YPa3hJypQ6Y51w4JcQTEo+Y=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.5; Wed, 25 Apr 2018 14:37:57 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0735.006; Wed, 25 Apr 2018
 14:37:57 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 04/10] commit: use generations in paint_down_to_common()
Thread-Topic: [PATCH v4 04/10] commit: use generations in
 paint_down_to_common()
Thread-Index: AQHT3KMANT2bQ4QDWk6cr0NSDg1QLQ==
Date:   Wed, 25 Apr 2018 14:37:57 +0000
Message-ID: <20180425143735.240183-5-dstolee@microsoft.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
In-Reply-To: <20180425143735.240183-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:405:70::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1106;7:2r4XyddMzyl1oLOpX+EsPMef1yom6Wqz8IcCCFDjqfGSZ/BLRBzAlLBcANx5grjQ+UbMiSWee9mv3g8dylA6Rvlzo9j/DMIYd4AJGpMo2dvGU21P2mlbP9C4tfhJzAID0nzxwZXgPXVNUSZfXGjV/+fj0bDxSkCYWH3cg5vfSWNlz1Nd0qcaKiiba4HWqon6vyGe/TX+WAt72PXl7n43B1J+8e2jZtspvA8C1bppssZ+6Jaf7/Z1JQzXNJb4HSwW;20:XBGaFsBmNmAOPu9usAlgXpura4i6vl77Ob4xp4f9KpgQsIWO8/TS4p52i2cF0jV+1WONUypFHDzzwtscP1CAjTvTsKq6CiMRi4aU/cf2pMVSCNUcGK6Qg68VGejazzD+O5glUAgyf4MkHrbcvNTVEQRSRBsMmWy2IWIRgUHXrsM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1106;
x-ms-traffictypediagnostic: BL0PR2101MB1106:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1106BDAB44ACCEAC39D82487A18F0@BL0PR2101MB1106.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1106;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1106;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(106356001)(86612001)(25786009)(105586002)(39060400002)(22452003)(486006)(316002)(6512007)(186003)(8676002)(1730700003)(81166006)(305945005)(6486002)(97736004)(8936002)(5250100002)(14454004)(76176011)(81156014)(386003)(6506007)(7736002)(99286004)(59450400001)(6116002)(86362001)(36756003)(102836004)(478600001)(1076002)(3280700002)(8656006)(3660700001)(52116002)(10290500003)(5660300001)(46003)(2900100001)(107886003)(5640700003)(4326008)(6436002)(6916009)(2501003)(2351001)(68736007)(10090500001)(11346002)(54906003)(2906002)(575784001)(446003)(53936002)(476003)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1106;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5e7sRWeN7suRFaK9SeyP1mg/AzlXRGtMeUPidEZjL0zsIaKeq6DmRlLfLkQ6nVJ/Qa2AX4ARK8V82a22kYiMWTCtwJOnuskrXbq5qA1S57U0EdNgRbcFj7pLYEw6Cq00J3WTu6f3Y+fxA1prXFbBeS7xizoRKtHD/QYqoEvXsYhs8ZL7npMueKen8bHpSXEZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1f830de8-d3c5-4e85-8b42-08d5aaba22e2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f830de8-d3c5-4e85-8b42-08d5aaba22e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 14:37:57.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1106
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

