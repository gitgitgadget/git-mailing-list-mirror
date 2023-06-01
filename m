Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9DC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 22:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFAWsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFAWsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 18:48:03 -0400
X-Greylist: delayed 1614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 15:48:01 PDT
Received: from proofpoint8.lanl.gov (proofpoint8.lanl.gov [IPv6:2620:126:4000:1801::a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA2133
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 15:48:01 -0700 (PDT)
Received: from pps.filterd (proofpoint8.lanl.gov [127.0.0.1])
        by proofpoint8.lanl.gov (8.17.1.19/8.17.1.19) with ESMTP id 351M100i032594
        for <git@vger.kernel.org>; Thu, 1 Jun 2023 16:21:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=lanl; bh=qfPMCVXNYvfU4Z1CUeRQu04zjVy9ZBCGfHovWgyn65Q=;
 b=W3NGFfBRiezf4G/Swv8zlI0eJMhzMYBCweU/dDgfm9QmJGxBQ9iwxiUfdFR0aKQ4PRMT
 GJ+emC6rgUYyk0oiaseR6xpSCUYHoxbUapzhRorPfC80APT9tH2y62Relmes/Ll+1CWX
 beGMCsgDuxtB58aQwq8UuEThxIXIaNW6sLazPSipVkRJR2I2iZlZdZJoqK98b8m/xYsB
 zZPDf7hQ4FNjqkHdybtJY7XkEvvL3r1G4IUaQ6NbEcU9pILl729+whTlwzFauV3LvXtF
 8t7Af9c19Puw2bqjvJlCbHwMLvP6OvPi1t2ZDbhgxGiO+A0Bjt+f4r4fZ2r8j/672Yo5 aQ== 
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint8.lanl.gov (PPS) with ESMTP id 3qxuctcsua-1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 16:21:06 -0600
Received: from localhost (localhost [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 3544A100B17B
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 16:21:06 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from EXG16-P-MBX06.win.lanl.gov (exg16-p-mbx06.win.lanl.gov [128.165.106.186])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 238D4100B178
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 16:21:06 -0600 (MDT)
Received: from EXG16-P-MBX03.win.lanl.gov (128.165.106.183) by
 EXG16-P-MBX06.win.lanl.gov (128.165.106.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 16:21:05 -0600
Received: from EXG16-P-MBX03.win.lanl.gov ([fe80::b846:ac49:a5ce:ec30]) by
 EXG16-P-MBX03.win.lanl.gov ([fe80::b846:ac49:a5ce:ec30%2]) with mapi id
 15.01.2507.023; Thu, 1 Jun 2023 16:21:05 -0600
From:   "Priedhorsky, Reid" <reidpr@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug? subprocesses can use wrong Git if $PATH is unset
Thread-Topic: bug? subprocesses can use wrong Git if $PATH is unset
Thread-Index: AQHZlNdb0yWI+I78EEOFCcjxE1B05w==
Date:   Thu, 1 Jun 2023 22:21:05 +0000
Message-ID: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.165.106.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8072894698E44B87F8DC91EC4FEC69@win.lanl.gov>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-GUID: bB054kd9_q7m6KoOPegI3D912s48na86
X-Proofpoint-ORIG-GUID: bB054kd9_q7m6KoOPegI3D912s48na86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQoNCkkgbWF5IGhhdmUgZm91bmQgYSBidWcgaW4gR2l0LiBJdCBzZWVtcyB0aGF0IGlm
ICgxKSBtdWx0aXBsZSBnaXQoMSkgYXJlIGluc3RhbGxlZCBvbiB0aGUgc3lzdGVtLCAoMikgb25l
IGlzIGluIHRoZSBzaGVsbOKAmXMgZGVmYXVsdCBwYXRoIChpLmUuLCB1c2VkIGlmICRQQVRIIGlz
IHVuc2V0LCBub3QgdGhlIGRlZmF1bHQgdmFsdWUgb2YgJFBBVEgpLCBhbmQgKDMpIHRoZSBkZXNp
cmVkIGdpdCgxKSBpcyBhdCBhIGRpZmZlcmVudCBwYXRoLCB0aGVuIHN1YnByb2Nlc3NlcyBvZiB0
aGUgZGVzaXJlZCBnaXQoMSkgaW52b2tlIHRoZSB1bmRlc2lyZWQgZ2l0KDEpIGluc3RlYWQuDQoN
CiRQQVRIIHVuc2V0IGlzIGluZGVlZCBhIHBhdGhvbG9naWNhbCBzaXR1YXRpb247IG9uZSBvZiBv
dXIgb3duIGJ1Z3MgaW4gb3VyIHNvZnR3YXJlIHRoYXQgY2FsbHMgZ2l0KDEpIGluYXBwcm9wcmlh
dGVseSBjbGVhcmVkIGl0LiBIb3dldmVyLCBpbiBteSB2aWV3IGl04oCZcyBzdXJwcmlzaW5nIGVu
b3VnaCB0byBiZSBhIHVzYWJpbGl0eSBidWcuIEkgd291bGQgZXhwZWN0IGdpdCgxKSB0byBjYWxs
IGl0c2VsZiBmb3Igc3VicHJvY2Vzc2VzIHJlZ2FyZGxlc3Mgb2YgdGhlIGVudmlyb25tZW50Lg0K
DQo+IFRoYW5rIHlvdSBmb3IgZmlsbGluZyBvdXQgYSBHaXQgYnVnIHJlcG9ydCENCj4gUGxlYXNl
IGFuc3dlciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91
ciBpc3N1ZS4NCj4NCj4gV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAo
U3RlcHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNzdWUpDQoNCjEuIElmIC91c3IvYmluL2dpdCBleGlz
dHMsIG1vdmUgaXQgb3V0IG9mIHRoZSB3YXkuDQoNCjIuIFdyaXRlIGEgc2hlbGwgc2NyaXB0IGF0
IC91c3IvYmluL2dpdCB0aGF0IHByaW50cyBhbiBlcnJvciBtZXNzYWdlIGFuZCB0aGVuIGZhaWxz
Lg0KDQozLiBJbnN0YWxsIGEgZGlmZmVyZW50IEdpdCBhdCBwcmVmaXggb3RoZXIgdGhhbiAvdXNy
IGFuZCBwdXQgaXQgaW4geW91ciBwYXRoIGJlZm9yZSAvdXNyL2Jpbi4NCg0KNC4gUnVuIHRoZSBm
b2xsb3dpbmcgUHl0aG9uIHNjcmlwdC4gKEl04oCZcyBQeXRob24gYmVjYXVzZSBJIGtub3cgaG93
IHRvIG1hbmlwdWxhdGUgdGhlIGVudmlyb25tZW50IGhvdyBJIHdhbnRlZCwgYW5kIEkgZG9u4oCZ
dCBpbiBzaGVsbC4pDQoNCn5+fn4NCiMhL3Vzci9iaW4vZW52IHB5dGhvbjMNCg0KaW1wb3J0IG9z
DQppbXBvcnQgc3VicHJvY2Vzcw0KaW1wb3J0IHN5cw0KDQpkZWYgY2hkaXIocCk6DQogICBwcmlu
dCgiIiwgZmlsZT1zeXMuc3RkZXJyKQ0KICAgcHJpbnQoIiQgY2QgJXMiICUgcCwgZmlsZT1zeXMu
c3RkZXJyKQ0KICAgb3MuY2hkaXIocCkNCg0KZGVmIGMobXNnLCBhcmd2LCAqKmt3YXJncyk6DQog
ICBwcmludCgiIiwgZmlsZT1zeXMuc3RkZXJyKQ0KICAgcHJpbnQoIiMgIiArIG1zZywgZmlsZT1z
eXMuc3RkZXJyKQ0KICAgcHJpbnQoIiQgIiArICIgIi5qb2luKGFyZ3YpLCBmaWxlPXN5cy5zdGRl
cnIpDQogICB0cnk6DQogICAgICBzdWJwcm9jZXNzLnJ1bihhcmd2LCBjaGVjaz1UcnVlLCAqKmt3
YXJncykNCiAgIGV4Y2VwdCBzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvciBhcyB4Og0KICAg
ICAgcHJpbnQoIiMgY29tbWFuZCBmYWlsZWQgd2l0aCBleGl0IGNvZGUgJWQiICUgeC5yZXR1cm5j
b2RlKQ0KICAgZWxzZToNCiAgICAgIHByaW50KCIjIHN1Y2Nlc3MiKQ0KDQpjKCJmYWtlIHN5c3Rl
bSBHaXQgY29udGVudHMiLCAgWyJjYXQiLCAiL3Vzci9iaW4vZ2l0Il0pDQpjKCJwYXRoIHRvIGRl
c2lyZWQgR2l0IiwgICAgICAgWyJ3aGljaCIsICJnaXQiXSkNCmMoIkdpdCB2ZXJzaW9uIiwgICAg
ICAgICAgICAgICBbImdpdCIsICItLXZlcnNpb24iXSkNCg0KY2hkaXIoIi90bXAiKQ0KYygicmVt
b3ZlIGV4aXN0aW5nIHRlc3QgcmVwbyIsIFsicm0iLCAiLVJmIiwgInRlc3QiXSkNCmMoImNyZWF0
ZSB0ZXN0IHJlcG8iLCAgICAgICAgICBbImdpdCIsICJpbml0IiwgIi1xIiwgInRlc3QiXSkNCmNo
ZGlyKCJ0ZXN0IikNCg0KYygidGVzdCBjb21taXQgQSIsICAgICAgICAgICAgIFsiZ2l0IiwgImNv
bW1pdCIsICItbSIsICJhIiwgIi0tYWxsb3ctZW1wdHkiXSkNCmMoImJyYW5jaCIsICAgICAgICAg
ICAgICAgICAgICBbImdpdCIsICJjaGVja291dCIsICItYiIsICJmb28iXSkNCmMoInRlc3QgY29t
bWl0IEIiLCAgICAgICAgICAgICBbImdpdCIsICJjb21taXQiLCAiLW0iLCAiYiIsICItLWFsbG93
LWVtcHR5Il0pDQoNCiMgVGhpcyB1c2VzIHRoZSBleGlzdGluZyAkUEFUSCB0byBmaW5kIGdpdCgx
KSwgYnV0IHRoZW4gcnVucyBpdCB3aXRoIGFuIGVtcHR5DQojIGVudmlyb25tZW50Lg0KYygiY2hl
Y2tvdXQgdy8gZW1wdHkgZW52IiwgICAgIFsiZ2l0IiwgImNoZWNrb3V0IiwgIm1hc3RlciJdLCBl
bnY9ZGljdCgpKQ0Kfn5+fg0KDQo+IFdoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhh
dmlvcikNCj4gKE5vdGUgcmUtb3JkZXJpbmcgZm9yIGNsYXJpdHkuKQ0KDQpTY3JpcHQgb3V0cHV0
Og0KDQojIGZha2Ugc3lzdGVtIEdpdCBjb250ZW50cw0KJCBjYXQgL3Vzci9iaW4vZ2l0DQojIS9i
aW4vc2gNCmVjaG8gJ3lvdSBzaG91bGQgbm90IHNlZSB0aGlzJyAxPiYyDQpleGl0IDENCiMgc3Vj
Y2Vzcw0KDQojIHBhdGggdG8gZGVzaXJlZCBHaXQNCiQgd2hpY2ggZ2l0DQovdXNyL2xvY2FsL2Jp
bi9naXQNCiMgc3VjY2Vzcw0KDQojIEdpdCB2ZXJzaW9uDQokIGdpdCAtLXZlcnNpb24NCmdpdCB2
ZXJzaW9uIDIuNDEuMA0KIyBzdWNjZXNzDQoNCiQgY2QgL3RtcA0KDQojIHJlbW92ZSBleGlzdGlu
ZyB0ZXN0IHJlcG8NCiQgcm0gLVJmIHRlc3QNCiMgc3VjY2Vzcw0KDQojIGNyZWF0ZSB0ZXN0IHJl
cG8NCiQgZ2l0IGluaXQgLXEgdGVzdA0KIyBzdWNjZXNzDQoNCiQgY2QgdGVzdA0KDQojIHRlc3Qg
Y29tbWl0IEENCiQgZ2l0IGNvbW1pdCAtbSBhIC0tYWxsb3ctZW1wdHkNClttYXN0ZXIgKHJvb3Qt
Y29tbWl0KSAwM2UyZWIwXSBhDQojIHN1Y2Nlc3MNCg0KIyBicmFuY2gNCiQgZ2l0IGNoZWNrb3V0
IC1iIGZvbw0KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICdmb28nDQojIHN1Y2Nlc3MNCg0KIyB0
ZXN0IGNvbW1pdCBCDQokIGdpdCBjb21taXQgLW0gYiAtLWFsbG93LWVtcHR5DQpbZm9vIGM0MTdj
ZWVdIGINCiMgc3VjY2Vzcw0KDQojIGNoZWNrb3V0IHcvIGVtcHR5IGVudg0KJCBnaXQgY2hlY2tv
dXQgbWFzdGVyDQp5b3Ugc2hvdWxkIG5vdCBzZWUgdGhpcw0KIyBjb21tYW5kIGZhaWxlZCB3aXRo
IGV4aXQgY29kZSAxDQoNCj4gV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3Rl
ZCBiZWhhdmlvcikNCg0KRXZlcnkgY29tbWFuZCBpbiB0aGUgc2NyaXB0IHNob3VsZCBiZSBzdWNj
ZXNzZnVsLiBJbiBwYXJ0aWN1bGFyLCBJIGV4cGVjdGVkIHRoZSBmaW5hbCBvdXRwdXQgdG8gYmU6
DQoNCiMgY2hlY2tvdXQgdy8gZW1wdHkgZW52DQokIGdpdCBjaGVja291dCBtYXN0ZXINClsuLi4g
bm9ybWFsIGNoZWNrb3V0IGNoYXR0ZXIgLi4uXQ0KIyBzdWNjZXNzDQoNCj4gV2hhdCdzIGRpZmZl
cmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVk
Pw0KDQovdXNyL2xvY2FsL2Jpbi9naXQgY2FsbGVkIC91c3IvYmluL2dpdCBmb3Igc29tZSBzdWJw
cm9jZXNzLiBJIGV4cGVjdGVkIGl0IHRvIGNhbGwgaXRzZWxmLg0KDQo+IEFueXRoaW5nIGVsc2Ug
eW91IHdhbnQgdG8gYWRkDQoNClVzdWFsbHkgZm9yIHVzLCB0aGUgdmVyc2lvbiBza2V3IGlzIGNs
b3NlIGVub3VnaCB0aGF0IGV2ZXJ5dGhpbmcgc2VlbWVkIHRvIHdvcmsuIEkgYmVsaWV2ZSB3ZSBp
bnN0YWxsZWQgR2l0IDIuNDAuMCBhbmQgc3VicHJvY2Vzc2VzIHdlcmUgcHJlc3VtYWJseSB1c2lu
ZyB0aGUgc3lzdGVt4oCZcyAyLjMxIGFuZCBldmVyeXRoaW5nIGFwcGVhcmVkIHRvIHdvcmsgZmlu
ZS4gT25seSB3aGVuIHdlIHRyaWVkIG91ciBzb2Z0d2FyZSBvbiBhIGRpZmZlcmVudCBib3ggd2hl
cmUgdGhlIHN5c3RlbSBHaXQgd2FzIDEuOCBkaWQgaXQgY3Jhc2guIFRoZXJlZm9yZSwgSSB3b3Jy
eSBhYm91dCBzaWxlbnQgcHJvYmxlbXMgZHVlIHRvIHZlcnNpb24gc2tldyBpbiB0aGUgaW50ZXJu
YWwgY29tbWFuZC1saW5lIEFQSS4NCg0KPiBQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBi
dWcgcmVwb3J0IGJlbG93Lg0KPiBZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdp
c2ggdG8gc2hhcmUuDQo+DQo+IFtTeXN0ZW0gSW5mb10NCj4gZ2l0IHZlcnNpb246DQo+IGdpdCB2
ZXJzaW9uIDIuNDEuMA0KPiBjcHU6IHg4Nl82NA0KPiBubyBjb21taXQgYXNzb2NpYXRlZCB3aXRo
IHRoaXMgYnVpbGQgW0kgYnVpbHQgdGhlIHNvdXJjZSB0YXJiYWxsXQ0KPiBzaXplb2YtbG9uZzog
OA0KPiBzaXplb2Ytc2l6ZV90OiA4DQo+IHNoZWxsLXBhdGg6IC9iaW4vc2gNCj4gdW5hbWU6IExp
bnV4IDUuMTAuMC0yMy1hbWQ2NCAjMSBTTVAgRGViaWFuIDUuMTAuMTc5LTEgKDIwMjMtMDUtMTIp
IHg4Nl82NA0KPiBjb21waWxlciBpbmZvOiBnbnVjOiAxMC4yDQo+IGxpYmMgaW5mbzogZ2xpYmM6
IDIuMzENCj4gJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi9iYXNo
DQo+DQo+IFtFbmFibGVkIEhvb2tzXQ0KDQpUaGFua3MsDQpSZWlkDQoNCuKAlA0KaGUvaGlzDQoN
Cg==
