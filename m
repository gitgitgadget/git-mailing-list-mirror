Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1819C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB92C2070B
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 18:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=strongestfamiliesinternal.onmicrosoft.com header.i=@strongestfamiliesinternal.onmicrosoft.com header.b="DDEQ87WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgGXSOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:14:07 -0400
Received: from mail-eopbgr660128.outbound.protection.outlook.com ([40.107.66.128]:45475
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbgGXSOG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 14:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWH6Aa7PJTRt2taGlvxdLy99DyXxMGgZsIJF7YK+i4jhAnhvydABfgJIufSo/ISGOgtelIQjd55waFMf9GT0eAGfHT3p8+uu9FUE6NJEHRtnlb1AqBT1rSzRIewHugMNR/tha5hVofJvYJfP3LKL3XgqVfPIPn0FdXwqN/jvrjiCzQm1rhTi6oyTRjR0iMUG8OAYzr6HMvRhPqB+At8g2QMYYfaMeR5m9tHElELzgu0x/+u0l18WNpXZCW5qaza1KDUM4TbHkciCNgUfKCA+R3pf7Kvyxj47Cr1tzG4NkswJHXAm8y3VyKLzJQYDc8c99X8NoqOmUBYVabKd4agieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OlNBgzSu3wiH/ksuISZQx9q/tw5uV7UdbbHKvwaN0o=;
 b=JWboWEOC2lcTX6nW1Oi40SiEJw7diiWN8GwwdaD+F25+DzkKUHY7EYo0gxK4ddPabGgTcE/m7X2JjKQoyuaR+yODcor9uyS/tyzLZnzTaPKFKFDmC7X2QmBDyzBp8ARmwEMuMJO+7su6HnUV8VckfDvq1nCAFR3D+mM6tx5MWnJgB17qCWcN4+hq3UimZeEX0VIpSHpLjmTtsWS40SRKEDYsaREZo20vQRbNrMafgU3zXe3az+wWsjUwNDzGNpqUPyafgp2Zd9wvL2n71np6XxaJ0WwuO1L0UKz5RYuw1r9jKEXc7/mnybvsyiRpe6cPM47FpWQDe7Dy0IqQUuF2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=strongestfamilies.com; dmarc=pass action=none
 header.from=strongestfamilies.com; dkim=pass header.d=strongestfamilies.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=strongestfamiliesinternal.onmicrosoft.com;
 s=selector2-strongestfamiliesinternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OlNBgzSu3wiH/ksuISZQx9q/tw5uV7UdbbHKvwaN0o=;
 b=DDEQ87WXDf1fDwRgxuxipMbMOoO4YgG5dVQFHrvCKO2NwWloFSRoHbj38gA7PRa032aLfw06tyR0wgJvqIrypKRfhQC1dsZ+Dj3/912gbIG2iTIbYZk9IM3j3yhsdr6OX2yk0iEgkbiwqityhtFHDbSMStK5luvJWCy/Q/Xg+ys=
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::31)
 by QB1PR01MB2996.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 18:14:03 +0000
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e]) by QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 18:14:03 +0000
From:   Casey Meijer <cmeijer@strongestfamilies.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Topic: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Index: AQHWYQRMte1QWK0kaEKnR3jjpovCbKkVFV4AgADZnwCAAOjRgA==
Date:   Fri, 24 Jul 2020 18:14:03 +0000
Message-ID: <EE35569F-6029-4659-86B3-29FBAAD7C491@strongestfamilies.com>
References: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
 <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
 <20200724011944.GD1758454@crustytoothpaste.net>
