Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C8C1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966412AbeF1OAK (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:00:10 -0400
Received: from mail-eopbgr680107.outbound.protection.outlook.com ([40.107.68.107]:45335
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966094AbeF1OAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+P1LBJNRxmUxpu1nkjTUgyYnkhID9ZPdUlLgZMP59k=;
 b=Xj4ZciUodb2j8z4oW4y23cx7UdA1afxPTcaueRq0ym+qY8NTASjc62AaL1tw8J5WgeXP85vNV/P0aZqEZgi8prEoH3Va0sdvw6HOIdygYOQhdEZM8RYM4pXVur36m4o01ZFMU+Dyg7/c5GdZRr1+YW2cTPbHQaosNtP8fRtwZyk=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.5; Thu, 28 Jun 2018 14:00:06 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 14:00:06 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: [PATCH v5 1/8] read-cache: teach refresh_cache_entry() to take istate
Thread-Topic: [PATCH v5 1/8] read-cache: teach refresh_cache_entry() to take
 istate
Thread-Index: AQHUDuhRYMir3c/tfkuENpksLGqNOg==
Date:   Thu, 28 Jun 2018 14:00:06 +0000
Message-ID: <20180628135932.225288-2-jamill@microsoft.com>
References: <20180620201557.77155-1-jamill@microsoft.com>
 <20180628135932.225288-1-jamill@microsoft.com>
In-Reply-To: <20180628135932.225288-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:405:6f::12) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0137;7:Bj62fErYuVO5psxe/wvdXlU5kO19Ok8SPCXrhO6jbtFTzO3b2O4oCnvEaroZqgcLGMYXjfzI1Dxl26ZEWeR9R0f6SO0lgi+cn3G23XwECPVrGNIfOt2eS+PPxMMQD+nKgWc4Nx2foDKA9uOI4nhBQkgj9R1QoNk+P83DIzTc18LwLgHYrHhq3Ggv+M3i/DVhBnr8clhoEX89kpv2Ix93UCDtdKnRsToFwQtzuCowlQHZFqnadql5st4yJAIxLuyp
x-ms-office365-filtering-correlation-id: d15bf124-45ae-49a7-d04b-08d5dcff73d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0137;
x-ms-traffictypediagnostic: DM5PR21MB0137:
x-microsoft-antispam-prvs: <DM5PR21MB01371D22231504A232208999CE4F0@DM5PR21MB0137.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0137;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0137;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(54906003)(86612001)(25786009)(4326008)(10090500001)(6862004)(106356001)(256004)(39060400002)(14444005)(105586002)(53936002)(6512007)(6436002)(6486002)(36756003)(5660300001)(7049001)(2900100001)(97736004)(486006)(476003)(2616005)(11346002)(446003)(68736007)(81156014)(81166006)(8676002)(7736002)(305945005)(6200100001)(6116002)(1076002)(14454004)(8936002)(2906002)(316002)(22452003)(52116002)(99286004)(1511001)(5250100002)(37006003)(6506007)(102836004)(386003)(10290500003)(6346003)(46003)(575784001)(86362001)(478600001)(76176011)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0137;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: sa/vZumhAzlmVUoxPXgu90ie7aLcDe9H6+Y1yC3t9uz9Q6+Kqlm7pg1l6tXQXVZ8Q5PxtZWfBdpJIS3uDJf8z8SjsuOLkL5r/Ejmnv6GxcLOB75zV/ycUUSlynINaTcnZi5+k04VAgZudBhxsKr34n7hYqQOH6xnRMi5NbeDex8I+4kD8VKQLNPbbICcW0NtKR8mlV7+ILw7uGPBVJwjtRDh4Xtdqx5QReGlRJzeOdNCi2tG+Y9topPBQKBw4YDhLOk+3WsHrRC0E3dLvyZB8fLih3im3sDxxTJgYleXt4fom6mKZjG0NFJwHSb+AoWQx+j8TKFXfF6yo8BfHagPnnvvRQxqDAbbyEaUG0K7wiw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15bf124-45ae-49a7-d04b-08d5dcff73d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 14:00:06.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0137
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor refresh_cache_entry() to work on a specific index, instead of
implicitly using the_index. This is in preparation for making the
make_cache_entry function apply to a specific index.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 cache.h           | 2 +-
 merge-recursive.c | 2 +-
 read-cache.c      | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94d..93af25f586 100644
--- a/cache.h
+++ b/cache.h
@@ -751,7 +751,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce=
, struct stat *st);
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs up=
date" */
 extern int refresh_index(struct index_state *, unsigned int flags, const s=
truct pathspec *pathspec, char *seen, const char *header_msg);
-extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsig=
ned int);
+extern struct cache_entry *refresh_cache_entry(struct index_state *, struc=
t cache_entry *, unsigned int);
=20
 /*
  * Opportunistically update the index but do not complain if we can't.
diff --git a/merge-recursive.c b/merge-recursive.c
index bed4a5be02..8b3d6781c7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -326,7 +326,7 @@ static int add_cacheinfo(struct merge_options *o,
 	if (refresh) {
 		struct cache_entry *nce;
=20
-		nce =3D refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSI=
NG);
+		nce =3D refresh_cache_entry(&the_index, ce, CE_MATCH_REFRESH | CE_MATCH_=
IGNORE_MISSING);
 		if (!nce)
 			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge a=
borting."), path);
 		if (nce !=3D ce)
diff --git a/read-cache.c b/read-cache.c
index 372588260e..fa8366ecab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -767,7 +767,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_namelen =3D len;
 	ce->ce_mode =3D create_ce_mode(mode);
=20
-	ret =3D refresh_cache_entry(ce, refresh_options);
+	ret =3D refresh_cache_entry(&the_index, ce, refresh_options);
 	if (ret !=3D ce)
 		free(ce);
 	return ret;
@@ -1473,10 +1473,11 @@ int refresh_index(struct index_state *istate, unsig=
ned int flags,
 	return has_errors;
 }
=20
-struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
-					       unsigned int options)
+struct cache_entry *refresh_cache_entry(struct index_state *istate,
+					struct cache_entry *ce,
+					unsigned int options)
 {
-	return refresh_cache_ent(&the_index, ce, options, NULL, NULL);
+	return refresh_cache_ent(istate, ce, options, NULL, NULL);
 }
=20
=20
--=20
2.17.1

