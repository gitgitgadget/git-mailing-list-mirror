Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6C4A01
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065836; cv=none; b=dkD513+mEf6IQI/B8+rOiM4sn1GlIIdboBe0RDYlHRFthwCZwaQjeM0DXgaZuPqSeKZd9NEoc8C/osWvzs3H7D+2IN9ImqVpTaUJOKU2zgjX1NKnE572gWYEpXz5ycQqUDBvgbn2bKyPFzRFYn3/nmotUXz2ppbfFjVJ+qVncFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065836; c=relaxed/simple;
	bh=r5RmSXB4E4WuYB2TksLftHHptaTjj+jLMtBMP+nYhGU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EToV4SnQWor+ZDSspcJXYIfw/ffPDeIfKrPRHYU8dSA9ou87LAJV9WRK6lyMgwe8v/UWdk7An51CACTktPMnzLPfOfLnB5waSlgO4fDk3nTwjen2rLD7QdJsLwD3hQ9CCOX1r2BC3E8cnAPlMXdNFl8SiOER6tt6QEvhY/AqoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=SHw8msHk; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="SHw8msHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065825; x=1711325025;
	bh=r5RmSXB4E4WuYB2TksLftHHptaTjj+jLMtBMP+nYhGU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SHw8msHkDk1p+oIBAu9mOEbBy6bmg16Nj/3VMziO5u7SHRTeMvobDOJs/tvBpdksc
	 s9ejE8GZ33IKxUGq6HKIzfGLNE8S/ib4HNOcitC751HuAHJ9rdx98PsOHMLfKTIIjV
	 ddEulzXI0pjSarK8NxejsFf2my8n0JsaxhW0N+dpFS8lkIK+w5KHjsqbGxfWqL22uU
	 EYY8XvHHkHkEZBCBjCoRusPzr4CkkAroSA5gM05GNax8/sLWsear+M2BygAjPcj8Y7
	 MEIMRzhu/KuN1Jb7rvgIrZL8l1fI5QeMK8wVybaEx076JfO1XYMMWtAIsXLPY15e+3
	 tT/ThtYEENDcw==
Date: Fri, 22 Mar 2024 00:03:40 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH 4/6] fast-import: remove dead strbuf
Message-ID: <20240322000304.76810-5-thalia@archibald.dev>
In-Reply-To: <20240322000304.76810-1-thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The strbuf in `note_change_n` has been unused since the function was
created in a8dd2e7d2b (fast-import: Add support for importing commit
notes, 2009-10-09) and looks to be a fossil from adapting
`note_change_m`. Remove it.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d6f998f363..ae8494d0ac 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2458,7 +2458,6 @@ static void file_change_cr(const char *p, struct bran=
ch *b, int rename)
=20
 static void note_change_n(const char *p, struct branch *b, unsigned char *=
old_fanout)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
 =09struct object_entry *oe;
 =09struct branch *s;
 =09struct object_id oid, commit_oid;
@@ -2523,10 +2522,6 @@ static void note_change_n(const char *p, struct bran=
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


