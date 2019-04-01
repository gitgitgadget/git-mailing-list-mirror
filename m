Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA4E20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfDASCn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:43 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:15392
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730977AbfDASCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q25gsNN9/l2J5A1CKUHpx3C5mUfKkaMOPUZvbGFYSWM=;
 b=jv8jzSykgOfFGt6pU75NOtK7HvMKMLHEHWF+TTxNJqLOe1HAT4fMM7Vk0w8sCQ0MRlEptvrJ3P9EC1soU1zVyaIYnt5dc3IbpGsrzdbTsdXSAkmwbh/e4hALBzW2SlWv8zf2xk/OPyzBL9bTP9nXTFxgTUIBNsji0IOdOiemwKA=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5465.namprd08.prod.outlook.com (20.178.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:02:38 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:38 +0000
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
Subject: [PATCH v3 8/8] git-p4: respect excluded paths when detecting branches
Thread-Topic: [PATCH v3 8/8] git-p4: respect excluded paths when detecting
 branches
Thread-Index: AQHU6LUXzs31Ol25DkaeHUlhE2qkGg==
Date:   Mon, 1 Apr 2019 18:02:38 +0000
Message-ID: <6d3ffb98a7c94f664acc1bd29a429c006d77a30c.1554141338.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 85b253bc-3680-4c56-1120-08d6b6cc3a2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5465;
x-ms-traffictypediagnostic: DM6PR08MB5465:
x-microsoft-antispam-prvs: <DM6PR08MB54653BE520B86FD5EF5FA132DA550@DM6PR08MB5465.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(105586002)(81156014)(2351001)(446003)(36756003)(76176011)(6916009)(11346002)(71190400001)(305945005)(4326008)(102836004)(478600001)(50226002)(7736002)(25786009)(6116002)(5660300002)(14454004)(2906002)(256004)(14444005)(3846002)(6436002)(1730700003)(53936002)(6512007)(26005)(5640700003)(71200400001)(66066001)(7416002)(186003)(6486002)(97736004)(86362001)(2501003)(81166006)(99286004)(316002)(6506007)(386003)(8676002)(54906003)(8936002)(486006)(68736007)(52116002)(2616005)(118296001)(476003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5465;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pg08QWsMvhC/mfXfQW2xUJIB9kzVv2s9uMFZgTL7FqCaWXEWac4QOd7xIzHslRbqPsSI2btSMRTYBrpRSxWH71H6qcqLfJhX7/lvQbvPuwKJRlDNIcODuLNHyKX5RkAuj0RuS6NfYhquXaJ4yx9hDy4Sr1srQKKNYWLjV6/jkWpzKdDpX2B8A2i3FZfnhaeiAr0LNdPwMZLbmSxmStUME0BKrZxffawmWWHXs1LgorpRBcWgs/HUzG6gyneaNMBICD1o+mkPHQ2xg6NqQi50Cxlh0zhC0f414sMivudEUu+vYqsJKfdDr08uKNx28Hpa8nOXNTdn8WV1diVCz6RrT5Io5v4tKl2wfSIxAeBgab6I45q+2GZ/6jDIqjfqGVczDC18H2tVDz6Pl3pAZKGdoeQS6DqkGJKPOejSRJgbeOQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b253bc-3680-4c56-1120-08d6b6cc3a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:38.7190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, excluded paths are only handled in the following cases:
 * no branch detection;
 * branch detection with using clientspec.

However, excluded paths are not respected in case of
branch detection without using clientspec.

Fix this by consulting the list of excluded paths
when splitting files across branches.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py                | 3 +--
 t/t9801-git-p4-branch.sh | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c47bd8c4d8..96c4b78dc7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2708,12 +2708,11 @@ def splitFilesIntoBranches(self, commit):
=20
         branches =3D {}
         fnum =3D 0
         while "depotFile%s" % fnum in commit:
             path =3D  commit["depotFile%s" % fnum]
-            found =3D [p for p in self.depotPaths
-                     if p4PathStartsWith(path, p)]
+            found =3D self.isPathWanted(path)
             if not found:
                 fnum =3D fnum + 1
                 continue
=20
             file =3D {}
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 7530d22de2..9654362052 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -410,11 +410,11 @@ test_expect_failure 'git p4 clone file subset branch'=
 '
 		test_path_is_missing file3
 	)
 '
=20
 # Check that excluded files are omitted during import
-test_expect_failure 'git p4 clone complex branches with excluded files' '
+test_expect_success 'git p4 clone complex branches with excluded files' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
 		cd "$git" &&
 		git config git-p4.branchList branch1:branch2 &&
--=20
2.19.2

