Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8740C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 18:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A226F206D8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 18:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=strongestfamiliesinternal.onmicrosoft.com header.i=@strongestfamiliesinternal.onmicrosoft.com header.b="V9S3TB2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXSRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:17:15 -0400
Received: from mail-eopbgr670127.outbound.protection.outlook.com ([40.107.67.127]:58776
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgGXSRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 14:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKNkYJSdC53CegnCzmDN41bfO6wpkfeZ6EumJbm6oY+3yNOrrfnovntN0zBGG9UlBiCiWUV62pE0BPkfLIsBUJVCo5QYnAEAHtxsB1elJ091Cl+/A/MT87T8H4QELGTt6//xMUpzCQx4kgtUeJ8wGr3ura7pEjLKnrScaSp9HZXRt2iODKgVhFaPXU82wuxJpi776rh2m5kvjl2XccaMKVJF0tFz2j+3RAWhvgu7t14GYXPk8AYaeYRomS7JiegtMMmJ9fnnbxpQheXjq9pKhhsNvV6agvZlKVuL/RgJfEHN2BFqWpvgZBdmwHAJvcHuKUKS0sSH0flbFfeFgMLdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tOnRmMNuqMLzNEkc6YgZ6DWLn07b+ObR7Dwpn1tDdo=;
 b=eO1e/6k+4hu/ga8XLJLofd95WkMkfCgfuXtDbBh8ISlR3zOxfi+cUbiJelnWyNzYuSPq47T5LS9dWJryoKkEIOOnHsJt1jz9v8YRbivD6tZYuluASvnWhsQOQKhMm66P++xe36m/pnODAnRBmJoo9IHFoEqqvTFORgKXGKOisX84Md7zOdThKo55BB+5C5ytwpiLuy+88qHUkGoaGyoUaIGFUBvgm45/2U5V1iPJbQtarddsPUQbuLI/bhdtL96RfsUHFrs3X37cbKyKsMpZNo+6/ddzLMrg5ZWNsKlXJDA26isGfQBdrucn5GkPjRx9DVajJv96cZuxMOWsYODAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=strongestfamilies.com; dmarc=pass action=none
 header.from=strongestfamilies.com; dkim=pass header.d=strongestfamilies.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=strongestfamiliesinternal.onmicrosoft.com;
 s=selector2-strongestfamiliesinternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tOnRmMNuqMLzNEkc6YgZ6DWLn07b+ObR7Dwpn1tDdo=;
 b=V9S3TB2+XPlr2rhlxpUk01ojwrI4AHNspTjFttTYkagj+Afwpk7uJ5Dx1rqLHb9ByOyL+z5JW37w4mVkXiJ4J/93L4Ky+j3Bw9y3RCBA+ypIRZF+fO77vkA79DiGwwYRG2aNdrTxo+5WFl0hOQ2/YF+l7mol9F19AdJOIXLhUKE=
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::31)
 by YQXPR0101MB0840.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 18:17:12 +0000
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e]) by QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 18:17:12 +0000
From:   Casey Meijer <cmeijer@strongestfamilies.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Topic: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Index: AQHWYQRMte1QWK0kaEKnR3jjpovCbKkVFV4AgADZnwCAAAG7ooAA6EIA
Date:   Fri, 24 Jul 2020 18:17:12 +0000
Message-ID: <02819EF1-CCA7-4A0F-9497-F6A52E6CBF30@strongestfamilies.com>
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
x-ms-office365-filtering-correlation-id: 3abe88bf-50a6-4390-84a7-08d82ffdc98f
x-ms-traffictypediagnostic: YQXPR0101MB0840:
x-microsoft-antispam-prvs: <YQXPR0101MB084084526DF9D483E6EF0CCBAB770@YQXPR0101MB0840.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WQ1+C54NuJBSS4ovvy0cQsNGk3XpVokwkM8ZsrsLm7y5dsQliiv0XJoF+0D3EMIS3uHZtLXAU7TmMrKsxPEO7d7444w3jnYwMu/G3CseqSVnnQvD2oGOgMvIbtyreZACxbqxSDrt7zXax371hRCpi3ALdUrqRhuooEV9U9o5BSKBlq01lnMJleJ4/rXI7oaxbDNRWOhl+FztUTBWkGpHX+e9fIPac6ifO0ALvp2IJI65Sh+8JvQP+I2ZW6kosOn093eqMe63XZM3f69VmXR9n+C3cyqG+QN8zsxNHjXQIDSbRYKT2cXCFWw6upHybGmKo8lEB17o41jWcLutwl4yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39830400003)(366004)(396003)(6506007)(6486002)(8936002)(110136005)(4326008)(8676002)(71200400001)(5660300002)(6512007)(316002)(33656002)(2616005)(83380400001)(66446008)(86362001)(186003)(66946007)(64756008)(26005)(508600001)(66476007)(2906002)(66556008)(36756003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OD8D44YKMH8SMiVz1LCtc/FUnp5E1mBZC7IDGH5dyaXKeqgxHpHbEUjzv4WUeFQN6o8vbdZiPzBc5wveR1llEzjAy2+DE7calr3Hecf4c0QA6R986B4OkARdn/X9PIdDtiBAtI4qWEaY+0DPYFlzXfq9buLVV1RBvpldauPt7E7tjBJA7T3ZZsGNsgkSp1UNn6Jb8rdbtTiTN0bUf5wN7qCobXWjyiUgsGGuWLIY0Y7yXdqXrUSEC2moAzuRwh0IXWeL94TNvA6t1us6atK0qZ8LFEaAOqDf0/PlnrdpM7MN2a0PNVq+gbmxYhY9GX0vnDgRnz4n3Rxg3UU6AUHmDwUkL77DRAwrGYWdTT0ioIFuQrFSWTtb49FEf3nT+KYF5/bWZ9wd0Y4IOL3NBxa1opjmYvA1YldUeczb3cJzcm2Cg0ipKmXRHEmmYBevJNTs6MoTjg7aPBRCmwQbgZfEXgZRckp+pm1JOsiZo2niwxaddBktQflWWoAZELbuUZfm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE64FF375F26DE4585687570E76E6E02@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: strongestfamilies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abe88bf-50a6-4390-84a7-08d82ffdc98f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 18:17:12.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88c0a794-6b77-42fa-a51d-2e160c167dfa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnO9Yyf6wCcc1HsIDuaLS4tNw9iDQQ7uu4YyNnI3b9a/VolRlC3BpbHShdgEjbXSD0G3h5VzoGFpWACvLW3b+mi2S5+x1PCJLMb7LuH/NS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB0840
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U29ycnkgSSBnb3QgbWl4ZWQgdXAsLCB0aGF0IGxhc3QgbWVzc2FnZSBzaG91bGQgaGF2ZSBiZWVu
IGFkZHJlc3NlZCB0byBKdW5pby4gDQoNCk15IGFwb2xvZ2llcy4gDQoNClRvIHB1dCBpdCB2ZXJ5
IHNpbXBseSwgSSdtIGFza2luZyB0aGF0IGdpdCByZXNwZWN0IHRoZSBzZXBhcmF0aW9uIG9mIGNv
bmNlcm5zIGJldHdlZW4gaXRzZWxmIA0KYW5kICBpdHMgc3RvcmFnZSBlbmdpbmUgKHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciB0aGF0J3MgcGx1Z2dhYmxlLCBvciBqdXN0IHRoZSBjdXJyZW50IGZpbGVz
eXN0ZW0sIHdoaWNoIEkgZ3Vlc3MgaXMgdGVjaG5pY2FsbHkgcGx1Z2dhYmxlLCBsb2wpLg0KDQoN
CkJlc3QsDQoNCkNhc2V5DQoNCu+7v09uIDIwMjAtMDctMjMsIDEwOjI1IFBNLCAiSnVuaW8gQyBI
YW1hbm8iIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQoNCiAgICAiYnJpYW4gbS4gY2FybHNv
biIgPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyaXRlczoNCg0KICAgID4gSXQgaXNu
J3QgY2xlYXIgdG8gbWUgZXhhY3RseSB3aGF0IHlvdSdyZSBzdWdnZXN0aW5nLiAgQXJlIHlvdSBz
dWdnZXN0aW5nDQogICAgPiB0aGF0IHdlIGFsbG93ICJoZWFkIiBpbnN0ZWFkIG9mICJIRUFEIiBp
biB3b3JrdHJlZXMsIG9yIHRoYXQgd2UgYWxsb3cNCiAgICA+IHJlZnMgaW4gZ2VuZXJhbCB0byBi
ZSBjYXNlIGluc2Vuc2l0aXZlLCBvciBzb21ldGhpbmcgZWxzZT8NCg0KICAgID4gVGhlcmUgaXMg
YSBwcm9wb3NhbCBmb3IgYSByZWYgc3RvcmFnZSBiYWNrZW5kIGNhbGxlZCAicmVmdGFibGUiIHdo
aWNoDQogICAgPiB3aWxsIG5vdCBzdG9yZSB0aGUgcmVmIG5hbWVzIGluIHRoZSBmaWxlIHN5c3Rl
bSwgYW5kIHdvcmsgaXMgYmVpbmcgZG9uZQ0KICAgID4gb24gaXQuICBUaGVyZSBoYXMgYmVlbiBh
IHN1Z2dlc3Rpb24gZm9yIGFuIFNRTGl0ZSBzdG9yZSBpbiB0aGUgcGFzdCwgYnV0DQogICAgPiB0
aGF0IGNhdXNlcyBwcm9ibGVtcyBmb3IgY2VydGFpbiBpbXBsZW1lbnRhdGlvbnMsIHN1Y2ggYXMg
SkdpdCwgd2hpY2ggZG8NCiAgICA+IG5vdCB3YW50IHRvIGhhdmUgQyBiaW5kaW5ncy4NCg0KICAg
IFllcywgYW5vdGhlciBpbXBvcnRhbnQgdGhpbmcgdG8gcG9pbnQgb3V0IGlzIHRoYXQgb25lIHNo
YXJlZCBnb2FsIG9mDQogICAgdGhlc2UgZWZmb3J0cyBpcyBzbyB0aGF0IHVzZXJzLCBldmVuIHRo
b3NlIG9uIGNhc2UgaW5zZW5zaXRpdmUNCiAgICBmaWxlc3lzdGVtcywgY2FuIG5hbWUgdGhlaXIg
cmVmcyBmb28gYW5kIEZPTyBhbmQgaGF2ZSB0aGUgc3lzdGVtDQogICAgdHJlYXQgdGhlc2UgYXMg
dHdvIGRpc3RpbmN0IHJlZnMuICBJT1csIHdhbnRpbmcgdG8gZW5oYW5jZSAic3VwcG9ydCINCiAg
ICBmb3IgY2FzZSBpbnNlbnNpdGl2ZSB0cmVhdG1lbnQgb2YgcmVmcyB3aWxsIG5vdCBmbHktLS1h
c2tpbmcgZm9yDQogICAgImhlYWQiIGFuZCBnZXR0aW5nIGNvbnRlbnRzIG9mICJIRUFEIiBvbiBj
ZXJ0YWluIHBsYXRmb3JtcyBpcyBhIGJ1ZywNCiAgICBpbmR1Y2VkIGJ5IGxpbWl0ZWQgZmlsZXN5
c3RlbSB0aGVzZSBwbGF0Zm9ybXMgdXNlLCBhbmQgaXQgaXMgYmVpbmcNCiAgICBmaXhlZC4NCg0K
ICAgIFRoYW5rcy4NCg0KDQo=
