Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22FDC433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9475864F34
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhCDLti (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 06:49:38 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:65312 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhCDLtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 06:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614858550; x=1646394550;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=JcbH/7MP2wjT68C/bh9s2cqwBQnbbrwSfyht1mbdOVo=;
  b=iuvxEFKTthm4MS3cVanspSUYb1dITwRzgpKPPpIBnPaJ08tqsCKbjbnG
   HEf9midgsy5fGkHpFlb7BIOtrem/vuxirnV7t71/r/IxsV3rf9Zv9tv3k
   rnkjTQjxXwEuLmsHQUpOE2XRHFLIu5Wp2MhxfiVxUBPEaQVyuTd2WLvFk
   Q=;
X-IronPort-AV: E=Sophos;i="5.81,222,1610409600"; 
   d="scan'208";a="94174526"
Subject: Re: bug: conflicting core.bare setting causes segfault during bare clone
Thread-Topic: bug: conflicting core.bare setting causes segfault during bare clone
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 04 Mar 2021 11:48:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id AF1BCA284F;
        Thu,  4 Mar 2021 11:48:27 +0000 (UTC)
Received: from EX13D07UWB003.ant.amazon.com (10.43.161.66) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Mar 2021 11:48:27 +0000
Received: from EX13D07UWB003.ant.amazon.com (10.43.161.66) by
 EX13D07UWB003.ant.amazon.com (10.43.161.66) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Mar 2021 11:48:27 +0000
Received: from EX13D07UWB003.ant.amazon.com ([10.43.161.66]) by
 EX13D07UWB003.ant.amazon.com ([10.43.161.66]) with mapi id 15.00.1497.012;
 Thu, 4 Mar 2021 11:48:27 +0000
From:   "Vusich, Joseph" <jvusich@amazon.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Thread-Index: AQHXEJOK5Na3K85vSEaUnnfGgdV/aapzMU8A
Date:   Thu, 4 Mar 2021 11:48:27 +0000
Message-ID: <6962C073-60A9-4FCB-8FAA-02549A78547D@amazon.com>
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
 <YEAi4OkkNnp+IMJD@camp.crustytoothpaste.net>
 <xmqq4khrg1qx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4khrg1qx.fsf@gitster.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.239]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E01537B669585D45A2144336DBD347BA@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+ICJicmlhbiBtLiBjYXJsc29uIiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3Jp
dGVzOg0KDQo+IEkgd2lsbCBhZG1pdCBiZWluZyBhIGJpdCBpbnRlcmVzdGVkIGluIGhvdyB0aGlz
IHdhcyBkaXNjb3ZlcmVkLCBzaW5jZSBpdA0KPiBzZWVtcyBsaWtlIGFuIG9kZCBjb25maWd1cmF0
aW9uIHRvIGhhdmUsIHNvIGlmIHlvdSBjYW4gc2hhcmUsIEknZA0KPiBhcHByZWNpYXRlIGl0LCBp
ZiBvbmx5IHRvIHNhdGlzZnkgbXkgY3VyaW9zaXR5Lg0KDQpRdWl0ZSBieSBhY2NpZGVudC4gQSBt
YWNoaW5lLWdlbmVyYXRlZCAuZ2l0Y29uZmlnIHdpdGggc29tZSAiZGVmYXVsdCINCnZhbHVlcywg
d2hpY2ggaW5hZHZlcnRlbnRseSBpbmNsdWRlZCBjb3JlLmJhcmU9ZmFsc2UuDQoNCg0KPiAiSnVu
aW8gQyBIYW1hbm8iIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQoNCj4gSSBoYWQgdGhlIHNh
bWUgcmVhY3Rpb24uICBGb3JjaW5nIGV2ZXJ5dGhpbmcgdG8gYmUgYmFyZSBpcyBxdWl0ZQ0KPiB1
bnVzdWFsLg0KDQpUZWNobmljYWxseSBub24tYmFyZSBpbiB0aGlzIGNhc2UsIGFsdGhvdWdoIHRo
ZSBmaWVsZCBzZWVtcyB0byBiZSBpZ25vcmVkDQppbiB0aGUgZ2xvYmFsIGNvbmZpZywgYXQgbGVh
c3QgcHJpb3IgdG8gR2l0IDIuMzAuMC4gSW4gYW55IGNhc2UsIGl0IG5ldmVyDQpoYWQgYW55IG9i
c2VydmFibGUgZWZmZWN0LCBhbmQgd2FzIHRoZXJlZm9yZSBuZXZlciBub3RpY2VkLg0KDQo=
