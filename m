Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25349C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbjDFTKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDFTKq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 15:10:46 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 12:10:02 PDT
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824167AA0
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1680808201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRG/0PtTmfIOeMDVpK4qF4EzuoHIpjepKCW1xMKmpdM=;
        b=ag3HjP6MPCm6NXLNT8qjirqaSKieib7PJSEScwz2RpMebJY+jbT2LEyTZv0priXEHHT+4o
        lijIxCL/+1Mbna5oB5WLKo3957QmRkZ5cUqMwD0cpJlEUdvD0Qzob7+aoVCFLesKhAOCzX
        gKoQMD6HNCXJnoC/gUotq/mmmTv7cFM=
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com
 (mail-westus2azlp17012027.outbound.protection.outlook.com [40.93.10.27]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-01_H1ZeSO2aGsAI3Ff2yXw-1; Thu, 06 Apr 2023 15:08:54 -0400
X-MC-Unique: 01_H1ZeSO2aGsAI3Ff2yXw-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by DM6PR05MB6297.namprd05.prod.outlook.com (2603:10b6:5:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:08:50 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::d484:ba61:5697:9d17]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::d484:ba61:5697:9d17%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 19:08:50 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] fsmonitor: handle differences between Windows named pipe
 functions
Thread-Topic: [PATCH] fsmonitor: handle differences between Windows named pipe
 functions
Thread-Index: AQHZXnQpCxtsr6xpkkSmMez/ylTtdK8Og/6AgAA5VgCAD/okEA==
Date:   Thu, 6 Apr 2023 19:08:50 +0000
Message-ID: <BL0PR05MB55713A00DEB97375BDC6D1DAD9919@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
 <e48e768a-19f3-386a-9bda-8fa8681d1a6c@gmx.de>
 <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
