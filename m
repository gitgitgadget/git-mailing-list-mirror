Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22701F597
	for <e@80x24.org>; Fri, 27 Jul 2018 12:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbeG0OVi (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 10:21:38 -0400
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:27072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728384AbeG0OVh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g15Gq1f51W7ZaDnuGMhYEesaZrHU5E/MGtqeFeIbclA=;
 b=CtI8Ktgf7Oq74P7f8pI2xh+e6h1inA5sxX0zsc0nz+C2ljpXaFcCUqcS+cUBKd1btyfbXxHKeuK6qlKNBBa5TpRV7oJ0LPNq4Hzwi2sLGhCjrUZ9ysPwqG0dtXdB0CIA7N88Mxi4RHfLu55C2iIHkXHzF9bovpMlsScDQBhjQig=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1131.namprd21.prod.outlook.com (52.132.146.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.2; Fri, 27 Jul 2018 12:59:44 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd%4]) with mapi id 15.20.1017.000; Fri, 27 Jul 2018
 12:59:44 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>
Subject: [PATCH v2 2/2] merge-recursive: preserve skip_worktree bit when
 necessary
Thread-Topic: [PATCH v2 2/2] merge-recursive: preserve skip_worktree bit when
 necessary
Thread-Index: AQHUJamwnLXjdweqWEyG87p4nRwROw==
Date:   Fri, 27 Jul 2018 12:59:44 +0000
Message-ID: <20180727125923.11744-3-benpeart@microsoft.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180727125923.11744-1-benpeart@microsoft.com>
In-Reply-To: <20180727125923.11744-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25)
 To MW2PR2101MB0970.namprd21.prod.outlook.com (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1131;6:gNgfI7ul6hZp30UzDe6cmR0iGZA+8ipDc31cu5XDqJtjvMNzlWjZQl/5YBuG0hnm5Pp9pPkF321YjLopTIoYX71PieA+gGNwhc+AFPE0Ipd/kH+SJC9XIf5TMoY5iWywlXGGWSaXYMd27GZljxKoPXgfsLVaCb8HPZW+5qdANh4KxZLL71L9Qz0Dx428UCNxH5q2WdS/Tws42It0BtC57/peNOXj0TVPLRsIH/wabktslgfijzzPB5ea/4519viJvWueKaFEL7eh/7RpuhXOXR465XPuciuSZj5zZlhLHtmbU/CxrNmqkArTX+k9pf5ElywX2Ul6jdQLWLCLKrCBxxFV/RobOVk2zKN22vMLP8DFc5a+WPt2vG0rwTjnbGb/Xw9ez/PZFl7ctPD/J6pnK9PtdUPnuJVAO98L+luw2QctL9sqdjxR/0wVgWaECrfV/g4MbAlGLLADKbVES0BlzQ==;5:bOo81ymF3ngfYg5Is5lDcswG8INmZ7OU09O1LGVrmGxMC+bUuwaYsJLaxCGG6tkugM5nClwSEkDDOBbBDCCIFZarpKJAPeK3siWJW91N1FZTOnfp7YbvYeXHGlJs7Mgjsn5W+994HR32cB89Rt8SxszQjfWaXbSn8feEL80sth4=;7:Lj5ADKqiJ8+tlifP3icTlRv6SZTkF4fnfEITv3Qb1l4HqUjjMR1f6/f86yz07ger1BFB4FE/jfe+0aOVsEAlIMFftYijq21v4Ce0gh7kC1pDusTOKFjNWv5OFIMii7Remv//kOhSDW+3tHZOuhIX/umrnfAPXW+W+lFbRUYEmYNcIuHjgH7Z71pucq8cS06EL3T/jeIY71eS4WQ3ZPfp74ds+/eLMOJbBJsioM9s9Y954pHtiOp4cDgrFvahalgz
x-ms-office365-filtering-correlation-id: 8beef244-dada-46c5-344d-08d5f3c0d2c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1131E3B5105965C7667B5021F42A0@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1131;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1131;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(99286004)(1361003)(476003)(446003)(25786009)(186003)(5250100002)(14444005)(4326008)(256004)(54906003)(2616005)(486006)(26005)(52116002)(6916009)(11346002)(39060400002)(81166006)(81156014)(86612001)(8676002)(66066001)(53936002)(5640700003)(6512007)(5660300001)(1411001)(386003)(76176011)(102836004)(7736002)(6486002)(305945005)(6506007)(1730700003)(8936002)(97736004)(6116002)(316002)(105586002)(106356001)(14454004)(72206003)(2351001)(10290500003)(68736007)(3846002)(2501003)(22452003)(2906002)(10090500001)(478600001)(36756003)(50226002)(1076002)(2900100001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6/PZbCN5wqFV56KpwubM/IwWhQS0mTjxQuaOKFmXh9fXkx4ccRPG1onRFPZ0SfejJ17ZbQTPYwWI75DtMENGObjHqrXmW8e433mqGC2G+/fIRKkRAJq/kaAIlpBmH4fd7kbUd9Wl5zaYrETEiBW+R9iIPlfVxJGVx0FeYosQ2f3thWRdz6/QpoZig/dkfV81kOn+mGj5j2BD+fgHBL3MCZ0MCb07cS2ajqsWrC1dRyACFNOxBgTWQPXnAmq6k3733sFVBk2vJkiZQhGqKtsOGbXuYYowNZJ9jEG7KCgzzKw/MqLpOZA1Wl6zS3A0A5zTqzpUtzIJ3bZI0Kb9PKCu6CHRLb4UdYjkUxVBCINwNMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beef244-dada-46c5-344d-08d5f3c0d2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 12:59:44.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive takes any files marked as unmerged by unpack_trees,
tries to figure out whether they can be resolved (e.g. using renames
or a file-level merge), and then if they can be it will delete the old
cache entries and writes new ones.  This means that any ce_flags for
those cache entries are essentially cleared when merging.

Unfortunately, if a file was marked as skip_worktree and it needs a
file-level merge but the merge results in the same version of the file
that was found in HEAD, we skip updating the worktree (because the
file was unchanged) but clear the skip_worktree bit (because of the
delete-cache-entry-and-write-new-one).  This makes git treat the file
as having a local change in the working copy, namely a delete, when it
should appear as unchanged despite not being present.  Avoid this
problem by copying the skip_worktree flag in this case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c               | 16 ++++++++++++++++
 t/t3507-cherry-pick-conflict.sh |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 113c1d6962..fd74bca173 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3069,10 +3069,26 @@ static int merge_content(struct merge_options *o,
 	if (mfi.clean &&
 	    was_tracked_and_matches(o, path, &mfi.oid, mfi.mode) &&
 	    !df_conflict_remains) {
+		int pos;
+		struct cache_entry *ce;
+
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				  0, (!o->call_depth && !is_dirty), 0))
 			return -1;
+		/*
+		 * However, add_cacheinfo() will delete the old cache entry
+		 * and add a new one.  We need to copy over any skip_worktree
+		 * flag to avoid making the file appear as if it were
+		 * deleted by the user.
+		 */
+		pos =3D index_name_pos(&o->orig_index, path, strlen(path));
+		ce =3D o->orig_index.cache[pos];
+		if (ce_skip_worktree(ce)) {
+			pos =3D index_name_pos(&the_index, path, strlen(path));
+			ce =3D the_index.cache[pos];
+			ce->ce_flags |=3D CE_SKIP_WORKTREE;
+		}
 		return mfi.clean;
 	}
=20
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict=
.sh
index 45ddd81bfa..0db166152a 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -392,7 +392,7 @@ test_expect_success 'commit --amend -s places the sign-=
off at the right place' '
 	test_cmp expect actual
 '
=20
-test_expect_failure 'cherry-pick preserves sparse-checkout' '
+test_expect_success 'cherry-pick preserves sparse-checkout' '
 	pristine_detach initial &&
 	test_config core.sparseCheckout true &&
 	test_when_finished "
--=20
2.17.0.gvfs.1.123.g449c066

