Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2E2D8779
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759113; cv=none; b=E0WnwSN8rF+L9UmhVsoDUc1jaKsT0yKDC1u2YFJ0Z1Gg0ksuFySUy6cyVCa0eIE/BDwLDtBKhipkxvr9NKwUQ+DJwQxLUmo6fDD4bYMaQJ1FK5ubu1lUZvfZijGcZG3On8Q0WFMYlt9OQQd8XKw9pWoMgXYIY0tvPqOZQMtBcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759113; c=relaxed/simple;
	bh=RYZ26KFIHKwpK0mK56ZDoVIkJZ3siQvR66YXqxibNt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SZw2YcpMxQvPt1Aole0dbY1q39GMtJh8z3aMdQrhvjYwzw+WzVImr+BKm2AmCIZa2b3xA8MXUYxshEmbGpoqoFGZ7cf2aA+Q7LV4wP3HGQEXz8qe+fLY+AOvbAD3UoxREHZ0Nt9Pvh/ze+WMsD6Kdq9fPhI00EbE1uVIQY44DtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VdIQTPG+; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VdIQTPG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764759108; x=1765363908; i=l.s.r@web.de;
	bh=OE5/oyTNvGfQ104fYYYnBM8xk4/sqIlofvliIp/RVV0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VdIQTPG+pT1WQTPvGf4f8uDNWgyIHCdOnL5DVYJ/AzHjT9vHHgz75oCwkG3LltH1
	 L4Z3wfAQN9+kLcPrXCbi6thLKlkNbWefGf8/HMf5tjqh2BTq2zAS53pzuRNmVlq4H
	 g2aUMwJx3zDQcoenPr7Op9QrsrOkYUoy9buZuUyqm3N12YF0k2pZbKSSOP/PirUZR
	 Mbw1JfdKZr0yQ+bE53F6ijowxrBbG8uaa8MbUg3YqC+FarEScLEbV2vLNNP9n8cb7
	 zYIbYp02LOfMe8AMptYDq5TbUGBv+B6DAhIUjLQ5PscY5XNH6jIjiWqL7hyHfh5eV
	 4sgo5yW25a5C7GW7Kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZjd-1w3fFR1k7h-00jySV for
 <git@vger.kernel.org>; Wed, 03 Dec 2025 11:51:48 +0100
Message-ID: <65c997a7-e480-4617-a761-fc9dc8a7b20d@web.de>
Date: Wed, 3 Dec 2025 11:51:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] wrapper: add git_mkdtemp()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Language: en-US
In-Reply-To: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r+PWJjn55z8BfkNEE58Iuj2NvZK2Ivx1f/OZQt6xZ6AsrxbN+Xk
 JLi4Cr7mDrVOxHYMiJwWH1WPvxs/3gX40c1YHYwmraGKc+QixNaO+BbphtoY4lCN0b9iQ7Y
 3iOMMlCyRCXRz41U+Q1oDlETtr3kWBu5GJHh+I8g/D8NCFUscmIHJhHGnA5XDwswPPM63tY
 GFXVOsKCn6zNnHrVk52Yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pYpM2XqTPWU=;IjM1mNEENPpMU0z2SazNsXZb26Q
 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

Extend git_mkstemps_mode() to optionally call mkdir(2) instead of
open(2), then use that ability to create a mkdtemp(3) replacement,
git_mkdtemp().  We'll start using it in the next commit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 wrapper.c | 17 +++++++++++++++--
 wrapper.h |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index d5976b3e7e..6ddf4eb66b 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -429,7 +429,7 @@ int xmkstemp(char *filename_template)
 #undef TMP_MAX
 #define TMP_MAX 16384
=20
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
+static int git_mkdstemps_mode(char *pattern, int suffix_len, int mode, bo=
ol dir)
 {
 	static const char letters[] =3D
 		"abcdefghijklmnopqrstuvwxyz"
@@ -471,7 +471,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len, =
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
@@ -486,6 +489,16 @@ int git_mkstemps_mode(char *pattern, int suffix_len, =
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
