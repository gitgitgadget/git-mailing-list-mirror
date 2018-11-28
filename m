Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B691F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 06:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeK1Rza (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 12:55:30 -0500
Received: from mail-eopbgr10110.outbound.protection.outlook.com ([40.107.1.110]:32862
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbeK1Rz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 12:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hiboxsystems.onmicrosoft.com; s=selector1-hibox-tv;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/JlaT3L2fKcSJC6xZ7Fgce90N7Hj4Cuvdur3QtQZqk=;
 b=ISV+t3BYVJU0ol1IFRqCFumxzRJgbdtPPSJAchWHfLZrGxQjnRYHOzbeICvw55f4hDNzwoMLZDGb/A6NSOJlOW+CiJ1VY2A5St3dFFOnCZlkoFrBYKUsm2TdrM9O75jfOAKN2+OQ8mdDaBHia/P4myW+4q5jmVDqlpvbeGPJHsA=
Received: from DB5PR08MB1063.eurprd08.prod.outlook.com (10.166.14.24) by
 DB5PR08MB0854.eurprd08.prod.outlook.com (10.164.43.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 06:54:46 +0000
Received: from DB5PR08MB1063.eurprd08.prod.outlook.com
 ([fe80::c061:7d4f:bfca:9064]) by DB5PR08MB1063.eurprd08.prod.outlook.com
 ([fe80::c061:7d4f:bfca:9064%6]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 06:54:46 +0000
From:   Per Lundberg <per.lundberg@hibox.tv>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     Jacob Keller <jacob.keller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Thread-Topic: [RFC PATCH] Introduce "precious" file concept
Thread-Index: AQHUebrNrQJxbaGKnUecpgicPjXQo6VMyZuAgBU5qgCAAEIxAIAAAgwAgAAB1gCAAAHGgIAAAkGAgAFL8ACAABRGAIAAQZMAgACO0gCAAF0MAA==
Date:   Wed, 28 Nov 2018 06:54:46 +0000
Message-ID: <08c3997b-b6fd-b1df-cc1c-f8b054f69f67@hibox.tv>
References: <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
 <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com>
 <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com>
 <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
 <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv>
 <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
 <56ffc52f-644c-2c1d-6a16-c1005b064385@hibox.tv>
 <20181128012142.GT890086@genre.crustytoothpaste.net>
In-Reply-To: <20181128012142.GT890086@genre.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::33) To DB5PR08MB1063.eurprd08.prod.outlook.com
 (2603:10a6:0:14::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=per.lundberg@hibox.tv; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.94.0.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR08MB0854;6:Er2DkneS/waqWe+diXaBFTVD+TlOAafrjICF4yvDCHmlgHrWlMQb136OSAVjHcqcAvKPGyKW1mG9+kEnTjrwvGA1ndvx7y8C+fU+OTbLxQsTlX1ihnO2JtEgqz7ax+10ZX7Nep5cPl7C3+I7NWfDU8FZMekaaP7uiA3wcSoVHUEscW8G1plnD9qSiCqzA1zDB4nX9KY1pjR6TiwLm8w5HNIFoUqe6aAO9SVJKnGDoeRN7uGgxoqavX+/KGYQ+QIIzoZI86VI1WcwWGpe8pPwN9ZxvOr/OVeucjARlD9n47MH+G0ZIqkGw/EQ+UfAIP939kTJNQfbbPqBLhEt2/41OS5zbQYtAfetURr7Zrobh5COo30AEviRnd5dPnpmVgoetdJhh4z4y4sGTrzkN98I/0j6eGrVrH4mEsBvvEZSZ8cLjr5U99AqAhLs2ZAxFz5X5lfhld7LLbaV2FhZ9EENsg==;5:WzQUFIA3Hi9NC0NVDJ8Nk9KWCNOwkatkWPVvBKHRo1xbi48yZdg0Ebyb3T6RHOA0/OE7gUIOxVhEv+HqDs7+ViEwBNlTOtQDvFoZ0h4/7YT9/hLjdjRn/ArJAjgM0FRXMs76w7hkkuCFdVmIXio6cEb9MVHCCrPK2B7qM3Hn/kE=;7:EUQnqDWLhu6Whp1gTauyZkfDwHSwx48DuAd40NTEu3JNixAIN6EUr8dhe6GSfmbzm3tK8bLu6JXZPpFS252rvLiiCP1uSv7Vtde0k7J2LZDq5SLq2g+DenF7Zd4m6y+j6He/xiw+gyUVfwZJlWI/9A==
x-ms-office365-filtering-correlation-id: f8fce982-0aa2-492f-eb73-08d654fe61c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB5PR08MB0854;
x-ms-traffictypediagnostic: DB5PR08MB0854:
x-microsoft-antispam-prvs: <DB5PR08MB0854EE268CD52ADA86204516EAD10@DB5PR08MB0854.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:DB5PR08MB0854;BCL:0;PCL:0;RULEID:;SRVR:DB5PR08MB0854;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39830400003)(346002)(376002)(51914003)(189003)(199004)(81156014)(8676002)(5660300001)(8936002)(7736002)(508600001)(2906002)(25786009)(305945005)(4326008)(31686004)(74482002)(81166006)(54906003)(36756003)(97736004)(316002)(66066001)(71200400001)(71190400001)(93886005)(229853002)(6486002)(6512007)(6436002)(3846002)(106356001)(31696002)(76176011)(86362001)(52116002)(99286004)(11346002)(446003)(102836004)(476003)(2616005)(486006)(14454004)(53546011)(386003)(6506007)(44832011)(186003)(6246003)(6116002)(26005)(39060400002)(105586002)(14444005)(256004)(53936002)(68736007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR08MB0854;H:DB5PR08MB1063.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hibox.tv does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HOw17lup80yODhulND+7zNaOJN8OY5gC8ycQInnms4pIkapLffiKaPNYQPcBGntVFdKxY78wu+zQrnmiKXUhi+BWyC8x0YLAssWwRS2DVKVzxnRwSy7MiNSBgO31HmLYHlwhPvtP0Pz0deVJP7CBeLsW6BmyG8fnMVL6JTPDJ1jEE5SBTJm6qDusKAIpVi1dycUdnlwaFKKqEfS+Cqdsj01GJeUntygdioXvSSZ9W8w9TJZzNoxmSvJwOKLFkdsVt8Tk/1Q63PoIFfMEwr9dqocClQM9ck2OoznwRJ7/NtXbQHq1Tan5GXb4E/XQ3Oml8OySMSvOapfvjozu8avMiQoBKu2J0+VKioe/FfbVDEY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3571C689701ACC44978E80818E1C5601@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hibox.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fce982-0aa2-492f-eb73-08d654fe61c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 06:54:46.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eec7d2e0-55d2-4f5e-ac15-00bd4e779ed6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB0854
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMTEvMjgvMTggMzoyMSBBTSwgYnJpYW4gbS4gY2FybHNvbiB3cm90ZToNCg0KVGhhbmtzIGZv
ciB0aGUgZWxhYm9yYXRpb24sIEJyaWFuIC0gZ29vZCB0byBnZXQgdGhpbmdzIGRvd24gdG8gYSAN
CnByYWN0aWNhbCwgcmVhbC13b3JsZCBsZXZlbC4NCg0KID4gWy4uLl0NCiA+DQo+IEkgcG9pbnQg
dGhpcyBvdXQgdG8gdW5kZXJzY29yZSBob3cgZnVuZGFtZW50YWwgdGhpcyBjaGFuZ2UgaXMuICBQ
ZW9wbGUNCj4gb3ZlcndoZWxtaW5nbHkgZG8gbm90IHJlYWQgdGhlIHJlbGVhc2Ugbm90ZXMsIHNv
IGV4cGVjdGluZyBwZW9wbGUgdG8NCj4gcmVhbGl6ZSB0aGF0IGEgY2hhbmdlIGhhcyBiZWVuIG1h
ZGUsIGVzcGVjaWFsbHkgd2hlbiBtYW55IHBlb3BsZSBvbmx5DQo+IHVwZ3JhZGUgR2l0IGJlY2F1
c2Ugb2YgYSBzZWN1cml0eSBpc3N1ZSwgbWF5IHJlc3VsdCBpbiB1bmV4cGVjdGVkDQo+IGNvbnNl
cXVlbmNlcy4NCg0KVGhpcyBpcyBvbmUgb2YgdGhlIG1vcmUgaW1wb3J0YW50IHRoaW5ncyBvZiBz
b2Z0d2FyZSBlbmdpbmVlcmluZy4gX0Rvbid0IA0KbWl4IHNlY3VyaXR5IGZpeGVzIHdpdGggYnJl
YWtpbmcgY2hhbmdlc18uIFRoZXkgYXJlIHZlcnkgZGlmZmVyZW50IA0KdGhpbmdzIGFuZCBsaWtl
IHlvdSBzYXksIHdlIGNhbid0IHJlYWxseSBleHBlY3QgcGVvcGxlIHRvIHJlYWwgcmVsZWFzZSAN
Cm5vdGVzIGZvciBldmVyeSBsaXR0bGUgaW5jcmVtZW50YWwgcmVsZWFzZSB3ZSBkby4NCg0KVGhh
dCdzIGFuIGltcG9ydGFudCBwYXJ0IG9mIHRoZSBTZW1WZXIgZ3VhcmFudGVlOiBhIG1pbm9yIHZl
cnNpb24gDQpidW1wL3BhdGNoIGxldmVsIGluY3JlYXNlIG1lYW5zICJidWcgZml4IiBvciAiYWRk
ZWQgZnVuY3Rpb25hbGl0eSBpbiBhIA0KYmFja3dhcmRzLWNvbXBhdGlibGUgd2F5Ii4gU286IG5v
IGNoYW5naW5nIG9mIGRlZmF1bHQgYmVoYXZpb3Igb3IgDQpzZW1hbnRpY3MsIGJ1dCBhZGRpbmcg
YSBuZXcgYmVoYXZpb3Igd2hpY2ggaXMgb3B0LWluIGlzIHBlcmZlY3RseSBmaW5lLg0KDQo+IEp1
c3QgYmVjYXVzZSB3ZSBkb24ndCB0aGluayBvZiB0aGlzIHVzZSBvZiBHaXQgYXMgbm9ybWFsIG9y
IGRlc2lyYWJsZSA+IGRvZXNuJ3QgbWVhbiBwZW9wbGUgZG9uJ3QgZG8gaXQgYW5kIGRvbid0IGV4
cGVjdCBpdCB0byBrZWVwIHdvcmtpbmcuDQoNCkluIG90aGVyIHdvcmRzLCB3ZSBuZWVkIHRvIGJl
ICJidWctYnktYnVnIiBjb21wYXRpYmxlIHdpdGggcHJldmlvdXMgDQp2ZXJzaW9ucy4gOi0pIFdo
YXQgc29tZSBwZW9wbGUgd291bGQgY29uc2lkZXIgYSBidWcsIG90aGVycyB3b3VsZCANCmNvbnNp
ZGVyIGEgZmVhdHVyZS4NCg0KPiBJIHRoaW5rIGFueSBjaGFuZ2Ugd2UgbWFrZSBoZXJlIGhhcyB0
byBiZSBvcHQtaW4sIGF0IGxlYXN0IHVudGlsIEdpdA0KPiAzLjAuICBBIGNvbmZpZyBrbm9iIHdv
dWxkIHByb2JhYmx5IGJlIHRoZSByaWdodCB3YXkgdG8gZ28uIA0KDQpBZ3JlZS4gSXQncyBsZXNz
IHRoYW4gb3B0aW1hbCBidXQgSSB0aGluayBpdCdzIHNvbWV0aGluZyB0aGF0IHdlIGFsbCANCmNv
dWxkIGxpdmUgd2l0aC4gRGVjaWRpbmcgdG8gc3dpdGNoaW5nIHRoZSBkZWZhdWx0IChvciBub3Qp
IGlzIHRoZW4gDQpyaWdodGZ1bGx5IHBvc3Rwb25lZCB0byBhIGxhdGVyIHRpbWUsIGFuZCB3ZSBj
YW4gcmV2aXNpdCB0aGUgcHJvcyBhbmQgDQpjb25zIHRoZW4uIFRoZSBpbXBvcnRhbnQgdGhpbmcg
bm93IGlzIHRvIGdldCB0aGUgZnVuY3Rpb25hbGl0eSANCmltcGxlbWVudGVkIGluIGEgZ29vZCB3
YXksIHRlc3RlZCBhbmQgZXZlbnR1YWxseSBtZXJnZWQuDQotLQ0KUGVyIEx1bmRiZXJnDQo=
