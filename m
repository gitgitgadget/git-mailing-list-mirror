Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997E41F404
	for <e@80x24.org>; Wed, 12 Sep 2018 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeIMCcc (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 22:32:32 -0400
Received: from mail-eopbgr700114.outbound.protection.outlook.com ([40.107.70.114]:49033
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbeIMCcb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 22:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjTiNeuHv4gMas8MRx+02xsELaezff9O8Y8TsOvCPoQ=;
 b=IGM4j9xjGf06sdja0ep7W2e2H/HEECSe0TkCuXGfGR4Fkh9wo2Gi7S20ExOcHMUusVSEiehoL4PCcB5ESUl74WT7CtN0zLVSVM08AG6s4C0rl9K/ZRrCmRKAo5OH/qtN7XvK/7G/32zQfsNO+1qPQk4uRgt4DiKflSQyJ/K1zv4=
Received: from SN6PR2101MB0975.namprd21.prod.outlook.com (52.132.114.28) by
 SN6PR2101MB0975.namprd21.prod.outlook.com (52.132.114.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Wed, 12 Sep 2018 21:26:04 +0000
Received: from SN6PR2101MB0975.namprd21.prod.outlook.com
 ([fe80::c97:89e3:1852:eea3]) by SN6PR2101MB0975.namprd21.prod.outlook.com
 ([fe80::c97:89e3:1852:eea3%4]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 21:26:04 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
Thread-Topic: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
Thread-Index: AQHUSt82GlcEKCNxOEuO8+QdWTp+PA==
Date:   Wed, 12 Sep 2018 21:26:04 +0000
Message-ID: <20180912212544.33624-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: DM5PR1101CA0008.namprd11.prod.outlook.com
 (2603:10b6:4:4c::18) To SN6PR2101MB0975.namprd21.prod.outlook.com
 (2603:10b6:805:4::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0975;6:LEBPJ1A4+AwofnCsE5Mo0X9tXQKBPUfZyd4qm8BOC4dZkvb9xk1K/FrtmUtJiNJSNYR16TZXFH7lHyTLyt2qEooT6XW6shM4Rz9hjdIiAAF+iek60ZLWrgCGsNMLA2F6WEf1JtZD0ByZy4Edd78sup/zgqxudzi/ne7QwW1zhB0GcWEgKP0c1Wv1Z3FmGQHuVITsUkgBx7rGcDz4yRsyPnwyuoKfXItMuj2NmhAEHNZB/kxDsvmuKfyscRodkXE2NM3KTMU2cJf+v17ARmfNjtwhz4+ePyBFd+7jHCcCkdYNkUbOvMeO3IgQLCeD1kwUWQiMmu83IreiGz9EwDnS1tWTkRS71bEX9qC/3eGPvZ0xpo34qfeAvRreZVMc+VArHtawWEwRuygX68WHb1Hw+Ww9Dsx2me985GGH07I5UeRHomPvO3ifXAtmzX4HD7ZR39LCsFe2wTkrS6nhFq4sUQ==;5:lbDXRi8hPl1w23+Fb1qUz4Yvg2++ozRuCL8o1101S/v+eSOeAjv3b28HjWTifZfUlnAhjH/7bnklM+alpWYgJV33zQcRoQZvaqoWbDk8VSknOA44G4lwNYfV2hFuL23bXKxRsptVrDUyODjY7dzCPzm5SjRpCQGM7FtzC/gHXDY=;7:rzwR/JqJ+XwJmSzJM1KZy1VgtPSoXYf99QwWxIlPHjz+WgFYDjfvuPE1BhBzufAkzB9R7dMdKWxHfTfz0y7aZ+gGx3d9++IOA9LN10XRfeVHSOcQ9tMlCR4gPf5cdlMuw4uhuXhGJa4A8cAxaPTfc23LQS0tHlzA6DsoGQOTa1kYuwNFxCATX5LRBv1FfU9S74ERoVOQ2SrlopcDtcVhKNo81fGwxvD3GVvFnywXmYa8JkbBdSHP8fHjomP9Ymde
x-ms-office365-filtering-correlation-id: ea3bd3b6-e056-45d9-487f-08d618f65808
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0975;
x-ms-traffictypediagnostic: SN6PR2101MB0975:
x-microsoft-antispam-prvs: <SN6PR2101MB0975A66A609FA74336A2E095F41B0@SN6PR2101MB0975.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:SN6PR2101MB0975;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0975;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(22452003)(966005)(14454004)(66066001)(486006)(97736004)(52116002)(26005)(81166006)(10290500003)(99286004)(6346003)(3846002)(102836004)(6116002)(1076002)(256004)(72206003)(14444005)(478600001)(1730700003)(186003)(81156014)(8676002)(8936002)(575784001)(86612001)(5250100002)(53936002)(25786009)(386003)(36756003)(2501003)(6506007)(106356001)(50226002)(105586002)(5660300001)(2906002)(6512007)(54906003)(68736007)(107886003)(10090500001)(5640700003)(6486002)(6306002)(4326008)(316002)(6916009)(6436002)(2351001)(7736002)(305945005)(2900100001)(2616005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0975;H:SN6PR2101MB0975.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: 5HDHOfVGaizOT3Vlhwe+Ce7QvHuUXqcVrrbdLthLObnmQWXkl482bbNUNfMWrvTQOH2PimS0m+Pnc7w2S9w5sFhgk+puRNJ6JZK+lCXvLrnuFLK5DfTronLx6Zqwp+cDDM6LLXek7OQ4WyLAmAS3OY1AdU66h9xeXzbBtuBtLpij+vniyQeSIDxRsc7aiBSZLWzDjC3PccDp36Ouox47AKpifgVmSDlabQZGS7WnLAgxKZJSvvYr8aqAmSyI/f8r5mFqLwAGPJ0bzmbb041+Ywl4zIgFG0KXSqQT2bpWxF0imamIUgBLChyuUUUjgD7as4QYyppvny2gFsg7wvU87ITqTWSmPnsKIRXpYSbwKCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3bd3b6-e056-45d9-487f-08d618f65808
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 21:26:04.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach get_index_format_default() to support running the test suite
with specific index versions.  In particular, this enables the test suite
to be run using index version 4 which is not the default so gets less testi=
ng.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: v2.19.0
    Web-Diff: https://github.com/benpeart/git/commit/52e733e2ce
    Checkout: git fetch https://github.com/benpeart/git git-test-index-vers=
ion-v1 && git checkout 52e733e2ce

 read-cache.c | 47 +++++++++++++++++++++++++++++++++--------------
 t/README     |  6 +++++-
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..d140ce9989 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1570,26 +1570,45 @@ static unsigned int get_index_format_default(void)
 	char *envversion =3D getenv("GIT_INDEX_VERSION");
 	char *endp;
 	int value;
-	unsigned int version =3D INDEX_FORMAT_DEFAULT;
+	unsigned int version =3D -1;
+
+	if (envversion) {
+		version =3D strtoul(envversion, &endp, 10);
+		if (*endp ||
+			version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
+			warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
+				"Using version %i"), INDEX_FORMAT_DEFAULT);
+			version =3D INDEX_FORMAT_DEFAULT;
+		}
+	}
=20
-	if (!envversion) {
-		if (!git_config_get_int("index.version", &value))
+	if (version =3D=3D -1) {
+		if (!git_config_get_int("index.version", &value)) {
 			version =3D value;
-		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
-			warning(_("index.version set, but the value is invalid.\n"
-				  "Using version %i"), INDEX_FORMAT_DEFAULT);
-			return INDEX_FORMAT_DEFAULT;
+			if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
+				warning(_("index.version set, but the value is invalid.\n"
+					"Using version %i"), INDEX_FORMAT_DEFAULT);
+				version =3D INDEX_FORMAT_DEFAULT;
+			}
 		}
-		return version;
 	}
=20
-	version =3D strtoul(envversion, &endp, 10);
-	if (*endp ||
-	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
-		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
-			  "Using version %i"), INDEX_FORMAT_DEFAULT);
-		version =3D INDEX_FORMAT_DEFAULT;
+	if (version =3D=3D -1) {
+		envversion =3D getenv("GIT_TEST_INDEX_VERSION");
+		if (envversion) {
+			version =3D strtoul(envversion, &endp, 10);
+			if (*endp ||
+				version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
+				warning(_("GIT_TEST_INDEX_VERSION set, but the value is invalid.\n"
+					"Using version %i"), INDEX_FORMAT_DEFAULT);
+				version =3D INDEX_FORMAT_DEFAULT;
+			}
+		}
 	}
+
+	if (version =3D=3D -1)
+		version =3D INDEX_FORMAT_DEFAULT;
+
 	return version;
 }
=20
diff --git a/t/README b/t/README
index 9028b47d92..f872638a78 100644
--- a/t/README
+++ b/t/README
@@ -315,10 +315,14 @@ packs on demand. This normally only happens when the =
object size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
=20
-GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pack-objects code
+GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncommon pack-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
+GIT_TEST_INDEX_VERSION=3D<n> exercises the index read/write code path
+for the index version specified.  Can be set to any valid version
+but the non-default version 4 is probably the most beneficial.
+
 Naming Tests
 ------------
=20

base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1

