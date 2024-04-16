Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556E11181
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298571; cv=none; b=Ib8TXuGNzrM2uMe0KV0uC3+m7RfGPAtgjqs1WPFpridYr2f2rSxSyPgg0mXEwen4270YfZVNPKWqSd1YFXXY3ODKff9rcgwittK8NV56z3Q2qOKtxB2Kq6/hOMArN9TPPAnORiOCNokZqIs+rOLkCYfIt/O7VNV4UCkOrGArqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298571; c=relaxed/simple;
	bh=Ea+mKe1/PMaxPhesIfQ0YMpUFVFjpsRw9wgfAwwX5no=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j6VMtsF5qvLWcTrqhJz8vinwmcyAV9d29G6Sg+tOLOTGn9QX3dGt8vL0P78ll3R2EiZ1FPc2VNmb6ijpQVk+hG7Z7/PMxnQa10mGyFKg+fVXaiZtMBbaIpwzSbM1W9bTXTfqpQqQl6832WRNJvAvqKQrD8MuR4P6jAK/lsW2iHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Bv3NPlr0; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Bv3NPlr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713298565; x=1713903365; i=l.s.r@web.de;
	bh=emPktB7HUDschAnYiuBppY4fHm2o3O7wE6mauvRuzXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bv3NPlr04bB/9mb81XZSmGwehyBe22uZdKCJgCxffxvbUppPul3P84sEVWbvZSVa
	 hIfu++pfw/yfZ2gPS8GbfVtGqISUa5f2EibmZt6ZLtxP4kJ8dM6hYs4lyXulG4Cu2
	 x8eTOpFhSJ6PkfdX4ZdM7HjUxZTlovRhgaRixfx/Ho+I869tBOJX3JcqKziPzknNW
	 o69bTDO8AHkuApEeslxapbl6z97x2H8a+CbySMxYmq7E5Ehdlh7yvzPCrAHo1rrle
	 gorEAD+b5xn487AOmDa2gll9EXyw8iJbwsPa7FTSEA2MCWq7sLotGGJd9Iy07HML+
	 luwJP8j8uwsEX1/qXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1sWzOr1h4W-00hvMP for
 <git@vger.kernel.org>; Tue, 16 Apr 2024 22:16:05 +0200
Message-ID: <a93cd243-cb17-4ad5-8d23-30768dc5213b@web.de>
Date: Tue, 16 Apr 2024 22:16:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] apply: avoid using fixed-size buffer in
 write_out_one_reject()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7NicHvyV4H/YYOltOpZH7eg9+W3ZwWmptjHEVzN7QXCEzfe/7I0
 P9JSBkc5iZAEoqQCHqbsVVGmQxrj4tpgXOlXx2LFWbafzWuNpVIBYgC3NxuacGZt8OOn9Qj
 MF+LYUd9RhAx8qC1Fw/SjcpAbxjFVYUItNPl31UBz3t4ERVV0/Jhy1j3F3HgQVqOMgNgq93
 x+VOMeK7NtKoh94eDlSnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L0RWAGFdgWY=;xbufldzkbLhiC712G+68jWuYHpT
 99Y6thKwf2wzsWF9jSz9/aq1pd8jhTcbY5gG+yf9PT0o9I7E7xAabBdzYomPdBVgLsU+LoFwE
 YY6uvVZEtT6s+jBoBYzdyA7/LlOVbSKPEi+E5pBJaiKm6qkcKBEKUY9vjqWbmUm2ArSf6Y+Sl
 PElOXCsUXfrSvp4h4ov4h8It6Iu7kY70HCPORge03zG9zEaNMyS0cm6gqvRvWOvMSMsHZHoMa
 ViQibrU6phnIDikJkf8+/m1Mt3CAJhzUb+iCmyeKtVGPQ4RlN9GEWlTazH8Mg1ieCvIqhhQ2e
 6onal6SbsH6Q4coNocknBKtPwXiD3ppnNjYx6wI7iFk1zXyaTAtoUk6iCCaWQWBpurxUvU+iD
 GA1+t2ZJQxlGkX6ql9F9lET1Z+eaE4PJwMjSA1VOfn5VDsmxyBKZ87D5h0uAzJRoBBpIZi7U7
 /VUfxVc+wyH89DIOXlSlJfRMlIIKTZLHXWmKI0hdPt76SrUyvs0pxx/anWLui7Ccve6iss0S6
 rgI9WgK8HfwlxE+pEJqumBvixOY9XdaEap6CGtdDFqoe5Lz0BGIaHdsmuEf2L0nOM7KYFEFHA
 uULsCId4nN/unVGikyYnhQuuczVXio2prlKeksKchmrHvJZLauuQMJAmS4NzuEgmcooR3Y7jz
 qGx0ooMV8Sm/vH6VEJcY1XrNOjVXTAdrMEyZ7v04RssO437tkHT5iKFpHUmzEbRdnOtxIf/Zt
 12e+9sVBNUqw/zape4L8XJrI+7SCKUdZQ5sBOJfpmi6pwnrQ+r6I2ZujrCH7Ge1ILDdbillNV
 MecsTsGapt+T9PinLX2sw5dtUw/M7sGEKMwsPHTVFx4lY=

