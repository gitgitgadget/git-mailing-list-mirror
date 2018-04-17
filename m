Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDF01F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755246AbeDQQe5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:34:57 -0400
Received: from mail-dm3nam03on0115.outbound.protection.outlook.com ([104.47.41.115]:40619
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755110AbeDQQeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Glxqm7MgDHcSb/V3c8EHS1AlCZ61ZdpTCeMhqUDnR/k=;
 b=R0ftkC4oKVBcDjJtP7+oKMqdWx7LXRzO6iOcJqYDYYV4lpWchKsu79tTq33zMBWFiKidOOEv5gGIcTni9tmxkVIdQz5swSE6LPem72o3lwquxvvs3d9m2/jP4JAY+ZwgZcM53Vf/iyJKxRnx/d4TMuGZ1aiBhM/Ucsd+1DFitzY=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0899.namprd21.prod.outlook.com (52.132.23.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Tue, 17 Apr 2018 16:34:41 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0715.004; Tue, 17 Apr 2018
 16:34:41 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v1 1/5] read-cache: teach refresh_cache_entry to take istate
Thread-Topic: [PATCH v1 1/5] read-cache: teach refresh_cache_entry to take
 istate
Thread-Index: AQHT1mn7D7PkDYJQx0ejQKGIu73Tdg==
Date:   Tue, 17 Apr 2018 16:34:40 +0000
Message-ID: <20180417163400.3875-3-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0899;7:Ae++85Iut/ioLhmaG9jcZcl0enV4IpqtibowpziT6XCs+yYRY3UGsBS2r1jJZibiYQQC9bDi42GDT4uQ4k0b/RxrPwf49B27K87x8OZ7NjKSK8JG9PorILWtle39sjKwG6yybcGnQOzN/WI9OLU+6W10aVwNDmxza3JMlUOrztoFxOoQ/bM/j514vFeuoptbzQMOrRko3fmnVJRskQ/Y+SoS01NNmCGwsdAubghONKcVGRIfPYNAGsZgpEtXo5pX;20:LBvPCZ/+tVWIySZAubbkfktTupxldPDfoZaXJeHbDBypdA4ZvwWiwzRb7rIQLr0XgHUyj/lSoIjOHa+nz4ujoVByRaPuEOKesfXVQ8iW2NkAkD/RDF30nPhhGXqVJkgpgG1drkk5mbDqnaYWgffCG7gWqVLXJlRsnQjXLCWCd6w=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0899;
x-ms-traffictypediagnostic: BL0PR2101MB0899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0899BA693AE298E8B4088324CEB70@BL0PR2101MB0899.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0899;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0899;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(6116002)(5640700003)(2351001)(14454004)(6512007)(97736004)(8656006)(6486002)(53936002)(2906002)(4326008)(5660300001)(106356001)(39060400002)(6436002)(36756003)(107886003)(6916009)(305945005)(1076002)(3280700002)(99286004)(22452003)(478600001)(59450400001)(316002)(476003)(446003)(2616005)(486006)(54906003)(6506007)(5250100002)(386003)(11346002)(10290500003)(575784001)(2900100001)(3660700001)(81166006)(81156014)(1730700003)(86362001)(8676002)(8936002)(10090500001)(186003)(68736007)(25786009)(46003)(86612001)(52116002)(76176011)(102836004)(105586002)(2501003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0899;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sAsF0cDOoG6aZt867RBcigDwQBQ3sXRxh+EoWzLCMCOkpfO8IrPY4CnWAIFAnlgrqiHlbfyYgkKc0+lo+mfYFG8iVycTsSNBW48fSp2BSFQOECffKoLRPQTjWXM7VPwJK6FUZ7yZpDXhbV2uCDCYMg+RVBXU9nF1m1Fn8+rElzaVHb60SpiBOudxFbtHXC87
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cbdfea7c-e759-4124-547f-08d5a4811dd4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdfea7c-e759-4124-547f-08d5a4811dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:34:40.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0899
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactoring dependencies of make_cache_entry to work on a specific
index, instead of implicitly using the_index. This is in preparation
for making the make_cache_entry function work on a specific index.
---
 cache.h           | 2 +-
 merge-recursive.c | 2 +-
 read-cache.c      | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index bbaf5c349a..e50a847aea 100644
--- a/cache.h
+++ b/cache.h
@@ -743,7 +743,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce=
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
index 0c0d48624d..693f60e0a3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -260,7 +260,7 @@ static int add_cacheinfo(struct merge_options *o,
 	if (refresh) {
 		struct cache_entry *nce;
=20
-		nce =3D refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSI=
NG);
+		nce =3D refresh_cache_entry(&the_index, ce, CE_MATCH_REFRESH | CE_MATCH_=
IGNORE_MISSING);
 		if (!nce)
 			return err(o, _("addinfo_cache failed for path '%s'"), path);
 		if (nce !=3D ce)
diff --git a/read-cache.c b/read-cache.c
index 10f1c6bb8a..2cb4f53b57 100644
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
@@ -1448,10 +1448,11 @@ int refresh_index(struct index_state *istate, unsig=
ned int flags,
 	return has_errors;
 }
=20
-struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
+struct cache_entry *refresh_cache_entry(struct index_state *istate,
+					       struct cache_entry *ce,
 					       unsigned int options)
 {
-	return refresh_cache_ent(&the_index, ce, options, NULL, NULL);
+	return refresh_cache_ent(istate, ce, options, NULL, NULL);
 }
=20
=20
--=20
2.14.3

