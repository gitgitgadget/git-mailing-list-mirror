Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448CFC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiHXPrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiHXPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 11:47:12 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285A10FE9
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1661355929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDgdBQRrbeSV+A2bSgKajkpQjDOK0nx2fg3Y0KEHrCg=;
        b=F+4TSwcG+Ujio5TNI2o9zWOhVejnz9iokGa/iPqtNhgHgvRKGQ9iKm1wd0liNSVQ+EAh96
        5k6O4mXm3k9ClO0ohf7El5efHoB/OmpW+HOLMGe4fHlD427k1IMiEWiydl1/mm0TBnGZ4U
        0vqciu2KW/5Qw1KDd1UP2HYLbAHFmlI=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-jU7x4obZNbeTfCjKQ7pAPg-2; Wed, 24 Aug 2022 11:45:27 -0400
X-MC-Unique: jU7x4obZNbeTfCjKQ7pAPg-2
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by BYAPR05MB6023.namprd05.prod.outlook.com (2603:10b6:a03:d7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 15:45:24 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::905b:1fcb:940b:e999]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::905b:1fcb:940b:e999%7]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 15:45:24 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
Thread-Topic: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
Thread-Index: AQHYs0PgP65/umilUkatLV07kvDAYa24YKj1gAKNTQCAAZpFgIABsXfA
Date:   Wed, 24 Aug 2022 15:45:23 +0000
Message-ID: <BL0PR05MB55716C6CC59D3258E55B25B9D9739@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
 <xmqqsflqlfjq.fsf@gitster.g> <092oq98r-39q3-4s66-0n0p-r77po7pq8275@tzk.qr>
 <055470ae-1483-bbd4-5b23-3762a4c131b8@jeffhostetler.com>
