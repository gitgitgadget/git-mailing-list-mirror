Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF15220248
	for <e@80x24.org>; Wed, 27 Mar 2019 23:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfC0XJz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 19:09:55 -0400
Received: from mail-eopbgr720098.outbound.protection.outlook.com ([40.107.72.98]:64736
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfC0XJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 19:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0io8mx3hqe/NQwLql+tnuLkm7gv6XyLBRCwlzMyAlU=;
 b=pgfV9TUR9XLLooYDkAzoW7EssBWTmSaFrnrn3JsWln9OVRKZRV/oMqFzuaOmgwEgnWzDh502ZNToPlCB5Luhnh6kvMbsiiSWogGXyxBQ3a9l/wEP/8DypNwRSAuZzhT/6xS/uWvxIkqJA8F53RRDGRDmuHB1whhqsBYq2PHSoyQ=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5307.namprd08.prod.outlook.com (20.176.112.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Wed, 27 Mar 2019 23:08:11 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 23:08:11 +0000
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
Subject: [RFC PATCH 1/1] git-p4: inexact label detection
Thread-Topic: [RFC PATCH 1/1] git-p4: inexact label detection
Thread-Index: AQHU5PHyPTHfkx/A7Uy6V45Zb7ZQLQ==
Date:   Wed, 27 Mar 2019 23:08:11 +0000
Message-ID: <f695acc99834e01f0313c0cc9cb024f960da3ab1.1553727979.git.amazo@checkvideo.com>
References: <20190326184327.28335-1-amazo@checkvideo.com>
In-Reply-To: <20190326184327.28335-1-amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:2d::37) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8194fff7-6080-49ee-bb5f-08d6b3091513
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB5307;
x-ms-traffictypediagnostic: DM6PR08MB5307:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB5307A5A7B35F8D7E5143E221DA580@DM6PR08MB5307.namprd08.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(105586002)(478600001)(52116002)(6306002)(7736002)(6916009)(25786009)(4326008)(106356001)(26005)(14454004)(66066001)(118296001)(3846002)(2906002)(305945005)(53936002)(386003)(6116002)(97736004)(966005)(6512007)(68736007)(6436002)(186003)(5640700003)(76176011)(256004)(6506007)(36756003)(102836004)(50226002)(486006)(86362001)(476003)(2501003)(81166006)(19627235002)(1730700003)(8936002)(81156014)(11346002)(2616005)(7416002)(5660300002)(14444005)(316002)(71200400001)(8676002)(446003)(54906003)(99286004)(2351001)(71190400001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5307;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G9g0Ud7epAlJxeUTsdMEO1dZPU+cP2NWUtRPq/39RKVUV556BBOv0qz3I5GcwB+KAqAe+lB63f69WWhnOVH/3yKEBDndrq1lV9DLGfE5Wn/99eZCVWExnuOJ9OgZMM8Sca/qHXczalpeNV4P8w+n/E4TJER5zyROAOVqbGRUDhSoiuID9WzTpit5n8aCkANXZZR852P1iwEyLQQXdVa0kY8+GFq0kR0qtpH6l7OPXXYkCKuW0d7gr2/NaDQtcZAdGesshStKqYKWW+tcgoqw6WWG1c5uQrdDUlUfLdSpKF/8HxhCmav1t3ZUY0YOApMlOeevch+7AACAsZQRyL+LDJEQhOiiU0l4N1x+IP/iYeRqW+lj3CoMj3Die141CF6VWsLzr2aq9GYDt2psCFhP+tcQLcH3Djpll5fk7OPqwGA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8194fff7-6080-49ee-bb5f-08d6b3091513
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 23:08:11.2748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5307
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
Also, `git filter-branch` is harder to use for incremental imports
or when changes are submitted from git back to Perforce.

As suggested by Luke,
instead of creating an empty commit for the sole purpose of being tagged la=
ter,
teach git-p4 to search harder for the next lower changelist,
corresponding to the label in question.

Do this by finding the highest changelist up to the label under all known b=
ranches,
(branches are finalized by the time importP4Labels() runs)
and using it instead of a depot-wide changelist corresponding to the label.

This new behavior may not be desired for people,
who want exact label <-> changelist relationship.
So, add a new boolean config parameter git-p4.allowInexactLabels (defaults =
to false)
to explicitly enable it if needed.
Also, this behavior only appears to be useful in case of multiple branches,
(otherwise, every Perforce changelist should appear in git)
so it's not engaged when running without branch detection.

Detect and report (--verbose) "inexact" tags,
i.e. tags placed on a lower changelist than was in Perforce.
Implement this by comparing a changelist for which a commit was found
with a changelist corresponding to the label on the whole depot.

Note, that the new "inexact" logic works slower
than the original code in case of numerous branches,
because p4 needs to calculate the most recent change for each branch path i=
nstead of just one.

This is an alternative solution to "alien" branches concept proposed earlie=
r:
https://public-inbox.org/git/b02df749b9266ac8c73707617a171122156621ab.15532=
83214.git.amazo@checkvideo.com/

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
Suggested-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b04f54b3d1..838c1b43d7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3186,17 +3186,40 @@ def importP4Labels(self, stream, p4Labels):
             if name in ignoredP4Labels:
                 continue
=20
             labelDetails =3D p4CmdList(['label', "-o", name])[0]
=20
-            # get the most recent changelist for each file in this label
-            change =3D p4Cmd(["changes", "-m", "1"] + ["%s...@%s" % (p, na=
me)
+            if self.detectBranches and gitConfigBool("git-p4.allowInexactL=
abels"):
+                doInexactLabels =3D True
+            else:
+                doInexactLabels =3D False
+
+            # get the most recent changelist in this label for the whole d=
epot
+            depot_wide_changelist =3D p4Cmd(["changes", "-m", "1"] + ["%s.=
..@%s" % (p, name)
                                 for p in self.depotPaths])
+            if 'change' in depot_wide_changelist:
+                depot_wide_changelist =3D int(depot_wide_changelist['chang=
e'])
+            else:
+                depot_wide_changelist =3D None
+
+            # get the most recent changelist for each file under branches =
of interest in this label
+            if doInexactLabels:
+                paths =3D ["%s...@%s" % (self.depotPaths[0] + p + '/', nam=
e) for p in self.knownBranches]
+                changes =3D p4CmdList(["changes", "-m", "1"] + paths)
+                changes =3D [int(c['change']) for c in changes if 'change'=
 in c]
+
+                # there may be different "most recent" changelists for dif=
ferent paths.
+                # take the newest since some paths were just modified late=
r than others.
+                if changes:
+                    changelist =3D max(changes)
+                else:
+                    changelist =3D None
+            else:
+                changelist =3D depot_wide_changelist
=20
-            if 'change' in change:
+            if changelist:
                 # find the corresponding git commit; take the oldest commi=
t
-                changelist =3D int(change['change'])
                 if changelist in self.committedChanges:
                     gitCommit =3D ":%d" % changelist       # use a fast-im=
port mark
                     commitFound =3D True
                 else:
                     gitCommit =3D read_pipe(["git", "rev-list", "--max-cou=
nt=3D1",
@@ -3216,14 +3239,24 @@ def importP4Labels(self, stream, p4Labels):
                         tmwhen =3D 1
=20
                     when =3D int(time.mktime(tmwhen))
                     self.streamTag(stream, name, labelDetails, gitCommit, =
when)
                     if verbose:
-                        print("p4 label %s mapped to git commit %s" % (nam=
e, gitCommit))
+                        if depot_wide_changelist =3D=3D changelist:
+                            isExact =3D ""
+                        else:
+                            isExact =3D " inexactly"
+                        print("p4 label %s mapped%s to git commit %s" % (n=
ame, isExact, gitCommit))
             else:
                 if verbose:
-                    print("Label %s has no changelists - possibly deleted?=
" % name)
+                    if depot_wide_changelist:
+                        # there is a changelist corresponding to this labe=
l,
+                        # but it's not under any branches of interest.
+                        print("Label %s has no changelists under detected =
branches -- ignoring" % name)
+                    else:
+                        # there is no changelist corresponding to this lab=
el in the whole depot
+                        print("Label %s has no changelists - possibly dele=
ted?" % name)
=20
             if not commitFound:
                 # We can't import this label; don't try again as it will g=
et very
                 # expensive repeatedly fetching all the files for labels t=
hat will
                 # never be imported. If the label is moved in the future, =
the

base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
--=20
2.19.2

