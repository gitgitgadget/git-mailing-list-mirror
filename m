From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH v3 2/4] Refactoring: connect.c: move duplicated code to a 
	new function 'get_host_and_port'
Date: Wed, 17 Feb 2010 13:02:20 +0300
Message-ID: <63cde7731002170202g78a47d20l62381a8bd61e65fd@mail.gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
	 <0d6d0066fecc892bd5b6afda64e1aa5591347504.1266360267.git.michael.lukashov@gmail.com>
	 <20100217000456.GA28433@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhgjl-0004un-Ny
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 11:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933950Ab0BQKCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 05:02:23 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:40183 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004Ab0BQKCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 05:02:22 -0500
Received: by ewy28 with SMTP id 28so2656228ewy.28
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 02:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XDWp/OZyso1bT0mb/gb/mj7lQITHZ0tUqQW1Mi7toWw=;
        b=gBb6L6Wdh+uRORWaLIUw8koy+cv5z3/wFAyeG9Gt4dd+ZBjshG9Ifwoxws616vv5uT
         ffKntrksVhKL99cEq6o06QRm+q1x7p5EcV1/ToB0IaWfKkyyIRRjFsrPR/TimBpvL03R
         UFhQBEe5R6N/QfwdBEc8jZZ+l7XZze9UnUB8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SZq7UmTcgHjaBfVkNs8krcTjpiFYg7ZKBAWM1iKtm3SJIyZDZl8zr95FWKl9ht9Mgm
         7g7whe0yl9VvP2axMZ/sICOZHBD7DeI9GasCN0Xvqacx1Rkb/pX9ODWkuGuK7Fxa0WB/
         p6+AyXcypVpZHA2d6DErScnuYR9wKRi9htczA=
Received: by 10.216.89.138 with SMTP id c10mr306706wef.47.1266400940374; Wed, 
	17 Feb 2010 02:02:20 -0800 (PST)
In-Reply-To: <20100217000456.GA28433@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140225>

T24gV2VkLCBGZWIgMTcsIDIwMTAgYXQgMzowNCBBTSwgTGFycnkgRCdBbm5hIDxsYXJyeUBlbGRl
ci1nb2RzLm9yZz4gd3JvdGU6Cj4gKiBNaWNoYWVsIEx1a2FzaG92IChtaWNoYWVsLmx1a2FzaG92
QGdtYWlsLmNvbSkgWzEwMDIxNiAxODo0M106Cj4KPj4gQEAgLTE3MCwzMCArMTkyLDE0IEBAIHN0
YXRpYyBjb25zdCBjaGFyICphaV9uYW1lKGNvbnN0IHN0cnVjdCBhZGRyaW5mbyAqYWkpCj4+IMKg
c3RhdGljIGludCBnaXRfdGNwX2Nvbm5lY3Rfc29jayhjaGFyICpob3N0LCBpbnQgZmxhZ3MpCj4+
IMKgewo+PiDCoCDCoCDCoCBpbnQgc29ja2ZkID0gLTEsIHNhdmVkX2Vycm5vID0gMDsKPj4gLSDC
oCDCoCBjaGFyICpjb2xvbiwgKmVuZDsKPj4gwqAgwqAgwqAgY29uc3QgY2hhciAqcG9ydCA9IFNU
UihERUZBVUxUX0dJVF9QT1JUKTsKPj4gwqAgwqAgwqAgc3RydWN0IGFkZHJpbmZvIGhpbnRzLCAq
YWkwLCAqYWk7Cj4+IMKgIMKgIMKgIGludCBnYWk7Cj4+IMKgIMKgIMKgIGludCBjbnQgPSAwOwo+
Pgo+PiAtIMKgIMKgIGlmIChob3N0WzBdID09ICdbJykgewo+PiAtIMKgIMKgIMKgIMKgIMKgIMKg
IGVuZCA9IHN0cmNocihob3N0ICsgMSwgJ10nKTsKPj4gLSDCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
ZW5kKSB7Cj4+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKmVuZCA9IDA7Cj4+IC0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZW5kKys7Cj4+IC0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgaG9zdCsrOwo+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZQo+PiAt
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVuZCA9IGhvc3Q7Cj4+IC0gwqAgwqAgfSBl
bHNlCj4+IC0gwqAgwqAgwqAgwqAgwqAgwqAgZW5kID0gaG9zdDsKPj4gLSDCoCDCoCBjb2xvbiA9
IHN0cmNocihlbmQsICc6Jyk7Cj4+IC0KPj4gLSDCoCDCoCBpZiAoY29sb24pIHsKPj4gLSDCoCDC
oCDCoCDCoCDCoCDCoCAqY29sb24gPSAwOwo+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIHBvcnQgPSBj
b2xvbiArIDE7Cj4+IC0gwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCEqcG9ydCkKPj4gLSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwb3J0ID0gIjxub25lPiI7Cj4+IC0gwqAgwqAgfQo+PiAr
IMKgIMKgIGdldF9ob3N0X2FuZF9wb3J0KCZob3N0LCAmcG9ydCk7Cj4+ICsgwqAgwqAgaWYgKCEq
cG9ydCkKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCAqcG9ydCA9ICI8bm9uZT4iOwo+Cj4gQWdhaW4s
IGlzbid0IHRoaXMgd3Jvbmc/IMKgVGhpcyBkb2Vzbid0IGV2ZW4gY29tcGlsZSBmb3IgbWUuIMKg
U2hvdWxkbid0IGl0IGJlCj4KPiBwb3J0ID0gIjxub25lPiI7Cj4KPiA/Pwo+Cj4gV2hhdCBhbSBJ
IG1pc3Npbmc/Cj4KPiDCoCDCoCAtLWxhcnJ5Cj4KCk9vcHMsIG15IGJhZCwgc29ycnkuClN0cmFu
Z2UsIG15IG1pbmd3LWdjYyA0LjQuMCBjb21waWxlciBkaWRuJ3QgaXNzdWUgbm8gZXJyb3JzIG9y
Cndhcm5pbmdzLiBXZWlyZCBpbmRlZWQuCkknbGwgc2VuZCByZXBhaXJlZCBwYXRjaCBsYXRlci4K
