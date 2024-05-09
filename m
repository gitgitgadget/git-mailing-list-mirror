Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5016F84D
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271092; cv=none; b=gJkwodTrrYMw+4V11889JxU1+6CyP5b5mcHIGYlCBQBQ8uMzLv1MaP2HC0M0R2Lw7EV8HyaMzYP27dvGsLsV+jErOTqJBidu0uMrlPzlmzDsWz1sHInk5UgRptGQ+4MnG2OMFy7ARBaEKXLaG8NDWAwiWWKASXutv3Z8Um+E1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271092; c=relaxed/simple;
	bh=pmEj5kfJAyFfh/0mz4uJFgSQtj4+N4m6+qLCD33tJEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR1fzxS8tCghP2G5oBw2m5hH9CDYbqI7iiEunTVF2fTUqjx1UkvRcNRF85pRUGvpi1zGms4CxchecRInhRv7GJ3ZA//0mmFVJ0DLCPV8ThLFj+bbnML76LInZ4G9LX8uNypJnqgCBwp8hdj/viX86lzqBxu3qlwuQ7c01vQv2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=qi7B5JEt; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="qi7B5JEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715271073; x=1715875873; i=tboegi@web.de;
	bh=DNyqcFeT8j0OAQEms2SszWep1KqpA2uCBcuJN8XVNMY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qi7B5JEtQQ9uXfalx9WogoyvXSeR6P+yIoD0KkLGGxfSOk32h1fJvGNvPD/u/+oo
	 S/yUdYAe8cZtlWxyWmMclb87E4CUq0e+mKZSBEN3fPeNSpZPHVFLvgoKiOyClXsMJ
	 jdtszke/UD4ylN5lqdSbc1HSYysRoxFAbwSLPfQ2K0Ly9PDkkZN02d70bgQ8sPol/
	 1VNQSYZGRpvqQ4VrFV58QGTt+nZnJTHPHei9uws4E8bydUO1xvqTvF81YbtnLjXfN
	 Vx51sy/FIQxB4sBpL8E4QNFBim3hODsDceJ5QgSvEsD/JWm3YTJN6y8CdGW6ITJ4z
	 sw6ybIIWBet9naXc8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([213.65.201.17]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N2BMA-1sk79r18r0-013Znt; Thu, 09 May 2024 18:11:13 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	takimoto-j@kba.biglobe.ne.jp
Subject: [PATCH v2 1/1] macOS: ls-files path fails if path of workdir is NFD
Date: Thu,  9 May 2024 18:11:10 +0200
Message-ID: <20240509161110.12121-1-tboegi@web.de>
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
X-Provags-ID: V03:K1:XHZabCIpUQpGLo+hIafJG/6x/NNPFVJj3Ti5gE6+ohqEUiXLvjR
 M/KrIb6Pcf/iRUx5yHPL+IjitTkkirYpdepYIPcWxFAUUamrNPIaI3jJ5qlsvqhaYzVG0IT
 j9QxobEJrWenG+2mXLpvP7QfuquzT5yhrycTNw+4qNXX4Hr1NICnPkwQWCbiRInA8C++Ju8
 P2hxuG1/lSG+zv0morubw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4GdLaJbCUaU=;qiCGacov3NG1uPdro4zjBBsl4LI
 ZHqi1WXPfQ/nl1oM1XtIZ0JphYIerhbvFCfov/+oZWWVEGGL+jIphHEi/S6Lc1xsR9tYNJYuC
 yMI+8jQbBJfRSS2AHoeU7uz1sAxZ+dhVlUkoTe1583ScNrzzrt8EDTJtUeNnc5P/N2hvWZCJb
 BiRzHB0b6tGR7YKHVerh5ZZQ9e0B674WY7bxO8IaBSjG6ogNBd9o0q1pV/KZsTsUfa/RsGLwj
 KHlwreHDm7IrFe1D37rFDVgYeav+r0jAxf48JoMP+ec63I4uLh9cFZoUbAbQsrVguGOKM/48y
 G0aHL1lOtYAhgJ0JxfjPytg6ZnFbjmYOI2zs47vPJezq2ZDztMKwJcz40s3VpXCPU4URV9fNC
 mVeXlx/2LSiAridE9q/enSHG/mnj/cEy0mIU8auH9TLCp68TUiro5f3ISdmnUsJTHypla0gMe
 lVYmxI+V50KRi8NbpGwdTj1WQR66rMJTf6hHBpt9Gmnc7hXEinZWG6fgo02TqTvci/Ba9QO+2
 XMaNU9DcEC/jXpQTdsGqpN1u9cC0tVQ/+wocQ+QORw6Z7RkF+BAXSnRmWyP1oHquDqB952Hxs
 FT2o5TPzidF7cayq2fhD5RDOteJO7BbCYvAy8ZMsdb/FbcyIPxR9CgiRgEvutNIx1G0DWhX3k
 ChMVbcBafh8NF/gY4EVu4QXgd2W26fFkfVMHjz5BBbzq2zVY+mjaAEYGB2u29UL0DWEMqprVE
 fiPsvLcXcP7l1jcMh6U7Fm0RahU9zoAFTXux6TeV8QGEBvaqlGO5mcMRP0Ucu6ydm6YqeEJkz
 ZJ43E60saLtMkbC/dy9eXbQ1f9HaHqvSeLFiVyl3X1sC0=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Under macOS, `git ls-files path` does not work (gives an error)
if the absolute 'path' contains characters in NFD (decomposed).
This happens when core.precomposeunicode is true, which is the
most common case. The bug report says:

$ cd somewhere          # some safe place, /tmp or ~/tmp etc.
$ mkdir $'u\xcc\x88'    # =C3=BC in NFD
$ cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
$ git init
$ git ls-files $'/somewhere/u\xcc\x88'   # NFD
  fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository at '=
/somewhere/=C3=BC'
$ git ls-files $'/somewhere/\xc3\xbc'    # NFC
(the same error as above)

In the 'fatal:' error message, there are three =C3=BC;
the 1st and 2nd are in NFC, the 3rd is in NFD.

This commit adds a test case that follows the bug report,
with the simplification that the '=C3=BC' is replaced by an '=C3=A4',
which is already used as NFD and NFC in t0050.

The solution is to precompose the result of getcwd(), if needed.

One possible implementation would be to re-define getcwd() similar
to opendir(), readdir() and closedir().
Since there is already a strbuf wrapper around getcwd(), and only this
wrapper is used inside the whole codebase, equip strbuf_getcwd() with
a call to the newly created function precompose_strbuf_if_needed().
Note that precompose_strbuf_if_needed() is a function under macOS,
and is a "no-op" on all other systems.

Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 compat/precompose_utf8.c | 10 ++++++++++
 compat/precompose_utf8.h |  1 +
 git-compat-util.h        |  1 +
 strbuf.c                 |  1 +
 t/t0050-filesystem.sh    | 11 +++++++++++
 5 files changed, 24 insertions(+)

Thanks everybody for the review, which makes V2 much better.


diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 0bd5c24250..5a7c90c90d 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -94,6 +94,16 @@ const char *precompose_string_if_needed(const char *in)
 	return in;
 }

