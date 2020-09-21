Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D6C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527D320BED
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="bwmG/42s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIUJWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 05:22:32 -0400
Received: from smtppost.atos.net ([193.56.114.176]:17968 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbgIUJWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 05:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1600680150; x=1632216150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ax6GIEzil5M8dfvEqu1cGs8wBZIFkD6HaB5ExdXnWAk=;
  b=bwmG/42s4f4Ku8rHrh/X5r8l0AEXfuPJPphKMq8n1jmxi3X46+7YUw2o
   rhGW5e/tw3MtmcbwzMbA7zvmYkqiLtAiaDWI//U5tUhGdHC5Vg9c19sil
   PVZWbIKE6W0kp3SnYL3x+MhwUSZptrjQ0PTKNCqCvCAKoYgXS+MRMVN+C
   o=;
IronPort-SDR: WatASrTdaMr6cElMK96O5xYfXpc2GvV/gwr4STEcIvFeHHwDlbqipqckCNxjYrXVMMbXiVbJy4
 5TcufvZShoEA6Cm8uxp0Z57FcADR4lTNscMJRY2Nfq1JyIJpg5mExNLbnpFqQgwauwMFclCq8C
 u5Rz8lJTq21BhCIv31Z9AVKce5UqL2dDsqhG9z710MIzv05Oj9jxeNqCAUOslf0rmZ8+n0Yd56
 OsHxlJSMn3xk0Ofl4zKBWwJcxm5o6f/tsE2BUpM8QK9zeXZvlxKFnSF+fz5Qe4pRBHe2HBWfPE
 IQQG3t0W+1h4eCmpIMmjln84
X-IronPort-AV: E=Sophos;i="5.77,286,1596492000"; 
   d="scan'208";a="96392037"
X-MGA-submission: =?us-ascii?q?MDGU1m1+xMJafz+YWew9Utiz/5kVsGTrgpIxLf?=
 =?us-ascii?q?ECWwRG0phxUjMF9q1a2YuB7pY7N3Rpsy5/eYdvBatW4R7MTFD6XoTKEC?=
 =?us-ascii?q?lMjjq3DNx1m3KmQeiWi6nHzxcSRJVv+Q8BjbDaoXeltB7OIDh34Z32zQ?=
 =?us-ascii?q?XF?=
Received: from unknown (HELO GITEXCPRDMB22.ww931.my-it-solutions.net) ([10.89.29.132])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2020 11:22:28 +0200
Received: from GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) by
 GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 21 Sep 2020 11:22:28 +0200
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (172.16.214.169)
 by GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3 via Frontend Transport; Mon, 21 Sep 2020 11:22:28 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju1AIEeyhowo3dwYNMY4CnYjq5FwEGqinQOsNoHiGFYaJm0+mtRGVPFB+wIyxMlg0MgpkpbFHyvf995E8immqMozDNL64AZF6JsgerbImDiQwJNjFsVEEurf7ERabwc8E1uc/8P7Oppq4vZgQY7UUsmWKNjTHZfc0MLKlnK9iCM+rNk1cGmLrBdcs28sQITlNYw93xfQBESVFQUcWQoukpGZK46truxL+64IaOhskCPEXT/a+NJCQsQUeGh1QyBkEn0y2hq5Qujh3ysQ5h+tNOrhWhm8frOrwYrA1pUYhPA214t8r0hovMisfpj87zxZqWpyoHaMBPmzfZGdc35fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax6GIEzil5M8dfvEqu1cGs8wBZIFkD6HaB5ExdXnWAk=;
 b=GRY3iEBvzs1gdYDQn/UVgXHon7Xhv2BBiHU4YOAMyPOeQtdG14A3RbWM7sSeKd211Y5glYiBvkwszMGZBXBARvDSjHDcDNALes4EJfIrFOkiu/GlYO1ODHJWRLAIEdssLO8N6JcoQzrqpjcFpenVlGxCPIHUO6IMtW4dPmKbwG+N8EN9tfWekVi6XHLPpHpGYSTtn7Ytl7lfsYQfZN/w36mHK3rrdbgP+ACnXeCDCNlDELrCSkbLzJRoW7wPY+SpozilybBr2B5zg4DlEdZC297+mKHkiiCgCVP3PRzgcbgF3qMlwof6ij4CHTt4dQcAUYFnoQIjoD7Lr/liF3CYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM4PR02MB3121.eurprd02.prod.outlook.com (2603:10a6:205:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Mon, 21 Sep
 2020 09:22:27 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::90c1:9419:e0f6:a8d6]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::90c1:9419:e0f6:a8d6%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 09:22:27 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>
