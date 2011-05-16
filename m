From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 08/11] streaming_write_entry(): support files with holes
Date: Mon, 16 May 2011 10:03:46 -0300
Message-ID: <BANLkTi=A_vJbJ1v9NDVdh5DMNgTqHQXg6w@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
	<1305505831-31587-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 15:03:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLxSh-0005CK-IB
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 15:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1EPNDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 09:03:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58964 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1EPNDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 09:03:46 -0400
Received: by iyb14 with SMTP id 14so3704137iyb.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ECbd04gtiM0fKVkzSotUJJwoMNcd4ZRj9vWyrMFCtXA=;
        b=jeqHMCrFEa2uqkkHSdH4e4rBIvpFwU/y/lDzYSLeh44Ah3NnoklnOfWR3fqRr6JVKz
         t/5aFzR6gOxz4fSo+Q6qIwXTXHlktceYOAKFqOu2F2bMQZ/v9F0/HNUUDt/Dk1YH6YNM
         oHwcFLzmqN+qkAi1x2/VQLuGBVM6F+SdmnoTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EnuXpOW3b90PHBrCyTNv2Oo0E5iEUWfmB+T430XxHzyK/IFHoDy72EFFmR73MU7uq3
         t9p8Bb1IO5esxwxom/vDJGjcSVVanECOBP5JnkY27KvuIlr700V64P4R86bz2yIo5Cal
         wmRUcdfLypf0nhn3938XI8WnevNtZcBUmm86E=
Received: by 10.42.239.10 with SMTP id ku10mr104458icb.477.1305551026121; Mon,
 16 May 2011 06:03:46 -0700 (PDT)
Received: by 10.42.230.193 with HTTP; Mon, 16 May 2011 06:03:46 -0700 (PDT)
In-Reply-To: <1305505831-31587-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173733>

T24gU3VuLCBNYXkgMTUsIDIwMTEgYXQgOTozMCBQTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJA
cG9ib3guY29tPiB3cm90ZToKPiBPbmUgdHlwaWNhbCB1c2Ugb2YgYSBsYXJnZSBiaW5hcnkgZmls
ZSBpcyB0byBob2xkIGEgc3BhcnNlIG9uLWRpc2sgaGFzaAo+IHRhYmxlIHdpdGggYSBsb3Qgb2Yg
aG9sZXMuIEhlbHAgcHJlc2VydmluZyB0aGUgaG9sZXMgd2l0aCBsc2VlaygpLgo+Cj4gU2lnbmVk
LW9mZi1ieTogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPgo+IC0tLQo+IMKgZW50
cnkuYyB8IMKgIDE4ICsrKysrKysrKysrKysrKysrLQo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2VudHJ5LmMgYi9l
bnRyeS5jCj4gaW5kZXggNzczM2E2Yi4uZDUwZTM4OCAxMDA2NDQKPiAtLS0gYS9lbnRyeS5jCj4g
KysrIGIvZW50cnkuYwo+IEBAIC0xMjMsNiArMTIzLDcgQEAgc3RhdGljIGludCBzdHJlYW1pbmdf
d3JpdGVfZW50cnkoc3RydWN0IGNhY2hlX2VudHJ5ICpjZSwgY2hhciAqcGF0aCwKPiDCoCDCoCDC
oCDCoGVudW0gb2JqZWN0X3R5cGUgdHlwZTsKPiDCoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcgc3o7
Cj4gwqAgwqAgwqAgwqBpbnQgcmVzdWx0ID0gLTE7Cj4gKyDCoCDCoCDCoCBzc2l6ZV90IGtlcHQg
PSAwOwo+IMKgIMKgIMKgIMKgaW50IGZkID0gLTE7Cj4KPiDCoCDCoCDCoCDCoHN0ID0gb3Blbl9p
c3RyZWFtKGNlLT5zaGExLCAmdHlwZSwgJnN6KTsKPiBAQCAtMTM3LDE3ICsxMzgsMzIgQEAgc3Rh
dGljIGludCBzdHJlYW1pbmdfd3JpdGVfZW50cnkoc3RydWN0IGNhY2hlX2VudHJ5ICpjZSwgY2hh
ciAqcGF0aCwKPgo+IMKgIMKgIMKgIMKgZm9yICg7Oykgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY2hhciBidWZbMTAyNDBdOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3NpemVfdCB3cm90
ZTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNzaXplX3Qgd3JvdGUsIGhvbGV0bzsKPiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHNzaXplX3QgcmVhZGxlbiA9IHJlYWRfaXN0cmVhbShzdCwgYnVm
LCBzaXplb2YoYnVmKSk7Cj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghcmVhZGxlbikK
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOwo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZm9yIChob2xldG8gPSAwOyBob2xldG8gPCByZWFkbGVuOyBob2xldG8rKykK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChidWZbaG9sZXRvXSkKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOwo+ICsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJlYWRsZW4gPT0gaG9sZXRvKSB7Cj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBrZXB0ICs9IGhvbGV0bzsKPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fQo+Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoa2VwdCAmJiBsc2VlayhmZCwga2VwdCwg
U0VFS19DVVIpID09IChvZmZfdCkgLTEpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBnb3RvIGNsb3NlX2FuZF9leGl0Owo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWxzZQo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAga2VwdCA9IDA7Cj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB3cm90ZSA9IHdyaXRlX2luX2Z1bGwoZmQsIGJ1ZiwgcmVhZGxlbik7Cj4K
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh3cm90ZSAhPSByZWFkbGVuKQo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBjbG9zZV9hbmRfZXhpdDsKPiDCoCDCoCDC
oCDCoH0KPiArIMKgIMKgIMKgIGlmIChrZXB0ICYmCj4gKyDCoCDCoCDCoCDCoCDCoCAoKCDCoGxz
ZWVrKGZkLCBrZXB0IC0gMSwgU0VFS19DVVIpID09IChvZmZfdCkgLTEpClRoZXJlIGlzIGFuIGV4
dHJhIHdoaXRlc3BhY2UgYWZ0ZXIgKCgKCj4gKyDCoCDCoCDCoCDCoCDCoCDCoHx8IHdyaXRlKGZk
LCAiIiwgMSkgIT0gMSkpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGNsb3NlX2FuZF9l
eGl0Owo+IMKgIMKgIMKgIMKgKmZzdGF0X2RvbmUgPSBmc3RhdF9vdXRwdXQoZmQsIHN0YXRlLCBz
dGF0YnVmKTsKPgo+IMKgY2xvc2VfYW5kX2V4aXQ6Cj4gLS0KPiAxLjcuNS4xLjM2NS5nMzJiNjUK
Pgo+IC0tCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVu
c3Vic2NyaWJlIGdpdCIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZn
ZXIua2VybmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgwqBodHRwOi8vdmdlci5rZXJu
ZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwKPgo=
