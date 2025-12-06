Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953A2F39AD
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765027665; cv=none; b=m6rxWfF+FikJRr74wEKrB3ESnwm9Ty+SGAU1GjTyuXuwgkjqFHx8QGZ9OpvplH+M76L/PxD+TQ5dR5cWfz/u5JhcIU+jm4+g7qm26q82tRlyPIsONBR355S3RmljYu3wKMAU3MGqSn/BdDg19bVmROoRgdmLN2k3ozKdZrIi0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765027665; c=relaxed/simple;
	bh=vi/9hi+AmzBv5IFl7Avxkk4LD+sJRS3USNGQh9dlUzQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dl5txFj2xx8+Jjz0yfsPkPd+eO24aMi31hOpnts+5CUqZunYT4eygKRyYqJxqOdxrDZUSM42Ylzop2XJf2tyFwoOBH5D+cctibQ4UYiKqMyQMbcxw/iiNsu9lqI4SCKC4hGOvyL2XPyMZ4cOYV/CQ7em5eXVYpAD2X3sJg0P1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=KwXftVtQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="KwXftVtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765027660; x=1765632460; i=l.s.r@web.de;
	bh=2/3tGNuIQaB6oH+yWMvPRCeZlvVdW4cZIxJOClFnt+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KwXftVtQsr1OqDLBK9OoYdHIdU0YLhLrcqIJQJtWa1Fs1118ENM2LDS0V3zDdVyd
	 MLiEjr55D6dH5M8gRs+6ZxlQnmF2EfsoQV3teCeTD2ewVBXYsScFvS7VQw2ltDaWI
	 cfVXhS9VVo8lsPsWIEQV5CoVyajzqZ7C5E0QLZMxp8U/pyHv+IwRTSDtKbis/qfee
	 3FAxWRyfFjEGpyqjLl0ZtbbCJDQNsWdkiymuro9+mOZK4LmDBpbVQVzi1nJ4p/B96
	 DishLUHFG33DUW1KKJHnJICaZP1m63XbPyOw1IaCxInGa5ZCm1R5dJAK9vju/M4ew
	 +QSBtGCBHO9BFeSWfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1wDOLA1FVU-00rmNg; Sat, 06
 Dec 2025 14:27:40 +0100
Message-ID: <8045d953-2cee-4ffd-b3d2-cbf732d5c839@web.de>
Date: Sat, 6 Dec 2025 14:27:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/5] wrapper: add git_mkdtemp()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Content-Language: en-US
In-Reply-To: <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UF4nBMqLI3KIoxCvl0b+WnjyZbhIWl+paRZj+vUy5q05E7qkNYl
 gaOI+ITJjfl8Z7JmHQScxqpViLE9MURmctkZ+DPjGZ079zk/OCtGcXIAKuNQELXMwcxxPkB
 /1OyrRUJpEF/LaQFi3ESp9HBVmyHeghNEqJv9DPbqSnnZHHHvsB2gzjQpisqOb1A0b6zNBK
 Pvxf2mdo/dnaTBUPWTwAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:08KCjdH+bpU=;yYtKtD/rqpLYph7mcOWgvsJ2n7o
 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
 E+0p4AlupYpg+pVIfbwh6yENj4upA

Extend git_mkstemps_mode() to optionally call mkdir(2) instead of
open(2), then use that ability to create a mkdtemp(3) replacement,
git_mkdtemp().  We'll start using it in the next commit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 wrapper.c | 21 +++++++++++++++++++--
 wrapper.h |  2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index d5976b3e7e..b794fb20e7 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -429,7 +429,11 @@ int xmkstemp(char *filename_template)
 #undef TMP_MAX
 #define TMP_MAX 16384
=20
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
+/*
+ * Returns -1 on error, 0 if it created a directory, or an open file
+ * descriptor to the created regular file.
+ */
+static int git_mkdstemps_mode(char *pattern, int suffix_len, int mode, bo=
ol dir)
 {
 	static const char letters[] =3D
 		"abcdefghijklmnopqrstuvwxyz"
@@ -471,7 +475,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len, =
int mode)
 			v /=3D num_letters;
 		}
=20
-		fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
+		if (dir)
+			fd =3D mkdir(pattern, mode);
+		else
+			fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >=3D 0)
 			return fd;
 		/*
@@ -486,6 +493,16 @@ int git_mkstemps_mode(char *pattern, int suffix_len, =
int mode)
 	return -1;
 }
=20
+char *git_mkdtemp(char *pattern)
+{
+	return git_mkdstemps_mode(pattern, 0, 0700, true) ? NULL : pattern;
+}
+
+int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
+{
+	return git_mkdstemps_mode(pattern, suffix_len, mode, false);
+}
+
 int git_mkstemp_mode(char *pattern, int mode)
 {
 	/* mkstemp is just mkstemps with no suffix */
diff --git a/wrapper.h b/wrapper.h
index 44a8597ac3..15ac3bab6e 100644
=2D-- a/wrapper.h
+++ b/wrapper.h
@@ -37,6 +37,8 @@ int xsnprintf(char *dst, size_t max, const char *fmt, ..=
.);
=20
 int xgethostname(char *buf, size_t len);
=20
+char *git_mkdtemp(char *pattern);
+
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
=2D-=20
2.52.0
