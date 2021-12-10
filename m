Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036BAC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhLJKzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:55:31 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:42336
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236819AbhLJKzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:55:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpAti3KKw25B9gHTdAPWHXjhUJu08c5oamHXL9QH6Fi7Ykz+r9RoMsvo9moNUlJKXTfVbT5BjGS2gbRZBdBRyRY7H6Gs05/lPDmXa6ww6M7BVSMFXJmj7Fayzq50GG+icsAm/Fv1DnPC8lxZVtcDYVZRACHJ0XBmnbh349P3kiSmiG36pn15xN00+xrT5T5uoWGwym8vu5AVX7VRy4a1chcjeNB86PqHriPM2y8pa73hgz3tx8AfQKc9dPn5uvLjW0KSxTECpAknaNafks6XiZc7AX5OysUPDcjurMbrYfLpmJCoM0Yx966Pv30i7yzkwvHY8r733Jn/MMtftGVvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82q9Hj7nSHMPS2eukkfjwnD7rv90cjgXSeqtFRQM7oE=;
 b=jeN6j8lxrh6S7N4iCvo/v3nrHSwHbNrFgvLcfRnwp+2amslUt6U9RaGRxwKIbyJRcZEEAcOjWA3pyqeyguvmmnSGHIn+RbQHKAwTgHsRPkmcAhy5eIgdJd72140Al7O6aExr2r0VEwDAkQtgHEsHWRcggaZhlyqqAU+ko4nt35OptweKQnQHpF2l8UE0URfoQ3euNl+FQwGlCz/zXhOUOXsx3GTJViR8pYkVzHw3wuvlnlKU+xekJ2ubguT02bS4LL84ovHqjaM/nGdg4Ga5Ib6ZJZuGTwClUU0MXEreCQGXkfPilqglA0bjTacSIfN0whhZAy9fTgCqoz72u2WqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82q9Hj7nSHMPS2eukkfjwnD7rv90cjgXSeqtFRQM7oE=;
 b=Cen6TTLsrxYT92NAuzKPrqf6JBlHJnQsA/5t1lqQr8N7bSp7qtp2xNu0lKqbpf8xqAvL3k0GM4b4/BSkjLdkYx0rY2d49abiMLQZptusMey/MaXYATgfiBCUiv36SBYyNVv/EkSODzu0GJqIz2z8IFKqaKPACGd4mSepqDdD8Yum4UxLvxLLmniX+7ee8tWpjy7xIK3Iwz95lvogdo36edsvFn9N69B1SGWe0SveToiZiHAzED4WO9a3HVi/wNLJ3M1HkaJ+0N+6E+uOOrKLhWzwkmchQFzJFRi8jqKCv4WQnODsP32WCk7F9gnbiKm2d0slmD8sT3AsvRXfCdxdIA==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 10:51:54 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 10:51:53 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Luke Diamand <luke@diamand.org>
CC:     Git Users <git@vger.kernel.org>
Subject: RE: [PATCH 6/6] git-p4: Resolve RCS keywords in binary
Thread-Topic: [PATCH 6/6] git-p4: Resolve RCS keywords in binary
Thread-Index: AQHX7TjfDMPjJGZJVU2bdCTDF9bZrqwrXNgAgAAvzcA=
Date:   Fri, 10 Dec 2021 10:51:53 +0000
Message-ID: <BN8PR12MB33611BD4A606919F343F0639C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <20211209201029.136886-7-jholdsworth@nvidia.com>
 <CAE5ih7_gvbOwvoO4deqDm_8Nk9XWzrdHGHEsgdiEb7+7YxtGwg@mail.gmail.com>
