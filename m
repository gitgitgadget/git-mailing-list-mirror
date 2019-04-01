Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCEC20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfDASCg (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:36 -0400
Received: from mail-eopbgr790099.outbound.protection.outlook.com ([40.107.79.99]:44704
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730870AbfDASCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYS71XeoDaWAZXGpQQV29M+IKlqtdU6YHO8XpRABOsw=;
 b=WPPbODBd0vTwEZtJyY43kGERaFaEgVhENMQBnKDOzDUPe6NX2Q8PU92/NxzC2/1Yzc/ktnLDNhHwvjf/8HP1Hoqgb46qcydTsQh124Q6n+0ykuqoI0Pbj5NRZLUjaGB1xUI8R5t+xBCVHNntkKDxRQ943S3OsXhytT3tix+8AfM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5465.namprd08.prod.outlook.com (20.178.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:02:29 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:29 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] git-p4: add failing test for "don't exclude other
 files with same prefix"
Thread-Topic: [PATCH v3 5/8] git-p4: add failing test for "don't exclude other
 files with same prefix"
Thread-Index: AQHU6LUS+SqAQ0SJYEq8tvgIcCeqUA==
Date:   Mon, 1 Apr 2019 18:02:29 +0000
Message-ID: <b65796715480f0a859707e1bafb749a60ffb9d1d.1554141338.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
 <cover.1554141338.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554141338.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:405:14::30) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6afa8e-9d1e-48bf-adfa-08d6b6cc34cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5465;
x-ms-traffictypediagnostic: DM6PR08MB5465:
x-microsoft-antispam-prvs: <DM6PR08MB5465B34D152AC258595D3007DA550@DM6PR08MB5465.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(105586002)(81156014)(2351001)(446003)(36756003)(76176011)(6916009)(11346002)(71190400001)(305945005)(4326008)(102836004)(478600001)(50226002)(7736002)(25786009)(6116002)(5660300002)(14454004)(2906002)(256004)(14444005)(3846002)(6436002)(1730700003)(53936002)(6512007)(26005)(5640700003)(71200400001)(66066001)(7416002)(186003)(6486002)(97736004)(86362001)(2501003)(81166006)(99286004)(316002)(6506007)(386003)(8676002)(54906003)(8936002)(486006)(68736007)(52116002)(2616005)(118296001)(476003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5465;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WAJLnZXdlAdt9l5KQRqu/lZsWmz7e8psN8Lc2oLVN/Eyn3gjLWtLJgbOgTyLpXEguA/raEpk64vNNdRehlYkIIb1aKL8YVhnX546o2dhgpdWW1SgkyqmcOTy+2awNSRQKegl/d0V6XSBKK8NkrswDTNi57PMtu3W3mTKeCoyW5tsNjyVrV5SoBc9mk4/5JoX58RMwbRoLam34ekRiH4EG7o11+SyFHQzx/lqUhHOnh5BuDkK9Cprvi7s0kcXfaJhQDulqX98Da9MenrONV6lLAWTRRCE/zfxmyoqMwyBsd2qrVSOx4DoyaS8QQIPKnXpq3NN58Ky7PYDhvutXPuAh+qdqwdfwTC4cpxBIV6emCLf8ztNa/TC0CuibL+V9lp2VkWbOYFg14arAH/lcqWu3ZmvXmnpma+bbzXS5F+Y2kE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6afa8e-9d1e-48bf-adfa-08d6b6cc34cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:29.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a fix, add a failing test case to test that
git-p4 doesn't exclude files with the same prefix unintentionally
when exclude paths are specified without a trailing /.
I.e., don't exclude "//depot/file_dont_exclude" if run with "-//depot/file"=
.
or don't exclude "//depot/discard_file_not" if run with "-//depot/discard_f=
ile".

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 t/t9817-git-p4-exclude.sh | 51 +++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index aac568eadf..1c22570797 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -20,49 +20,90 @@ test_expect_success 'create exclude repo' '
 	(
 		cd "$cli" &&
 		mkdir -p wanted discard &&
 		echo wanted >wanted/foo &&
 		echo discard >discard/foo &&
-		p4 add wanted/foo discard/foo &&
+		echo discard_file >discard_file &&
+		echo discard_file_not >discard_file_not &&
+		p4 add wanted/foo discard/foo discard_file discard_file_not &&
 		p4 submit -d "initial revision"
 	)
 '
=20
 test_expect_success 'check the repo was created correctly' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$git" &&
 		test_path_is_file wanted/foo &&
-		test_path_is_file discard/foo
+		test_path_is_file discard/foo &&
+		test_path_is_file discard_file &&
+		test_path_is_file discard_file_not
 	)
 '
=20
 test_expect_success 'clone, excluding part of repo' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard/... --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$git" &&
 		test_path_is_file wanted/foo &&
-		test_path_is_missing discard/foo
+		test_path_is_missing discard/foo &&
+		test_path_is_file discard_file &&
+		test_path_is_file discard_file_not
+	)
+'
+
+test_expect_failure 'clone, excluding single file, no trailing /' '
+	test_when_finished cleanup_git &&
+	git p4 clone -//depot/discard_file --dest=3D"$git" //depot/...@all &&
+	(
+		cd "$git" &&
+		test_path_is_file wanted/foo &&
+		test_path_is_file discard/foo &&
+		test_path_is_missing discard_file &&
+		test_path_is_file discard_file_not
 	)
 '
=20
 test_expect_success 'clone, then sync with exclude' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard/... --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$cli" &&
-		p4 edit wanted/foo discard/foo &&
+		p4 edit wanted/foo discard/foo discard_file_not &&
 		date >>wanted/foo &&
 		date >>discard/foo &&
+		date >>discard_file_not &&
 		p4 submit -d "updating" &&
=20
 		cd "$git" &&
 		git p4 sync -//depot/discard/... &&
 		test_path_is_file wanted/foo &&
-		test_path_is_missing discard/foo
+		test_path_is_missing discard/foo &&
+		test_path_is_file discard_file &&
+		test_path_is_file discard_file_not
+	)
+'
+
+test_expect_failure 'clone, then sync with exclude, no trailing /' '
+	test_when_finished cleanup_git &&
+	git p4 clone -//depot/discard/... -//depot/discard_file --dest=3D"$git" /=
/depot/...@all &&
+	(
+		cd "$cli" &&
+		p4 edit wanted/foo discard/foo discard_file_not &&
+		date >>wanted/foo &&
+		date >>discard/foo &&
+		date >>discard_file_not &&
+		p4 submit -d "updating" &&
+
+		cd "$git" &&
+		git p4 sync -//depot/discard/... -//depot/discard_file &&
+		test_path_is_file wanted/foo &&
+		test_path_is_missing discard/foo &&
+		test_path_is_missing discard_file &&
+		test_path_is_file discard_file_not
 	)
 '
=20
 test_expect_success 'kill p4d' '
 	kill_p4d
--=20
2.19.2

