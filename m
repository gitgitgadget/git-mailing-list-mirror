Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7747DF8B
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350893; cv=none; b=u3GjnQEEG1T7WwOUBHOzOBhISwWgCw2sS37bPnZ/ouNe9vlqJff2JLWAzrBJT4DTHt0cNCuwmni+eYOrKOnbJXXw0P2SyWSMoPxvYboPPdAe0PEppb/DcBbn3ddhSSoIABNoEUp65kdpgrdbwiF5plt8l+g+gAd8FcFUK/d3vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350893; c=relaxed/simple;
	bh=USM2TIpgxfccRbQx8O39Pm4Qzg9CIrQsj8z9QnM7SFo=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=hFnoUtpUZUqgQkcTGr8BGrUaSZqniVFb9M00esw5hdq/WS4rF5VaPfDSTIWK19fxVxTw+t0hNAnoHFFfMxOt/wOSvYR0T3CQaV3n1JrMi+ik7R9hrjkO/mjSCAOaiwxn8avEn9m9NfTi4ek0VUKl9WgdPDH6ZrzgmY39v8o95Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=fail (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=PqJeY5gx reason="signature verification failed"; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="PqJeY5gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=FkZW1fqEQsbFSOCd8fnHB7I9J8prLM7tzNY9CvqMz7c=; b=PqJeY5gxRJ73F
	La+CUVWkPOk//wycoMSDpnQm/8TD4vs5ZiPLCkrlpKHvJm/zWxIqh1qT7kFbSqY3
	VfwId2CO1Kyn7KHNNA7le7NkKv8PGmZh+rhoKR2Me/TQVdh5+AS5ibELL2DJw+4m
	qqeNzndueZHWuCGi0p7ZEFG1/fWVug=
Received: from zkd18cjb$mail.ustc.edu.cn ( [137.132.219.134] ) by
 ajax-webmail-mailweb2024 (Coremail) ; Wed, 2 Sep 2026 20:07:36 +0800
 (GMT+08:00)
Date: Wed, 2 Sep 2026 20:07:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zkd18cjb@mail.ustc.edu.cn
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, toon@iotcl.com
Subject: [PATCH] history: do not dereference NULL when parent tree is
 missing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn ustccn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5438d465.ab31e.1a062047bd5.Coremail.zkd18cjb@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:3ZYKCgA3DreIEZhqS00JAA--.21906W
X-CM-SenderInfo: p2ngimxfmeqzxdloh3xvwfhvlgxou0/1tbiARESBGqXYwBfNwABsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

d3JpdGVfb25kaXNrX2luZGV4KCkgZGVyZWZlcmVuY2VzIHRoZSByZXR1cm4gdmFsdWUgb2YKcmVw
b19wYXJzZV90cmVlX2luZGlyZWN0KCkgdW5jb25kaXRpb25hbGx5LiAgSWYgdGhlIHBhcmVudCBj
b21taXQncwp0cmVlIG9iamVjdCBpcyBtaXNzaW5nIGZyb20gdGhlIG9iamVjdCBzdG9yZSAoY29y
cnVwdCByZXBvc2l0b3J5LApvYmplY3QgcmVtb3ZlZCBieSB0b29saW5nLCBvciBpbmNvbXBsZXRl
IHJlc3RvcmUpLCB0aGUgZnVuY3Rpb24KcmV0dXJucyBOVUxMIGFuZCAiZ2l0IGhpc3Rvcnkgc3Bs
aXQiIGNyYXNoZXMgd2l0aCBhIFNJR1NFR1YKKHJlbGVhc2UgYnVpbGQ7IFVCU2FuIHJlcG9ydHMg
YSBudWxsLXBvaW50ZXIgbWVtYmVyIGFjY2VzcyBhdApidWlsdGluL2hpc3RvcnkuYzo3ODkpLgoK
R3VhcmQgdGhlIHBhcnNlIHJlc3VsdCBhbmQgZXJyb3Igb3V0IGdyYWNlZnVsbHksIGZvbGxvd2lu
ZyB0aGUKY29kZWJhc2UgY29udmVudGlvbiBmb3Igb2JqZWN0cyB0aGF0IGNhbm5vdCBiZSBsb2Fk
ZWQuCgpTaWduZWQtb2ZmLWJ5OiBKaW5iYW8gQ2hlbiA8emtkMThjamJAbWFpbC51c3RjLmVkdS5j
bj4KLS0tCkhpLAoKKFRoaXMgd2FzIHJlcG9ydGVkIHZpYSB0aGUgR2l0IHNlY3VyaXR5IGNvbnRh
Y3QsIHdoaWNoIHN1Z2dlc3RlZCBwb3N0aW5nCmhlcmUuICBUaGUgc2VjdXJpdHkgdGVhbSBhc2tl
ZCBtZSB0byBwb3N0IHRoZSBmaXggb24gdGhpcyBsaXN0LCBhcyB0aGUKY3Jhc2ggcmVxdWlyZXMg
YSBtaXNzaW5nIG9iamVjdCBpbiBhIGxvY2FsIHJlcG9zaXRvcnkgYW5kIGlzIG5vdApjb25zaWRl
cmVkIGEgc2VjdXJpdHkgaXNzdWUuKQoKImdpdCBoaXN0b3J5IHNwbGl0IiBjcmFzaGVzIHdpdGgg
YSBTSUdTRUdWIHdoZW4gdGhlIGNvbW1pdCdzIHBhcmVudCB0cmVlCm9iamVjdCBpcyBtaXNzaW5n
IGZyb20gdGhlIG9iamVjdCBzdG9yZSAoY29ycnVwdCByZXBvc2l0b3J5LCBvYmplY3QKcmVtb3Zl
ZCBieSB0b29saW5nLCBpbmNvbXBsZXRlIGJhY2t1cC9taXJyb3IgcmVzdG9yZSk6IHdyaXRlX29u
ZGlza19pbmRleCgpCmRlcmVmZXJlbmNlcyB0aGUgTlVMTCByZXR1cm4gdmFsdWUgb2YgcmVwb19w
YXJzZV90cmVlX2luZGlyZWN0KCkuClRoZSBmaXggYmVsb3cgZ3VhcmRzIHRoZSBwYXJzZSByZXN1
bHQsIG1hdGNoaW5nIHRoZSBjb2RlYmFzZSBjb252ZW50aW9uCmZvciBvYmplY3RzIHRoYXQgY2Fu
bm90IGJlIGxvYWRlZCAoImlmICghdHJlZSkgcmV0dXJuIGVycm9yKC4uLikiKS4KClJlcHJvZHVj
dGlvbiAodmVyaWZpZWQgb24gbWFzdGVyIEAgZjc4Y2UyZjdiNiwgeDg2LTY0IExpbnV4KToKCiAg
ICBnaXQgaW5pdCByICYmIGNkIHIKICAgIGdpdCBjb25maWcgdXNlci5lbWFpbCB0QHQgJiYgZ2l0
IGNvbmZpZyB1c2VyLm5hbWUgdAogICAgZWNobyBhID4gZiAmJiBnaXQgYWRkIGYgJiYgZ2l0IGNv
bW1pdCAtcW0gb25lCiAgICBlY2hvIGIgPiBmICYmIGdpdCBjb21taXQgLXFhbSB0d28KICAgIHRy
ZWU9JChnaXQgcmV2LXBhcnNlICdIRUFEXl57dHJlZX0nKQogICAgcm0gLmdpdC9vYmplY3RzLyQo
ZWNobyAiJHRyZWUiIHwgY3V0IC1jMS0yKS8kKGVjaG8gIiR0cmVlIiB8IGN1dCAtYzMtKQogICAg
R0lUX0VESVRPUj10cnVlIGdpdCBoaXN0b3J5IHNwbGl0IEhFQUQKCkJlZm9yZTogcmVsZWFzZSBi
dWlsZCBTSUdTRUdWIChleGl0IDEzOSwgY29yZSBkdW1wZWQpOyBVQlNhbiByZXBvcnRzCiJtZW1i
ZXIgYWNjZXNzIHdpdGhpbiBudWxsIHBvaW50ZXIgb2YgdHlwZSAnc3RydWN0IHRyZWUnIiBhdApi
dWlsdGluL2hpc3RvcnkuYzo3ODkuCkFmdGVyOiAiZXJyb3I6IHVuYWJsZSB0byBwYXJzZSB0cmVl
IDxvaWQ+IiwgZXhpdCAyNTUsIG5vIGNyYXNoLgpDb250cm9sICh0cmVlIG9iamVjdCBwcmVzZW50
KSBpcyB1bmNoYW5nZWQuCgogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2J1aWx0aW4vaGlzdG9yeS5jIGIvYnVpbHRpbi9oaXN0b3J5LmMKaW5kZXggMDAwMTU1
YWQ5Yy4uMDk3NjMxZjViYSAxMDA2NDQKLS0tIGEvYnVpbHRpbi9oaXN0b3J5LmMKKysrIGIvYnVp
bHRpbi9oaXN0b3J5LmMKQEAgLTc4Niw2ICs3ODYsMTAgQEAgc3RhdGljIGludCB3cml0ZV9vbmRp
c2tfaW5kZXgoc3RydWN0IHJlcG9zaXRvcnkgKnJlcG8sCiAJb3B0cy5kc3RfaW5kZXggPSAmaW5k
ZXg7CiAKIAl0cmVlID0gcmVwb19wYXJzZV90cmVlX2luZGlyZWN0KHJlcG8sIG9pZCk7CisJaWYg
KCF0cmVlKSB7CisJCXJldCA9IGVycm9yKF8oInVuYWJsZSB0byBwYXJzZSB0cmVlICVzIiksIG9p
ZF90b19oZXgob2lkKSk7CisJCWdvdG8gb3V0OworCX0KIAlpbml0X3RyZWVfZGVzYygmdHJlZV9k
ZXNjLCAmdHJlZS0+b2JqZWN0Lm9pZCwgdHJlZS0+YnVmZmVyLCB0cmVlLT5zaXplKTsKIAogCWlm
ICh1bnBhY2tfdHJlZXMoMSwgJnRyZWVfZGVzYywgJm9wdHMpKSB7Ci0tIAoyLjUzLjAKCg==
