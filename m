Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F52F7AC5
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765027716; cv=none; b=ekrjCAaDZCxXIsE1Y8ynYxD0uro7/4r/wK3Izdo4t2AmuhZDpm7P/HEPGygIZyJsxSwnRDd4xc88zW/pH/PBEdVrb3On6adI8Ofwzh3gsRcR/nLt+A5ZxE85xkLJQSKmsu2qvUD8lrno+5/R74xFxyXLZYGPoTK7PavTD8QGu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765027716; c=relaxed/simple;
	bh=Uv9nsAhuho49sEvG7E8yA8kZUDAwkTxzUZZGIXpBMUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q0LM3socd5ReC1LJHt7kNZdbZ5T8c3zKCUbj6VMsb0K6e35dRZesIVB4LIRKQEvin3bZZNxBR9RKbQ6VMzBeNpusB/vMs+xdVU5ceXBEJ0QG0wSvNNNPCVZMW3wdUFR4lndf+cXZaCpv9lfNQpVKelNesUpc/1i4X7p3CSSjCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=pg49TN1x; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pg49TN1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765027706; x=1765632506; i=l.s.r@web.de;
	bh=KlNRVDNUFdcUSL7B/ASa+/nEUll/ivGd1EgvyfbOqYE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pg49TN1xPK3vshgNGmVbmsul/dStCa8LT2paNPP529YQ26Ew+XfLNYuJR5yEaJoa
	 4HlfUTxB3fKhHJ2yPQqnIA/70ZN0cHPajhUgOW43F9sChbYaX9afoayLbemY0tijl
	 cNxCpV5rdJQyIsiaB1bX+hrZbEVAeujkZTy256tKyVZ4lPnC6+ZjvEnKV7YaFyGpD
	 0C55dvYkCqwiFI795thkePY16CKqR5LT4OKcLoDvCyvu0dBPQjbdNtKsHKnaS+oBV
	 GA6ME/EvY6yJjRS7oQ6khdWWy1NLvQJn01sMffSnIPoELpWNk2KR0YuFJFkQnl/+/
	 +C+MAQSDmnO4hTxLuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1w5NaX1z8R-00zmhM; Sat, 06
 Dec 2025 14:28:26 +0100
Message-ID: <88a8a282-d436-4948-b2d0-ee9e1449f578@web.de>
Date: Sat, 6 Dec 2025 14:28:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/5] compat: remove mingw_mktemp()
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
X-Provags-ID: V03:K1:1ZJScVbIyxyZU9Z3V/rFA4zrQH3ssmjLxanuCBiTgmGjMES51kQ
 XIjdCZbsYLHcNIYARnWbxWJetZ4byALXpy0/L8MOgORzG/2u0zLsgOdWV8zYV+C5OnlB5ds
 VZUCQtar601IbDUjd5Ynrb5PF1QJva+nn8RYWJXaNNJQ1XfjwQNVkbeUuarjzx8jU9H9pa/
 u7aSah64tSIWKqddQH6KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4X0IMuyXALY=;3nh/hW5x0ldOIpiVsZwG+ZFlUon
 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

Remove the mktemp(3) compatibility function now that its last caller was
removed by the previous commit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw-posix.h |  3 ---
 compat/mingw.c       | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 631a208684..0939feff27 100644
=2D-- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -241,9 +241,6 @@ int mingw_chdir(const char *dirname);
 int mingw_chmod(const char *filename, int mode);
 #define chmod mingw_chmod
=20
-char *mingw_mktemp(char *template);
-#define mktemp mingw_mktemp
-
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd
=20
diff --git a/compat/mingw.c b/compat/mingw.c
index 90ba5cea9d..939f938fe2 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1164,18 +1164,6 @@ unsigned int sleep (unsigned int seconds)
 	return 0;
 }
=20
-char *mingw_mktemp(char *template)
-{
-	wchar_t wtemplate[MAX_PATH];
-	if (xutftowcs_path(wtemplate, template) < 0)
-		return NULL;
-	if (!_wmktemp(wtemplate))
-		return NULL;
-	if (xwcstoutf(template, wtemplate, strlen(template) + 1) < 0)
-		return NULL;
-	return template;
-}
-
 int mkstemp(char *template)
 {
 	return git_mkstemp_mode(template, 0600);
=2D-=20
2.52.0
