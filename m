Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34786C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 10:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737D22429
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="51GI781P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfKTKpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:45:54 -0500
Received: from smtppost.atos.net ([193.56.114.176]:6051 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfKTKpx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 05:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1574246752; x=1605782752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6yBYF1gah8sSgcjnYR+YuAvjfgiQNU5DEDDPyCZKF3o=;
  b=51GI781Pi+BrCHeWioAbK4UyZvakhGVRXLjKd+imHMl2XMAk6awZkIyu
   Z1+RwFjF5UINdJsSXMCPLhB5d4eNzQGDoEPgLGzXhj89vnyRGkz0o8M2j
   JNRX8xDrNWbKaKoMozuwBgaBsaUxO2p1XN6hSoeTW2m0cIrF/n+2eABYs
   4=;
IronPort-SDR: IIKkPTeEnq9ZP6nialgB/5UqUYQuWs+v79r0mhA4G+SoSVkmMuTQa0H9N3T7yqRIf7aQsNLJOw
 G4FcmKEIvd4QBMaI0gkigDE9O2EVlLDAaYl1A5eLXrntOQp3+ttFzcYFVJNYdkyUisUzbiZ+ZT
 tlCyDpSG0rTKwLJGeQeABPScg9xu9YvYGPTzdOCgTKDBIGRnvFJnkI0/7SHrPjGfRLpT0OEokP
 vANs6z6FYIDaahReNNjvjzdnRKOo/nh1do8bkJIkuxVK04GJs3bQek0Z+qk50wxZG/2Zafo4fg
 h3kDQnkl6VNEhQ1j9QoeI9AD
X-IronPort-AV: E=Sophos;i="5.69,221,1571695200"; 
   d="scan'208";a="4372991"
X-MGA-submission: =?us-ascii?q?MDHL5HfJe5yGnRY6NHE0ToFsYmbBz8GjOQDPb4?=
 =?us-ascii?q?tDq0NoS3wj8DLCPBBaO6VIkz6PNrj5yo1tmtpCvh7K946lbrHAhYBidu?=
 =?us-ascii?q?gAoLVRIqWKn7m8CyVSjpmiLy0yJDhw9cgH0T5xY5UJEhvy8ERwmSAFmv?=
 =?us-ascii?q?Qp?=
Received: from unknown (HELO DEERLM99ETZMSX.ww931.my-it-solutions.net) ([10.86.142.48])
  by smtppost.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 20 Nov 2019 11:45:45 +0100
Received: from DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) by
 DEERLM99ETZMSX.ww931.my-it-solutions.net (10.86.142.48) with Microsoft SMTP
 Server (TLS) id 14.3.468.0; Wed, 20 Nov 2019 11:45:45 +0100
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.96) with Microsoft SMTP Server
 (TLS) id 14.3.468.0; Wed, 20 Nov 2019 11:45:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiTC+RyU7OIMPSvauLdvpiDwodKTHIGg0xWsH60hY1j9EuFHl4kRdhOy3gxM/DJPfjaQ1jcbRX5138MMu8jAMtrkk2A8K9Slh3sd0SMhmQSyZtH6W3UEN558Z2cGcJi6WZRrPQIJkae0OwgwENtAuowpjD4KIGwSM5J05dLb6yABm6Q8eYz6rk7ZKShTtDE4nhW1rhYddhx3m0zEl3O22TIJ6LkDKI6ctOUJBa6drgjq9yzjYKudcRclilDnhl/6V6fsoPHV2bfrD5PAuzdl2rnyLuuS7PYPXgpooBCc1d+wZDCAstawcygqdRJL14UExZuIOcoban6YT7RsosdyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yBYF1gah8sSgcjnYR+YuAvjfgiQNU5DEDDPyCZKF3o=;
 b=IogvkdGS4pmf85XXJbNwYw+iGXGZgKWXuRBlDI7QBfRzwitq0nzHuAe2cO781ywxZ/edj1J2wl65+454nffxtiNNm8PkW92C/jHvaD2N84FF3rdwrKUSVA94kgORQ6y2BRLwfRwT0ZKlJZE0+/sxFAXwoVgV69OMif2/Mejsz5vNPi1rb7bmEtKcHZfNtVe1xoK56gpzd38UZoCvO/xqVs+wBvZAeCRx9AY1j5ft8g9mYsBBqz3vBBFcyR5Nxjvdefsx1zZWAUlzT5AIkqUo6C3z/qmobsIDm1FBqytHN1E8qHhE2ZROZUqrb52FvnWiYy14PeFQypfFloi24MKBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (52.134.80.141) by
 AM0PR02MB4626.eurprd02.prod.outlook.com (20.178.18.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 10:45:44 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::9c1d:6b9f:8a1e:4eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::9c1d:6b9f:8a1e:4eb8%5]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 10:45:44 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
