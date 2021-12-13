Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36764C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 13:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhLMNrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:47:55 -0500
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:33120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232047AbhLMNry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 08:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvhRAaRJFUY8VbDsCX5bc8C/JFj+61VuAwuwEdp/qf401vZacniGrDZrFxhO+EqA94WiJeeophFYcPDUYOwtLJcjGG+wmS7MM3JhwGWr2R+xD0wlmwtihf1DndlOIjxMTF/WKw+r/VZgrNpVpBtSjQkDUVPiZfWnXhQvxJ0b536hxgr7hZoc+6DGuWmq+2PPPJoCHOH1lH6sYFzoQIoDU38JTF7XQRKfvns7JT9nr1AfCveY7R5NDF75ZhI+wVecP1wlmPr2abkV4J+62o0VNy7qFT1w9h+bcdEr4TvkA7pou//S5vPblJ0AUm7eO5qYaf9MWETaE7nBmrKLqHkpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJfctpUVpICXRPhWe4NOIeUdnptpm1SgBLMc6/1GU9I=;
 b=mns7Hd+wTPAvP4e6NrTy1SPVHR1XAkp7Hj9jkPj0w3xr3egwsmJ2M4wej0eYD0QCDoDPExXlj6yRyFrrGKz0gjf6e/+71xZoKE1PuHKkRIQ2POt/tZulk7gIuSK3RotwWXJY1GTdqgpJilpBQfkfLgbCxl4YNGSrAJPWMJdriwlA1pGQA7hna1Kl/EFf2/H5jksyRmHLHyctqOj/McMWSxVpymW07PJf/Ni+GHGVb8SBz2e75E7+WJSr65opohC8rJCbqg2U9Q7lIqGuf89qh7iHW6Yjx2TIHAlwourYgjOXY4R31zGQT9PvJ5deluOh+5XEoQn0M0dikBTa1bVvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJfctpUVpICXRPhWe4NOIeUdnptpm1SgBLMc6/1GU9I=;
 b=XZXTHaFeHLnPx0ZK6BNznsvxC9xi/HtVA3JbAJB5sf4ETvWzA2PPwCudpvsOG1g0V2eIcGVeHdi5pjd3gtcviHVdfe4bVMDuwiPiS/gK2P643dREMWwuyhjssZ/uxQm4w1X61nX1pWgMW6lQWf1prtHaKMqeSrV30AmoNjUv8oKIv3hkNQpKhs/qHv3Sy3U7ON90xHcEIPu6rY9IjejGemZDMEPsyXWnkJ2q0KX5hSTpyCxXtLCk57Sz+Dsug0K8JZLJN9AMqMCZ2/gpHO9toV4KlSyGcvewDt0qXhKohhFcK9xa5ZAgGRmOTRyfqFjQTC8WAdBKWHFEr9CDxolzVg==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3284.namprd12.prod.outlook.com (2603:10b6:408:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 13:47:49 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 13:47:49 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Luke Diamand <luke@diamand.org>
CC:     Git Users <git@vger.kernel.org>
Subject: RE: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Topic: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Index: AQHX7TjcBdyuTAN1MEKv4eIoPWSSjawrW5kAgAAx4fCAAYNXAIADYpSw
Date:   Mon, 13 Dec 2021 13:47:49 +0000
Message-ID: <BN8PR12MB33619656D91E92C50FF1B86CC8749@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com>
 <BN8PR12MB33613E4CCDF13E6D0DE155BEC8719@BN8PR12MB3361.namprd12.prod.outlook.com>
 <CAE5ih7-ZoKThXefBN=znytQi=z4_notihQdSksYdMTzKDTAb=w@mail.gmail.com>
In-Reply-To: <CAE5ih7-ZoKThXefBN=znytQi=z4_notihQdSksYdMTzKDTAb=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57594a33-84df-4fe6-fe6d-08d9be3f2711
x-ms-traffictypediagnostic: BN8PR12MB3284:EE_
x-microsoft-antispam-prvs: <BN8PR12MB328441F6FA38B0DD3BB53976C8749@BN8PR12MB3284.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NV7UVNnnoqFPuG7kqmHlFNxiwMEcEsBJBAXf5smxzEYFkZBBoqTw3hboP0YovgpTaIBpB9xjzQ78rrDvq2Qwt0sCpJxiI94RN8WzIWmLGY0O60XjWKAp/jrRsBDQn7dcyxgJy/YNAGPeXvatCHfrVuuA+WKaImRGiyfTolmi1uvTtgu9D3b/7RSClIzHUpKDjHit58O6BuRHNluJuXxgb2He3LZ8yXz0/qRGktJ7D7Q1Mb1xar64UQz6c5PLzlYvlYJ9vls36L/KVuccKRVxgKsp7iBbxzTe76o1RzXMntw/20dC2yyxl4yQF+4GIlJXNAH8NSwONkc8YQRZHgIZFW9h6hZHJB0/t7ahseLgBw28QawT3DUVUlIqTYrjBrikchgAnLe2QOJj5k1MXTrwRTKHFHfijHKuKryqBftrj1OlKEN6cD9cCtTLcbfgIjqaC6Ysjr636yHS8RpY+LLbsoH/L1qj+lGRaa978vW2x7qdYu3eMRb4gyhXkfP3fJn/FXvWdBt8iwB6tnHAchSZBiMva/AvHY6LbBFBmAPx235LxlBV8MXYEa+Yd0ULQz2POSLOCk7ljOyfkjLjs29SxxsQDoXHHEoq6pxD56AkKWlScuCPsv/YxPTHde8A/DZlWYUIvZjqgGLcgm6m5ICPh6ykZUwhEyv82oeVDsLbLULAU+PmijDSbElWXPCOa1DOTNKHDDtsaWdlQQg/s42Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(8936002)(4326008)(26005)(2906002)(6916009)(122000001)(33656002)(71200400001)(86362001)(9686003)(508600001)(316002)(52536014)(186003)(76116006)(55016003)(6506007)(66476007)(64756008)(5660300002)(66556008)(7696005)(4744005)(8676002)(66946007)(66446008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnZrSDJZVjdIdnAvQTBDaVd3Q2VWckhPdXpjVGVRYzBGaFdlczZxelpaQnVW?=
 =?utf-8?B?aDNpaW1VMno5WFl5UFFCOVZaSEt1Y0RSU1Z0dWNwZUZwQnhtZlFJMm5ORlU4?=
 =?utf-8?B?Zmp0bmxqTVlkZEhpQXpYYlJLRDE3WGdUK1lXc0tsb0c2ZndkL1Rtd1NSdnRO?=
 =?utf-8?B?akhFQWxEWG5yUDZMREhhaFh6eVFQcnZiMzU0MEtFWGVYTmYva0R4a2tXaUd2?=
 =?utf-8?B?bHROaVhCZ1FTVDJRaTIwV1pXeDJ3TklyZGx2SjV0b25nWlRzcWc2M3hTaGdr?=
 =?utf-8?B?ODFicG8yTkpiN3NzTjhHd0dqVDg0TkZkakZYVFRreE1NcVZkaVVtTTVIMnBl?=
 =?utf-8?B?ejB5dFZ6eU5sQzR5MzhPUDJaZjM0eGsrb3o2Q0RoL3lYSWtwby9WNW5sa2k4?=
 =?utf-8?B?ZGdvZnBCSVJtWGYvY0s0cGRpRW9lRmlqdUxnZmJpc25uT0ZQVUNEYlNLN1NI?=
 =?utf-8?B?OEhjV1EzZlA0NXltZndnZll2M1dlNDBlUk9JZ2dGaERxaGIrQWYwaTZSWG9C?=
 =?utf-8?B?TGVaL3IrS2FRRWw1SjRnZEw0dmpKMWExZCtiTkMxMHpRN0RRNTF3NTlUZXNT?=
 =?utf-8?B?U3UwS0RlMFFLS1lYMnRjUGxMalY1OXYyTTJFdWhBOVBhb0dPdTVJNFE2SUxF?=
 =?utf-8?B?RDdhYTVDZk13VWRtYURmSkwyTWdRT292Z20zcCttSzJjbGVzSi9aVXowcXVN?=
 =?utf-8?B?anVzZ2NDbHJEZ20xd2p3Q1gyaFErL3lkWEcxc3o4dzBza1Rwd0JDOWY5YTZZ?=
 =?utf-8?B?MC8wcEloV0NmYXZyenZPTWw3K09HY2pDelBDeGdGMzNvQTJjbit1dFhFSVU1?=
 =?utf-8?B?N0l3Sk4xSmh2T25DUnllOTBzdjdaNkNnTFUxSkN0R0NWa09uN09ENlQ5NTcy?=
 =?utf-8?B?UXA2dThkczE4N0s2M3FjaXg4WjZuNjg5a1RBUEhmekhyZGsvOEZ3RjV0c2wz?=
 =?utf-8?B?Y3FoQVNqdUhtU2lheFBjVkZJUG1memF1aUMraE5QVTZKM2xwZnlDZFhOeWcz?=
 =?utf-8?B?b0IyRHh1QW5PY1VkYlpxWmYwVEFIQ2VzZkFWajIwNnRZeXBUZUEvem45U0pl?=
 =?utf-8?B?alJwZU1qdGxBWUg1Qzg1N001cGY3OHBvcWxDS0dmWnhldGt6elhyMDMyQkE4?=
 =?utf-8?B?WFh1OG0wRXY4a01Obnl5QXJxczQrVTNqUFMrRTVtOFJncDQxaUNSUnRsdUNm?=
 =?utf-8?B?QkwwWVF2Z0xVOHVuOEd6dzJYMHhKVm1YVGRSTlJYa3krQUVkZlVTN0RkLzJx?=
 =?utf-8?B?QzUwNk1nOHAxMCs4RDZ3djZPVGd0Skx1cmlTWnBRRk9VYTl6SkExSDJWRVJY?=
 =?utf-8?B?Vkh4V3ArODE5RGx1Qm1OSTEvZjhLbnpydGx0T3Z1bDRtYmN6VGFJRHIreXBl?=
 =?utf-8?B?OE8xbG1YMkNScTBhbWRkUUNkb0pqbWJRanFGVWJFaS9zem5RS3loZXBNTmha?=
 =?utf-8?B?R1c5cE5pRStEVTBWanB1N3psaXQ3c2lxb2t3QnBaUVhBWjJZQmsrZUVGSTFx?=
 =?utf-8?B?RzBza2VPdngrVThFYnEyU0Q2OUJ0TmpuQjZVT1duWjYrNTJQMzBlVWkyRmVv?=
 =?utf-8?B?VEFNVTZSODBwb1pIUDJPa0U1dURIa1lIcnBxaEJERWtrU2JPT2swOUtBK0lZ?=
 =?utf-8?B?MEhkSG9lZFIyRjM3eEpNcXhHQ2UyUmk3b3NXeFljS3Axb1NMOGV5QlJiWG5t?=
 =?utf-8?B?T1VtU3V3aUhwMjJmcWNnOHdyeG5OWll2Zk11RTdqMVkzYmUxRnVhVXBzSjBN?=
 =?utf-8?B?UnA3NU8zeEIzbndPK081MVduMThlSjgwMG1zKzZZOFFtK0l4R3ZVWEpjeEg2?=
 =?utf-8?B?MWltVGhNM3V2b2k4djRpekFBZ3dMd2ZwMDVOc25HN0RzaWFxZ2pJUDEyZlZL?=
 =?utf-8?B?SzlBa1BDWkMwZzJVSWxZc1VsQ1AwWnY2ZUNUdklJakhuR2NnZ2lNMEl3cXZF?=
 =?utf-8?B?c1ZaV1pxdmZYeEUxQTFrd2xKa0cvaXlEYzc3OGlIMmppNUVLeVdYY0tqTXZZ?=
 =?utf-8?B?R1FHSGRhbGpKNHo0djdyVXVuMVc0Y0hHbWpBM1hlV2w0ZlNUUWxQZ0RzUktF?=
 =?utf-8?B?bGF3bmdWMFRpdEpqY2xzRERKV3YzSVVHMi9EYzVQWTRhUFU4R2NpWDFBTks4?=
 =?utf-8?B?TWFqQlh2c043cUFxUVAyQWRtWUpYd3l6QmZOcWN4Nm5XbmtWWXJITExPdVRI?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57594a33-84df-4fe6-fe6d-08d9be3f2711
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 13:47:49.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XgU6g8mYOS1hUSyiy5Z2h9tzHg7Gx2Pnj0M/D5icbO7siH/eDXeQrY3GKwMD3gWXigoxni/YrOB7SqA0D/sXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3284
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiA+IFdoYXQgdW5pdCB0ZXN0cyBhcmUgdGhlc2U/IEkgYW0gaGFwcHkgdG8gdGVzdCB3aXRoIHRo
ZW0uDQo+IA0KPiAgICAgY2QgdA0KPiAgICAgbWFrZSBUPXQ5OCogLWokKG5wcm9jKQ0KDQpBd2Vz
b21lISBKdXN0IHJhbiB0aGUgdGVzdHMuIFdlIGdvdCBhIGNsZWFuIHN3ZWVwLg0KDQpXaXRoIG9u
ZSBwcm92aXNvOg0KDQpXaGVuIHJ1bm5pbmcgdGhlIGN1cnJlbnQgdXBzdHJlYW0gbWFzdGVyIGdp
dC1wNCB2ZXJzaW9uLCB0aGVyZSBhcmUgZXJyb3JzIGlmIC91c3IvYmluL3B5dGhvbiBpcyBub3Qg
cHJlc2VudC4NCg0KbGliLWdpdC1wNC5zaCBjaGVja3MgZm9yIHRoZSBwcmVzZW5jZSBvZiBweXRo
b24gd2l0aCAidGVzdF9oYXZlX3ByZXJlcSBQWVRIT04iIC0gYnV0IGlmIEkgb25seSBoYXZlIC91
c3IvYmluL3B5dGhvbjMgaW5zdGFsbGVkLCB0aGUgcHJlcmVxdWlzaXRlIGNoZWNrIHBhc3Nlcywg
YnV0IGdpdC1wNC5weSBpdHNlbGYgZmFpbHMgYmVjYXVzZSB0aGUgc2hlYmFuZyBwb2ludHMgYXQg
cHl0aG9uIG5vdCBweXRob24zLg0KDQpPbiBEZWJpYW4gaW5zdGFsbGluZyB0aGUgcGFja2FnZSAi
cHl0aG9uLWlzLXB5dGhvbjMiIGZpeGVzIHRoZSBpc3N1ZS4NCg0KUGVyaGFwcyBpdCBtaWdodCBo
ZWxwIHRvIGhhdmUgc29tZXRoaW5nIGxpa2UgInRlc3RfaGF2ZV9wcmVyZXEgUFlUSE9OMyIuDQoN
ClJlZ2FyZGxlc3MsIGlmIHB5dGhvbjMgaXMgaW5zdGFsbGVkLCB0aGlzIHBhdGNoLXNldCBwYXNz
ZXMgdGhlIHRlc3RzIGp1c3QgZmluZS4NCg0KSm9lbA0K
