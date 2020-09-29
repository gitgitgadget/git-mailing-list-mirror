Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DECC4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728B620757
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JIt72X6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgI2Wlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:41:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:13706 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgI2Wly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 18:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601419314; x=1632955314;
  h=from:to:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=ipgk2oniNokOstxFs/JwJprn8E8zOnkHT9C+cy3UrSk=;
  b=JIt72X6u9Gout6jzOCMZB3odXnvwduv9FQF3GHeTzfiMhpuPCdkMaM/V
   2NzmiP2zc1AJCJYw8bEAgSjh3ijH3Tx7f6jAt9EsgR73NNX9N5oxOkvxZ
   C6t3aKQGWV6CAioCfHNTWdIMhUoYXcwszzpioVPdXiBpa3YIx1lQY3d/j
   g=;
X-IronPort-AV: E=Sophos;i="5.77,320,1596499200"; 
   d="scan'208";a="72132684"
Subject: Re: Question About Git V2 Protocol & SHA256
Thread-Topic: Question About Git V2 Protocol & SHA256
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Sep 2020 22:41:51 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id D3E60A18E4;
        Tue, 29 Sep 2020 22:41:50 +0000 (UTC)
Received: from EX13D20UWA002.ant.amazon.com (10.43.160.176) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 29 Sep 2020 22:41:50 +0000
Received: from EX13D20UWA003.ant.amazon.com (10.43.160.97) by
 EX13D20UWA002.ant.amazon.com (10.43.160.176) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 29 Sep 2020 22:41:50 +0000
Received: from EX13D20UWA003.ant.amazon.com ([10.43.160.97]) by
 EX13D20UWA003.ant.amazon.com ([10.43.160.97]) with mapi id 15.00.1497.006;
 Tue, 29 Sep 2020 22:41:49 +0000
