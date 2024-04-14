Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20417740
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057132; cv=none; b=ceSKlGOcgjICraDndedquBtwTk273tZljOJxWRN36P2/Sx6zHTl2oGaMM9LGac7s17Swwa79wEskDq9MO+nmtFZx6pPdeMAN9L0NH8S/EzN3KQxPZEMPIToonZzxN0bxnIxkH1n9e/O+tIV9EEjc1UDdv4FJsQdeh6ZbQcApIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057132; c=relaxed/simple;
	bh=2bR2hri9uVWyQZ3NWwDfLPl3+d4sZ0dtP0Emxk/YzF8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiX/oxkVbcmW6Izcp23NgexMskEs4i1rjYYXbqfisSv23smL0oqilvYocH37yyva1cPjLILraDpBum0zCh3nUCNzoil1wjnyk80FnHD/7KO5eIpFHRvVzDo/eBkXIjZ0jI2Qg79hHwXfCajB62K7Rh9AW7VtBMJo5QTFPPSjBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=wapugXQf; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="wapugXQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057123; x=1713316323;
	bh=2bR2hri9uVWyQZ3NWwDfLPl3+d4sZ0dtP0Emxk/YzF8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wapugXQfa5z5ShU4T1G4vdI9phAm7mkYBz1z7OlYMX+o1Yl9cq2VxYd3vpCmWUPNd
	 RXD1q9R9MKaksO9Vz1D+XG1WacX0juxqkRDAXwFeub3XVbzX4U/ex8VsPUX8Ue7Wju
	 FaLgjt60PUASfkNjRNN3T8f6EnheYq+i5tLiv3vQ4R4e/RFRNcWOQ6XGCW22n8RQaq
	 1TgorLNS4tppoByY+zzZxPO4jFiuxDpgbLt7twkyqlJK6otFJGFDQWIXK9l9mrDHO1
	 ekC6fsuTOXkY6HfiNVHK9pY87qd7D4b9j9hx6Xqw2bT1dEL/eOecSckQltWayay/qB
	 NCWLPXN1tCU8Q==
Date: Sun, 14 Apr 2024 01:11:59 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 4/8] fast-import: remove dead strbuf
Message-ID: <96ff70895a272d3b2836058be8e189c9ff563908.1713056559.git.thalia@archibald.dev>
In-Reply-To: <cover.1713056559.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev> <cover.1713056559.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The strbuf in `note_change_n` is to copy the remainder of `p` before
potentially invalidating it when reading the next line. However, `p` is
not used after that point. It has been unused since the function was
created in a8dd2e7d2b (fast-import: Add support for importing commit
notes, 2009-10-09) and looks to be a fossil from adapting
`file_change_m`. Remove it.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index c8a1e3ef3d..832d0055f9 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2448,7 +2448,6 @@ static void file_change_cr(const char *p, struct bran=
ch *b, int rename)
=20
 static void note_change_n(const char *p, struct branch *b, unsigned char *=
old_fanout)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
 =09struct object_entry *oe;
 =09struct branch *s;
 =09struct object_id oid, commit_oid;
@@ -2513,10 +2512,6 @@ static void note_change_n(const char *p, struct bran=
ch *b, unsigned char *old_fa
 =09=09die("Invalid ref name or SHA1 expression: %s", p);
=20
 =09if (inline_data) {
-=09=09if (p !=3D uq.buf) {
-=09=09=09strbuf_addstr(&uq, p);
-=09=09=09p =3D uq.buf;
-=09=09}
 =09=09read_next_command();
 =09=09parse_and_store_blob(&last_blob, &oid, 0);
 =09} else if (oe) {
--=20
2.44.0


