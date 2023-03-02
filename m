Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C962C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCBWBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCBWBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:01:39 -0500
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn20819.outbound.protection.outlook.com [IPv6:2a01:111:f403:7005::819])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D1B5551F
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:01:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D48+Pwr3LigKrIiO1NGDuO0ArDDFM8tmL8JlmY27f7koRw8pcNyaLNlBb/IyIuGXzDbAZGrYSCZWvguMapQo+625aJwnx5jUnd2/o4LYkVx6yQbH73WiG3F3Ml6MRdIe4QBKzndNSzBQ7/hL8dpcVyGOux4seMHSxbeEpI0Gsay5zrsY5Qa1P+o9gMR2hAGaANuYoWL7l/wVofIfssElhEbSQDbuWp7k3u5GypcLu1jsR25y5GIZVGEe9+H1fhfVTZpK2dv7LygAzS6POGTtYei0qqJLCAsKoLxT6+OHCU9R0N6LmBhIB7c6FYZd7aPL9ZGFQ4BXuT1iEUqFx8Yi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtbreFdKuQ+8JWgIUiyoAt/aaR0pXf1XaOHQIWfRtDA=;
 b=iVbmyxgCK4n1x00bge34JcxfZp25+do/0yTEdMEqEJLonNpUR6ZDAOKeuhELkiOZexg329nCPKs4RB1FbYHL6QvpG8GMTpfQyHrQafdQ3mmYVJfpbRCp4/v01riuOTLJ430g7wHnakNoGNE638N0g8gPP0IvZB6DbfRb86iEngqFlcGnBE+FUs/7ce/RAR6zI2SVYordXfAgTQd7Ss3dIacE99p99JPKOujcXUP3oZjHh2PXoh6xkbH315PEGXBHmg1hI5+VquYVYhHrk72QZlL1/xYSMRv+GxRRkJnhnfg99XhCj1hVpmUkvSK4jcJqeZUG5ysd356A23p9vHsLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtbreFdKuQ+8JWgIUiyoAt/aaR0pXf1XaOHQIWfRtDA=;
 b=NEU0VQ+aNfcDrnjLiHUzBa46DKhQty4iPmSk2RmStuOPBp7ey67d9aNFBvenQE2BazuPjUcureQqZmSq1oalLB9Z+VAWlUiXd0E/s1ffadzTLzvDt2YWOr/qvMGwmAN/pz8W6YsQGLZ7Rr8B8u9U8w6KGAIab4Tz3ktWWbdPxfpCd2Jv0gf16LdJwskgnUDkN2vaWcBHI2mXXKugegdUmM+R7u7kEBC0837dfKi0L0puUn9DNQdgnuel0sCgHk+4sjTKLfb3GuvOjUJTZmpbB//vW0H2VJLVi8Rt9iyFWuuP2tdECjLdI0Z7EuHln4zAhvANEE8P6QUVgd6kDtFVyg==
Received: from SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1be::9) by
 SYBP282MB0122.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.17; Thu, 2 Mar 2023 22:00:59 +0000
Received: from SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f382:7e57:e8e4:2c]) by SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f382:7e57:e8e4:2c%6]) with mapi id 15.20.6178.008; Thu, 2 Mar 2023
 22:00:59 +0000