From:   "Wu, Zhichen" <zhwu@amazon.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Thread-Index: AQHWlf5ecO6oUvIkOE6Oo7T8lc6CpKmAL3KA//+SqIA=
Date:   Tue, 29 Sep 2020 22:41:49 +0000
Message-ID: <60F39754-A524-475C-A0B8-CA107767B14B@amazon.com>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
In-Reply-To: <20200929221311.GA15129@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.221]
Content-Type: text/plain; charset="utf-8"
Content-ID: <592F26E82723A3478A0AD0D578F3E1DD@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgUGVmZiwNCg0KVGhhbmsgeW91IGZvciB0aGUgcXVpY2sgcmVzcG9uc2UhIFRoYXQgaXMgdmVy
eSBoZWxwZnVsIGFuZCBJIHRoaW5rIEkgaGF2ZSBhbGwgdGhlIGluZm9ybWF0aW9uIEkgbmVlZC4N
Cg0KQXBwcmVjaWF0ZSBpdCBhIGxvdCENClpoaWNoZW4NCg0K77u/T24gOS8yOS8yMCwgMzoxMyBQ
TSwgIkplZmYgS2luZyIgPHBlZmZAcGVmZi5uZXQ+IHdyb3RlOg0KDQogICAgQ0FVVElPTjogVGhp
cyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJt
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQoNCiAgICBPbiBU
dWUsIFNlcCAyOSwgMjAyMCBhdCAwMToxNzo1OUFNICswMDAwLCBXdSwgWmhpY2hlbiB3cm90ZToN
Cg0KICAgID4gMS4gU2luY2UgdjIgcHJvdG9jb2wgaGFzIGJlZW4gbGF1bmNoZWQgZm9yIDIgeWVh
cnMsIGlzIHRoZXJlIGFueSBwbGFuDQogICAgPiAgICBpbiB0aGUgbmVhciBmdXR1cmUgYWJvdXQg
djEgZGVwcmVjYXRpb24/DQoNCiAgICBJIHN1cHBvc2UgaXQgZGVwZW5kcyB3aGF0IHlvdSBtZWFu
IGJ5IGRlcHJlY2F0aW9uLg0KDQogICAgdjIgaXMgbm90IGV2ZW4gdGhlIGRlZmF1bHQgeWV0IChi
dXQgaG9wZWZ1bGx5IHdpbGwgYmUgc29vbiwgcGVyaGFwcyBpbg0KICAgIHRoZSBuZXh0IHJlbGVh
c2UpLg0KDQogICAgT25jZSB0aGF0IGhhcHBlbnMsIEkgZG91YnQgdGhhdCB3ZSB3aWxsIGFkZCBu
ZXcgY2FwYWJpbGl0aWVzIG9yIGZlYXR1cmVzDQogICAgdG8gdjEgaW4gZ2VuZXJhbC4gT2xkIHZl
cnNpb25zIG9mIEdpdCB3b3VsZCBub3QgYmUgYWJsZSB0byB0YWtlDQogICAgYWR2YW50YWdlIG9m
IHRoZW0gYW55d2F5LCBhbmQgbmV3IG9uZXMgd291bGQgYmUgdXNpbmcgdjIuDQoNCiAgICBCdXQg
SSBkb24ndCB0aGluayB2MSB3aWxsIGdvIGF3YXkgZm9yIGEgbG9uZyB0aW1lLiBUaGVyZSB3aWxs
IHN0aWxsIGJlDQogICAgdjEgY2xpZW50cyBhbmQgdjEgc2VydmVycyBoYW5naW5nIGFyb3VuZCBm
b3IgbWFueSB5ZWFycywgYW5kIG1vZGVybg0KICAgIHZlcnNpb25zIG9mIEdpdCB3aWxsIG5lZWQg
dG8gc3BlYWsgYm90aC4NCg0KICAgID4gMi4gSSBzZWUgdjIgaGFzIGEgY2FwYWJpbGl0eSBjYWxs
ZWQg4oCcb2JqZWN0LWZvcm1hdOKAnSB0aGF0IHByb3ZpZGVzIFNIQTENCiAgICA+ICAgIG9wdGlv
bi4gSeKAmW0gd29uZGVyaW5nIGlmIHRoYXQgY2FwYWJpbGl0eSB3aWxsIGJlIHRoZSBvbmx5IHdh
eSBmb3INCiAgICA+ICAgIGNsaWVudCBhbmQgc2VydmVyIHRvIHN0YXJ0IHVzaW5nIFNIQTI1Nj8g
T3IgcHV0IGl0IGFzIGFub3RoZXIgd29yZCwNCiAgICA+ICAgIHdpbGwgdjIgcHJvdG9jb2wgYmUg
dGhlIHByZXJlcXVpc2l0ZSBvZiBTSEEyNTY/DQoNCiAgICBJIHRoaW5rIGl0IHdvdWxkIGJlIGlt
cG9zc2libGUgdG8gaGFuZGxlIG9iamVjdC1mb3JtYXQgdmlhIHYxLCBiZWNhdXNlDQogICAgdGhl
IHYxIHByb3RvY29sIHdyaXRlcyB0aGUgcmVmIGFkdmVydGlzZW1lbnQgYmVmb3JlIGFueSBjYXBh
YmlsaXRpZXMgYXJlDQogICAgbmVnb3RpYXRlZC4gU28gSSB0aGluayB2MSBtdXN0IGltcGxpY2l0
bHkgcmVtYWluIHNoYTEtb25seSAoYW5kIGEgc2hhMjU2DQogICAgcmVwb3NpdG9yeSBvbiB0aGUg
c2VydmVyIHNpZGUgd291bGQgbmVlZCB0byBlaXRoZXIgcmVqZWN0IGEgdjEgY2xpZW50LA0KICAg
IG9yIGJhY2stdHJhbnNsYXRlIGFzIGl0IHdvdWxkIGZvciBhIHYyIGNsaWVudCB3aGljaCBhc2tz
IGZvciBzaGExKS4NCg0KICAgIC1QZWZmDQoNCg==
