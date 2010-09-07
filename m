From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree
 entries missing from index
Date: Tue, 7 Sep 2010 11:28:10 +1000
Message-ID: <AANLkTinACDSruJXon0DkbU8V=ko55KzpVZmCRKA7i=5f@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osmyw-00087L-4V
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab0IGB2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:28:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49254 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab0IGB2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:28:12 -0400
Received: by wyf22 with SMTP id 22so3630024wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9FSXQuS4j1l2s5jYANyZz+ta9laDqOz/TtbHYHwDlmo=;
        b=BOuewAkX+Dwbi8yd3XjCM6JRqXALKCNkcYW03CB7xOcKLfF6w1/UH7VGud3Ui9WC+O
         J+5vawmUor6uW6wsZhG+UThKye1iSVuJn3nqRmpL3acpqAh2r0LGxA36lmCmkggL/tum
         IZmWDU9AOR5DpLomjEbbhrqthN8ZvI6/t0aM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mDEzf0MOiuk90XOoLzz3WCzFuI6Uzw/A35gMyPUhg9rCnRyXAbwgGg8KCGp8hdFPCq
         6ca5QSZj9xVDSkN6JfMfcBPdqca7cjFykG3MgXHUX2BJXS7ogFKEcancNpDOHHgfPTa5
         llOSUSOAVKBDWlEW11TRzV4JXeJYraXX1MY+4=
Received: by 10.216.1.20 with SMTP id 20mr3537254wec.66.1283822890906; Mon, 06
 Sep 2010 18:28:10 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Mon, 6 Sep 2010 18:28:10 -0700 (PDT)
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155656>

T24gU3VuLCBTZXAgNSwgMjAxMCBhdCAxMDoxMyBBTSwgRWxpamFoIE5ld3JlbiA8bmV3cmVuQGdt
YWlsLmNvbT4gd3JvdGU6Cj4gK3N0YXRpYyB2b2lkIGFkZF9taXNzaW5nX3BhdGhzX2JlZm9yZShj
b25zdCBjaGFyICpwYXRoLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpbnQgcGF0aGxlbiwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IGJhc2VsZW4sCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCB0cmVlX2Rl
c2MgKmRlc2MsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN0cnVjdCBzdHJidWYgKmJ1ZmZlcikKPiArewo+ICsgwqAgwqAgwqAgaWYgKCFn
aXRfc3BhcnNlX3BhdGhzcGVjcykKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjsgLyog
Tm8gcGF0aHMgYXJlIG1pc3NpbmcgKi8KPiArCj4gKyDCoCDCoCDCoCBmb3IgKDsgZGVzYy0+c2l6
ZTsgdXBkYXRlX3RyZWVfZW50cnkoZGVzYykpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0
cnVjdCBuYW1lX2VudHJ5IGVudHJ5ID0gZGVzYy0+ZW50cnk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpbnQgZW50bGVuID0gc3RybGVuKGVudHJ5LnBhdGgpOwo+ICsKPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC8qIFdlIG9ubHkgd2FudCBwYXRocyBiZWZvcmUgcGF0aCAqLwo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgaWYgKHBhdGgpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAvKgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIEZJWE1FOiBp
ZiBlbnRsZW4gPCBwYXRobGVuLCBkbyBJIG5lZWQgdG8KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKiB1c2Ugc3RybmNtcCBpbnN0ZWFkPyBEb2VzIGVudHJ5LnBhdGggYmVp
bmcKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBOVUwtdGVybWluYXRl
ZCBlbnN1cmUgbWVtY21wIGV4aXRzCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCogZWFybHk/Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovCj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAobWVtY21wKGVudHJ5LnBhdGgs
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBh
dGgrYmFzZWxlbiwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcGF0aGxlbi1iYXNlbGVuKSA+PSAwKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7CgpJZiB5b3UgZG8gImJyZWFrOyIgaGVyZSwg
dGhlIGN1cnJlbnQgZW50cnkgcmVtYWlucyBpbiAiZGVzYyIgYW5kIHdpbGwKYmUgdXNlZCB0byBy
ZWdlbmVyYXRlIGEgZHVwbGljYXRlIHRyZWUgaW4KYWRkX21pc3NpbmdfcGF0aHNfYmVmb3JlKE5V
TEwsIDAsIDAsIC4uKTsuIFRoYXQgZW50cnkgaXMgYWRkZWQgdGhlCmZpcnN0IHRpbWUgYnkgdXBk
YXRlX29uZSBpdHNlbGYgYmVmb3JlIHRoZSBzZWNvbmQgYWRkX21pc3NpbmcoKSBjYWxsLgpUaGlz
IGZpeGVzIGl0IGZvciBtZQoKZGlmZiAtLWdpdCBhL2NhY2hlLXRyZWUuYyBiL2NhY2hlLXRyZWUu
YwppbmRleCA3OWMyOGNjLi4xNjU1NzM4IDEwMDY0NAotLS0gYS9jYWNoZS10cmVlLmMKKysrIGIv
Y2FjaGUtdHJlZS5jCkBAIC0yNzgsMTcgKzI3OCwxOSBAQCBzdGF0aWMgdm9pZCBhZGRfbWlzc2lu
Z19wYXRoc19iZWZvcmUoY29uc3QgY2hhciAqcGF0aCwKIAkJaW50IGVudGxlbiA9IHN0cmxlbihl
bnRyeS5wYXRoKTsKCiAJCS8qIFdlIG9ubHkgd2FudCBwYXRocyBiZWZvcmUgcGF0aCAqLwotCQlp
ZiAocGF0aCkKKwkJaWYgKHBhdGgpIHsKIAkJCS8qCiAJCQkgKiBGSVhNRTogaWYgZW50bGVuIDwg
cGF0aGxlbiwgZG8gSSBuZWVkIHRvCiAJCQkgKiB1c2Ugc3RybmNtcCBpbnN0ZWFkPyBEb2VzIGVu
dHJ5LnBhdGggYmVpbmcKIAkJCSAqIE5VTC10ZXJtaW5hdGVkIGVuc3VyZSBtZW1jbXAgZXhpdHMK
IAkJCSAqIGVhcmx5PwogCQkJICovCi0JCQlpZiAobWVtY21wKGVudHJ5LnBhdGgsCi0JCQkJICAg
cGF0aCtiYXNlbGVuLAotCQkJCSAgIHBhdGhsZW4tYmFzZWxlbikgPj0gMCkKKwkJCWludCByZXN1
bHQgPSBtZW1jbXAoZW50cnkucGF0aCwgcGF0aCtiYXNlbGVuLCBwYXRobGVuLWJhc2VsZW4pOwor
CQkJaWYgKHJlc3VsdCA+IDApCiAJCQkJYnJlYWs7CisJCQlpZiAoIXJlc3VsdCkKKwkJCQljb250
aW51ZTsKKwkJfQoKIAkJLyogV2Ugb25seSB3YW50IHBhdGhzICJtaXNzaW5nIiBmcm9tIGluZGV4
IGR1ZSB0byBzcGFyc2l0eSAqLwogCQlpZiAocGF0aCkgewotLSAKRHV5Cg==