From:   Dinesh Dharmawardena <dinesh_dh@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Let us not call it git blame
Thread-Topic: Let us not call it git blame
Thread-Index: AQHZTVJ5pkJAaoUsPUej6bMQtlpoiw==
Date:   Thu, 2 Mar 2023 22:00:59 +0000
Message-ID: <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Guf0ub4xv2SaRUnpIr1O/tCAaM3oMo41]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY6P282MB3782:EE_|SYBP282MB0122:EE_
x-ms-office365-filtering-correlation-id: 87b04502-e7a1-402c-ba8b-08db1b699b8f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEdsm/IczY45P2ZNLtlxZtlCW//3tSehZfBTiT37GPF271a/OUd1VIUaIs7t4pXKdVC9xlKSEKLoHTfTu8q5Bd/CjTCGlpQvypUufANlnAK79Rx+ggFlJxjUAARKsEn1fs3hisT/+Sn4DDFCCclQAMqFqfo5PwuPJCYuhNA1+ngg+MReP+AI3V+XMqJE2DSpDsCgk7sS29fFDrtVWHQOvzqMRkI9HpcshGSyNrXufQvHF6JCMkztTo71YqKZTB0nM20FdME9vA5fffYA/8/43z+w+HXQCqFaXwjC/jvNnFlZcCwbKihgqVkiXndTOxwsX1rD95gZ8t0/iAJuU2qLnRM/f5jhPq9J3n/J0b9vqvDKD1UTqwUc92DfwGK1KJdWg0xgSg/47YHkh0EBpCmCnD13EePFfwB5aYLXr+k3WrertQiEzjc1a23OkfjB80uB6/OKMDbMd9iXuriq4xNH7kDrjFekqY6WPVV3N01kyHHiKUKw0SknoAJTHuYJqKoNNv03L46S7sUmcIvWRPlB+13Ku2ojZGKqmUdr9/5PwjWgnOAZAdHO/TaVnKes+fPX+KPFehn59bBOHRrDlqOdzA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1d2OC9RVWV5K2hVZ0Npdm1BdmpIdkZlN1NKZ2RtQlhiNmd4RThFOER3VXB1?=
 =?utf-8?B?U0lCWjBERXJvNkt3VlFralFhamsvNVhLVVIzMFp0NVk5K2FUUWF4cTJobVhL?=
 =?utf-8?B?U283ZWVsZ2VwTDAzRU5qYXBMQlFpUXNnM2xCdG4zN0thZGJxMzN1aHpCTDh1?=
 =?utf-8?B?Q25VVFpCdUVtT2dNdytrbWJnVGtwcm1Tanp6ZzVQZnNBVlJnVGNFQXd0SnNC?=
 =?utf-8?B?RDJWQ09neFZleUV3N2F4OTVjVXJMSnJzeDkxVXVpbzB6cTNlZThnakxkdEJH?=
 =?utf-8?B?RGdlNFJtMU0rN1M1V0hWajI0d09lUjVJSEV1WlJ5SlI2d1pWMzNxeVQ4RmtM?=
 =?utf-8?B?ZTMwMko4WGdWd0NXcUFLRmFQWU5XVklEWmhOMnhINWExL0VLeVcyWkZieHRx?=
 =?utf-8?B?d2t1bElja2szZFpmSFp5aUNiQ2x2dVZXemx4dDZmUU9sbkcwYm1NMEs2b1Vx?=
 =?utf-8?B?UUdydEc0L3RySjdrZXo2K1NZQjJJQzk1WDQ0aGl3S3BXUlhXREpFTTJMZ05q?=
 =?utf-8?B?bDNOTHkwRmVZazVLUUNWQlNtekMrZjhTRGFWdU9YSGV1cjhWSmkrNk9aRU1R?=
 =?utf-8?B?bU93RVllVWdUMC90ZEQ2ajV0MDBTNmtzTjBIdmIxSE1pUWx1TndhMmxiQXd1?=
 =?utf-8?B?UGRqZ3E1TDBMV29WWElyakxDanFXb1czSFJnbkx3d1B1V3NONWpwaExuRTIy?=
 =?utf-8?B?SlFHUHh1aUpvazVjZ3FJT2VZeVZ1V2FpYkpZSEUxSHJZdFdSQWlNZUpqQWlC?=
 =?utf-8?B?QzBQNGtNeU9PNXdCam1iRjRNby8zMmp3WThYWEZkS2hUVElhL05CNk52ZzJQ?=
 =?utf-8?B?M2UzUXBaUUl2c3lFSThlOVBNN3dYTDV4VUVBZC9LMWVCanAxV3NBMTFlNW82?=
 =?utf-8?B?RmxsalNoSVo1YkFPdzJTem16TGF3UGxBMEVENDZaUENXd0JnSGEwbTJ6SDJz?=
 =?utf-8?B?WEQzdmVPT3d6RHJoMXBMMmswM0lYRk9DVnE4ZGhYNHZRZElXcm1vdm1DYTlZ?=
 =?utf-8?B?UE5CTWplMU1WaHRYSlBIcU5NTG1tYUE4K1c5UVVrOVhqWFJCb3J1MDNNMHA3?=
 =?utf-8?B?c0RJMHZmdkdtMkVCRXl5N0lBRmo1Z2dUb0FsVUV3THhmYm1TZFBGMGlCQUR6?=
 =?utf-8?B?Z2VsYnhKYzk3VGJoYWJIaXRrSlRuODY5VWdycG0xUC9nY1cyelZkOGhadUxz?=
 =?utf-8?B?VHJZVjhQYUZXRG1DTGRwN2ozT1Z0UlNoL3lqeXVhbGR6bk4yZkx3cUJ1RnZ1?=
 =?utf-8?B?WXkwekMwUnM2bndGQ01iTGhuRzFWaStSYStEa2lOeElnOE1yb2dCUnpRd1FF?=
 =?utf-8?B?cGhmanZueGVNb2p4cFdlUGhQT0QycUhqdVlQYmt3aElsZWJxbW00OEtiRnNZ?=
 =?utf-8?B?QmFFVnpzWVQvOThqTzU2RnNKcnFodDhoSmhKZTBYU0lZWGJLL0dKcVRvTDRR?=
 =?utf-8?B?TjlESjFKdUJkcVZmWkIvdXRuVWQ5UjdQc1lHN2w4bFp6NjZNenMwSGloanlI?=
 =?utf-8?B?YjN1SEJIVnRiM2o1OFJyRnQycnRRTG1lemlzNi93WFNJejlDTFUrektyU2dr?=
 =?utf-8?B?WlZkbWJLQTNYNXBybGJmUmIvTGQyUnlLblp4dzB0MHk2MTZ3ME1IbEszbzQ0?=
 =?utf-8?B?TUtkY3lhUVVLOXRJOGhOMkNvTFl0RzN0V3p5bkdIV1RaU0NPSEk0azAzNXVn?=
 =?utf-8?B?Vyt6YVJnMFlVQUdLYVUvSzJDWmp3cHQ0ekR5VVlEZm00bU1vS1hYSExnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b04502-e7a1-402c-ba8b-08db1b699b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 22:00:59.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB0122
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkNCg0KSSBhbSB3cml0aW5nIHRvIHlvdSB0byByZXF1ZXN0IHRoYXQgdGhlIHRlcm0gYmxhbWUg
aW4gZ2l0IGJsYW1lIGJlIHJlcGxhY2VkIHdpdGggc29tZXRoaW5nIHRoYXQgZG9lcyBub3Qgc291
bmQgc28gYmxhbWVmdWwuIEnigJltIGFuIFNSRSBhbmQgd2UgYWN0aXZlbHkgdHJ5IHByb21vdGUg
YSBibGFtZWxlc3MgY3VsdHVyZSBhcyBzdWNoIGluZHVzdHJ5IHRvb2xpbmcgc2hvdWxkIGFsc28g
Zm9sbG93IHN1aXQgaW1vLiBQcm9ncmVzc2l2ZWx5IHBoYXNpbmcgdGhpcyB0ZXJtIG91dCB3aXRo
IGEgYmV0dGVyIGFsaWFzIHdvdWxkIGJlIGdyZWF0Lg0KDQpDaGVlcnMNCkRpbmVzaA0KDQpTZW50
IGZyb20gbXkgaVBob25l
