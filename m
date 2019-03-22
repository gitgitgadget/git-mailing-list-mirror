Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3686C20248
	for <e@80x24.org>; Fri, 22 Mar 2019 19:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfCVTyv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 15:54:51 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com ([40.107.68.126]:62176
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfCVTyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 15:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZzRVt0T48JUG5D5Klq//gLX7p6ZHJJGJBQ6wVhZLlc=;
 b=vhbEMxZeBhF1qRh7L2x9L2NjaXErEYdC1l7+cXd5DPzPuNtQGNmvsuLoysUoTlIJqvch05+Dsicuy5niuHMPkgra3FE5/oo3jIjcKK0y7gEicX6UTg+SIU4eGUImrjS8Oxg4/mt1Nd+QPYcvRVb17Nk6lcutaxpZzmaUeOrnPdM=
Received: from BN7PR08MB4945.namprd08.prod.outlook.com (20.176.176.19) by
 BN7PR08MB6004.namprd08.prod.outlook.com (20.176.179.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 19:54:45 +0000
Received: from BN7PR08MB4945.namprd08.prod.outlook.com
 ([fe80::5c65:6123:80f4:d975]) by BN7PR08MB4945.namprd08.prod.outlook.com
 ([fe80::5c65:6123:80f4:d975%6]) with mapi id 15.20.1730.017; Fri, 22 Mar 2019
 19:54:45 +0000
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
        Andrey <ahippo@yandex.com>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/2] git-p4: support loading changelist descriptions from
 files
Thread-Topic: [RFC PATCH 2/2] git-p4: support loading changelist descriptions
 from files
Thread-Index: AQHU4OkYtk8qmR+l2kGuadbAgVDS2Q==
Date:   Fri, 22 Mar 2019 19:54:45 +0000
Message-ID: <bb3e14a3897c98762b0e656d583eaa408a6aba60.1553283214.git.amazo@checkvideo.com>
References: <cover.1553283214.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553283214.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0115.namprd02.prod.outlook.com
 (2603:10b6:208:35::20) To BN7PR08MB4945.namprd08.prod.outlook.com
 (2603:10b6:408:28::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef2dcce8-e243-44b1-30b5-08d6af003b4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB6004;
x-ms-traffictypediagnostic: BN7PR08MB6004:
x-microsoft-antispam-prvs: <BN7PR08MB6004B8ACFA5FE25A87B52037DA430@BN7PR08MB6004.namprd08.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39850400004)(136003)(396003)(346002)(189003)(199004)(106356001)(5640700003)(5660300002)(6486002)(71200400001)(66066001)(2501003)(71190400001)(68736007)(6436002)(53936002)(486006)(6116002)(3846002)(446003)(86362001)(11346002)(476003)(7416002)(186003)(2351001)(6506007)(6916009)(97736004)(102836004)(50226002)(6512007)(36756003)(105586002)(118296001)(26005)(8936002)(14454004)(99286004)(4326008)(25786009)(81166006)(54906003)(1730700003)(14444005)(256004)(386003)(81156014)(316002)(52116002)(305945005)(8676002)(2616005)(76176011)(2906002)(478600001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB6004;H:BN7PR08MB4945.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H2Q5BWrR8I/WwKNG5Tp3OAUwWVmjfJLEXoiIgIh9naXL37R0WZ+9gVAUbYc2Da3vY7O/FbI6xA+amDaahgVKzf6Es2vSj4l6LDiIJHRo5RegP3eXv+usdByFy5PGDCFOgfaF3m9vfRk8nPob7dWFHZrUyALIQ83fIZbW8Jt6RoEAjjCAv4CF0QShg7vx5/N0XQkMBGrsQpcVp6lpH+4P5nac8lgJoHpNtoczgOuSC/v53tZEBN1f6fVcyzDAmtTvZQ+Z4aQ2kXGsAySmlTkTex0mHCsaZx2IVMTPcU+lx+cFgaPaoiaKmILcr4PkTTRZTZZxW3E99kPEOYMjvyPNLEQETA7qHeFzhtNIHBjaRXwiMhuBWOJXZ/VlsOvzM+mSRb82EIN1xzfrGV240TcLMdJVXw0BYZWTPRDSFBgnN1I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2dcce8-e243-44b1-30b5-08d6af003b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 19:54:45.2002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB6004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Perforce server experienced some kind of database corruption a few year=
s ago.
While the file data and revision history are mostly intact,
some metadata for several changesets got lost.
For example, inspecting certain changelists produces errors.
"""
$ p4 describe -s 12345
Date 2019/02/26 16:46:17:
Operation: user-describe
Operation 'user-describe' failed.
Change 12345 description missing!
"""

While some metadata (like changeset descriptions) is obviously lost,
most of it can be reconstructed via other commands:
 * `p4 changes -l -t //...@12345,12345` --
   to obtain date+time, author, beginning of changeset description;
 * `p4 files -a //...@12345,12345` --
   to obtain file revisions, file types, file actions;
 * `p4 diff2 -u //...@12344 //...@12345` --
   to get a unified diff of text files in a changeset;
 * `p4 print -o binary.blob@12345 //depot/binary.blob@12345` --
   to get a revision of a binary file.

It might be possible to teach git-p4 to fallback to other methods if `p4 de=
scribe` fails,
but it's probably too special-cased (really depends on kind and scale of DB=
 corruption),
so some manual intervention is perhaps acceptable.

So, with some manual work, it's possible to reconstruct `p4 -G describe ...=
` output manually.
In our case, once git-p4 passes `p4 describe` stage,
it can proceed further just fine.
Thus, it's tempting to feed resurrected metadata to git-p4 when a normal `p=
4 describe` would fail.

This functionality may be useful to cache changelist information,
or to make some changes to changelist info before feeding it to git-p4.

A new config parameter is introduced to tell git-p4
to load certain changelist descriptions from files instead of from a server=
.
For simplicity, it's one pickled file per changelist.
```
git config --add git-p4.damagedChangelists 12345.pickled
git config --add git-p4.damagedChangelists 12346.pickled
```

The following trivial script may be used to produce pickled `p4 -G describe=
`-compatible output.
"""
 #!/usr/bin/python2

 import pickle
 import time

 # recovered commits of interest
 changes =3D [
     {
         'change':     '12345',
         'status':     'submitted',
         'code':       'stat',
         'user':       'username1',
         'time':       str(int(time.mktime(time.strptime('2019/02/28 16:00:=
30', '%Y/%m/%d %H:%M:%S')))),
         'client':     'username1_hostname1',
         'desc':       'A bug is fixed.\nDetails are below:<lost>\n',
         'depotFile0': '//depot/branch1/foo.sh',
         'action0':    'edit',
         'rev0':       '28',
         'type0':      'xtext',
         'depotFile1': '//depot/branch1/bar.py',
         'action1':    'edit',
         'rev1':       '43',
         'type1':      'text',
         'depotFile2': '//depot/branch1/baz.doc',
         'action2':    'edit',
         'rev2':       '8',
         'type2':      'binary',
         'depotFile3': '//depot/branch1/qqq.c',
         'action3':    'edit',
         'rev3':       '6',
         'type3':      'ktext',
     },
 ]

 for change in changes:
     pickle.dump(change, open('{0}.pickled'.format(change['change']), 'wb')=
)
"""

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---

Notes:
    Documentation changes and tests are obviously missing,
    but I hoped to get some feedback on the idea overall
    before working on those.

 git-p4.py | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 40bc84573b..3133419280 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -24,10 +24,11 @@
 import stat
 import zipfile
 import zlib
 import ctypes
 import errno
+import pickle
=20
 # support basestring in python3
 try:
     unicode =3D unicode
 except NameError:
@@ -2615,10 +2616,12 @@ def __init__(self):
         self.knownAlienLabelBranches =3D {}
=20
         self.tz =3D "%+03d%02d" % (- time.timezone / 3600, ((- time.timezo=
ne % 3600) / 60))
         self.labels =3D {}
=20
+        self.damagedChangelists =3D {}
+
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
         out =3D self.gitOutput.readline()
@@ -3312,10 +3315,25 @@ def getAlienLabelBranchMapping(self):
         for mapping in alienLabelBranches:
             if mapping:
                 (alien, ours) =3D mapping.split(":")
                 self.knownAlienLabelBranches[alien] =3D ours
=20
+    def loadDamagedChangelists(self):
+        damagedChangelists =3D gitConfigList("git-p4.damagedChangelists")
+        for clPickled in damagedChangelists:
+            if not clPickled:
+                continue
+
+            try:
+                clDesc =3D pickle.load(open(clPickled, 'rb'))
+                if not ("status" in clDesc and "user" in clDesc and "time"=
 in clDesc and "change" in clDesc):
+                    die("Changelist description read from {0} doesn't have=
 required fields".format(clPickled))
+            except (IOError, TypeError) as e:
+                die("Can't read changelist description dict from {0}: {1}"=
.format(clPickled, str(e)))
+
+            self.damagedChangelists[int(clDesc["change"])] =3D clDesc
+
     def updateOptionDict(self, d):
         option_keys =3D {}
         if self.keepRepoPath:
             option_keys['keepRepoPath'] =3D 1
=20
@@ -3413,11 +3431,14 @@ def searchParent(self, parent, branch, target):
             return None
=20
     def importChanges(self, changes, origin_revision=3D0):
         cnt =3D 1
         for change in changes:
-            description =3D p4_describe(change)
+            if change in self.damagedChangelists:
+                description =3D self.damagedChangelists[change]
+            else:
+                description =3D p4_describe(change)
             self.updateOptionDict(description)
=20
             if not self.silent:
                 sys.stdout.write("\rImporting revision %s (%s%%)" % (chang=
e, cnt * 100 / len(changes)))
                 sys.stdout.flush()
@@ -3704,10 +3725,12 @@ def run(self, args):
                     bad_changesfile =3D True
                     break
         if bad_changesfile:
             die("Option --changesfile is incompatible with revision specif=
iers")
=20
+        self.loadDamagedChangelists()
+
         newPaths =3D []
         for p in self.depotPaths:
             if p.find("@") !=3D -1:
                 atIdx =3D p.index("@")
                 self.changeRange =3D p[atIdx:]
--=20
2.19.2

