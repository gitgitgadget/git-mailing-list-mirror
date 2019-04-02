Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BBA220248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDBAOJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:14:09 -0400
Received: from mail-eopbgr730134.outbound.protection.outlook.com ([40.107.73.134]:18496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfDBAOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKNhHl4Hnn86m6MnMYrZinwuAM25SuCw5qUR0bJKY8Q=;
 b=FTVg1tO5zicQ/reQSmjLUUrfkj/MB60SOUlWprBC+enWEp+77LRbzXKy6Lp5/G3MljZroPS+phq9F5QwuUgXLq1XUJ/ZNVEsM5Dy8fKRUi/X3p2toHXka9wIxVBnrkRYdjXrMzxoY9W0UMpucscg8avAw3RYvvqf/SPA0NAnyMk=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4827.namprd08.prod.outlook.com (20.176.115.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Tue, 2 Apr 2019 00:13:48 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 00:13:48 +0000
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
Subject: [RFC PATCH v2 2/2] git-p4: support loading changelist descriptions
 from files
Thread-Topic: [RFC PATCH v2 2/2] git-p4: support loading changelist
 descriptions from files
Thread-Index: AQHU6Ojxo5OesSQeXkC4DQfSI5n5gg==
Date:   Tue, 2 Apr 2019 00:13:48 +0000
Message-ID: <83b00345385bee36957f3812dda866826a8c2547.1554162242.git.amazo@checkvideo.com>
References: <cover.1554141338.git.amazo@checkvideo.com>
 <cover.1554162242.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554162242.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d13639-8ec1-4bf9-530c-08d6b70013ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB4827;
x-ms-traffictypediagnostic: DM6PR08MB4827:
x-microsoft-antispam-prvs: <DM6PR08MB4827F1DD2E9EB95A54A11037DA560@DM6PR08MB4827.namprd08.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(71200400001)(11346002)(6436002)(476003)(446003)(486006)(14444005)(19627235002)(102836004)(305945005)(6506007)(386003)(97736004)(186003)(7736002)(256004)(26005)(71190400001)(86362001)(2501003)(76176011)(4326008)(52116002)(66066001)(68736007)(478600001)(105586002)(106356001)(2616005)(50226002)(8936002)(36756003)(25786009)(6512007)(8676002)(5640700003)(81156014)(118296001)(7416002)(81166006)(1730700003)(2906002)(53936002)(316002)(6486002)(6916009)(54906003)(14454004)(3846002)(6116002)(5660300002)(2351001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4827;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qAyY3afeX0CpQ3htM+vTnMjxSnxcypS7teKoDmdgAGQ9mP6e5D3x5nfcEXZX8psp1IQSyQjU/kcVXe+/pkNKMTlQbnEgGCEFH2Sj2y3HnULwpGaFfnQ8bvhiNAfS5/uKeW3EEX+auRU7qzrerPqsrmRV/GNyXs+vYL80wV4TtpH6KUaOPOEPhsuopIC+Nk4AXmtPlZ3ofvIw6e8mPxTJZ+cACjSSzyyQ355WqalmheSoW7WlrfJK4yqL8PhpPHEQySvvpyCFOuhfhYJbF7jWTgpIxb7j6rDti4WygLwkOpg939q8vOFpDQT8qsf4eeIHIOkIB18D1M1ER7je5w91zXBPpggPmdwBo/HMaRs6vpqKe4pcdVPK/e1zUbFOm2g0AGMUqkKspHYNTWSCCNEtz5ulbY3L0IVa07ZMkStcXYU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d13639-8ec1-4bf9-530c-08d6b70013ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 00:13:48.4362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4827
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
For simplicity, it's one marshalled file per changelist.
```
git config --add git-p4.changelistDescriptionFile 12345.marshal
git config --add git-p4.changelistDescriptionFile 12346.marshal
```

The following trivial script may be used to produce marshalled `p4 -G descr=
ibe`-compatible output.
"""
 #!/usr/bin/env python

 import marshal
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
     marshal.dump(change, open('{0}.marshal'.format(change['change']), 'wb'=
))
"""

Or, the following script may be used to produce marshalled `p4 -G describe`=
-compatible output
for our particular database corruption.
"""
 #!/usr/bin/env python

 import itertools
 import marshal
 import subprocess
 import tempfile

 def p4_unmarshal(fileobj):
     result =3D []
     while True:
         try:
             result +=3D [marshal.load(fileobj)]
         except EOFError:
             break

     return result

 def p4_describe_fallback(cl):
     with tempfile.TemporaryFile() as p4_changes_output:
         with tempfile.TemporaryFile() as p4_files_output:
             subprocess.check_call(['p4', '-G', 'changes', '-l', '-t', '//.=
..@{0},{0}'.format(cl)], stdout=3Dp4_changes_output)
             subprocess.check_call(['p4', '-G', 'files', '-a', '//...@{0},{=
0}'.format(cl)], stdout=3Dp4_files_output)

             p4_changes_output.seek(0)
             p4_files_output.seek(0)

             p4_changes_unmarshalled =3D p4_unmarshal(p4_changes_output)
             p4_files_unmarshalled =3D p4_unmarshal(p4_files_output)

             described_cl =3D p4_changes_unmarshalled[0] # there is usually=
 only one entry
             described_cl['desc'] +=3D '<lost>\n'

             assert described_cl['change'] =3D=3D str(cl)

             for (file_info, i) in itertools.izip(p4_files_unmarshalled, it=
ertools.count()):
                 for f in ('depotFile', 'action', 'rev', 'type'):
                     described_cl['{}{}'.format(f, i)] =3D file_info[f]

                 assert file_info['change'] =3D=3D described_cl['change']

             return described_cl

 cls_wanted =3D ( 12345, 12346 )

 for cl in cls_wanted:
     with open('{0}.marshal'.format(cl), 'wb') as f:
         cl_info =3D p4_describe_fallback(cl)
         marshal.dump(cl_info, f)
"""

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 Documentation/git-p4.txt | 27 +++++++++++++++++++++++++++
 git-p4.py                | 24 +++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index ceabab8b86..f751ae729f 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -654,10 +654,37 @@ git config --add git-p4.mapUser "p4user =3D First Las=
t <mail@address.com>"
 -------------
 +
 A mapping will override any user information from P4. Mappings for
 multiple P4 user can be defined.
=20
+git-p4.changelistDescriptionFile::
+	This config variable points 'git p4' to a file,
+	containing a serialized (marshalled) changelist description.
+	'git p4' loads a description from such a file
+	instead of asking Perforce server about it.
+	The file format is the same as produced by 'p4 -G describe -s <changelist=
>'.
+	This option can be specified multiple times
+	to feed multiple changelist descriptions to 'git p4'.
+	The path is relative to git work tree,
+	file names or extensions don't matter.
+	This example loads 2 changelist descriptions:
++
+-------------
+git config --add git-p4.changelistDescriptionFile cl-12345.marshal
+git config --add git-p4.changelistDescriptionFile cl-12347.marshal
+-------------
++
+Under some circumstances (for example, Perforce database corruption)
+this option is useful to supply changelist description to 'git p4' bypassi=
ng 'p4'.
+Also, it can be used for caching of changelist descriptions
+to reduce load on the Perforce server in case of successive imports
+(say, when splitting the depot into multiple Git repositories)
+or for overriding some changelist information.
+This config variable is generally not needed after the initial import,
+so it can be removed from the config file
+together with corresponding description files after the import.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
 	Detect renames.  See linkgit:git-diff[1].  This can be true,
 	false, or a score as expected by 'git diff -M'.
diff --git a/git-p4.py b/git-p4.py
index 98b2b7bbca..e65df92d75 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2613,10 +2613,12 @@ def __init__(self):
         self.initialParents =3D {}
=20
         self.tz =3D "%+03d%02d" % (- time.timezone / 3600, ((- time.timezo=
ne % 3600) / 60))
         self.labels =3D {}
=20
+        self.loadedChangelistDescriptions =3D {}
+
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
         out =3D self.gitOutput.readline()
@@ -3319,10 +3321,25 @@ def getBranchMappingFromGitBranches(self):
                 branch =3D "main"
             else:
                 branch =3D branch[len(self.projectName):]
             self.knownBranches[branch] =3D branch
=20
+    def loadChangelistDescFromFile(self):
+        changelistDescriptionFiles =3D gitConfigList("git-p4.changelistDes=
criptionFile")
+        for clMarshalledDescFile in changelistDescriptionFiles:
+            if not clMarshalledDescFile:
+                continue
+
+            try:
+                with open(clMarshalledDescFile, 'rb') as clFileObj:
+                    clDesc =3D marshal.load(clFileObj)
+                if not ("status" in clDesc and "user" in clDesc and "time"=
 in clDesc and "change" in clDesc):
+                    die("Changelist description read from {0} doesn't have=
 required fields".format(clMarshalledDescFile))
+                self.loadedChangelistDescriptions[int(clDesc["change"])] =
=3D clDesc
+            except (IOError, TypeError, ValueError, EOFError) as e:
+                die("Can't read changelist description from {0}: {1}".form=
at(clMarshalledDescFile, str(e)))
+
     def updateOptionDict(self, d):
         option_keys =3D {}
         if self.keepRepoPath:
             option_keys['keepRepoPath'] =3D 1
=20
@@ -3420,11 +3437,14 @@ def searchParent(self, parent, branch, target):
             return None
=20
     def importChanges(self, changes, origin_revision=3D0):
         cnt =3D 1
         for change in changes:
-            description =3D p4_describe(change)
+            if change in self.loadedChangelistDescriptions:
+                description =3D self.loadedChangelistDescriptions[change]
+            else:
+                description =3D p4_describe(change)
             self.updateOptionDict(description)
=20
             if not self.silent:
                 sys.stdout.write("\rImporting revision %s (%s%%)" % (chang=
e, cnt * 100 / len(changes)))
                 sys.stdout.flush()
@@ -3706,10 +3726,12 @@ def run(self, args):
                     bad_changesfile =3D True
                     break
         if bad_changesfile:
             die("Option --changesfile is incompatible with revision specif=
iers")
=20
+        self.loadChangelistDescFromFile()
+
         newPaths =3D []
         for p in self.depotPaths:
             if p.find("@") !=3D -1:
                 atIdx =3D p.index("@")
                 self.changeRange =3D p[atIdx:]
--=20
2.19.2

