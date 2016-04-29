From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 22:39:42 +0000
Message-ID: <1461969582.731.1.camel@intel.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	 <1461079290-6523-3-git-send-email-sbeller@google.com>
	 <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	 <20160420041827.GA7627@sigill.intra.peff.net>
	 <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	 <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	 <xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
	 <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "gitster@pobox.com" <gitster@pobox.com>,
	"sbeller@google.com" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:39:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awH4e-0000Vr-MY
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 00:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbcD2Wjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 18:39:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:32007 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbcD2Wjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 18:39:44 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Apr 2016 15:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,553,1455004800"; 
   d="scan'208";a="694527067"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2016 15:39:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.60]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.174]) with mapi id 14.03.0248.002;
 Fri, 29 Apr 2016 15:39:43 -0700
Thread-Topic: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Thread-Index: AQHRomUCiT74xvCpKU+P1kyy8u/Khp+h/4kAgAABEAA=
In-Reply-To: <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.173]
Content-ID: <C245153C3B1D6F4E84E9E9C4D0857D30@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293063>

T24gRnJpLCAyMDE2LTA0LTI5IGF0IDE1OjM1IC0wNzAwLCBTdGVmYW4gQmVsbGVyIHdyb3RlOg0K
PiBPbiBGcmksIEFwciAyOSwgMjAxNiBhdCAzOjE4IFBNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEphY29iIEtlbGxlciA8amFjb2Iua2Vs
bGVyQGdtYWlsLmNvbT4gd3JpdGVzOg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBGcmksIEFwciAy
OSwgMjAxNiBhdCAxOjI5IFBNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jbw0KPiA+
ID4gbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+
IHdyaXRlczoNCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gLi4uIEhhdmluZyB0aGUg
dHdvIGRpcmVjdGx5IG5leHQgdG8gZWFjaCBvdGhlciByZWFkcw0KPiA+ID4gPiA+IGJldHRlciB0
byBtZS4gVGhpcyBpcyBhIHByZXR0eSB1bnVzdWFsIGRpZmYsIHRob3VnaCwgaW4gdGhhdA0KPiA+
ID4gPiA+IGl0IGRpZA0KPiA+ID4gPiA+IGNoYW5nZSB0aGUgc3Vycm91bmRpbmcgd2hpdGVzcGFj
ZSAoYW5kIGlmIHlvdSBsb29rIGZ1cnRoZXIgaW4NCj4gPiA+ID4gPiB0aGUgZGlmZiwNCj4gPiA+
ID4gPiB0aGUgaWRlbnRpY2FsIGNoYW5nZSBpcyBtYWRlIGVsc2V3aGVyZSBfd2l0aG91dF8gdG91
Y2hpbmcgdGhlDQo+ID4gPiA+ID4gd2hpdGVzcGFjZSkuIFNvIHRoaXMgaXMga2luZCBvZiBhbiBh
bm9tYWx5LiBBbmQgSU1ITyB0aGUNCj4gPiA+ID4gPiB3ZWlyZG5lc3MgaGVyZQ0KPiA+ID4gPiA+
IGlzIG91dHdlaWdoZWQgYnkgdGhlIHZhc3QgbnVtYmVyIG9mIGltcHJvdmVtZW50cyBlbHNld2hl
cmUuDQo+ID4gPiA+IFNvLi4uIGlzIGV2ZXJ5Ym9keSBoYXBweSB3aXRoIHRoZSByZXN1bHQgYW5k
IG5vdyB3ZSBjYW4gZHJvcA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gdHdlYWtpbmcga25vYiBhZGRl
ZCB0byBoZWxwIGV4cGVyaW1lbnRhdGlvbiBiZWZvcmUgbWVyZ2luZyB0aGUNCj4gPiA+ID4gcmVz
dWx0IHRvICdtYXN0ZXInPw0KPiA+ID4gPiANCj4gPiA+ID4gSSBhbSBwcmV0dHkgaGFwcHkgd2l0
aCB0aGUgZW5kIHJlc3VsdCBteXNlbGYuDQo+ID4gPiBJIGFtIHZlcnkgaGFwcHkgd2l0aCBpdC4g
SSBoYXZlbid0IGhhZCBhbnkgaXNzdWVzLCBhbmQgSSB0aGluaw0KPiA+ID4gd2UnbGwNCj4gPiA+
IGZpbmQgYmV0dGVyIHRyYWN0aW9uIGJ5IGVuYWJsaW5nIGl0IGF0IHRoaXMgcG9pbnQgYW5kIHNl
ZWluZw0KPiA+ID4gd2hlbi9pZg0KPiA+ID4gc29tZW9uZSBjb21wbGFpbnMuDQo+ID4gPiANCj4g
PiA+IEkgdGhpbmsgZm9yIG1vc3QgaXQgd29uJ3QgYmUgbm90aWNlZCBhbmQgZm9yIHRob3NlIHRo
YXQgZG8gaXQNCj4gPiA+IHdpbGwNCj4gPiA+IGxpa2VseSBiZSBwb3NpdGl2ZS4NCj4gPiBJIGFt
IGRvaW5nIHRoaXMgb25seSB0byBwcmVwYXJlIGluIGNhc2Ugd2UgaGF2ZSBhIGNvbmNlbnN1cywN
Cj4gPiBpLmUuIHRoaXMgaXMgbm90IHRvIGRlY2xhcmUgdGhhdCBJIGRvIG5vdCBjYXJlIHdoYXQg
b3RoZXIgcGVvcGxlDQo+ID4gc2F5LsKgwqBIZXJlIGlzIGEgcGF0Y2ggdG8gcmVtb3ZlIHRoZSBl
eHBlcmltZW50YXRpb24ga25vYi4NCj4gPiANCj4gPiBMZXQncyBzYXkgd2Uga2VlcCB0aGlzIHBh
dGNoIG91dCBvZiB0cmVlIGZvciBub3cgYW5kIGtlZXAgdGhlIHRvcGljDQo+ID4gaW4gJ25leHQn
IHNvIHRoYXQgcGVvcGxlIGNhbiBmdXJ0aGVyIHBsYXkgd2l0aCBpdCBmb3Igc2V2ZXJhbCBtb3Jl
DQo+ID4gd2Vla3MsIGFuZCB0aGVuIGFwcGx5IHRoaXMgb24gdG9wIGFuZCBtZXJnZSB0aGUgcmVz
dWx0IHRvICdtYXN0ZXInDQo+ID4gZWFybHkgaW4gdGhlIG5leHQgY3ljbGUuDQo+ID4gDQo+ID4g
LS0gPjggLS0NCj4gPiBkaWZmOiBlbmFibGUgImNvbXBhY3Rpb24gaGV1cmlzdGljcyIgYW5kIGxv
c2UgZXhwZXJpbWVudGF0aW9uIGtub2INCj4gPiANCj4gPiBJdCBzZWVtcyB0aGF0IHRoZSBuZXcg
ImZpbmQgYSBnb29kIGh1bmsgYm91bmRhcnkgYnkgbG9jYXRpbmcgYQ0KPiA+IGJsYW5rDQo+ID4g
bGluZSIgaGV1cmlzdGljcyBnaXZlcyBtdWNoIG1vcmUgcGxlYXNhbnQgcmVzdWx0IHdpdGhvdXQg
bXVjaA0KPiA+IG5vdGljZWFibGUgZG93bnNpZGVzLsKgwqBMZXQncyBtYWtlIGl0IHRoZSBuZXcg
YWxnb3JpdGhtIGZvciByZWFsLA0KPiA+IHdpdGhvdXQgdGhlIG9wdC1vdXQga25vYiB3ZSBhZGRl
ZCB3aGlsZSBleHBlcmltZW50aW5nIHdpdGggaXQuDQo+IEkgd291bGQgcmVtb3ZlIHRoZSBvcHQt
b3V0IGtub2IgbXVjaCBsYXRlciBpbiB0aGUgZ2FtZSwgaS5lLg0KPiANCj4gwqDCoMKgwqAxKSBt
YWtlIGEgcGF0Y2ggdGhhdCByZW1vdmVzIHRoZSBkb2N1bWVudGF0aW9uIG9ubHkNCj4gwqDCoMKg
wqDCoMKgwqBiZWZvcmUgdGhlIG5leHQgcmVsZWFzZSAoaS5lLiBiZWZvcmUgMi45KQ0KPiDCoMKg
wqDCoDIpIG1ha2UgYSBwYXRjaCB0byByZW1vdmUgdGhlIGFjdHVhbCAodW5sYWJlbGVkKSBrbm9i
cywNCj4gwqDCoMKgwqDCoMKgwqDCoG1lcmdlIGludG8gbWFzdGVyIGJlZm9yZSAyLjEwIChpLmUu
IGp1c3QgYWZ0ZXIgdGhlIDIuOQ0KPiByZWxlYXNlKQ0KPiANCj4gVGhlbiB3ZSBnZXQgdGhlIG1v
c3Qgb2YgdGhlIGNvbW11bml0eSB0byB0ZXN0IGl0IHdpdGggdGhlIDIuOSByZWxlYXNlDQo+IGFu
ZCBzdGlsbCBoYXZlIGFuIGVtZXJnZW5jeSBrbm9iIGluIGNhc2Ugc29tZSBtYWpvciBoZWFkYWNo
ZXMNCj4gc2hvdyB1cC4gQWZ0ZXIgb25lIHJlbGVhc2UgY3ljbGUgd2UnbGwgYmUgbXVjaCBtb3Jl
IGNvbmZpZGVudA0KPiBhYm91dCBpdHMgdXNhZ2UgYW5kIGl0cyBzaG9ydCBjb21pbmdzIGFuZCBk
byBub3QgbmVlZCB0aGUNCj4gZW1lcmdlbmN5IHR1cm4gb2ZmLiBJZiB0aGUgY29tbXVuaXR5IGRv
ZXNuJ3QgbGlrZSBpdCBmb3Igc29tZSByZWFzb24NCj4gd2UgY2FuIGRvY3VtZW50IGl0IGFuZCBk
ZWJhdGUgdGhlIGRlZmF1bHQgc2V0dGluZz8NCj4gDQo+IEkgYWdyZWUgd2Ugd2FudCB0aGUga25v
YiBnb25lIGV2ZW50dWFsbHkuDQo+IE1ha2luZyBpdCBhbiB1bmRvY3VtZW50ZWQgZmVhdHVyZSBp
cyBhcyBnb29kIGFzIHRoYXQgZnJvbQ0KPiBhIHVzZXJzIHBvaW50IG9mIHZpZXc/DQo+IA0KDQpD
dXJyZW50bHkgaXQncyBhbiAib3B0IGluIiBrbm9iLCBzbyB0aGlzIGRvZXNuJ3QgbWFrZSBzZW5z
ZSB0byBtZS4gSWYNCndlIHJlbW92ZSB0aGUgZW50aXJlIGtub2IgYXMgaXMsIHdlIGNhbiBhbHdh
eXMgKGZhaXJseSBlYXNpbHkpIGFkZCBpdA0KYmFjay4gSSB3b3VsZCBrZWVwIHRoZSBjb2RlIGlu
c2lkZSB4ZGlmZiBhcyBhIGtub2IsIGJ1dCBzZXQgaXQgdG8NCmVuYWJsZSBkZWZhdWx0IHNvIHRo
YXQgdGhlIHVzZXIgY29uZmlnIGhhcyBubyBrbm9iIGF0IHRoZSB0b3AgbGV2ZWwgYnV0DQp0aGUg
eGRpZmYgbWFjaGluZXJ5IGRvZXMgKHRoaXMgbWFraW5nIGEgImRpc2FibGUiIGJlIHJlbGF0aXZl
bHkgc21hbGwNCnBhdGNoKS4NCg0KVGhhbmtzLA0KSmFrZQ==
