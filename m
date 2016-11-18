Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EDC1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbcKRRs4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 12:48:56 -0500
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:40054 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbcKRRsz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 12:48:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 16F9D10005F;
        Fri, 18 Nov 2016 17:48:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2SoF_vrd-E78; Fri, 18 Nov 2016 17:48:49 +0000 (GMT)
Received: from EXMBNJE6.ad.twosigma.com (exmbnje6.ad.twosigma.com [172.20.45.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 06BAA8002E;
        Fri, 18 Nov 2016 17:48:49 +0000 (GMT)
Received: from EXMBNJE7.ad.twosigma.com (172.20.45.147) by
 EXMBNJE6.ad.twosigma.com (172.20.45.169) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Fri, 18 Nov 2016 17:48:48 +0000
Received: from EXMBNJE7.ad.twosigma.com ([fe80::a093:116d:d3a6:d7a6]) by
 EXMBNJE7.ad.twosigma.com ([fe80::a093:116d:d3a6:d7a6%17]) with mapi id
 15.00.1156.000; Fri, 18 Nov 2016 17:48:48 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: RE: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Topic: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Index: AQHSP2ezYl8XykiMv0OTBeEAHSKu4qDe/BWAgAAAOECAAAHGgIAACpbg
Date:   Fri, 18 Nov 2016 17:48:48 +0000
Message-ID: <3404f9d7dd6c44bc9090cc1b556bdb9b@EXMBNJE7.ad.twosigma.com>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
 <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
 <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
 <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
 <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net>
 <764305554fa74779ad5fb956aa2b658a@EXMBNJE7.ad.twosigma.com>
 <20161118170855.22p3vhcocdxgmpy4@sigill.intra.peff.net>
In-Reply-To: <20161118170855.22p3vhcocdxgmpy4@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxOCwgMjAxNiAxMjow
OSBQTQ0KPiBUbzogRGF2aWQgVHVybmVyDQo+IENjOiBKdW5pbyBDIEhhbWFubzsgZ2l0QHZnZXIu
a2VybmVsLm9yZzsgc3BlYXJjZUBzcGVhcmNlLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBy
ZW1vdGUtY3VybDogZG9uJ3QgaGFuZyB3aGVuIGEgc2VydmVyIGRpZXMgYmVmb3JlIGFueQ0KPiBv
dXRwdXQNCj4gDQo+IE9uIEZyaSwgTm92IDE4LCAyMDE2IGF0IDA1OjA0OjU5UE0gKzAwMDAsIERh
dmlkIFR1cm5lciB3cm90ZToNCj4gDQo+ID4gPiBTbyBJIGRvbid0IGZlZWwgbGlrZSB3ZSBoYXZl
IGEgZ29vZCBwYXRjaCBmb3IgdGhlIGdlbmVyYWwgY2FzZSB5ZXQsDQo+ID4gPiBhbmQgSSdtIHBy
b2JhYmx5IG5vdCBnb2luZyB0byBnZXQgYXJvdW5kIHRvIGltcGxlbWVudGluZyBpdCBhbnl0aW1l
DQo+ID4gPiBzb29uLg0KPiA+DQo+ID4gSSdtIGNvbmZ1c2VkIC0tIGl0IHNvdW5kcyBsaWtlIHlv
dXIgcGF0Y2ggYWN0dWFsbHkgZG9lcyB3b3JrICh0aGF0IGlzLA0KPiA+IHRoYXQgSnVuaW8ncyBm
YWlsdXJlIHdhcyBub3QgY2F1c2VkIGJ5IHlvdXIgcGF0Y2ggYnV0IGJ5IHRoZSBhYnNlbmNlDQo+
ID4gb2Ygb3VyIHBhdGNoZXMpLiBBbmQgeW91ciBwYXRjaCBoYW5kbGVzIG1vcmUgY2FzZXMgdGhh
biBtaW5lLiAgU28gd2UNCj4gPiBzaG91bGQgcHJvYmFibHkgdXNlIGl0IGluc3RlYWQgb2YgbWlu
ZS4NCj4gDQo+IE5vLCBtaW5lIHBhc3NlcyB0aGUgdmFuaWxsYSB0ZXN0IHN1aXRlLCBidXQgZmFp
bHMgd2l0aCBHSVRfVEVTVF9MT05HLg0KPiBJZiB0aGUgd2FudC9oYXZlIG5lZ290aWF0aW9uIHRh
a2VzIG11bHRpcGxlIHJvdW5kcywgdGhlIGludGVybWVkaWF0ZQ0KPiByb3VuZHMgZG9uJ3QgZW5k
IG9uIGEgZmx1c2ggcGFja2V0LCBhbmQgbXkgcGF0Y2ggY2F1c2VzIHJlbW90ZS1jdXJsIHRvDQo+
IGNvbXBsYWluIHRoYXQgdGhlIHJlc3BvbnNlIHdhcyB0cnVuY2F0ZWQuDQo+IA0KPiBJIHRoaW5r
IHlvdSBjb3VsZCBmaXggaXQgYnkgdGVhY2hpbmcgcmVtb3RlLWN1cmwgdGhhdCB0aGUgZmluYWwg
cGFja2V0DQo+IG11c3QgYmUgYSBmbHVzaCBfb3JfIGNvbnRhaW4gYW4gQUNLL05BSywgYnV0IEkg
ZGlkbid0IHRyeSBpdC4gVGhhdCdzDQo+IGdldHRpbmcgYSBiaXQgaW52YXNpdmUgYW5kIGJyaXR0
bGUuDQoNCk9LLCBJJ2xsIHJlLXJvbGwgbWluZSB3aXRoIGEgYmV0dGVyIG1lc3NhZ2UuDQo=
