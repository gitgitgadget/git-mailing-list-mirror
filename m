Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142621F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHTUIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:32 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:59456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbeHTUIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSWXjEJpF4ALImeoKN+Pt38uIaS83LJ4iyw93sVQsBw=;
 b=PfMpw0370Aj8AYa/plk3rNHqjavKo8AV+dVoQNFeRSQUPFekMFQXV9a8qPiiiC746Km38yvy5IkT+zekor2fuC3/Hhrn6QYTT7JZaujU9VFIo9OYsmmQH7QAS5h5o5kA3uegK4SH8D+FCJNLrJ/wZ3mRErZRYVvXop77vESB6d8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:51:57 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:51:57 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/9] midx: mark bad packed objects
Thread-Topic: [PATCH 3/9] midx: mark bad packed objects
Thread-Index: AQHUOKYbuKkXGsPMA0Wm7AZcIhYIKA==
Date:   Mon, 20 Aug 2018 16:51:57 +0000
Message-ID: <20180820165124.152146-4-dstolee@microsoft.com>
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:wBwtyilLIEeJKBMz1aL1c5IhridINgLs3nFm8EYmyPBpMHAd9jwMYHJVqoLM2W1H/ZIor1PBmLzGCnFKNVmfUPyM8DB623JiRVP9l7AMoc3eIE7nQM9Lryok7eevY5QmUbHBpclbS+EYt4bAuW4wxVWe2u3VylbX67ZShuKFKb/HUV6Rm1HnCTSuoerHtM8NiH8ZT4p8JipJBqVgQJFJFW6WUzTjlKOyHHMi2i4H2SVnqb9zHTBZPEtzJaQosP5ceap11fWRL79Z57o8OC4SRDtDpp9dq5Tl25S/ULtUZ+ShhF6Bm7701n8C1a9Pyt00JZf2rGv5/zfkAJnz1zMX1kLmuXztyI7czDrxDrHtnxUfXuouZaW0Lpp5ec5pM6ig3k50h/DKmkuBEkkNaufiDAYviCdjWWW9JBl8mj0uB5LgYislA2MrmhdZ7S1JSYlMv4/73zY4sRPW4fy3n0JbCA==;5:xzJwUF1d/qRaINus6Zo6mnx2z5RZmZrVTjJxxYOsnPbCuWtGfBHu1jRMIKQNr26/cH4UbRe4G+nsEftB5nGjF0ecPmyhhKDzAEt+CsJdOTT6bG0+XJ78WzJgZxtqXBVq4u2DONy2sfQnbvGEMugELDzPmxnCZiYRjvILnFJOqZY=;7:LZO5uPZI35K4pnZDuDkQjperwLPuM1dJMYQJXSr7D3rWj9oYOpKBwimXHvAmeKQaqqonSzLA2Ykrs3pRRgXP23CqQsvPIofMvG0gyv3INIXgxYnPvFRl1It7YaxS6yzM87m4KFXovISsCk3F6tmifXuBxwsxBAKCvsfeWyxRSTc8rAwCOJibaPUrfqZMQG2HLujUwhSwmRPfyI9NnmYwrm9O4woQW59ZbtLsugzZf0EPJk6eUn0wvJnHTmoO5Rkq
x-ms-office365-filtering-correlation-id: bf76238a-a0e9-4a8f-cee9-08d606bd3d5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB0962E29E09CF48D9B17D3356A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(14444005)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: Aum42sxrRK3ucYduZ9q7udfI+51jxKAm6sH/kR/Ftqgre5vEQ0t4ZRphK9duYwmds9x0gYHOr2upmkMRWBPJaKwBE7rRwJ15QA++ybBJkbbe+qfx7t21/3f/ooZhiEpFluqROs3s84QruvUnIM9fXgFcIDyY8Vx9RQxW+XgTmP8nW7Lx9khW1e5uMOzJlSnYOFNQV1ibd3ZcNGBmRMTswBrL06O5KrYdvm28wRPwhAo8rSJStGNwzgrAKpZYCfRP7MSFB2Uw9Dqgeegi2CwPQNccaLISTAmJSC4ltp7YDlIdPep7G2kskC9rgGG+M0vKV6bVq1B2ZOFjivbpmq0uTt/AqBW9A1luL99i8lddNCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf76238a-a0e9-4a8f-cee9-08d606bd3d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:51:57.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an object fails to decompress from a pack-file, we mark the object
as 'bad' so we can retry with a different copy of the object (if such a
copy exists).

Before now, the multi-pack-index did not update the bad objects list for
the pack-files it contains, and we did not check the bad objects list
when reading an object. Now, do both.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/midx.c b/midx.c
index 6824acf5f8..7fa75a37a3 100644
--- a/midx.c
+++ b/midx.c
@@ -280,6 +280,16 @@ static int nth_midxed_pack_entry(struct multi_pack_ind=
ex *m, struct pack_entry *
 	if (!is_pack_valid(p))
 		return 0;
=20
+	if (p->num_bad_objects) {
+		uint32_t i;
+		struct object_id oid;
+		nth_midxed_object_oid(&oid, m, pos);
+		for (i =3D 0; i < p->num_bad_objects; i++)
+			if (!hashcmp(oid.hash,
+				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
+				return 0;
+	}
+
 	e->offset =3D nth_midxed_offset(m, pos);
 	e->p =3D p;
=20
--=20
2.18.0.118.gd4f65b8d14

