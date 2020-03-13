Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88126C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344CC206B7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=InnovaAS.onmicrosoft.com header.i=@InnovaAS.onmicrosoft.com header.b="jqtg4pT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCMTLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:11:10 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:9403
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbgCMTLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niX9YOylQF8FMPdROTW8uV/rVmyCxkGLN2MCySe4s8bJ0jArD4Kh0bIwNfT+Fjf/rcpacpMHbixnwsxD1gp2t6NF6+FjzGkRyFQ1sroHnnkI6fIFaFgMvp+a1Qnmvr1Z7hhmLpFK14Tm7ovZ3t5mpYmI/pfs1Obduf140BOKECqTkOUpwMC8yIaAl0Xtg40jpTU8/QLvNw5naUSoKetiQWbu59Vm5YhKy2MRpROhtMBl91/79hKhyAImYJuNxRadVkT4f0wxeZ1WjrD0hUDEKAjXvu340DA0brEeS3uDDNdZ2Qv6KpfsJkY9HoOwW58W/aWrxB0BgLSRT2N6s+oyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNQXbACo3N61iY/75ldbdBT2Ss5Z1IofSqJTp/n8QZg=;
 b=fUV4LV5kTZuPoVhfCUPlkSgXbSoOSzGWHVLVSp954a9cQs2xk4C7hvauUhLnLg/urBki0Gxg384Odi9C/lTkeT40X6iPAYpW4NSo4HFRSwM7vkDiBVZVNcYW8AbDW6LHwiBj18z0UqVLAv1NHE6fjQC92YxaAqBXxeLtQWhA7tL7q5eOsJwKumbEgGj3TM9249kxfv4yAe7kEHGaor3qYZdUpfaPMdRHwJ9ldDjlO2a4QsSqoWq6nVYIWYYh/BA24VTeVT5oDkJEvoSygQPN15izpShtKgpHUICCbEB/kPDLyvnAE0bgccwPZdH6iLW6ehtWC9miq8ENElsZA0RNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innova.no; dmarc=pass action=none header.from=innova.no;
 dkim=pass header.d=innova.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=InnovaAS.onmicrosoft.com; s=selector2-InnovaAS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNQXbACo3N61iY/75ldbdBT2Ss5Z1IofSqJTp/n8QZg=;
 b=jqtg4pT7rTMiRhHKLt91OiY+MSk9NWHCAHkODFRQMZpSMNXjw5DybJVPS8pj69o5xLJ5A/yJLMZVSDOz+g4kusNWaNOnKFbYCyzW0EWATImyxhYCdE9xEiX/z8OIq3zFUoDrFH0qPSuME7egA53qo4X0t/sZIxXncXHODT4bM8U=
Received: from AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM (10.161.92.147) by
 AM5PR10MB1636.EURPRD10.PROD.OUTLOOK.COM (10.161.64.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Fri, 13 Mar 2020 19:10:23 +0000
Received: from AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd87:bf66:b0fc:5e0c]) by AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd87:bf66:b0fc:5e0c%7]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 19:10:23 +0000
From:   Erlend Aasland <Erlend-A@innova.no>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Jeff King <peff@peff.net>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] Make rev-parse -q and --is-* quiet
Thread-Topic: [RFC PATCH] Make rev-parse -q and --is-* quiet
Thread-Index: AQHV+V0aCsg2KJf4ukOTNt4cPsCTh6hGzFKAgAAIjcKAAA58AA==
Date:   Fri, 13 Mar 2020 19:10:23 +0000
Message-ID: <CAB5DABE-BBBE-4E1A-83FE-E2840714CA7C@innova.no>
References: <CAHk66ftWBYF3d_L0-__BP5mKNxBioj57y44yhyqGrtK3TZTjSg@mail.gmail.com>
 <20200313174755.GA549554@coredump.intra.peff.net>
 <xmqqa74kce4t.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa74kce4t.fsf@gitster.c.googlers.com>
