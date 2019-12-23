Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6B5C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 14:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2B920715
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 14:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=strongestfamiliesinternal.onmicrosoft.com header.i=@strongestfamiliesinternal.onmicrosoft.com header.b="soqXJlKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLWO7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:59:31 -0500
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:64736
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfLWO7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 09:59:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APHosDJmYd8tftfDvN9HAdmuYIHA/yM2Xqkxj/NYAsJdISjG4OFlSZ4YJPhFG+o21gvten3y+rqa7p16viUUIMDJRfB+5Iyq3hpqF7fz3FBplLzjITP6V4HUYPiMfk/0jJQoHYveQwrMEFuaTOdnqAjGmtvsAD6OiZ0M3u9vCoQDRFOmak43RCqbef2DDka9NribgnPtruclxKl8DLr9eXwNs52qDUcWAk+z5vVh3kuq9FTPnlWbyX+IH2IH0982yZAdL+oNQeGW1PKZVPDOi7sGR/LgPm4GEeZEQXZJKbEcXAxQSFD82Eir0/ZnFvx1iin1giRa/jbhw0SocFwEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDLFsVNUV4tp7QMujOLc20mi1UMVqiljBFtCPPclMDI=;
 b=h8Vzw3AByQ8cJdaYO8sj4zOEI6D1URh+NqeFgsnQv96BszYbihdQlQIXWI99vMym+vsTps2CnW37F4AMxcyXisCt108g1YJpVO+gRwE2JktdsKCCYOzLSOlF2FJeF8/breEBnRlHPh4LdZizC4WoyjMHWzMXHz74sxVJp0H7D1tC0IQV6qcudmIviBMX2crmm0marRyBYak2jYjox5bwjAgap3yvreaQZG9D8PiBXu4jSzZNMxS7fqCGm8vP90Gomp+ysPp2Qj8ySvF9aMIEW691T2DQ+QPdLNGZrTc9O4Oou9OOwSNVY1JnElRdPxcwdeoHb102iCFjyhUAXtrePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=strongestfamilies.com; dmarc=pass action=none
 header.from=strongestfamilies.com; dkim=pass header.d=strongestfamilies.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=strongestfamiliesinternal.onmicrosoft.com;
 s=selector2-strongestfamiliesinternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDLFsVNUV4tp7QMujOLc20mi1UMVqiljBFtCPPclMDI=;
 b=soqXJlKIc+jgvrg5UtKKlnpfa4CKHeKq7rhyKxjbqWr4jThflwBZJ50BW4NQmAQqe7IT5ISSGZUH8vUv7RkfuGzcGoT6p+YJnFLYflYgQ9Hn5Cg7SywalYn2zE3Rvr0VkN/q7sdWyXyaRA+Ga7AOkzsjxV1v8KwLWHaq6sAecms=
