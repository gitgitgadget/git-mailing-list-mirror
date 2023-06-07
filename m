Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B3C77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFGRn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjFGRnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 13:43:22 -0400
Received: from proofpoint7.lanl.gov (proofpoint7.lanl.gov [IPv6:2620:126:4000:1801::a7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368931FE3
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 10:43:19 -0700 (PDT)
Received: from pps.filterd (proofpoint7.lanl.gov [127.0.0.1])
        by proofpoint7.lanl.gov (8.17.1.19/8.17.1.19) with ESMTP id 357GUWjp010711;
        Wed, 7 Jun 2023 11:43:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=lanl;
 bh=/ScZrl/lx7fnEm/ouojfz2p3FmXPx1q0eKgFdXGhVTY=;
 b=bSBOWnVjxMaepBwzb10VU37Yuut3p42K5tlB1+o1s5M+znQkhRJEDZHDcXaEH6GiHnpy
 ydaHfOJABVEa0eQVS/d/rAJrEl4ZaRbDtbcaPA3fXdIbsf8gIHS0lo9EzHl1BWaOZ/Nr
 TLWrMb/N3LMbGPj9kImea4jUF3N6VVb1Gbdjee7E5UsyuY8ttwJltLgJ+kBPaRgDlc52
 hUywTiGyJORBwDvt07H7XwZ0wxS4VVPuV2sYETc7GVMbP52fZIVFMnCoacQoTQs63LaD
 Y4C1b64n8wIs0fVhU8Lw+aXa1vawSPF1y5ojyCrFtckNS0tUCYxhRFN0lv9T3MaUR513 Jw== 
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint7.lanl.gov (PPS) with ESMTP id 3r2a8smpyy-1;
        Wed, 07 Jun 2023 11:43:01 -0600
Received: from localhost (localhost [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 1E3161006795;
        Wed,  7 Jun 2023 11:43:01 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from EXG16-P-MBX03.win.lanl.gov (exg16-p-mbx03.win.lanl.gov [128.165.106.183])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 09FEC100B0E3;
        Wed,  7 Jun 2023 11:43:01 -0600 (MDT)
Received: from EXG16-P-MBX03.win.lanl.gov (128.165.106.183) by
 EXG16-P-MBX03.win.lanl.gov (128.165.106.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 11:43:00 -0600
Received: from EXG16-P-MBX03.win.lanl.gov ([fe80::b846:ac49:a5ce:ec30]) by
 EXG16-P-MBX03.win.lanl.gov ([fe80::b846:ac49:a5ce:ec30%2]) with mapi id
 15.01.2507.023; Wed, 7 Jun 2023 11:43:00 -0600
From:   "Priedhorsky, Reid" <reidpr@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? subprocesses can use wrong Git if $PATH is unset
Thread-Topic: bug? subprocesses can use wrong Git if $PATH is unset
Thread-Index: AQHZmWeA4YLzBfKCx0mB2y1FYKhliA==
Date:   Wed, 7 Jun 2023 17:43:00 +0000
Message-ID: <52BEE66B-934F-449F-A9BA-75B61A64A989@lanl.gov>
References: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
 <ZHk5V6U9gfkuwErH@tapette.crustytoothpaste.net>
 <412E82B5-79C0-4AAD-8219-AA7664E9EE1E@lanl.gov>
 <ZHpO9/4RSbeTy0HJ@tapette.crustytoothpaste.net> <xmqqwn0l72bg.fsf@gitster.g>
In-Reply-To: <xmqqwn0l72bg.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.165.106.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F2F8D8DAF6A23479793A9C686230F9B@win.lanl.gov>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 7QHbNY2ovu_YbZH1hJ4QW2IyXCZLW-_D
X-Proofpoint-GUID: 7QHbNY2ovu_YbZH1hJ4QW2IyXCZLW-_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IE9uIEp1biAyLCAyMDIzLCBhdCA3OjM4IFBNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBw
b2JveC5jb20+IHdyb3RlOg0KPiANCj4gImJyaWFuIG0uIGNhcmxzb24iIDxzYW5kYWxzQGNydXN0
eXRvb3RocGFzdGUubmV0PiB3cml0ZXM6DQo+IA0KPj4gT24gMjAyMy0wNi0wMiBhdCAxNjoxNDo0
NywgUHJpZWRob3Jza3ksIFJlaWQgd3JvdGU6DQo+Pj4gSGVsbG8gQnJpYW4sDQo+Pj4gDQo+Pj4g
SSBkbyB3b25kZXIgaWYgdGhlIGJlaGF2aW9yIHdvdWxkIGJlIHdvcnRoIGRvY3VtZW50aW5nLCBl
LmcuIGF0DQo+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0LXNjbS5j
b20vYm9vay9lbi92Mi9HaXQtSW50ZXJuYWxzLUVudmlyb25tZW50LVZhcmlhYmxlc19fOyEhQnQ4
ZkdocDhMaEtHUmchQ1RMREs5bjFwR0pUT0REcmFwVjlyX0pyeXBVQ2s1QV92NHc3Yno2R2dDVHo4
X3NnOTFrcHoySUQxTlJwdENqRzJiVU1pSjZmdEMtUGxNNCQgLA0KPj4+IHdoZXJlIEdpdOKAmXMg
cmVsYXRpb25zaGlwIHRvICRIT01FIGlzIGFsc28gZG9jdW1lbnRlZC4gSSB3b3VsZCBiZSBoYXBw
eQ0KPj4+IHRvIHN1Ym1pdCBhIHB1bGwgcmVxdWVzdC4NCj4+IA0KPj4gSSBkb24ndCB0aGluayBp
dCdzIG5lY2Vzc2FyeSwgc2luY2UgaXQncyBleHBlY3RlZCBiZWhhdmlvdXIgZm9yIG1lLCBidXQN
Cj4+IEkgYW0gbm90IHRoZSBvbmx5IHBlcnNvbiBvbiB0aGlzIGxpc3QsIGFuZCBwZXJoYXBzIG90
aGVycyB3b3VsZA0KPj4gYXBwcmVjaWF0ZSBhIHBhdGNoLg0KPiANCj4gSSB0ZW5kIHRvIGFncmVl
IHRoYXQgaXQgaXMgYW4gZXhwZWN0ZWQgYmVoYXZpb3VyLiAgSW4gYWRkaXRpb24sDQo+IHVuc2V0
dGluZyBQQVRIIGlzIG5vdCBzb21ldGhpbmcgcGVvcGxlIGRlbGliZXJhdGVseSBkbyBldmVyeSBk
YXkNCj4gd2l0aG91dCB1bmRlcnN0YW5kaW5nIGl0cyBpbXBsaWNhdGlvbnMsIHNvIEkgd291bGQg
cmF0aGVyIG5vdCBzZWUgdXMNCj4gYWRkICJpZiB5b3UgZG8gdGhpcyBlc3RlcmljIHRoaW5nLCB0
aGlzIHdvdWxkIGhhcHBlbiIgZm9yIHRoZW0uDQo+IA0KPiBUaGFua3MuDQoNClRoYW5rIHlvdTsg
dGhhdCBzb3VuZHMgbGlrZSBhIGNvbnNlbnN1cy4NCg0KVG8gYmUgY2xlYXIgdGhvdWdoLCB3ZSBk
aWRu4oCZdCB1bnNldCAkUEFUSCBvbiBwdXJwb3NlLiBXZSBmb3VuZCB1bmV4cGVjdGVkIGJlaGF2
aW9yIGFuZCB0cmFja2VkIGl0IGRvd24gdG8gYSBidWcgdGhhdCBjbGVhcmVkIHRoZSBlbnZpcm9u
bWVudCwgaW5jbHVkaW5nICRQQVRILg0KDQpUaGFua3MsDQpSZWlkDQoNCuKAlA0KaGUvaGlz