+void precompose_strbuf_if_needed(struct strbuf *sb)
+{
+	char *buf_prec =3D (char *)precompose_string_if_needed(sb->buf);
+	if (buf_prec !=3D sb->buf) {
+		size_t buf_prec_len =3D strlen(buf_prec);
+		free(strbuf_detach(sb, NULL));
+		strbuf_attach(sb, buf_prec, buf_prec_len, buf_prec_len + 1);
+	}
+}
+
 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix)
 {
 	int i =3D 0;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index fea06cf28a..7c3cfcadb0 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -30,6 +30,7 @@ typedef struct {

 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
 const char *precompose_string_if_needed(const char *in);
+void precompose_strbuf_if_needed(struct strbuf *sb);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index ca7678a379..892e1f9067 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -344,6 +344,7 @@ static inline const char *precompose_string_if_needed(=
const char *in)
 	return in;
 }

+#define precompose_strbuf_if_needed(a)
 #define probe_utf8_pathname_composition()
 #endif

diff --git a/strbuf.c b/strbuf.c
index 0d929e4e19..d5b4b3903a 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -592,6 +592,7 @@ int strbuf_getcwd(struct strbuf *sb)
 		strbuf_grow(sb, guessed_len);
 		if (getcwd(sb->buf, sb->alloc)) {
 			strbuf_setlen(sb, strlen(sb->buf));
+			precompose_strbuf_if_needed(sb);
 			return 0;
 		}

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 325eb1c3cd..a24ec866d1 100755
=2D-- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -156,4 +156,15 @@ test_expect_success CASE_INSENSITIVE_FS 'checkout wit=
h no pathspec and a case in
 	)
 '

+test_expect_success 'git ls-files under NFD' '
+	(
+		mkdir -p somewhere/$aumlcdiar &&
+		mypwd=3D$PWD &&
+		cd somewhere/$aumlcdiar &&
+		git init &&
+		git --literal-pathspecs ls-files "$mypwd/somewhere/$aumlcdiar"  2>err &=
&
+		>expected &&
+		test_cmp expected err
+	)
+'
 test_done
=2D-
2.41.0.394.ge43f4fd0bd

