Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB2C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhLJKsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:48:09 -0500
Received: from mail-dm3nam07on2054.outbound.protection.outlook.com ([40.107.95.54]:15494
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232936AbhLJKsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:48:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnC6VlkuH6iT11TRw5nEzPMOs8L9c9jREJhov1HJWWwSLqXL3qHpxGiImbOVKN/A5XdOLxbpaJRSB56a/b8Zl0n87VEjATvO8ufMuQsS49gssWO1FsTPxwVyunkgOI8IbXnLwBy1uBDImpBhALBFv0CBJnpTlywSGheHp5utACdVUClspgiRVu+6a8RpDVlzJXVgPaEQA/OZUFjc6R0Vr+uQuIcSrE4Pupm/844dE9iSER2eYiVpEEZrk/FywRs2bjODOY7QfmhWfBdzn+uNdyYEORd+nCyUfdPlZ3rEzqynVfAF2sMTqNkZkpEi8DUVUgTEj1z/fpRqhnlqdb7Aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jnu9uArXVBOKHvA55vZKCTFbqhARdQgx+wyMhzXH78=;
 b=FZ5ezhPTRTkhXyGBxZGQQ8zxFzCOyDhFdC9xwr6Mgn7B+IiXW/STLEWJiuIEsHBAMmnFFLvmt2fI0uCxkXK+eGDvISj7N5MYfcuZ8QzcTDeV5Fif2oVAoR/LXyAjgL0O8UzJmsQ6Cc9lJVIgCNystTeQazonpiihJF1e/uAOysmb76qCxQZ1cZDBpTMAlim42jHEULHO+JA6ij+VGK2Dk8kp4eMEdpYLujtxFAuArmeCY7tdGIrbnsIUcBWxPvvkH6Xwq3+0VG2tkl2xW8yeTcaQvTgL2+PRwy9dqogmlq9wDx0+azlRmQGTO76A5BuZuQ4/5ecNgPW35Ji8390Ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jnu9uArXVBOKHvA55vZKCTFbqhARdQgx+wyMhzXH78=;
 b=ru3YpjqVsdBzhSl+o0OjgGuXAGo2IuBbCrfSd/6aUJI5pn5alhaSJTsn6kvjzgToywHJ1MrC8QLrKocUriCISFR1vBZzLPQwGP5mRaQNFroLLQ5OqEuFl6bPUyPkaURGVMR66zTpD2YKy87kGh0zd5zf84NXELmK5SFDcg6GNbFGDe38MhObddb50Eb6E5f7r8X9Aj1d9Ln10i+yuCxneGqHLvcg4/izFwNq4uAxRpu/Rx3jCn0y1zCOyRXRKiNYGcC0nMz9cjzjQhQlRKXqZKBKLK9Bdp+JAXN/aOlgfc2gg+ciSPFvYJr/KLnjJVQYUFmIdLl9Zew1r6KjCa/Y0A==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1699.namprd12.prod.outlook.com (2603:10b6:404:ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 10:44:32 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 10:44:32 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     David Aguilar <davvid@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH 3/6] git-p4: Removed support for Python 2
Thread-Topic: [PATCH 3/6] git-p4: Removed support for Python 2
Thread-Index: AQHX7Tjdo68TbvplVkyvI+Bf9lbevKwrENaAgAB6IqA=
Date:   Fri, 10 Dec 2021 10:44:31 +0000
Message-ID: <BN8PR12MB33615F9CF2F6838507A06C46C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <20211209201029.136886-4-jholdsworth@nvidia.com>
 <CAJDDKr5N-2WUaspsyciq3WW+pMW--Mjiu5+3F_gOmHYENAkCUA@mail.gmail.com>
In-Reply-To: <CAJDDKr5N-2WUaspsyciq3WW+pMW--Mjiu5+3F_gOmHYENAkCUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d4d6fd5-193d-4c9f-fa10-08d9bbca0cb0
x-ms-traffictypediagnostic: BN6PR12MB1699:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1699075BE2383F1A23BFB7F4C8719@BN6PR12MB1699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpobnnlnRHq3fVTKNNeY0J4TC7iMWmGc4uqbQuDWCJFvQn/ZWo+yNTIsc0WtMokC8xL6nsasCT/giawwLHC8LvxuzWzQuOCw6NYwm0kIQjBw+HDJe4VHUs4aPZYM076iPXT5HxkzjvrngBfcVHfL6Md3NJU9/YXtigUzBK5qTgweYae/DANT9RLDE1TUNx8koFa0LRGq4wEDIIrz/bw0EneiMErVoJYgRe6QCfATMVv6JTfsf8bfs6wnY6mHu7uUVr7YdpUHgN6H3mujwz5zL7Ib4Sl9Zld776AuySnRo8mpm9dxueap9hh8UW3XCF7IPK3sYUDXc92P8YkRVH95Gp4sIJ8TmCik9IVr8cVoRT5BmlT4382UiY2cmAT3sRG2cjGrAgt3JO74xZAvVv0U8dkMV4pSr8TpNB5RnevO6Rgl2zoqx5l5hAWncLrBMLs/hh/ISeApnOQo8gOPLInaTuXFibunvi8sNW5R6501w516uRn9epwILX1upnBZN5rWS5h2WEidmV8wlkomo4p8L5cj47iJYmuyYq282CzG/8trkT6pIGkuMDXifnMwl19+655cXBumlCJ9ohT9cDtaCJKm6EEL3tr2Pp9Bd0ed+8j6ajyWSP36tomFDxgrmGIjwdFH+RUX8ZKn8MP2XdcBxXSzcgR3LtXHpVL4nLgzc1qX1YqoYGWzXl2hRfYCzJrfwp8F/6J6YEQxmRpxw2xuBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(9686003)(86362001)(6916009)(2906002)(66446008)(64756008)(66946007)(52536014)(76116006)(38070700005)(6506007)(66556008)(55236004)(55016003)(66476007)(508600001)(5660300002)(316002)(71200400001)(122000001)(4326008)(33656002)(38100700002)(26005)(4744005)(186003)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2JjWlBtRmp4NG1OUlZOcnNQaitHVUl0TFBIbGlURFVaWTErMkJDWEpkaU1F?=
 =?utf-8?B?bFd4bDVuTVd5MVkyWElKYXNLUWJDRHlXbDhjLy9oUDV5eFVETnJ6UGFqcjVa?=
 =?utf-8?B?eFlQSkxzelZUd05QemgzUWQ0TGxSclV2MXJWbzhSUUgwT0psLzdWTW5YTG5l?=
 =?utf-8?B?UVZ1NlZ4c2JaMTdZMTI2SXdOWllFMnJEaVN0ZDBTMTBJMThvODBPSXZRd3ZV?=
 =?utf-8?B?bFZMaTFmdVlwNXFPTUdUUWRYTktqaEFDYlFNMmt0Zy83dHF1eUpUQ01zdTU1?=
 =?utf-8?B?bEZuZk00M2gzNTh1ODcramk5MzVqUDhiRDYvcWE1cCtGQXZmMnIyWVN5SUJY?=
 =?utf-8?B?WVVXMVJwTzQzY0UzZU9mTk55a2ZsQ2lqdTNyL1pLRDAwT1JzcUlmQzYvWWJH?=
 =?utf-8?B?dTVxTTI4bE9rMVR5dlVQUmE3cGF5NU1NTG94L2wrZ0RNVUdGcGl1MzdoeTBn?=
 =?utf-8?B?ckxhMmpPaWlWZ1lTeEc1Wm81NU5mNHFEMWdPMVRncWJNMHdEWHlkWFZzdmdI?=
 =?utf-8?B?RFBGN0xwNFlNMHhxVGkrSXdZNTk3blB0cWtlM0RvdGZxWXFLR3E1bVhiTzQ3?=
 =?utf-8?B?NmlwazdBTUdHc29pTTVQMGZldmhmNVhqemVBN1VGR0xvZGNJb2JFRzNMQkFZ?=
 =?utf-8?B?Sm5Lc1BFczlTU0lFeFNzcGZUZFAyNzl1V3hwTy9wcXlybVpicU1GaHlwWkcy?=
 =?utf-8?B?SnRsckNWYzBlV2JtV29LU21NWWJPZmNvNFFoeGlUQkxaaFBaVHpTTVVPRUZq?=
 =?utf-8?B?T0ZLMjZFVVMyVTFoNXliNFZ0Lzc5TmM3cjByR25PblVxekdXMU9jb0tQR2Za?=
 =?utf-8?B?ZkhoOWdjWUZqMWUvOWQzTHlGT0VXZVBiMU5iUWpwN0RBOUp6VWVLUlQrNitw?=
 =?utf-8?B?SlZXaUNvVFBTaVUrUW1kZXdPNW04cHM0enBlOWhuOE9JOG1KbmdJTjB6TWlJ?=
 =?utf-8?B?cU1pRDRFNjZxd0VBVnhkVjFIK3IwMVBmY3NMNi9DVlQ4QzVUT25BODd0S3ZB?=
 =?utf-8?B?SStDejUyeXZEZjRTQTdSc1hiSEZrbkdwWUZDeUdkN1pab3phcHNUQW9lRHJX?=
 =?utf-8?B?T1pERzRTMWtYa0Y0UzVORXlYL3dUSW5vUDlnVGx4NzVac1drV0xsWlFjZHhx?=
 =?utf-8?B?T0MrNnIxT1MzRFM3anVLdEJvRzJUMEsyYUN2TnQrTEpROVgrQUQyL1k5eXlV?=
 =?utf-8?B?Skc2RzdvNDJPampPMHhhK1Y0RzNaTXNiVEN0bVpLU0R4c0RZZTQxK28xczE5?=
 =?utf-8?B?OWFzb1dYZmVYS3FkQ3dDZnFVbXBLVG5DQXVXVHFQeThHTThVQ2VkaGp3V296?=
 =?utf-8?B?Mk9oSGtqVExnRVFxWHdOOWdhd3NSMGVuN3Z0OXRVYVhxSnk5NlYwcmJzbkFC?=
 =?utf-8?B?aFZkMUt1RytzK0NJRTNodDZNb0RuTHpHOUp3MW1ra3FlaUR1aldZR1Vrb1A2?=
 =?utf-8?B?WGxVQW5rbjNsUnRuUkxhZjJ2NGFZbDRXZXU0LzQxbElXeGhwekF0T3hXUHJ5?=
 =?utf-8?B?SmZjTEsvWkJBTjVhT0x0MS9JNHZYTWdDUG8wL0g0cTQyYjNuQmRjbGJmUGhh?=
 =?utf-8?B?VDUwd3B5dDNtYnlDTm1yV01zcGo4TjFzeGxYdTF5RzdvcmZkdkJiSGNyUU9S?=
 =?utf-8?B?VzM0VkhiODVDM2V4N0VFQ1ViMG5CUWIxdTV5RE5mc1JGQkh1R2ZLR2J3Nmpp?=
 =?utf-8?B?L0xGdmpUMVlCeVVVNkNGSnVSNzVBSDZxMDRiYnJ1eWpBUzhPY1Z5VW1RN1dp?=
 =?utf-8?B?OWRNb0UxV3o1NUNJUUtYNzNaUDZyUk9JejRaM3NhTWdveXZtMHZmcmdnZEpM?=
 =?utf-8?B?ODEzTXdVckJsMVJYSzRpM1lqWHUvQTFldE42MXdTcFY5SE54Zko3djlQVWJo?=
 =?utf-8?B?emxRbVg3TEY1bmJYeG1rUU5vWVFFTUs5bml5NHU1UzNFUVVnc0IvMHlCWG1v?=
 =?utf-8?B?NEtJYmc1SE1uTEwxWU9ybTQ1Z3hjalV3ZjYrNEdhdXA2UUZHNUhxeEN1b0hv?=
 =?utf-8?B?NkRtbjhlVFpUcnFsRmlDbVVXTkxNT1lKV3N1ZXlxcW1IaEQ4aDM0ZFJYN3Vh?=
 =?utf-8?B?TkNoc0hEdTl0bC9nL3V1UjlpLzhUSjRLeTdIb3huSkZWRlBzdytmYzA0T0Jw?=
 =?utf-8?B?SERHM3Nsa0ZCRW9TNlM2dmxnelJpeUtmTGxzRU1UTHJHbFRBeWdubURpR2pO?=
 =?utf-8?Q?H5QRR82hV9Ow8GrhTSfuI4Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4d6fd5-193d-4c9f-fa10-08d9bbca0cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:44:31.9279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8j+ft8LdzaIqphfySyXqZwKSjSTyMUl7ZuSd1+hzemxJ5EnhWBMhX416pHOkhubvDKg+ksebnQJcFiCDPGM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1699
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBUaGVyZSBhcmUgcHJldHR5IGxhcmdlIHVzZXIgYmFzZXMgb24gY2VudG9zL3JoZWwgNys4IHdo
ZXJlIHB5dGhvbjMuNiBpcyB0aGUNCj4gZGVmYXVsdCB2ZXJzaW9uLg0KPiANCj4gSWYgd2UgZG9u
J3QgbmVjZXNzYXJpbHkgcmVxdWlyZSBhbnkgZmVhdHVyZXMgZnJvbSAzLjcgdGhlbiBpdCBtaWdo
dCBiZSB3b3J0aA0KPiBsb3dlcmluZyB0aGlzIGNvbnN0cmFpbnQgdG8gYWxsb3cgMy42IG9yIG1h
eWJlIGV2ZW4gMy40IHRvIG1heGltaXplIHRoZQ0KPiBudW1iZXIgb2YgdXNlcnMgdGhhdCB3b3Vs
ZCBiZW5lZml0Lg0KPiANCj4gSSByZWFsaXplIHRoZXNlIHB5dGhvbiB2ZXJzaW9ucyBhcmUgcmV0
aXJlZCBhY2NvcmRpbmcgdG8gdGhlIHB5dGhvbiBjb3JlDQo+IHRlYW0sIGJ1dCBJIHRlbmQgdG8g
YmUgYSBsaXR0bGUgbW9yZSBzeW1wYXRoZXRpYyB0byB1c2VycyB3aGVuIGl0IGRvZXNuJ3QNCj4g
aGF2ZSBhbnkgaW1wYWN0IG9uIHRoZSBjb2RlLg0KDQpJIGRvbid0IG1pbmQgMy42IC0gSSBkb24n
dCBuZWVkIGFueSBmZWF0dXJlcyBmcm9tIDMuNyBvciBuZXdlci4NCg0KSSBkcmF3IHRoZSBsaW5l
IGF0IFB5dGhvbiAyLCB0aG91Z2guDQo=
