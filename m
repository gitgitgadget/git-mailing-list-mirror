Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F585C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 02:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiEGCTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 22:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445350AbiEGCSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 22:18:52 -0400
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.133.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 837DA5DE67
        for <git@vger.kernel.org>; Fri,  6 May 2022 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651889706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8/fdZ47DcGGbMxFZe9qUSQY/Vh7n/2X6o/6kZEgx9jg=;
        b=KAYC0TJ3Frvvfpg80eTea3/wuq5mvUl4apH1F0qKXp7mRMOIhenyf2UYTVB/mKlNUOctDn
        3cCYbj9MPfvmlkc2JMJRV2PKFVAdyy2CY9go2LGHMm8/OvRSoLY1e3LP0xjvdQVqV3TG8t
        66PsrQ6lAk7oGdyB+aJXAN+KElGsdb8=
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-JGSB9OFaOwqU-SGwbvc_Wg-1; Fri, 06 May 2022 22:15:05 -0400
X-MC-Unique: JGSB9OFaOwqU-SGwbvc_Wg-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by MWHPR16MB1469.namprd16.prod.outlook.com (2603:10b6:320:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 02:15:01 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 02:15:01 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
CC:     =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Thread-Topic: [PATCH] Prevent git from rehashing 4GBi files
Thread-Index: AdhhuC1ooYho6unzQC+Df3CzXL6irg==
Date:   Sat, 7 May 2022 02:15:00 +0000
Message-ID: <CY4PR16MB1655F83010A128D4ED67C7EDAFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4ec8537-b785-47f4-ea39-08da2fcf6414
x-ms-traffictypediagnostic: MWHPR16MB1469:EE_
x-microsoft-antispam-prvs: <MWHPR16MB1469C1B2CFF135E7CB1089C9AFC49@MWHPR16MB1469.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: hfRcobqIw0Zna+VXIKX6ujl07WPTSAtmns2KDpG9K5zuNsAORgFggItVUKYuwCYLCBoGYuCwuazt17ArdMjLdE0XbRkzDm5MqDG4W7gMguCrkhSgKIQMk4NoO0YA5hG1IOtkwhbX9jZ9nsKOdAfFPcTBvC+DZFAGHE7Uf6ZPVPSZLTgmufvYob8mo7wxQ7/HIa/dAIWVtjCvHR8muqz+Lp9xK7KkZ3YzXJTnRWRxVhLbT+/HKHbMva0nl1xdtSkKC9heDoCVvHEY34t/xXMJNrosi9VrO3FLIXZwQnItLll3ZjdhJxeaHS0U5xj9ix1gfdyqV+2rcSvb2Vz90aL1OUMTcz+GLhabBfLQLErkIq5S3TCCIVRjdtZSxHIafvUpV57cuLmafwH2SKXSq0Y5EZd3IzraFRJuNZl2IgAHAljbYCC5UEfI3FDVG2F9w9GfO+twWUkZdVHBufCyB5ylO/wP3nzLPBqdSNrKPF4j5gVOy2HSR20GtUFf7g/D7EacHDzQ+NuUOr4n51gospc78+4LYPF7mAt8KVwBNuV9ufXUyaDR7llmWVdKjzx6IQHn5WgRMNDbY4CZv5BeN8Fd9vjKQ6Gnb5SbNDLMELlN28pJGz82pfvDHBzOkazuvQa5T4dzQnUjovOMuKLdw/qXX63nnMGjPstRDDxOraH0H+9zap5oehpRHj7sGc8zFnnatPOX53P2h35+LyKbAXsTpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(5660300002)(508600001)(83380400001)(33656002)(38100700002)(38070700005)(71200400001)(86362001)(6506007)(7696005)(9686003)(26005)(66574015)(186003)(2906002)(55016003)(54906003)(122000001)(66946007)(76116006)(66476007)(8676002)(4326008)(316002)(66446008)(64756008)(110136005)(66556008);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG1JbzdTcU80OXZ4YW13djZQNHYxdjJrODNsengrVk4yVW0wa3RWZ0tUbHFQ?=
 =?utf-8?B?RWNhNzErZTlZclFRdndxd1VWeTZTMHBUcFM1VVUrb3F2dGhNNHFuQUJwNkZU?=
 =?utf-8?B?bHVrUnFBRzZtRHZCTWxYOW9zUXdNRHhBNktIcG0wblZtYmJ4MTlZeWV6WHQy?=
 =?utf-8?B?eXRJaTN2ZHlTRTdzYlhtREJKOFFxVXlYNEJBTWRzYk14YldWMC9BZHhyK1o5?=
 =?utf-8?B?L3dYZm9zbFNmeDN4NWhKT2hUTTdaclczU2I3emltbHg0R0tWMFFVa3h5NFpJ?=
 =?utf-8?B?a1ZRM21QbDRCbFk5bEluR3BJYkgyVm1FR0NFQjN6ZnJSdmlLUVBxSWxrU2x0?=
 =?utf-8?B?WDBPZ2lwcTQ5UFZqZFBGcnQwM2UwRVFFNW9HSFJZY00wNWZYSXdWZ21ZbDdk?=
 =?utf-8?B?N2IwYTBwZWN4OHUzWHpYRTBiNTdrTXRFY0RhYmdLM2ltUTkyR2NoVGo3ZDJ3?=
 =?utf-8?B?Z1dld1d2Q1IzMkZqcGZXVWl0SjlqV1ppWXVoNUR3K1dQZGFvZ2NLSjg2L3Z5?=
 =?utf-8?B?dDJTbzF1QkV1VGlmZ0ZFK0xaVHFqRnkrakxGMGpldXdHNUV1cFJrQThyQVo2?=
 =?utf-8?B?U0UyWWtuaS93YkNpekZhb1FXTThlME4ra21OVUQyOW1GN1V6SEhsdDBlaDA4?=
 =?utf-8?B?YWQrT3hFUVhjRjRxWWVPTmlqbXo3S0FqZ04xcEtJUDRBYmdiSWxlV3poOUdo?=
 =?utf-8?B?eHBUV2tMZG13YlR1dFBSSkxWazNEV2NtRTJZcEdoR3hwVEtvMXZ6MkJJQm1y?=
 =?utf-8?B?OS83akw3d2h5UXdHWncvYldXZWN5MnBJQytBN2VzMzZDeWxLZnE3dmpRREEr?=
 =?utf-8?B?cmlRU1FRMTVReElOL1FQcktwbEoyWVRZc2V6YlZ1Q3Vqa3ZsR2FVc25mT2xv?=
 =?utf-8?B?Q3ZWZU01QzZnN2IyTDhBMDlEOHE5WHBKQk5EQjZxYnVDdTZFeUh3UjNVZzAy?=
 =?utf-8?B?K05ablM3Qnd3SWprNEZ0d1lpYkdNRXpKQUl3TVZuRUNUTXZDWHFOMS9ZUEZS?=
 =?utf-8?B?Q3A0K0JTSWFzYUVDc2RocXErQUMxTHpZWUVOZXhDM2JSOUN0ZVNGWlgvL2du?=
 =?utf-8?B?WVlyWDYvdEhYOVZEMXkvM3kveDYyU2RUUlFKZS8wNEVhbmdFNm8rb2VDQnFU?=
 =?utf-8?B?VWlmRjFwY2Y5N1JDTzgxS1ZZSWdhQjAydTdOelJEVmt2NzVrNCtuZndWM2RP?=
 =?utf-8?B?dmgyNWVLUHNmR1psajZabjBlcGhXOEtsTUpLcGRUK3FCWDZmR0cvdGtER2Nq?=
 =?utf-8?B?WmdMS215KzJIdkU4QzlqWnNZMVY4QUtBWUtBK1g1eG5XYkwxRFdqSGpFdzJt?=
 =?utf-8?B?K1NYazlCOEIwc2JsWDF6QUtZa3Z3Uk85R1hOSm0wdUJodFRXcnJPNUlCV09p?=
 =?utf-8?B?Ym9LMXg1dXJXMGlMdER4Yko3ZzBla2p3eGMrWjdQeWxaOXJnUWttdUdXRkVn?=
 =?utf-8?B?UEJ2TlJOV3F4OTJ6MUxaNkwrUDU5ZVhGOW84WExmMkNYNUlrQkthaDlwZytH?=
 =?utf-8?B?cXF5eU1GMWpuWEVrdDhKemdKeW1NTmVrVGJJRE5Ob0pVcFY5ZmlMVGQ1Vmxu?=
 =?utf-8?B?YXJUdkIyRU1zSGRJU0FhYUEyTXlKUlBYVE0vZEVKZlZ5RkcwYU1VMElaN2Rv?=
 =?utf-8?B?NG9qWFhnTUxYSE9YL2Q5SWR4aXdnZDBVY1RBSzR1WWJMMk9Lb0FjVGUzRFVz?=
 =?utf-8?B?d21qR2lrZHhpTXhucmNQWkYxdTZYbEFZdEJyc1JORTg2RkRodjNxZTF1MkxT?=
 =?utf-8?B?QzVLVGtQbVR1SjQ5TmRUVXBhVS9McGlENktyaXZlblhyb2VpZDd1d1F0aWxz?=
 =?utf-8?B?Wk5iSEhiN2t4ZlRTQ3JhNSs1NG0rbnczWG5SZmpKNWpMeERCUTdtT2U2Yzcz?=
 =?utf-8?B?Qkx0Q3VTTmxndTFWLytXd1dyQjBpcGpUVlhqOFRRdjc0cUdDOTdWVHYzZVNi?=
 =?utf-8?B?d1pESloyMGw2ZDQzNHdUZWFMcFBKaVU1bWF2TnJuejczUWVFY1lVNEV6Yjdt?=
 =?utf-8?B?ai9ibGh6NDFWYUxkZHdOOEJkcHNCeEpVTk80V2NzRW5PUnJwOTJrZ1VTdlI5?=
 =?utf-8?B?SHRidzhWYjJFbHF5OEI4VmRqNDlUVHBaLzE0cUZrTHpRQk1XcHhWS3JTQWs0?=
 =?utf-8?B?dmhWTlhpRnJKMzVoMUFKRmpqUlpKN08rSGIrTHlSYXRGWllJTGt1WFJSUHQ4?=
 =?utf-8?B?RVVaNGN1Q1dzUTZ5K21IcDFTVTRhUWFjSGxMUU5lclZEd3cySktnOWx2ZDFx?=
 =?utf-8?B?OWRlZHlXVC9VanlvdzdPZXFjVHp4WkgxcWFvb0Roam1XeXFrMTdXdFNqRlMz?=
 =?utf-8?B?QmhLc0h2MGxzdDdQam9sWDB5TWs3WTA4cDZ1SHhkdzdaMVBGd0Q1RFF3ZXcr?=
 =?utf-8?Q?2MbKZFW9XDlzkgP4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ec8537-b785-47f4-ea39-08da2fcf6414
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 02:15:00.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5rU1NVcFNgj2ZnSj2kx1YFtLZlDJgy/M7gD40Ep13YrT1Vp1BNSyT7YqEUfsvTeXRFp4wiCiMZ1tsTSkPF0Dsx7HR984NOXP2nxlLuZljU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1469
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PlBoaWxpcCBPYWtsZXkgPHBoaWxpcG9ha2xleUBpZWUuZW1haWw+IHdyaXRlczoNCj4NCj4+PiBU
aGlzIG1heSB0cmVhdCBub24temVybyBtdWx0aXBsZSBvZiA0R2lCIGFzICJub3QgcmFjeSIsIGJ1
dCBoYXMNCj4+PiBhbnlib2R5IGRvdWJsZSBjaGVja2VkIHRoZSBjb25jZXJuIFLDqW5lIGJyb3Vn
aHQgdXAgZWFybGllciB0aGF0IGENCj4+PiA0R2lCIGZpbGUgdGhhdCB3YXMgYWRkZWQgYW5kIHRo
ZW4gZ290IHJld3JpdHRlbiB0byAyR2lCIHdpdGhpbiB0aGUNCj4+PiBzYW1lIHNlY29uZCB3b3Vs
ZCBzdWRkZW5seSBzdGFydCBnZXR0aW5nIHRyZWF0ZWQgYXMgbm90IHJhY3k/DQo+PiBUaGlzIGlz
IHRoZSBwcmUtZXhpc3RpbmcgcHJvYmxlbSwgdGhhdCB+MWluIDJeMzEgc2l6ZSBjaGFuZ2VzIG1p
Z2h0IG5vdA0KPj4gZ2V0IG5vdGljZWQgZm9yIHNpemUgY2hhbmdlLiBUaGUgMCBieXRlIC8gNEdp
QiBjaGFuZ2UgaXMgYW4gaWRlbnRpY2FsDQo+PiBpc3N1ZSwgYXMgaXMgY2hhbmdpbmcgZnJvbSAz
IGJ5dGVzIHRvIDRHaUIrMyBieXRlcywgZXRjLiwgc28gdGhhdCdzIG5vDQo+PiB3b3JzZSB0aGFu
IGJlZm9yZSAod2VsbCBtYXliZSB0d2ljZSBhcyAndW5saWtlbHknKS4NCj4NCj5PSywgaXQgYWRk
ZWQgb25lIG1vcmUgY2FzZSB0byAyXjMyLTEgZXhpc3RpbmcgY2FzZXMsIEkgZ3Vlc3MuDQo+DQo+
Pj4gVGhlIHBhdGNoICh0aGUgZmlybmFsIHZlcnNpb24gb2YgaXQgYW55d2F5KSBuZWVkcyB0byBi
ZSBhY2NvbXBhbmllZA0KPj4+IGJ5IGEgaGFuZGZ1bCBvZiB0ZXN0IGFkZGl0aW9ucyB0byB0aWNr
bGUgY29ybmVyIGNhc2VzIGxpa2UgdGhhdC4NCj4+IFRoZXknZCBiZSBwcm90ZWN0ZWQgYnkgdGhl
IEVYUEVOU0lWRSBwcmVyZXF1aXNpdGUgSSB3b3VsZCBhc3N1bWUuDQo+IA0KPiBPaCwgYWJzb2x1
dGVseS4gIFRoYW5rcyBmb3Igc3BlbGxpbmcgdGhhdCBvdXQuDQoNCkkgaGF2ZSBiZWVuIHRlc3Rp
bmcgb3V0IHRoZSBwYXRjaCBhIGJpdCBhbmQgaGF2ZSBnb29kIGFuZCAobW9zdGx5KSBiYWQgbmV3
cy4NCg0KV2hhdCB3b3JrcyB1c2luZyBhIG11bmdlIHZhbHVlIG9mIDEuDQoNCiQgZ2l0IGFkZA0K
JCBnaXQgc3RhdHVzDQoNClJhY3kgc2VlbXMgdG8gd29yay4NCg0KJCB0b3VjaCAuZ2l0L2luZGV4
IDRHaUIgIyA0R2lCIGlzIG5vdyByYWN5DQokIGdpdCBzdGF0dXMgIyBHaXQgd2lsbCByZWhhc2gg
dGhlIHJhY3kgZmlsZQ0KJCBnaXQgc3RhdHVzICMgR2l0IGNhY2hlZCB0aGUgZmlsZS4gU2Vjb25k
IHN0YXR1cyBpcyBmYXN0Lg0KDQpXaGF0IGRvZXNuJ3Qgd29yay4NCg0KJCBnaXQgY2hlY2tvdXQg
NEdpQg0KJCBmYXRhbDogcGFja2VkIG9iamVjdCBpcyBjb3JydXB0IQ0KDQpVc2luZyBhIG11bmdl
IHZhbHVlIG9mIDE8PDMxIGNhdXNlcyBldmVuIG1vcmUgcHJvYmxlbXMuIFRoZSBmaWxlIGhhc2gg
aW4gdGhlDQppbmRleCBmb3IgNEdpQiBmaWxlcyAoZ2l0IGxzLWZpbGVzIC1zIC0tZGVidWcpIGFy
ZSBzZXQgdG8gdGhlIHplcm8gZmlsZSBoYXNoLg0KDQpJIGxvb2tlZCB1cCBhbmQgZG93biB0aGUg
Y29kZSBiYXNlIGFuZCBjb3VsZG4ndCBmaWd1cmUgb3V0IGhvdyB0aGUgbXVuZ2VkDQp2YWx1ZSB3
YXMgbGVha2luZyBvdXQgb2YgcmVhZC1jYWNoZS5jIGFuZCBicmVha2luZyB0aGluZ3MuIE1vc3Qg
b2YgdGhlIGNvZGUNCkkgZm91bmQgdGVuZHMgdG8gdXNlIHN0YXQgYW5kIHRoZW4gY29udmVydCB0
aGF0IHRvIGEgc2l6ZV90LCBub3QgdXNpbmcgdGhlDQptdW5nZWQgdW5zaWduZWQgaW50IGF0IGFs
bC4NCg0KTWF5YmUgc29tZW9uZSBlbHNlIHdpbGwgaGF2ZSBiZXR0ZXIgbHVjay4gVGhpcyBzZWVt
cyBvdmVyIG15IGhlYWQgOigNCg0KVGhhbmtzDQotLQ0KSmFzb24NCg0K