Received: from CH2PR22MB1894.namprd22.prod.outlook.com (20.180.12.71) by
 CH2PR22MB1909.namprd22.prod.outlook.com (20.180.10.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 14:59:28 +0000
Received: from CH2PR22MB1894.namprd22.prod.outlook.com
 ([fe80::15bc:62cc:b42f:4e3a]) by CH2PR22MB1894.namprd22.prod.outlook.com
 ([fe80::15bc:62cc:b42f:4e3a%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 14:59:28 +0000
From:   Casey Meijer <cmeijer@strongestfamilies.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GIT BUG] show-ref doesn't work with Symbolic Refs other than
 HEAD
Thread-Topic: [GIT BUG] show-ref doesn't work with Symbolic Refs other than
 HEAD
Thread-Index: AQHVt2/AQ3JWu6T8oUCxgJEDa1BTGafDL1sAgABIEEWABBnLgA==
Date:   Mon, 23 Dec 2019 14:59:27 +0000
Message-ID: <07BD46C7-19F0-47EE-B6AB-23C300C8F690@strongestfamilies.com>
References: <46A996A1-4B9D-4613-A49B-A95E98119DFA@strongestfamilies.com>
 <BF8A29F0-0572-49EA-9E3F-AC6964C6D8B0@strongestfamilies.com>
 <xmqqo8w2928s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8w2928s.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cmeijer@strongestfamilies.com; 
x-originating-ip: [173.252.62.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3306689-8e3d-4a01-4f77-08d787b8b542
x-ms-traffictypediagnostic: CH2PR22MB1909:
x-microsoft-antispam-prvs: <CH2PR22MB190925E369A011F69B0363EDAB2E0@CH2PR22MB1909.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39830400003)(376002)(396003)(366004)(199004)(189003)(36756003)(66446008)(2906002)(4001150100001)(86362001)(6486002)(91956017)(6916009)(2616005)(6512007)(64756008)(76116006)(66946007)(66476007)(66556008)(508600001)(71200400001)(33656002)(6506007)(186003)(316002)(26005)(4326008)(8936002)(8676002)(81156014)(81166006)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR22MB1909;H:CH2PR22MB1894.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: strongestfamilies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9zqz6V/L8yWk0u2UdRWOm38tvvl82UFAest53NS0Cpq8uoiyJKlzG5rCdRRJXHJhBY7+uSqU1trrb4ToEwgTTE76ct93A+HUeLUdHDpeisO2USGUnZ0CURWY5+suoGUclS/hcQC382Uu2JvNfhESDCRyzgKoP2A0Gm581anyDMC+v8Fr5lkpQ8THN1A7w7CWxziq3XuMbWQOxDMdYGVOrAe9EIuSBJimBUbzBIwQwZlnhaTjr5RObT/psnd2PTu+bYeSBQY8/fUDCgxVuK229u/wvKTvka/kQcz7ig3oTwfBMkWwkD9Pyr5YtgDnsg3uZck2+fJCFWnUtogNXdiUGUqXMNzFWuqp+U7uOrtYTrDKkZdxIS57pXtcWjWm4BNN+220df5kI8Yu8jBCJ9VxJCeUc92efxmeDwmVse3nG7dBhMQhmuZ8CLm7vGnfhq2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D3480ADB587234E8CC7156EAF17D08F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: strongestfamilies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3306689-8e3d-4a01-4f77-08d787b8b542
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 14:59:27.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88c0a794-6b77-42fa-a51d-2e160c167dfa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zJqc7h2pSYXw+4Af6xLvLawrFmI/nS0zlSnv3w1lCodOwMj8aj2haNW4p64ayxc14a0ZNe7CdanNXalOOIPtxpOwEhaFYrvZ7En+oJLP1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1909
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBzZWUuICBQZXJoYXBzIGFuIGVuaGFuY2VtZW50IHRoZW4/DQoNCkl0J3Mgbm90IGF0IGFsbCBp
bnR1aXRpdmUgdGhhdCBzaG93LXJlZiBpc24ndCBhYmxlIHRvIHNob3cgcmVmcywgc3ltYm9saWMg
b3Igbm90LiANCg0KVG8gY2xhcmlmeTogSSBkb24ndCBhdCBhbGwgZXhwZWN0IHNob3ctcmVmIHRv
IGNoYW5nZSB3aGF0IGl0IGRpc3BsYXlzIHRvIGJlIHRoZSAiaW50ZXJlc3RpbmcgYnJhbmNoIiBv
biB0aGUgcmVtb3RlLCBub3IgdG8gb3V0cHV0IHRoZSBicmFuY2ggdGhhdCBhIHN5bWJvbGljIHJl
ZiBwb2ludHMgYXQuIA0KDQpJIHdvdWxkIGV4cGVjdCBpdCB0byBzaG93IHRoZSBjb21taXQgU0hB
ICh1c2VmdWwpIGFuZCB0aGUgcmVmLW5hbWUgKG5vdCBzdXBlciB1c2VmdWwpLCBhcyBpdCBkb2Vz
IGZvciBvdGhlciByZWZzICh0aG91Z2ggcGVyaGFwcyB0aGUgZGVyZWZlcmVuY2Ugb3B0aW9uIGNv
dWxkIGJlIHJldXNlZCBoZXJlIHNvbWVob3cgdG8gZ2l2ZSBib3RoIG9wdGlvbnM/KS4NCg0KSW4g
YW55IGNhc2UsIG5vIHNlcmlvdXMgY29uY2VybiBzaW5jZSBgc3ltYm9saWMtcmVmYCB3b3Jrcywg
anVzdCBhIHdlaXJkIGluY29uc2lzdGVuY3kuIA0KDQpUaGUgZG9jdW1lbnRhdGlvbiBjb3VsZCBj
ZXJ0YWlubHkgYmUgaW1wcm92ZWQuICBJIHdvdWxkIGp1c3QgYWRkIGEgbGluZSAic2hvdy1yZWYg
ZG9lcyBub3QgaW5zcGVjdCBvciBmb2xsb3cgc3ltYm9saWMgcmVmZXJlbmNlcyBsaWtlIEhFQUQg
b3IgdGhvc2UgbWFkZSB3aXRoIHN5bWJvbGljLXJlZiIgdG8gdGhlIHN1bW1hcnkgYXQgdGhlIHRv
cC4gIFNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmc6DQogDQoiIiINCkRpc3BsYXlzIHJlZmVy
ZW5jZXMgYXZhaWxhYmxlIGluIGEgbG9jYWwgcmVwb3NpdG9yeSBhbG9uZyB3aXRoIHRoZSBhc3Nv
Y2lhdGVkIGNvbW1pdCBJRHMuIFJlc3VsdHMgY2FuIGJlIGZpbHRlcmVkIHVzaW5nIGEgcGF0dGVy
biBhbmQgdGFncyBjYW4gYmUgZGVyZWZlcmVuY2VkIGludG8gb2JqZWN0IElEcy4gQWRkaXRpb25h
bGx5LCBpdCBjYW4gYmUgdXNlZCB0byB0ZXN0IHdoZXRoZXIgYSBwYXJ0aWN1bGFyIHJlZiBleGlz
dHMuIA0KDQpCeSBkZWZhdWx0LCBzaG93cyB0aGUgdGFncywgaGVhZHMsIGFuZCByZW1vdGUgcmVm
cy4gIEl0IGRvZXMgbm90IGV2ZXIgaW5zcGVjdCBvciBmb2xsb3cgc3ltYm9saWMgcmVmZXJlbmNl
cyBsaWtlIEhFQUQgb3IgdGhvc2UgbWFkZSB3aXRoIGBnaXQgc3ltYm9saWMtcmVmIE5BTUUgUkVG
YC4NCg0KVGhlIC0tZXhjbHVkZS1leGlzdGluZyBmb3JtIGlzIGEgZmlsdGVyIHRoYXQgZG9lcyB0
aGUgaW52ZXJzZS4gSXQgcmVhZHMgcmVmcyBmcm9tIHN0ZGluLCBvbmUgcmVmIHBlciBsaW5lLCBh
bmQgc2hvd3MgdGhvc2UgdGhhdCBkb27igJl0IGV4aXN0IGluIHRoZSBsb2NhbCByZXBvc2l0b3J5
Lg0KDQpVc2Ugb2YgdGhpcyB1dGlsaXR5IGlzIGVuY291cmFnZWQgaW4gZmF2b3Igb2YgZGlyZWN0
bHkgYWNjZXNzaW5nIGZpbGVzIHVuZGVyIHRoZSAuZ2l0IGRpcmVjdG9yeS4NCiIiIg0KDQpUaGFu
a3MgZm9yIHRha2luZyBhIGxvb2shDQoNCkJlc3QsDQoNCkNhc2V5ICANCg0K77u/T24gMjAxOS0x
Mi0yMCwgNDoyMiBQTSwgIkp1bmlvIEMgSGFtYW5vIiA8Z2l0c3RlckBwb2JveC5jb20+IHdyb3Rl
Og0KDQogICAgQ2FzZXkgTWVpamVyIDxjbWVpamVyQHN0cm9uZ2VzdGZhbWlsaWVzLmNvbT4gd3Jp
dGVzOg0KICAgIA0KICAgID4gYGdpdCB2ZXJzaW9uIDIuMjEuMGANCiAgICA+ICANCiAgICA+IEV4
YW1wbGUNCiAgICA+IC0tLS0tLS0tLS0tLQ0KICAgID4gIA0KICAgID4gYGdpdCBzeW1ib2xpYy1y
ZWYgREVWIHJlZnMvaGVhZHMvZGV2YA0KICAgID4gYGdpdCBzeW1ib2xpYy1yZWYgREVWYA0KICAg
ID4gYD4+IHJlZnMvaGVhZHMvZGV2DQogICAgPiBgZ2l0IHNob3ctcmVmIERFVmANCiAgICA+IGA+
PiBbTk8gT1VUUFVUXWANCiAgICA+ICANCiAgICA+IEV4cGVjdGVkIG91dHB1dA0KICAgID4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQogICAgPiAgDQogICAgPiBgRlVMTF9DT01NSVRfSEFTSCByZWZz
L2hlYWRzL2RldmANCiAgICANCiAgICBXaGF0IG1hZGUgeW91IGV4cGVjdCBzdWNoIGFuIG91dHB1
dD8gIFRoYXQgbWF5IGJlIGNhdXNlZCBieSBhDQogICAgZG9jdW1lbnRhdGlvbiBidWcgb3IgdHdv
LCB3aGljaCBtYXkgd2VsbCBiZSB3b3J0aCBmaXhpbmcuDQogICAgDQogICAgVGhlIHNob3ctcmVm
IGNvbW1hbmQgbmV2ZXIgcmVzb2x2ZXMgYSBzeW1ib2xpYyByZWYgdG8gaXRzIHBvaW50ZWUsDQog
ICAgYW5kIGl0IG9ubHkgc2hvd3MgdGhpbmdzIHVuZGVyIHJlZnMvIGhpZXJhcmNoeS4NCiAgICAN
CiAgICBBbmQgREVWIGlzIG5vdCBzcGVjaWFsLg0KICAgIA0KICAgIAlnaXQgc2hvdy1yZWYgSEVB
RA0KICAgIA0KICAgIHdvdWxkIG5vdCBzaG93IEhFQUQgKGkuZS4gdGhlIGNvbW1pdCB0aGF0IGlz
IGF0IHRoZSB0aXAgb2YgdGhlDQogICAgY3VycmVudCBicmFuY2gpLCBhbmQgaXQgd291bGQgc2hv
dyByZWZzL3JlbW90ZXMvb3JpZ2luL0hFQUQgaW4gYQ0KICAgIHJlcG9zaXRvcnkgY2xvbmVkIGZy
b20gZWxzZXdoZXJlIGJ1dCBpdCBkb2VzIG5vdCBzYXkgd2hhdCBvdGhlciByZWYNCiAgICBpcyBw
b2ludGVkIGF0IChpbiBvdGhlciB3b3Jkcywgd2hhdCB0aGUgcmVtb3RlIHJlcG9zaXRvcnkgY29u
c2lkZXJlZA0KICAgIHRoZSBwcmltYXJpbHkgaW50ZXJlc3RpbmcgYnJhbmNoKS4NCiAgICANCiAg
ICBUaGFua3MuDQogICAgDQoNCg==
