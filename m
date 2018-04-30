Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F320215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeD3Pbp (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:31:45 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:22710
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754524AbeD3Pbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=00xnzm5Y0FAd2zjGYMOep57I2Zh6dsa1RXD0GjOCEb8=;
 b=RNS7d//wyYF7wcfZMWeuxHDBvMcL5WFaRJt7z9CyEvBd3w4l9krB0GyMZBhgmra2oqTz1oQg/pGw/t32+GOuFvv9gXXnGhRJozIqiNDO7Z8fIDXQxPZaUWbtQ3+yyNE5fsgUGiBt/NuYdPr3gc4bS5wyUr9t8VQrfZemER5eT14=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Mon, 30 Apr 2018 15:31:41 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0755.002; Mon, 30 Apr 2018
 15:31:41 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 1/5] read-cache: teach refresh_cache_entry() to take istate
Thread-Topic: [PATCH v2 1/5] read-cache: teach refresh_cache_entry() to take
 istate
Thread-Index: AQHT4JhWY6wuFrc8/UGVXPnqxflQkg==
Date:   Mon, 30 Apr 2018 15:31:41 +0000
Message-ID: <20180430153122.243976-2-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180430153122.243976-1-jamill@microsoft.com>
In-Reply-To: <20180430153122.243976-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN4PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:403:3::17) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:LYA+fBz4qs1irT7r0UM5N0DjcyqkP9SpgBWZhnzV8xTv+3K9l1+esaiRV7KmtuLbOUE9z6+Rw0b6sYq8CVzfiHpRVAcpEyR2pFYq7VSFUGa3PGNyEz3hC2DlgvuPFy096qedfHqHIy7ebPidwIHxFyLoXEPiNF/xmHptkB8VzC9SWdgBic3AgY98NULgwbbXX5QrayNFznVojWuM5xS5IdI8eT7O5y+wszWypd+FJ+6Z4x46P7hsYQuk283kzX3+;20:6i+qRrlFM6fC1whmyUAeMZMQPNU1Bntdy+IeUNO12Pz6UwN9bPvEmlWA+brnkoQyf0bi4R9egN7jQw0P8GZVCkAQPPHAuIOHfv7c9GQE/+FcobGkPP7IXz4NKCXw9Ab8sF2HU0BDkHxsLK+Ye4qniD9P9XUajn+Z2l0PcSC8XLU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10128BE1D70A48E0A611BB5FCE820@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(10090500001)(6506007)(3660700001)(386003)(59450400001)(1730700003)(7736002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8936002)(8676002)(186003)(3280700002)(476003)(2616005)(97736004)(446003)(11346002)(6116002)(86612001)(106356001)(46003)(99286004)(4326008)(102836004)(6916009)(105586002)(76176011)(1076002)(107886003)(2351001)(14454004)(54906003)(2906002)(6512007)(2900100001)(53936002)(36756003)(5640700003)(10290500003)(316002)(25786009)(39060400002)(8656006)(478600001)(68736007)(22452003)(5250100002)(486006)(6486002)(575784001)(86362001)(2501003)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8vkmAZmjjNMfwbtUBW0uOey1tM/qpIQIaWzwGWidsrO+ZCN9xe65fkVKAN1OPhUuFUBZe3NqbTtTySJGyRkQP+0DwjOgj4PO8USU1+A786WfUvSBi1/kkgD4tUgcZwHhP7m0qOYNk7L+VxXkL1OltRw8fgi1f9xv5DOQCU6HrseF4vohzT6vLjLkLSLkH+pQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4f0bc339-abea-4d88-137c-08d5aeaf789a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0bc339-abea-4d88-137c-08d5aeaf789a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:31:41.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
index 77b7acebb6..31f8f0420a 100644
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

