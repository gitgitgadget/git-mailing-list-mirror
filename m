Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CCC1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJZDMI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:12:08 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:13749 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeJZDMH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1540492693; x=1572028693;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=YRHp+PAJ1rIodgmnUG0Kxn/gSXiNH2blJKAB6rW/Li8=;
  b=kakoU5VAF5CYwlbfSJaLGEmCEN/tPGdVTDXt6jfIED8FKL/vdA2/vwqA
   jqfxG0TR0vmSUJO+O6A523I8nwNcZneHjAe4rTmwCbhKmkXMl+3+vnJg2
   tDtiqGw3N24eVrQkIpT0VAOefPNvJlB+t5US7XOOkGH2Zff18xuzOIjI2
   A=;
X-IronPort-AV: E=Sophos;i="5.54,425,1534809600"; 
   d="scan'208";a="365174968"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Oct 2018 18:38:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9PIc4F7107163
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:38:10 GMT
Received: from EX13D11UEE001.ant.amazon.com (10.43.62.132) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Oct 2018 18:38:10 +0000
Received: from EX13D11UEE003.ant.amazon.com (10.43.62.248) by
 EX13D11UEE001.ant.amazon.com (10.43.62.132) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Oct 2018 18:38:10 +0000
Received: from EX13D11UEE003.ant.amazon.com ([10.43.62.248]) by
 EX13D11UEE003.ant.amazon.com ([10.43.62.248]) with mapi id 15.00.1367.000;
 Thu, 25 Oct 2018 18:38:10 +0000
