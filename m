Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2D41F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933151AbeEWOrk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:40 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:61824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933149AbeEWOrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn2dYvciOHWzzpa9BvfSxUUUShlGWbckScXSuQUokAk=;
 b=NBN8IJKlGa+wG6/X7pLgidkv3qqI1f2lYI05D2y1ndaKByevm4OX1JKw9SGkgGBE2hFxqhDJrrajgQZR7oFOU6BBKSgGnnpjOLQcyS3U7u/Ibn55vxrclpwrowQSqRw1tM90UBNA2nWvdF67wE3EIeyGR09bXIpxxif6tU6CdUQ=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0977.namprd21.prod.outlook.com (52.132.20.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:35 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:35 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 1/7] read-cache: teach refresh_cache_entry() to take istate
Thread-Topic: [PATCH v3 1/7] read-cache: teach refresh_cache_entry() to take
 istate
Thread-Index: AQHT8qT8/RshLiLbwUiSc5+JmuiOmg==
Date:   Wed, 23 May 2018 14:47:35 +0000
Message-ID: <20180523144637.153551-2-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180523144637.153551-1-jamill@microsoft.com>
In-Reply-To: <20180523144637.153551-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR1801CA0033.namprd18.prod.outlook.com
 (2603:10b6:405:5f::46) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0977;7:n5LNpm+iroHiAn/6ZJAPmi4qzySQ04354l+LbjJ86tkc8jP39IXAYCPMHygfAVCc5peP6P2wic1nNToWiPX/G6iP6QUzH9VMo07V9lo/ljJp9JGuQD2l4HvCxNX8HKDl7foeyWABVwu47WNm/JYqfzg4g3NNTv2y9FFOWFJlK/h4tm5qpavV6ePeQoAiz7VeVFfEGX+L8Drwlpeds5IrAnRxvctufIcr/TOZ1OSnC0jBWvxXFshMAuli54zJcA4C;20:dAvF9TbqNy4pwPigE2WKFCgKHqv0ix6qGnfmse5MOpQnJexRJpbPJyVFaaXJxISBo0h1p6n4GAqPmxm3yEx/2i+X+yGmqFevxtX6YthAEsQ6RTFVV1Hp4ASepTrA7u7pIu/lYv5kj3GMTM73sYgomZkKbLU6/3zXpU5UsRivBuM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0977925E2763DB5FED62265ACE6B0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0977;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0977;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(76176011)(102836004)(99286004)(59450400001)(6506007)(386003)(2501003)(5250100002)(81166006)(81156014)(1730700003)(8676002)(105586002)(8936002)(305945005)(106356001)(97736004)(7736002)(86362001)(476003)(25786009)(575784001)(2906002)(3660700001)(1076002)(14454004)(486006)(3280700002)(6116002)(446003)(11346002)(186003)(52116002)(2616005)(86612001)(46003)(10090500001)(6512007)(53936002)(2351001)(478600001)(36756003)(5660300001)(4326008)(6916009)(68736007)(6436002)(5640700003)(2900100001)(22452003)(316002)(54906003)(8656006)(39060400002)(10290500003)(107886003)(6486002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0977;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VCQHI1eL0QzBVNtCCDpM1n8VMvsMZwkjSB7nOjIyq+h/zGEshq86b/mVOcWEql0BLhVGt3v+5cNuGK1efqgLOr8/KgXlRnDBhzOpLCDJN4QO5ipXlbriQsrNtD9+nZrc35CWwUzBkRFgw0HX8fEO7Z9ahXlzecp8669k5dPd0ye40UYlJ0G8YE3yxHOxSFg6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1219066d-08b6-4344-469b-08d5c0bc1eb6
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1219066d-08b6-4344-469b-08d5c0bc1eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:35.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor refresh_cache_entry() to work on a specific index, instead of
implicitly using the_index. This is in preparation for making the
make_cache_entry function work on a specific index.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 cache.h           | 2 +-
 merge-recursive.c | 2 +-
 read-cache.c      | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 0c1fb9fbcc..f0a407602c 100644
--- a/cache.h
+++ b/cache.h
@@ -744,7 +744,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce=
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

