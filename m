Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B2C20248
	for <e@80x24.org>; Fri, 22 Mar 2019 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfCVTyf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 15:54:35 -0400
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:60736
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfCVTye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 15:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChG298o76ucWQNj/vAE+2CrEdc8biAT5ViF5q4hEbhI=;
 b=eWaN4MtS12YBiH9+OYN9jRx82wkVUhM22d6SCyTk8/n9fYanLLQ0nzRvCFIeWx6wMnCsVRPoRtzrKSjDeV4Yf8xWOFmYgw0QgsObPoGZ3ROXrNJa0vhZL5nZsw2tcfRldRbBwaPWaFGkruZ1y0folcFUC0xqKJN/a+m8e3+GjOw=
Received: from BN7PR08MB4945.namprd08.prod.outlook.com (20.176.176.19) by
 BN7PR08MB6004.namprd08.prod.outlook.com (20.176.179.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 19:54:30 +0000
Received: from BN7PR08MB4945.namprd08.prod.outlook.com
 ([fe80::5c65:6123:80f4:d975]) by BN7PR08MB4945.namprd08.prod.outlook.com
 ([fe80::5c65:6123:80f4:d975%6]) with mapi id 15.20.1730.017; Fri, 22 Mar 2019
 19:54:30 +0000
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
Subject: [RFC PATCH 1/2] git-p4: introduce alien branch mappings
Thread-Topic: [RFC PATCH 1/2] git-p4: introduce alien branch mappings
Thread-Index: AQHU4OkP5k6YadBSpkG8wakiVMZ6MA==
Date:   Fri, 22 Mar 2019 19:54:29 +0000
Message-ID: <b02df749b9266ac8c73707617a171122156621ab.1553283214.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: e5b4e9d8-3c75-4b6c-c399-08d6af00321c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB6004;
x-ms-traffictypediagnostic: BN7PR08MB6004:
x-microsoft-antispam-prvs: <BN7PR08MB600477EEEBD327F8881B1D3DDA430@BN7PR08MB6004.namprd08.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39850400004)(136003)(396003)(346002)(189003)(199004)(106356001)(5640700003)(5660300002)(6486002)(71200400001)(66066001)(2501003)(71190400001)(68736007)(6436002)(53936002)(486006)(6116002)(3846002)(446003)(86362001)(11346002)(476003)(7416002)(186003)(2351001)(6506007)(6916009)(97736004)(102836004)(50226002)(6512007)(36756003)(105586002)(118296001)(26005)(8936002)(14454004)(99286004)(4326008)(25786009)(81166006)(54906003)(1730700003)(19627235002)(14444005)(256004)(386003)(81156014)(316002)(52116002)(305945005)(8676002)(2616005)(76176011)(2906002)(478600001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB6004;H:BN7PR08MB4945.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lOlGTCSzoDabfRdmMaf/F0ckrS/1qahkmQRqcZY7E5BrNCwzc5jMcoT6vyo4lQhyBbpkrV1l0Odmj21z2+GPaRMVOVQf9C2XDLDo/hg2gbaPh/mp1/zPFiy5QG4cC1NBrxcHDGqcoEPIwyajaftj53PSZbVxEYm9j9W+nm5XIPosgNi80jod5sKYfoO8QVhTXlkWN/2sP/tHcN7mj+F0IS6wntnl7XU3ikkSstMisQifzL3Cy0bn/veGuPNtTYvOnH4cX1zAEDb21KtEHvjx83KpsPEIUDXM/y42xwckcX3sxRpe9n24JBYb6m/zmRCkJQ32HQ4QVC3gI9pmy1ifYw4iBf3jG1mjLVo7e47zjH6WY8ruztJyRoMrDQ0Nj9LQ8C6iVY/dvR/AMUNMAgW8oosIrUS65imG+yT+g/Eva5w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b4e9d8-3c75-4b6c-c399-08d6af00321c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 19:54:29.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB6004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Labels in Perforce are not global, but can be placed on a particular view/s=
ubdirectory.
This might pose difficulties when importing only parts of Perforce depot in=
to a git repository.
For example:
 1. Depot layout is as follows:
    //depot/metaproject/branch1/subprojectA/...
    //depot/metaproject/branch1/subprojectB/...
    //depot/metaproject/branch2/subprojectA/...
    //depot/metaproject/branch2/subprojectB/...
 2. Labels are placed as follows:
    * label 1A on //depot/metaproject/branch1/subprojectA/...
    * label 1B on //depot/metaproject/branch1/subprojectB/...
    * label 2A on //depot/metaproject/branch2/subprojectA/...
    * label 2B on //depot/metaproject/branch2/subprojectB/...
 3. The goal is to import
    subprojectA into subprojectA.git and
    subprojectB into subprojectB.git
    preserving all the branches and labels.
 4. Importing subprojectA.
    Label 1A is imported fine because it's placed on certain commit on bran=
ch1.
    However, label 1B is not imported because it's placed on a commit in an=
other subproject:
    git-p4 says: "importing label 1B: could not find git commit for changel=
ist ..."
    The same is with label 2A, which is imported; and 2B, which is not.

Currently, there is no easy way (that I'm aware of) to tell git-p4 to
import an empty commit into a desired branch,
so that a label placed on that changelist could be imported as well,
It might be possible to get a similar effect by importing both subprojectA =
and B in a single git repo,
and then running `git filter-branch --subdirectory-filter subprojectA`,
but this might produce way more irrelevant empty commits, than needed for l=
abels.
(although imported changelists can be limited with git-p4 --changesfile opt=
ion)

So, introduce a concept of an "alien" branch.

In the above example of importing subprojectA,
 * branch1/subprojectB is an alien branch for branch1/subprojectA;
 * branch2/subprojectB is an alien branch for branch2/subprojectA.
Any changelist for branch1/subprojectB will be imported into subprojectA.gi=
t branch1
as an empty commit for the sole purpose of being labeled with a tag later
or just to preserve the history of changes across the branches.

This relation between branches is specified in a similar way to branchList:
`git config --add git-p4.alienLabelBranchMap alien_branch:real_branch`

For the example of importing subprojectA above, config parameters are
```
git config --add git-p4.branchList branch1/subprojectA:branch2/subprojectA
git config --add git-p4.alienLabelBranchMap branch1/subprojectB:branch1/sub=
projectA
git config --add git-p4.alienLabelBranchMap branch2/subprojectB:branch2/sub=
projectA
```

A similar use case, is when a label is placed on a changelist for an exclud=
ed path.
 1. Depot layout is as follows:
    //depot/branch1/...
    //depot/branch1/exclude_me/...
 2. Labels are placed as follows:
    * label 1  on //depot/branch1/...
    * label 1E on //depot/branch1/exclude_me/...
 3. The goal is to import
    //depot/... into depot.git excluding files under
    //depot/branch1/exclude_me/...
    and preserving all the branches and labels.
 4. Importing subprojectA.
    Label 1 is imported fine because it's placed on certain commit on branc=
h1.
    However, label 1E is not imported because it's placed on a commit which=
 is excluded.

For this use case, the config would be
```
git config --add git-p4.alienLabelBranchMap branch1/exclude_me:branch1
```

Note that the current implementation doesn't process alien branches
when a clientspec is used.

Diff best viewed with --ignore-all-space .

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---

Notes:
    Documentation changes and tests are obviously missing,
    but I hoped to get some feedback on the idea overall
    before working on those.
   =20
    A better name for "alien" branches is very welcome.

 git-p4.py | 59 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 148ea6f1b0..40bc84573b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2610,10 +2610,12 @@ def __init__(self):
=20
         # map from branch depot path to parent branch
         self.knownBranches =3D {}
         self.initialParents =3D {}
=20
+        self.knownAlienLabelBranches =3D {}
+
         self.tz =3D "%+03d%02d" % (- time.timezone / 3600, ((- time.timezo=
ne % 3600) / 60))
         self.labels =3D {}
=20
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
@@ -2705,14 +2707,37 @@ def splitFilesIntoBranches(self, commit):
         if self.clientSpecDirs:
             files =3D self.extractFilesFromCommit(commit)
             self.clientSpecDirs.update_client_spec_path_cache(files)
=20
         branches =3D {}
+        alienBranches =3D {}
         fnum =3D 0
         while "depotFile%s" % fnum in commit:
             path =3D  commit["depotFile%s" % fnum]
             found =3D self.isPathWanted(path)
+
+            # start with the full relative path where this file would
+            # go in a p4 client
+            if self.useClientSpec:
+                # with a clientspec, we won't know where the file goes if =
it's excluded
+                if found:
+                    relPath =3D self.clientSpecDirs.map_in_client(path)
+                else:
+                    relPath =3D None
+            else:
+                # without a clientspec, we can guess a file path even if i=
t's excluded
+                relPath =3D self.stripRepoPath(path, self.depotPaths)
+
+            # Process alien branches before excludes (i.e. before respecti=
ng `found`) --
+            # picking (empty) commits from excluded paths is one of the us=
e-cases for alien branches.
+            # We don't commit any files for alien branches, so don't viola=
te excludes.
+            for (alienPath, ourPath) in self.knownAlienLabelBranches.items=
():
+                if relPath is not None and p4PathStartsWith(relPath, alien=
Path + '/') and ourPath in self.knownBranches:
+                    # we don't put any files since they are under the path=
s, we're not interested in.
+                    # however, we still want the commit message and etc.
+                    alienBranches[ourPath] =3D [{"alienPath": alienPath}]
+
             if not found:
                 fnum =3D fnum + 1
                 continue
=20
             file =3D {}
@@ -2720,26 +2745,23 @@ def splitFilesIntoBranches(self, commit):
             file["rev"] =3D commit["rev%s" % fnum]
             file["action"] =3D commit["action%s" % fnum]
             file["type"] =3D commit["type%s" % fnum]
             fnum =3D fnum + 1
=20
-            # start with the full relative path where this file would
-            # go in a p4 client
-            if self.useClientSpec:
-                relPath =3D self.clientSpecDirs.map_in_client(path)
-            else:
-                relPath =3D self.stripRepoPath(path, self.depotPaths)
-
             for branch in self.knownBranches.keys():
                 # add a trailing slash so that a commit into qt/4.2foo
                 # doesn't end up in qt/4.2, e.g.
                 if p4PathStartsWith(relPath, branch + "/"):
                     if branch not in branches:
                         branches[branch] =3D []
                     branches[branch].append(file)
                     break
=20
+        # not on any branch, check out our alien mapping
+        if not branches:
+            branches =3D alienBranches
+
         return branches
=20
     def writeToGitStream(self, gitMode, relPath, contents):
         self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
         self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
@@ -3283,10 +3305,17 @@ def getBranchMappingFromGitBranches(self):
                 branch =3D "main"
             else:
                 branch =3D branch[len(self.projectName):]
             self.knownBranches[branch] =3D branch
=20
+    def getAlienLabelBranchMapping(self):
+        alienLabelBranches =3D gitConfigList("git-p4.alienLabelBranchMap")
+        for mapping in alienLabelBranches:
+            if mapping:
+                (alien, ours) =3D mapping.split(":")
+                self.knownAlienLabelBranches[alien] =3D ours
+
     def updateOptionDict(self, d):
         option_keys =3D {}
         if self.keepRepoPath:
             option_keys['keepRepoPath'] =3D 1
=20
@@ -3396,17 +3425,22 @@ def importChanges(self, changes, origin_revision=3D=
0):
=20
             try:
                 if self.detectBranches:
                     branches =3D self.splitFilesIntoBranches(description)
                     for branch in branches.keys():
-                        ## HACK  --hwn
-                        branchPrefix =3D self.depotPaths[0] + branch + "/"
-                        self.branchPrefixes =3D [ branchPrefix ]
+                        # hack branch prefix and file list for alien branc=
hes
+                        if branches[branch] and "alienPath" in branches[br=
anch][0]:
+                            branchPrefix =3D self.depotPaths[0] + branches=
[branch][0]["alienPath"] + "/"
+                            filesForCommit =3D []
+                        else:
+                            ## HACK  --hwn
+                            branchPrefix =3D self.depotPaths[0] + branch +=
 "/"
+                            filesForCommit =3D branches[branch]
=20
-                        parent =3D ""
+                        self.branchPrefixes =3D [branchPrefix]
=20
-                        filesForCommit =3D branches[branch]
+                        parent =3D ""
=20
                         if self.verbose:
                             print("branch is %s" % branch)
=20
                         self.updatedBranches.add(branch)
@@ -3715,10 +3749,11 @@ def run(self, args):
=20
             if self.hasOrigin:
                 self.getBranchMappingFromGitBranches()
             else:
                 self.getBranchMapping()
+                self.getAlienLabelBranchMapping()
             if self.verbose:
                 print("p4-git branches: %s" % self.p4BranchesInGit)
                 print("initial parents: %s" % self.initialParents)
             for b in self.p4BranchesInGit:
                 if b !=3D "master":
--=20
2.19.2

