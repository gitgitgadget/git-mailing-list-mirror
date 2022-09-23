Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A83C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIWQvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiIWQvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 12:51:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AFF147A1B
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfpzCh8tIZwEUX7r4j8Wpq08ut83/+vGaRv9DChwlpF0bKK/V+ZwlqqdbrbWav6XZVGCALPL6+1U+gLSIiQvMDKW+70SwNRAdwQoXv9ny9pJYW+HYQcCS2tjJpwMWc7FAlZvQNpDYP8z7inEwZKUE/1ngekMpQqSmY5eIe+S1tmo7/sW4ix+xI/Ai6Fwnx4eoQvyMvzUCOd5+W5scO6WMqgtM8bRzxAXTpgqdjue1OLybV1YP3f97RGY8BeV8lQ6P959AhuDRppJw6RaqyDfNaTD6tnXms9UF5HN1z873tikW5zq7TL/q/yDlP0bGhVvaBdA+AX03Z4/Ielxanms8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqGurQ4aBvP9JW4XYIAx/1XzHQ7rcat6Wc7YJGNJLIQ=;
 b=MOZZ0hbRR//yMnHzUmm/iA/M9fFAZcDji3tfmn8SfO6Jc88GbrKWfZtlYn+3K3SnHEtzdEaztenRxeMWtdN+mb6ChmV9XNmz6FOdHnDBBfr86Gta+IQRlaHt5XeTuJqpgbR5nMr9c0q2LdgzfwJQlm6jFMQxrf90jsCtrmfntVer4tKrcFBKBu3PV33V6sor+8x8aLm6fody08kEQf+IRDQ+HacMlqtSjFp7yODWv9a0XcnkqLB+eR8zEV+CQBcZpVvz5hBw01EHAav/CeH7ASCKDY3Hv9QOYTxCamLkfTA8nKek9SbXe+gjymiB2WTFDNQdt4GRy2wg6emyejU8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqGurQ4aBvP9JW4XYIAx/1XzHQ7rcat6Wc7YJGNJLIQ=;
 b=IG5EH6/00kZx5XVjZb0tDIO3w3AFbJlyBsK9gCYTWsmlxr0gXEUVgj3+AugYzi70bMeqzyfsoidLNXH04ZFJKr7aUylKHwgMWKxG0BbOklii+hG0GNVA3G8cQfdNUNhxFMr8HZ+v6WXtHCtEbeX4n9rNbaLFEQFtgbq43X5Q2QxHSOpy/M13J5fVdFSs4Xu5MxOVRLaRD6VlXgdmC6GsBQZOKTW3PJf2BjC5DT108vqLx0R8qmxKMaANK7o9IBIk+IuMaYyFbfsec/n9twnOywuiBdKk/hnb/iSEFC//wqNbicTeh3stITmpJ2zfDaOUyyGE99jbug9sIiNx5Ghu4g==
Received: from PH0PR06MB7639.namprd06.prod.outlook.com (2603:10b6:510:4e::18)
 by PH0PR06MB7205.namprd06.prod.outlook.com (2603:10b6:510:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 16:51:28 +0000
Received: from PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18]) by PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18%8]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 16:51:27 +0000
From:   "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git --archive
Thread-Topic: git --archive
Thread-Index: AdjOYUggigRgkiEITWKCyoo+Qa1cmQAXoZumAAAHifAACZc6AAAg48+QAACXnbA=
Date:   Fri, 23 Sep 2022 16:51:27 +0000
Message-ID: <PH0PR06MB7639A83F08BF3B286E5FEB3886519@PH0PR06MB7639.namprd06.prod.outlook.com>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
        <xmqqleqbxj4h.fsf@gitster.g>
        <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
        <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> <xmqqedw2vysc.fsf@gitster.g>
