Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhLJKwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:52:24 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:31232
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233090AbhLJKwX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:52:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxQJObLNa15Iz49dSurHODrp/7FYjQuqgRjYei2N17m3bsywEHERFcBDS591+FGJ/rTjBwsBiQyaSpfDxxKx24nADCitMIAf6xdKNJc/WL75DDMUq5cSEkVmUq3VMmjaKXRuoxSkG7hPnJ4ZKmRlp8kAqMufwPfKvGaOM28epjG25djerbh92bnMUTlXnGkv6KW0cKaHn0stf1EHx/zOWK/KJwUVIIz9daB7ooKJeryOS5rGz0p9zxbvIy9wGGvmjQA5AEUsEbdwTJlZ6ZS/Ih+VvFH31sFKj/KOANo8B0JxUvdCfJ5CMLb1Sj4EH1GBGdjWYokcUtUjQ5jV0mSWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlp/c0C5HSwByaxr9R5AfSUsJXaWDOFI528h/prwZyk=;
 b=RgrSFR6bASFOYRMTgJSOulARybCc9eBy0ChwDCHrtHd5unXFFiVoA14Wi5WHcIS3t1dM3OLIG07Nu4iP4FF6sbU2NcebQjLCZvuBvAr+A6gXq7g4mtKF2o+oX04UjBKIXA9dkliLvWNKR9B31fO9DLurjsks5H+Kwk++Vv2n3nT9UPDyL9I2XgK06SeZXJrrGks+ro8FIroQUz5TAu8j+VXePOPI0yM2ja9lVHHlGWD5lRvUP9dM8pwNiJcKV9pD6sNGiLvae9h+hE4t8iSEPFsob7yp9Y0xfB6yFP2lUDqHTNyp05atzUBPGaSoj3F4xspW8HPEBSaRxw6AXxEOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlp/c0C5HSwByaxr9R5AfSUsJXaWDOFI528h/prwZyk=;
 b=KtrzkEprDLArphnT+uGlKgonsmffLfVo8EvLi8/oPvCn1i7yPl388hD2sHDHupJ4ZGNnAWP1MQ1JFoJF7y9LB6fG/GrwZ7+fW3J5o8ldHBMNjVkGPdinCppC0lzmET3bDv3IyYGPqB3S6g99P+E0lkpLub5gwcjYDdO/YCGGvZds0ihMSN9zBGIiub70kHyUkx5Z43Wosncfgg+CdEGahG6S8TYjSySpx95+oqBFkvRARDCKuTq1gWhNlEBHkXgXSyuCmDaISh7ZyDcJHQOtEkrdGwrgd0YySGRxS7l1zeLBPGjwbIDBiCP+CTkgmDrloB1Hr2oD5pIsPxjsvPVn8A==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 10:48:47 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 10:48:47 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 4/6] git-p4: Decode byte strings before printing
Thread-Topic: [PATCH 4/6] git-p4: Decode byte strings before printing
Thread-Index: AQHX7TjegWc0xX/84E+r8GjK3oN8BKwqwwUggAClq4CAACLYkA==
Date:   Fri, 10 Dec 2021 10:48:46 +0000
Message-ID: <BN8PR12MB3361E7641EE4796C80220CF9C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <20211209201029.136886-5-jholdsworth@nvidia.com> <xmqqczm5o0pa.fsf@gitster.g>
 <20211210084021.k4pzkckrmocoqfgg@fs>
