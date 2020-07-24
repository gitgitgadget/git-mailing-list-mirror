Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC6AC433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1322067D
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=strongestfamiliesinternal.onmicrosoft.com header.i=@strongestfamiliesinternal.onmicrosoft.com header.b="WaR8RGP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgGXSHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:07:35 -0400
Received: from mail-eopbgr660127.outbound.protection.outlook.com ([40.107.66.127]:6451
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgGXSHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 14:07:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH4iDYJuwPI5DlBYawd5GZ23FY1QPoLCxhJbHtyzWQ7Tr4kG00D1rkRK5MTyVCx1MPkAH3lLT0ul5B+83QQAnqhB32ke2pyxSi/Nr5QA28Q9kkvFf+bfQvczji2wCFuiDZsmOR0FVvwiRVy2E2ir2WBJAisCYqDDacVLYA/r92kpJW0hn0OqBPUrBNoj4DVXARF2KAuLNYQ85joKhGMkeJUL9Jgp4DX+W1MluqPZZZbm2OPaGocrdeIV6UnikJAYqogVNp/8UzvCdyiPwnU/NQBB7ScSsViqumHHbY9QKinrfBqsUFDxt1PoW0bi0Ql8kFIJpHL121g1sxgJrcgGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tudEDY14vudh9dnHBCrrVD88BAL33kg3oLj4ohLbbvk=;
 b=Enrb8vPxGDrEeNuZVIRVfI9qpfMeaCHEHU1WmvfOCm967AoMedgCBEFkom0TOdS6+ki8CfxFcpl8IrA7kmHJsRWfe+aT8DbFS0MCvf9di3PI0kucZ69wKX2XcyXTvrIRO5V9rV7MxVLz8g7GbJxBFy1RadI0JjLbVoe3mGlG5yPqn5Nsjr7RAt9h/nmS76rthRNPpXG7aYBliAhKXaChfIdhTe0RAAahHPz0r2eFm2GaeIu89QJL85w/3fVRD9lfaT1OplTAPIRhy57S8QdbXrfF8C2oXXVI1Izcslz68ue5vr5dCCY1DT/s2mXU4JUcoKMScf3CSB9VAqXwdvRzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=strongestfamilies.com; dmarc=pass action=none
 header.from=strongestfamilies.com; dkim=pass header.d=strongestfamilies.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=strongestfamiliesinternal.onmicrosoft.com;
 s=selector2-strongestfamiliesinternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tudEDY14vudh9dnHBCrrVD88BAL33kg3oLj4ohLbbvk=;
 b=WaR8RGP9AUoMwuITClysFvnhZS4Iwk3KQYpTxIftbtNnJW3L2omlJIVfYeuEIVj2B4omWHldwsWKZjD3cSlR1uQoG7n5QVVkL3lqna3uyXhOj+6sjaMt/3LTfu3R+5RNTcusvN/F4S/PZwnbvVaqkFkdQv9wxL1FLIlVFoMpLv8=
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::31)
 by YQXPR0101MB1590.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:18::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Fri, 24 Jul
 2020 18:07:29 +0000
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e]) by QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 18:07:29 +0000
From:   Casey Meijer <cmeijer@strongestfamilies.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Topic: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Index: AQHWYQRMte1QWK0kaEKnR3jjpovCbKkVFV4AgADZnwCAAAG7ooAA5YuA
Date:   Fri, 24 Jul 2020 18:07:29 +0000
Message-ID: <5352321F-0122-49BA-B778-80A84DDABB71@strongestfamilies.com>
References: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
 <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
 <20200724011944.GD1758454@crustytoothpaste.net>
 <xmqqft9hn1pd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft9hn1pd.fsf@gitster.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none
 header.from=strongestfamilies.com;