In-Reply-To: <xmqqedw2vysc.fsf@gitster.g>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.600.2
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR06MB7639:EE_|PH0PR06MB7205:EE_
x-ms-office365-filtering-correlation-id: f2a6367a-2da6-4228-1cf6-08da9d83dbaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyBJ/ohqVTXLxoKcaEOkeWpcjUXYVDeaKfuEzYeazxwTC5YYMxkxpzpHgigqbegv+8eRyjDYys5mBhFO85zHYZi+7X7Eid2bllX9xCnvpQrpUFNSSpTzlVCRXAKACeEjdqxz54SJNZ9H8Udnz3Im5Z0mvSenRIa3/QDiTHYIcYUeUE8uATjVlkPtG9MNDIpZrQCIZFzrPoE1LscLKPO3Oko+CVkFMmrnTnXFjF0np0Hq0KX53pO/FxmucLmbtFk1rIcbH8SnDMQo/fEot0Z1tcBMGkm2CWtjFfQ/76yZOFGoIjfDQua6LJ0cDaG/dDunRHOd+IGyLA4+bvzAWifzR9i/lVqXmca0UhbMLnfsqaWXGRSE4tsYkkslGOoiVeqLEhlxbawo0Zi/4wWSigoAaWZys3ucm16pQ8UD/0eu2nqUZEOjds6KOzruKJ7S6nEcVlk0sIjQTPjXqO5w1tVOC02gDjzCqg/DHegI3SlBZc0aOUwNy3YkrJqPARjN5kRlgMxUDjV1ze/37+Gl0lmZ1RS+Ybcdh0HmTZwGh0fT/7SthauwyffR/pn8gK/gUJoJi60AM6imsQYaCZDMpgpxyu10uCevdTyVjqShBQH35zdc5Prckaq0aD89hv7F+EKa/2CehDDR3BQTsRxl8DXk7+4chsETV9E2ivH/N/TaweaXhzTyo+gwlO+8KntR3LEv6tT93lab11fthI9H1jnrsEuRYvY2MdnD1erb/zcRcGzGk+hUhzb37h0RHpEb46fP4rhUcddKqiZIlL/VkqbmXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR06MB7639.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(66946007)(66556008)(6506007)(66446008)(7696005)(86362001)(66476007)(76116006)(4326008)(9686003)(8936002)(52536014)(41300700001)(38070700005)(26005)(64756008)(33656002)(71200400001)(316002)(122000001)(8676002)(478600001)(186003)(2906002)(110136005)(83380400001)(55016003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzgwQUY3SnUxNDRVVkVqNm5ialgzQk1PQnRzMWk2Z3lPdTBKVnB2eExWMlZN?=
 =?utf-8?B?Y21IRVphYWRpS2pnQXdLTTZxRHhUVmRHVFB3OXFmMDI3NkgxKy9wQTFweUoz?=
 =?utf-8?B?eXJFbG9pNkI2dzVwdW9SSFlCZmtDL2Yxd0R0SkJBWEl2QlhRbHpaSjM4NGlG?=
 =?utf-8?B?U09FZGQxT29nS2dFTmNBaXhuZDBLNWZHMlR2ZnVXbGd2dmF4OEhUU0xKa0Nm?=
 =?utf-8?B?bDRBNElDdDRQaytjWkhDRndSMDFOS2Zjdlg1VVZwelBYQ0Z2dEhwVitod0xN?=
 =?utf-8?B?UzAzMVE4YWxkaFA2UzhtZWRQK1lyZDB2VytCWHZKV25oT2xRNlBzb1oyN3dU?=
 =?utf-8?B?dFhvSUxJUTU1QjNPa1BtWUU5Nklpa3E3eDF5VDdMUGY4cmZ4TjZoMTZIVnM4?=
 =?utf-8?B?UThWdHlhSXBockxqUXJ2Sk1tSzlveTZSLzZaZGZvVjdHdldYa3cxK3BxSGxK?=
 =?utf-8?B?Y1E5YUJDWFFOUW4zcXVhYll1UWRwQ0tNaEpRY0pyRHYxRVhpQjZSYVdOV1J1?=
 =?utf-8?B?ZW85SENpSlY2cjM0SEFCWG5UYXcvQWR0amxMRkFXZ09KTFNxUnJZcnZCSGFO?=
 =?utf-8?B?OVQ3WElqd0xPSDJjUG5EeUxqQzhBVTJ2bEJRdUR6MkNiZlJQcHY1elBWbXox?=
 =?utf-8?B?V0owUWZWbTFHeHJrMDNCUFR1VVUwRFd3aFUrMEtwYjRJajZLakZzVFRhQUpR?=
 =?utf-8?B?cUV2VHBTV1ZSNFVxOWQrRnNhOEJGbTA1SHIzZ0lMUkRxMmhWbkh5aTAvejl6?=
 =?utf-8?B?ZjBTSm43UkdMWDRaTittWHFKWGRCM2hzV2Nma1ZEWGdYMFlYbFUwbXVJbU1R?=
 =?utf-8?B?cDJoZjVqaldSL2pzS3Q5VGphdVBLS3R5dGQ1MUdQVmJTR0xjTWRuSXhKOW5w?=
 =?utf-8?B?VHlsdGVsOXRlUGNqYVV5QXJJc2JLL3ZoNUVFcDcrdTV4ZVZlSmpwUWRYNStD?=
 =?utf-8?B?QmFtV1VWenNjcHNobWlZUFQvdGNUTkhybzFISFE3TEV1TExyc01hYTVMbXFn?=
 =?utf-8?B?a3E0dzdQcnc2djYrTUZRSlgvaHJRb255Smd0bDVQZGxSemZyYWpBVUNweFlU?=
 =?utf-8?B?cFVxcVgwdFVVSzZwNVRnM2ZjNSs1bno5RjdCOVhQUWsyYjFSck1BZWIreUQ0?=
 =?utf-8?B?YUpVdlI1eWxiUHlFUDdjbEljQlZqck1Cd1R6bE5MY1NQa1hYOWU0T01xOVRq?=
 =?utf-8?B?STBZYXRtbk1CQ1dpdWlKSEFuTTdOUWZPOHZ0YWtPQmhGZ29HYkpYVjVaMUpT?=
 =?utf-8?B?VDJrOEdyY0trM2dsOWF4dVdSSmJ3c1V1YW10TWYzTTczeW5ES2F4SXF5TEdr?=
 =?utf-8?B?Nm55alA2NU56aklXM1BvcGJXSTR4OGVaNFc4bWZOOElSNklOL21MREMzM05m?=
 =?utf-8?B?TWptQ2FyVnlPalBzdlViUm9qV2grbExEK3BsUUVJempYYTd1eXBKQXFOMkVt?=
 =?utf-8?B?ellUQlFSbnRpNkY1MkJ6STRNcG9mRTE2N2VTbU5OL3BXUWc0MlQwSXpTanVU?=
 =?utf-8?B?anUrL3pKY2x1NE42ZVhuMzlxcFN3Tzl3N290S3BqL3RUMWVoTnkrcnVTYlFH?=
 =?utf-8?B?OWVtOVA1Z1dFYmFEc2c3QnFtNG9YV3JIdGszVlZPR2NGY1hyWWIxRzlaSGpD?=
 =?utf-8?B?NWMyWHpxcnlmbzdFYWJMdDBTVHFteTg0b1hYK1FzbnlPcGk1LzJ0ZzF1eGYw?=
 =?utf-8?B?VlJqU1BiVXBuVUNvR3JTejgvN0k3c0NpdDZGclB1bkN1aFk4azIrZ3owbkox?=
 =?utf-8?B?RHdsaHR3SnlYbHNhM2ROMlZCbm1MUkt5VUM2Tzg3TDNoQi9Wa3hIYlI2bHNr?=
 =?utf-8?B?Z0F4cm1Da0srMERPVncxK3pHY2hTWjVpd3JYVGwzUURhc2Y5Uk1pV3phZm1s?=
 =?utf-8?B?Q3drQXJGb004eTk2a1UvWWVqc3VLVFVUa2N3ZHZiOXRGcm1DMGIwYnhWZjFu?=
 =?utf-8?B?SjlZTlY5L25oM3d3RTBkejRjNFVrem9ycVFlRmxOOWZPUDIzQkgrMVhxV2xC?=
 =?utf-8?B?OEY5bmlET2VNR1dIK0U4TGFGV0g4MTZBVzcxa1ZOV3dtN0dQK0w1VW5Db0dr?=
 =?utf-8?B?a0ZVRWdMc0cvajBaT1NsUTlyM2hIaGM3ZmEzMlpnSmZud3ZwQTZURllRR0xV?=
 =?utf-8?Q?tCUM8xokQL/uowlTd0rJ3m4Mo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR06MB7639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a6367a-2da6-4228-1cf6-08da9d83dbaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 16:51:27.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYuoG4teoep5cD1QyaKBgQjBXQxz2HXmIgAuWylrqKFPMTrUkpCdZqsTV5ebdrXfOul5xiM33p10yDZfrBWFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7205
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCg0KPiAiYnJpYW4gbS4gY2FybHNvbiIgPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+
IHdyaXRlczoNCj4NCj4+IE1heWJlIHRoZXkgY2FuIHRlY2huaWNhbGx5IGJlIHN0b3JlZCBpbiBh
bnkgb3JkZXIsIGJ1dCBwZW9wbGUgZG9uJ3QgDQo+PiB3YW50IGdpdCBhcmNoaXZlIHRvIHByb2R1
Y2Ugbm9uLWRldGVybWluaXN0aWMgYXJjaGl2ZXMuLi4NCj4+IC4uLiAgSSBmZWVsIGxpa2UgaXQg
d291bGQgYmUgdmVyeSBkaWZmaWN1bHQgdG8gYWNoaWV2ZSB0aGUgc3BlZWR1cHMgDQo+PiB5b3Ug
d2FudCBhbmQgc3RpbGwgcHJvZHVjZSBhIGRldGVybWluaXN0aWMgYXJjaGl2ZS4NCj4NCj4gSSBh
bSBub3QgZ29pbmcgdG8gd29yayBvbiBpdCBteXNlbGYsIGJ1dCBJIHRoaW5rIHRoZSBvbmx5IHBv
c3NpYmxlIHBhcmFsbGVsaXNtIHdvdWxkIGNvbWUgZnJvbSBtYWtpbmcgdGhlIHJlYWRpbmcgZm9y
IEYobisxKSBhbmQgc3Vic2VxdWVudCBvYmplY3RzIG92ZXJsYXAgd3JpdGluZyBvZiBGKG4pLCBn
aXZlbiBhIGRldGVybWluaXN0aWMgb3JkZXIgb2YgZmlsZXMgaW4gdGhlIHJlc3VsdGluZyBhcmNo
aXZlLiAgV2hlbiB3ZSBkZWNpZGUgd2hpY2ggZmlsZSBzaG91bGQgY29tZSBmaXJzdCwgYW5kIGxl
YXJucyB0aGF0IGl0IGlzIEYoMCksIGl0IHByb2JhYmx5IGNvbWVzIHRoZSB0cmVlIG9iamVjdCBv
ZiB0aGUgcm9vdCBsZXZlbCwgYW5kIGl0IGlzIHZlcnkgbGlrZWx5IHRoYXQgd2Ugd291bGQgYWxy
ZWFkeSBrbm93IHdoYXQgRigxKSBhbmQgRigyKSBhcmUgYnkgdGhhdCB0aW1lLCBzbyBpdCBzaG91
bGQgYmUgcG9zc2libGUgdG8gZGlzcGF0Y2ggcmVhZGluZyBhbmQgYXBwbHlpbmcgY29udGVudCBm
aWx0ZXJpbmcgb24gRigxKSBhbmQga2VlcGluZyB0aGUgcmVzdWx0IGluIGNvcmUsIHdoaWxlIHdl
IGFyZSBzdGlsbCB3cml0aW5nIEYoMCkgb3V0Lg0KPg0KPiBUaGFua3MuDQoNClllcy4gQnV0IGV2
ZW4gcHJlY2VlZGluZyBhbnkgY2hhbmdlcyBpbiB0aGUgYWN0dWFsIHRyZWUgdHJhdmVyc2FsIHRv
IGNvbGxlY3QgdGhlIG9iamVjdHMgb25lLWJ5LW9uZSBhcyBjdXJyZW50bHksIGEgInNpbXBsZSIg
cGFyYWxsZWxpemVkLCByZWN1cnNpdmUgd2FsayBvdmVyIGFsbCBvYmplY3RzLCBwc2V1ZG8tcmFu
ZG9tbHkgcmVhZGluZyBhIGZyYWN0aW9uIG9mIHRoZSBkYXRhIChtb3N0bHkgZGlyZWN0b3JpZXMs
IGJ1dCBhbHNvIGZpbGVzIHRvIHVwZGF0ZSBhbGwgdGhlIChleHRlcm5hbGx5KSBjYWNoZWQgaW5v
ZGUgbWV0YWRhdGEsIHNob3VsZCBoZWxwLiBBcyBsb25nIGFzIHRoaXMgc3RhZ2UgaXMgaGlnaGx5
IHBhcmFsbGVsaXplcywgaXQncyBjb3N0IChpbiB0aW1lKSB3b3VsZCBiZSByZWNvdmVyZWQgaW4g
YSBtdWNoIGZhc3RlciBzaW5nbGUtdGhyZWFkZWQgdHJlZSByZWN1cnNpb24ganVzdCBhcyBleGlz
dHMgY3VycmVudGx5Lg0KDQpUaGF0IGlzIG5vdCB0byBzYXksIHRoYXQgdGhlIGFib3ZlIG1ldGhv
ZCB3b3VsZG4ndCBiZSBhIHNpZ25pZmljYW50IGltcHJvdmVtZW50IGFnYWluIPCfmIoNCg==
