Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F9920248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfDASCa (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:30 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:27833
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730884AbfDASC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGU2xz9yoNd355zlBtTlFUkLXuZ3yqbgB4XOtyApIFY=;
 b=PKjq+yQLVM2KBhUuLPdcwmFbUf8PxRb0VwPcPc/sw/Xxx8UHoIFxMGbdc18CJFvv7QiDYq3Zgbhq8WpnOoiVsrpYVRHZTBq76vz/teTBqdlpnO4dy5Cqs22vXuj7y7tRJoB0LjjEtiXV8xCXwjxJZEGglCMDo92Hju4ehJJFRVc=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5465.namprd08.prod.outlook.com (20.178.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:02:26 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:26 +0000
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
Subject: [PATCH v3 4/8] git-p4: don't groom exclude path list on every commit
Thread-Topic: [PATCH v3 4/8] git-p4: don't groom exclude path list on every
 commit
Thread-Index: AQHU6LUQZzjar1DN4kml4TvFGRj2CA==
Date:   Mon, 1 Apr 2019 18:02:26 +0000
Message-ID: <1bd5e170e00956ba131cf57b680102610a1b4aa2.1554141338.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 63bfcfaf-7e88-4d65-6cf3-08d6b6cc32b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5465;
x-ms-traffictypediagnostic: DM6PR08MB5465:
x-microsoft-antispam-prvs: <DM6PR08MB5465D00BCF52AE81A88B339DDA550@DM6PR08MB5465.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(105586002)(81156014)(2351001)(446003)(36756003)(76176011)(6916009)(11346002)(71190400001)(305945005)(4326008)(102836004)(478600001)(50226002)(7736002)(25786009)(6116002)(5660300002)(14454004)(2906002)(256004)(14444005)(3846002)(6436002)(1730700003)(53936002)(6512007)(26005)(5640700003)(71200400001)(66066001)(7416002)(186003)(6486002)(97736004)(86362001)(2501003)(81166006)(99286004)(316002)(6506007)(386003)(8676002)(54906003)(8936002)(486006)(68736007)(52116002)(2616005)(118296001)(476003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5465;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AB+2b+rNxZwQxUrm9mswUlktd9+gkIpL6srUmThvS8oa9fzgop6nAJw+qKIEYF37T340TJKElmjX1iNTqksCAYaby4nj79S5fsRV/K1xQU7RJ/XEVsrjvSYIsC90No8ipandTp/pnz3lPcZYPx+wIUv/6ZNSuyzD0mheDRTvpXuHnjeLVaSOwl7YCpBUgiW6rYoxNGb6p+JBPuyxOjckjBFE165qwSCHFmGoHKzd2L37n3D5ftg543loyXMApZKAqULmAlrpkmHY7vKRlYVcVCSbkkuebsIhrMS32P/HuyNbP+WnxSavjNdBObuZpKe80NlINBsF16HmN8ZrxGkavqUK1YhkjahI4llI7LEH63DDguruuumiQ6BPBMjnqgAoOvViJczGmvfWOF2xOaZ77mjnlhPAcEZ/wVDF9hArxjI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bfcfaf-7e88-4d65-6cf3-08d6b6cc32b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:26.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `cloneExclude` array is being groomed (by removing trailing "...=
")
on every changeset.
(since `extractFilesFromCommit()` is called on every imported changeset)

As a micro-optimization, do it once while parsing arguments.
Also, prepend "/" and remove trailing "..." at the same time.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f3e5ccb7af..7edcbad055 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1314,11 +1314,11 @@ class Command:
     def __init__(self):
         self.usage =3D "usage: %prog [options]"
         self.needsGit =3D True
         self.verbose =3D False
=20
-    # This is required for the "append" cloneExclude action
+    # This is required for the "append" update_shelve action
     def ensure_value(self, attr, value):
         if not hasattr(self, attr) or getattr(self, attr) is None:
             setattr(self, attr, value)
         return getattr(self, attr)
=20
@@ -2528,10 +2528,15 @@ def map_in_client(self, depot_path):
             return self.client_spec_path_cache[depot_path]
=20
         die( "Error: %s is not found in client spec path" % depot_path )
         return ""
=20
+def cloneExcludeCallback(option, opt_str, value, parser):
+    # prepend "/" because the first "/" was consumed as part of the option=
 itself.
+    # ("-//depot/A/..." becomes "/depot/A/..." after option parsing)
+    parser.values.cloneExclude +=3D ["/" + re.sub(r"\.\.\.$", "", value)]
+
 class P4Sync(Command, P4UserMap):
=20
     def __init__(self):
         Command.__init__(self)
         P4UserMap.__init__(self)
@@ -2551,11 +2556,11 @@ def __init__(self):
                 optparse.make_option("--keep-path", dest=3D"keepRepoPath",=
 action=3D'store_true',
                                      help=3D"Keep entire BRANCH/DIR/SUBDIR=
 prefix during import"),
                 optparse.make_option("--use-client-spec", dest=3D"useClien=
tSpec", action=3D'store_true',
                                      help=3D"Only sync files that are incl=
uded in the Perforce Client Spec"),
                 optparse.make_option("-/", dest=3D"cloneExclude",
-                                     action=3D"append", type=3D"string",
+                                     action=3D"callback", callback=3Dclone=
ExcludeCallback, type=3D"string",
                                      help=3D"exclude depot path"),
         ]
         self.description =3D """Imports from Perforce into a git repositor=
y.\n
     example:
     //depot/my/project/ -- to import the current head
@@ -2617,12 +2622,10 @@ def checkpoint(self):
         out =3D self.gitOutput.readline()
         if self.verbose:
             print("checkpoint finished: " + out)
=20
     def extractFilesFromCommit(self, commit, shelved=3DFalse, shelved_cl =
=3D 0):
-        self.cloneExclude =3D [re.sub(r"\.\.\.$", "", path)
-                             for path in self.cloneExclude]
         files =3D []
         fnum =3D 0
         while "depotFile%s" % fnum in commit:
             path =3D  commit["depotFile%s" % fnum]
=20
@@ -3888,11 +3891,10 @@ def run(self, args):
=20
         if not self.cloneDestination and len(depotPaths) > 1:
             self.cloneDestination =3D depotPaths[-1]
             depotPaths =3D depotPaths[:-1]
=20
-        self.cloneExclude =3D ["/"+p for p in self.cloneExclude]
         for p in depotPaths:
             if not p.startswith("//"):
                 sys.stderr.write('Depot paths must start with "//": %s\n' =
% p)
                 return False
=20
--=20
2.19.2

