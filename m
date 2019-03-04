Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52ED20248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCDReu (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:34:50 -0500
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:18492
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727406AbfCDRet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlH2x1R8E9eZa6pzO88bQsHk1eo441ZLR7kYd5RqXTc=;
 b=0N6Bsc3AN7la/rsJqxrECoXgLEkib9YVOWn22NbP2Xk1WMhZK1ZBJPtqeVc3bPvCs0Aoj9cYgPGdmSc2F9FFGQlrRnpdt4au/0UViSZBuW0tuOUW/KwoNzZIpXgq7HFigu3ElpiQTaBRWyb9afe7X2iS2TA/CKEDh0+DlQQGxhM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:34:46 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 17:34:46 +0000
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
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH 3/5] git-p4: don't groom exclude path list on every commit
Thread-Topic: [PATCH 3/5] git-p4: don't groom exclude path list on every
 commit
Thread-Index: AQHU0rCP7Ba/nUHJoEqWKgFIKr8Bfg==
Date:   Mon, 4 Mar 2019 17:34:46 +0000
Message-ID: <44fed954dc4ee7d98ce518c0665cc71a0751dd3b.1551485349.git.amazo@checkvideo.com>
References: <cover.1551485349.git.amazo@checkvideo.com>
In-Reply-To: <cover.1551485349.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:404:13e::32) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4eb138d-269a-47bc-bd56-08d6a0c7b1f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR08MB4377;23:oKkQpk5UBtqsjdk9GKBxk5tGvTXCp73ZCBxREEy?=
 =?iso-8859-1?Q?KfNFl9JD0feVw58bXwX3sZkJaCjW2AnwoKWHHCu4hEN4Rp4jzgdZw2rYov?=
 =?iso-8859-1?Q?GI3huzdYvJOf+GxSFhnkhsCAGvoZr72HfO9dH3gUlMF531CtoPwJdHyFhs?=
 =?iso-8859-1?Q?Hk9v+EqmGBJBkTOv3sk9EkkaHLwI1xa9iiBxldDmj/rGvDEy7qwtlYmktf?=
 =?iso-8859-1?Q?/a6Zwco+Y6Z4yM6E81ok0qEh8jVe5YvcMU0V3HutwY82/zyLZtEzH7zyfd?=
 =?iso-8859-1?Q?pkIegg7x/NqaJi1MXC75XoIOhYNVqOCDnIXhsZg9MS1X4o5Zs4SAdUlq8s?=
 =?iso-8859-1?Q?yV4qoJ8+q2QG74ebZk2hPFVE9RlE4rrTy2DftDusoxwrZfE1zZhzerVMkg?=
 =?iso-8859-1?Q?b4BGMW8xSxICPx5L5+5ZVCZRmHBUpGNl5kOaBJkHXBsPVY1WDeN9iSzGxv?=
 =?iso-8859-1?Q?XsODBvDvkhtszR+zV4x4afKX2YBWHbC+XcmJLxiIe26g0arOUPV6UeyPJd?=
 =?iso-8859-1?Q?Ajb35d6XrSxoJ2mw82cXDsxWXPesgmM8ZQT8uqUldyfnE7k456TC33aSbn?=
 =?iso-8859-1?Q?M+SWyXcN2VAL7tWFcJJl9mTizMYGEeVUDZ9brCUWQ0reHe8xffno5/K38q?=
 =?iso-8859-1?Q?KR9S+V+Yz8Nltvbx/l1t497xjD0JPZMmqExKBaoKLGKmmxysu52RBhEyjJ?=
 =?iso-8859-1?Q?qGhVcB/ogRyPg1bW6klVuUTVvFLlKGXt1usjWVctWDi3xNmnFmGIi+zJTj?=
 =?iso-8859-1?Q?wEc6VlE/eCCP1wnsgDVTCGbB2iVEREXomT+ncfZsRfwnDWfaHMV+JTCShm?=
 =?iso-8859-1?Q?6qAp6eUL9wgtwf+LUEmxsR2fxl3F6MglSYGI8JuILKXzCEAnDX7TwppDXd?=
 =?iso-8859-1?Q?HXF2Y/lhgT12LGW9ZiBJRFeCD6cRYNAm8m7Xn9edLPPeIKlTF8NYSc1xiG?=
 =?iso-8859-1?Q?4jgOleu7f98MCBy66wYGBV1bWnqkG6AzPFAAi4ZhDXD0urDjJ1lVJMrjv6?=
 =?iso-8859-1?Q?4Ji0/Lh3iqEQu9w18aVU5eVySYGObKUO2fq4WeneVF7Uz0Y4Hc5VICUwMt?=
 =?iso-8859-1?Q?k4MvOeCky2yhTcStjGEcTuy3VKIkzYLzutm60DGEEwSfNmXYGnFV+NKWbb?=
 =?iso-8859-1?Q?PQgWzzO8FAo9Gxgh7DatE4T7ZmJVUpgGWAtttCbVNh0crjhtVBadDSE6fW?=
 =?iso-8859-1?Q?cFJHi7Tu0Nqcyr/64yPDyMdoKUOmKASchvN106Mt5zqBqACgce7JzeABp9?=
 =?iso-8859-1?Q?WEotmc3HqjK+To/BwjEVmr/Vsa64e2P1JU0kJp20fDjkrvJ0BlT/lniuI0?=
 =?iso-8859-1?Q?5SpZ+xZ0rI1kBwUAK5A44yCufgN+vTq5EvFzSKlQMMDqvasbp40/Kzo1Xw?=
 =?iso-8859-1?Q?iu28zMr5mx+HmhDIIa2Oogsc+9GtR?=
x-microsoft-antispam-prvs: <DM6PR08MB437717530DDD124FDC8A5C1EDA710@DM6PR08MB4377.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(316002)(5640700003)(86362001)(3846002)(6116002)(186003)(26005)(6512007)(4326008)(6916009)(486006)(6486002)(66066001)(53936002)(6436002)(256004)(118296001)(14444005)(6506007)(52116002)(102836004)(76176011)(99286004)(386003)(2906002)(478600001)(14454004)(2351001)(2501003)(81156014)(5660300002)(81166006)(1730700003)(8676002)(68736007)(2616005)(8936002)(97736004)(50226002)(54906003)(7416002)(105586002)(106356001)(11346002)(25786009)(36756003)(305945005)(7736002)(71190400001)(71200400001)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fuKpSaoD1A0AIz9VO7qCFpGBavtJEsOVp1qkylXqVaC0ItnrUSwq2/apn5B1jri15c+/y/9y4FjOiyAM+euTUuNocZDN82Zed6+z2IXOmy1EijaZyp7WLNZMPLEGTQafJdFbXBp0xg287WHDPAipsDF03ufpiE/aIppCJuyMEwbFZAjOUF47/ErZyLhH73K1sgUe8OsFbI4/birYDux4dAEKhKHKwDjTrJPq4mXhKPXHaXwlDk0hYpJmddSlINNtQoHE54bTmXO4+gI5P8GkV+R6jp4l6DI+HBCkWO7SgO8xNJvE9oeyn8EtG0bmCsWtQgLGo5H1d3O7T77WuIdXsfj8ir6XsC3sPWbjRg5ZX3cJKzqg+HcXNhGNpOGJzlqW1FLIK3U8bWdChpeyMebt64bDfbO8OMgQxl5NrUST7ik=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb138d-269a-47bc-bd56-08d6a0c7b1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:34:46.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
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
index 91c610f960..a9f53e5b88 100755
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

