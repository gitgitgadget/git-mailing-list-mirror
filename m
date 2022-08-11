Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6501FC19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiHKIKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHKIKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:10:10 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 952189018A
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:10:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,228,1654531200"; 
   d="scan'208";a="38289502"
Received: from hk-mbx03.mioffice.cn (HELO xiaomi.com) ([10.56.8.123])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 11 Aug 2022 16:09:58 +0800
Received: from BJ-MBX05.mioffice.cn (10.237.8.125) by HK-MBX03.mioffice.cn
 (10.56.8.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 11 Aug
 2022 16:09:57 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX05.mioffice.cn
 (10.237.8.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 11 Aug
 2022 16:09:56 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Thu, 11 Aug 2022 16:09:56 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Partial-clone cause big performance impact on server
Thread-Topic: Partial-clone cause big performance impact on server
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQ==
Date:   Thu, 11 Aug 2022 08:09:56 +0000
Message-ID: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkuDQogICAgIFdlIG9ic2VydmVkIGJpZyBkaXNrIHNwYWNlIHNhdmUgYnkgcGFydGlhbC1jbG9u
ZSBhbmQgcmVxdWlyZSBhbGwgb2Ygb3VyIHVzZXJzICgyMDAwKykgdG8gY2xvbmUgcmVwb3NpdG9y
eSB3aXRoIHBhcnRpYWwtY2xvbmUgKGZpbHRlcj1ibG9iOm5vbmUpDQogICAgIEhvd2V2ZXIgYXQg
YnVzeSB0aW1lLCB3ZSBmb3VuZCBpdCdzIGV4dHJlbWVseSBzbG93IGZvciB1c2VyIHRvIGZldGNo
LiBIZXJlIGlzIHdoYXQgd2UgZGlkLg0KDQogICAgMS4gYXNrIGFsbCB1c2VycyB0byBmZXRjaCB3
aXRoIGZpbHRlcj1ibG9iOm5vbmUuIEFuZCBpdCdzIHJlbWFya2FibGUuIE5vdyBvdXIgZG93bmxv
YWQgc2l6ZSBwZXIgdXNlciBkZWNyZWFzZSBmcm9tIDQ2MEcgdG8gMTgwRy4NCiAgICAyLiBCdXQg
YXQgYnVzeSB0aW1lLCBldmVyeW9uZSdzIGZldGNoIGJlY29tZSBzbG93LiAoYXQgaWRsZSBob3Vy
cywgaXQgdGFrZXMgdXMgNSBtaW51dGVzIHRvIGNsb25lIGEgYmlnIHJlcG9zaXRvcmllcywgYnV0
IGl0IHRha2VzIG1vcmUgdGhhbiAxIGhvdXIgdG8gY2xvbmUgdGhlIHNhbWUgcmVwb3NpdG9yaWVz
IGF0IGJ1c3kgaG91cnMpDQogICAgMy4gd2l0aCBHSVRfVFJBQ0VfUEFDS0VUPTEuIFdlIGZvdW5k
IG9uIGJpZyByZXBvc2l0b3JpZXMgKDIwMEsrcmVmcywgNm0rIG9iamVjdHMpLiBHaXQgd2lsbCBz
ZW5kcyA0MGsgd2FudC4NCiAgICA0LiBBbmQgd2UgdGhlbiB0cmFjayBvdXIgc2VydmVyKHdoaWNo
IGlzIGdlcnJpdCB3aXRoIGpnaXQpLiBXZSBmb3VuZCB0aGUgc2VydmVyIGlzIGNvdXRpbmcgb2Jq
ZWN0cy4gVGhlbiB3ZSBjaGVjayB0aG9zZSA0MGsgb2JqZWN0cywgbW9zdCBvZiB0aGVtIGFyZSBi
bG9icyByYXRoZXIgdGhhbiBjb21taXQuICh3aGljaCBtZWFucyB0aGV5J3JlIG5vdCBpbiBiaXRt
YXApDQogICAgNS4gV2UgYmVsaWV2ZSB0aGF0J3MgdGhlIHJvb3QgY2F1c2Ugb2Ygb3VyIHByb2Js
ZW0uIEdpdCBzZW5kcyB0b28gbWFueSAid2FudCBTSEExIiB3aGljaCBhcmUgbm90IGluIGJpdG1h
cCwgY2F1c2UgdGhlIHNlcnZlciB0byBjb3VudCBvYmplY3RzICBmcmVxdWVudGx5LCB3aGljaCB0
aGVuIHNsb3cgZG93biB0aGUgc2VydmVyLg0KDQpXaGF0IHdlIHdhbnQgaXMsIGRvd25sb2FkIHRo
ZSB0aGluZ3Mgd2UgbmVlZCB0byBjaGVja291dCB0byBzcGVjaWZpYyBjb21taXQuIEJ1dCBpZiBv
bmUgY29tbWl0IGNvbnRhaW4gc28gbWFueSBvYmplY3RzIChsaWtlIHVzICwgNDBrKykuIEl0IHRh
a2VzIG1vcmUgdGltZSB0byBjb3VudGluZyB0aGFuIGRvd25sb2FkaW5nLg0KSXMgaXQgcG9zc2li
bGUgdG8gbGV0IGdpdCBvbmx5IHNlbmQgImNvbW1pdCB3YW50IiByYXRoZXIgdGhhbiBhbGwgdGhl
IG9iamVjdHMgU0hBMSBvbmUgYnkgb25lPw0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTku7bl
kKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrp
naLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bk
urrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jl
iIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/j
gILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7k
u7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0
cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9N
SSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2Ug
YWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRh
aW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRv
dGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9u
KSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9o
aWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQh
KioqKioqLyMNCg==
