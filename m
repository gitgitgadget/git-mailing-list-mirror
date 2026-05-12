Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788B3A4507
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586978; cv=none; b=ns6UV47D7wyC9c5daqGYdoO5mul9Q9yV+qi8A4BAyBw0pcnf2+TcFvlUKnboCm6ns+qiJiVdY2lgKclc95eX9Ah+zHznuV6/D2UcXfHIW68iQx/0/yDQEnPmMEsd9BH3hm1phdqGdwriK4euBwUN3cc9ZiSDkz8t4CxYbs4dxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586978; c=relaxed/simple;
	bh=Uiyhinjs7SWxCAqimlHFr5IpAeErtK8OxggTGZMl9uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVGhLiizNA/n471GqTItMBHxjHj7xNTnB0JA7lQ4GDWE90fQcXTc4qAHqjlV6k4K0O6OFZzAttrnag+NCdCmmvtJwVof4Bl7WLOr9UQ1s45fEnejUGRJOi3BrgSknUQTHQU7DDcGW2fwUlzeC30hjoVqBZFs90DLltuSS8Fbh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=IcPi6IJG; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="IcPi6IJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778586969; x=1779191769; i=l.s.r@web.de;
	bh=cXnx/Gvnytlre0iaW++M3P46UgOY/pbDNA9vO4j3snA=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IcPi6IJGFsbzsPm0J304+k24lEJ+kYik5HLtolchl9w4dDwT89etoATD8Yu7TOSf
	 DPvh+wyIbIYJ2s7bStdegfm2x+7P9Lst+DEE9uvLCyILGYhvekT+tLuNEr+7R4WtW
	 cm/F+HcxGlKbYuWtlkpLAu2E7pXQqIzg/G7Ze9YL8wj8fEzXuNOmeS+H0gy5EmPdV
	 hXjxF20hsCMFXJekG1LE3K3uG9w2rhUwTZ5HZzw1Z4DTx33MpF4PilGWGqEO0S1hO
	 cLxeobDqLd+hixvTDCoZPdX9fLE6auJ25+14TWq4fOT7hDKkZ7Of8wimsh+oDbFvz
	 cPHKpikXqqC606eKAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVet-1wZi1I02D3-00DoLs for
 <git@vger.kernel.org>; Tue, 12 May 2026 13:56:09 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 4/4] ls-tree: use strbuf_add_uint()
Date: Tue, 12 May 2026 13:56:03 +0200
Message-ID: <20260512115603.80780-5-l.s.r@web.de>
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
X-Provags-ID: V03:K1:jeH0Pxu0x63QgGQiC8xzE3x560Lipy6WZ+5pjVv3biXdMA5lAbK
 8feRg1wI0xNvfPJPP3iA6meO7eOiVaFdruPEunNAyeAHX3fYHNiIJLMnoPpsbD0xZ8oY/75
 FYi0Kgm544sk1PlkZWy7/KllGK9Q63eyH+R8zMpDWKWrZt+EPuRwam7wRNbGsA24c9TQKLM
 cn2b4DeUHYkBmyaXnQ5jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HCfZCZU5Po8=;Ko30CWdSoKNtmqekiUCdN7rHFN9
 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
 QBg4WcTBd4XKEHkbnmoKUrWg==

Speed up printing of objectsize values by using the specialized function
strbuf_add_uint() as well as strbuf_insert() for padding instead of the
general-purpose function strbuf_addf().  Here are the numbers I get when
listing objects in the Linux kernel repo:

Benchmark 1: ./git_main -C ../linux ls-tree -r --format=3D'%(objectsize)' =
HEAD
  Time (mean =C2=B1 =CF=83):     294.4 ms =C2=B1   0.4 ms    [User: 231.5 =
ms, System: 59.4 ms]
  Range (min =E2=80=A6 max):   293.9 ms =E2=80=A6 295.0 ms    10 runs

Benchmark 2: ./git -C ../linux ls-tree -r --format=3D'%(objectsize)' HEAD
  Time (mean =C2=B1 =CF=83):     291.2 ms =C2=B1   0.4 ms    [User: 227.9 =
ms, System: 62.1 ms]
  Range (min =E2=80=A6 max):   290.6 ms =E2=80=A6 292.0 ms    10 runs

Benchmark 3: ./git_main -C ../linux ls-tree -r --format=3D'%(objectsize:pa=
dded)' HEAD
  Time (mean =C2=B1 =CF=83):     295.3 ms =C2=B1   0.6 ms    [User: 232.0 =
ms, System: 59.6 ms]
  Range (min =E2=80=A6 max):   294.3 ms =E2=80=A6 296.3 ms    10 runs

Benchmark 4: ./git -C ../linux ls-tree -r --format=3D'%(objectsize:padded)=
' HEAD
  Time (mean =C2=B1 =CF=83):     291.9 ms =C2=B1   0.4 ms    [User: 228.5 =
ms, System: 61.5 ms]
  Range (min =E2=80=A6 max):   291.2 ms =E2=80=A6 292.3 ms    10 runs

Summary
  ./git -C ../linux ls-tree -r --format=3D'%(objectsize)' HEAD ran
    1.00 =C2=B1 0.00 times faster than ./git -C ../linux ls-tree -r --form=
at=3D'%(objectsize:padded)' HEAD
    1.01 =C2=B1 0.00 times faster than ./git_main -C ../linux ls-tree -r -=
-format=3D'%(objectsize)' HEAD
    1.01 =C2=B1 0.00 times faster than ./git_main -C ../linux ls-tree -r -=
-format=3D'%(objectsize:padded)' HEAD

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-tree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 113e4a960d..57846911ce 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -26,20 +26,23 @@ static const char * const ls_tree_usage[] =3D {
 static void expand_objectsize(struct strbuf *line, const struct object_id=
 *oid,
 			      const enum object_type type, unsigned int padded)
 {
+	static const char padding[] =3D "       ";
+	size_t min_len =3D padded ? strlen(padding) : 0;
+	size_t orig_len =3D line->len;
+	size_t len;
+
 	if (type =3D=3D OBJ_BLOB) {
 		unsigned long size;
 		if (odb_read_object_info(the_repository->objects, oid, &size) < 0)
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
 struct ls_tree_options {
=2D-=20
2.54.0