On some systems PATH_MAX is not a hard limit.  Support longer paths by
building them on the heap instead of using static buffers.

Take care to work around (arguably buggy) implementations of free(3)
that change errno by calling it only after using the errno value.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 apply.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/apply.c b/apply.c
index 34f20326a7..757009a39e 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -4612,7 +4612,7 @@ static int write_out_one_result(struct apply_state *=
state,
 static int write_out_one_reject(struct apply_state *state, struct patch *=
patch)
 {
 	FILE *rej;
-	char namebuf[PATH_MAX];
+	char *namebuf;
 	struct fragment *frag;
 	int fd, cnt =3D 0;
 	struct strbuf sb =3D STRBUF_INIT;
@@ -4645,30 +4645,29 @@ static int write_out_one_reject(struct apply_state=
 *state, struct patch *patch)
 		say_patch_name(stderr, sb.buf, patch);
 	strbuf_release(&sb);

-	cnt =3D strlen(patch->new_name);
-	if (ARRAY_SIZE(namebuf) <=3D cnt + 5) {
-		cnt =3D ARRAY_SIZE(namebuf) - 5;
-		warning(_("truncating .rej filename to %.*s.rej"),
-			cnt - 1, patch->new_name);
-	}
-	memcpy(namebuf, patch->new_name, cnt);
-	memcpy(namebuf + cnt, ".rej", 5);
+	namebuf =3D xstrfmt("%s.rej", patch->new_name);

 	fd =3D open(namebuf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0) {
-		if (errno !=3D EEXIST)
-			return error_errno(_("cannot open %s"), namebuf);
-		if (unlink(namebuf))
-			return error_errno(_("cannot unlink '%s'"), namebuf);
+		if (errno !=3D EEXIST) {
+			error_errno(_("cannot open %s"), namebuf);
+			goto error;
+		}
+		if (unlink(namebuf)) {
+			error_errno(_("cannot unlink '%s'"), namebuf);
+			goto error;
+		}
 		fd =3D open(namebuf, O_CREAT | O_EXCL | O_WRONLY, 0666);
-		if (fd < 0)
-			return error_errno(_("cannot open %s"), namebuf);
+		if (fd < 0) {
+			error_errno(_("cannot open %s"), namebuf);
+			goto error;
+		}
 	}
 	rej =3D fdopen(fd, "w");
 	if (!rej) {
 		error_errno(_("cannot open %s"), namebuf);
 		close(fd);
-		return -1;
+		goto error;
 	}

 	/* Normal git tools never deal with .rej, so do not pretend
@@ -4693,6 +4692,8 @@ static int write_out_one_reject(struct apply_state *=
state, struct patch *patch)
 			fputc('\n', rej);
 	}
 	fclose(rej);
+error:
+	free(namebuf);
 	return -1;
 }

=2D-
2.44.0
