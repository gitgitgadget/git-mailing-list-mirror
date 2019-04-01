Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58EF20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfDASCh (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:37 -0400
Received: from mail-eopbgr790113.outbound.protection.outlook.com ([40.107.79.113]:6848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbfDASCf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIvMw9O2+eRmUr65gU7GU4/HVjN8CnqIaf+WgPFnx/Y=;
 b=jPMaTI/zp8Nci4Ew94fTwxVUXxSXyd50XRdfnhyQ6HjQnpb7chiwE1n/ilal6PA2vid0kBUZBncGitVIY9cuk0gEpa2YnEb6thhpRzi7czYxgwuPedUPZkJQjCZqjRDQM9Kp52Knz7jYhih5G8e3B0iHSxMkm6lHLnkgmRazqQA=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5465.namprd08.prod.outlook.com (20.178.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:02:33 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:33 +0000
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
Subject: [PATCH v3 6/8] git-p4: don't exclude other files with same prefix
Thread-Topic: [PATCH v3 6/8] git-p4: don't exclude other files with same
 prefix
Thread-Index: AQHU6LUUUj4UZiRwYE2lNSWZ7nIpjA==
Date:   Mon, 1 Apr 2019 18:02:32 +0000
Message-ID: <035abfff2a20516bc13f6b2e219ff158490ceced.1554141338.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 7df728bc-6ca2-477e-d907-08d6b6cc36b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5465;
x-ms-traffictypediagnostic: DM6PR08MB5465:
x-microsoft-antispam-prvs: <DM6PR08MB5465BD4AC89359EB8F273B20DA550@DM6PR08MB5465.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(105586002)(81156014)(2351001)(446003)(36756003)(76176011)(6916009)(11346002)(71190400001)(305945005)(4326008)(102836004)(478600001)(50226002)(7736002)(25786009)(6116002)(5660300002)(14454004)(2906002)(256004)(14444005)(3846002)(6436002)(1730700003)(53936002)(6512007)(26005)(5640700003)(71200400001)(66066001)(7416002)(186003)(6486002)(97736004)(86362001)(2501003)(81166006)(99286004)(316002)(6506007)(386003)(8676002)(54906003)(8936002)(486006)(68736007)(52116002)(2616005)(118296001)(476003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5465;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: COtB8Vcuj1s/hbC7UqV1bs8ANlJCmBxU6p5A7FUUR5/xC0Tu2j2XfAIvPC34iX7fDsVHZqiPCXjXsLZ92KTvm8xJPBgroolSuqpdkMwwRGJfLg39VsHEI3/EKCSpjSX0l0VbnluNBNqNZuL/LgqKcXzRrqEzAtWRPTyZuFrsuUrM72uj8fv8ad3r8P7cvqCHOmDgpHY8a+BJ3QLcp6/ojpi67/OQoeyAlyDNkiFf74EKJKDhnd99JC3TKNRp3YwpHmabP8G2BgPKmSLcHXa9OcbFc+b0x3ho8/Ez6FGNfjDvMRNGQPkKebaotjjmN91NUfktwAyWqONXD2if3zBhJWKnjGuE+7rcOqzJn8+n98e7tbCnfCz0ac6FDlJ9ihAcztgxvBAlKNQ31NWzH1SGQnwbLvTpMRqPiX5iMat9/lA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df728bc-6ca2-477e-d907-08d6b6cc36b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:32.9467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure not to exclude files unintentionally
if exclude paths are specified without a trailing /.
I.e., don't exclude "//depot/file_dont_exclude" if run with "-//depot/file"=
.

Do this by ensuring that paths without a trailing "/" are only matched comp=
letely.

Also, abort path search on the first match as a micro-optimization.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py                 | 21 ++++++++++++++-------
 t/t9817-git-p4-exclude.sh |  4 ++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7edcbad055..c47bd8c4d8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2621,22 +2621,29 @@ def checkpoint(self):
         self.gitStream.write("progress checkpoint\n\n")
         out =3D self.gitOutput.readline()
         if self.verbose:
             print("checkpoint finished: " + out)
=20
+    def isPathWanted(self, path):
+        for p in self.cloneExclude:
+            if p.endswith("/"):
+                if p4PathStartsWith(path, p):
+                    return False
+            # "-//depot/file1" without a trailing "/" should only exclude =
"file1", but not "file111" or "file1_dir/file2"
+            elif path.lower() =3D=3D p.lower():
+                return False
+        for p in self.depotPaths:
+            if p4PathStartsWith(path, p):
+                return True
+        return False
+
     def extractFilesFromCommit(self, commit, shelved=3DFalse, shelved_cl =
=3D 0):
         files =3D []
         fnum =3D 0
         while "depotFile%s" % fnum in commit:
             path =3D  commit["depotFile%s" % fnum]
-
-            if [p for p in self.cloneExclude
-                if p4PathStartsWith(path, p)]:
-                found =3D False
-            else:
-                found =3D [p for p in self.depotPaths
-                         if p4PathStartsWith(path, p)]
+            found =3D self.isPathWanted(path)
             if not found:
                 fnum =3D fnum + 1
                 continue
=20
             file =3D {}
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index 1c22570797..275dd30425 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -51,11 +51,11 @@ test_expect_success 'clone, excluding part of repo' '
 		test_path_is_file discard_file &&
 		test_path_is_file discard_file_not
 	)
 '
=20
-test_expect_failure 'clone, excluding single file, no trailing /' '
+test_expect_success 'clone, excluding single file, no trailing /' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard_file --dest=3D"$git" //depot/...@all &&
 	(
 		cd "$git" &&
 		test_path_is_file wanted/foo &&
@@ -83,11 +83,11 @@ test_expect_success 'clone, then sync with exclude' '
 		test_path_is_file discard_file &&
 		test_path_is_file discard_file_not
 	)
 '
=20
-test_expect_failure 'clone, then sync with exclude, no trailing /' '
+test_expect_success 'clone, then sync with exclude, no trailing /' '
 	test_when_finished cleanup_git &&
 	git p4 clone -//depot/discard/... -//depot/discard_file --dest=3D"$git" /=
/depot/...@all &&
 	(
 		cd "$cli" &&
 		p4 edit wanted/foo discard/foo discard_file_not &&
--=20
2.19.2

