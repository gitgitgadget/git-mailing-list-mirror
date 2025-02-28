Received: from evolvis.org (evolvis.org [217.144.135.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF01EEE0
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.135.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720893; cv=none; b=GrJvBvnOiL1/CWeBAgrskLx+gTvQUQdaSe7IaLhttzmgZZ7rhKrlxCs2vDJ0XQmBoOAIesFXcydh/cRPEM6F1KoW206CXdIQ6v+aPdveKlxKjwbGm6mhsO00saAhi09b1B3f9xAn3Sp5jzPloIkvq0x5UeAxG4h7Qc5vQngGajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720893; c=relaxed/simple;
	bh=WNLP3tWKk7OKmSSLifP4HN/2GNE50Ch6khOyMOYbUUM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=PCVSwZUwEDm2wvKXtphL3t5K3jnyg7SoyPmkxhxfgbNFupiunIWvs/dfyDkoF0ceql+cULTkvPQhLMIv8ulcoE3+qiaQKhZKdpEZJwTJx+OzkJwh9ToJkLs0SSrTB1A3LULR4fijrPkM1zyVI4Ep5HlZL1N98GSyu6hdWtP23jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.144.135.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from x61p.mirbsd.org (xdsl-212-8-144-17.nc.de [212.8.144.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	(Authenticated sender: x61p@relay.evolvis.org)
	by evolvis.org (Postfix) with ESMTPSA id C5731100061
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 05:34:43 +0000 (UTC)
Received: by x61p.mirbsd.org (Postfix, from userid 1000)
	id 43099147132; Fri, 28 Feb 2025 06:34:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by x61p.mirbsd.org (Postfix) with ESMTP id 3CB81147131
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:34:43 +0100 (CET)
Date: Fri, 28 Feb 2025 06:34:43 +0100 (CET)
From: Thorsten Glaser <tg@debian.org>
To: git@vger.kernel.org
Subject: gitweb.js build mistake
Message-ID: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1876430812-1740720883=:4590"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1876430812-1740720883=:4590
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

the new gitweb.js build (moved into a shell script) now
appends said shell script to the end of the gitweb.js
that=E2=80=99s actually installed, causing js syntax errors and
no small amount of confusion.

This is because (rightfully) the output got a new dependency=E2=80=A6
> $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
=E2=80=A6 but the rule uses $^ to append sources.

Possible fix attached.

bye,
//mirabilos
--=20
<ch> you introduced a merge commit        =E2=94=82<mika> % g rebase -i HEA=
D^^
<mika> sorry, no idea and rebasing just fscked =E2=94=82<mika> Segmentation
<ch> should have cloned into a clean repo      =E2=94=82  fault (core dumpe=
d)
<ch> if I rebase that now, it's really ugh     =E2=94=82<mika:#grml> wuahhh=
hhh
--8323328-1876430812-1740720883=:4590
Content-Type: text/x-diff; name=0001-Unbreak-content-of-gitweb.js.patch
Content-Transfer-Encoding: BASE64
Content-ID: <6126369f-fd2d-81fb-c50c-ef8ef8f4fae2@evolvis.org>
Content-Description: 
Content-Disposition: attachment; filename=0001-Unbreak-content-of-gitweb.js.patch

RnJvbSBlZDk4NjM5NzFkMzdlZDUzNjI4YTU4NzFhNGE1NjljY2Q2Mjg3ZjUz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogbWlyYWJpbG9zIDx0
Z0BkZWJpYW4ub3JnPg0KRGF0ZTogRnJpLCAyOCBGZWIgMjAyNSAwNTozMzox
MCArMDAwMA0KU3ViamVjdDogW1BBVENIXSBVbmJyZWFrIGNvbnRlbnQgb2Yg
Z2l0d2ViLmpzDQoNClRoZSBmb3JtZXIgJF4gYWRkcyBhbGwgcHJlcmVxdWlz
aXRlcywgaW5jbHVkaW5nIHRoZQ0KKHByb3BlcikgbmV3IGRlcGVuZGVuY3kg
b24gdGhlIGdlbmVyYXRvciBzY3JpcHQuDQoNClNpZ25lZC1vZmYtYnk6IG1p
cmFiaWxvcyA8dGdAZGViaWFuLm9yZz4NCi0tLQ0KIGdpdHdlYi9NYWtlZmls
ZSB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2dpdHdlYi9NYWtlZmlsZSBi
L2dpdHdlYi9NYWtlZmlsZQ0KaW5kZXggZDU3NDhlOTM1OS4uMmE4Zjk3Y2Vm
OCAxMDA2NDQNCi0tLSBhL2dpdHdlYi9NYWtlZmlsZQ0KKysrIGIvZ2l0d2Vi
L01ha2VmaWxlDQpAQCAtMTE4LDcgKzExOCw3IEBAICQoTUFLX0RJUl9HSVRX
RUIpZ2l0d2ViLmNnaTogJChNQUtfRElSX0dJVFdFQilnaXR3ZWIucGVybA0K
ICQoTUFLX0RJUl9HSVRXRUIpc3RhdGljL2dpdHdlYi5qczogJChNQUtfRElS
X0dJVFdFQilnZW5lcmF0ZS1naXR3ZWItanMuc2gNCiAkKE1BS19ESVJfR0lU
V0VCKXN0YXRpYy9naXR3ZWIuanM6ICQoYWRkcHJlZml4ICQoTUFLX0RJUl9H
SVRXRUIpLCQoR0lUV0VCX0pTTElCX0ZJTEVTKSkNCiAJJChRVUlFVF9HRU4p
JChSTSkgJEAgJEArICYmIFwNCi0JJChNQUtfRElSX0dJVFdFQilnZW5lcmF0
ZS1naXR3ZWItanMuc2ggJEArICReICYmIFwNCisJJChNQUtfRElSX0dJVFdF
QilnZW5lcmF0ZS1naXR3ZWItanMuc2ggJEArICQoYWRkcHJlZml4ICQoTUFL
X0RJUl9HSVRXRUIpLCQoR0lUV0VCX0pTTElCX0ZJTEVTKSkgJiYgXA0KIAlt
diAkQCsgJEANCiANCiAjIyMgSW5zdGFsbGF0aW9uIHJ1bGVzDQotLSANCjIu
MzAuMg0KDQo=

--8323328-1876430812-1740720883=:4590--
