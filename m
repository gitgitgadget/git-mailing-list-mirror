Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974F91F424
	for <e@80x24.org>; Tue, 24 Apr 2018 17:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeDXRLr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 13:11:47 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com ([104.47.36.114]:9088
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751339AbeDXRLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 13:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jEUmKSIs0c/vKCPI4oVdTSSHG8gRC1sUgdtx/oCchts=;
 b=MYYeWgrG/ofc8G7mVovTWkLo6/8J2ybF0leI9cnrQT1tbu3kUIr/kHWBQp6Wj1JlzPHqD1/sP7qidHGB2MxmrlT6be6+BdbLnseEZNHZdtBHI8wU00gF067uiEiEuKBDCa02sRfYiGy4T6X51llVuVKmHSOmKxnC+F0DTh5tseE=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0982.namprd21.prod.outlook.com (52.132.133.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Tue, 24 Apr 2018 17:11:41 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.005; Tue, 24 Apr 2018
 17:11:41 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: [PATCH v2 1/2] merge: Add merge.renames config setting
Thread-Topic: [PATCH v2 1/2] merge: Add merge.renames config setting
Thread-Index: AQHT2+9P/SmWgZybiUukJ0tXp0E5CA==
Date:   Tue, 24 Apr 2018 17:11:41 +0000
Message-ID: <20180424171124.12064-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com>
In-Reply-To: <20180424171124.12064-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR10CA0014.namprd10.prod.outlook.com (2603:10b6:403::24)
 To DM5PR2101MB1016.namprd21.prod.outlook.com (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:Yi7FCyv44PjLjrWwj2oolDwBhANRymUY0OXbiPH3d78K/DkBbU3tjN5CbCutUaOa+VxOOMVSlEBQwcY2x3nrjeSMDxRa02ddJr+3HnZ3e2I6LBud/bWypLosaX0OEGkBUN//kagU631MCRHJzppS6TWpH8vZHNRnMuUm2tUVzDHzR0wERuemvrXN176/i/24SkXyT21nHQ/25MNh8YDNNaXwiglcX8wlRqJoIkUuSlF5bg3SzhCJKvy8msMHq8lR;20:Vj/9F3LAXmxWcDlgfKUysrIhXgXkGcbBhCGhgnz5i5ZFZg5Q/3Iy1NHG1LxD9SLLM3LQDItmms/FBV/4DczsDNediFpv4tDVFWc5amfQNPE8J8nK4H8wvHng76KatOoyPP31Ibmd24oXqQVWy5tc/duKvAMvveU0WW83xqy/9ow=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09820C30C5FC96F3026A0C1FF4880@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(366004)(396003)(346002)(199004)(189003)(36756003)(102836004)(3280700002)(6916009)(22452003)(5660300001)(6116002)(1076002)(26005)(3660700001)(3846002)(14454004)(76176011)(2906002)(52116002)(66066001)(105586002)(10090500001)(8656006)(305945005)(476003)(97736004)(486006)(316002)(50226002)(99286004)(54906003)(2501003)(11346002)(81156014)(1730700003)(81166006)(5250100002)(6512007)(8666007)(53936002)(25786009)(2616005)(6486002)(2351001)(186003)(68736007)(478600001)(10290500003)(5640700003)(72206003)(8936002)(7736002)(39060400002)(59450400001)(86612001)(4326008)(2900100001)(446003)(386003)(8676002)(6506007)(6436002)(106356001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cG9dpPEHOEPXwlY1ZwPZdd5yl/q2xZJiL1LzF2MfrIaUsnAUOiGpu5Y91uBa2sCu2N21PlC9ss1U84/1EXiLtLdSiFMW0z+H3eG2eOjv6sz/F6M5Js8jIDuXKKxkKkKZwvfL521oDQ42okySP5+n0b/KFpXOAesNhlZPz11KdSKA++RNEgBB+KwlliuZfmgz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dba63013-b7c2-40e8-92ae-08d5aa067229
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba63013-b7c2-40e8-92ae-08d5aa067229
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 17:11:41.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to control rename detection for merge via a config setting.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/diff-config.txt      | 3 ++-
 Documentation/merge-config.txt     | 8 +++++++-
 Documentation/merge-strategies.txt | 6 ++++--
 builtin/merge.c                    | 1 +
 merge-recursive.c                  | 1 +
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 5ca942ab5e..77caa66c2f 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -112,7 +112,8 @@ diff.orderFile::
=20
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option `-l`.
+	detection; equivalent to the 'git diff' option `-l`. This setting
+	has no effect if rename detection is turned off.
=20
 diff.renames::
 	Whether and how Git detects renames.  If set to "false",
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 12b6bbf591..0540c44e23 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -35,7 +35,13 @@ include::fmt-merge-msg-config.txt[]
 merge.renameLimit::
 	The number of files to consider when performing rename detection
 	during a merge; if not specified, defaults to the value of
-	diff.renameLimit.
+	diff.renameLimit. This setting has no effect if rename detection
+	is turned off.
+
+merge.renames::
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enabled. This is the default.
=20
 merge.renormalize::
 	Tell Git that canonical representation of files in the
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strat=
egies.txt
index 4a58aad4b8..1e0728aa12 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -84,12 +84,14 @@ no-renormalize;;
 	`merge.renormalize` configuration variable.
=20
 no-renames;;
-	Turn off rename detection.
+	Turn off rename detection. This overrides the `merge.renames`
+	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
=20
 find-renames[=3D<n>];;
 	Turn on rename detection, optionally setting the similarity
-	threshold.  This is the default.
+	threshold.  This is the default. This overrides the
+	'merge.renames' configuration variable.
 	See also linkgit:git-diff[1] `--find-renames`.
=20
 rename-threshold=3D<n>;;
diff --git a/builtin/merge.c b/builtin/merge.c
index 8746c5e3e8..3be52cd316 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -424,6 +424,7 @@ static void finish(struct commit *head_commit,
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
+		git_config_get_bool("merge.renames", &opts.detect_rename);
 		diff_setup_done(&opts);
 		diff_tree_oid(head, new_head, "", &opts);
 		diffcore_std(&opts);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9c05eb7f70..cd5367e890 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3256,6 +3256,7 @@ static void merge_recursive_config(struct merge_optio=
ns *o)
 	git_config_get_int("merge.verbosity", &o->verbosity);
 	git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
 	git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
+	git_config_get_bool("merge.renames", &o->detect_rename);
 	git_config(git_xmerge_config, NULL);
 }
=20
--=20
2.17.0.windows.1

