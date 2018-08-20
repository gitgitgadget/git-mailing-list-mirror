Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9651F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeHTUIi (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:38 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:59456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbeHTUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrPoa2g8acv1WQ/PrU6sJZ4ejYV6lmTW0D170WU0pco=;
 b=eQY/Kg6htu6LUDQ+E/Peu0oY5EVatLaF4lifIb426A67e4d7ynr10UGQD3ylh3DQr+4mLr0/UFmnhmliTMu2KU22x2m1akMpFP8k+17TiidQmaPVzZcgus2zbdDtXYTxFCbA4XOcKj50/uUJ8+W4WrzAGH2/WBiAwFA6GACiwkM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:52:06 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:52:06 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 8/9] midx: test a few commands that use get_all_packs
Thread-Topic: [PATCH 8/9] midx: test a few commands that use get_all_packs
Thread-Index: AQHUOKYgZWSK/gygOkWiJtkMnWNYbg==
Date:   Mon, 20 Aug 2018 16:52:06 +0000
Message-ID: <20180820165124.152146-9-dstolee@microsoft.com>
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:ZDzwyVEhgRlSWxUfLYgWDqTpNypuJKjgzY0++GI9EpDen1OmuWRohnbKgJA/ALVltah2C3AtjQx/rGDXBv8aE7qhSYFk4kU6laOe0VZk22k+uJrCYRn2J6yjOAZtMskQkg8a2nCeZ5LQETspNoCfyjwOZaI2pJBM8hnxmvrUtda38WSmHh1w0EvIri6MxVllLcSb3zHiTxqKQTOzU2GXXHx1+OtO/K8CodhnFJdvb7zTs3p0MQi74IAtpmxOAOtWg4J2b39lQeketyRfiXzxDQ6wRCZjj0dKagt59mQR0SU2krkG2lwUXaoAKIY9FJmDMqaFxASuubQ9wwGqZ5Pv+YB8kDGbOtzNqDpUXZbF9VFHLtLptkjgikVFLQp02VS43errfmdEikVgs9Pn+YQlGKwaFBmDzzD00Rm/8EGrQH/UfE2o1J7sjxm4SeoYJTqachjElrde9Vtqkgtt3pX5fQ==;5:q/+y1o87OBG870bFtHKhcpeyJ0BivWzWw5sPMJfEjHYm1A7jWwvUZ8ur54xTq8YE4l/3mQuGPKwFjcyD+qLWgsLv/3QUr1LCZ73BgLyrnWLbTqSFdAbx0GMBLyPe51vDbmO4QEpqDctrHrblnC9S3xNhGfroJVc4TDB5mO4U4X8=;7:pNe79GDXCZWC+WikzVpSWoG83OxHxYynclyVGEynhm1gW7qBPP8uYPRO9FkL8FV2MKmEBcPgwwyIvZVQnmzVgpeEPueGwVaRFIxyCmLSGt9rBeXQq3orr5b/uUQVPpmaLB3K91bJOAfrTR+oKA0yCpChk/yxHLx8GBMQCyfthGM3BI6xJrzN/JTaaRigCgm0u1/NJll5g7fzDDwQXFIxXIOBDFpAmjt1ikq9KHOap0TGdFRmrZ0SU/J9Bt7PAT+F
x-ms-office365-filtering-correlation-id: 72fab774-e93c-4035-b63c-08d606bd42c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB0962C4C9D5F9BAA0D8EE58A2A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(575784001)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: jwgJsARZI/I/RSVGEwwuQuO599TVyg/CDAIJnVL1zP+kVfrDILUParsPOuMDmw5CJtnVF4Cs3NKXbraV/JEY+k2sQpLM2KUil2h2aSI0ANaqTLZtJVlMpD71ZfmDFkJzHmBjvnkiHakGAP/C32vfEC2Gh4t3i4+bHt2nhycAc25XghkSvbwYg67W0WSRMzTZtpba8sV4synDQz/Cr3l4jR5sJeEfv1mJLPOgNSIVbQKoQQQX6QbdSG0AKXs3glYS/2VUb1Kxe5tzw7j4TvlNUQQykMiOLlDOf7MuVcxJhq3RaoiCCjjwtV4ebzsfpF5IVFeFuGKGxAQ+UIADj2fHL+o/wVzdUsTephVQmP64ixY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fab774-e93c-4035-b63c-08d606bd42c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:52:06.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new get_all_packs() method exposed the packfiles coverede by
a multi-pack-index. Before, the 'git cat-file --batch' and
'git count-objects' commands would skip objects in an environment
with a multi-pack-index.

Further, a reachability bitmap would be ignored if its pack-file
was covered by a multi-pack-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 4b6e2825a6..424d0c640f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -86,8 +86,14 @@ test_expect_success 'write midx with one v1 pack' '
 '
=20
 midx_git_two_modes () {
-	git -c core.multiPackIndex=3Dfalse $1 >expect &&
-	git -c core.multiPackIndex=3Dtrue $1 >actual &&
+	if [ "$2" =3D "sorted" ]
+	then
+		git -c core.multiPackIndex=3Dfalse $1 | sort >expect &&
+		git -c core.multiPackIndex=3Dtrue $1 | sort >actual
+	else
+		git -c core.multiPackIndex=3Dfalse $1 >expect &&
+		git -c core.multiPackIndex=3Dtrue $1 >actual
+	fi &&
 	test_cmp expect actual
 }
=20
@@ -95,7 +101,10 @@ compare_results_with_midx () {
 	MSG=3D$1
 	test_expect_success "check normal git operations: $MSG" '
 		midx_git_two_modes "rev-list --objects --all" &&
-		midx_git_two_modes "log --raw"
+		midx_git_two_modes "log --raw" &&
+		midx_git_two_modes "count-objects --verbose" &&
+		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check"=
 &&
+		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check =
--unsorted" sorted
 	'
 }
=20
@@ -149,6 +158,12 @@ test_expect_success 'repack removes multi-pack-index' =
'
=20
 compare_results_with_midx "after repack"
=20
+test_expect_success 'multi-pack-index and pack-bitmap' '
+	git -c repack.writeBitmaps=3Dtrue repack -ad &&
+	git multi-pack-index write &&
+	git rev-list --test-bitmap HEAD
+'
+
 test_expect_success 'multi-pack-index and alternates' '
 	git init --bare alt.git &&
 	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
--=20
2.18.0.118.gd4f65b8d14

