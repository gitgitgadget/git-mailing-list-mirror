Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C9C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3E32067D
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 17:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plasticcircus.onmicrosoft.com header.i=@plasticcircus.onmicrosoft.com header.b="cZlBSEbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfKTR0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:26:16 -0500
Received: from mail-eopbgr680093.outbound.protection.outlook.com ([40.107.68.93]:22406
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728404AbfKTR0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 12:26:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba8WGKekVoeuO8+T62Owl5N6MMrs0uvnv1yHKDZxcwtffwsc0pjXBp6McJEJLL1dXyh3jqIssBCEUs8EiQQv4zrYTkK0E6LX6cLMY1DADjJx1Fxmc/EeybmQxuYZIJXc0Y1rW+s7NuDMgP9FaZqKJ6pTbQNWJZY06B9WeRd7ukeF2dyK4GKcS8hiVPP6hpfGK5tySkGQfihXsnQ3bsF/lwlswWJf/LdFvQpyUVY33AYop53hybuZzGO1jO3im8Qx+/kVHJh/ntn/2RR8dGanpM9BescwnoJk8d12oDT/b9Mg6vBNMORUAAlap7oRNv6g+WTHGU4D/oMDGSCXQahitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iZuEn/U1ngQuNRHIhhXhTpkF9iRGPeKbfyKEWoBDZk=;
 b=Drf1Oasqv9SMkRTqrdIJJrirHGNI18W4+HKypqgT+hQHLxhRwAQBhmIaRx1VOtRtpCkBY/cet6xyHHFQrpVlRrG6EzAflPoYDVi18jtaWG2zu1knjpmqXSiEm1JIn8gVUoFSPs9Nu8zxbVlU4vOT04eSernb/Jay4PYIwwT6hgPEeN0/ELLUEAuLagXrZAfJ6shcJox3G2mx1FVm1F0lF3QAFbN/G2/1QOl/8vSpz4Izl3hW6YRVxZ9dA9yZaIQquYZrXOIpc2SfWBVKPyqjLal6sMk43+dZeeBDPXwUgouoSJcIAAuzZRugku9m+OsZW3RYIKoGj6kJc9o0pmhW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plasticcircus.com; dmarc=pass action=none
 header.from=plasticcircus.com; dkim=pass header.d=plasticcircus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plasticcircus.onmicrosoft.com; s=selector2-plasticcircus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iZuEn/U1ngQuNRHIhhXhTpkF9iRGPeKbfyKEWoBDZk=;
 b=cZlBSEbP7TAE4GqT7MGkWOv6bE+kYaSd8KZqOB+QyfLEfrkk0u6Kt4zXW058NjtJ1r9xBapNna8Eh8UZosWK3WoONj7fShn/jwbd9+97wt4iER0tyS1Ctqpmpk7qWV4RN+Qwzirb/np1y/mJSoebSRXNLNIylO2j1OHdLSbgofs=
Received: from CY4PR05MB3287.namprd05.prod.outlook.com (10.171.246.25) by
 CY4PR05MB3301.namprd05.prod.outlook.com (10.171.246.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Wed, 20 Nov 2019 17:26:12 +0000
Received: from CY4PR05MB3287.namprd05.prod.outlook.com
 ([fe80::c965:c5b0:7ca1:a2df]) by CY4PR05MB3287.namprd05.prod.outlook.com
 ([fe80::c965:c5b0:7ca1:a2df%6]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 17:26:12 +0000
From:   John Sockwell <John@plasticcircus.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: git stash
Thread-Topic: Bug report: git stash
Thread-Index: AQHVmb7h/zXCehTS8Eq4Q0Urw84FCqeUW7cA
Date:   Wed, 20 Nov 2019 17:26:12 +0000
Message-ID: <B173575D-E845-498A-A3E4-5AF894215475@plasticcircus.com>
References: <3F47D50C-4E1C-4BAC-AFB9-3E908B123278@plasticcircus.com>
 <DB3F5927-76A4-43F1-8A09-EEB7D0B6F720@plasticcircus.com>
In-Reply-To: <DB3F5927-76A4-43F1-8A09-EEB7D0B6F720@plasticcircus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John@plasticcircus.com; 
x-originating-ip: [69.203.108.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 904ab730-ddab-482f-6169-08d76ddebd93
x-ms-traffictypediagnostic: CY4PR05MB3301:
x-microsoft-antispam-prvs: <CY4PR05MB3301FB96D1B066AF303F10FCDB4F0@CY4PR05MB3301.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(366004)(136003)(346002)(396003)(199004)(189003)(2351001)(446003)(99286004)(6246003)(316002)(25786009)(81156014)(81166006)(91956017)(66066001)(256004)(14444005)(76116006)(1730700003)(8676002)(50226002)(8936002)(14454004)(6116002)(3846002)(71200400001)(66556008)(64756008)(66446008)(86362001)(66946007)(6506007)(53546011)(26005)(102836004)(186003)(305945005)(5660300002)(71190400001)(66476007)(76176011)(33656002)(7736002)(80792005)(229853002)(2906002)(486006)(6512007)(6916009)(5640700003)(2501003)(508600001)(476003)(11346002)(36756003)(6486002)(2616005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR05MB3301;H:CY4PR05MB3287.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: plasticcircus.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPBq99HsyJ4nJ33Rh2g9rd4s5a2j8/2qIvsH+o7e8hJJEpJFEn26JhMZcNysOwPPgH7RKme8KNruWV17MTW2ek2751/fld4jVgnAHt7xj4psITFOZHVWu2o55n8FWsf5moo/742jmyxUXEbKGuo/1w8MpuBZODgD4oaEBXOu1nVa0uIW/c/Mu8+LilBTtkgcMOoeGARKTbxdHZPi/frKiq35tkN5oE/l9tIZdu3XXb00enWG+FB2tvwUcivPczvDf6Xq3mvlCw8pAoAjVSFlg2gKIpRkhl2HkLf6++/7gPbxMt3HSxxaZw9thODJwcj4Xg0mtOyDSvbHEHljOC51bbc5IrsquuH6V8zhfPTNxtTFCbn+ttbnXSZyrbhq60GlH8JeJ1bcBUCYxctkvaWPcwQFmNf8EIWlZPhOqKJq7yXLIi1SEYq7trQ/Y9/MAuHd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <03F0418E0869224ABB1E4E7DA2FE9B04@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: plasticcircus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ab730-ddab-482f-6169-08d76ddebd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 17:26:12.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb9aa32b-af1d-4883-98a5-8a5a7790d7e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBgMFsFofALo4KG++5qiPTg61co9XLsOLreMp2XRkXDbVnmlgRh7Lz6Oq47pP3vVGczXtB0xLo1sU/jB9pytug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3301
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gT24gMjAxOS4xMS4yMCwgYXQgMTI6MjAsIEpvaG4gU29ja3dlbGwgPEpvaG5AcGxhc3Rp
Y2NpcmN1cy5jb20+IHdyb3RlOg0KPiANCj4gDQo+IEhlbGxvLA0KPiANCj4gSeKAmXZlIGVuY291
bnRlcmVkIHVuZXhwZWN0ZWQgYmVoYXZpb3IgdXNpbmcgdGhlIGBnaXQgc3Rhc2ggcG9wIOKAlHF1
aWV0YCBhZnRlciB0aGUgcG9wIHRoZSBhbGwgdGhlIGZpbGVzIGluIHRoZSByZXBvIGFyZSB1bnRy
YWNrZWQuDQo+IA0KPiBNeSBzb2Z0d2FyZSB2ZXJzaW9uczogDQo+PiBtYWNPUyBDYXRhbGluYSAx
MC4xNS4xDQo+PiB6c2ggNS43LjENCj4+IGdpdCAyLjI0LjANCj4gDQo+IFN0ZXBzIHRvIHJlcHJv
ZHVjZToNCj4+IENyZWF0ZSBhbiBlbXB0eSByZXBvOiBgbWtkaXIgL3RtcC9naXQ7IGNkIC90bXAv
Z2l0OyBnaXQgaW5pdGANCj4+IENvbW1pdCBhbiBlbXB0eSBmaWxlOiBgdG91Y2ggc2FtcGxlLWZp
bGU7IGdpdCBhZGQgc2FtcGxlLWZpbGU7IGdpdCBjb21taXQgLS1tZXNzYWdlICJJbml0aWFsIGNv
bW1pdOKAnWANCj4+IE1vZGlmeSB0aGUgc2FtcGxlIGZpbGU6IGBlY2hvICJtb2RpZmljYXRpb24i
ID4gc2FtcGxlLWZpbGVgDQo+PiBTdGFzaCB0aGUgZGlydHkgdHJlZTogYGdpdCBzdGFzaCBwdXNo
YA0KPj4gUG9wIHRoZSBzdGFzaDogYGdpdCBzdGFzaCBwb3BgIOKAlCB3b3JraW5nIHRyZWUgcmV0
dXJuZWQgdG8gZGlydHkgc3RhdGUgd2l0aCBtb2RpZmllZDogc2FtcGxlIGZpbGUNCj4+IFN0YXNo
IHRoZSBkaXJ0eSB0cmVlIGFnYWluOiBgZ2l0IHN0YXNoIHB1c2hgDQo+PiBQb3AgdGhlIHN0YXNo
IHVzaW5nIHRoZSDigJRxdWlldCBvcHRpb246IGBnaXQgc3Rhc2ggcG9wIOKAlHF1aWV0YA0KPiAN
Cj4gRXhwZWN0ZWQgcmVzdWx0OiBTYW1lIGJlaGF2aW9yIGFzIHdpdGhvdXQgdGhlIOKAlHF1aWV0
IG9wdGlvbi4gV29ya2luZyB0cmVlIHRvIGFnYWluIGJlIHJldHVybmVkIHRvIGRpcnR5IHN0YXRl
IHdpdGggbW9kaWZpZWQ6IHNhbXBsZS1maWxlDQo+PiBgZ2l0IHN0YXR1c2ANCj4+IE9uIGJyYW5j
aCBtYXN0ZXINCj4+IENoYW5nZXMgbm90IHN0YWdlZCBmb3IgY29tbWl0Og0KPj4gICAodXNlICJn
aXQgYWRkIDxmaWxlPi4uLiIgdG8gdXBkYXRlIHdoYXQgd2lsbCBiZSBjb21taXR0ZWQpDQo+PiAg
ICh1c2UgImdpdCByZXN0b3JlIDxmaWxlPi4uLiIgdG8gZGlzY2FyZCBjaGFuZ2VzIGluIHdvcmtp
bmcgZGlyZWN0b3J5KQ0KPj4gCW1vZGlmaWVkOiAgIHNhbXBsZS1maWxlDQo+PiANCj4+IG5vIGNo
YW5nZXMgYWRkZWQgdG8gY29tbWl0ICh1c2UgImdpdCBhZGQiIGFuZC9vciAiZ2l0IGNvbW1pdCAt
YeKAnSkNCj4+IA0KPiBBY3R1YWwgcmVzdWx0OiB3b3JraW5nIHRyZWUgaXMgZGlydHkgd2l0aCBh
IGRpZmZlcmVudCBzZXQgb2YgY2hhbmdlcyBkZWxldGVkOiBzYW1wbGUtZmlsZSwgdW50cmFja2Vk
IGZpbGVzOiBzYW1wbGUtZmlsZQ0KPj4gYGdpdCBzdGF0dXNgDQo+PiBPbiBicmFuY2ggbWFzdGVy
DQo+PiBDaGFuZ2VzIHRvIGJlIGNvbW1pdHRlZDoNCj4+ICAgKHVzZSAiZ2l0IHJlc3RvcmUgLS1z
dGFnZWQgPGZpbGU+Li4uIiB0byB1bnN0YWdlKQ0KPj4gCWRlbGV0ZWQ6ICAgIHNhbXBsZS1maWxl
DQo+PiANCj4+IFVudHJhY2tlZCBmaWxlczoNCj4+ICAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4i
IHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCj4+IAlzYW1wbGUtZmlsZQ0K
PiANCj4gDQoNCg==
