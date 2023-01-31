Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A10C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 10:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjAaKwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 05:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjAaKwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 05:52:50 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E42B610
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 02:52:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE41PBGdpYL/e+gE7OhQtNZN6HhrswNP8n9QBCIZhBOZ0Hxy4hy0pCT0MmkfjMwM/1zkFt1ALB2K3wxjmoLP61ZvwQYjZzxQ5+z/BYhll7G3VL45euQ+Dlc/3hC15pvCimruj5Xr416vUNwullMPtcnryMDjk+z6CdclQZWOdZSpzYQFspN104V6FMTzgaVZQUq0/aDXPc9NwbErBNYa3uDIBBWDgePO6WAAtDHeatEEBtWYC1rbohnRa5uBAAorIUVDmDhrew13Ta98Nz+UBJAYISVbOtNvgyE5FCbkBSVjNmKOquSY5j8HDTFfYR8uWUQs/Jl/Y0OU1CunTmWZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0izF4xGiTfze7NBO94NEG8ArzXJDq0tWcL63ieM+1Dk=;
 b=bxdy16vBkPinmnS6l/Nvlw6JcmGwZPq9fljEoRROMnzms6hTxy68FBTpe+L9oi+rWxaWMa+e0HctiIVcBSTJkB3/jzmfaFRnLRJQIJR8dwpgAJ0FGCtxgGDoZuTHMGOKFkroIkx4JYtJJtcOvXGUX+dyaSU4a5fd37wTdbvQxXsx7sPwhY2oJV+ko1sLGbQTEYA6V8ut93VSIGQQ+5lTiKaBQLrPkWASdaG+KTOpj9na7FTIKYhe6zlDsS0rZARle8t4kz2S3CwB9lzLJ4EdTqlvwOBDd1gB8QXmUOu3FqOOYanhJtxvyp/dJpbTIBKIIhKsLyUN2iX8Kt/ZGvjJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izF4xGiTfze7NBO94NEG8ArzXJDq0tWcL63ieM+1Dk=;
 b=dYFIHAnD1X3Sqvm7ugdA8UXfo0+LhRC1xvurq4vHbO+zX9iuNxeXoORkPKDu1Y2XEnOQD6nyaVTIqK7HbShcr15gcyjHLZt7sQCLsRMzMGDBM0wRBhhQg+aOHTPLABnoJrYSQNXUyElVv4A59RUg22irwQ1lnfmZA/g6LDb/wILRWIAII1MjeDj0HqykF9aa7T7QPo46OZwa0WsjJvYYKbLIwrvO+OWIj4qnbmYJhBbPJWUWCKp2lT4OLGpo5KpbJ9HjPumjst5dGxDVNsyKsM/j6ToQjzIurDcuYgg4mYVo6SKiNMgtB9bMA7Vfb+OGLMxS+iQH7f9R92xS0QuGcw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS8PR10MB6652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:52:47 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf%8]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 10:52:47 +0000