CC:     "postmaster@vger.kernel.org" <postmaster@vger.kernel.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Thread-Topic: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Thread-Index: AdaM2sus1K7J5wJcQwu+SuxuGJE34gAF+K6AAEb1jwAAATXMgAB4n+8A
Date:   Mon, 21 Sep 2020 09:22:27 +0000
Message-ID: <AM0PR02MB4081CA0FA1878FD098D5417D9C3A0@AM0PR02MB4081.eurprd02.prod.outlook.com>
References: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <20200917130139.GB3024501@coredump.intra.peff.net>
 <20200918225326.GA1367@pug.qqx.org>
 <20200918232805.GA1197580@coredump.intra.peff.net>
In-Reply-To: <20200918232805.GA1197580@coredump.intra.peff.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-09-21T09:22:24.9181402Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=8406c9d5-b53d-4375-9532-bc9c4e7cf38c;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-09-21T09:22:24.9181402Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=8406c9d5-b53d-4375-9532-bc9c4e7cf38c;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=atos.net;
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50c99c60-7d99-499e-7146-08d85e0fdbb4
x-ms-traffictypediagnostic: AM4PR02MB3121:
x-microsoft-antispam-prvs: <AM4PR02MB3121237BABF66EDF379254FE9C3A0@AM4PR02MB3121.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yKqwt95FZZkrZE8o9fsqQfo2BKkk98kJZMMElHNU+Xsa38vjrpsniQllO+l+ssRjbfMN50JEga6URSthzUx0Tp9VSLRgZ9tDHyrMwA439wnKg0oyQGr8MhT5GRn3MNXgYGVQNRdAz28A/U/rr0omnSjsWjgL1H+jlGAXi5WyScHZteP06xIB9yt1YqUbLJgXBJtgBIGAtGsvlQ20EgHT24vFfdNZq+wlEkWwja0u80uMpJuX/iHv6+fM1lYp7FQk4aALzEz6iROjCNmz5A3M7ky8x5P/nMhOrCYpcOHqolE7VSFj8Oj/J4g2QDFniyPnFXMVgIjSATvRUmy8o0IP6dD2GKz+qATqMW2EyGoKizcNOLohvLM5L87Jcu7PkAv+xGcABuae066QRGMyOX0WYH5adBmeXIRaKlFb5C/ppMkajPLQ9jNWiXWjXFt7k6+2NiuJrCDvxJGr1k14saVVWo0h49SS1VTxZpONV+S464LmPEK7i8yHSJgqMlClmtrgtlFjneoXzOGyqOG0N2LfpGi4YluzYqwZ0Jkq96TJps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(8936002)(71200400001)(5660300002)(26005)(110136005)(316002)(33656002)(54906003)(55016002)(86362001)(8676002)(9686003)(64756008)(76116006)(6506007)(66446008)(66556008)(66476007)(66946007)(7696005)(478600001)(4326008)(2906002)(186003)(52536014)(83380400001)(966005)(45080400002)(130980200001)(223123001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 06dESYVYaRmg3E4Ak0eBrfizDnwQZ89kBmKQ57eNW39B3r0UpvcTpyjD8a+XrhCxNSGxmVIjJUh68rh89ld1Cgh0VUpTgZG+0tjDE7PVf1Zc9eoxYG1rzbq30QFi48PcBBzp8tEaQ+SRpVSTDEMMgECBIw4zbhWxr3RS6oExW/MfG/XtdYcchKDHIE0LY7XuzoVh4Df0Vb1BPVxOqT1ae+58ZibrEFZ4djngh1ED5jODKUIq27QSc5EleonGKPcepvB+4J9Oz0lZYNPErDZzRAfFjIzNpWIPzVjQzKKvYfJNBDrAtakHlXGomD9IOFMB2mHlEZkkvuJ2NM+GzK+lurjkB36+5S8Em+IIk4wNGiaXkJ6U97y/BKtfnIO2xdgdp591FHFzyX8nqygqibvoqgsiGj1qIvuA6AztOAmrvepFGphOvK9mjNE/3hx30NpHJkJzM5WM6kiaOHHDed0UkTGTjgkPejFkA+GoiJ+yQFaJrjTNTTzRs1Aq2wjshvRsoi/ivKXM5F2aH+9L3V0UgCDGAQWKQyUnW9lj4xJyxARsh9k+cQCc4o2qc0Gcj+ERQ6dlljzXUs9p7IC5FVDq6W0o4x3BAqzXMnF9d/mRoRWxQEBIAz4eCjVvLc710ZmAFLQzEIWp8WkZgAFyvIhxvw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c99c60-7d99-499e-7146-08d85e0fdbb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 09:22:27.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSPGYsg1JquDs9FFnOYM1wyYJj/Y4iRAy1gFLu7P2m2AxRk6+e/IG2FJWnFtC7guMP0SYbGDG1PMIfLebHYTxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3121
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyA8cGVmZkBwZWZm
Lm5ldD4gDQpTZW50OiAxOSBTZXB0ZW1iZXIgMjAyMCAwMDoyOA0KDQpbK2NjIHBvc3RtYXN0ZXJA
dmdlcjsgaXQgbG9va3MgbGlrZSBtZXNzYWdlcyB0byB0aGUgZ2l0LWxpc3Qgc3RvcHBlZCBpbmNs
dWRpbmcgYSBTZW5kZXIgaGVhZGVyIGFzIG9mIGEgZmV3IGRheXMgYWdvXQ0KDQpPbiBGcmksIFNl
cCAxOCwgMjAyMCBhdCAwNjo1MzoyNlBNIC0wNDAwLCBBYXJvbiBTY2hyYWIgd3JvdGU6DQoNCj4g
PiBOb3QgdG8gbXkga25vd2xlZGdlLiBUaGUgc210cC1sZXZlbCBlbnZlbG9wZSBmcm9tIG9uIGFs
bCBvZiB0aGUgDQo+ID4gbWVzc2FnZXMgSSd2ZSByZWNlaXZlZCBpcyBnaXQtb3duZXJAdmdlci5r
ZXJuZWwub3JnLiBJcyB0aGVyZSBzb21lIA0KPiA+IG90aGVyIG1lY2hhbmlzbSB5b3UgbWlnaHQg
YmUgZmlsdGVyaW5nIG9uPw0KPiANCj4gQ29tcGFyaW5nIDwyMDIwMDkxMTE0MzMyMS5HQTIzNzQ5
NTBAY29yZWR1bXAuaW50cmEucGVmZi5uZXQ+IHdpdGggdGhlIA0KPiBtZXNzYWdlIEknbSByZXBs
eWluZyB0byBzbyB0aGF0IEknZCBoYXZlIG1lc3NhZ2VzIHdoaWNoIEkgd291bGQgZXhwZWN0IA0K
PiB0byBiZSBzaW1pbGFyIGJlZm9yZSB0aGUgbGlzdCBoYW5kbGluZyBJIHNlZSB0aGF0IHRoYXQg
b2xkZXIgbWVzc2FnZSANCj4gaW5jbHVkZWQgdGhlIGhlYWRlcg0KPiANCj4gICBTZW5kZXI6IGdp
dC1vd25lckB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IEJ1dCB0aGUgbmV3ZXIgbWVzc2FnZSBkb2Vz
IG5vdCBoYXZlIGEgU2VuZGVyOiBoZWFkZXIuDQoNCkFoLCB0aGFua3MuIEkgZXZlbiBsb29rZWQg
Zm9yIGEgU2VuZGVyIGhlYWRlciwgYnV0IEkgc3R1cGlkbHkgbG9va2VkIGF0IHRvby1yZWNlbnQg
bWVzc2FnZXMsIHdoaWNoIG9mIGNvdXJzZSBkaWRuJ3QgaGF2ZSBvbmUuIDopDQoNCkFjY29yZGlu
ZyB0byBteSBsb2NhbCBhcmNoaXZlLCB3ZSBzdG9wcGVkIGdldHRpbmcgU2VuZGVyIGhlYWRlcnMg
YXJvdW5kDQoxNjAwMjk2MDI2ICh0aGF0J3MgdGhlIHRpbWVzdGFtcCB3aGVuIEkgcmVjZWl2ZWQg
aXQpLCB3aGljaCB3YXMNCg0KICBEYXRlOiAgIFdlZCwgMTYgU2VwIDIwMjAgMTc6MTE6NTAgLTA0
MDANCiAgU3ViamVjdDogUmU6IFtQQVRDSCAzLzVdIHQzMjAwOiBhdm9pZCB2YXJpYXRpb25zIG9m
IHRoZSBgbWFzdGVyYCBicmFuY2ggbmFtZQ0KICBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZn
aXQlMkYyMDIwMDkxNjIxMTE1MC5HQTYxNzIzNyU0MGNvcmVkdW1wLmludHJhLnBlZmYubmV0JTJG
JmFtcDtkYXRhPTAyJTdDMDElN0NyaWNoYXJkLmtlcnJ5JTQwYXRvcy5uZXQlN0MxOGZiZmI5NTY3
MGM0MjM5NjA2ZTA4ZDg1YzJhODIxMyU3QzMzNDQwZmM2YjdjNzQxMmNiYjczMGU3MGIwMTk4ZDVh
JTdDMCU3QzAlN0M2MzczNjA2ODQ5MjYxMDg2NzgmYW1wO3NkYXRhPWtPJTJCMTh6cEFyS0xzZSUy
Rkk0SmFOTnZocU5tdiUyRjhobmZ0WXladldUalZFQ1ElM0QmYW1wO3Jlc2VydmVkPTANCg0KVGhl
IG1lc3NhZ2UgSSByZWNlaXZlZCByaWdodCBiZWZvcmUgdGhhdCB3YXM6DQoNCiAgRGF0ZTogV2Vk
LCAxNiBTZXAgMjAyMCAxNDoyNTo0MiAtMDcwMA0KICBTdWJqZWN0OiBSZTogW1BBVENIIDIvNV0g
dC90ZXN0LXRlcm1pbmFsOiBhdm9pZCBub24taW5jbHVzaXZlIGxhbmd1YWdlDQogIGh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RmxvcmUua2VybmVsLm9yZyUyRmdpdCUyRnhtcXFvOG01djJnOS5mc2YlNDBnaXRzdGVyLmMuZ29v
Z2xlcnMuY29tJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NyaWNoYXJkLmtlcnJ5JTQwYXRvcy5uZXQl
N0MxOGZiZmI5NTY3MGM0MjM5NjA2ZTA4ZDg1YzJhODIxMyU3QzMzNDQwZmM2YjdjNzQxMmNiYjcz
MGU3MGIwMTk4ZDVhJTdDMCU3QzAlN0M2MzczNjA2ODQ5MjYxMDg2NzgmYW1wO3NkYXRhPUlMMFRk
OXdyUWRWUGZmWVpUeWNwcjF4N2p4eTVUcTYzTTJyJTJCNGglMkZoYjVBJTNEJmFtcDtyZXNlcnZl
ZD0wDQoNCndoaWNoIGRvZXMgaGF2ZSBhIFNlbmRlciBoZWFkZXIgKG5vdGUgdGhvc2UgYXJlIG91
dCBvZiBvcmRlciBpZiB5b3UgYmVsaWV2ZSB0aGUgY2xpZW50LXNpZGUgRGF0ZSBoZWFkZXJzKS4N
Cg0KPiBJIGRvbid0IGtub3cgaWYgdGhhdCB3YXMgYSBkZWxpYmVyYXRlIGNoYW5nZS4NCg0KW1JL
XSBZZXMsIHRob3NlIGFyZSB0aGUgdHdvIG1lc3NhZ2VzIGVpdGhlciBzaWRlIG9mIHRoZSBjaGFu
Z2UgYXMgSSBzZWUgaXQuICANCltSS10gSSdtIHVzaW5nIE91dGxvb2sgKGl0J3MgYSB3b3JrIGNv
bXB1dGVyKSBzbyBJIHByb2JhYmx5IGRvbid0IGhhdmUgdGhlIGxldmVsIG9mIGNvbnRyb2wgdGhh
dCBzb21lIG90aGVyIG1haWwgcmVhZGVycyBkbywgYW5kIGV2ZXJ5dGhpbmcgZ2V0cyBhIGxvYWQg
b2Ygc3BhbS1maWx0ZXIgaGVhZGVycyBhZGRlZCwgbWFraW5nIHRoZSBoZWFkZXJzIGhhcmRlciB0
byByZWFkLiAgQnkgYWRkaW5nICJUbzogR2l0IiBJIHNlZW0gdG8gaGF2ZSBnb3QgbXkgZmlsdGVy
cyB3b3JraW5nIGFnYWluIHVuZGVyIHRoZSBuZXcsIFNlbmRlci1sZXNzLCBzY2hlbWUuICBUaGF0
IGlzIGV2ZW4gd29ya2luZyBmb3IgbWVzc2FnZXMgd2hlcmUgdGhlIEdpdCBsaXN0IGlzIENDLWVk
IHJhdGhlciB0aGFuIFNlbnQgdG8uDQoNCg0KW1JLXSBSZWdhcmRzLA0KW1JLXSBSaWNoYXJkLg0K
DQoNCg0KDQo=
