Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255816ABCF
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314615; cv=none; b=SUcymrhM0jX/wSMD9WwJuxso/El2SIdvzmFPFDPu5GihcjARFVH/i9uuF3SsfX1VF6RFoGLkhhOmxrmmNKar5makv+D0+1F7v3Ss5Lsf2DNTPNv36KwBTTu/TTAxVNSKi3c+e4z71ELUajMAr/fctZmoD4HuIXYdzusXA5VoNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314615; c=relaxed/simple;
	bh=vvOv02FKxkchpPk8mTtFZ2NW0ZVcmLqT4ZL1OlT59JE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2F6Yl3oflMN5ac70fVgLPLo3lGshMu7wTn/A4WgdaT4f6FB2xw1O6A6lI6DWQG4e0E4yKldG+OrI60PeSEKLGnTF91R9n2sRhU8JYvV9XfJiCy0jrwyWJhlTZafASLJJNgT5S8hTSqnUzAD03VcJkG1FAZl9J/SO4uj9dEOZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZFNS0wmb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZFNS0wmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712314608; x=1712919408; i=l.s.r@web.de;
	bh=KHJB/I2whF5aCBvemvhuMyWJObsgNcYeRFUA7mSdfPM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=ZFNS0wmbQUdy9Qs46GG4CEQ2EiOFAKUJAJciJsldbU+Ft0IzsjRiguvn9rmsI2Lr
	 oV6rqxrWUSjxekTBUNt0OoPdHVbNSMjTFAAnAtvkQk+JJK/UP8rnVvRaSJj15Fbjn
	 sw4JJk8qfdJHqYl9t5ZSOmvAKg8xsAQn3gCH6iaCwkSds2BqDqqlTwZdPlWlKzZKQ
	 xKnbYdrQ4iIm0qbA5y5k6tzmmABzpjoYkOfGgTaWEILua5dXZQu5IObyd9V9RcQFB
	 F5kTQ0M/m79JoDMYm46YQa/Moi/eg7Bg/JTMTTrH14FfsRC03bbKCldA63J414pFE
	 EK1TGiYoTL6LfWkhOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkSC-1sNu8c3QTu-00dEl6; Fri, 05
 Apr 2024 12:56:48 +0200
Message-ID: <c085abab-2f10-488d-87d4-65e92e0ea24b@web.de>
Date: Fri, 5 Apr 2024 12:56:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] path: remove mksnpath()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <1b5f3b1d-60e2-4fe7-9ac8-a63ad861cd16@web.de>
Content-Language: en-US
In-Reply-To: <1b5f3b1d-60e2-4fe7-9ac8-a63ad861cd16@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CP8o1DHaIMEzIcTJVMHlOMybAYMuOb2eBCOpKmpCqCGZqocjFeS
 Gntmp2tvI6MZjxAaHsSz+6/r1dGSS3C3IaoIj4v5jhH/ifDWG66w8hUy4DMy7xH7FcfiOdZ
 Fa4UX9fi8FzmdRQ0tj05wDaDVdRfhfhzsXAk6XW9noHkLijNxfpnKy772oG+aVr/CvmN6IU
 RjpUIJqLQxl2flckE8vEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YOkaDJ1MbSI=;ywtg1MZAzcoJdDm7vNQEG/PmmbL
 fZw5NHxGTCvz37tgxU1CZ3QGaYR7VewwqdF1swkk5jFPtuYpyReH057X5PZdk28YxOKr/0xzr
 PNOQh7cWIfz+k//bH69RqtZSzusQ2lH0hDGvDwi6rjDGtSLj73L6wtTCK4dA5AhnEeCcHgoaa
 VUz7YwzcqKSxOcz/WXwa78M4t+L764JcyROxGQafAtKYNNjWJ3QSOt4sGikwbr+SNclmgUkF6
 pOihIGgrmPEWd3sZrcTlV4pptTtkRodZLd9HBU5vMDxagwEG0pfFRp8qafiHzrA8CxR+6F3se
 OgEWvr0YUYiwJxxoxVRR5joLMa7Qgi6AyA9Z+E5kmIznXoZ33gTnqraSwVOeUTVQ0yibJrycz
 8OyjXARVIT2m4p6Um9WBRhaGjl67L1awcInYzMSKZcMAMJc6qzUl3GvxJ5sf75gKWz8BM8GPa
 3X8PemeJmucACXqR8EcHr+mck5FsytqP1XsveI6R+zSgc8GV+89d4XEgNHBKPPOPjGrwhx8LN
 qfj9L2QPf8q/7FuTU11urJ0gSDX52G5JW+9YhQePOP7pIspnsI+HF7SawDfrgzc/DKNAsmSz+
 W7yqrXg48Pln2QKruX7SqPPzr0MzLcu5a9V86tkD37svyrywQS8/XAKnoTyaagfn3dpYLFE2G
 i0OWWADOMf3jcEysTfUpOV6UYmyt7E4IoflkvjAB9lRAN3WqoQf1CmPhHoSOXp6vRx9OhXcr2
 nRov4BUXyfBSapz9b7z40JGcuW5frKckLvWLK2/egqLQ1rHbyVv2aYet7YL80wswV60jD7qaj
 D3EaWSU1gQMN/9FPePbUy4FGxszL9fLR2Tg6dKLiJwXh4=

Remove the function mksnpath(), which has become unused.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Split out removal of mksnpath() into a separate patch, this one.
- Remove occurrence in contrib/vscode/init.sh as well.

 contrib/vscode/init.sh |  1 -
 path.c                 | 17 -----------------
 path.h                 |  6 ------
 3 files changed, 24 deletions(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 521d303722..f2d61bb0e6 100755
=2D-- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -92,7 +92,6 @@ cat >.vscode/settings.json.new <<\EOF ||
         "isexe",
         "iskeychar",
         "kompare",
-        "mksnpath",
         "mktag",
         "mktree",
         "mmblob",
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
