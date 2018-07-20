Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2CF1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbeGTRW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:28 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:31488
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731000AbeGTRW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8UIT/BQ7dq4TjPmKc3RyAVstQaYJfQqmpoK9vmLf7s=;
 b=M+9lVZdeyOQvzRHdkCMApmcbU1sRmwr8U14Ev5tqVfoXJEL5ZOtSG0e/cTvlFvwBToaryVhnZld4qQW0U0D/j9POnjxaed13vvZZn7FPWgD4HGaGULbChOQBs+wtUtX4WSNZAhMMY4XixVr7ot4Jggx7xYtas0CG+rp/BV5Jhyk=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:12 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:12 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 07/18] upload-pack: generalize commit date cutoff
Thread-Topic: [PATCH v2 07/18] upload-pack: generalize commit date cutoff
Thread-Index: AQHUIEdZxomH8I0Q0UmjTKG685EPiA==
Date:   Fri, 20 Jul 2018 16:33:12 +0000
Message-ID: <20180720163227.105950-8-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:yz1eMn2t4cOqiw2ib7ugJYnWc/L4qEEr9IZoCGb9L8fOatbB9Tmh+NQPhv5L+aprgdaAYplq8mFa52VnOCFrCu9/P+vgj2j7/xpYTSrQofDa8X/yCKyIvqlu9j1lahaBGfFFL08V0NiLmAODuKueiO73QP/QCKT1M6+tSl9kji40QQVK/EJQ6w/jtnq0tnCU14rp2DpfKxB/KBpUNiMuYuWiGz4iLeGRwrEZTXLob0376Uftdo2A79SPCos+CW6If+zgcT6v58NcUZpn2oDmAGMj2aVhi9X31mJMV2Urmg9PH5Wq9Dxzg3t3CFBZEuLXThuO3VPSWv4sgBC/nXkbkI5NjRJUJAoS7KH7G+47jWylgI+PHFyUnaqINzszLY/heg8S4XHLh8YrARqcRbJopHHzlR6e3MLkjWaneb8tt51mgfI59WlIqeZFZ7DpGoACVxSL9NIpAjzsm6Yaj+Jiyw==;5:D+fNQLet6IEfgo1vKIcAdzlT2/gfELEqa71e+5qHtx776LeIrDQv6rOMlgXcEZpQ3gdlCoKUsE2c5wvl11HR+6e+OE8JsDM17aGO+4zukPqtnXIqFJaQeLkfayhD6YdEzPVtmY1ETdfKlsZt6Ag3mqWG71Jd3CmKsWtkNvl23aw=;7:LvmhdwiNtXG/M7x+NvigidL8B74gR9YbK8uoaCBF7L113mz0lIt2MuWkb8THmSEah1UpXMlgn5Wpd1BrH5SrwKNU2gH8dnkil/e4NraGToi49QPZQr6BiZfMzfzfZc/++GP6vXpWZ6R1T2sInuesv3UtZb6q47icofS8pj4B+IyrVXz+HuRDTGHypIWYDtida/xD/1iqoxjSd5js95S12n27ugTBlEIL67gcA47uyQrAu/RHMlSl3bS23AtxcYuD
x-ms-office365-filtering-correlation-id: f6261a06-ac1c-4e2d-5965-08d5ee5e7c10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB092918112DA327CE587BC5BBA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: coNfUUDjHTuQA2Xzn+fzuoTt2LZM98FquA1oLJL8d8fX0/jgW04rLylRCliJwlY6u8OOhOuKzo+fmfNYbXegzGsWChWo1sqqmek2YJIrr1Ep7J8wByLkUQcwH4Qidzpr1gQt1VHyB3+I6Gw6FO9YGRvkDwFGLxRrRk6cFCUwFEoxcWAxoLEf2TwRPyVzhyZDTUk+gCAu2hyD5D1T8V5y6t7pmUXE2rj8NqGFgHgEK8HwrWxibCt5RLsKYgaqJ8U3hOY5vMohrrd3wZuTzihpbv8O4f7ELqM/yuu0MLu0F8GKnCL8gpTkaYZGZeKiPD3y5vGDWpgfOiHoHq2hUMhvHRUb3lMswC7ugbR3C7eiXBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6261a06-ac1c-4e2d-5965-08d5ee5e7c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:12.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ok_to_give_up() method uses the commit date as a cutoff to avoid
walking the entire reachble set of commits. Before moving the
reachable() method to commit-reach.c, pull out the dependence on the
global constant 'oldest_have' with a 'min_commit_date' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 9fe19003c6..427de461d8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -337,7 +337,7 @@ static int got_oid(const char *hex, struct object_id *o=
id)
 }
=20
 static int reachable(struct commit *from, unsigned int with_flag,
-		     unsigned int assign_flag)
+		     unsigned int assign_flag, time_t min_commit_date)
 {
 	struct prio_queue work =3D { compare_commits_by_commit_date };
=20
@@ -355,7 +355,7 @@ static int reachable(struct commit *from, unsigned int =
with_flag,
 		if (commit->object.flags & REACHABLE)
 			continue;
 		commit->object.flags |=3D REACHABLE;
-		if (commit->date < oldest_have)
+		if (commit->date < min_commit_date)
 			continue;
 		for (list =3D commit->parents; list; list =3D list->next) {
 			struct commit *parent =3D list->item;
@@ -372,11 +372,13 @@ static int reachable(struct commit *from, unsigned in=
t with_flag,
 /*
  * Determine if every commit in 'from' can reach at least one commit
  * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
- * as a marker for commits that are already visited.
+ * as a marker for commits that are already visited. Do not walk
+ * commits with date below 'min_commit_date'.
  */
 static int can_all_from_reach_with_flag(struct object_array *from,
 					unsigned int with_flag,
-					unsigned int assign_flag)
+					unsigned int assign_flag,
+					time_t min_commit_date)
 {
 	int i;
=20
@@ -395,7 +397,8 @@ static int can_all_from_reach_with_flag(struct object_a=
rray *from,
 			from->objects[i].item->flags |=3D assign_flag;
 			continue;
 		}
-		if (!reachable((struct commit *)from_one, with_flag, assign_flag))
+		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
+			       min_commit_date))
 			return 0;
 	}
 	return 1;
@@ -406,7 +409,8 @@ static int ok_to_give_up(void)
 	if (!have_obj.nr)
 		return 0;
=20
-	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE, COMMON_KNOWN);
+	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE,
+					    COMMON_KNOWN, oldest_have);
 }
=20
 static int get_common_commits(void)
--=20
2.18.0.118.gd4f65b8d14