x-originating-ip: [216.208.243.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68a5b0ca-6ab2-439a-3bfb-08d82ffc6e1b
x-ms-traffictypediagnostic: YQXPR0101MB1590:
x-microsoft-antispam-prvs: <YQXPR0101MB15901FA9C810707BA4D4B51AAB770@YQXPR0101MB1590.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yarXAydiq5cbQXlmHtTKddfM7RagQTlBu4Qm9dw6ih0FAPSGqABKgrsc7071SctodoNSJKA7ADvDDs3LS++6mINf2SZDQNVR/JCIyYbAm/A2wGm54H//w61E4UG3xtQiO977GOswCUROW0cneJvnZ0DASCEv66FY1Sp/gl7e3x1VGVwn3s2Jq/3GP94SVj82ADJtKpC3tCRYFqRbPBaVaZyx6PZFS0X5RsFNhLRCBkeHNuQYmjflMnL0zwWQth9Nqiey/nhup3BUAi/wF+tPZHfv6OmdhhdV3yLyssBj0AuOsmn4y5I+W2eX41p5CfZxZaKCuegzP5CMnQ/PjlJNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39830400003)(136003)(376002)(33656002)(110136005)(8936002)(71200400001)(6506007)(86362001)(2906002)(5660300002)(4326008)(316002)(6486002)(66574015)(8676002)(83380400001)(36756003)(508600001)(66556008)(66446008)(66946007)(6512007)(66476007)(64756008)(76116006)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wQk6yER8UeK0WPIqEYb4Gd5WDoyHRfIScMeV/IYDCHfuyQ6qPiFHimSKls2oxYydCapxq5yK+KOPwC0rgz7JVgvwvtAxuwSBlMsk2Jf9OTC8+HjNL7ZNgoM4ina/c+iL0XiDhn9EwiM3FNx6gODtK7L8iUcYaXotYUpobC07x6biBOOQ+rumrgTijXg9gFsXvDDmZ7bnGdsui/z7PuVku5SYXXaeYaoL869dt0i2fkn4DmwpibKI7cRceG03gbS7kJBAY3GfRHTbEtp+/oQtKhavkVikJzG3aFeEUgiCe4jdaakSgPdeU8WQ7U//0MY9CfuUqWlZz+DCrwLL4NL0ay/QQ1dCLweYYdxY95Wt9lGw9Unn2gbpFicaq3fTr5tZUQXjGxejsN2vCDQ6Ka0AuRvvB3cj9S7OWOF68bcruxQUHHaHd68GXe5NxWnWVcDVeCDqoeE9TApXSz9WgxukAiumbSMBNT35UViq/m0KIjtQ0INScqmocPBh306s9Drx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E75949032B9BB4FBF6F89EF51970109@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: strongestfamilies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a5b0ca-6ab2-439a-3bfb-08d82ffc6e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 18:07:29.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88c0a794-6b77-42fa-a51d-2e160c167dfa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBwYQzPufoWBWnZSw8JVBBhx+DDWcACV6It0DjuYWM4QEX15nPRaVkF5xdPriayQROqH8K1dpRwy8DB21seRCrx6Uoxb+mmeMkRzawhpxUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1590
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SXQncyBkZWZpbml0ZWx5IGEgYnVnIGFuZCBpdCdzIGtpbmQgb2YgYW1hemluZyB0aGF0IGl0J3Mg
YmVlbiBmbG9hdGluZyBhYm91dCBmb3IgMiB5ZWFycy4gIA0KSSdtIG5vdCBzdWdnZXN0aW5nIGFu
eXRoaW5nIHJlYWxseSBjaGFuZ2UgZXhjZXB0IHRoZSB3YXkgeW91IGRldGVybWluZSB3aGV0aGVy
IGEgcmVmIGlzICJ3b3JrLXRyZWUgbG9jYWwiIG9yIG5vdC4gDQpUaGlzIHdheSBvbiBjYXNlIHNl
bnNpdGl2ZSBmaWxlc3lzdGVtcyBvbmx5IEhFQUQgd2lsbCBiZSBhY2NlcHRlZCwgYW5kIG9uIGNh
c2UgaW5zZW5zaXRpdmUgZmlsZXN5c3RlbXMgYm90aCBoZWFkIGFuZCBIRUFEDQp3aWxsIGJlIHZh
bGlkIChhbmQgd2lsbCByZWZlciB0byB0aGUgc2FtZSBmaWxlL3JlZiksIHJlcGxpY2F0aW5nIHRo
ZSBzZW1hbnRpY3Mgb2YgdGhlIHByaW1hcnkgd29ya3RyZWUuIA0KDQpOYW1lbHksIGluc3RlYWQg
b2YgY2hlY2tpbmcgZXhwbGljaXRseSBmb3IgIkhFQUQiIChvciBnb2luZyB0aHJvdWdoIHNvbWUg
aG9vcHMgdG8gZGV0ZXJtaW5lIGlmIHRoZSBmaWxlc3lzdGVtICANCippcyogY2FzZSBzZW5zaXRp
dmUpLCBqdXN0IGxvb2sgaW4gdGhlIHdvcmt0cmVlIHJlZnMuICBJZiBpdCdzIGluIHRoZXJlLCB0
aGVuIGl0J3Mgd29ya3RyZWUgbG9jYWwuICBJZiBub3QsIHRoZW4gbm90LiANCg0KTGlrZSBJIHNh
aWQsIG1heWJlIHRoZXJlIGFyZSBzb21lIHByb2JsZW1zIHdpdGggdGhpcyBhcHByb2FjaCB0aGF0
IEknbSBub3QgYXdhcmUgb2YsIGJ1dCBpZiBzbywgSSB0aGluayBpdCdzIHdvcnRoIHRoaW5raW5n
IA0KYWJvdXQgd2hldGhlciB0aG9zZSBwcm9ibGVtcyBhcmUgcmVzb2x2YWJsZSDwn5iKIA0KDQpB
cyBmYXIgYXMgYWx0ZXJuYXRlIHN0b3JhZ2UgZW5naW5lcywgIEknZCBiZSBtb3JlIGludGVyZXN0
ZWQgaW4gc2VlaW5nIGNvcmUgZ2l0IGJ1aWx0b3V0IHRvIHN1cHBvcnQgYSBwbHVnYWJsZSBzdG9y
YWdlIGVuZ2luZSB0aGFuIGFueSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbi4NClRha2UgYSBsb29r
IGF0IFBvc3RncmVTUUwncyB3b3JrIG9uIFRhYmxlIEFjY2VzcyBNZXRob2RzIGZvciBhbiBleGFt
cGxlIGluIHRoaXMgdmVpbi4gIEkgdGhpbmsgdGhpcyBpZGVhIHBsYXlzIHdlbGwgd2l0aCBteSBw
cm9wb3NhbCBhYm92ZSBhcyB3ZWxsIGJlY2F1c2UgaXQgDQpkZWxlZ2F0ZXMgdGhlIHJlc3BvbnNp
YmlsaXR5IG9mIGNhc2Ugc2Vuc2l0aXZpdHkgdG8gdGhlIHN0b3JhZ2UgYmFja2VuZCAoaW4gdGhp
cyBjYXNlLCB0aGUgZmlsZXN5c3RlbSkuICANCg0KDQpCZXN0LA0KDQpDYXNleQ0KDQrvu79PbiAy
MDIwLTA3LTIzLCAxMDoyNSBQTSwgIkp1bmlvIEMgSGFtYW5vIiA8Z2l0c3RlckBwb2JveC5jb20+
IHdyb3RlOg0KDQogICAgImJyaWFuIG0uIGNhcmxzb24iIDxzYW5kYWxzQGNydXN0eXRvb3RocGFz
dGUubmV0PiB3cml0ZXM6DQoNCiAgICA+IEl0IGlzbid0IGNsZWFyIHRvIG1lIGV4YWN0bHkgd2hh
dCB5b3UncmUgc3VnZ2VzdGluZy4gIEFyZSB5b3Ugc3VnZ2VzdGluZw0KICAgID4gdGhhdCB3ZSBh
bGxvdyAiaGVhZCIgaW5zdGVhZCBvZiAiSEVBRCIgaW4gd29ya3RyZWVzLCBvciB0aGF0IHdlIGFs
bG93DQogICAgPiByZWZzIGluIGdlbmVyYWwgdG8gYmUgY2FzZSBpbnNlbnNpdGl2ZSwgb3Igc29t
ZXRoaW5nIGVsc2U/DQoNCiAgICA+IFRoZXJlIGlzIGEgcHJvcG9zYWwgZm9yIGEgcmVmIHN0b3Jh
Z2UgYmFja2VuZCBjYWxsZWQgInJlZnRhYmxlIiB3aGljaA0KICAgID4gd2lsbCBub3Qgc3RvcmUg
dGhlIHJlZiBuYW1lcyBpbiB0aGUgZmlsZSBzeXN0ZW0sIGFuZCB3b3JrIGlzIGJlaW5nIGRvbmUN
CiAgICA+IG9uIGl0LiAgVGhlcmUgaGFzIGJlZW4gYSBzdWdnZXN0aW9uIGZvciBhbiBTUUxpdGUg
c3RvcmUgaW4gdGhlIHBhc3QsIGJ1dA0KICAgID4gdGhhdCBjYXVzZXMgcHJvYmxlbXMgZm9yIGNl
cnRhaW4gaW1wbGVtZW50YXRpb25zLCBzdWNoIGFzIEpHaXQsIHdoaWNoIGRvDQogICAgPiBub3Qg
d2FudCB0byBoYXZlIEMgYmluZGluZ3MuDQoNCiAgICBZZXMsIGFub3RoZXIgaW1wb3J0YW50IHRo
aW5nIHRvIHBvaW50IG91dCBpcyB0aGF0IG9uZSBzaGFyZWQgZ29hbCBvZg0KICAgIHRoZXNlIGVm
Zm9ydHMgaXMgc28gdGhhdCB1c2VycywgZXZlbiB0aG9zZSBvbiBjYXNlIGluc2Vuc2l0aXZlDQog
ICAgZmlsZXN5c3RlbXMsIGNhbiBuYW1lIHRoZWlyIHJlZnMgZm9vIGFuZCBGT08gYW5kIGhhdmUg
dGhlIHN5c3RlbQ0KICAgIHRyZWF0IHRoZXNlIGFzIHR3byBkaXN0aW5jdCByZWZzLiAgSU9XLCB3
YW50aW5nIHRvIGVuaGFuY2UgInN1cHBvcnQiDQogICAgZm9yIGNhc2UgaW5zZW5zaXRpdmUgdHJl
YXRtZW50IG9mIHJlZnMgd2lsbCBub3QgZmx5LS0tYXNraW5nIGZvcg0KICAgICJoZWFkIiBhbmQg
Z2V0dGluZyBjb250ZW50cyBvZiAiSEVBRCIgb24gY2VydGFpbiBwbGF0Zm9ybXMgaXMgYSBidWcs
DQogICAgaW5kdWNlZCBieSBsaW1pdGVkIGZpbGVzeXN0ZW0gdGhlc2UgcGxhdGZvcm1zIHVzZSwg
YW5kIGl0IGlzIGJlaW5nDQogICAgZml4ZWQuDQoNCiAgICBUaGFua3MuDQoNCg0K
