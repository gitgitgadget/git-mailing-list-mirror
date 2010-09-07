From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree
 entries missing from index
Date: Mon, 6 Sep 2010 21:06:13 -0600
Message-ID: <AANLkTinPyXCGWXH6VUtvTx6Cb4F5Bn238HQRE7tDZDtJ@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-8-git-send-email-newren@gmail.com>
	<AANLkTinACDSruJXon0DkbU8V=ko55KzpVZmCRKA7i=5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 05:06:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsoVw-0004xD-Sb
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 05:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab0IGDGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 23:06:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0IGDGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 23:06:19 -0400
Received: by fxm13 with SMTP id 13so2767451fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1wLqHCTKjUOkmj3Dmz2uq40wW1025CnoHHsIHxMG9Hg=;
        b=RHjA4iF340kjiw81QpnuSUfw4M9B68TzR06TWuXaqh6k/mwzqvciSWTKhjt9AsUgv7
         FtvblFUeULXkZPeuaQTvCtQwXXJ2uzfUrj2jJzdA5AwEXAtZCfX5oX5p3VGzrR9apNTA
         +R1i9Wy7vMnVc2kvZ6znN+Hzm9wvB96q4iqSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tHvSQSjil5R6F+y5HH25PWE19JNRTNMnkeBAyYkWRTsSqNMQYTsRBuFGZ0zpxWiPFG
         eKX9ODa4zx05jeHLgBZulZP4GNfeAogDQ2w+qYdTM6C2MpFBAkuMfTc5h0ZucdDdhd51
         jU3g7hP+GFdf/SjFC53R3Ub+g7W7WQBGG5QjM=
Received: by 10.223.125.196 with SMTP id z4mr3235764far.80.1283828773213; Mon,
 06 Sep 2010 20:06:13 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 20:06:13 -0700 (PDT)
In-Reply-To: <AANLkTinACDSruJXon0DkbU8V=ko55KzpVZmCRKA7i=5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155668>

T24gTW9uLCBTZXAgNiwgMjAxMCBhdCA3OjI4IFBNLCBOZ3V5ZW4gVGhhaSBOZ29jIER1eSA8cGNs
b3Vkc0BnbWFpbC5jb20+IHdyb3RlOgo+IE9uIFN1biwgU2VwIDUsIDIwMTAgYXQgMTA6MTMgQU0s
IEVsaWphaCBOZXdyZW4gPG5ld3JlbkBnbWFpbC5jb20+IHdyb3RlOgo+PiArc3RhdGljIHZvaWQg
YWRkX21pc3NpbmdfcGF0aHNfYmVmb3JlKGNvbnN0IGNoYXIgKnBhdGgsCj4+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgcGF0aGxlbiwK
Pj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGludCBiYXNlbGVuLAo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3RydWN0IHRyZWVfZGVzYyAqZGVzYywKPj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBzdHJidWYgKmJ1
ZmZlcikKPj4gK3sKPj4gKyDCoCDCoCDCoCBpZiAoIWdpdF9zcGFyc2VfcGF0aHNwZWNzKQo+PiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjsgLyogTm8gcGF0aHMgYXJlIG1pc3NpbmcgKi8K
Pj4gKwo+PiArIMKgIMKgIMKgIGZvciAoOyBkZXNjLT5zaXplOyB1cGRhdGVfdHJlZV9lbnRyeShk
ZXNjKSkgewo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBuYW1lX2VudHJ5IGVudHJ5
ID0gZGVzYy0+ZW50cnk7Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IGVudGxlbiA9IHN0
cmxlbihlbnRyeS5wYXRoKTsKPj4gKwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFdlIG9u
bHkgd2FudCBwYXRocyBiZWZvcmUgcGF0aCAqLwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlm
IChwYXRoKQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qCj4+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIEZJWE1FOiBpZiBlbnRsZW4gPCBwYXRo
bGVuLCBkbyBJIG5lZWQgdG8KPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCogdXNlIHN0cm5jbXAgaW5zdGVhZD8gRG9lcyBlbnRyeS5wYXRoIGJlaW5nCj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIE5VTC10ZXJtaW5hdGVkIGVuc3VyZSBtZW1j
bXAgZXhpdHMKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogZWFybHk/
Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqLwo+PiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChtZW1jbXAoZW50cnkucGF0aCwKPj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGgrYmFzZWxl
biwKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHBhdGhsZW4tYmFzZWxlbikgPj0gMCkKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBicmVhazsKPgo+IElmIHlvdSBkbyAiYnJlYWs7IiBoZXJlLCB0aGUg
Y3VycmVudCBlbnRyeSByZW1haW5zIGluICJkZXNjIiBhbmQgd2lsbAo+IGJlIHVzZWQgdG8gcmVn
ZW5lcmF0ZSBhIGR1cGxpY2F0ZSB0cmVlIGluCj4gYWRkX21pc3NpbmdfcGF0aHNfYmVmb3JlKE5V
TEwsIDAsIDAsIC4uKTsuIFRoYXQgZW50cnkgaXMgYWRkZWQgdGhlCj4gZmlyc3QgdGltZSBieSB1
cGRhdGVfb25lIGl0c2VsZiBiZWZvcmUgdGhlIHNlY29uZCBhZGRfbWlzc2luZygpIGNhbGwuCj4g
VGhpcyBmaXhlcyBpdCBmb3IgbWUKPgo+IGRpZmYgLS1naXQgYS9jYWNoZS10cmVlLmMgYi9jYWNo
ZS10cmVlLmMKPiBpbmRleCA3OWMyOGNjLi4xNjU1NzM4IDEwMDY0NAo+IC0tLSBhL2NhY2hlLXRy
ZWUuYwo+ICsrKyBiL2NhY2hlLXRyZWUuYwo+IEBAIC0yNzgsMTcgKzI3OCwxOSBAQCBzdGF0aWMg
dm9pZCBhZGRfbWlzc2luZ19wYXRoc19iZWZvcmUoY29uc3QgY2hhciAqcGF0aCwKPiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGludCBlbnRsZW4gPSBzdHJsZW4oZW50cnkucGF0aCk7Cj4KPiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC8qIFdlIG9ubHkgd2FudCBwYXRocyBiZWZvcmUgcGF0aCAqLwo+
IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHBhdGgpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAocGF0aCkgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyoKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEZJWE1FOiBpZiBlbnRsZW4gPCBw
YXRobGVuLCBkbyBJIG5lZWQgdG8KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAqIHVzZSBzdHJuY21wIGluc3RlYWQ/IERvZXMgZW50cnkucGF0aCBiZWluZwo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogTlVMLXRlcm1pbmF0ZWQgZW5zdXJlIG1lbWNt
cCBleGl0cwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogZWFybHk/Cj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi8KPiAtIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmIChtZW1jbXAoZW50cnkucGF0aCwKPiAtIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGF0aCtiYXNlbGVuLAo+IC0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYXRobGVu
LWJhc2VsZW4pID49IDApCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQg
cmVzdWx0ID0gbWVtY21wKGVudHJ5LnBhdGgsIHBhdGgrYmFzZWxlbiwgcGF0aGxlbi1iYXNlbGVu
KTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChyZXN1bHQgPiAwKQo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7Cj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIXJlc3VsdCkKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOwo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfQo+Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBXZSBvbmx5
IHdhbnQgcGF0aHMgIm1pc3NpbmciIGZyb20gaW5kZXggZHVlIHRvIHNwYXJzaXR5ICovCj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocGF0aCkgewoKWWVzLCBnb29kIGNhdGNoIGFuZCB0aGFu
a3MgZm9yIHRoZSBmaXguCg==