In-Reply-To: <CAE5ih7_gvbOwvoO4deqDm_8Nk9XWzrdHGHEsgdiEb7+7YxtGwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b99156c-e96d-47f5-9b7a-08d9bbcb1414
x-ms-traffictypediagnostic: BN8PR12MB3363:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3363882BF4BCC273926EF294C8719@BN8PR12MB3363.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiKvvm9nVtGK2e4AZSKljwoSUcrmzaLMUfcYh43TIqkjhGoeOaFr8tKC2IwHSKSEQy+uHnTHVX9/S8vcgPi4dIOLMh32foMbUVKGZC2f6wjyH2Pk1Y/Hs/7zxrZQf7sQqfUHS53mhQddfl6psyuNlga707TJkzb8qymy1/dNG+wMLJ1D+fbgDf53XE2v1qU1WdPkQZg0+XWq5f+p3D8ObA2itIdSAk4pSxwJivdpma/XjM5ANVUkUpH9OeFy3TKeRIQvdhV/9Zmol7I1IMbnLk6odAb42PazQ2i4kz+ygNADMVPHhKT+iiF2w0n1MH7GbdN0KUVRU/E+0R4X0kxel9UnF2rdTNtO5d3FkizFUgdveGrgqVgrWle4gNjzerJKpdwq8lsC3YY9Q0NYpwQVPxjjtkr8mSQv5bFwTXIJnPlF52uGCnJJzIqBibzssf3XJdhHYfZn1CSEnxqqq/NSq9O0+jaWJ9EvB+wrkosf4RLbr581+mgfoIZMoRuerFtQzAn6bjk2YEF5m8IA4CNz64bh17r56fCZWrTaJR6kZEQSjUfIS7q4MvkT7DH7ZDV8n6WXTFwl6i02ZhTahRJY2RLdLtUnXqnxOq23fkmcYF73VzXppK3uc4P2nYnGh2Dnyj1CpH4hyXvnPYlhfZ9HsfPeA6T15i7ubPatbvyOhkkLBbWxJ/1Yy5zaQ+izYBudJC3hnMIP0bYP2RYfLAJ4cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(316002)(2906002)(7696005)(4326008)(55236004)(9686003)(6916009)(86362001)(76116006)(122000001)(66476007)(64756008)(71200400001)(66556008)(66446008)(66946007)(52536014)(508600001)(83380400001)(55016003)(8676002)(186003)(26005)(5660300002)(8936002)(38100700002)(38070700005)(4744005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1RUU3c1R1RUQ3ZiNEE1Q2k5UkNhVjh2VEMyRDZ4R1hmWE92UFB3ckdyaXBl?=
 =?utf-8?B?dkkxR1R1Rk5ONEhId2dTL0E2N1VmMENYeUVXc0RmemJldUV0Rzg5ZTFPMmE3?=
 =?utf-8?B?UWJha0dXc1Rwa21KUEsvWjVadWxVWXRUc29maGRiNTdObS9xZDBXelV1cWtq?=
 =?utf-8?B?cHZCbU5lRVhDTlJsNEJxQ3JzMUM4VTluYlE5RktLZGlTSXBxWnYyQSttQXZ0?=
 =?utf-8?B?MFZzNWR6cXhRUjFnUSt5ZG8wNVlIbGIyZm9sdDhwM1hJWktRcEdQZW8vWmtL?=
 =?utf-8?B?ZklnWWdPN2lPWEhGWDJlTVlyWEZDdjM2Y3BXZWdvdUladlFXNTFMSFQ5SlVL?=
 =?utf-8?B?OHY4bCtzbTNQaHJ1aGhWUWRHSGdsdjRwRUxFeGRudVB2M2ZEQndyYjF5NG9l?=
 =?utf-8?B?dEJ4RzhHN3kvOWQvM1pwL1l5dlBLQ1AxYWRBc2x3Q2lKamJ3WlNmQjk5VTB0?=
 =?utf-8?B?UnEwTE5UOFVoWmdIcnYybGV4dFdCeEtMS01iU1dSdzFKY3dQVEt3MDMzeW45?=
 =?utf-8?B?ZFV5NWE5WjlPZEhQOFFMakZXMUYyVHdPSENrR2gvOFdKeVRvdER2SmhTNUox?=
 =?utf-8?B?MCtvM3oxTDJ6MzFaQVRmd2ZJWmdWLzY5bEhTK3c5c3ZSVkNad3FlblROV3Nk?=
 =?utf-8?B?UGM4ekZEUzlJSDVOWmNuQmU0blVlNzY2dFJWbjRacllLVWxNcDlGTmFQTy94?=
 =?utf-8?B?M3ZzUmRXWnY1NUFzODU3R2x0STNiVWM0Wm9pTVpJMnNuSmFIbkR4ZEhrM01o?=
 =?utf-8?B?Nlp5MHZlN0ZBWkZPcDBQVnNabml2YmJJUldRa29vRVFaeDRSTDhIdm5xR05u?=
 =?utf-8?B?bzQ1MlNoQ2dMNkJMclFsbTFGQlgraDVCc05jYjNmcHViNVFlZ1dOankrVnRM?=
 =?utf-8?B?ZnhkYzFYODFLOWFBVHVGNUtsd283TXcveDMxcDR6eG4wcFVXeVA5YUJUZFJn?=
 =?utf-8?B?TTZYRk45T1hKWnJ2QXNpenNCK1hrSDJVWGZiL0QwaXlKajRNNE5TbmdKQ3dB?=
 =?utf-8?B?cGVvc2p2UW1Xd3IwbitTNkFrYm5DTjk3SUFUVFB6Y0U3K2ltV0hDZUlJRTNZ?=
 =?utf-8?B?czZOditSMmU4WWxNcVEzSmJpRjAzalFZeDcvcGJaT2p2bWk5c05tOHNDcWh4?=
 =?utf-8?B?VGI3djB1SFpuMjJkZG1tK1c4aVlQdzQ5THpBdWFxeXUwc3B3ejNrbTV0L3N6?=
 =?utf-8?B?c05CWWNoR0MxTnY1YzVLSXUyNkQybk5Hai9jYWVFcE9xU3E4OWVtSDlzdlU2?=
 =?utf-8?B?OC81QnkyM2xzK290TXVIcU5UcXpxNUZibDM5YURpSTRYYmdDb2xWMG5CbG0z?=
 =?utf-8?B?aGo1TElhYWcyeVBMNm5mNjR3RkNuMHhpRm1YMGdadm12UnFwdTNWN2U1aEtW?=
 =?utf-8?B?dkphdWp3Q3BlOFZqVlpBSVdCTTF3Sjg2UUR2UEJKS1FDZlRveEVGdzdKUnJs?=
 =?utf-8?B?MVFnRzllaVFnL0huOS9MaGRYNGhRa1EyN29MT0dKUjNJQkk2NzFkdWRBdk1t?=
 =?utf-8?B?R2M0Sit0MG00UTZYMWt4aGgzZ24zc04zeVlsVXlxZHZwUlc2YTg5cnBwNlUv?=
 =?utf-8?B?N0VqdENSUE1mTmtrTkNaaTF1Z3JQd2E5bm1jL25oNmpXRTk2c0pXcW84czJh?=
 =?utf-8?B?YTVBd0F4TnlIU29BVFgzUW9tZkh6b2tkNm5hWTdybG8vVk9acVpzaUdHTUtF?=
 =?utf-8?B?VmlRb2VKTUlYc1AyQndXMEM3WGk4M0V3SWJ4MiszY3BDdEpDRHZzV3pnRE1x?=
 =?utf-8?B?azdkZTFGallsMjF2TDI4clRIVHlXTVZZMENaUFdaMkY2MEgyTFVrQWc0bTFW?=
 =?utf-8?B?cml1ZENYUDRGUERlOVR1WHFrQ2hvUCt0Y0c4MzlWMy9oM3djUHVPbDBxeG90?=
 =?utf-8?B?d2FHVzBpTDh4YXdzajlzdlcyRHBkUkNqS0hQY29YaEsyYnMwNlpZMGtMVkQv?=
 =?utf-8?B?cnVnSkhHK25NRE5SQWxHMzVFaVlUTEtxNVZOaDBic25YY3l3bWljZ3A5TGdN?=
 =?utf-8?B?MWI4ektBcUFnVlNnNnVoMFdnSUtCdllFdHZXaGgvN2ZPekRySVRYWWZVUWdE?=
 =?utf-8?B?a1FyenhZZXRCSWtweE1OMGV3RmR0TG82SlZFTXgyU2ZJeFlPeXdyZnp2TlVM?=
 =?utf-8?B?YWEyZzhuR1d2d3cxeWNLQUdHSFcvTjBPeG4wVTA5YWpMMldFYys1dW1SQnNS?=
 =?utf-8?Q?+K525b02Fl4kWU0qPp7ZAfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b99156c-e96d-47f5-9b7a-08d9bbcb1414
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:51:53.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJsvL/Kj/WvKzdni++it5Adn1VlDLbEinNmvFippVkhKN+uKG/gYrFYZ9amx3PY4c8r9ufItu5SP38cXR0+GfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBUaGlzIGNvbW1lbnQgYXBwZWFycyB0byBoYXZlIGJlZW4gc3RyaXBwZWQgb3V0LCBkb2VzIHRo
YXQgbWVhbiB0aGF0IHdlDQo+IG5vdyAqZG8qIHRyeSB0byBkZW1hbmdsZSBrZXl3b3JkcyBvbiB1
dGYxNj8NCg0KR29vZCBwb2ludC4gSSBndWVzcyB0aGUgY29tbWVudCBzaG91bGQgc3RheS4NCg0K
VGhvdWdoIHJlYWxseS4uLiBJJ20gbm90IHN1cmUgd2hhdCB3ZSBzaG91bGQgZG8gd2l0aCB1dGYx
NiBmaWxlcy4gQ3VycmVudGx5IHRoZSBSQ1Mga2V5d29yZHMganVzdCB3b24ndCBiZSByZXNvbHZl
ZCwgd2l0aCBubyB3YXJuaW5nIGZvciB0aGUgdXNlciEgSSBndWVzcyB3ZSBjb3VsZCByZXNvbHZl
IHRoZW0sIGlmIHdlIGhhZCBhIHJlbGlhYmxlIHdheSBvZiBkZXRlY3RpbmcgVVRGLTE2Pw0K
