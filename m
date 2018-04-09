Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D1A1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDIQmI (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:08 -0400
Received: from mail-sn1nam02on0090.outbound.protection.outlook.com ([104.47.36.90]:16672
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbeDIQmF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J95HVegh4n7QWBR/TF2hiP50tROGSP/iMXtcyL3/GQk=;
 b=WYLZRKSHhPCHnW8h47Qb0fBJeQIkWuM/Uk8Z6mo5zu2pWsJIHISLotbOZdq6XZUgbbEucXdKoZoqail+DqwHd6gNVmNPaVfXmzVdmf7r3zFx/syTgmEapdWYOUSG7WbKDpDy8h4QUlpS/NoSYEJKSVfQXFczmNTl0Q3Ykc8fOCg=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:03 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 05/10] commit: use generations in paint_down_to_common()
Thread-Topic: [PATCH v2 05/10] commit: use generations in
 paint_down_to_common()
Thread-Index: AQHT0CGwbYa4aVKoP0KwLDm4mjwWpw==
Date:   Mon, 9 Apr 2018 16:42:03 +0000
Message-ID: <20180409164131.37312-6-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:oxx46p9czJMWyptP5DogY9MYwX56Tffa21ppzHMBpMyZGN/xeZpBPWxZ/hLWnfgpRcnqisepktx2XXqIO0SQaqSO9/0Wh52YI8NpmsxVCMuqdenwlX1QWQSDZbZ+gpQvFdF82DqvDMK4yIJhJNloL6ewigcWhsQAbNBwMvcmkktI5wJzJWYIi0n0W3QNeBLoOgnxVKW7GfvShngCwz3b8PI8/wNgqAWATkf4rfG236TEmCfMT6TchjAsOSLbWzkl;20:cRmVMoBqCfPTGINQczJcS4AZGTqu5aab4mcRDj4tHDj4buVDQ/Ck40MwO0Pxx7JVzu5gn1tyFuNiehtSKdsH/XEgU7T2pGS2dwb4rB9ioWmzTVokAfwVddvv1cVT2HXCu0EQtxY/ZyVaYV+Va7FLUUrKbzv3jNyWU1YBFDAYh2Q=
X-MS-Office365-Filtering-Correlation-Id: e181e3e8-0eaa-4096-9de7-08d59e38d2ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962474ADF6A87C851D5E26BA1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(59450400001)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xELhBwzlJpNGVk9HCoA3cdWEzh4wx6voiMI9nIgzAEzX/d2FpUMn2Pe2rrFScaVsoBA+HVejvUJtKj06nwZb/bfz0tUMzdkWuJs1Qvl5hFb6wL+XKEFFeLaC9ARObRE/u66F71iQyHFJbtfkOxi9xr3l3X81ywffXVGyclsydT+GU5QuJi35bzX2pWDV5aRDkrPKKPqSH06H/HnOdH+9Gm/trvpIhsYzMWRV27KolNVOeHAx09dPUOd+/OofWn45wHI0YX46WV5HZcNMFUr1bT5azW07LNeJI1yR9xNk9affFDf7lmRepL4ZYPrzNJ/IU8iuTJAMWY9ClyCmIrZKgLTaxibCslkYqHN0u1v2H4edVMIQ5SKBOvmrHhgiHReLs94cpgw9yUb6rCkqgka9FtfPn6U17nNtGFo9RD4a6mE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e181e3e8-0eaa-4096-9de7-08d59e38d2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:03.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
 commit.c | 19 ++++++++++++++++++-
 commit.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 3e39c86abf..95ae7e13a3 100644
--- a/commit.c
+++ b/commit.c
@@ -624,6 +624,23 @@ static int compare_commits_by_author_date(const void *=
a_, const void *b_,
 	return 0;
 }
=20
+int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_=
, void *unused)
+{
+	const struct commit *a =3D a_, *b =3D b_;
+
+	if (a->generation < b->generation)
+		return 1;
+	else if (a->generation > b->generation)
+		return -1;
+
+	/* newer commits with larger date first */
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
@@ -773,7 +790,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
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
index b91df315c5..c440f56bf9 100644
--- a/commit.h
+++ b/commit.h
@@ -332,6 +332,7 @@ extern int remove_signature(struct strbuf *buf);
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
2.17.0

