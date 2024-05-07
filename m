Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428013D25E
	for <git@vger.kernel.org>; Tue,  7 May 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071488; cv=none; b=cxPEOm2KmVLY8MbeCyIuN/ErivWNOFA9cNhAvdFeCE1jqb59J1O33PoHl5dChE+a2P/8mJR/At6WScI8xdxR5aqZrNwm1PJyiziyM0YkBbueY4kEMLixW+kf1uqsZZAOnlE894H1W5gg3XaReJLZ1X9j9njnriXgULu/Baz5pvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071488; c=relaxed/simple;
	bh=nCzMD1/QtyXZBJPnhhNJ5l+BssEMN45uIZ5QWDay2tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OluHwH8b8t8OE1vqHB/xx7CZE82DcT4j0Fwjgu2373QQEfEjm57xUJaUlAujLWXqc6OubdgLIAj12ioUdNiifWPVL1Y6dCfE4CRx1cgs4MRdYpp7R8cW8D3gmevdMdqpoJKUw/0MaoNdTzWArNvCP23EMH7ORM0CLUKDfCEXY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=uJ6dD5xB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="uJ6dD5xB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715071473; x=1715676273; i=tboegi@web.de;
	bh=/x4SaoShVhUkops8Iy0EOj+rrg6FX5SWz+/FI18qFjw=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uJ6dD5xBqeX+fFPhe2QT/wx1ZwzW/y7Aj7e1LhAk0HaNngpBxsLWM0S9r8rxg+YK
	 /bE5ZoQJ4Tuq5KEGCSlFzPjj238JbD2aPKhG9vNYosVun4SGqWKkEcBB0jr7DiMzN
	 RbXbE+CZ6tMsml0K1290Ptd8dgyMZ8IDQQRU83XPIoO9Qed19I6Nx8G/wBZAJGVeM
	 PPChTNyjZKnhxIoele8kC2EKH58nYxdkI44RA1AagE3244/FLDRWfvFzveZCVLwG4
	 IElQE+5nWgS5TfYX5nKRxtkD8bxL5YTML6LTezT4fh6lkNkeQKyrZB+V7pYWlXBE0
	 N3jZR8kzfSYPOrte5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([213.65.201.17]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M2ggX-1s3R5q12T9-0049cE; Tue, 07 May 2024 10:44:33 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	takimoto-j@kba.biglobe.ne.jp
Subject: [PATCH v1 2/2] strbuf_getcwd() needs precompse_strbuf_if_needed()
Date: Tue,  7 May 2024 10:44:31 +0200
Message-ID: <20240507084431.19797-1-tboegi@web.de>
X-Mailer: git-send-email 2.41.0.394.ge43f4fd0bd
In-Reply-To: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ork5MKKgth8etOHq5QDlAT33nuDhqXOy8L2gtNQxNbJOfTeAGM
 /qepePDlZpepxddcN2/RCg8MKTGBUHfNtL6ZhYetUyNQSs6CyQDttBWUSANkXvLogL+eh6v
 9eoQn4uNUF48HdgIa15x2BDphzc1r6wrjk5O+vfAqi3T/lv2UM5Z1wCUmDF8JpLUvUQnQBX
 koxQgcg+gMwzFCQ33wLlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JLy2UctUzXI=;/nWkt7T4N8buZ9D+0JA+OQRTbjI
 X7Gb4hWoRuAusvNw2Cr0k4J0JvLfOxSVKFJK3G68PUMrq6If8HdYWlbOo2qw7khpbojc4dgxf
 QdHri/LjDGOFR/ci8mlu7EcokMAG/Ye+AYBKO4TTMwR8qoN2iVG+PH8NdP6deLLJt1iCVPP6L
 5Dh9pSIQgybch+N1Q7UASPzJm4ULjBA8+X08u/h4hVMeulRec2ksk7UqSX09g4vuojqc5juBf
 qj8ncU6D+u1FEuxc5prhSSEqDXx/yAtk4WV3Q189nIbr1zKfApGTeWT3B/FbmsXGDYXII1gq1
 J1Cl+osqzLQ9aSSkd2oUhGQvG/KesTGWoiNUCpbVSkfRK5YDO1wlcBJJPOwLGP7E8ogsADRg/
 /21K0WyS2uA/+Wx8387qpG6FEdOqLYdxwQrw4Ke+AVJs7TrbHb/CjC2CpbseGgonvAMHyOji+
 ZBzeokqBGUxEh63zyZER8BAqYYGQQDPD1bmExA9L069AcwEIRji/Caaop4oUodkbbbPZRx9Xz
 eqEWIYjUL5inUs8BYC/zjvnme1Czn/0dEf11klfefxF/CnRzW8qcHJVrtLgaPBwk1EubOtbuy
 tDeIQzBdW8QKKKnNZyCR8po9WFDToeY/cpBFtsVMu1zhPiPUgh0dLDOtTPbB43BAS47WpiqiR
 OLJnt52YZBLQhB40fCghFmA77ou5hVtwEYBsa9/vEWZeZAHuG4RrJ6ijJR9Z0Cj3IsFPN1y+P
 jnrOBXBv1lsDH5xIhJb5Jl04RgHCiZAKjM2FT/AwG0BQoihE/uP2k/icS+UfqtWmfQkLtAeFh
 hafVMjvGHneojs4O3Ydm/MEH2OSu+l33wISQ2LJRqoDqE=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

When running under macOs a call to strbuf_getcwd() may return
decomposed unicode.
This could make `git ls-files` fail, see previous commit of t0050

The solution is to precompose the result of getcwd() if needed.
One possible implementation would be to re-define getcwd() similar
to opendir(), readdir() and closedir().
Since there is already a strbuf wrapper around getcwd(), and only this
wrapper is used inside the whole codebase, equip strbuf_getcwd() with
a call to the newly created function precompse_strbuf_if_needed().
Note that precompse_strbuf_if_needed() is a function under macOs,
and is a "nop" on all other systems.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 compat/precompose_utf8.c | 11 +++++++++++
 compat/precompose_utf8.h |  1 +
 git-compat-util.h        |  2 ++
 strbuf.c                 |  1 +
 4 files changed, 15 insertions(+)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 0bd5c24250..82ec2a1c5b 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -94,6 +94,17 @@ const char *precompose_string_if_needed(const char *in)
 	return in;
 }

