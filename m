From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 22:48:33 +0000
Message-ID: <1461970113.731.3.camel@intel.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	 <1461079290-6523-3-git-send-email-sbeller@google.com>
	 <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	 <20160420041827.GA7627@sigill.intra.peff.net>
	 <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	 <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	 <xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
	 <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
	 <1461969582.731.1.camel@intel.com>
	 <CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"peff@peff.net" <peff@peff.net>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "sbeller@google.com" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:48:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHDD-000513-Ss
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 00:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbcD2Wsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 18:48:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:16921 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcD2Wsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 18:48:35 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP; 29 Apr 2016 15:48:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,553,1455004800"; 
   d="scan'208";a="943162174"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2016 15:48:34 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.60]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.95]) with mapi id 14.03.0248.002;
 Fri, 29 Apr 2016 15:48:33 -0700
Thread-Topic: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Thread-Index: AQHRomUCiT74xvCpKU+P1kyy8u/Khp+h/4kAgAABEACAAAFwgIAAAQmA
In-Reply-To: <CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.173]
Content-ID: <A9BBC44D0F1CDC4E8F9B7E0B4C88E4D8@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293065>

T24gRnJpLCAyMDE2LTA0LTI5IGF0IDE1OjQ0IC0wNzAwLCBTdGVmYW4gQmVsbGVyIHdyb3RlOg0K
PiA+IA0KPiA+IEN1cnJlbnRseSBpdCdzIGFuICJvcHQgaW4iIGtub2IsIHNvIHRoaXMgZG9lc24n
dCBtYWtlIHNlbnNlIHRvIG1lLg0KPiArc3RhdGljIGludCBkaWZmX2NvbXBhY3Rpb25faGV1cmlz
dGljID0gMTsNCj4gDQoNCk9vcHMgZGlkbid0IGtub3cgd2UnZCBtYWRlIGl0IGRlZmF1bHQgYXQg
c29tZSBwb2ludC4gKGFsbCBteSB2ZXJzaW9ucw0KaGFkIGl0IGRpc2FibGVkIGJ5IGRlZmF1bHQp
DQoNCj4gSXQncyByYXRoZXIgYW4gb3B0LW91dCBrbm9iIGdvaW5nIGJ5IHRoZSBjdXJyZW50DQo+
IG9yaWdpbi9qay9kaWZmLWNvbXBhY3QtaGV1cmlzdGljDQo+IA0KDQpZZWEgaW4gdGhhdCBjYXNl
LCB3ZSBjb3VsZCBrZWVwIGl0Lg0KDQo+IA0KPiA+IA0KPiA+IElmDQo+ID4gd2UgcmVtb3ZlIHRo
ZSBlbnRpcmUga25vYiBhcyBpcywgd2UgY2FuIGFsd2F5cyAoZmFpcmx5IGVhc2lseSkgYWRkDQo+
ID4gaXQNCj4gPiBiYWNrLiBJIHdvdWxkIGtlZXAgdGhlIGNvZGUgaW5zaWRlIHhkaWZmIGFzIGEg
a25vYiwgYnV0IHNldCBpdCB0bw0KPiA+IGVuYWJsZSBkZWZhdWx0IHNvIHRoYXQgdGhlIHVzZXIg
Y29uZmlnIGhhcyBubyBrbm9iIGF0IHRoZSB0b3AgbGV2ZWwNCj4gPiBidXQNCj4gPiB0aGUgeGRp
ZmYgbWFjaGluZXJ5IGRvZXMgKHRoaXMgbWFraW5nIGEgImRpc2FibGUiIGJlIHJlbGF0aXZlbHkN
Cj4gPiBzbWFsbA0KPiA+IHBhdGNoKS4NCj4gV2hlbiB3cml0aW5nIG15IHJlcGx5LCBJIHRob3Vn
aHQgYWJvdXQgcGVvcGxlIHVzaW5nIEdpdCBmcm9tIGEgYmluYXJ5DQo+IGRpc3RyaWJ1dGlvbiB3
aXRoIGxpdHRsZSB0byBubyBhZG1pbiByaWdodHMuIFRoZXkgd2FudCB0byBoYXZlIGFuDQo+IGVt
ZXJnZW5jeQ0KPiBrbm9iIHRvIGRpc2FibGUgdGhpcyB0aGluZywgYnV0IGNhbm5vdCBwYXRjaC9y
ZWNvbXBpbGUgR2l0Lg0KPiANCj4gSWYgeW91IGNhbiBwYXRjaCBhbmQgY29tcGlsZSB5b3VyIHZl
cnNpb24gb2YgR2l0LCB0aGVuIHJldmVydGluZyBpcw0KPiBlYXN5LCBzbw0KPiBpbiB0aGF0IGNh
c2UgSnVuaW9zIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBUaGFua3MsDQo+IFN0ZWZh
bg0KDQpUcnVlLiBJIHRoaW5rIHRoZSBjaGFuY2VzIHRoYXQgaXQgbmVlZHMgc3VjaCBhIHRoaW5n
IGFyZSBxdWl0ZSBtaW5vciwNCmFuZCBpZiBhbiB1bmRvY3VtZW50ZWQga25vYiBnZXRzIGV4cG9z
ZWQgaXQgd291bGQgaGF2ZSB0byBiZWNvbWUNCmRvY3VtZW50ZWQgYW5kIG1haW50YWluZWQsIHNv
IEknZCBwcmVmZXIgdG8gYXZvaWQgaXQuIEdpdmVuIHRoYXQgdGhlDQpyaXNrIGlzIHByZXR0eSBz
bWFsbCBJIHRoaW5rIHRoYXQncyBvay4NCg0KVGhhbmtzLA0KSmFrZQ==