Accept-Language: nn-NO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Erlend-A@innova.no; 
x-originating-ip: [92.220.124.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45783429-8313-49a4-ec22-08d7c7822e37
x-ms-traffictypediagnostic: AM5PR10MB1636:
x-microsoft-antispam-prvs: <AM5PR10MB1636EFB349180AA21CFE57199CFA0@AM5PR10MB1636.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39840400004)(396003)(376002)(199004)(6486002)(316002)(53546011)(6506007)(2906002)(186003)(66446008)(64756008)(5660300002)(66476007)(66556008)(66946007)(86362001)(71200400001)(54906003)(91956017)(2616005)(76116006)(36756003)(6916009)(508600001)(4326008)(8936002)(81166006)(8676002)(6512007)(81156014)(26005)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR10MB1636;H:AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: innova.no does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYEqVunt+YuKwmW9oSP5Qg2Bw7ugPJStrtXNNtn6DYhTgJEivK6A6XL+208uGzd+s0mPXNHcZ7E4TlayioqNE+OeNvjsBXeweuAA+ZXZUudxkj241S4HlcaDSRKdPHinHHeJk45TtAzl3V1906U/zo53ka4sCMrUwy+g3um0t1beRRNPkukbglXGOQPH+Rxv6Q3M85NNgORP7Bxl3ll9ee+9WZrTqpX7486UXME+XPR99ERNjj9W+t2bcz3tg7GPA/7NfutRg2rkmFHKMP3o+nO0Pp/Tyq7Pj8rVMGsT7eDgleUoz3dF13hi9O0MiKqxOAeAaM1wLCXMfslfwNLjMeS+JMSqCiWeM0ZoS27Hqq31pJjqXZ1OL19eTN7YN+Yv/gfurvtRxtcJeRMSaYMOx92JtmJRbB6NGKv2OHCf13A8zypmd3Df4GNtKT7hE3Y5
x-ms-exchange-antispam-messagedata: LHUE+VWKggh1fOVA3htqxB892ZySXLaG/jsBLgiqmr4/R0WEYhPt5B2j7pTbt/ZfKEYpGI38MRw1z2P8uzPikpAXjYoh+FJC5EUKv9/anML++oFf7NkSfGxfs2xe2CXneE01YcyEudIZYgOJzTevNw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <956D128905EFEC4196DF234FB8FDDC06@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: innova.no
X-MS-Exchange-CrossTenant-Network-Message-Id: 45783429-8313-49a4-ec22-08d7c7822e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 19:10:23.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b7619df-4c48-4446-b5bc-62bc2f3cd746
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQnpdyp6593bNxmpGf1/tVkH3sg436GBxShSoSy9el2ZcbAYBbq1HqM6ToagbRaLxdXO5A02vvOK9tgWmP4z8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1636
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGFsbCBmb3IgeW91ciB0aG9yb3VnaCByZXZpZXdzIGFuZCBjb25zdHJ1Y3RpdmUg
Y29tbWVudHMuDQoNCk1hbnkgb2YgeW91IGNvbW1lbnQgb24gdGhlIHNhbWUgZmxhd3MgaW4gbXkg
cGF0Y2g7IEnigJlsbCBhZGRyZXNzIGFsbCBvZg0KdGhlbSBpbiB0aGUgZXZlbnQgb2YgYSBzZWNv
bmQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLCBpZiB5b3UgYWxsIHRoaXMgdGhpcw0KZmVhdHVyZSBp
cyB3b3J0aCBpdC4NCg0KSXNzdWUgMSkgTmFtaW5nDQpJ4oCZbGwgcmVuYW1lIHRoZSBpc19zZXQg
dmFyaWFibGVzIGFjY29yZGluZyB0byBBYmhpc2hla+KAmXMgcHJvcG9zYWwgKGlzX2lubGluZSwN
CmlzX3NoYWxsb3csIGV0Yy4pDQoNCklzc3VlIDIpIFByZW1hdHVyZSByZXR1cm4NClllcywgSSBj
aG9zZSB0aGUgZWFzaWVzdCB3YXkgb3V0LCBzaW5jZSB0aGlzIHdhcyBhIFJGQyA6KSBPbmUNCnBv
c3NpYmlsaXR5IGNvdWxkIGJlIHRvIEFORCBvciBPUiB0aGUg4oCUaXMtKiBvcHRpb25zIHRvZ2V0
aGVyLCBidXQgSSB0aGluaw0KZ29pbmcgd2l0aCBKdW5pb+KAmXMgcHJvcG9zYWwgaXMgdGhlIG1v
c3Qgc2FuZSB0aGluZyB0byBkbzoNCg0KDQpPbiAxMyBNYXIgMjAyMCwgYXQgMTk6MTgsIEp1bmlv
IEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IC0gd2hlbiAtLXF1aWV0IGlz
IGluIHVzZSwgbWFrZSAtLWlzLSogbXV0dWFsbHkgZXhjbHVzaXZlIGFuZCBkaWUNCj4gIHdoZW4g
bW9yZSB0aGFuIG9uZSBvZiB0aGVtIGlzIGdpdmVuLiAgSSB0aGluayBhbnkgb2YgdGhlIC0taXMt
KiwNCj4gIHdoZW4gdXNlZCB3aXRoIC0tcXVpZXQsIHNob3VsZCBhbHNvIGJlIGFuIGVycm9yIGlm
IHRoZXJlIGFyZSByZXZzDQo+ICBvbiB0aGUgY29tbWFuZCBsaW5lIChlLmcuICJnaXQgcmV2LXBh
cnNlIC0taXMtaW5zaWRlLWdpdC1kaXINCj4gIEhFQUQiIGlzIE9LLCBidXQgbm90IHdpdGggIi0t
cXVpZXQiKS4NCg0KSXNzdWUgMykgRXhpdCBjb2RlDQpJIHRoaW5rIGdvaW5nIHdpdGggSnVuaW/i
gJlzIHByb3Bvc2FsICgwID0+IHRydWUsIDEgPT4gZmFsc2UsIDIgPT4gZXJyb3IpIGlzIG9rLg0K
DQoNCknigJlsbCBoYXZlIGFub3RoZXIgZ28gYXQgaXQsIGlmIHlvdSBhbGwgdGhpbmsgaXTigJlz
IHdvcnRoIGl0LiBJZiBzbywgSeKAmWxsIGFsc28gYWRkIGRvY3MNCmFuZCB1bml0IHRlc3RzLg0K
DQoNCkVybGVuZA0KDQoNCj4gT24gMTMgTWFyIDIwMjAsIGF0IDE5OjE4LCBKdW5pbyBDIEhhbWFu
byA8Z2l0c3RlckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4gSmVmZiBLaW5nIDxwZWZmQHBlZmYu
bmV0PiB3cml0ZXM6DQo+IA0KPj4gSSdtIG5vdCBzdXJlIGlmIHJldHVybmluZyBhIHNpbmdsZSBp
c19zZXQgbWFrZXMgc2Vuc2UsIHRob3VnaC4gSXQNCj4+IGVmZmVjdGl2ZWx5IGJlY29tZXMgYW4g
T1IsIGFuZCB5b3Ugd291bGRuJ3Qga25vdyB3aGljaCBmbGFnIHRyaWdnZXJlZA0KPj4gaXQuIEl0
IHdvdWxkIG1ha2UgbW9yZSBzZW5zZSB0byBtZSBmb3IgdGhlIGludm9jYXRpb24gYWJvdmUgdG8g
c2ltcGx5IGJlDQo+PiBhbiBlcnJvciwgcmVtaW5kaW5nIHRoZSBjYWxsZXIgdGhhdCB0aGV5IG5l
ZWQgdG8gaGFuZGxlIGl0IG1vcmUNCj4+IGNhcmVmdWxseS4NCj4+IA0KPj4gV2UgX2NvdWxkXyBl
bmNvZGUgZWFjaCB2YWx1ZSBpbnRvIHRoZSBleGl0IGNvZGUgKGUuZy4sIHNldCBiaXQgMSBpZiB0
aGUNCj4+IGZpcnN0IGNvbmRpdGlvbiB3YXMgdHJ1ZSwgYW5kIHNvIG9uKS4gQnV0IGNoZWNraW5n
IHRoYXQgYmVjb21lcyBhcyBtdWNoDQo+PiBoYXNzbGUgYXMgcmVhZGluZyBzdGRvdXQsIHNvIHRo
ZXJlJ3MgbGl0dGxlIHZhbHVlLg0KPiANCj4gTm9uZSBvZiB0aGUgYWJvdmUgZXhjaXRlcyBtZS4g
IEkgZG8gbm90IHRoaW5rIGl0IG1ha2VzIG11Y2ggc2Vuc2UgdG8NCj4gY29tYmluZSAtcSB3aXRo
IC0taXMtKiBmb3IgdGhlIHJlYXNvbnMgeW91IHN0YXRlZCBhbHJlYWR5IChpLmUuIHRoZQ0KPiBj
YWxsZXIgY2Fubm90IHRlbGwgYmV0d2VlbiAiZmFpbHVyZSIgYW5kICJmYWxzZSIpIGluIHRoZSBm
aXJzdA0KPiBwbGFjZSwgYnV0IGlmIHdlIG11c3QgZG8gdGhpczoNCj4gDQo+IC0gcmVzZXJ2ZSAw
ICh0cnVlKSBhbmQgMSAoZmFsc2UpIGZvciBzdWNjZXNzZnVsIGV4aXQgYW5kIHVzZSAyIChvcg0K
PiAgIGFib3ZlKSBmb3Igb3RoZXIgZmFpbHVyZXM7DQo+IA0KPiAtIHdoZW4gLS1xdWlldCBpcyBp
biB1c2UsIG1ha2UgLS1pcy0qIG11dHVhbGx5IGV4Y2x1c2l2ZSBhbmQgZGllDQo+ICAgd2hlbiBt
b3JlIHRoYW4gb25lIG9mIHRoZW0gaXMgZ2l2ZW4uICBJIHRoaW5rIGFueSBvZiB0aGUgLS1pcy0q
LA0KPiAgIHdoZW4gdXNlZCB3aXRoIC0tcXVpZXQsIHNob3VsZCBhbHNvIGJlIGFuIGVycm9yIGlm
IHRoZXJlIGFyZSByZXZzDQo+ICAgb24gdGhlIGNvbW1hbmQgbGluZSAoZS5nLiAiZ2l0IHJldi1w
YXJzZSAtLWlzLWluc2lkZS1naXQtZGlyDQo+ICAgSEVBRCIgaXMgT0ssIGJ1dCBub3Qgd2l0aCAi
LS1xdWlldCIpLg0KPiANCj4gaXMgdGhlIG1pbmltdW0gdGhhdCBtYWtlcyBtZSBmZWVsIHRoYXQg
d2UgaGF2ZSBzZW1pLXJlYXNvbmFibGUNCj4gYmVoYXZpb3VyIHRoYXQgY2FuIGJlIGV4cGxhaW5l
ZCB0byBlbmQgdXNlcnMuDQoNCg==