CC:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: RE: [PATCH v2] MyFirstContribution: add avenues for getting help
Thread-Topic: [PATCH v2] MyFirstContribution: add avenues for getting help
Thread-Index: AQHVnAltnSgqj2ARA0m7JJrW9LVwiqeNHYT8gARdWoCAAWEogIAALNGAgADdj/A=
Date:   Wed, 20 Nov 2019 10:45:44 +0000
Message-ID: <AM0PR02MB3715245F0CB1C7678DA8794F9C4F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
References: <20191115230637.76877-1-emilyshaffer@google.com>
 <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
 <20191118214519.GH22855@google.com> <20191119184919.GM23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [157.203.176.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ecbe793-5567-4b6a-dd99-08d76da6cb72
x-ms-traffictypediagnostic: AM0PR02MB4626:
x-microsoft-antispam-prvs: <AM0PR02MB4626BC6A93CFD3F4E6735D249C4F0@AM0PR02MB4626.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(52314003)(99286004)(66066001)(81166006)(6506007)(7696005)(53546011)(76176011)(8936002)(81156014)(316002)(256004)(25786009)(478600001)(45080400002)(102836004)(229853002)(110136005)(71200400001)(71190400001)(8676002)(54906003)(26005)(186003)(11346002)(305945005)(86362001)(476003)(7736002)(446003)(74316002)(486006)(3846002)(6116002)(2906002)(66556008)(64756008)(52536014)(5660300002)(76116006)(33656002)(66946007)(14454004)(6246003)(4326008)(4744005)(9686003)(6436002)(66446008)(66476007)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4626;H:AM0PR02MB3715.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGq1nsC0NoJmOa1AUCZim7PYG79K3Mk6Hj4nQ1LfecpL75L2aKeN+GcwVKnelQYnOtHPGRMhm/lksjOOQCY/cPHJ+iWlkpvxA5e0WeQGRSVlRaUUV4G0HfoU2JJmJg2AEH8Rc8Lr1X/oxukcAZvelULcnwucdqAHOz9Z7AM0473aiFRj8OvxAaoK6YYkqGXpGoDvIDz5n6+3HlBp+wflzcUzFOSEG6nV7OkXkafzFNcLp25ZritP1+zv9OOtTZAVHz8HjuLbLlwxv6bi5CGRzLcR3T0inZTBuSJAoqJWyDN0I2GzcAZn2ko9aak4rKgT4MDNxtvqBWweZCVJGXLH2p51XdwmadFS7nffSeAdGTATKNOunektg7pwXe8t+gA1GRy4nFGMqKt09rfNPGQ/f0u4F4wd/aMr/E/v+GJRkPcEqMX3d9U8WbjgOkQ7R2Y2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecbe793-5567-4b6a-dd99-08d76da6cb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 10:45:44.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6CVaQ49+aYeofYksu8wi78EkdZzas2lwbh9wRZ94kCPuVeOZBxu3wYeTKRBxo8HBWp1b4F966pQSAyAUNy6Tsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4626
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJuZWwub3JnIDxnaXQtb3duZXJAdmdlci5rZXJuZWwu
b3JnPiBPbiBCZWhhbGYNCj4gT2YgSm9oYW5uZXMgU2NoaW5kZWxpbg0KPiBTZW50OiBUdWVzZGF5
LCBOb3ZlbWJlciAxOSwgMjAxOSA5OjMwIFBNDQo+IFRvOiBTWkVERVIgR8OhYm9yIDxzemVkZXIu
ZGV2QGdtYWlsLmNvbT4NCj4gLi4uIGV4Y2VwdCBwZW9wbGUgd2l0aCBhbiBAb3V0bG9vay5jb20g
YWRkcmVzcyAoYWxsIG9mIHRoZWlyIGVtYWlscyB3aWxsDQo+IGJvdW5jZSkgYW5kIHBlb3BsZSB3
aG8gZG8gbm90IGtub3cgaG93IHRvIHN1cHByZXNzIEhUTUwgaW4gdGhlaXIgZW1haWxzDQo+ICh3
aGljaCBJIGJlbGlldmUgY29uc3RpdHV0ZXMgdGhlIHZhc3QgbWFqb3JpdHkpLi4uDQoNCltSSz5d
IEFuZCBldmVuIHRob3NlIG9mIHVzIHdobyBjYW4gZmluZCB0aGUgcGxhaW4vaHRtbCBmb3JtYXQg
c2VsZWN0aW9uIGNvbnRyb2wgbWF5IGZpbmQgdGhhdCBvdXIgZW1wbG95ZXIncyBzeXN0ZW0gdHVy
bnMgZXZlcnl0aGluZyBpbnRvIGJhc2U2NCBhbnl3YXksIHRodXMgYWdhaW4gbWFraW5nIGl0IGlt
cG9zc2libGUgdG8gcG9zdCB0byB2Z2VyLiAgSSBmdWxseSBleHBlY3QgdGhpcyBlbWFpbCB0byBy
ZWFjaCBhbGwgdGhvc2Ugb2YgeW91IHdobyBhcmUgVG8gb3IgQ0MsIGJ1dCBub3QgdG8gcmVhY2gg
dmdlci4NCg0KUmVnYXJkcywNClJpY2hhcmQuDQo=
