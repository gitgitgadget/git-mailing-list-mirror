Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327CEC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCUPyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUPyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 11:54:12 -0400
Received: from proofpoint7.lanl.gov (proofpoint7.lanl.gov [IPv6:2620:126:4000:1801::a7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5325E30
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 08:54:05 -0700 (PDT)
Received: from pps.filterd (proofpoint7.lanl.gov [127.0.0.1])
        by proofpoint7.lanl.gov (8.17.1.19/8.17.1.19) with ESMTP id 32LApAjV007826;
        Tue, 21 Mar 2023 09:54:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=lanl;
 bh=7TXQ1U6oKeQZ4q4KSCXEzcL6ql/HDKbxYOMPvKkC0u4=;
 b=XFG6UEUOC5f3Xp4kDWtyGCqHvSpL966dumkEbnoqsnVG8bw1HY0u8Y3J2+2qjsHXWFz0
 2KBVaSZP5Rbnw0DCluRYXH0e6youzKNcPa2zyvqbWtNyV7CoPwxIYrN/og1Y0pmREIpJ
 2wiEa0sAsDjdhZBxVS5xNUbmE18qrYUvOlu1azybCDTZLSPW4I1a9ZnSZmO8ET3fy+tM
 PUSwSKydg4wZBfdDnEdVjswkEhLZyYhdGbNf8EFNKnjcZnDm6ded3Wk7INoDh+A7KK6Z
 hxjBPI5v09UE57SS6KSCYhZ5sbyU3zl4LPm0qosFslh+izeqFql73VEZ/APwdDPZb4XS FQ== 
Received: from mailrelay1.lanl.gov (mailrelay1.lanl.gov [128.165.4.101])
        by proofpoint7.lanl.gov (PPS) with ESMTP id 3pdv1a913f-1;
        Tue, 21 Mar 2023 09:54:03 -0600
Received: from localhost (localhost [127.0.0.1])
        by mailrelay1.lanl.gov (Postfix) with ESMTP id B124E100E22D;
        Tue, 21 Mar 2023 09:54:03 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay1.lanl.gov
Received: from EXG16-P-MBX08.win.lanl.gov (exg16-p-mbx08.win.lanl.gov [128.165.106.188])
        by mailrelay1.lanl.gov (Postfix) with ESMTP id 9FB5D100D4B3;
        Tue, 21 Mar 2023 09:54:03 -0600 (MDT)
Received: from EXG16-P-MBX03.win.lanl.gov (128.165.106.183) by
 EXG16-P-MBX08.win.lanl.gov (128.165.106.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 21 Mar 2023 09:54:03 -0600
Received: from EXG16-P-MBX03.win.lanl.gov ([fe80::9943:1574:6f23:46db]) by
 EXG16-P-MBX03.win.lanl.gov ([fe80::9943:1574:6f23:46db%2]) with mapi id
 15.01.2507.023; Tue, 21 Mar 2023 09:54:03 -0600
From:   "Priedhorsky, Reid" <reidpr@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Elijah Newren <newren@gmail.com>
Subject: Re: bug? round-trip through fast-import/fast-export loses files
Thread-Topic: bug? round-trip through fast-import/fast-export loses files
Thread-Index: AQHZXA1clcqo9qo/606puAoUqe5p6A==
Date:   Tue, 21 Mar 2023 15:54:03 +0000
Message-ID: <6486D136-23D8-4C90-AEDA-DD037A5CD2B5@lanl.gov>
References: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
 <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
In-Reply-To: <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.165.106.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4992ECC1BC023249B0D5F39F3286E003@win.lanl.gov>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 20FTe494u3e8eEkJsgNfX0IRTw0DGSw3
X-Proofpoint-GUID: 20FTe494u3e8eEkJsgNfX0IRTw0DGSw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IE9uIE1hciAyMCwgMjAyMywgYXQgNzo1NyBQTSwgRWxpamFoIE5ld3JlbiA8bmV3cmVuQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBUaGFua3MgZm9yIHRoZSB3ZWxsLXdyaXR0ZW4gYnVnIHJl
cG9ydCwgaW5jbHVkaW5nIG5vdCBvbmx5IGEgdGVzdGNhc2UNCj4gYnV0IGV2ZW4gdGhlIHJlbGV2
YW50IGJpdHMgb2YgdGhlIGZhc3QtZXhwb3J0IG91dHB1dC4NCg0K8J+YgQ0KDQo+IEEgYmV0dGVy
IHNvbHV0aW9uIHRoYXQgd291bGQgaGFuZGxlIGJvdGggRi0+RCBhbmQNCj4gRC0+RiB3b3VsZCBi
ZSBoYXZpbmcgZmFzdC1leHBvcnQgc29ydCB0aGUgZGlmZl9maWxlcGFpcnMgc3VjaCB0aGF0IGl0
DQo+IHByb2Nlc3NlcyB0aGUgZGVsZXRlcyBiZWZvcmUgdGhlIG1vZGlmaWVzLg0KDQpJbiBmYWN0
LCB0aGUgc3VjY2Vzc2Z1bCB3b3JrYXJvdW5kIGluIG15IG93biBjb2RlIGlzIHRvIHJlLW9yZGVy
IHRoZSBmYXN0LWV4cG9ydCBvdXRwdXQgaW4gZXhhY3RseSB0aGlzIHdheSAoaS5lLiwgc29ydCB0
aGUgbGluZXMgc28gYWxsIHRoZSBEIGxpbmVzIGNvbWUgYmVmb3JlIGFsbCB0aGUgTSBsaW5lcyku
DQoNCj4gQW5vdGhlciBpbXByb3ZlZCBzb2x1dGlvbg0KPiB3b3VsZCBiZSBoYXZpbmcgZmFzdC1p
bXBvcnQgc29ydCB0aGUgZmlsZXMgZ2l2ZW4gdG8gaXQgYW5kIGhhbmRsaW5nDQo+IGRlbGV0ZXMg
Zmlyc3QuICBFaXRoZXIgc2hvdWxkIGZpeCB0aGlzLg0KPiANCj4gTWlnaHQgYmUgYSBnb29kIHRh
c2sgZm9yIGEgbmV3IGNvbnRyaWJ1dG9yLiAgQW55IHRha2Vycz8gIChUYWdnaW5nIGFzDQo+ICNs
ZWZ0b3ZlcmJpdHMuKQ0KDQpMZXQgbWUgdGFrZSBhIGxvb2ssIGJ1dCBJIGNhbuKAmXQgZ3VhcmFu
dGVlIGFueXRoaW5nLg0KDQpIVEgsDQpSZWlkDQoNCuKAlA0KaGUvaGlzDQoNCg==
