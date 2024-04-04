Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26A12D1EF
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264934; cv=none; b=a/6KGIn6KZ6IynYznWq4urJ96tGTvR40S7OUW/AjW+jXwPIrGqK28dArKkD3rFalFe+McgPLKbhfQ9JC18QvRJZGU+NE22n4pdN48ruOBoSDREJw5l5Aw0HPm6yLEzdckqlQ5wTgM4COmYF04lIi02HZmAJ8d1qqw36F5zaDsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264934; c=relaxed/simple;
	bh=f6y/wHZ7QUWcC3sHEVj2CLWgPgzwlnhSHU5SQFgZX3M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ob0ds1cMvQM1AiKLuoVjH9NGJUajdF5rOpWPJGuDY9SjQDfiShHcqvZRXGuOIac6BU/ymI+4k30ZDTgCCzv5/awe2qAVYzYEQxKF+wM2MEatFOf2/LELWgqO3PwFoqYHbatgA5AndmxzTF1kr07FHdRiYzzscqpzMLT3lL+u0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=unnfditq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="unnfditq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712264919; x=1712869719; i=l.s.r@web.de;
	bh=yV08c47afHQnrl7Vr1UAbxldX3VwXL5CG5izx+ocBDQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=unnfditqEBaoMX75NstiFQIJ36cApfFE/g0xDKCtyK5HX4sZ7UzLxCx/sz9vBpsi
	 h1+1r4IDsIF/RvwdrGWswZIoeaTLs8BnN2C7P93UDgY8AHiAhwC8Uy4NnFXCIaK82
	 gp0beKbYC2QIbIyFgmFzSl2K2xCfL/Ls7O5yEmJSfI4cp4gIhankvCrEyJHRfcT25
	 B97jMyjbpnNojtlsD9FPWGvDYT42Cpz3vVYFk4V5lBXFzB23Bthgi4UcY/KsL312Z
	 ZzQA3L+BR44cyN12D/G5EbkZpl8a6+WwZAq8R3mVJwo4n3spYlSM7Z1du6n4FTTxi
	 gOSx2xuxl6Lu93ZuRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.148.48]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB49-1sN68M09cP-00Mfho; Thu, 04
 Apr 2024 23:08:39 +0200
Message-ID: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
Date: Thu, 4 Apr 2024 23:08:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] apply: replace mksnpath() with a mkpathdup() call
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aJjRgS0YBiRJu7s9FxOBjNFMST25sGI8vqqeDsR4jd0pDG+kzxQ
 WdV6KhPzVDf62YYZj0KX5py2+J5Fjk6ZWM7HTxFXadgd/0MPheBMjs2IYIqBNfQf95eBsJV
 M3e8tjQdWEBkqpZEpanRiQDXygipwoN/OxXlCw+lFIEd1JNvSGboqPf/oQJ6DnNuKv0+J3K
 W6fVAb1avWXeoHitaXuFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WOEUGln8NfY=;rB3h6EEaElsDCrzVS3bdWW3a3sX
 Vl41GvNL3Z8l3l4goS/Jh4TYtIadSBNn3zBDD4FIxKGKgJRT6BzsZ6sWOm5Mx61K3MJbGQOAq
 al4DNraq3kQj0NPJr2asOU73JzZoAAtXFlcxHwrhI9dfh7i3b5F1oXe0QQRheglEuhSJ3Z4Pz
 rH1IEUWS2MP+stVquzDBd6f4NIY7DMLua9G3K68Tj6X1TP/k8b1fcDFseNSWYbW+RxxUoPHA1
 4wun4GnVlbSOJmL21giEQrhPGs3cqFMSjK0J4mffSVRb4n2iCQfcq15g48MlPBxN2swcXgCs+
 1Eu/teiyY8SuJ5X7DdOu1ueiQDUkpH1NyZXY5aGkhz/d+9SJ9EXNcyO0UJI9ducFjGdWRyYNG
 MRdajcJ9osx6+2Bn7EAxmHdDxL52fYMphVqz7oh7j25aSfCqBNlEt3g8EOsWyjyM+l6BhdPuT
 wIe0fG5GW4yHyXeXl4XPAmrV+dPfreQZVMoeBmjKhSYmK5PeVPOcavgI41M7poXzH54vSgEMz
 XJZJOxMtApjEIj6leGSIme6+/HrLXPF9aQDqUB7bglZrCnMNBiBKtjtzI3N7+h7qhsqzHD9zU
 tYkQ8c7t88AMFpWrhfkq6ckVrrYkOHmm2moOcThUM52Una3dsgW3UVauOq769kUzlvQyvMIHN
 1KIW2IxhKRbcuhL+gPHpObhZodGT2UPL03RFuUC8MY10FPoy3bgAnC6D26ENODl43SmNh1O6O
 VD1Urqd0sUVjRnEJYzGpnzym8X0/52hUS8mjffwCQSfIwoJTyiUbiBgrLDCQpyYY54CRsyHQw
 wNTgD57vxa3O4Mb1F59ggerueEwUHe8nAfTe96KR/9Mcs=