In-Reply-To: <20211210084021.k4pzkckrmocoqfgg@fs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f76a738-563c-4915-7459-08d9bbcaa4ae
x-ms-traffictypediagnostic: BN8PR12MB3363:EE_
x-microsoft-antispam-prvs: <BN8PR12MB33635434117C92A05D2A6451C8719@BN8PR12MB3363.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kuauu2docGjxy2wkJlXVs/WXoyqOlP1efVD65tD7tEa1d/ScvxOhsdIs1CX+rAq2ToL+UfiOb8W3VHhuVfzGD2l5P3IvAc2pGSeFcMqOgiXrNvIO/ToVI8/xVzlO7XVRHRUBdD/TToV1VvuEIzXvG3u1qz1GT0yg2DPeguCjWKPpmo1k6if7Jxl17Ufak+N0P1bzDaAebDv/WnMsa6MMaMbtMVUTvjq+3gAtt5MNBUDNAFcev/wtg3pm3mVesCv1+SDAW6uKW2z6RhKGZx+SZYTir1aXcWZi6EHF+veB4McNcOxhv+vuc4hX4CC/+lBinErv25DbsL5VumcM+EKs9g1RbKs3ajC1Xz1yyN+Sb6fYSFtxAhcQLFnVG31NCCHdMzysA0TzOGwA404+Z9l02lVMC5Q+51tYOut1uHwG21w3Ct1Qdm0iXzRHjBQcXI74Y5RMUz1sW4ICz5sOo9zIErk0F2gbegm1BlZ+mRcNWi7runKg5u1dwuwZi48H0tFSH2CxCMu+DesY6EAJH24ZbEI+wjMnnZtJNIdsGdAXl30aDR7bCbk7dVtuCHFmGqaJftspMJ0AvsJPiW8apdA1Ea/H9qD6uNEv8xUr8wclmUun69LmyQu0z6yfZx7LjWfllFVsQOck8ibyHI83wMXVDH/hWMkRthYXnyqc5K7W5HZB+Fp0Y/+uIme+megK5aTQELywD0odnh1AEod/riLmuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(316002)(2906002)(7696005)(4326008)(55236004)(9686003)(86362001)(76116006)(122000001)(66476007)(64756008)(71200400001)(66556008)(66446008)(66946007)(110136005)(52536014)(508600001)(55016003)(8676002)(186003)(26005)(5660300002)(8936002)(38100700002)(38070700005)(4744005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmE2RnFIVkVhaFM0K1BZbDBTTVcvSk5oVFdSeVNHTUZ5ZEVxOXRlL1JmcEtD?=
 =?utf-8?B?cFFWVkdubXozeEd2YW85Qno3OWc0bXl5NDBYVVBwVFVxaVhaSXFSNlVYR2Y3?=
 =?utf-8?B?ZytSUlFlVkVSNXNwY2Y1YzJWSFkwQkt1d0oxaDVjaUVEUFF3eW5KdjJrWnpJ?=
 =?utf-8?B?RGdQYUhqOW03a0cxaXVRRW1KWWtPQTQ4d0ZGRTExSFJwZXRSRjAzTUR6bHlB?=
 =?utf-8?B?a05WMFJ5aUFHSnNncDZGN09WL0ZnQzU4K2lpOXBSRW9uSjh5dUhnY25sTlZr?=
 =?utf-8?B?RnY4a3Roc0hpc3dsbVhkVTNvc0ZvdUk4SUp5THB2RHpzSHliSjVXRzZVWHQw?=
 =?utf-8?B?NWFkc0tTYUVocVZScFpZaS8wL1liSXF6bWpqWHhIaENNVGxPMllKVWRYeHhQ?=
 =?utf-8?B?d3FCWHYyc3habDJlUUV1c0xJakNlTkFQSXZLayt6SVZVL0xKaWUxYzl0cy9V?=
 =?utf-8?B?OUFFYU4wbzNrL01Pc2ZIay9pRXJBYWxGRXlOaWFidnlPTmVtckhXT250eWRB?=
 =?utf-8?B?djF5aENCUHVIbkwvSCtHVENxWGdHblg1ck8rYVlmQ211cTQ0UlRMc2VPTHl3?=
 =?utf-8?B?T2ZnMGpSVkhHZkhCVXF4S0lFeDZCeFJ1Z1pjcy96b0s3VUZsTnBaeVBYYmF6?=
 =?utf-8?B?YUZRMi9IbUFhWlNPZnFodlNGaUNkb240SUF5V0JvY3hnNldiTXlCTldwM2FI?=
 =?utf-8?B?YnEwM0NEZFJiVWJ2eWVUYU5oTktneGVYS29EOXdhZGlHdlMzR0pBQmIwRXZC?=
 =?utf-8?B?YWQvK1RlUVNJYU81clJwT05Wc01ESHNsck1uU1E1QllaZjVsT0lFLy85SG5k?=
 =?utf-8?B?aGpoZWZMK0RwYktvTmtnUnEzaHZUVWNVMER6eCtHbGcvM1Q5THNyWjM2WkpW?=
 =?utf-8?B?OTQ2RldGSElSTGVXQTZsT0duRFFwbzNYdUNNek0yVGtvekxwWVoxU1c3T0Y3?=
 =?utf-8?B?b0RqU0wyQVM5bmZRUzVVN3c1Sjh0eXdqd0NnaWtlOEpyUEo2TFJ2TlpFQUxS?=
 =?utf-8?B?U09yV2U4T2ZpWGMwck1iM3BLTnNDZm5JL1JzZzg1SGxuTkpXRHhWbUdwSDVT?=
 =?utf-8?B?VzJFQndLL3ExQUpmcHFUZHNBVWlwZHpoU2lDWk1lbjFRN1NTd2c0dWF0QWRa?=
 =?utf-8?B?dkpJeitaQXJFTTNka0xJVFV1ajVQdUJSQlB4RUU3elcraFk2M0tqVkYwRGdU?=
 =?utf-8?B?QUt3OXY4eDZqbzBDckNZQW9EcktiYnIxbDE1WTNOZC9lN0pObmZYOHJoNGNk?=
 =?utf-8?B?d3I3dWRGK2F0dDBhV2RiZnNaSC9EWCtSMXVCTlJYemN3NU94VzR4TEE5Z0dv?=
 =?utf-8?B?Y29xYkdyc0ZWaFZhemI2UFpjYW5kNTVlUVZERDZoR0ZPeVhXczE4VFRoSWJY?=
 =?utf-8?B?VUV6MVhVZnpLTFRGWjRxVXdCR0lwUWovZW1SU3VzL2hzVE5aK0N2YlZwOERs?=
 =?utf-8?B?bHQ5amZCZ3FmNzBjaDh6b1hXbCtETld2NTYxa3pjSk5YZFJGWnZHOVcrK2NH?=
 =?utf-8?B?N0VDUmxhOUlrclpBMkpiVGlEcUlXR1p4RWVBRktkUjJoR09VRmdZdTZJTGty?=
 =?utf-8?B?SXpQM2UrOTIyOUp5OW5JMEY3bm5nT2VFL0FLeFVpTGZycTd3KzVWdTNub3F4?=
 =?utf-8?B?MmdkTnY4T3Z5Tm5GK1J1UFV3N0JROWdSeTE3c1VVSTRVelFTQUNtVGFNcUlm?=
 =?utf-8?B?V3VWVkxGRXFLcW5WS2FjWVhoTzdESW9veHJtTHlNTHhpazBPbHU3MGl3bkti?=
 =?utf-8?B?Rnk0c2VUZHBnOWwwTHJMaTJIVDZha3VxRTNXMVdHOE4reWdTY0JOQ0xkSlVL?=
 =?utf-8?B?ejI4elIxSGVWYi9XdzhZblVlc1FXVExNMGY5SnlpSDc1dTNWV3Rad20xQXhE?=
 =?utf-8?B?WTJBeWlPTUljY3hYRXRyN1NNOHRTVmpaVUF3a0hqYmtQYmJweUFzWnBrc3dt?=
 =?utf-8?B?SVNyZ0k0M1FlaE93a1pnRzdQUjlzRTAxK20xK1JpTnEzbnkxUGFYc2Nxck8r?=
 =?utf-8?B?Wm9OcE4yRVpCbDJTS1RqQXlQaXoxMmpqcm9RVzZ0REN2aTVscHE0S3NPL0c1?=
 =?utf-8?B?ejk0cFlYVTl0UGg1cUcwQkVzeFMwUk1qNWVpRzh5WW1sZUVLWS9QSXUzMHBz?=
 =?utf-8?B?cXVEY3Q0c2FVMjZ3ajlKaERhQm5ReWpxL29vT0dhVGQ5VnBHYXlZRlZ4Tzkr?=
 =?utf-8?Q?DMXG0rd6C7YJf7l4QVU8uZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f76a738-563c-4915-7459-08d9bbcaa4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:48:46.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMg7UBdPGFEJWAmj66rlKm2GPMc938E+48BxSJHXN3nkiOdNnUCAm9b0vQM1i4QbPkyp0P7+ASSvn+vRLNqHGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJZiB0aGUgbmV3IG1pbmltdW0gcHl0aG9uIHZlcnNpb24gd2lsbCBiZSAzLjYgb3IgYWJvdmUg
SSdkIHZvdGUgZm9yIHVzaW5nIGYtDQo+IFN0cmluZ3MgaW5zdGVhZCBvZiAuZm9ybWF0KCkgd2hp
Y2ggSSB0aGluayBhcmUgbW9yZSByZWFkYWJsZSBhbmQgYXJlIGFsc28NCj4gc3VwcG9zZWQgdG8g
YmUgZmFzdGVyLg0KDQpUaW1lIHBhc3NlcyBzbyBmYXN0IC0gSSB3b3VsZCBwcmVmZXIgdG8gdXNl
IGYtc3RyaW5ncywgYnV0IEkgZGlkbid0IHJlYWxpc2UgdGhhdCB0aGV5IHdlcmUgdW5pdmVyc2Fs
bHkgYXZhaWxhYmxlIHlldC4gVGhleSdyZSBzdGlsbCBhICJuZXcgdGhpbmciIGFzIGZhciBhcyBJ
J20gY29uY2VybmVkLg0KDQpJIHdvdWxkIHByZWZlciBmLXN0cmluZ3MsIEkganVzdCB1c2VkIHRo
ZSBzdHIuZm9ybWF0KCkgbWV0aG9kIGFzIGEgbWlkZGxlLWdyb3VuZC4NCg0KPiBTbzoNCj4gc3lz
LnN0ZG91dC53cml0ZShmJ1xye2ZpbGVfcGF0aH0gLS0+IHtyZWxfcGF0aH0gKHtzaXplLzEwMjQv
MTAyNH0gTUIpXG4nKQ0KDQpCeSB0aGUgd2F5LCBJIGhhdmUgYSBwYXRjaCBjb21pbmcgc29vbiB0
aGF0IGNhbiBwcmludCB0aGUgc2l6ZSBpbiBodW1hbiByZWFkYWJsZSB1bml0czogYiwga2IsIE1i
LCBHYiBldGMuIHJhdGhlciB0aGFuIGFsd2F5cyBjb252ZXJ0aW5nIGl0IHRvIE1iLg0KDQo=
