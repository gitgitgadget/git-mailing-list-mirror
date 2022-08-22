Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB0C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiHVSW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiHVSWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:22:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2075.outbound.protection.outlook.com [40.92.58.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB4A474EB
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2geOOHoMP6+dLiTfJWIL258mQK9KLqvNTjvcgN349PqVwFU3VtqQtbxJyqijpYkfrLRDEk5XHd08N7j/fwrZYzjaxgKACwIYnUeurPKsWchzVfzQ7I+gg0pmaEIxrMrGM/D7ALaeLaYrRDSAfbDyDhPhv2rnjS1a0J4DnQr9My5PR4RuinaZg8BD+cRggfVZapkTGGW3++uzDH9kKFzjwLwVdLUWwQXLIB5TDtgdDobKTgSR98tc5G7ge3JZa6XFdyEDG0cKFvimKl4Dq1KLUThojxY2QSHHLzspbij1uqOnMsAbPtb/Xm51CZ/rv43y/Gmp473QHZTrDYkw07UwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWcyXS1ZI87HkA3AfFeUqIfsLa9IoJE2GIwvpcjM0QY=;
 b=gl4yQf/fRKZxFIODy2SoMGBClVIghP3gUJ0qfhBA+Mqe/OY90vPqw+ChVL9+FWk8aneoUSf/eJ+6Oq9eCQbveH3qfHXPPrg0d2BrPq5PDJiIztAx8Vxe5/J3hUQNqQg75V9M1Vw77te/H1YrC4IrlXN/Z3k0akpTySAye9p40I5z1naT4NwmFokRmi1ViWX/5qX9d/e32Ei05yysYEgBXzMmekQg44fzhR63sA5xABA9JLaZSspmE/webfbRx7iQFj2Qr2TINn7KgRTETgNfPeQxfJeJluIGUfOzADhnQl5EiVVip25oEfeH4aymYrN7DoaJ66yERqCw9fdehmiAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWcyXS1ZI87HkA3AfFeUqIfsLa9IoJE2GIwvpcjM0QY=;
 b=mxawAQEfuxOkI4HzxD2WN/BMyOtOMBz8er9jN3oRFzVRAfJF8eZ6WliOklquQDbcHA/TLwirsaX5K9TDv8jlaqzAxHuUOnof1ezPk+1liHU8P4L4eXXlPxabcGzGQ7u5bV6T87it8h6oj4c3p6P/UwZss9YwNZWwZEIlO477aYZU+/Q3qdbd1K8uVgyj7LvTHnF9atwMsoJSxeNOXXCq4ZqnusyMT2dwp4O5NBxkCLP1fQoBzizCeW92LTez6MFljwzrV9t4OjoLrPJgex7wnwYM2IV/E2XcevB2IKUSdQDbmCyOOCuTIrTum9Kr3Uj2lAjYspzFmtWAHfihYMyMLw==
Received: from DU0P195MB1649.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a6::14)
 by AS8P195MB1351.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 18:22:21 +0000
