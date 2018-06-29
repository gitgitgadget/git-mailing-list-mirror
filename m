Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DDE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966907AbeF2QNE (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:04 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:13680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966887AbeF2QNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aARXFK7eboBXPo3w4LGA3HnX/1K4MVEPsnr4A8O/azw=;
 b=Wp7wWpTAKsObrCy2eoIFwgAyBFI0jPK+Mdpb3Y/kchLmtjuydyN9BsmWKBJu1K1h4QZMlmBxCv+GjlH6FTbDyux89y/IFC5Y6smVvF+PBlEwvsjx/9OSaYkSElEg9UgPBbzzz7D80vCsNQ27VPMWiq8NEv71LHNA6lfSLN9GvTI=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:59 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:59 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 10/13] commit-reach: test is_descendant_of
Thread-Topic: [RFC PATCH 10/13] commit-reach: test is_descendant_of
Thread-Index: AQHUD8QLTuAXrAiRYEibLfZNRG4beQ==
Date:   Fri, 29 Jun 2018 16:12:58 +0000
Message-ID: <20180629161223.229661-11-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:OckR5BPklHS6pfZXKd+uZbAyKYCSla4loq8sdJenf89+mYisBloCR5AYGV9Mc8uN2tITI1a8z8eLlIzm2mibPhN1MHov8fds8gp5SOVS5oarAE+rrk6YQ+o0Z3eb6kFZDIB8CFmVB+ecko/ixNV4HaMiTexgF/iXYa4NFCKr5ByDq5LRXGTLhwB6MPWsLUiwqIQjabedyOVeyj4oNcMJ0bu1Bk3ens3Rat7MAY0mXBqTIUc1pGulIImGVEjh/PMC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a906507-26f0-4ac2-da06-08d5dddb2e4d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB10448894860089B285D17466A14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 8DZxgrH541nKpPXF7JtvDWRRo+PWiNQ5gyt4uIG2r8fa9K5rXJoZ3z19RDzoKlaTlMke9/nbXSeoKcT9cg13ydA2t8/vrrNywy/YBeaHROZK6221aMELMMyJaqimFSXZX+eTtmRf2G7sZzH1NGMBMeYZ6L5DFdaRYLbStv8hD+CxCtrkN0G0GEaGwM29EKFvTntYwHOK69Fs+yozD3DtTDCRAPFuG4lv4Ygh4srowOyz9psxT5CCoR7dR9wlKJEhD8kU5cVTskch/qk9ojgzaOeKqif6q+rU78I/WiMw21Q6I8CN5ibJDAKgyUzMofAiNx28PcxirNrdT8773VxWLCfaZpcuxoM368rY9RhobvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a906507-26f0-4ac2-da06-08d5dddb2e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:59.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c |  2 ++
 t/t6600-test-reach.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 88639a2945..14aaef5bff 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -89,6 +89,8 @@ int cmd__reach(int ac, const char **av)
 		printf("%s:%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_base"))
 		printf("%s:%d\n", av[1], in_merge_bases(A, B));
+	else if (!strcmp(av[1], "is_descendant_of"))
+		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, list_X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
 		struct commit_list *list =3D get_merge_bases_many(A, nr_X, X);
 		printf("%s(A,X):\n", av[1]);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index ef25e70174..62655ae650 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -78,6 +78,31 @@ test_expect_success 'ref_newer:miss' '
 	test_reach_two_modes ref_newer
 '
=20
+test_expect_success 'is_descendant_of:hit' '
+	cat >input <<- EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-1-1
+	EOF
+	cat >expect <<- EOF &&
+	is_descendant_of(A,X):1
+	EOF
+	test_reach_two_modes is_descendant_of
+'
+
+test_expect_success 'is_descendant_of:miss' '
+	cat >input <<- EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-6-6
+	EOF
+	cat >expect <<- EOF &&
+	is_descendant_of(A,X):0
+	EOF
+	test_reach_two_modes is_descendant_of
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<- EOF &&
 	X:commit-1-10
--=20
2.18.0.118.gd4f65b8d14

