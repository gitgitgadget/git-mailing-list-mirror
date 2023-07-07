Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6B8EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGGTiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjGGTf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 15:35:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2056.outbound.protection.outlook.com [40.92.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313B1FEF
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 12:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8klpT98WbeGyAmipsrI3a10NKOpBfsTptGpHnwg/uoiZpuDHi0c13TYotAwuF2dQSLu+ebMqNEhoYXGnzjaeotLaaRgPePCX9sIe7Re5faRJ8fHKhY4CIqh+oy17s/A92yxEGF2AhnU734AxfKD1ddtP1mNCjhb+XC7erfX+4FC2mqzatMipAvw9GXmjelU+RNiZSICQW40mcvKhQNn80OTkQth6Dt0lKn+pgUJideqPDaoYzFgJZCZc2Gx2g8E6XgGe8/CPdb7gjbaKagi5FnaFWCJa247eFlgZzRzvpz08bgM+cbYjBUBCz0NUyLZ/Ed/LhDyE71lk5wXgUsJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b0juv5AfH80iPSinkM4CUU8JbogfWf3a8ccqEPakT8=;
 b=DVOKsi+M5+GRIYrfZJIpzxZ2qVrImdrl3ay7NNZrQZS8GTlq296r3xGyco3gApEP5R29HvckJ8NZeWB7iCw7Q88w0l+DgI3snKvfYNtxrMqyZNu5MDujgQ9Hvu+v3858mVIrj72s8k7sAs42+VBbypPBQU6JTKVr5z4RRPp5xmFBEWxauNbkh8QMhWM+3zBRTuatbkN91M/rnsJWMGRhKQD16bk5MpwkMut4+FLiw8pa2cLap9ByPHJf+GAMzBfUn5kr2QJIvOi8CvDYJOWU5H4Xj3KevhgpaIgUn8neVYAcBKW3pTV2RBwAeyPJf9QaljU1Pz/sltZEgG5MQrLA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b0juv5AfH80iPSinkM4CUU8JbogfWf3a8ccqEPakT8=;
 b=U4lDdgQ92EX3qN9z110NnScQrKKiJDxTBxH+QgIK4IwRONM5EBPiF/lfZyv4Q4ZOPYogRqjzjzEWbdUC0uSbgf90lqD1gjtOp6Amo0SvaokXI2w2vQr/3SvBJiBGlvS4hWshXyWgnm0f/noXE70inZaexV3NKQ3z5fBwDvrnuzLOvtt/MIAKSbT1Mx7Ro42YixeIwshGDS7Lq60cloiepQd2NUZidOETk2tf9ZPTPj5GbmV3zW/cGDkm1hPGHpSMDKBc9Ie+9bhYfh9QP+Nd8jgXP5tAzQ52Stt2YT6H3Kt2RkTOzi3f7bOLhcRDKiQagh2F3TgGjda8ZWhWTbWjMA==
Received: from DM6PR07MB7339.namprd07.prod.outlook.com (2603:10b6:5:216::19)
 by MW4PR07MB8569.namprd07.prod.outlook.com (2603:10b6:303:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:31:53 +0000
Received: from DM6PR07MB7339.namprd07.prod.outlook.com
 ([fe80::93a3:83b1:87c9:c636]) by DM6PR07MB7339.namprd07.prod.outlook.com
 ([fe80::93a3:83b1:87c9:c636%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 19:31:53 +0000
From:   ross thomas <rossrecovery93245@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Hello world
Thread-Topic: Hello world
Thread-Index: AQHZsQmvtPPuxiPIzkyhTEMj8i3aWg==
Date:   Fri, 7 Jul 2023 19:31:53 +0000
Message-ID: <DM6PR07MB73395D3E002E4E7C8D7EE647FB2DA@DM6PR07MB7339.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [HmAhIGRaObVu7iU+Hu76JE/fQWSCAqKj8g3wgs4NJeM=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB7339:EE_|MW4PR07MB8569:EE_
x-ms-office365-filtering-correlation-id: 235c5bd4-6eb7-44b5-6e64-08db7f20d1c6
x-ms-exchange-slblob-mailprops: c9/CzQ6A0FyD8A1R8xqjapmYGCpA8QO8LTvB23w/BLMxs92bQ6NDXtv9xMvRNwHW5ZEv70rqeeYZiH8oc/yXzNu3hGvnXWciE7hynsdPth253H74SpHSvG7mZ+oli3GE85bxdmV9+mR3RS+i4+qkZmgNRQczyz0z0JeWwLcwQrvzedupvT4M72fj8uG1B5PUWkulgT0Fqlz4/n8gslRL5SxIjZg6uX2q12PoWyO5I9vSlk/rfNZhBR1xGy3Ma+q9pkvl214RKhNaMkK9iOlMMPt3NbidPmCusp1/jyQNzDl93pZqXr8JR699HVoSpuinhiWKIOGiHdzy3OvOx1ZJqK8/fI4LDazyiz9oZtVlszsEHcYF5HnPUMVYSuKhs0EveX8SIe6fU2MmOqujIEESuLi8zChHS9UE1DiYq4LnXREE1F99dP2ZN5giU65v/9nSFVxsV9ved99VJtSpRPH03X7afyxsG+Ib953H9LtdfKLtkuN5ydSOb9x4q8ZXYAMyV1OxzjOOoJlR4sPYohPrbht+ZI1cnU4uhajX1veZYlyOzI/wnH300qSafseIHjyi647qNxYYAOYhLkaWbz1RZatEKH5u4IC0UAieYvD4rHY=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXHVJClGbhVLLxqbmyF374TrxKDhM7C7hYs3AwrZrKs8eYj95b7c3umEgOLHB1Kb7HTrGqrYSngRueh7K5YTHUKVB+PckH7+sl24Xo4NNg3hIU7vGdGHSmbLfHBj32NyUg9r4YCXoLWEnOEZXBpGxhj03FikkW59JNHltMT/k3sr5JzBijDg7DL0SGOJRpG2/lwlX8r6vO/gKYD+PyTufSSR7waYJ7ahV5sV6a7FgCk0v1srCZzAad5P2/fZHvWo1gEkcGUFekb0wWj+Fc4zjcrHQ2wY2BQ5S7FqF7AzfDxNmGlljJrl3QrDphCqRfnkAk5ktzSJFeclFeEAnRV+TtvIANH9KNQXflhD98MsuLxg+GgeFW5V1Xzod4jC3jAsZ4kmyedWjoMsgLXptrjHn9JmiSFUOOsH70KQy7AyXHliQ27WbM6IR+SJcLRrY7lDYKIVp9P/KtAMw9qHnQCd0XdZ3kgzc46ZSNhuIe0An64fthGhNyZN/zL7DZNuvbYLbXWAs0j1dPUG079kRvZJovnBIgOjTWEgty11E7Mm0YTufc1xlwwKzAdcdrV1r4f0BeCIm446UGH4CyRbF9r/fMNUbdsJUreW4usU5R5P30l4nIpecdbnBg7Fb0Xl7Ecn
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1JrYTBRb3pGYjhSZXF2WnVva29DN2g1Y2F0K0kvV283dll5Qy9kTjFnaVNO?=
 =?utf-8?B?UzRFQ1oyWFFQRnR1SmsrQ1k0RExwWlJnblhjSm9uTDdvMnZtRTNNWVBVMFYv?=
 =?utf-8?B?UUJVTldEUWU1RklUMFNhQkY4WTRTSlZMWmM4d1NuOUw1QmlzdEMxSUVlUi95?=
 =?utf-8?B?Vk1PVHdHTU9NVTRvUW5UZUtLSTZ0MFJIWlNSSzA2Mk83ZjhRakEzYjlzTWY5?=
 =?utf-8?B?MDg4cXNoK0pUd0grZFgwQWYvZjNGSm1MblVwNE5lbjJRQjd6eXAyZS80UHcx?=
 =?utf-8?B?ZnZkc0FhSkpoWk9QdGo4SkY4a0x6cURaQjd3OWZwL0NuS2dPMHg4Rnh3MitM?=
 =?utf-8?B?RStjdmVMdFFhU3F2TW5kU29DZXNzeUFHTXUvVzVwVWhTbGVCOHowa2h6ejB0?=
 =?utf-8?B?MndxYUJMc0hQMzFGSzdKdncvcUhpaThDVTFibVF0WmdTOGNjcTNuSjhQUWFD?=
 =?utf-8?B?Z2xFaGpnL0grdVVBczVsbUZzV1o3THpBa0o1cHJsQTRFakhHakVOMVNQTkls?=
 =?utf-8?B?NDVxMkNISWU5T1FkMlFhREVDUlJ5a21nSVdMenZxODBpaTdIYWJjTzhjZit4?=
 =?utf-8?B?YlRaTDIyT3dCVHdLM1F3eWpnVGV2eGs5R2lRNkJRbFJBWmk1T3NGQUVud3Nl?=
 =?utf-8?B?SWdYdXhiRTZ5elhuSVVHL2NWbC8wa3ZvM3JFRFNhbmRwYlY3eEswSko5WVI4?=
 =?utf-8?B?dW1DV2dHVzh6MEdKSHZaNGw2K3BocDdScllMUjV5UGJGaEFYTnhibTZxTTlM?=
 =?utf-8?B?UDlwaDlOSGZKRWw1WmJRWVlmdnJ5a1FtQnVobGNKVjU4cnM4enhlSWV1RmZP?=
 =?utf-8?B?aTlQZjRPUFRENDFzSS9aaFNJZHlCMXVDRkVaR3dLVmh0TVdtQzM3WEVEVjRL?=
 =?utf-8?B?bTF6MjBXMTZ5MjJ6TkE4cmQ5TE1iSHRPTHJVamd1anhJK1lVK3VLMWpBejNV?=
 =?utf-8?B?Z1dRTm94Y1JrbTNFRHkySVVFdTVkanFzbmo5YzNhenp4dDhNamdCV1BaOXBu?=
 =?utf-8?B?dSs0eS9yL3JaUUJUTTFROFlPM3VsV0N2YzNWWHcxMmwzWDNyVDVmSUdyME1h?=
 =?utf-8?B?akNuSXpiZ2RmOER0dkIxQkE5dnBPQWg4SU4rcWJNdW40UFlSZXFKclVaMUli?=
 =?utf-8?B?Yy9XUWpaU2FGbDZ2dk5xMS8wWS9sR2J4NWxONmJzVFV2aHNma00wMDhOQXlK?=
 =?utf-8?B?V1lvVVRKVngyRnJyL3VJbHU2blA5TThMM0RMb3ZxK3ZhdUFYWjFpbkpDVjU3?=
 =?utf-8?B?c3FBVlpUTjlST3ZYRVFIaGZoRE1zckF4Zk5vT1pUS3hnbkhKcHVVUjg5UUNk?=
 =?utf-8?B?LzJQOVBJZWxtNTVTTXNzeDk4dWZTMmFNYStYNmtiUzg5T3JjWU1LOTZ3Mmda?=
 =?utf-8?B?dHlFTHB0SW5rVnRoWnFUcTFkUjNvdkdpbUg1cWlJaThWN2QyZzYxU1hESjFq?=
 =?utf-8?B?OEJLV1cxQ29SbjRVUUliRUc0THo0WGFJdWxlL1JrUVRnT0Zqamt6cnZjOWNJ?=
 =?utf-8?B?NW5sS0FUZGpaVG9FdS8xRTJFWGwveXZIRnM4TU54eVljZTUya0ZjYVQ5NE01?=
 =?utf-8?B?bGtacWwzektMMEJsOFQ3NHlwak8xM0p0QVJQK2pYQy9SZG91VlBLVEJIMW9w?=
 =?utf-8?B?SEpsOGN4eVJZS2dDTWVlbzAwUUZvelZPY3c3bmc4NGpCTTZsR0RsUDV1bnZn?=
 =?utf-8?Q?Ya+JrRpdlmSXonOp/Yw4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8EE642AF0ABB944AD319FABAA4A43EB@sct-15-20-4755-11-msonline-outlook-5fbaf.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB7339.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 235c5bd4-6eb7-44b5-6e64-08db7f20d1c6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 19:31:53.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8569
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gd2hvIGFtIEkgc3BlYWtpbmcgd2l0aCBhbmQgd2h5IGRpZCB5b3UgaGF2ZSBhIGVtYWls
IG9mIG1pbmUsIGlzIHdoYXQgSeKAmW0gd29uZGVyaW5nLCB0aGlzIGlzIFJvc3MgTmljaG9sYXMg
T25laWwgVGhvbWFzLiBEbyB5b3Ugc3RpbGwgd29yayB3aXRoIHRoZSBzaXRlIG9yIGFyZSB5b3Ug
bm90IHRoZXJlIGFueW1vcmUuDQoNClNlbnQgZnJvbSBteSBpUGhvbmU=