In-Reply-To: <20200724011944.GD1758454@crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=strongestfamilies.com;
x-originating-ip: [216.208.243.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdff5c90-fb6e-4306-5d10-08d82ffd58bc
x-ms-traffictypediagnostic: QB1PR01MB2996:
x-microsoft-antispam-prvs: <QB1PR01MB2996C6573E6B433F88E862EDAB770@QB1PR01MB2996.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FEtjnStvHXExc+9inZOU10CUSMD6syiqM47z3AeCWtmQM4NpA0TaWI/yYTtedMIxtcMUk486Pp030SXxMPznhugLp4GNJqA3K9dqosGHVvewcvKKmp16Du9d4KxTupgZawhfasqr0PCmPTO88aghnFapN/su43WNOmkPsbI1OiQfVHdlOTNJs7+oJbrtjUbsPI/mYaAbKwRQ02iHdM6UBLYhM9qruMyQxRLQxNuEcIZ0HQFSsuj/2kXd5PrAmsnMcN8UlAPtMFXtNUdX2LUjKA1MxmQFkOgYT+yRUWkZzbtubDAwlORMANGRaVdaWBWV5M0/YgA9TMHEqjzQwLey6WSk0Opx1VV/erGc6xROvkExHn0YP5H7ColzPV3L8Fg3hzngrFfA5J+TsSF6Lv4gNCRmT9LZmWoE6swtsXT+TYVx5gsETzifKq8EOL7k1ht31NIl/5jwV+VasYSUkYjiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(39830400003)(396003)(8936002)(66946007)(64756008)(36756003)(5660300002)(8676002)(66556008)(66476007)(76116006)(33656002)(2906002)(66446008)(53546011)(6916009)(186003)(6506007)(316002)(4326008)(508600001)(26005)(966005)(71200400001)(86362001)(6486002)(6512007)(2616005)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HwAxjCJKLwj+GPn5WdVTvmhH9LvBW6phfLhxvWQN0Q8cPQPVQaC20esr6SRMbXpilkmkArOSoB/pYxYv55VD07Ed2V92dx390tkfOQiHzIKB4/VsIcUmdgiVNGlYsQW3MCD+FsAKOIB8ss5j5C/PJ90d6dBrx5Zl9oC5MBJfW6zyt4kBX9Y5aQyc9W2e8atkopNg2lpxcSy9cCvvQD/QrENcLOOoo0PyTqOqZTYhIFy/lf/ZejzVIEr/Qt1ZXNg3M/PW3mSv6K+/ndps23gSMzq4B9I5xRCrmBEPAS+GGQkxRK1jfi5Il92PkjHOHyiKYIBnM1WK+TQL2D0zqWhtLQmpezuxQ41YPz6A4o85WdsFwGpw2Vg+Ip2fsRcgQkbPR2ZjMde05xKLA2zg7ozlEp4bmSlQpDQkEX/R6O6EqUdx/GD9Z2MQgM6c3bZL1SVjuAxhP94VokdW/DAyQDUN3z5Ej9PkXYXRlZVOVKdp2nKJCrLmoTMDLYEr+Q0RBiOu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <339BFFA37495BE4781D88B21854A47DB@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: strongestfamilies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bdff5c90-fb6e-4306-5d10-08d82ffd58bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 18:14:03.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88c0a794-6b77-42fa-a51d-2e160c167dfa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9RVr8KX+IiX7ji0LC07+OyIJMojALeVMb5VxkagO+Xem0xeiK1v6Rgv0J6/RnGlhIviO0ucq/d722wdDVpSHPL2Zc0m8ktWD6/TeVliCD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB2996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSB0aGluayBJIG1pc3VuZGVyc3Rvb2QgeW91ciBjbGFpbSBhY3R1YWxseSBCcmlhbi4gICBXaGF0
IGlzIGEgYnVnIGlzIGFza2luZyBmb3Igd29ya3RyZWUgQSdzIGhlYWQgYW5kIGdldHRpbmcgdGhl
IG1haW4gd29ya3RyZWUncyBoZWFkLiBBIHN1cGVyIGRhbmdlcm91cyBidWcuIA0KDQpJIGNlcnRh
aW5seSBkaXNhZ3JlZSB3aXRoIHlvdXIgYXNzZXJ0aW9uIHRoYXQgYXNraW5nIGZvciBoZWFkIGFu
ZCBub3QgZ2V0dGluZyBIRUFEIChvciBIZWFEIG9yIGhFQWQpIG9uIGEgY2FzZS1pbnNlbnNpdGl2
ZSBzdG9yYWdlIGVuZ2luZSBpc24ndCBhIGJ1ZyBhbmQgaXQgY2VydGFpbmx5IA0Kc2hvdWxkbid0
IGJlIGEgYnVnIG9uY2UgZXh0ZW5zaWJsZSBzdG9yYWdlIGVuZ2luZXMgYXJlIGluIHBsYWNlOiB0
aGUgc3RvcmFnZSBlbmdpbmUgc2hvdWxkIGhhdmUgZmluYWwgc2F5IG9uIGhvdyBvYmplY3RzIGFy
ZSBzdG9yZWQgYW5kIHJldHJpZXZlZCwgbm90IGdpdC1jb3JlLiANCg0KQmVzdCwNCg0KQ2FzZXkN
Cg0K77u/T24gMjAyMC0wNy0yMywgMTA6MTkgUE0sICJicmlhbiBtLiBjYXJsc29uIiA8c2FuZGFs
c0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3JvdGU6DQoNCiAgICBPbiAyMDIwLTA3LTIzIGF0IDE1
OjIwOjUwLCBDYXNleSBNZWlqZXIgd3JvdGU6DQogICAgPiBUaGlzIGp1c3QgYml0IG1lOyBpdCBz
ZWVtcyBxdWl0ZSBvbGQsIGFuZCBJIHdhbnRlZCB0byBwcm9wb3NlIGFuIGFsdGVybmF0aXZlIHNv
bHV0aW9uIChtYXliZSBpdCBkb2VzbuKAmXQgd29yayBmb3Igc29tZSByZWFzb24gSeKAmW0gdW5h
d2FyZSBvZik6DQogICAgPiBodHRwczovL21hcmMuaW5mby8/bD1naXQmbT0xNTQ0NzM1MjU0MDE2
Nzcmdz0yDQogICAgPiAgDQogICAgPiBXaHkgbm90IGp1c3QgcHJlc2VydmUgdGhlIGV4aXN0aW5n
IHNlbWFudGljcyBvZiB0aGUgbWFpbiB3b3JrdHJlZSBieSBjaGVja2luZyB0aGUgd29ya3RyZWUg
cmVmcyBmaXJzdCB1bmNvbmRpdGlvbmFsbHkgYW5kIG9ubHkgZmFsbCBiYWNrIHRvIHRoZSBtYWlu
IHJlZnMgd2hlbiB0aGUgcmVmIGRvZXNu4oCZdCBleGlzdCBsb2NhbGx5IGluIHRoZSB3b3JrdHJl
ZT8NCiAgICA+ICANCiAgICA+IFRoaXMgd291bGQgaGF2ZSB0aGUgYWRkZWQgYmVuZWZpdCBvZiBh
bGxvd2luZyBwb3dlciB1c2VycyB0byBvdmVycmlkZSByZWZzIGluIHRoZWlyIHdvcmt0cmVlcyBh
bmQgd291bGQsIGlmIEnigJltIG5vdCBtaXN0YWtlbiwgcHJlc2VydmUgdGhlIHNlbWFudGljcyBv
ZiB0aGUgbWFpbiB3b3JrdHJlZSBpbiBjYXNlLWluc2Vuc2l0aXZlIGFuZCBjYXNlLXNlbnNpdGl2
ZSBmaWxlc3lzdGVtcy4NCg0KICAgIEl0IGlzbid0IGNsZWFyIHRvIG1lIGV4YWN0bHkgd2hhdCB5
b3UncmUgc3VnZ2VzdGluZy4gIEFyZSB5b3Ugc3VnZ2VzdGluZw0KICAgIHRoYXQgd2UgYWxsb3cg
ImhlYWQiIGluc3RlYWQgb2YgIkhFQUQiIGluIHdvcmt0cmVlcywgb3IgdGhhdCB3ZSBhbGxvdw0K
ICAgIHJlZnMgaW4gZ2VuZXJhbCB0byBiZSBjYXNlIGluc2Vuc2l0aXZlLCBvciBzb21ldGhpbmcg
ZWxzZT8NCg0KICAgID4gQW55d2hvLCBqdXN0IGEgdGhvdWdodC4gIEkgY291bGQgd29yayBvbiBh
IHBhdGNoIGlmIHRoaXMgYXBwcm9hY2ggbWFrZXMgc2Vuc2UgYXQgbGVhc3QgYXMgYW4gaW50ZXJt
ZWRpYXJ5IHVudGlsIHRoZXJl4oCZcyBhIHBsdWdnYWJsZSBzdG9yYWdlIGJhY2tlbmQgZm9yIG5v
bi1GUyBzdG9yZXMg8J+YiSAgIChJJ2QgYWxzbyBiZSBzb21ld2hhdCBpbnRlcmVzdGVkIGluIGlt
cGxlbWVudGluZyBhIHBvc3RncmVzL3NxbCBzdG9yYWdlIGJhY2tlbmQgaWYgdGhpcyBwcm9qZWN0
IGlzIG1vdmluZyBmb3J3YXJkcyBfXyApLg0KDQogICAgVGhlcmUgaXMgYSBwcm9wb3NhbCBmb3Ig
YSByZWYgc3RvcmFnZSBiYWNrZW5kIGNhbGxlZCAicmVmdGFibGUiIHdoaWNoDQogICAgd2lsbCBu
b3Qgc3RvcmUgdGhlIHJlZiBuYW1lcyBpbiB0aGUgZmlsZSBzeXN0ZW0sIGFuZCB3b3JrIGlzIGJl
aW5nIGRvbmUNCiAgICBvbiBpdC4gIFRoZXJlIGhhcyBiZWVuIGEgc3VnZ2VzdGlvbiBmb3IgYW4g
U1FMaXRlIHN0b3JlIGluIHRoZSBwYXN0LCBidXQNCiAgICB0aGF0IGNhdXNlcyBwcm9ibGVtcyBm
b3IgY2VydGFpbiBpbXBsZW1lbnRhdGlvbnMsIHN1Y2ggYXMgSkdpdCwgd2hpY2ggZG8NCiAgICBu
b3Qgd2FudCB0byBoYXZlIEMgYmluZGluZ3MuDQogICAgLS0gDQogICAgYnJpYW4gbS4gY2FybHNv
bjogSG91c3RvbiwgVGV4YXMsIFVTDQoNCg==
