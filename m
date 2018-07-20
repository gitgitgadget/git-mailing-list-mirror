Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB1E1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbeGTRWg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:36 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:31488
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731000AbeGTRWf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4SGTV+MuFYmLEp2ba75edFJGt6b6D64R6aat3XBgLE=;
 b=gC35DXxpW/jMU2xeMYa7z6vGlcQojV3j2w8DEbOZsZNBuV5ZUTVbtI3B0LAIrExpmSM8e7vBM8JC71nI0kn8lj3JN2Ju5UqJBgeg69Phzzsi0r20o825ScwgYp9jF30XWoU1baA6X3Q8P47PRQ37TDxjrVK40aHIllTP+MVzrI0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:18 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 11/18] test-reach: test is_descendant_of
Thread-Topic: [PATCH v2 11/18] test-reach: test is_descendant_of
Thread-Index: AQHUIEddWUgAqfhBK062YcsDkf1S0g==
Date:   Fri, 20 Jul 2018 16:33:18 +0000
Message-ID: <20180720163227.105950-12-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:nw+3qlK44Uo3mmXo6ZMkyEgKz8qRq5WJ7k0O3N8dSb2SoPvzqfjclRSJUrArcuxSvMbhowwxA2h8k1GO1riHogPrLo2lUhmKPBWR1CnnyGYiPj57ymZMK5+U7aj/yjOQEydMb7YPwUwupftBBeLWaB1E6go09p9iWWQ0reHg29I38JRBsku45q6RA7DGMukw4EVSt6drPNRRJZFrDBzoYiRjthuh3ly5gwcOKCkxm/Ue7d1hWETZ8fSUXtx5XIDbhB9dmF5EOsrfLkdVwAOKnI6SwJqd/Jb2WLVBqNTxwJdpFER3VMgYFvSL8xbt+BJjtU4KaQwwcc3F9kAF8F8r9ynO9597spsas/dQK7QsFJDC/8i81PLY94wiu8GxkrUAgCdmWQQqGirWrQUqarApKbECWINjePy4RazWq8mt/SCMwS/syVvIl9/EpqKD49q/Sdi3DLky/XVDp/UTNUfFug==;5:w9WIV4o7nDrSkgzKmdjqqHxlFcUjc0NUtx4MYhHwzaT0tGGYkdbYPTm2zsvSNcFVjenKm4l56xq8yzNOVUa46tQSvsepQhGaZe/K/8s/auMLkRXIkkuFV97meFnsUWbqHar/c+dwYlnRcUwWaiwQ/tD+hf8Mwcf3ab2zPqpIKtY=;7:rHrHHEa/3Gf/YvU8KDqURqt0xL1t5nRW3Tyt6YdSvTMUBOGFt1WHdkFacYGmjGJHoMcYS3fbhnHZN4tRT59vVk7pqoQiIqfSfLM2xO6EsUPkeRpoTn3Ud742/gk5EW5tHxZ+h53jdoDnOU8mQAOb9JOkZFDzTCPPYGGOosTOGnX6rgm/R/hRaKKZ9vbZhbyoZ8OGiVMvrT+hd3i0oKlIQKZpqpOU5BscfxUNINbDbbew1G7YiX58oQqj6/Flu5lZ
x-ms-office365-filtering-correlation-id: 03c08e90-c3b4-4caf-01b1-08d5ee5e7ffe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929BB85A89D13168469B8FAA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: keV2V/BxjfsfMV7gGWhF7NmLD6x38/MIorkI8x45v769pBbjsGbLtqzNNXICFZBOBdQdVJb0xiFGZn4Scy8ry99cvhVZH8XH0mYG2RTmkandkJ60+1Nkq76T9/hPBPOU7O2oL/sIQCp7WWkoK/GDwPlgAZ1zUKhu/lrNQrEo3GD96gRvuyERovHLBdTh7lFrIuBrNEF/VZFvKrs95xutcpSE9MsTDVlJYwLLYIRjia75j+JRoFnDQX7e427X+4UUlBz68g9BTwLSNvCdBukPN7rgaAwbPaY4WkH2SNqk0C9ruCdDcGy9c3HMa/yhd1xj4bKb40oknvexuS8sT79INIV9bqv+v0CfsQYxAoMwn64=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c08e90-c3b4-4caf-01b1-08d5ee5e7ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:18.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_descendant_of method takes a single commit as its first parameter
and a list of commits as its second parameter. Extend the input of the
'test-tool reach' command to take multiple lines of the form
"X:<committish>" to construct a list of commits. Pass these to
is_descendant_of and create tests that check each result.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c |  8 ++++++++
 t/t6600-test-reach.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index f93ad5084d..dccbd48178 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -10,6 +10,7 @@ int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
+	struct commit_list *X;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct repository *r =3D the_repository;
=20
@@ -19,6 +20,7 @@ int cmd__reach(int ac, const char **av)
 		exit(1);
=20
 	A =3D B =3D NULL;
+	X =3D NULL;
=20
 	while (strbuf_getline(&buf, stdin) !=3D EOF) {
 		struct object_id oid;
@@ -54,6 +56,10 @@ int cmd__reach(int ac, const char **av)
 				B =3D c;
 				break;
=20
+			case 'X':
+				commit_list_insert(c, &X);
+				break;
+
 			default:
 				die("unexpected start of line: %c", buf.buf[0]);
 		}
@@ -64,6 +70,8 @@ int cmd__reach(int ac, const char **av)
 		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_bases"))
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
+	else if (!strcmp(av[1], "is_descendant_of"))
+		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
=20
 	exit(0);
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 5cd6b14c69..98bcb17960 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -101,4 +101,26 @@ test_expect_success 'in_merge_bases:miss' '
 	test_three_modes in_merge_bases
 '
=20
+test_expect_success 'is_descendant_of:hit' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-1-1
+	EOF
+	echo "is_descendant_of(A,X):1" >expect &&
+	test_three_modes is_descendant_of
+'
+
+test_expect_success 'is_descendant_of:miss' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-5-9
+	X:commit-4-10
+	X:commit-7-6
+	EOF
+	echo "is_descendant_of(A,X):0" >expect &&
+	test_three_modes is_descendant_of
+'
+
 test_done
--=20
2.18.0.118.gd4f65b8d14

