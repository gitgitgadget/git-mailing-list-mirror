Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8D720248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCUWdn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:33:43 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:2850
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbfCUWdm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qafieZikvoznm5Z6VSOif/gKBU3KaMTwQzo7HdAT8Ks=;
 b=oyqn7Y957KWdII3VxlicdA1SPwMSEQL3OqS9Z2xKmdRqzCbOUF/6k5QO4f32b0IEtCCWEJorXowPh7sWU8yniY935GuChhVsPdBZ3j2Pkb2R8a/DJVWzrpXp6lRmqhsBBQxfl9N5Iiu771VpVmSPRX+YYhGOE2qBgWBfGpSNk60=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4251.namprd08.prod.outlook.com (20.176.82.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 22:33:11 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:33:11 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH v2 7/7] git-p4: respect excluded paths when detecting branches
Thread-Topic: [PATCH v2 7/7] git-p4: respect excluded paths when detecting
 branches
Thread-Index: AQHU4DYOWQvMGicNzEKZgMjiTfLXGA==
Date:   Thu, 21 Mar 2019 22:33:07 +0000
Message-ID: <758d8e84868edc4b53c382a74655048d69d187de.1553207234.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553207234.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:400::33)
 To DM6PR08MB4956.namprd08.prod.outlook.com (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6853f18-cb22-4383-28bc-08d6ae4d3083
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4251;
x-ms-traffictypediagnostic: DM6PR08MB4251:
x-microsoft-antispam-prvs: <DM6PR08MB425121FA04E5DB168DBAC1E0DA420@DM6PR08MB4251.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(14444005)(6666004)(6436002)(5640700003)(53936002)(36756003)(76176011)(386003)(486006)(446003)(6506007)(8676002)(68736007)(2501003)(97736004)(305945005)(256004)(25786009)(186003)(478600001)(476003)(86362001)(6512007)(71200400001)(4326008)(7416002)(6916009)(2616005)(11346002)(6486002)(102836004)(118296001)(3846002)(6116002)(26005)(7736002)(66066001)(50226002)(316002)(99286004)(14454004)(54906003)(2906002)(106356001)(81156014)(5660300002)(52116002)(71190400001)(1730700003)(81166006)(2351001)(8936002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4251;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 82jwscr6OVVdrBEF26cEGTW8+8tQS1JuPMTzk28fPSN9oDxG5oC6D0JpPA19zbPGjkCayloQjc8D0BHLjw1QTc4uye4ErTTeKvxfoPh+IQKfLE8stvtOBsZUAwro27CQwexnGHLRqBPp8yjxZkRcnkHNuhXgKPENHosULNz+M6Enb/MoW/TzqjzgJ4iwd8WKEP7yz23FMT4IYjkg6Y6bAuQ87GbKSYT6Su2xdqlIFD4Fz/nczklvp0kpRh12WaBdlxNz7XzyonGFs/y081/S6Vl3F4Cjm361H8kH/vkw7ZiywGBEQhTFEG/zOo8Zel4BgaeLJOnqcFVQpcyvg5q4LyMM6/fU29y/hdefI4yw1HmKKlz/oD1xXDWSbFUYSQvi1Fpt/prsIofGm1VAAYRxpsuUmHpVx4d5VKGB12goPeo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6853f18-cb22-4383-28bc-08d6ae4d3083
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:33:07.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4251
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
index 162877aa82..148ea6f1b0 100755
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
index 4729f470b2..62a3929d8e 100755
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