From:   "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Thread-Topic: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Thread-Index: AQHZNWIngcTCFaniJkulFJ5t06rCgA==
Date:   Tue, 31 Jan 2023 10:52:47 +0000
Message-ID: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|AS8PR10MB6652:EE_
x-ms-office365-filtering-correlation-id: c49ae906-d156-48f3-9057-08db03794a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8ErpIe8wwZwcQbbZpniQfJFd8wTSfq7/TNvK7a1nf3xE2uZHf3AswYtQPeWKfPy/Lq8aYhVAa1xifgJwwmwtT72hAda0NUzLzhfOZ/fWwPaxJDqibGSPTcHwSL2bNCWZsxb9hop12YaUM+iuH8MrQpenua2A30hWCM/PVn1+TNcyKLCjhHEFfAlIzZ5/P8UPw4FeJ0RAq3DdZVeXNhbP/+myp5SVK1wGFjLeyOd0/BhgJkSuB9nHkx6HAMyYVEAAISbtM9B+VPhWa++DUHjPyNCheqqyEOB6Rzi9ThmqeZMwKSxB8Y+JoLYS1M1QHXQV4KEap9XPkNlK8DS0TqedgDiewzU7ZEmv5YrShApyVGVtcltCzWh8tjrAbQb/bFyaS4baqcM5g0Wts7ux5uJYsKpcJsdMCozfTpDYETt+R9EFjvwgejBl00m+sV+FpraoWQPauNY5g6NWmZgV9orJzEvf489rELJxLyFQtBNk0LcwVjtEF7HIklD2kWru9Ydp3OFk9dLL3sHIgx6gcFv7UuSdcYUxzWCVx4zEUzhMZUz2chCaPpo+1+rCwQGuJEgT6+Vovx86ZGxGlKgn7YUuTtVrdPJJO/zUOOwu8HWlB3OPUz18JnMGo5jub6zErXMMBTVpAUBLuV03olYpTclHGi0od3SyrRz5mblGQHynNgV5BWIlUl+vxKQ7MKAHP9/Pamb2AWYmpVYjJxdyNDVEUU9GbSDSteYOb9u2ohh5NY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(36756003)(82960400001)(2616005)(6506007)(186003)(6486002)(38070700005)(966005)(122000001)(86362001)(478600001)(2906002)(71200400001)(5660300002)(38100700002)(54906003)(6512007)(316002)(4326008)(66476007)(64756008)(66556008)(6916009)(76116006)(66946007)(66446008)(91956017)(83380400001)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFR4NTBlUVpsenR2S0dMZjZybXFZdFRnUjRIR1FXVUVIaTFoQXhmeGRGUEsz?=
 =?utf-8?B?bU80bHN3clU5SHRzQUFrSjhxY1FFTjhsblp2ZmZqSXNOcXZCR0R6bllzYm1s?=
 =?utf-8?B?VkY5NGgvN0dYODVaRlRRSFRBdVhFbmwvNGlxdTNoWlZKamVlRXpoQ0Q0bEQr?=
 =?utf-8?B?SVo3bUtvYUNVUStFQmxXZ2kxWUljK2FUVXhEOUJQLzg2OS9tcHI3SmRUUEVy?=
 =?utf-8?B?dHMxeENWSVBZbTRYUlZJTEhVWVRZejFFTVlQUGNPUmxlRVJScVNNT1V3OEZY?=
 =?utf-8?B?TmN6blp3VUxxUTN1dzVGOUwwU3Vad2ROYkx4dGVOV3lZRU5sYmt2cGg5Ukxo?=
 =?utf-8?B?cnJ0SS9MM2RpYlVSTGhHaU5Ob2tBUWt0bW9UdFJDTzdubjVvNHdNeEdqRkI4?=
 =?utf-8?B?eE42WG1OM29nK3hTa1VjMVhNQll3VjgrVXZjOVVqaGU0b2o1OXdkTFd2WjZz?=
 =?utf-8?B?Vi9Ud1pXOHpnM2hOOTBUbUdXRm93OHpkdUc5Tjl4TnA4MS9hSklhZDBGNHpz?=
 =?utf-8?B?OE5LeXpOT0Q0SGNUeHNlRGxGUzFxSit2emNaR0hUVFloS1dRSEg5MXI1U2h4?=
 =?utf-8?B?ZVFpWjdIOUpYaHh1TWE2cElBWXBUejk5OU51NE1ENXlYTVVUZWErcHBuWWRn?=
 =?utf-8?B?eGtwTmxudi9mUnNOYi9FNWZybXRPd0hpdVpza3pNVDNKMzZ3S2RSSCtSTmVi?=
 =?utf-8?B?OVgrV1lKSXI1RVMyZlNiaVJoQXlmMFk5cHFuTnpsWklvR29ub0tMbnVnUGx6?=
 =?utf-8?B?UVhCMGdrYjlvdFp3M2hOZW5Pb0tXb1RsZTdqWW1mb29iRS95YUJ0SUZMNXVS?=
 =?utf-8?B?NHIxYjduM1RaQlRHZTZOUVV1T2FsR0t5Nk51c1ZFL09MN2pOMUdzNHhBOGM5?=
 =?utf-8?B?N05hYmJ0am03RmhoU0Q4MHU0MGlWSGVLY201SGNoYWZLTjdZbm84NHpEbzQy?=
 =?utf-8?B?bzNMN3RRWlNRL1NsTzhWT1RjWXpCOVlLTWc4TFVrK0loYmVDeVNFU2tLMkxN?=
 =?utf-8?B?TmQyY0JVbE9heGZPQVVqZVVheWY3WkU4UmFtZ1Mycnp4dmYyMFIxQmNQR2lZ?=
 =?utf-8?B?SGsrVG44cHNmRXBsR0habFNxaEJBNDliWGIzN2ppZGhmTVA5d2pwemplRXYz?=
 =?utf-8?B?ZTEyWFU1UVRCN2RjSXNGWGQ5cnVneGg3U2ZoNkRRYjM4Y2NOemVIemRxQ0dx?=
 =?utf-8?B?RU1lZHFtUU50cURuQVZjTFlTbkNxdTRLeTliZkZ3RGc5OGsvNDRvVzJyUHNx?=
 =?utf-8?B?eW8yeGM5SU4rYTBnNkdSRXhPTlp1aEZ0c1NqMWV1ejVSOVdBdVlDdFc1bmVO?=
 =?utf-8?B?VjJqNStEbnppSXY1WWNhUWVEbHNEOVpxUWhpTWZwZU5iWnhidXhhaUxLTkpE?=
 =?utf-8?B?anNXbjJaRUhLdlRHZGRVTTBZb0dZbFZLN3lPdTVrVFo5WGJ2a3JPNUVlcGoy?=
 =?utf-8?B?SEJDaGw3Mjh4WlU2bTZEd1BjaXplZjYvRUpuamZ0Z05oQjF5eHVYaVZIRkl6?=
 =?utf-8?B?NUxpdEo2MFRPMW02V3F6QVhjSmdFMXROTlNMZTluVSsyVHFLcUZiblBycmhQ?=
 =?utf-8?B?TXVDV01TYXVGYlNYTHNJRXNRamNQQ2w3b3ZYa1NlbXhhWlF3ZVVhOW9Xd01W?=
 =?utf-8?B?Mm9SU0NhZUthRitOWnc0c2dNTy9jNWtkK0xQTWJUT3pTS1IzZ2xPeG1HcU0w?=
 =?utf-8?B?cGlLWCsrSTF3TlZIZWdENWM3UkF2N3grN3VBVjJwRkNNSEhLS3dxdjZWSG8x?=
 =?utf-8?B?Q1NxVWlieDg0VHVxSHA5MXNXOUt2bWdBODRhVXB0L3RRd2tLU2ZHcGJJT0lM?=
 =?utf-8?B?MHJrajdOZGlYVFhYT1RlRU1XS1ljeDdKbmx5R0ZkaFZqMFNTdUdZZ3dqNFF6?=
 =?utf-8?B?MWo0NkQ2eXR6d0lEVVE0OHJNaUJaa3A5S1NYQVV2WCtPWENxbmRHUE9USEJS?=
 =?utf-8?B?aklrWlZnK1Q1elRQcVZWOEpIbGo4TjdzM0x0R3plaFN0eThEQlNSUXJ4clJX?=
 =?utf-8?B?bk9EOTREWXovdXp0T3cvVHFxc1J0eElKWW5kSzduZUFWdXhWdUIrRVZQQ0M3?=
 =?utf-8?B?M1hLVXBsTktVRHRkdWpHcWZQbHp4c3hYOTlxcGV1RkE0TDAxTVRoZnNJRXgv?=
 =?utf-8?B?UjBEaUFOM0RIOXdheDRFQzJmRU5la2lmaVhHZXRIeFA4YVRveFJWTFEyOFk1?=
 =?utf-8?B?Z0RQY2d1eE1tUFdxR084am1EemNCcW9nL3hKeTRXTTBNZ2pTczJLc0RDTnpE?=
 =?utf-8?B?N1hkTHRUSytiVnhablBCUlRhNFp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <158BCC44A897FA4F9EA5A4C0921BCD06@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c49ae906-d156-48f3-9057-08db03794a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 10:52:47.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUGyKZEqqu5PyKjDvR09K2TPo+oOk8DG/OWy0UcLzd9rThbVUlAsFIS0BnqaU/rP3N+n+jwPQPHNSk5JLftQf8f9GQoIRJlr8VukFI8I8sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6652
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgYWxsLA0KDQpJIGp1c3QgdXBkYXRlZCBmcm9tIGdpdCAyLjMwLjIgKGZyb20gRGViaWFuIDEx
KSB0byAyLjM5LjAgKGZyb20gRGViaWFuDQp0ZXN0aW5nKSBhbmQgcmVhbGl6ZWQgdGhhdCBJIGNh
biBubyBsb25nZXIgY2xvbmUgcmVwb3NpdG9yaWVzIHVzaW5nIHRoZQ0KZ2l0Oi8vIHByb3RvY29s
Lg0KDQpUaGVyZSBpcyBvbmUgc3BlY2lhbHR5IGluIG15IHNldHVwOiBJJ20gbG9jYXRlZCBiZWhp
bmQgYSBwcm94eSwgc28NCkdJVF9QUk9YWV9DT01NQU5EIGlzIHNldC4gSSdtIHVzaXVuZyB0aGUg
b2UtZ2l0LXByb3h5IHNjcmlwdCBbMV0gaGVyZS4NCk15IGVudmlyb25tZW50IHByb3ZpZGVzIHRo
ZSBodHRwX3Byb3h5IHZhcmlhYmxlIGFuZCBwcml2b3h5IFsyXSBpcw0KcnVubmluZyBvbiB0aGUg
c2VydmVyIHNpZGUuIFRoYXQgaW5mb3JtYXRpb24gc2hvdWxkIGJlIHN1ZmZpY2llbnQgdG8NCnJl
cHJvZHVjZS4NCg0KSSB0cmllZCB0aGUgZm9sbG93aW5nIHR3byByZXBvc2l0b3JpZXMgZm9yIHRl
c3Rpbmc6DQogLSBnaXQgY2xvbmUgZ2l0Oi8vZ2l0LmNvZGUuc2YubmV0L3AvbGludXhwdHAvY29k
ZSBsaW51eHB0cA0KIC0gZ2l0IGNsb25lIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0DQoNClRoZSByZXN1bHQgaXM6DQpDbG9uaW5n
IGludG8gJ2xpbnV4cHRwJy4uLg0KZmV0Y2gtcGFjazogdW5leHBlY3RlZCBkaXNjb25uZWN0IHdo
aWxlIHJlYWRpbmcgc2lkZWJhbmQgcGFja2V0DQpmYXRhbDogZWFybHkgRU9GDQpmYXRhbDogZmV0
Y2gtcGFjazogaW52YWxpZCBpbmRleC1wYWNrIG91dHB1dA0KDQpJIHdhcyBhYmxlIHRvICJnaXQg
YmlzZWN0IiBpdCB0byB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCmFlMWE3ZWVmZmZlNiAoImZldGNo
LXBhY2s6IHNpZ25hbCB2MiBzZXJ2ZXIgdGhhdCB3ZSBhcmUgZG9uZSBtYWtpbmcgcmVxdWVzdHMi
KQ0KDQpSZXZlcnRpbmcgdGhpcyBjb21taXQgb24gdG9wIG9mIHRoZSBtYXN0ZXIgYnJhbmNoIGZp
eGVzIG15IGlzc3VlLg0KQWxsIHBlb3BsZSBpbnZvbHZlZCBpbiB0aGlzIGNvbW1pdCBzaG91bGQg
YmUgaW4gQ0MuDQoNCkxvb2tpbmcgYXQgdGhlIFRDUCBieXRlIHN0cmVhbSBzaG93cyB0aGF0IHRo
ZSBzb2NrZXQgaXMgY2xvc2VkIGFmdGVyDQp0aGUgY2xpZW50IHJlY2VpdmVkIHRoZSBmaXJzdCAi
cGFydCIgb2YgdGhlIHBhY2tmaWxlLg0KDQouLi4NCjAwMzJ3YW50IGVjM2YyOGEwYWMxM2RmODA1
Mjc4MTY0ZjJjNzJlNjk2NzZkMTMxMzQNCjAwMzJ3YW50IDU3Y2FmNWQ5NDg3NmU4MzI5YmU2NWQy
ZGMyOWQzYzUyOGIxNDk3MjQNCjAwMDlkb25lDQowMDAwMDAwZHBhY2tmaWxlDQoNCkxldCBtZSBr
bm93IGlmIHlvdSBuZWVkIGZ1cnRoZXIgaW5mb3JtYXRpb24uIEhvcGVmdWxseSB0aGlzIHdhcyB0
aGUNCmNvcnJlY3Qgd2F5IG9mIHN1Ym1pdHRpbmcgYSBidWcgdG8gZ2l0Li4uDQoNCkJlc3QgcmVn
YXJkcywNCkZsb3JpYW4NCg0KWzFdIGh0dHBzOi8vd2lraS55b2N0b3Byb2plY3Qub3JnL3dpa2kv
V29ya2luZ19CZWhpbmRfYV9OZXR3b3JrX1Byb3h5DQpbMl0gaHR0cHM6Ly93d3cucHJpdm94eS5v
cmcvDQoNCg0K