In-Reply-To: <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|DM6PR05MB6297:EE_
x-ms-office365-filtering-correlation-id: 8a9690b2-19c6-4905-5210-08db36d25b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: F0mgkqAKkxg744G5yY7ErhzBadiu8gLI6vg+SacYKVdQNQ1xxlLFLqzM7yOrrxy9gJ27JGi1LNEz6Bf0Jl0JEDIZuYKe2ZL+nMy/X3HCMdC/yIIn58Ih9oqEZEk+vNm0A4/j9Fw6RdXh9tmAtwEZPn9cVzzOqH5Wox0Qiu6IhS+EPUZB27WKOuT6RnHkl0hcHIzRAhUXbKniAMwKnLD741nacECgpsnndj5OT9GNYrtLyIc/B1uWn0Pta7UnRjStqNr+/7LOaMhblPbLO7FDY1nyETGvxCM9eS632ZzOL3UNtRqqeKbqYBDNmcBs0r0E319ejypGlaNjRRxCXnZAw+aROh3eCFWzQlo/TYi8juRVP+MMKZlCn1VVsV/qFGXkAiwgi9jXFtKr88vMMdbkY21O2IJaOvlhj5QLAGtK4EwAGy1WDnAP1zG/O6RVMMICXorQH2KAWyFmmCQYJJfZ68EHF/AGAVs1MpnWdl3aa8CF39aRhtFYuQJgsyiHcfVkbLT2X+JAyKDG/uFH2QnRd54Y96njOKLrIAUgs9Dqw3+Q6fkD4RweJcJdG9R68V9R5lDWIji53Dd9P49qkqK+zHMKzwlyurm5FQvMYBix4azoHR8YwoeLTWYA+PkkwkO8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(66574015)(83380400001)(9686003)(7696005)(478600001)(71200400001)(26005)(110136005)(186003)(53546011)(6506007)(66446008)(122000001)(64756008)(33656002)(5660300002)(4326008)(38100700002)(2906002)(8676002)(41300700001)(66476007)(52536014)(76116006)(86362001)(8936002)(66946007)(55016003)(38070700005)(66556008)(316002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STFkZkVQK01vaExBS2JFZlVJbGpYVkxQVnhWMTNZUWVDQnRRcXJVdE5JYnpx?=
 =?utf-8?B?R0xvMWNIRUlMcE1YVzNocmdPN3RqQ01TaHo3bUo2ZFA1WDB3S1hHMUJvMTdk?=
 =?utf-8?B?T0FRSGUxRVBqaTIwL0doUnUwR0NCTWE1UE9DNDBBclEzZ3FPNndQTHRFdmJv?=
 =?utf-8?B?ZkxFWVhsamp2aUFYTzFQS29QMC9iWGxrUUgrTGxyYzJ4dzlFYlZpclhlcXRa?=
 =?utf-8?B?dVM1T3htTVV1VS9xYjRvYVpmeWY4bnA0d1QxcFVyK2Z6eHNRZHNueTV5cEE2?=
 =?utf-8?B?UFM3S25UaTBJdjRyOWdqY05MR2tRR3g0c1dIRitkN3FZdkRvanRqemNnaUxZ?=
 =?utf-8?B?QzVtMWxRYnBoTWF1TmZsbG5ReG1oNXpjaFFZaXFjOVpFT21KM29WaTc2enRk?=
 =?utf-8?B?N2ZWbmxIWUpEbENrOWdxdHVwNEdCcE9aUnlCek5xeHVqeHpqZWNNTjhZckk5?=
 =?utf-8?B?NHVuVGFZcnFZQ0ZJMENCbEtibi9XeEdFZC82MGtzMFRXdk40NERNV1hVSTRS?=
 =?utf-8?B?ZkI3VTNDT1l4dks0bmxMUU9WMUNPMnF1dzhmaGVZdjU0SjVhZDlBNUVNRW5s?=
 =?utf-8?B?am0wQVkxbWozYWk1R3ZIQ2d5QmpXY1lha2EwNnN2ZSswWU9lNU9ZQzNHc2VU?=
 =?utf-8?B?RExxQ3hBNjBZUGhKcUpUYzlKUmRrOCs3QWlwd1FncUlLVVQ3R0V1N1Fwakdy?=
 =?utf-8?B?ZDRrK3YzTmRQakE2cjZwUDRBNmpqbmdzZy9hcC9jaWxoTHdpTmlsUS9IaXlY?=
 =?utf-8?B?WkQ1YVprWndHdHZGTWcyZlk3Tys4bXRWRWV2OURhTXZkOHlGR1V5QXhaUXBx?=
 =?utf-8?B?d1JnVjdCZTIzTklWUDJtb3hDdGtVSk9nS2xaeTlqWDB2WWFvREJDRzArZ0dK?=
 =?utf-8?B?bno3NFByK3QwQUMrakNoQ2MzVE9XZDVJWkpWQ0pOcHM5ZkM5V3ZMdU1ERTk5?=
 =?utf-8?B?SEVVazQya1FINCtjTkZBTmhreXlaQnlBYVZCdktyVU5uUmZMbzdYMHNzV3M5?=
 =?utf-8?B?MHBEZGtKcHhnWlp4ZFJpdkNMancrNzcrRXM5MkRHbTRxdmF0cXY0OXh6SXRl?=
 =?utf-8?B?YXdEckwxSUd5T01qbFQvUUNJTnVCWElHL3g0bUZEcUt6YUVUZnRCcFNWeE81?=
 =?utf-8?B?RmkvUE9zeWZ3V2tTeitkdkRrbkJQbWFweFBPaG1TOWNhMUdTUUFHK2xyajFE?=
 =?utf-8?B?clVrOFJtTmQzWm1OangvWmc4QVVDVEwvNlA2cUh1WStoNkQvVUw4QlJySnhI?=
 =?utf-8?B?SmtsQlhLWC9zcGhHYW1TWE1USjdubk5HYUpFazMrQzNlMnJWNUhiMnZtS1Fw?=
 =?utf-8?B?MFVRV3hZVE9SVDNOUmpiVmZCWW9iYk8rQUpMUXNpQUlGK0JyS2NHRkpDL3Z0?=
 =?utf-8?B?K3JWYUk1d0NJOWJybm1OQXlramMwVTZLeWdZMXlNN2F0dGg0Yjg1dWphY0pk?=
 =?utf-8?B?cXVjcFFRNWN6WVlNQS9jVkVDcE1LSFdPRnVkQnVHOTlvR3pMcjA4dXoxWGhX?=
 =?utf-8?B?MGJwWjJhS1BPVkV1R0FuT2tzemVJd0k4S2dIWFcwbDc0d295V2ZYR0hFMCt4?=
 =?utf-8?B?UkVSVkV3WGZmRGJNQnpBQy90VWpuNjQweWlqM3RGUGRnWXJQbHU4TzBFSldv?=
 =?utf-8?B?TTBJN0lnQmhrZnVTVit5U0RWZHJia0dmRkJ1L0pvYXZQTTdMalUyZGN6elEw?=
 =?utf-8?B?REU0d0xSZkpjOU1sT1AwOFhPYzJPMXZ3dDdQYTJDK2p1SnNlbmxuUGR3Sk0x?=
 =?utf-8?B?Ri9ReDA3SUhRR1RoSDMvZm0rb25ZK0lkOW1pTUg5N2R4Q3RzMVNvaUh3akdo?=
 =?utf-8?B?WWcyckNUWjFLMTRVR3hhQk5OLytkQkZ6YXJITTFHcDE2ZjN5bHRDbnJ4dVps?=
 =?utf-8?B?T0lCTi9mcUpRQjhwTjFKV3hsNGdkQTU2end5K0d4OENoa3AvbGRhOGJENDB4?=
 =?utf-8?B?K3ludkgzcFZtcHFyb1BneWtGRVRZK2labS9aamtSdEVRZWd3ZDRRYi9oVGUv?=
 =?utf-8?B?dXJxbkNKWXN6aVlrMXlGQU5TV0JQcFNlMjZzcWsvU20xQ1hIbGtoTEpMMlZn?=
 =?utf-8?B?QThscDlQcmFPTkg1RUd1R1o1c2VwOThEbDk5elIxWWIzbVhTbE4xWW13SkNN?=
 =?utf-8?Q?Qx2PuGZLeO+6/pk5IEl2BLlAd?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ae4JhXqzcD8NvBZaFezsUFegAtC1vwPxkOhM1X9uDkdfmAZNtwFCbw9phWqfcLqrzpay84OMKmYVnaTx1nx8jM4xUaVgY0tVIsmMV5woaKXata7n1h5RpVp1CNmVeiYZak+k89QZIfeCQ9ub3Yk+z5nBvaFB6MjTxmgRIyDhG9erBN3sC2fxvMFZk0AaHCXRwy2la1R21leRfZGZ9clhJHOmXdMFUumK3246nbQRpWJlzXgYo8l+mVHWRzkIbfQGU+SgXQGNrKLrNQp4LJFKiTo8Adb7z5e0wAn2bIqoLa0aeKT7C/pE21L3NnkQlJG6s7aR6RIrhYK056FTLtVUZI5Q2b3LJ0EEQNJ8NO7pAT6CNiiGZsMLE0e/CQvP+RWVL9OXHiYuX4NuWSKH6JgIGQwBaY3Qg8dLly8Lp5nlN2BnKJeDqMx66Rgc6mFL7zOZKxoqHoN2c99igA13xNLrznbo/00HMlEnFFAAXAXMxZQAexuPK3NaszkHsFuVIjwNmEkoapB6o3/+vt39PoyHc93CRh3s5ZwcOxatTg2HhoUz/5TU6pqWcoGRoaNplplzKMNXfqXighK4nMG0/U3ozWdNQt+H0Vxi1v5i0XJJcn7zep8jpcrl1Cxz9ozJWQlHW2FnmlX/QrxFxX0cJFfjUeGP2YKtoxXpPU6pl6YW9WAIgZGdgP7oiTDBraT3RW4WHNBW6hVmlHACIKXvtg/iUvjn2Y52aWy/5jjEQggqyx4jcDKJrlxnDNlfY5s6+UbnSU8+RpRYx2Mn4ZvKGLVP33Lb6tQYq3JM4JGfO3X8uiVcZFpV46QeA9QxygKWhWkCJFIS+xCc3hU3eWi31Ng4E7uXQ1by70GHP/mBvRV6rZ0=
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9690b2-19c6-4905-5210-08db36d25b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 19:08:50.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1lorqI5ADKTfaYvkxV4OIMFFvW83HAHSsqVGxgbK9dbD2ZziBoFf9++yasfrAe8F7tKCtE82lo89ei0MF5l0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6297
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBIb3N0ZXRsZXIg
PGdpdEBqZWZmaG9zdGV0bGVyLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyNywgMjAyMyAx
MTowMiBBTQ0KPiBUbzogSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBn
bXguZGU+OyBFcmljIERlQ29zdGEgdmlhDQo+IEdpdEdpdEdhZGdldCA8Z2l0Z2l0Z2FkZ2V0QGdt
YWlsLmNvbT4NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmc7IEVyaWMgRGVDb3N0YSA8ZWRlY29z
dGFAbWF0aHdvcmtzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZnNtb25pdG9yOiBoYW5k
bGUgZGlmZmVyZW5jZXMgYmV0d2VlbiBXaW5kb3dzDQo+IG5hbWVkIHBpcGUgZnVuY3Rpb25zDQo+
IA0KPiANCj4gDQo+IE9uIDMvMjcvMjMgNzozNyBBTSwgSm9oYW5uZXMgU2NoaW5kZWxpbiB3cm90
ZToNCj4gPiBIaSBFcmljLA0KPiA+DQo+ID4gT24gRnJpLCAyNCBNYXIgMjAyMywgRXJpYyBEZUNv
c3RhIHZpYSBHaXRHaXRHYWRnZXQgd3JvdGU6DQo+ID4NCj4gPj4gRnJvbTogRXJpYyBEZUNvc3Rh
IDxlZGVjb3N0YUBtYXRod29ya3MuY29tPg0KPiA+Pg0KPiA+PiBDcmVhdGVOYW1lZFBpcGVXIGlz
IHBlcmZlY3RseSBoYXBweSBhY2NlcHRpbmcgcGlwZSBuYW1lcyB3aXRoDQo+ID4+IHNlZW1pbmds
eSBlbWJlZGRlZCBlc2NhcGUgY2hhcmN0ZXJzIChlLmcuIFxiKSwgV2FpdE5hbWVkUGlwZVcgaXMg
bm90DQo+ID4+IGFuZCBpbmNvcnJlY3RseSByZXR1cm5zIEVSUk9SX0ZJTEVfTk9UX0ZPVU5EIHdo
ZW4gY2xlYXJseSBhIG5hbWVkDQo+ID4+IHBpcGUsIHN1Y2Nlc2Z1bGx5IGNyZWF0ZWQgd2l0aCBD
cmVhdGVOYW1lZFBpcGVXLCBleGlzdHMuDQo+ID4+DQo+ID4+IEZvciBleGFtcGxlLCB0aGlzIG5l
dHdvcmsgcGF0aCBpcyBwcm9ibGVtbWF0aWM6DQo+ID4+IFxcYmF0ZnMtc2IyOS1jaWZzXHZtZ3Jc
c2JzMjlcbXlfZ2l0X3JlcG8NCj4gPj4NCj4gPj4gSW4gb3JkZXIgdG8gd29yayBhcm91bmQgdGhp
cyBpc3N1ZSwgcmF0aGVyIHRoYW4gdXNpbmcgdGhlIHBhdGggdG8gdGhlDQo+ID4+IHdvcmt0cmVl
IGRpcmVjdGx5IGFzIHRoZSBuYW1lIG9mIHRoZSBwaXBlLCBpbnN0ZWFkIHVzZSB0aGUgaGFzaCBv
Zg0KPiA+PiB0aGUgd29ya3RyZWUgcGF0aC4NCj4gPg0KPiA+IFRoaXMgaXMgYSByYXRoZXIgbGFy
Z2UgZGV2aWF0aW9uIGZyb20gdGhlIG90aGVyIHBsYXRmb3JtcywgYW5kIGl0IGhhcw0KPiA+IGFu
IHVud2FudGVkIHNpZGUgZWZmZWN0OiBHaXQgZm9yIFdpbmRvd3MnIGluc3RhbGxlciBjdXJyZW50
bHkNCj4gPiBlbnVtZXJhdGVzIHRoZSBuYW1lZCBwaXBlcyB0byBmaWd1cmUgb3V0IHdoaWNoIEZT
TW9uaXRvciBpbnN0YW5jZXMNCj4gPiBuZWVkIHRvIGJlIHN0b3BwZWQgYmVmb3JlIHVwZ3JhZGlu
Zy4gSXQgaGFzIHRvIGRvIHRoYXQgYmVjYXVzZSBpdA0KPiA+IHdvdWxkIG90aGVyd2lzZSBiZSB1
bmFibGUgdG8gb3ZlcndyaXRlIHRoZSBHaXQgZXhlY3V0YWJsZS4gQW5kIGl0DQo+ID4gbmVlZHMg
dG8ga25vdyB0aGUgcGF0aHMgWyoxKl0gc28gdGhhdCBpdCBjYW4gc3RvcCB0aGUgRlNNb25pdG9y
cw0KPiA+IGdyYWNlZnVsbHkgKGFzIG9wcG9zZWQgdG8gdGVybWluYXRpbmcgdGhlbSBhbmQgcmlz
ayBpbnRlcnJ1cHRpbmcgdGhlbQ0KPiB3aGlsZSB0aGV5IHNlcnZlIGEgcmVwbHkgdG8gYSBHaXQg
Y2xpZW50KS4NCj4gPg0KPiA+IEEgbXVjaCBsZXNzIGludHJ1c2l2ZSBjaGFuZ2UgKHRoYXQgd291
bGQgbm90IGJyZWFrIEdpdCBmb3IgV2luZG93cycNCj4gPiBpbnN0YWxsZXIpIHdvdWxkIGJlIHRv
IHJlcGxhY2UgYmFja3NsYXNoZXMgYnkgZm9yd2FyZCBzbGFzaGVzIGluIHRoZSBwYXRoLg0KPiA+
DQo+ID4gUGxlYXNlIGRvIHRoYXQgaW5zdGVhZC4NCj4gPg0KPiA+IENpYW8sDQo+ID4gSm9oYW5u
ZXMNCj4gPg0KPiA+IEZvb3Rub3RlICoxKjogSWYgeW91IHRoaW5rIHRoYXQgdGhlIEdpdCBmb3Ig
V2luZG93cyBpbnN0YWxsZXIgY291bGQNCj4gPiBzaW1wbHkgZW51bWVyYXRlIHRoZSBwcm9jZXNz
IElEcyBvZiB0aGUgRlNNb25pdG9yIGluc3RhbmNlcyBhbmQgdGhlbg0KPiA+IGxvb2sgZm9yIHRo
ZWlyIHdvcmtpbmcgZGlyZWN0b3JpZXM6IFRoYXQgaXMgbm90IGEgdmlhYmxlIG9wdGlvbi4gTm90
DQo+ID4gb25seSBkb2VzIHRoZSBXaW5kb3dzLWJhc2VkIEZTTW9uaXRvciBzcGVjaWZpY2FsbHkg
c3dpdGNoIHRvIHRoZQ0KPiA+IHBhcmVudCBkaXJlY3RvcnkgKHRvIGF2b2lkIGJsb2NraW5nIHRo
ZSByZW1vdmFsIG9mIGEgR2l0IGRpcmVjdG9yeQ0KPiA+IG1lcmVseSBieSBydW5uaW5nIHRoZSBw
cm9jZXNzIGluIHNhaWQgZGlyZWN0b3J5KSwgZXZlbiB3b3JzZTogdGhlcmUgaXMNCj4gPiBubyBv
ZmZpY2lhbGx5LXNhbmN0aW9uZWQgd2F5IHRvIHF1ZXJ5IGEgcnVubmluZyBwcm9jZXNzJyBjdXJy
ZW50DQo+ID4gd29ya2luZyBkaXJlY3RvcnkgKHRoZSBvbmx5IHdheSBJIGtub3cgb2YgaW52b2x2
ZXMgaW5qZWN0aW5nIGEgcmVtb3RlDQo+ID4gdGhyZWFkISBXaGljaCB3aWxsIG9mIGNvdXJzZSBy
aXNrIGJlaW5nIGxhYmVsZWQgYXMgbWFsd2FyZSBieSBjdXJyZW50IGFudGktDQo+IG1hbHdhcmUg
c29sdXRpb25zKS4NCj4gDQo+IEFncmVlZC4gUGxlYXNlIHVzZSBmb3J3YXJkIHNsYXNoZXMuDQo+
IA0KPiBUaGFua3MsDQo+IEplZmYNCj4gDQoNCkkgaGF2ZSBtaXNkaWFnbm9zZWQgdGhlIHByb2Js
ZW0uIEhlcmUgYXJlIG15IG1vc3QgcmVjZW50IGZpbmRpbmdzOg0KDQpUaGUgcHJvYmxlbSBpcyB0
aGUgbGVhZGluZyBkb3VibGUtc2xhc2hlcyBmb3IgcmVwb3MgdGhhdCByZXNvbHZlIHRvIHJlbW90
ZSBmaWxlc3lzdGVtcy4gaS5lLiBpZiBTOlxteXJlcG8gcmVzb2x2ZXMgdG8gXFxzb21lLXNlcnZl
clxzb21lLWRpclxteXJlcG8gdGhlbiB0aGUgcGF0aCBwYXNzZWQgdG8gaW5pdGlhbGl6ZV9waXBl
X25hbWUgaXMgLy9zb21lLXNlcnZlci9zb21lLWRpci9teXJlcG8NCg0KUmVnYXJkbGVzcyBvZiB3
aGF0IHR5cGUgb3IgaG93IG1hbnkgc2xhc2hlcyBhcHBlYXIgYWZ0ZXIgXFwuXHBpcGVcIHRoZSBw
aXBlIG5hbWUsIGFzIHJlcG9ydGVkIGZyb20gUG93ZXJTaGVsbCwgaXMgYWx3YXlzIFxcLlxccGlw
ZVxcc29tZS1zZXJ2ZXJcc29tZS1kaXJcbXlyZXBvIGFuZCBXYWl0TmFtZWRQaXBlVyByZXR1cm5z
IEVSUk9SX0ZJTEVfTk9UX0ZPVU5EDQoNCklmIEkgc2tpcCBvdmVyIHRoZSBmaXJzdCBsZWFkaW5n
IHNsYXNoIGFuIHVzZSAvc29tZS1zZXJ2ZXIvc29tZS1kaXIvbXlyZXBvIEkgZ2V0IHRoZSBzYW1l
IHBpcGUgbmFtZSBhcyBiZWZvcmUsIFdhaXROYW1lZFBpcGVXIGlzIGhhcHB5IGFuZCBjb21tYW5k
cyBsaWtlIGdpdCBmc21vbml0b3ItLWRhZW1vbiBzdGF0dXMgY29ycmVjdGx5IHJlcG9ydCB0aGF0
IHRoZSBkYWVtb24gaXMgd2F0Y2hpbmcgdGhlIHJlcG8uDQoNCi1FcmljDQo=