+void precompse_strbuf_if_needed(struct strbuf *sb)
+{
+	char *buf_prec =3D (char *)precompose_string_if_needed(sb->buf);
+	if (buf_prec !=3D sb->buf) {
+		size_t buf_prec_len =3D strlen(buf_prec);
+		free(strbuf_detach(sb, NULL));
+		strbuf_attach(sb, buf_prec, buf_prec_len, buf_prec_len + 1);
+	}
+
+}
+
 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix)
 {
 	int i =3D 0;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index fea06cf28a..fb17b1bd4a 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -30,6 +30,7 @@ typedef struct {

 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
 const char *precompose_string_if_needed(const char *in);
+void precompse_strbuf_if_needed(struct strbuf *sb);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index ca7678a379..80ae463410 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -344,6 +344,8 @@ static inline const char *precompose_string_if_needed(=
const char *in)
 	return in;
 }

+#define precompse_strbuf_if_needed(a)
+
 #define probe_utf8_pathname_composition()
 #endif

diff --git a/strbuf.c b/strbuf.c
index 0d929e4e19..cefea6b75f 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -591,6 +591,7 @@ int strbuf_getcwd(struct strbuf *sb)
 	for (;; guessed_len *=3D 2) {
 		strbuf_grow(sb, guessed_len);
 		if (getcwd(sb->buf, sb->alloc)) {
+			precompse_strbuf_if_needed(sb);
 			strbuf_setlen(sb, strlen(sb->buf));
 			return 0;
 		}
=2D-
2.41.0.394.ge43f4fd0bd