From:   "Jansen, Geert" <gerardu@amazon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [RFC PATCH] index-pack: improve performance on NFS
Thread-Topic: [RFC PATCH] index-pack: improve performance on NFS
Thread-Index: AQHUbJHg0WSTDXn0M0aRdbudIsvf0Q==
Date:   Thu, 25 Oct 2018 18:38:09 +0000
Message-ID: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.62.42]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8636AF3EC0004A43BA0E58DD9426D7F7@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGluZGV4LXBhY2sgY29tbWFuZCBkZXRlcm1pbmVzIGlmIGEgc2hhMSBjb2xsaXNpb24gdGVz
dCBpcyBuZWVkZWQgYnkNCmNoZWNraW5nIHRoZSBleGlzdGVuY2Ugb2YgYSBsb29zZSBvYmplY3Qg
d2l0aCB0aGUgZ2l2ZW4gaGFzaC4gSW4gbXkgdGVzdHMsIEkNCmNhbiBpbXByb3ZlIHBlcmZvcm1h
bmNlIG9mIOKAnGdpdCBjbG9uZeKAnSBvbiBBbWF6b24gRUZTIGJ5IDh4IHdoZW4gdXNlZCB3aXRo
IGENCm5vbi1kZWZhdWx0IG1vdW50IG9wdGlvbiAobG9va3VwY2FjaGU9cG9zKSB0aGF0J3MgcmVx
dWlyZWQgZm9yIGEgR2l0bGFiIEhBDQpzZXR1cC4gTXkgYXNzdW1wdGlvbiBpcyB0aGF0IHRoaXMg
Y2hlY2sgaXMgdW5uZWNlc3Nhcnkgd2hlbiBjbG9uaW5nIGludG8gYSBuZXcNCnJlcG9zaXRvcnkg
YmVjYXVzZSB0aGUgcmVwb3NpdG9yeSB3aWxsIGJlIGVtcHR5Lg0KDQpCeSBkZWZhdWx0LCB0aGUg
TGludXggTkZTIGNsaWVudCB3aWxsIGNhY2hlIGRpcmVjdG9yeSBlbnRyaWVzIGFzIHdlbGwgYXMg
dGhlDQpub24tZXhpc3RlbmNlIG9mIGRpcmVjdG9yeSBlbnRyaWVzLiBUaGUgbGF0dGVyIG1lYW5z
IHRoYXQgd2hlbiBjbGllbnQgYzEgZG9lcw0Kc3RhdCgpIG9uIGEgZmlsZSB0aGF0IGRvZXMgbm90
IGV4aXN0LCB0aGUgbm9uLWV4aXN0ZW5jZSB3aWxsIGJlIGNhY2hlZCBhbmQgYW55DQpzdWJzZXF1
ZW50IHN0YXQoKSBvcGVyYXRpb24gb24gdGhlIGZpbGUgd2lsbCByZXR1cm4gLUVOT0VOVCB1bnRp
bCB0aGUgY2FjaGUNCmV4cGlyZXMgb3IgaXMgaW52YWxpZGF0ZWQsIGV2ZW4gaWYgdGhlIGZpbGUg
d2FzIGNyZWF0ZWQgb24gY2xpZW50IGMyIGluIHRoZQ0KbWVhbiB0aW1lLiBUaGlzIGxlYWRzIHRv
IGVycm9ycyBpbiBhIEdpdGxhYiBIQSBzZXR1cCB3aGVuIGl0IGRpc3RyaWJ1dGVzIGpvYnMNCm92
ZXIgbXVsdGlwbGUgd29ya2VyIG5vZGVzIGFzc3VtaW5nIGVhY2ggd29ya2VyIG5vZGUgaGFzIHRo
ZSBzYW1lIHZpZXcgb2YgdGhlDQpzaGFyZWQgZmlsZSBzeXN0ZW0uDQoNClRoZSByZWNvbW1lbmRl
ZCB3b3JrYXJvdW5kIGJ5IEdpdGxhYiBpcyB0byB1c2UgdGhlIOKAnGxvb2t1cGNhY2hlPXBvc+KA
nSBORlMgbW91bnQNCm9wdGlvbiB3aGljaCBkaXNhYmxlcyB0aGUgbmVnYXRpdmUgbG9va3VwIGNh
Y2hlLiBUaGlzIG9wdGlvbiBoYXMgYSBoaWdoDQpwZXJmb3JtYW5jZSBpbXBhY3QuIENsb25pbmcg
dGhlIGdpdGxhYi1jZSByZXBvc2l0b3J5DQooaHR0cHM6Ly9naXRsYWIuY29tL2dpdGxhYi1vcmcv
Z2l0bGliLWNlLmdpdCkgaW50byBhbiBORlMgbW91bnRlZCBkaXJlY3RvcnkNCmdpdmVzIHRoZSBm
b2xsb3dpbmcgcmVzdWx0czoNCg0KICBsb29rdXBjYWNoZT1hbGwgKGRlZmF1bHQpOiA2MjQgc2Vj
b25kcw0KICBsb29rdXBjYWNoZT1wb3M6IDQ5NTcgc2Vjb25kcw0KDQpUaGUgcmVhc29uIGZvciB0
aGUgcG9vciBwZXJmb3JtYW5jZSBpcyB0aGF0IGluZGV4LXBhY2sgd2lsbCBpc3N1ZSBhIHN0YXQo
KQ0KY2FsbCBmb3IgZXZlcnkgb2JqZWN0IGluIHRoZSByZXBvIHdoZW4gY2hlY2tpbmcgaWYgYSBj
b2xsaXNpb24gdGVzdCBpcyBuZWVkZWQuDQpUaGVzZSBzdGF0KCkgY2FsbHMgcmVzdWx0IGluIHRo
ZSBmb2xsb3dpbmcgTkZTIG9wZXJhdGlvbnM6DQoNCiAgTE9PS1VQIGRpcmZoPSIuZ2l0L29iamVj
dHMiLCBuYW1lPSIwMSIgLT4gTkZTNEVSUl9FTk9FTlQNCg0KV2l0aCBsb29rdXBjYWNoZT1hbGws
IHRoZSBub24tZXhpc3RlbmNlIG9mIHRoZSAuZ2l0L29iamVjdHMvWFggZGlyZWN0b3JpZXMgaXMN
CmNhY2hlZCwgc28gdGhhdCB0aGVyZSB3aWxsIGJlIGF0IG1vc3QgMjU2IExPT0tVUCBjYWxscy4g
V2l0aCBsb29rdXBjYWNoZT1wb3MsDQp0aGVyZSB3aWxsIGJlIG9uZSBMT09LVVAgb3BlcmF0aW9u
IGZvciBldmVyeSBvYmplY3QgaW4gdGhlIHJlcG9zaXRvcnksIHdoaWNoDQppbiBjYXNlIG9mIHRo
ZSBnaXRsYWItY2UgcmVwbyBpcyBhYm91dCAxLjMgbWlsbGlvbiB0aW1lcy4NCg0KVGhlIGF0dGFj
aGVkIHBhdGNoIHJlbW92ZXMgdGhlIGNvbGxpc2lvbiBjaGVjayB3aGVuIGNsb25pbmcgaW50byBh
IG5ldw0KcmVwb3NpdG9yeS4gVGhlIHBlcmZvcm1hbmNlIG9mIGdpdCBjbG9uZSB3aXRoIHRoaXMg
cGF0Y2ggaXM6DQoNCiAgbG9va3VwY2FjaGU9cG9zICh3aXRoIHBhdGNoKTogNTc3IHNlY29uZHMN
Cg0KSSdkIHdlbGNvbWUgZmVlZGJhY2sgb24gdGhlIGF0dGFjaGVkIHBhdGNoIGFuZCB3aGV0aGVy
IG15IGFzc3VtcHRpb24gdGhhdCB0aGUNCnNoYTEgY29sbGlzaW9uIGNoZWNrIGNhbiBiZSBzYWZl
bHkgb21pdHRlZCB3aGVuIGNsb25pbmcgaW50byBhIG5ldyByZXBvc2l0b3J5DQppcyBjb3JyZWN0
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBHZWVydCBKYW5zZW4gPGdlcmFyZHVAYW1hem9uLmNvbT4NCi0t
LQ0KIGJ1aWx0aW4vaW5kZXgtcGFjay5jIHwgNSArKysrLQ0KIGZldGNoLXBhY2suYyAgICAgICAg
IHwgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9idWlsdGluL2luZGV4LXBhY2suYyBiL2J1aWx0aW4vaW5kZXgtcGFj
ay5jDQppbmRleCAyMDA0ZTI1ZGEuLjIyYjNkNDBmYiAxMDA2NDQNCi0tLSBhL2J1aWx0aW4vaW5k
ZXgtcGFjay5jDQorKysgYi9idWlsdGluL2luZGV4LXBhY2suYw0KQEAgLTg0LDYgKzg0LDcgQEAg
c3RhdGljIGludCB2ZXJib3NlOw0KIHN0YXRpYyBpbnQgc2hvd19yZXNvbHZpbmdfcHJvZ3Jlc3M7
DQogc3RhdGljIGludCBzaG93X3N0YXQ7DQogc3RhdGljIGludCBjaGVja19zZWxmX2NvbnRhaW5l
ZF9hbmRfY29ubmVjdGVkOw0KK3N0YXRpYyBpbnQgY2xvbmluZzsNCiANCiBzdGF0aWMgc3RydWN0
IHByb2dyZXNzICpwcm9ncmVzczsNCiANCkBAIC03OTQsNyArNzk1LDcgQEAgc3RhdGljIHZvaWQg
c2hhMV9vYmplY3QoY29uc3Qgdm9pZCAqZGF0YSwgc3RydWN0IG9iamVjdF9lbnRyeSAqb2JqX2Vu
dHJ5LA0KIA0KIAlhc3NlcnQoZGF0YSB8fCBvYmpfZW50cnkpOw0KIA0KLQlpZiAoc3RhcnR1cF9p
bmZvLT5oYXZlX3JlcG9zaXRvcnkpIHsNCisJaWYgKHN0YXJ0dXBfaW5mby0+aGF2ZV9yZXBvc2l0
b3J5ICYmICFjbG9uaW5nKSB7DQogCQlyZWFkX2xvY2soKTsNCiAJCWNvbGxpc2lvbl90ZXN0X25l
ZWRlZCA9DQogCQkJaGFzX3NoYTFfZmlsZV93aXRoX2ZsYWdzKG9pZC0+aGFzaCwgT0JKRUNUX0lO
Rk9fUVVJQ0spOw0KQEAgLTE3MDUsNiArMTcwNiw4IEBAIGludCBjbWRfaW5kZXhfcGFjayhpbnQg
YXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkNCiAJCQkJY2hlY2tf
c2VsZl9jb250YWluZWRfYW5kX2Nvbm5lY3RlZCA9IDE7DQogCQkJfSBlbHNlIGlmICghc3RyY21w
KGFyZywgIi0tZnNjay1vYmplY3RzIikpIHsNCiAJCQkJZG9fZnNja19vYmplY3QgPSAxOw0KKwkJ
CX0gZWxzZSBpZiAoIXN0cmNtcChhcmcsICItLWNsb25pbmciKSkgew0KKwkJCQljbG9uaW5nID0g
MTsNCiAJCQl9IGVsc2UgaWYgKCFzdHJjbXAoYXJnLCAiLS12ZXJpZnkiKSkgew0KIAkJCQl2ZXJp
ZnkgPSAxOw0KIAkJCX0gZWxzZSBpZiAoIXN0cmNtcChhcmcsICItLXZlcmlmeS1zdGF0IikpIHsN
CmRpZmYgLS1naXQgYS9mZXRjaC1wYWNrLmMgYi9mZXRjaC1wYWNrLmMNCmluZGV4IGIzZWQ3MTIx
Yi4uYzc1YmZiOGFhIDEwMDY0NA0KLS0tIGEvZmV0Y2gtcGFjay5jDQorKysgYi9mZXRjaC1wYWNr
LmMNCkBAIC04NDMsNiArODQzLDggQEAgc3RhdGljIGludCBnZXRfcGFjayhzdHJ1Y3QgZmV0Y2hf
cGFja19hcmdzICphcmdzLA0KIAkJCWFyZ3ZfYXJyYXlfcHVzaCgmY21kLmFyZ3MsICItLWNoZWNr
LXNlbGYtY29udGFpbmVkLWFuZC1jb25uZWN0ZWQiKTsNCiAJCWlmIChhcmdzLT5mcm9tX3Byb21p
c29yKQ0KIAkJCWFyZ3ZfYXJyYXlfcHVzaCgmY21kLmFyZ3MsICItLXByb21pc29yIik7DQorCQlp
ZiAoYXJncy0+Y2xvbmluZykNCisJCQlhcmd2X2FycmF5X3B1c2hmKCZjbWQuYXJncywgIi0tY2xv
bmluZyIpOw0KIAl9DQogCWVsc2Ugew0KIAkJY21kX25hbWUgPSAidW5wYWNrLW9iamVjdHMiOw0K
LS0gDQoyLjE5LjEuMzI4Lmc1YTBjYzhhY2EuZGlydHkNCg0KDQo=
