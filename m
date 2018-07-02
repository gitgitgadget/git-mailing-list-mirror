Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CABF1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeGBTtd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:49:33 -0400
Received: from mail-by2nam03on0132.outbound.protection.outlook.com ([104.47.42.132]:33952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752770AbeGBTtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+P1LBJNRxmUxpu1nkjTUgyYnkhID9ZPdUlLgZMP59k=;
 b=YrT7ok4oTMUjhItLAHh2j/sHEs4Ur1HJiqbBqNWH2Fi7pyjJhv/A3pgvaTW0BCeAO4alW2Ora0rIvLswKsOeOQBcK2wTdxZHgm7XcVtln801V2G847uPAES1/f5eINdBiAIygXtmdDJTuc/HzKRhCgAWrx5pcV11L0K0N0Rhk84=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 19:49:29 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 19:49:29 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Jameson Miller <jamill@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>
Subject: [PATCH v6 1/8] read-cache: teach refresh_cache_entry to take istate
Thread-Topic: [PATCH v6 1/8] read-cache: teach refresh_cache_entry to take
 istate
Thread-Index: AQHUEj3J+2uyUmsFA0KaQWwzlZR3gw==
Date:   Mon, 2 Jul 2018 19:49:29 +0000
Message-ID: <20180702193745.8940-2-jamill@microsoft.com>
References: <20180628135932.225288-1-jamill@microsoft.com>
 <20180702193745.8940-1-jamill@microsoft.com>
In-Reply-To: <20180702193745.8940-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN3PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:400:4::25) To DM5PR21MB0780.namprd21.prod.outlook.com
 (2603:10b6:3:a5::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0284;7:ap78pW4uFptMQE2nUGj+xJRXvTP81bK8tkPYspKfcxWhWcLi9dCujJNpKEAjyrgnC6gNzsfeyoUQmSg/82LZFppHusVv/gRuheS9lNZre3IN1iBpsEq5ouVgI6ITjt9Vt5qUN+t5hs2qjRWPjjFxS8wSBq/ge+P782LqejlO1LZMoRw8Sr5QRjJahSqCkjGcXOs7U0jQc75RPjYSxRj8pM3CWblLCwS1dNe1YXwmNSNxcQBeEoysmIJV/muAMJpg
x-ms-office365-filtering-correlation-id: fd53ca8e-c9b6-4e28-a2ab-08d5e054ec2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0284;
x-ms-traffictypediagnostic: DM5PR21MB0284:
x-microsoft-antispam-prvs: <DM5PR21MB0284D97A19C223500C54BA49CE430@DM5PR21MB0284.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0284;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0284;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(36756003)(316002)(22452003)(86612001)(37006003)(86362001)(54906003)(14444005)(256004)(99286004)(446003)(11346002)(476003)(575784001)(2906002)(2616005)(10290500003)(4326008)(14454004)(25786009)(39060400002)(6862004)(486006)(10090500001)(53936002)(478600001)(5660300001)(76176011)(5250100002)(102836004)(6200100001)(386003)(6506007)(6436002)(6512007)(8936002)(305945005)(52116002)(68736007)(1076002)(2900100001)(105586002)(8676002)(81156014)(81166006)(6116002)(7049001)(1511001)(97736004)(46003)(6486002)(106356001)(7736002)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: etTeDw3Ry/AOhSuHy4JEkdbKoKDlBVOBk5EwwOdKyiNuLisVxGkFUTfluPgieNWNAut4pHv+aczEHywjWbROEuLjhJhuZg/cx2NfGxW6H9YAqhOcMzTCQgbgZuL+KoJV7zKqdK5HPJJC3Yh6Z5SYaLuC0iVQY+msJSEYrOPa2aVsbMHj89ZTUG3J04cbOie9NpXHOPxI+HAuGieKaO13QHpfLBgno3ST6xS/9n091GU1ydgXzjKQW9fABZXe/QUQ9zyFJs5eGsIVQbHjN9HtWr0S6n8Kbgk4i3f7/vlYrnF/C2iRHeb/P4VQNfEUE6Oq+n4QiKX6mLXmgnLtY97YKisfi/jRrislJ3+ym0NTqdo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd53ca8e-c9b6-4e28-a2ab-08d5e054ec2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 19:49:29.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
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

