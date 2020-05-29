Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A01C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 06:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2F020721
	for <git@archiver.kernel.org>; Fri, 29 May 2020 06:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QVKLF95g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE2GQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 02:16:28 -0400
Received: from mail-eopbgr1300101.outbound.protection.outlook.com ([40.107.130.101]:63232
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2GQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 02:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXovrXWh10HWQpkFujfIAnp88nh4ujJV0T29S4CGC5LZQfhjIeJdU5dBhRKelDFoKh+bCAC2qEJVCK676a29opzkEnTQUptNaVR9BPoy82g9TOoVj4858YB4W7O+ogZWE6k8A9OyOHC9R41R4thOONt2GS4XwzjE32shdN5YFz7DmHr6589Q/eiGA/A1gA8U+l3cIXThhFIss78TxwHYvjQeduDDxFCF9N8OiZQ3KRBpuz4X1Udg4IHxEsZqns31BdqGxj8bALPItd9eGKS2dA3SoAYioj85LfHG152fW6VQeKDTDhtUFn+cnkSva7Z2m2SluBREzPXdrFq/w5kXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUD+tjtRObdylDXvjvaD3q+Zj5IBXFJL/I83p6BYdNI=;
 b=mrQNca1phNAU4cRUPqDf0uRXEjuHtGMQkaCSgCMDfgRXJIrmrNgxTGwaKx3s7duk2P7sUffPVTfwPd7+OOThUanneipvH9RO/4qO/FEVDxxX7AwM2qKrg4q9b/qtd2Ax/gcFjQheM/nwcygLJhWSP7zn7YVAnhuKOA0zGExF6WeArgr635E8tu+rs6ACyERbYNe0TWLj5bPp2/POcx0M+iLYwMbLobPg8ktA6ygKNj7C1mEUH65DQYOMVxsFLBINtMTSRzyDS0CjWcM4G7LpgtSTEXwVJTpyWPHIkC+52bVc1nxwJTb0R3veghsFj86KSWywcSTRHJPWFGXHBaBMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUD+tjtRObdylDXvjvaD3q+Zj5IBXFJL/I83p6BYdNI=;
 b=QVKLF95gyLtRaI0J2g4UB73tVmMAawrDnay/sHUI5EyIYIUQ/F3li9Vk4Q2FwKus0x5oJlCAQuvf3dzI4EftDvX0bfeP+dacb89t69znN1CbtXicBd6xgtpE1r+ptB/v4zHQX9vx2V/jVpXA68tp8vVSmg7+h3iJLIng6aYh080=
Received: from HK0P153MB0113.APCP153.PROD.OUTLOOK.COM (2603:1096:203:19::14)
 by HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (2603:1096:203:29::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8; Fri, 29 May
 2020 06:16:24 +0000
Received: from HK0P153MB0113.APCP153.PROD.OUTLOOK.COM
 ([fe80::c196:a6cb:9d5:c814]) by HK0P153MB0113.APCP153.PROD.OUTLOOK.COM
 ([fe80::c196:a6cb:9d5:c814%6]) with mapi id 15.20.3066.010; Fri, 29 May 2020
 06:16:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] New git unable to show this commit completely?
Thread-Topic: [BUG] New git unable to show this commit completely?
Thread-Index: AdY1e90QgQZ+lnAgT725z0zgKS9EiAAATtOAAADQtRA=
Date:   Fri, 29 May 2020 06:16:23 +0000
Message-ID: <HK0P153MB0113974318F69042C36EB62FBF8F0@HK0P153MB0113.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0113E08900C5C8B8311A4B24BF8F0@HK0P153MB0113.APCP153.PROD.OUTLOOK.COM>
 <20200529055045.GA1294228@coredump.intra.peff.net>
In-Reply-To: <20200529055045.GA1294228@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-29T06:16:21Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fbd7eee9-cff4-4ee2-8905-40fda70839ae;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:29e9:a365:d0a8:25d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cd387bc-6e59-482a-7a88-08d80397d047
x-ms-traffictypediagnostic: HK0P153MB0178:
x-microsoft-antispam-prvs: <HK0P153MB0178E272AD95FA4181F2376DBF8F0@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uzdPpp7yVJjsfzCgUVArPyZwX8hFrd7xNPPNqLyWxJkjdcmo5GYZrmd9T76sQiekhZNqFFNQGfEYykrloq/xXmDbti/hgNx7XjwQS7RMREILAiC+xx+MtpBNRygEw26dAKmXffbWqwUHxYJ63idteXPxk0d9P5H28u4sTwe78FoeEOS6zOBGwJ3maAYABXf+mkYkm0HrTzRU0R3NotcErZsinXE/m6Odf4yu+6Mq/+ocFfs8R36IIr47CaTwANAPYBLQFLpBT3gfHmMAWOyGF+mSSx0xZlnA4rTYOFRYyQcu1hRF2a6RCB73aTaZG5enecFMyIj/FYwQls5fBIMKAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0113.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(52536014)(478600001)(316002)(5660300002)(66476007)(2906002)(64756008)(6506007)(66446008)(66556008)(33656002)(4744005)(7696005)(10290500003)(6916009)(71200400001)(4326008)(186003)(66946007)(8676002)(82950400001)(82960400001)(8990500004)(83380400001)(8936002)(9686003)(55016002)(86362001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qu/qfggVupU5q2BWWkzRxL1rhaVhk8Qm7IFGi6OMBTdTMPKs/f1if3vxqyLRYJcTP3qD+0r0vmD0UqhjH3lhgj29tNI2oB6xasXvS1C6ALlKszXN83ZqLwDPPb4DkYjEIOTs1rH8kHpGP3a82/WWDqAA63DhtwmAMhPfowlbFk6MeOrxdK/9EbDAoK88CwqIwJrI2BJJQXiGEjDqq42ym+PhgwL7Kc21Fyz+QBT4EpOhEgR+80lM3nbtNt97lUziwQHTaE7CuR0ibqw7dJtt9C5o0ensvBqU0ee0A0EI8IqVdUquEOf2O1q1K+gzZtwiIBCKEvp2lUG00MToZNlhB7N2DEGHy/FWr6DvyH9dzMzE1E5AnSlZ7vax2Hnd8I8a/ENMQUans04s8+8Y+WnNFxNUD+um3rbjA7wo3mTt+bxUB5NIUyGG3OUCEbtXKrL7oeiL8uw9gN+qVaNe36p+/Z+ip2o3ADkXuB+7S8zsChXMdi1sVuu0o2WpgxI0gdj63AnzgEewbVEC5uzDkANpOw3tdFngexQu57ozqvHcye3V7dd9LqFNFNlBh+PUlQdO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd387bc-6e59-482a-7a88-08d80397d047
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 06:16:23.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PWdM4g4cqKLSDniDUEnuHjX/qjdBrnJrRpRzEevmKOga/Er3i/D5jZW3GumDjnz3UzRGzot0zOTjCQEVXmabg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkg
MjgsIDIwMjAgMTA6NTEgUE0NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtCVUddIE5ldyBnaXQgdW5hYmxlIHRvIHNob3cgdGhpcyBjb21taXQgY29tcGxldGVseT8N
Cj4gDQo+IE9uIEZyaSwgTWF5IDI5LCAyMDIwIGF0IDA1OjQzOjI5QU0gKzAwMDAsIERleHVhbiBD
dWkgd3JvdGU6DQo+IA0KPiA+IEhvd2V2ZXIsIGluIFVidW50dSAyMC4wNCwgdGhlIGdpdCBkb2Vz
bid0IHNob3cgdGhlIGRlbGV0ZWQgZmlsZQ0KPiA+IGFyY2gveDg2L21hY2gtZ2VuZXJpYy9wcm9i
ZS5jIGF0IGFsbDoNCj4gDQo+IEl0IGRvZXM7IGl0J3MgcGFydCBvZiB0aGlzIHJlbmFtZToNCj4g
DQo+ID4gIGFyY2gveDg2L3ttYWNoLWdlbmVyaWMvcHJvYmUuYyA9PiBrZXJuZWwvcHJvYmVfMzIu
Y30gfCA5Mg0KPiArKysrKysrKysrKysrKysrKysNCj4gDQo+IFJlbmFtZSBkZXRlY3Rpb24gd2Fz
IHR1cm5lZCBvbiBieSBkZWZhdWx0IGluIEdpdCB2Mi4wLiANCg0KQWgsIGdvdCBpdCEgVGhhbmtz
IGZvciB0aGUgcXVpY2sgcmVwbHkhIA0KSSBzaG91bGQgaGF2ZSBjaGVja2VkIGl0IG1vcmUgY2Fy
ZWZ1bGx5LiA6LSkNCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
