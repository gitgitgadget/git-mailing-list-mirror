Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C77FC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100F2610FC
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhDZUsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:48:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232492AbhDZUsw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Apr 2021 16:48:52 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QKiSSC026802;
        Mon, 26 Apr 2021 13:48:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iQNyJEiurp7KZ859clM9O6nyM9sg4URZy2uHzjEQ3LE=;
 b=Vdz2RU3y6f9+d5a3FXZmzZPArGkQ1hHWtBMGODSbPgiyzCgk67H+RDzMnAu9mVuzFcpm
 2hVnm/vgif/OPS1JvWJINgX9fAGZw0pE561EmQhUipZGPDfuJgQVLtn55ZJa4OBn3eWz
 U0BXwI2ot2Pk9VqmM7IxC9KxVAu6B5H9Yok= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38627r90rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 13:48:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 13:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f86L/W1x7l/Q2+7ahF98OJocV8AqvyHxZNuw948cvu6p4A35wYOBRbeRrtpMQ3mfAUR0RPoqzPO+wOoFxikNZ7eTtHUHn3q8o7mm8T8prhjmCujVjyHEjKP3ORyS3BUwHhHnR7dMTr6U8aFLwag4dtTmBmCxN98RDFTrRTJkZlTK7yrzD7iDdKfHGyLn+8RxqYhY53Um6Up0Nd1q+jwbBTPPCOVsxl4N8Zyf5Ujn6ZdZuQDU3swczqx8oG7HWplAISKbSkJQ23kZwNHxBkwRBHT13Q0NxcSMGgAVePSIXv6QEhldcOsdo104HZlZGeuNR0DDRRywzPCbgfmyYiqYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQNyJEiurp7KZ859clM9O6nyM9sg4URZy2uHzjEQ3LE=;
 b=UzfkRkO6p6K/4FheYEYai/1TJF3LIUMXQUtx+6p2KCor8JtFAvLmY1nB4aJx0V3cijrcHpu46BAXfsOvAJuTps73+PQp8Fu4LNir3vRE3WoejyGF07qMho9UydTjpO26wMnYFqYdFdekPzr7rHnw2Ith7ytJg0zIJzcaF+eyT3W2R1fSm3l9ojnYB1wRkoh1k26I45FIXWUMmVChBt8vu75GxLT8ajqL6MLYfWZVM9VXhgxeIl7Xwulf1Zp3bOoM44rH7f2gilksD0QbYseKy4J0a6CxL+fHNL5kwm2uOZdEwUV4VdkTKKFPfZMvfQcFn1TyJ/SkznEtKqMldtMZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3697.namprd15.prod.outlook.com (2603:10b6:a03:1b3::32)
 by BYAPR15MB3269.namprd15.prod.outlook.com (2603:10b6:a03:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 20:48:07 +0000
Received: from BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::60ca:e5a2:a17b:70e7]) by BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::60ca:e5a2:a17b:70e7%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 20:48:07 +0000
From:   Shoaib Meenai <smeenai@fb.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] ** glob pattern in git diff doesn't match root directory
Thread-Topic: [BUG] ** glob pattern in git diff doesn't match root directory
Thread-Index: AQHXOLTY90qVDB3WrkWA7U/v+Lwk5KrGeVuAgABazQA=
Date:   Mon, 26 Apr 2021 20:48:07 +0000
Message-ID: <CE391060-0F01-449A-BBAA-B0C577D759A6@fb.com>
References: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
 <87k0oq21md.fsf@evledraar.gmail.com>
