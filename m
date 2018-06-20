Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A3C1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbeFTUR2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:17:28 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:9494
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932755AbeFTUR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpRDCWSJezV1mepmLhf1JCm6merwd77sBgSn6K+YDRU=;
 b=StL5NI1LNXtDmHtJqHERBuPYhEr39Cg949RDNEFatu6oqwwwuuY6660R67DIal4qwUWMIX5TuM7GVDv9ZQBiS5RuP6Nv+nOsx5hw4mU6pllUgs9vQHA/kXXdn2OPR6uvjYTo1oIWjOKIuDKya8qy6n1q89CLFi6vPd7nQGYX2/w=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0283.namprd21.prod.outlook.com (10.173.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.10; Wed, 20 Jun 2018 20:17:24 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::6ce5:a314:3fed:d0cd%6]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 20:17:24 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 1/8] read-cache: teach refresh_cache_entry() to take istate
Thread-Topic: [PATCH v4 1/8] read-cache: teach refresh_cache_entry() to take
 istate
Thread-Index: AQHUCNOz9erVOOExbkWNBiPG5r01UA==
Date:   Wed, 20 Jun 2018 20:17:24 +0000
Message-ID: <20180620201557.77155-2-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180620201557.77155-1-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0283;7:nmZDU2R47p/vSDBM2ztnDXn1KHH9ujt9R2N8GXh/3j4Xcz2i+cQHD4Tt6ol8T+j8/+WHmRnVg9qu4XBvioTPcWYJKZmr1cJpoF//AYv/43x71FcqVs5BM3QRxjZIQw/g63HhBu4g0K814LkjTdOQOHWnYaQlMgOyDhfhU+xVqeyGDNQtJgtQfS7gfLwgMNl++xUBubiXz3imKipXJYnPZ+SwrnpmW3wHNnCRQPxntPY4nMISysm3d+D2Nlp435sy
x-ms-office365-filtering-correlation-id: 8f473704-0018-4dc7-9ccb-08d5d6ead5f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0283;
x-ms-traffictypediagnostic: DM5PR21MB0283:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0283B08FF16067050F08A4B5CE770@DM5PR21MB0283.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0283;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0283;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(189003)(199004)(102836004)(2906002)(186003)(3660700001)(476003)(11346002)(486006)(2616005)(446003)(36756003)(5660300001)(3280700002)(76176011)(6506007)(386003)(68736007)(6916009)(59450400001)(5250100002)(2351001)(2501003)(25786009)(52116002)(4326008)(39060400002)(8656006)(7736002)(6436002)(6486002)(6116002)(575784001)(305945005)(2900100001)(316002)(106356001)(105586002)(22452003)(10090500001)(81156014)(1730700003)(8676002)(81166006)(54906003)(53936002)(86612001)(10290500003)(478600001)(8936002)(97736004)(86362001)(99286004)(14454004)(46003)(5640700003)(107886003)(6512007)(1076002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0283;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QjOjvxqrElDxl/ckL9mJLHsIfUrKSC05vqIQRF7HCscFuXr3vkriIF3WWXepMfXNYSj2a5faQ45lvjZVkJpuhemyap7HGB8LyeVtvIKbXGwmxU/iZhWFgTWIYMeeIJDohhncU55IA6o0wDNTbvJ1p1cjc4XxzgUBSSTLEoL8MYp1JlkV/ccVo1fwBSuopaNU/9bgdfKlTWh7yKVxmtMvlVERGCX/spH5WW6DmW7xqrT0mn7AGBS57cPaMzFjSeviRTjIkZd6e22/Rw0+cPtAChRo4vFOpb4KPQMvN6wiHAhasmslw6CFr3o9juruPDTgcIeNLrhJ9KCxAEC8KXCwhg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f473704-0018-4dc7-9ccb-08d5d6ead5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 20:17:24.7395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0283
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
index 89a107a7f7..9538511d9f 100644
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
index f110e1c5ec..11a767cc72 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -323,7 +323,7 @@ static int add_cacheinfo(struct merge_options *o,
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
2.14.3

