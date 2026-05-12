Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351D386C1E
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586978; cv=none; b=dASokVsDDy8mbcGpZJ+GxmCNwWMdS5EMXh2T8Cjb757oTlwJJHvzGaQbM0KK07bE9DTA24I+TFMg7dUK0ucMOpxxRy9qPmzFNlJPXl9qKp3xTVTvjYrhbs6ld1hyKfWmgVPDsn8BcSsirQXSKkKoxPqp9gFB/eUndElfq5RR8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586978; c=relaxed/simple;
	bh=XLYtEb98/T4yoDV3iEnD9OyPNy8nBotGeJDJfJmJwTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iijNRtJ2YHJwU4k5SVPgI/w0xdaOOPULOrqP+pPW44CKd+mbpFwADmGFb6I7ybdjNRqZyUKzp1JTXaMSCKiQehK40zbY4pTBtUpqNbWKL5h25JSX97b+my+U/z8jkuI4+BT5cF9IxyW5YLj9jaLOmo+kIwAJITSYDgZAQpbhBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=A1OrM5gS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="A1OrM5gS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778586969; x=1779191769; i=l.s.r@web.de;
	bh=1qCi51GjXw/JjlC49nLGYPIBNr+GbO1OHMudsrAXcXk=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A1OrM5gSnTPD4GChF6RnSxuYjv/8DCavxOTD14NVBysIR87MNAIo3m001iOCgKwk
	 jKr5AGXldyZINJFOgM3Tl9cmx8fm9o2NkVSIchBi3CYF46OHMK493RFI+YZixq359
	 4poop/O6LupXVsvplisU2B+5mYnUey4VzdT0g56g2jgeFek2uatt5/5eGNO3RtpWJ
	 2nTGYm7u74WuyCaJIWYrYishel3QgJjJbQthm5V5dZCruNudS8vAiTSPLZmYkkf3Q
	 Y1bFt3h/dhMcVR/OS7DOZ8yr6/XwHsly78FeDT6eomJSacQoG1pg+fbnZ/MLMuwsw
	 EhOnLLAZfzC44CW6wA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14pE-1xOGZe3g5a-012JPT for
 <git@vger.kernel.org>; Tue, 12 May 2026 13:56:08 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 3/4] ls-files: use strbuf_add_uint()
Date: Tue, 12 May 2026 13:56:02 +0200
Message-ID: <20260512115603.80780-4-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512115603.80780-1-l.s.r@web.de>
References: <20260512115603.80780-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LzKcFKmwKsFyZ0+SOvtwJrPhgGvyzoabqUAQOlPkX/bzCGzXN1u
 3cSLtmyHyLT9MwQEAQa8FL/e/JA2zOwNDuPeqfFvCZx8FJmh+Oa5NAdOLMnJM5yRlYSsMEo
 2dRhs6inDecOjAoTNFIJhAF9SvKJ+D88/8KlSNR2tQ4ETI32jAj30SR2w/2shGF0GCM5g3M
 OO7ecvNpbFu04bGmTZvCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EG/geoOS4r8=;fDgdwc6duSc+MJOs4FLjEP0oo91
 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

Speed up printing of objectsize values by using the specialized function
strbuf_add_uint() as well as strbuf_insert() for padding instead of the
general-purpose function strbuf_addf().  Here are the numbers I get when
listing files in the Linux kernel repo:

Benchmark 1: ./git_main -C ../linux ls-files --format=3D'%(objectsize)'
  Time (mean =C2=B1 =CF=83):     257.3 ms =C2=B1   0.4 ms    [User: 197.4 =
ms, System: 56.7 ms]
  Range (min =E2=80=A6 max):   256.7 ms =E2=80=A6 258.1 ms    11 runs

Benchmark 2: ./git -C ../linux ls-files --format=3D'%(objectsize)'
  Time (mean =C2=B1 =CF=83):     253.4 ms =C2=B1   0.3 ms    [User: 193.6 =
ms, System: 56.6 ms]
  Range (min =E2=80=A6 max):   253.0 ms =E2=80=A6 253.8 ms    11 runs

Benchmark 3: ./git_main -C ../linux ls-files --format=3D'%(objectsize:padd=
ed)'
  Time (mean =C2=B1 =CF=83):     257.9 ms =C2=B1   0.3 ms    [User: 198.0 =
ms, System: 56.6 ms]
  Range (min =E2=80=A6 max):   257.3 ms =E2=80=A6 258.5 ms    11 runs

Benchmark 4: ./git -C ../linux ls-files --format=3D'%(objectsize:padded)'
  Time (mean =C2=B1 =CF=83):     254.6 ms =C2=B1   1.0 ms    [User: 194.6 =
ms, System: 56.7 ms]
  Range (min =E2=80=A6 max):   253.7 ms =E2=80=A6 256.8 ms    11 runs

Summary
  ./git -C ../linux ls-files --format=3D'%(objectsize)' ran
    1.00 =C2=B1 0.00 times faster than ./git -C ../linux ls-files --format=
=3D'%(objectsize:padded)'
    1.02 =C2=B1 0.00 times faster than ./git_main -C ../linux ls-files --f=
ormat=3D'%(objectsize)'
    1.02 =C2=B1 0.00 times faster than ./git_main -C ../linux ls-files --f=
ormat=3D'%(objectsize:padded)'

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-files.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b148607f7a..c142ad4156 100644
=2D-- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -250,20 +250,23 @@ static void expand_objectsize(struct repository *rep=
o, struct strbuf *line,
 			      const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
+	static const char padding[] =3D "       ";
+	size_t min_len =3D padded ? strlen(padding) : 0;
+	size_t orig_len =3D line->len;
+	size_t len;
+
 	if (type =3D=3D OBJ_BLOB) {
 		unsigned long size;
 		if (odb_read_object_info(repo->objects, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
-		if (padded)
-			strbuf_addf(line, "%7"PRIuMAX, (uintmax_t)size);
-		else
-			strbuf_addf(line, "%"PRIuMAX, (uintmax_t)size);
-	} else if (padded) {
-		strbuf_addf(line, "%7s", "-");
+		strbuf_add_uint(line, size);
 	} else {
 		strbuf_addstr(line, "-");
 	}
+	len =3D line->len - orig_len;
+	if (len < min_len)
+		strbuf_insert(line, orig_len, padding, min_len - len);
 }
=20
 static void show_ce_fmt(struct repository *repo, const struct cache_entry=
 *ce,
=2D-=20
2.54.0