In-Reply-To: <87k0oq21md.fsf@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [67.188.238.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8776782-9fb7-48c1-0f8e-08d908f49880
x-ms-traffictypediagnostic: BYAPR15MB3269:
x-microsoft-antispam-prvs: <BYAPR15MB326975A231DDDACE6A9C4135C9429@BYAPR15MB3269.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJOVesNGEpmw2yr3gdqB1z/unT0M+T8dAIHpSvvBQNdalrWuNMfH44YbVhQJLHavV0AtfS7mDJp0IqXcPpiRLG/uj8LsQqiUw4npVUjZt50XAze5FLYhjR3enKx4sAPsLY8M8KMsqhg0WA6oMHwX3Wh8kmWOpxO48gDE7coKDLOqbisnAHGnAGazxs3do0o7uN+YzcEEnQZS7WPRLsgcIEVULgxc/bm5yfrtdqA5rafue8L5cOfKh+Ct6nDs3cu1RSqGfNsquQLDD/FYLHX3RLOxgMg1Ke6SqWLyI4QsF7xgBdfbevdhQHDZM5k8YEoCltQUt6ys+iJZIZCQ2ozdCevVqNdvA3net91o5Vwr4BBx95kWzz/BK7zCg1DwgpbGTFl6ELlsLUVr1jVt5wm8tEYYH50cK5aDFcKj/gFz/h3IYA28heGJIn0RHCzGlMS74olEzE3cI4orFI+zv2kRVPHg72GX/tUGju2nZUw7oXbwYsD+pslyfCu5wubIwg991i1yY9HCEFT9Qnk3ydrZJhSdqtzLAFHyR1nEqyJU6CQCF+micof9RfBs1CbHbwSCMeuoC+vQIF01oCRh32xvKzvH45KtrY+fOUpm2fCFjQm+MB1Dm+UwMHyyOsn7AH6fhL8Dd6DHT8GH5z9FWvwz6oN3FLWDtg0SY6nOg8EYcSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3697.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(122000001)(6486002)(36756003)(26005)(6916009)(2616005)(186003)(53546011)(6506007)(5660300002)(478600001)(38100700002)(66446008)(76116006)(2906002)(64756008)(66556008)(6512007)(8936002)(86362001)(8676002)(316002)(66946007)(33656002)(4326008)(66476007)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RkNGUUtKV1I1UVQ4cllWSkMrd2dwTjVJNUc4b3BPN0JZSDhWWk1wSHZ1SkJF?=
 =?utf-8?B?WG1GRmlwWVVVVEQ2WXNUV2taUys1RjlaQi9kT3d3K2E0WU9CQk5UQnIzV3Nt?=
 =?utf-8?B?S0hhaCtsa3hqWUIrOGd1d3VPSi9FQTZvZHRzRkoyQ3hPNXNpUVF5Q1ZYcGdx?=
 =?utf-8?B?WDgxbDRvS292SDNaaTg4Q2hrSERKVG1UdkdjTXF1QlZZOEQ4Z1haRklPZE1h?=
 =?utf-8?B?K3RwaGJaTUdGbzZpbDNWWEZYTGhnc3VBdzVySWRBY25leDV1aU4vZ3JQM0ZQ?=
 =?utf-8?B?R2J6U1RIUHcvbXVmbTJoZDJhbDQ4eDhvTldzMDE0RzYzRHpSeEtaaElSOGQ4?=
 =?utf-8?B?TXpVTUZ3bWtiWGQybjdTWFU2dTZGRTdOWXU2UmlZUlNNTk82OVRicTFIN0hN?=
 =?utf-8?B?R2N1WVBoanE5SDdwelo1anRBamZHcEErdkpBdWlyZUhxMlFPbFV4U29lOEMv?=
 =?utf-8?B?ZW1QZFB6ZExsUXA5OG9tK2dJc0xBaU5TRVA1VFZXd3pWVVg5N0Z0WFF6bkhh?=
 =?utf-8?B?bVVtc0NnV012QmNRUWlJOFoyU1FIU2hWVXVtQ2taQVBHSFdpTEhhb1RDNytH?=
 =?utf-8?B?RG1IUUFHTWdBMDVYZVpLSXZ2TEhuNFJLQ3Y3MVZvNU1teU9wSDBWV3J6cngz?=
 =?utf-8?B?Mmo1TEZYdHJjbkJHcHIxL2oxb1JoWFowTUFqNFoxd3B4RUpTUGJEREkwUzZl?=
 =?utf-8?B?QS9DcG4vcThHRGlLVFQyckdQZXJTU0JQdkdJWVhQQjJnYm5TblViWlc2dGpE?=
 =?utf-8?B?TW5Mb0JrWEJCL2gwWENZZDQxc2FvdGFoWUJzSDFyeTFxVWVsTENkbWhVN01v?=
 =?utf-8?B?aU1UdEdSbFhySEhLY1FXUi9GL0YvWUpIQXk0bi9mWjBKZnIvUTZTbS9ESElS?=
 =?utf-8?B?RklXTXIyMlV2TlF2TjFINFlNVXhFM05BK09idGVQZEtvQ0xTYTNPWG5YMy9Z?=
 =?utf-8?B?YVZ5dVh6UVkxZERWN0pxdmFuYVZHc3ZScXF4RTF5amJrZTFINEFPN0IxaHN2?=
 =?utf-8?B?SUZ0ck16NnZ6clhPL2ttaEs0YW4vQkw4bHc5ZWhwMWdIUGwxNUdITmFQdld3?=
 =?utf-8?B?SkdGbHAybXJabDk3OWlqb2ZBTjBKeXFiSHZrOGdjb3hROGFOMjRMM0Z2aEV5?=
 =?utf-8?B?VkxwN0FKc1dndm5TVDdJNm54UDZvazEvd2JYY1RjQkU1OEpXM3VjTEMvbjdB?=
 =?utf-8?B?Rm9sT2Z5S0FUN2FHc01RaHBzcmZ2VVVWRG56YXdCeUVOQ3BLN3NGWnpSTXZR?=
 =?utf-8?B?VnNKd2NwRVBvc3dQQzArb2NlbTBEV3R0VlErejhrcENzMkJKcFI2RGhwM0hM?=
 =?utf-8?B?L1h5clVxTG5MZUlGamplZ3BsbUlHUTZ0ejVpUHoyd0ExUHlKNlk3eVIweG41?=
 =?utf-8?B?cXRuYlREL1gycTBOZVFmV3Ayalh0WDR0c3ZQZEoydlBBbE5UOWxJdW50KzdG?=
 =?utf-8?B?Tzhidm1pRnJzV1dqMnZwOUlrWlFaVDBoZkl6ZlNGQ0Y1OTRZVjcyQzNxQXBt?=
 =?utf-8?B?RHpZbW9LdGxzYUlMUHhFcnZBZHVWSEYvZDRjVzNjLzZpcFhLUkVrSEI3WTRk?=
 =?utf-8?B?QmRrWDBTeGlTMnFad3pPSFQyYjd4aHp6UUJJZGhqL0RRTU9uMmpPZ09WNzQy?=
 =?utf-8?B?VUJPaGt5WGhQL0xxZTFoMFYweklZSTZrVVcvaVlxNzNEcXpmVHlZUkNtVXpw?=
 =?utf-8?B?YmNpa0lWYWptNTBtd1hkL2pQdG1JUVdVczBLaTE2ZEZoV01jZEx6K1VQWnBa?=
 =?utf-8?Q?eTgUREJvclIkKOrpCYpkwCWhKneW1bYYUG2T1sx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <011598A7A3E8D043A0D77C4815EC5376@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3697.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8776782-9fb7-48c1-0f8e-08d908f49880
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 20:48:07.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHAsSIk4HPkUHGC00qRyFOn9AkJvf1a1iJFFUpKzdhS187yWTsLx8UViCJ5vWIuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3269
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: nd2DWRwOogApVRbFwrEhF99e2kpkuzRf
X-Proofpoint-GUID: nd2DWRwOogApVRbFwrEhF99e2kpkuzRf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPbiA0LzI2LzIxLCAxOjIzIEFNLCAiPT91dGYtOD9CP3c0WjJZWElnUVhKdVptckR0bkxEc0E9
PT89IEJqYXJtYXNvbiIgPGF2YXJhYkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiBTYXQsIEFwciAy
NCAyMDIxLCBTaG9haWIgTWVlbmFpIHdyb3RlOg0KPg0KPj4gSGkgYWxsLA0KPj4NCj4+IFdoZW4g
SSB1c2UgYSBgKiovYCBnbG9iIHBhdHRlcm4gd2l0aCBgZ2l0IGRpZmZgLCBpdCBkb2Vzbid0IHNl
ZW0gdG8NCj4+IG1hdGNoIGluIHRoZSByb290IGRpcmVjdG9yeS4gVGhlIGRvY3VtZW50YXRpb24g
Zm9yIGdpdGdub3JlIHNheXMgdGhhdCBhDQo+PiBsZWFkaW5nIGAqKi9gIHNob3VsZCBtYXRjaCBp
biBhbGwgZGlyZWN0b3JpZXMsIGFuZCBJIHdvdWxkIGV4cGVjdCBpdCB0bw0KPj4gYmVoYXZlIHRo
ZSBzYW1lIHdheSBmb3IgYGdpdCBkaWZmYC4gRm9yIGV4YW1wbGU6DQo+Pg0KPj4gJCBnaXQgLS12
ZXJzaW9uDQo+PiBnaXQgdmVyc2lvbiAyLjMxLjEuNTI3Lmc0N2U2ZjE2OTAxICMgYnVpbHQgZnJv
bSB0aGUgYG5leHRgIGJyYW5jaA0KPj4gJCBta2RpciAvdG1wL2dsb2J0ZXN0ICYmIGNkIC90bXAv
Z2xvYnRlc3QNCj4+ICQgZ2l0IGluaXQNCj4+ICQgZWNobyBmb28gPiBmb28NCj4+ICQgbWtkaXIg
c3ViDQo+PiAkIGVjaG8gc3ViZm9vID4gc3ViL2Zvbw0KPj4gJCBnaXQgYWRkIC4NCj4+ICQgZ2l0
IGNvbW1pdCAtbSAnSW5pdGlhbCBjb21taXQnDQo+PiAkIGVjaG8gYmFyID4gZm9vDQo+PiAkIGVj
aG8gc3ViYmFyID4gc3ViL2Zvbw0KPj4gJCBnaXQgLS1uby1wYWdlciBkaWZmICcqKi9mb28nDQo+
PiBkaWZmIC0tZ2l0IGEvc3ViL2ZvbyBiL3N1Yi9mb28NCj4+IGluZGV4IGVmNzg4OWYuLjJiMmFi
NmMgMTAwNjQ0DQo+PiAtLS0gYS9zdWIvZm9vDQo+PiArKysgYi9zdWIvZm9vDQo+PiBAQCAtMSAr
MSBAQA0KPj4gLXN1YmZvbw0KPj4gK3N1YmJhcg0KPj4NCj4+IE9ubHkgdGhlIGRpZmYgdG8gYHN1
Yi9mb29gIGlzIHByaW50ZWQsIHdoZXJlYXMgSSdkIGV4cGVjdCB0aGUgY2hhbmdlIHRvDQo+PiB0
aGUgdG9wLWxldmVsIGBmb29gIHRvIGJlIHByaW50ZWQgYXMgd2VsbC4gYGdpdCBkaWZmICcqKmZv
bydgIGRvZXMgYmVoYXZlDQo+PiBhcyBJIHdvdWxkIGV4cGVjdC4gVGhpcyBhbHNvIGhhcHBlbnMg
d2l0aCBhIGAqKmAgaW4gdGhlIG1pZGRsZSBvZiBhDQo+PiBwYXR0ZXJuOyBlLmcuLCBgc3ViLyoq
L2JhcmAgd2lsbCBtYXRjaCBgc3ViL2Rpci9iYXJgIGJ1dCBub3QgYHN1Yi9iYXJgLg0KPj4NCj4+
IEFtIEkgbWlzdW5kZXJzdGFuZGluZyBob3cgYCoqYCBzaG91bGQgd29yaywgb3IgaXMgdGhpcyBh
IGJ1Zz8NCj4NCj4gSXQncyBub3QgYSBidWcgaW4gYmVoYXZpb3IsIGJ1dCByZWFkaW5nIHRoZSBk
b2N1bWVudGF0aW9uIEkgdGhpbmsgaXQncw0KPiBidWdneSBpbiBkZXNjcmliaW5nIGhvdyBpdCB3
b3Jrcy4NCj4NCj4gVGhlIGJlaGF2aW9yIG9mICoqIGhlcmUgaXMgdG8gbWF0Y2ggYW55dGhpbmcs
IGluY2x1ZGluZyBhIHNsYXNoLCBidXQgeW91DQo+IHlvdXJzZWxmIGFyZSBwcm92aWRpbmcgdGhl
IHNsYXNoIHdpdGggIioqLyIuDQo+DQo+IFRoaXMgYmVoYXZpb3IgaXMgZGlmZmVyZW50IHVuZGVy
IDooZ2xvYikgd2hlcmUgd2Ugd291bGQgbWF0Y2ggImZvbyIgb24NCj4gdGhlIHRvcC1sZXZlbC4N
Cj4NCj4gU2VlIHQvdDMwNzAtd2lsZG1hdGNoLnNoLCBpcyBwYXJ0aWN1bGFyIHRoZSAiKiovZm9v
IiB0ZXN0LWNhc2UuDQo+DQo+IFdlIGFkb3B0ZWQgdGhpcyBjb2RlIGZyb20gcnN5bmMgb3JpZ2lu
YWxseSwgSSB0aGluayBpdHMgbWFudWFsIHBhZ2UgaXMNCj4gYmV0dGVyIGF0IGRlc2NyaWJpbmcg
aG93IGl0IHdvcmtzLCBhcyBhbiBhc2lkZSBJIHNlZSB0aGV5J3ZlIHNpbmNlIGFkZGVkDQo+IGEg
IioqKiIgd2hpY2ggd2Ugd29uJ3QgaGF2ZSwgYW5kIG1heWJlIHNvbWUgb3RoZXIgZmVhdHVyZXMu
DQoNCkdvdCBpdCwgdGhhbmsgeW91ISBJIHdhcyBwcm92aWRpbmcgYSBzbGFzaCBteXNlbGYgYmVj
YXVzZSBteSBpbnRlbnRpb24NCndhcyB0byBvbmx5IG1hdGNoIHBhdGhzIHRoYXQgYXJlIGV4YWN0
bHkgImZvbyIsIHdoZXJlYXMgZS5nLiAnKipmb28nDQp3b3VsZCBhbHNvIG1hdGNoICdzb21lX3By
ZWZpeF9hbmRfdGhlbl9mb28nLiBgOihnbG9iKWAgZG9lcyBleGFjdGx5IHdoYXQNCkkgd2FudCB0
aG91Z2g7IHRoYW5rIHlvdS4NCg0K