Received: from DU0P195MB1649.EURP195.PROD.OUTLOOK.COM
 ([fe80::1ef:e678:90c4:4c99]) by DU0P195MB1649.EURP195.PROD.OUTLOOK.COM
 ([fe80::1ef:e678:90c4:4c99%9]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 18:22:21 +0000
From:   Mohamed Akram <mohd.akram@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git diff prints long usage help if not run in git repo
Thread-Topic: git diff prints long usage help if not run in git repo
Thread-Index: AQHYtlQe/w12+TWEfUmVm4ACzJoE6w==
Date:   Mon, 22 Aug 2022 18:22:21 +0000
Message-ID: <A2326287-9808-4479-95C5-E54979E21F95@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NdtsNzt6IAs2/Gn4YrjG/MOxGwnWzByYwRXW7adOr4wLFKlqWvaqNo4FcpiUvTjv]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bead969f-5bd6-4da6-2f5e-08da846b414b
x-ms-traffictypediagnostic: AS8P195MB1351:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lk5zzqsMZ3iN3L4w1szkcYGLxUordQrsty4uBVk/X715uGzb8J/TFcgYxr7wu7+UbeR/mZsAuQBHLaRRuOFnGzq+QuWgteLPnzesgW033m3x893WlXjQAooY/MpvZr9QgUyMkomD9M3IHDwduJVuGAJaFxlJ9nfFy727rJNmCriLpZbKUO59DKVFI0cClAUhzJCJkl6leT7cvL6pK6MmDBSQJPerKBXhUfWnZ7/lO9c5R8//1Al3c+KEA5VRhy5XAGQ/K/IWhTgj5wkHVxCnCkBom7JiHpof+y1ur6M0KqZPACD97HkcOnPQG7bssmyQeorOMRoF9qzyArcBe109z6CF2IcrEllRSpl2q2j4xSXiTvGeUbRgPyFtdTe5wJH6T7WNuo3Wd9S02Q19RON6s75c00ZbkIPLYzcMEyRaik5q3SL481+/qgvoibOCCaILxSqFUMJsmr5WKEKfOGKxe9id7cyu39q5kInJU2qVtlU3DSXI6cglBl/CksJyymJBYk/74C5efYOEaWEYQX+ygRzulbrwO7CRR1NWaoigPtnMGkwkzaAVnCgAXvMufaTjgl2DRO//zq7G/Wo9fxCL/jeYI/D4jmgTCWf3CO2dOKIk/2ojNTpqm21eytRFIpd/UNQUV/TX7RnuPoyMojtBdQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWpQVFhtZmFJUm5mYTBUUmN6S2RGNFRBVTVPVmFvOVpvd3FaU09HeHdzdll2?=
 =?utf-8?B?R2hXWTQ1bnhiOHBqZDV6UVJJMHlFUUV1b3ZURy9VT3B2VkxVdE13RklDRXVI?=
 =?utf-8?B?SWhhT3F4SmdNbVMwZkZSdGY5R3NPNmZKaXNURlo1MGZhb21zTWRyK1Vja1pC?=
 =?utf-8?B?a2dZYnBlQklEQk9qdTRDUUVDVGxlWUNmNFhjTHN3dUNLRVdhcFVLcjRMNVBl?=
 =?utf-8?B?cVJ3djVQWHE2Z2ppQTdUTlNsOU01cmpSZFZpdFZHVnUrUVlhOEJLRWIxUEUx?=
 =?utf-8?B?Wit0N0hGSUNnYzFvaExCUjVacE5KbEE3cGdnNVlGZ1lhWUdEYnVaUnd6OVVX?=
 =?utf-8?B?dG5HNXhOR3J6a0RWeEM3WGdjY01MczQyeEZvOWd4V0VFSUJEOGM1eDhyMTFW?=
 =?utf-8?B?cDVZS1EveUVXbzRtRk1YNnY2QVZ6Y21LSG9ZMktsUlR5aVZ6QVJTT1REMGZm?=
 =?utf-8?B?MlBMaUh6M21GZmpqeHFYa2t3Sjk2blhrckJQVGk4dnRWdmEyM0RpUDZuejJH?=
 =?utf-8?B?NmVodnpLclMyVkpjUmovekhqdzMyblRoZW91bDFiQmw4c1YzUUJ6TEpYZkNY?=
 =?utf-8?B?MWZqMGY4a2trY3dBSkVURStta0RYYmhlZzB2V2IzdmpYUEEzTHQ5eG5WYkE3?=
 =?utf-8?B?eG55MGxOcmRDUUVIZ3FRUFl4UW9nTjM4a2dMNnd6alFVcFR1UkNIbHlweVY3?=
 =?utf-8?B?RFRaMXJXeVkxZFRaQk52K1k0VVB6UEJldmQ0VjNBZnQ0c3pZQ01YU09Zand3?=
 =?utf-8?B?VXRIbVdLOWx0QU4vYkFqVnpJaDBjV0RNZmhCMDRtMENFeXo2emEyMVVjU0dz?=
 =?utf-8?B?TWhuUjVrT0tFa3g1b3BsTm5RVWcxdnFMb1hNUHMrazZnYUFtUHZ5b1dYRXdw?=
 =?utf-8?B?ellram5CUXZZWDlpeUJ4NCtNNlovL2toQmJRbHJKZGIzZEo2ZzFDYy9xYWd0?=
 =?utf-8?B?eVNIdHBHMlFFTFNxc1Z1aWpiV3IyeUJZb2lydEZEbmJoY0t1VjFZbDEwdnpr?=
 =?utf-8?B?WEpGc0REWmZxQzhSQUU4UXV3K2hiSzZrWmU0K1JYRWFad0ZYMVhuajAybzRk?=
 =?utf-8?B?bWxaRFJEUHB3Uk1IZkorRlA0S2l4RGlCcWNjQmJaMnF0QWE3RFlGNkRmS2lC?=
 =?utf-8?B?NjJmWWh3RDVac3pHTXlwSFRRZ3l0d3UybFc5ZFQ1ejlYcUU5RklWQTBnaDlZ?=
 =?utf-8?B?M1JXM1lZbndPYitaR0xmelozM01CSllFSGhRVGlKQWdNcUlRTDBvMHJYTXJW?=
 =?utf-8?B?MWYwOFdYT2hUdnJudkNTWjVkak5LTVYvS05VU1hvZXViODE0K0F4SCtSdXd0?=
 =?utf-8?B?dGhXRlVVL29Mb3Y3dmNsRmFIM01ablF2UkkwYnpwWmxnNGlSM1VUeTB2WGpD?=
 =?utf-8?B?amFoL2xMb2lQRHovQUlyUU5YT1U4T3pEWVhoQlkzclA3Y3orZnNBRTM2Z09N?=
 =?utf-8?B?djRKWjZxM0thRUNQK0xCcmg3aWRQZ3oyamg5SlhUSGdzUGhqa0Uzcy9CU0Ux?=
 =?utf-8?B?Y0dacjYxalhxS1N3VTNyS242SUJFRkRqMnB2WmhNSkFsc3ZWSkJ0ZHNnemFh?=
 =?utf-8?B?V25QWEw2eHg0eGVzZUV0RVlIQWthcGVsRlFja09VWk5iQ2FWN3lkY2s3Tksv?=
 =?utf-8?B?cWVLa1pMR3M3Q2lEa0owUHdVUmF0SjBBdUxlZVBaMDdjWnNaYS9jK0NLcUxR?=
 =?utf-8?B?dzdVUmQ1NFd5Z09xcWFzZVNxVWNJdEl6cDZNMkROSmhDRSsrVmFDTW5ydzVJ?=
 =?utf-8?B?cjlNOC9LKzNXVjNyVlZ5K29JdnhhVkdsMDBCdWdYbXF4K1A0cFkxbGM3azUv?=
 =?utf-8?B?blZuTUN1T21LN1lPZW9JQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <630951A1DA3F0547BC2EE475BA4D3488@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P195MB1649.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bead969f-5bd6-4da6-2f5e-08da846b414b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 18:22:21.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1351
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hlbiBydW5uaW5nIGBnaXQgZGlmZmAgaW4gYSBkaXJlY3RvcnkgdGhhdOKAmXMgbm90IGEgZ2l0
IHJlcG8sIGl0IHByaW50cyBhIHdhcm5pbmcgdGhhdCB0aGlzIGlzIHRoZSBjYXNlLCBmb2xsb3dl
ZCBieSBhIHZlcnkgbG9uZyBoZWxwIHRleHQgdGhhdCwgb24geW91ciBhdmVyYWdlIHRlcm1pbmFs
LCBjYXVzZXMgaXQgdG8gc2Nyb2xsIHNvIG11Y2ggdGhhdCB0aGUgd2FybmluZyBpc27igJl0IGV2
ZW4gdmlzaWJsZS4gSXQgc2hvdWxkIG9ubHkgcHJpbnQgdGhlIHdhcm5pbmcgYW5kIG5vdGhpbmcg
ZWxzZSBsaWtlIG90aGVyIGdpdCBjb21tYW5kcy4gVGhpcyB3YXMgdGVzdGVkIHdpdGggZ2l0IHZl
cnNpb24gMi4zNy4yIG9uIG1hY09TLg==