Support paths longer than PATH_MAX in create_one_file() (which is not a
hard limit e.g. on Linux) by calling mkpathdup() instead of mksnpath().
Remove the latter, as it becomes unused by this change.  Resist the
temptation of using the more convenient mkpath() to avoid introducing a
dependency on a static variable deep inside the apply machinery.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 apply.c | 13 +++++++++----
 path.c  | 17 -----------------
 path.h  |  6 ------
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/apply.c b/apply.c
index 432837a674..4793b05f3d 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -4502,17 +4502,22 @@ static int create_one_file(struct apply_state *sta=
te,
 		unsigned int nr =3D getpid();

 		for (;;) {
-			char newpath[PATH_MAX];
-			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
+			char *newpath =3D mkpathdup("%s~%u", path, nr);
 			res =3D try_create_file(state, newpath, mode, buf, size);
-			if (res < 0)
+			if (res < 0) {
+				free(newpath);
 				return -1;
+			}
 			if (!res) {
-				if (!rename(newpath, path))
+				if (!rename(newpath, path)) {
+					free(newpath);
 					return 0;
+				}
 				unlink_or_warn(newpath);
+				free(newpath);
 				break;
 			}
+			free(newpath);
 			if (errno !=3D EEXIST)
 				break;
 			++nr;
diff --git a/path.c b/path.c
index 8bb223c92c..67229edb9c 100644
=2D-- a/path.c
+++ b/path.c
@@ -28,8 +28,6 @@ static int get_st_mode_bits(const char *path, int *mode)
 	return 0;
 }

-static char bad_path[] =3D "/bad-path/";
-
 static struct strbuf *get_pathname(void)
 {
 	static struct strbuf pathname_array[4] =3D {
@@ -59,21 +57,6 @@ static void strbuf_cleanup_path(struct strbuf *sb)
 		strbuf_remove(sb, 0, path - sb->buf);
 }

-char *mksnpath(char *buf, size_t n, const char *fmt, ...)
-{
-	va_list args;
-	unsigned len;
-
-	va_start(args, fmt);
-	len =3D vsnprintf(buf, n, fmt, args);
-	va_end(args);
-	if (len >=3D n) {
-		strlcpy(buf, bad_path, n);
-		return buf;
-	}
-	return (char *)cleanup_path(buf);
-}
-
 static int dir_prefix(const char *buf, const char *dir)
 {
 	int len =3D strlen(dir);
diff --git a/path.h b/path.h
index e053effef2..ea96487b29 100644
=2D-- a/path.h
+++ b/path.h
@@ -23,12 +23,6 @@ const char *mkpath(const char *fmt, ...)
 char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));

-/*
- * Construct a path and place the result in the provided buffer `buf`.
- */
-char *mksnpath(char *buf, size_t n, const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
-
 /*
  * The `git_common_path` family of functions will construct a path into a
  * repository's common git directory, which is shared by all worktrees.
=2D-
2.44.0
