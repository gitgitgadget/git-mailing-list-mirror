Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDBBC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 16:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjFBQP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbjFBQPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 12:15:25 -0400
Received: from proofpoint7.lanl.gov (proofpoint7.lanl.gov [IPv6:2620:126:4000:1801::a7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65455E58
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 09:15:03 -0700 (PDT)
Received: from pps.filterd (proofpoint7.lanl.gov [127.0.0.1])
        by proofpoint7.lanl.gov (8.17.1.19/8.17.1.19) with ESMTP id 352FJvUg009722;
        Fri, 2 Jun 2023 10:14:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=lanl;
 bh=N7X585WeFHYjo90xZLzrulhB1PY2EcP3u02u94YH3Es=;
 b=HE3wQvW9yqFHNf+A2Eb2ZxFgOUS86fUc6SAqz98dmv90tQ2wSkkNgGmyf/MQsNlxvt21
 /C478gqELxUNIgf9DFGWEta/jqGWWKCNSF7IRadYRwlO2x/gz+b+BR9knQop03SAfG0O
 +Ct/8UaRE6L284pfYnuh1g1u8w1uDmbFlbNS6XwV+4Tt63Vh7IskJP/+0mCOOJ/JVOxO
 6dNTtef13BQM8+kO72f6AEyzAf+I2KPeC6WdZm9VO3uxNtqdA8/owkGtPJbJybYCsh+D
 KGFYwmdAy7GeKX6ONN/Z2k7v9fx7aVV9CnjMx9URkDap0/FBHShWMkhghKTRLBjBLFXZ gg== 
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint7.lanl.gov (PPS) with ESMTP id 3qyh0e0x4t-1;
        Fri, 02 Jun 2023 10:14:48 -0600
Received: from localhost (localhost [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 1BD0710028A8;
        Fri,  2 Jun 2023 10:14:48 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from EXG16-P-MBX09.win.lanl.gov (exg16-p-mbx09.win.lanl.gov [128.165.106.189])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 0B0761001F62;
        Fri,  2 Jun 2023 10:14:48 -0600 (MDT)
Received: from EXG16-P-MBX03.win.lanl.gov (128.165.106.183) by
 EXG16-P-MBX09.win.lanl.gov (128.165.106.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 10:14:47 -0600
Received: from EXG16-P-MBX03.win.lanl.gov ([fe80::b846:ac49:a5ce:ec30]) by
 EXG16-P-MBX03.win.lanl.gov ([fe80::b846:ac49:a5ce:ec30%2]) with mapi id
 15.01.2507.023; Fri, 2 Jun 2023 10:14:47 -0600
From:   "Priedhorsky, Reid" <reidpr@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: bug? subprocesses can use wrong Git if $PATH is unset
Thread-Topic: bug? subprocesses can use wrong Git if $PATH is unset
Thread-Index: AQHZlW1ZbONuHdIJokecj7t48nY2Jw==
Date:   Fri, 2 Jun 2023 16:14:47 +0000
Message-ID: <412E82B5-79C0-4AAD-8219-AA7664E9EE1E@lanl.gov>
References: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
 <ZHk5V6U9gfkuwErH@tapette.crustytoothpaste.net>
In-Reply-To: <ZHk5V6U9gfkuwErH@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.165.106.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1C39EB378B26748898EC3638CAD43D2@win.lanl.gov>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-GUID: BSbg5Pw7T5opL59GytYpfXb4UkDL6y3D
X-Proofpoint-ORIG-GUID: BSbg5Pw7T5opL59GytYpfXb4UkDL6y3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gQnJpYW4sDQoNCj4gT24gSnVuIDEsIDIwMjMsIGF0IDY6MzUgUE0sIGJyaWFuIG0uIGNh
cmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPiANCj4gSXQgaXNu
J3QgcG9zc2libHkgdG8gcG9ydGFibHkgZGV0ZXJtaW5lIHRoYXQgcGF0aCB0aGF0IHdhcyB1c2Vk
IHRvIGV4ZWMNCj4gdGhlIGN1cnJlbnQgYmluYXJ5LCBzbyBHaXQgZG9lc24ndCB0cnkgdG8gZG8g
c28sIGFuZCBpdCBhc3N1bWVzIHRoYXQgeW91DQo+IHNldCBQQVRIIGFwcHJvcHJpYXRlbHkuICBJ
biBmYWN0LCBvbiBzb21lIHN5c3RlbXMsIHlvdSBjYW4gdXNlIGZleGVjdmUNCj4gdG8gZXhlY3V0
ZSBmaWxlIGRlc2NyaXB0b3JzIHBvaW50aW5nIHRvIGZpbGVzIHRoYXQgaGF2ZSBiZWVuIHVubGlu
a2VkLA0KPiBzbyBpbiBnZW5lcmFsLCBpdCdzIG5vdCBwb3NzaWJsZSB0byBkZXRlcm1pbmUgd2hp
Y2ggYmluYXJ5IHRvIHVzZQ0KPiB3aXRob3V0IHRoZSBQQVRILg0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBleHBsYW5hdGlvbi4gVGhpcyBpcyBmYXNjaW5hdGluZy4gSXQgYWxzbyBleHBsYWlucyB3aHkg
bXkgc2NyaXB0IHdvcmtzIGFzIGV4cGVjdGVkIGlmIEkgc3Vic3RpdHV0ZSDigJwvdXNyL2xvY2Fs
L2Jpbi9naXTigJ0gZm9yIHBsYWluIOKAnGdpdOKAnS4NCg0KPiBJIGRvbid0IHRoaW5rIHRoZXJl
J3MgYW55dGhpbmcgdG8gY2hhbmdlIGhlcmUgaW4gR2l0Lg0KDQpUaGF0IHNlZW1zIGNvbnZpbmNp
bmcuDQoNCkkgZG8gd29uZGVyIGlmIHRoZSBiZWhhdmlvciB3b3VsZCBiZSB3b3J0aCBkb2N1bWVu
dGluZywgZS5nLiBhdCBodHRwczovL2dpdC1zY20uY29tL2Jvb2svZW4vdjIvR2l0LUludGVybmFs
cy1FbnZpcm9ubWVudC1WYXJpYWJsZXMsIHdoZXJlIEdpdOKAmXMgcmVsYXRpb25zaGlwIHRvICRI
T01FIGlzIGFsc28gZG9jdW1lbnRlZC4gSSB3b3VsZCBiZSBoYXBweSB0byBzdWJtaXQgYSBwdWxs
IHJlcXVlc3QuDQoNClRoYW5rcywNClJlaWQNCg0K4oCUDQpoZS9oaXM=
