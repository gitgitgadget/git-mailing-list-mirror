Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD6C215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeEAMrO (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:47:14 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:52942
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755352AbeEAMrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qmdz+TpBRCo+cz/YL/22lPp8H1eeDFKpYm8MAtX3+wc=;
 b=SYOMosYKuv/AqsYTN/Mof1Tg9APk3z0xa+9MqMGaBMQOUV6Qv4HFCqhzVxTpssKCwEdEozs2DQv8aicnWUQgHGL/D40h8gQejnVNRZc85fDKWMtEJPnNwEYr8dWgahhnCO0wJKWWUqfsJAd57Rxaj5yZzb+4buZguhjet/HLrbo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Tue, 1 May 2018 12:47:09 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%2]) with mapi id 15.20.0755.007; Tue, 1 May 2018
 12:47:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 03/11] commit-graph: compute generation numbers
Thread-Topic: [PATCH v5 03/11] commit-graph: compute generation numbers
Thread-Index: AQHT4UqEK9TrBChkT0GQxbwLUzycdw==
Date:   Tue, 1 May 2018 12:47:09 +0000
Message-ID: <20180501124652.155781-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:hE+7CDKHTfDFOM1RZg/UOjjTMyoLrnUlMyoiilvRuRpOFNuYxAzb85hY00BHbFYt4lkHycDPUw6oR2bukKgK7CxG50f7Fp32j+493ZRMIPCDgjISboLKfjtI64mrlt/7CoxkoArNkyuFI0h1/4RdWf9Y4M0DU0kZhgpSrBUQbAFhqG7CS3fvGTOfN+Zs7FoAMZgEUKxWVTAksbfHsQ/dqq+DHVjTQqe9h/zj6K1hIaPVPCN2RmdUArSDBnUUtsjv;20:C5J/37V1kV9EO/QQQ9UgcFXIDFx0zA9bhwgymbJb3gJQbKQh8qokpyfdHc9hY+tSG8OusKDVsTuExiOq9k/khxUTTBxaLCRdGGSRFlzkWMpy4KDrLQqErI+uVvfvyo37iCIbvz5Wi5r2Frf2UwLtfxfF7Jbc7SD/PT65e1Oedy0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB0977233AFCB2C9E8C766D1C9A1810@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(102836004)(53936002)(6506007)(386003)(59450400001)(99286004)(2900100001)(54906003)(5640700003)(3280700002)(3660700001)(2906002)(6512007)(6486002)(25786009)(39060400002)(4326008)(107886003)(86612001)(6436002)(6346003)(8656006)(36756003)(52116002)(76176011)(105586002)(106356001)(5660300001)(6916009)(5250100002)(2501003)(97736004)(7736002)(68736007)(8676002)(81166006)(81156014)(10290500003)(8936002)(478600001)(86362001)(486006)(10090500001)(6116002)(476003)(2351001)(1730700003)(186003)(1076002)(305945005)(446003)(22452003)(46003)(2616005)(316002)(11346002)(14454004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: xxWoblN9uQaEvTDChjeZMh7wQnPdGs9B9EpYabyu5/a/UhKd8QTZMynqToyCoi+Pf2TTrbxodpVSlECzEHhd3Uydqpy3D0owsEMkl34kWTCpq/97s12OClK8rvuuVopuKwQrDIjp1yNtiafeYU//mFsZn/S28Txl13SQaeY1J/W0nWRNYRt2r71HJZBMP7QH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e3a624dc-b967-4bac-20cf-08d5af61a739
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a624dc-b967-4bac-20cf-08d5af61a739
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:47:09.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing commits to be written into a commit-graph file, compute
the generation numbers using a depth-first strategy.

The only commits that are walked in this depth-first search are those
without a precomputed generation number. Thus, computation time will be
relative to the number of new commits to the commit-graph file.

If a computed generation number would exceed GENERATION_NUMBER_MAX, then
use GENERATION_NUMBER_MAX instead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 9ad21c3ffb..36d765e10a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -439,6 +439,8 @@ static void write_graph_chunk_data(struct hashfile *f, =
int hash_len,
 		else
 			packedDate[0] =3D 0;
=20
+		packedDate[0] |=3D htonl((*list)->generation << 2);
+
 		packedDate[1] =3D htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
=20
@@ -571,6 +573,45 @@ static void close_reachable(struct packed_oid_list *oi=
ds)
 	}
 }
=20
+static void compute_generation_numbers(struct packed_commit_list* commits)
+{
+	int i;
+	struct commit_list *list =3D NULL;
+
+	for (i =3D 0; i < commits->nr; i++) {
+		if (commits->list[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
+		    commits->list[i]->generation !=3D GENERATION_NUMBER_ZERO)
+			continue;
+
+		commit_list_insert(commits->list[i], &list);
+		while (list) {
+			struct commit *current =3D list->item;
+			struct commit_list *parent;
+			int all_parents_computed =3D 1;
+			uint32_t max_generation =3D 0;
+
+			for (parent =3D current->parents; parent; parent =3D parent->next) {
+				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
+				    parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
+					all_parents_computed =3D 0;
+					commit_list_insert(parent->item, &list);
+					break;
+				} else if (parent->item->generation > max_generation) {
+					max_generation =3D parent->item->generation;
+				}
+			}
+
+			if (all_parents_computed) {
+				current->generation =3D max_generation + 1;
+				pop_commit(&list);
+
+				if (current->generation > GENERATION_NUMBER_MAX)
+					current->generation =3D GENERATION_NUMBER_MAX;
+			}
+		}
+	}
+}
+
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
@@ -694,6 +735,8 @@ void write_commit_graph(const char *obj_dir,
 	if (commits.nr >=3D GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
=20
+	compute_generation_numbers(&commits);
+
 	graph_name =3D get_commit_graph_filename(obj_dir);
 	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
=20
--=20
2.17.0.39.g685157f7fb

