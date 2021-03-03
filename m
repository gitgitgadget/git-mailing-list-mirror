Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45CC433E0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E3E64EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448783AbhCCGfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:52 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49380 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbhCCAHA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 19:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614730020; x=1646266020;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=fq1WexJqntjcgcHVK3jsppQOMHpb2Qmwx9eT3TRFibQ=;
  b=tltixlGUFb2ZJraHTTjd6LXnCB5cAmGc3YA2YOOX3SkQ7iPhdkNI6Vb1
   cxczqmr6oqDGSYikgsfdWMmkwJvUncsCPsZBcIQ6VGRjtgm/BVH3Ll1+8
   Y0sISdZZI1fctt/JtZ7eKNFQOBpj7DDdW081ncwmxgMHYfSGWtsXVMW8H
   E=;
X-IronPort-AV: E=Sophos;i="5.81,218,1610409600"; 
   d="scan'208";a="89094281"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Mar 2021 00:06:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id E6843A24D0
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 00:06:01 +0000 (UTC)
Received: from EX13D07UWB003.ant.amazon.com (10.43.161.66) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Mar 2021 00:06:01 +0000
Received: from EX13D07UWB003.ant.amazon.com (10.43.161.66) by
 EX13D07UWB003.ant.amazon.com (10.43.161.66) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Mar 2021 00:06:01 +0000
Received: from EX13D07UWB003.ant.amazon.com ([10.43.161.66]) by
 EX13D07UWB003.ant.amazon.com ([10.43.161.66]) with mapi id 15.00.1497.010;
 Wed, 3 Mar 2021 00:06:01 +0000
From:   "Vusich, Joseph" <jvusich@amazon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug: conflicting core.bare setting causes segfault during bare clone
Thread-Topic: conflicting core.bare setting causes segfault during bare clone
Thread-Index: AQHXD8D+5Na3K85vSEaUnnfGgdV/aQ==
Date:   Wed, 3 Mar 2021 00:06:01 +0000
Message-ID: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.179]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9D24EAB2A38D64B9678723E4ADC3418@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQoNCiQgZW52IHwgZ3JlcCBHSVQNCg0KJCBnaXQgY29uZmln
IC0tbGlzdA0KdXNlci5lbWFpbD1qdnVzaWNoQGFtYXpvbi5jb20NCnVzZXIubmFtZT1Kb3NlcGgg
VnVzaWNoDQpjb3JlLmJhcmU9ZmFsc2UNCg0KJCBnaXQgY2xvbmUgLS1iYXJlIGh0dHBzOi8vZ2l0
aHViLmNvbS9qb3NlcGh2dXNpY2gvZml4dHVyZQ0KQ2xvbmluZyBpbnRvIGJhcmUgcmVwb3NpdG9y
eSAnZml4dHVyZS5naXQnLi4uDQp6c2g6IHNlZ21lbnRhdGlvbiBmYXVsdCAgL29wdC9sb2NhbC9i
aW4vZ2l0IGNsb25lIC0tYmFyZSBodHRwczovL2dpdGh1Yi5jb20vam9zZXBodnVzaWNoL2ZpeHR1
cmUNCg0KV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikN
Cg0KImdpdCBjbG9uZSAtLWJhcmUiIHNob3VsZCBjbG9uZSBhIGJhcmUgcmVwb3NpdG9yeSwgcmVn
YXJkbGVzcyBvZiB0aGUgY29yZS5iYXJlIHNldHRpbmcgaW4gdGhlIGdsb2JhbCBjb25maWcNCg0K
V2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KDQoiZ2l0IGNsb25lIC0t
YmFyZSIgY2F1c2VzIGEgc2VnZmF1bHQgaWYgdGhlIGdsb2JhbCBnaXRjb25maWcgaGFzIGNvcmUu
YmFyZT1mYWxzZQ0KDQpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoNCg0KKiBOb24tYmFy
ZSBjbG9uZXMgc3RpbGwgd29yayB3aGVuIGNvcmUuYmFyZT1mYWxzZQ0KKiBCYXJlIGNsb25lcyBv
bmx5IHdvcmsgd2hlbiBjb3JlLmJhcmU9dHJ1ZSwgb3IgaWYgY29yZS5iYXJlIGlzIGFic2VudCBm
cm9tIGdpdGNvbmZpZw0KKiBTdGFydGVkIGZhaWxpbmcgd2l0aCBHaXQgMi4zMC4wLCBhbHNvIGZh
aWxzIG9uIDIuMzAuMSwgYnV0IHN1Y2NlZWRzIG9uIDIuMjkuMg0KKiBJc3N1ZSByZXByb2R1Y2Vk
IG9uIG11bHRpcGxlIG1hY2hpbmVzLCBydW5uaW5nIFVidW50dSwgTWFjIE9TLCBhbmQgQWxwaW5l
IExpbnV4DQoqIFJ1bm5pbmcgd2l0aCBhbGwgVFJBQ0VzIGVuYWJsZWQgc2hvd3Mgb25seSBvbmUg
YWRkaXRpb25hbCBsaW5lIHByaW9yIHRvICJDbG9uaW5nIg0KICAgIDE1OjM4OjA4LjU2NzI5MiBn
aXQuYzo0NDQgIHRyYWNlOiBidWlsdC1pbjogZ2l0IGNsb25lIC0tYmFyZSBodHRwczovL2dpdGh1
Yi5jb20vam9zZXBodnVzaWNoL2ZpeHR1cmUNCiogVGhlIGZpeHR1cmUuZ2l0IGRpcmVjdG9yeSBp
cyBjcmVhdGVkIHByaW9yIHRvIHRoZSBzZWdmYXVsdCwgdGhlIGZpeHR1cmUuZ2l0L2NvbmZpZyBm
aWxlIGNvbnRlbnQgaXMgYmVsb3c6DQogIFtjb3JlXQ0KICAgIHJlcG9zaXRvcnlmb3JtYXR2ZXJz
aW9uID0gMA0KICAgIGZpbGVtb2RlID0gdHJ1ZQ0KICAgIGJhcmUgPSBmYWxzZQ0KICAgIGxvZ2Fs
bHJlZnVwZGF0ZXMgPSB0cnVlDQoNClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyBy
ZXBvcnQgYmVsb3cuDQpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdpc2ggdG8g
c2hhcmUuDQoNCg0KW1N5c3RlbSBJbmZvXQ0KZ2l0IHZlcnNpb246DQpnaXQgdmVyc2lvbiAyLjMw
LjENCmNwdTogeDg2XzY0DQpubyBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQNCnNp
emVvZi1sb25nOiA4DQpzaXplb2Ytc2l6ZV90OiA4DQpzaGVsbC1wYXRoOiAvYmluL3NoDQp1bmFt
ZTogRGFyd2luIDE5LjYuMCBEYXJ3aW4gS2VybmVsIFZlcnNpb24gMTkuNi4wOiBUdWUgSmFuIDEy
IDIyOjEzOjA1IFBTVCAyMDIxOyByb290OnhudS02MTUzLjE0MS4xNn4xL1JFTEVBU0VfWDg2XzY0
IHg4Nl82NA0KY29tcGlsZXIgaW5mbzogY2xhbmc6IDEyLjAuMCAoY2xhbmctMTIwMC4wLjMyLjIp
DQpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlDQokU0hFTEwgKHR5cGlj
YWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiAvYmluL3pzaA0KDQoNCltFbmFibGVkIEhvb2tzXQ0K
bm90IHJ1biBmcm9tIGEgZ2l0IHJlcG9zaXRvcnkgLSBubyBob29rcyB0byBzaG93DQoNCg==