In-Reply-To: <055470ae-1483-bbd4-5b23-3762a4c131b8@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4d8090f-792b-48eb-484f-08da85e7a8a4
x-ms-traffictypediagnostic: BYAPR05MB6023:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: j6+lfYrn0gGoJl4HGRKOrox93h6rIMSBtI+G87X6xWebQ14ePWC6t8+gRIjBkvBg6vFw18mvfPoicPDupinu6d9kbaW+QiPw0NAGj9NeMb5qV660KY3xzKnCdYt3w9nk+e5UcUcApPo+WAIuE4unJ0iklfov3ttLlzNxYahlV+X/5XS/420Qo8hPdh+R7CH6Drv0rOSDE0mVGo6w1UZLo8NxOa6LvGLxo7eKS4oxnGPZicOOH6zRg71b8MvKqod5NfzXJXkt+Z/nJDKq9ibd/OT3GGl/y6oe3VZcxzMsPGMHpib209i2oIFBeqWgXLrekYX1J1twHYV36jqp1Ew4OiWFjSZqli3gnW/4VCmFQvP1BlBgD1ClEkYbBAaEoZeFFgFCJgmqhL3SWs2DfP5Yfx8JGHY4/cCL0xB6xLjaXKqialoMIjMNjkjX3nx1GFDVKFMLv4WLWeB939OvehDs1GCTa43D7Zw2PcI82GtfmowZy2zitVdxu8AWBbP2HYCfyRNtN9ZOk9/xg/6I7YbxP0qqBM9PmTYEi0Z9FQxoPH+lPsgUhVioPJ39U0Idqytt/VNEL3Y/ozJH4+5zEafI0A6NqtxP7M/W4GZWI3aYL3AMqWRAI/hZjRsJfjYvD67XWglFNjNi9wMgmy3oRvOBJMyTNMOBEFJHAGEQS/rCql1emUCcIhsblXEpItrjG/4GvraBIRnJ4eUpfYN3Or+veulaPbDVKLmfe3UkYMsiDV1PciUyUrj2unfeh41R/ipB3zwGRRFxPDFMUxYnfpOCD1bJ1nN164dNr0AJKf8z7d/jQzl60D4H+uXcNK13+J4K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(86362001)(186003)(54906003)(122000001)(478600001)(4326008)(41300700001)(316002)(8676002)(110136005)(33656002)(66446008)(66556008)(66476007)(64756008)(38070700005)(66946007)(76116006)(9686003)(8936002)(26005)(6506007)(52536014)(38100700002)(4744005)(2906002)(5660300002)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym9KQ3RjeG03bzJpNE9ZKzd2eGpMQTlpcXQ5K3JUYUVBaXdMbWpYMkVMem5s?=
 =?utf-8?B?Z3FUS00vNGVqcU5FK3FGS3dvNmZXbnJlc1NENmMwcVhaaWptVjA5NitlTzlt?=
 =?utf-8?B?b0dMaFNCd0RRSlF1YWlGcGpiemNwclpkdTZmNUVISHhHZTNpVUxqVU5ROEZ1?=
 =?utf-8?B?a3lDU2VaZ01lTGNLcW5tL254T1R4b2JNMEpVNlBYUUltMGRMdVJmcEh3OFky?=
 =?utf-8?B?M05iMzdDTWx6eUNicjVKeDJ2Q0VYM1htV1FJS2VYM01oY0J5UTR1bGxIdU9a?=
 =?utf-8?B?bWhqb0dNU1ZrdjFTN3I3d0lmNlJFUFBkWVVmNWNSTVk1SGs4dHJRZXBwM20z?=
 =?utf-8?B?bElEVGlzbThsMk9RaWNsQmNSZkZYTGZsNVNUaUNQd0dTYjcwMGYwRTNFUjVU?=
 =?utf-8?B?bExwejBQaG9OVW1HVGRVcEJnOTltNk54L0hSSGMzRFFMc2M2YnVkOUFJSW5M?=
 =?utf-8?B?RE9mMUtGQU10ZjljQXYzVHM0RGM5Y1V2VXM2elo0N1ZpTWJXdHFzTDJ5WE01?=
 =?utf-8?B?WVkrc2JxU2JBVWlic3pOOXlPSFlac2VXR0Y4UXM1RTUvOFgwL1dObkhKRm1J?=
 =?utf-8?B?aU90Y3cyTzQ5N05NVSsveGhhUUkrVjdBT2dzdEI5YUE3a3pOVGNYWFQ2UjZs?=
 =?utf-8?B?UE9rdHF2eVA3a1JPY2MwNFdmVjdlSkpWamZPdW5sL0VlaG9uQ2RRRGM1ZzZh?=
 =?utf-8?B?WCtrSDkzbjRQM0FOMVpvaUZKLzNVSkdNY0c1eEEwODlCV2hJVU9lS0hmSEVQ?=
 =?utf-8?B?Y05kUUxlNXh4SDRSRFFYK09pd3R3c3ByL1VKbEw1NEp3NGVzM08xZU5OcjdS?=
 =?utf-8?B?WFlJUUl3TFpaWVdRMytleVJvTU5NcmJOV2JIblZIcnJGWWZ0MmpwdTg1eWJY?=
 =?utf-8?B?WU9Bb1BYSmE5eXUyY3lJN3IwQkZJRm5IN0dXWVhzUi9OTWF6NTkvQ3ExazhN?=
 =?utf-8?B?UG5Ma1Irbk9UdTN4Mm0yNWd1UVp6OU02U0ZUT1Z3d1VmZENZa0RDdC9HeHIv?=
 =?utf-8?B?djNJcHRBalR6TFpUZTVEa3o2dlhZZEUrNzlvZkxGME03b3VJNXhlMzc5STV4?=
 =?utf-8?B?RlVjUnFDRmx3RmVBKy9xZ0d2VXZ3V2NYSThHdEw1MklzNmFER08xZk1rWVRp?=
 =?utf-8?B?K01oMmlRTGlaQkR2S250cktERGs5dlpMSTBxRUxzWUl4WC9ETGY4Y0JxSzBj?=
 =?utf-8?B?R0QrNmM2bWpOWGF1blVEZXpQTTRuQmV1Vnpyd21pckE4TXgrclB0bjVLei90?=
 =?utf-8?B?VlluUEM3R3lLRWw5QXlFSmRGVnp3YkRjWGpTbFlCTk1MNGZZd1dUSUdrMUFX?=
 =?utf-8?B?a0RRb3o3aGJLTmp1TmNSNmRJSVB4R3FGajJpa1ZDejdRWjJ1emRVL0lhZDdi?=
 =?utf-8?B?d1Z6YlVHSTlEcFhmMnZMdW51VDBXUHpYTUJyWTM3d21Fa0ttTWlXTG14c0ov?=
 =?utf-8?B?QjcveEVLVVdUMkp1bDdrV2didUxrZjl2bnE1dFNYV2hSNFNiMitTdjBxb3FL?=
 =?utf-8?B?VU1VbGRiQnBRdWdLajVsb3JrOGdYc3k5aHZKdnZHT1R6R3luc3lWazZmMjNk?=
 =?utf-8?B?eXd0OVJQQzhGOUZrZlZjZ3EzN2lYcmw0K2JNZFdYanorN1Q2VHczb2dUQ3hY?=
 =?utf-8?B?QXRBV1U3SDl3NkRrU3NjelBZQUJUT1N5NVRyb1RzeXhZTlA5Z2tVK0ZhUGFk?=
 =?utf-8?B?WE5KOXJUVlB5L0kvMUYrZjV2eFNPQzU4NlpZWkpDUmY3bmF1UDZyZzBBa1Bv?=
 =?utf-8?B?VGVnYlZaQS94dUEwTEpMNklIMjhIajAzb2hkd1dweCtsODZ5WUJvV3ZmMm1k?=
 =?utf-8?B?SEdrQ2JuTjgxYXpJdDIxR2RSZGh3cnJqSTBnWFJ3Q2wxVnUzczREM2N0blIx?=
 =?utf-8?B?bFhJZi8vL0pHSU9DeXQyclV2dnpORWRSWTZKVUp1d3BRazZ4NkNSOU5iYS9j?=
 =?utf-8?B?QWxwVktVTzE5VDhJRDloYlhYOEVROUlaKzlkR1gwUU1INzAwMURQUzlPN1Zr?=
 =?utf-8?B?TlU3eHhFNTM5SnAzTXRKbm54T2lvSHE5RHFHS0FqWFVpdmpveXBFYnFXcFdR?=
 =?utf-8?B?Zy80SS8yY3ZiWnFub0NSZDdQOFFDVVpZRHVBT1VCNStxZ0FTZFBsRTAvZk1n?=
 =?utf-8?Q?YXN0fHz+EKBDm28xsAFWEOyyg?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d8090f-792b-48eb-484f-08da85e7a8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 15:45:23.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYGPceUg0zAYFaP8T3ziO/Jj3soreoc0FZuaYErhJp0DN1noDYsVqb6O3LvZu9YFQWECeUCbBx1z4ORjByGN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6023
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJIHdvdWxkIGFsc28gc2V0IEdJVF9UUkFDRV9GU01PTklUT1IgYW5kIEdJVF9UUkFDRTJfUEVS
RiAob24gYm90aCBkYWVtb24NCj4gYW5kIGNsaWVudCBzaWRlcyBvZiB0aGUgdGVzdHMpIGFuZCBj
YXB0dXJlIHRoZSBsb2dzIGFuZCB0cnkgdG8gZmlndXJlDQo+IG91dCB3aGF0IGlzIGhhcHBlbmlu
Zy4NCj4NCj4gSSBzdXNwZWN0IHRoYXQgdGhpcyB0ZXN0aW5nIHNob3VsZCB3YWl0IHVudGlsIHlv
dSByZWRvIHRoZSBwYXRjaCB0bw0KPiByZW1vdmUgdGhlIHRtcCBmaWxlIHN0dWZmIGFuZCBqdXN0
IG1vdmUgdGhlIHNvY2tldCBpbnRvICRIT01FIGFzIHdlDQo+IHRhbGtlZCBhYm91dCBlYXJsaWVy
Lg0KPg0KPiBKZWZmDQoNCkFsbCB0ZXN0cyBhcmUgcGFzc2luZyBub3cgd2l0aCB0aGUgbmV3IHBh
dGNoLiBCeSBkZWZhdWx0IHRoZSBzb2NrZXQgaXMgd3JpdHRlbiBpbnRvDQp0aGUgb3JpZ2luYWwg
bG9jYXRpb24gKC5naXQgZGlyZWN0b3J5KSB1bmxlc3MgJ2ZzbW9uaXRvci5hbGxvd1JlbW90ZScg
aXMgdHJ1ZS4gT25seQ0KdGhlbiBpcyAkSE9NRSB1c2VkIGFuZCBpZiAkSE9NRSBwcm92ZXMgdW5z
dWl0YWJsZSB0aGUgdXNlciBjYW4gb3ZlcnJpZGUgdGhhdA0KYnkgc2V0dGluZyAnZnNtb25pdG9y
LnNvY2tlckRpcicgdG8gc29tZSB2YWxpZCwgbG9jYWwgZGlyZWN0b3J5Lg0KDQotRXJpYw0K

