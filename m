Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC081AB6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069792; cv=none; b=o2l2teoIbqIZ/VMCOdpCler6+++NGhVpbaT4KZdloMlHNPShnU7Rujmi/Pei9tgaAhCNBk6Iln8J+JOxigIlftSmfQW9+5O076inO37c+Be0YnOlt9dMaHhTXxctAYsPpXis8ml/t/918Rah6iVqvgyKBRJxEstiS9cW66XBefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069792; c=relaxed/simple;
	bh=FiL3QM0HZ4UZ251jS+gr/5JRzUHvwv91iY9Wd5MACXM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VXwH4RM1NfXJ2aCe9TI+m96qBnO1Dw4MBvpLatcTVUPp9ie+XcnrVGH36HnmdgIlIKtAZghOMM5OmSTtEkEUqRFaMwGE0vidushhX/69cNIg4I7LbWuiFTV7X+Qhdp8zRqgMD5Kc71zPKNZuVIOhessUtKK3A2C07hznVruXx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LAufnEWg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LAufnEWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712069788; x=1712674588; i=l.s.r@web.de;
	bh=oXAI8veZHTAhGJMwDwXvKjRTaWRolhlunxonZ8sWRhU=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
	b=LAufnEWgceO7wnm34LXyS+0FcFkKBNqgs8ccvMW7ge4bAzfrk0lh8UlJzcwbwqsV
	 G4LuiMMlRzqaCQf+s9mM7397hjtVNkmBXilpsgg4qvhujJETk4rf4jvEJFNQI8hrj
	 9x5oy8f16s+arul6KWsvmXVgecANuErq891iZR7mLMSihGp4T1lP/csmoVyu25VGk
	 b3MrUunDAknqfcNH1StUeQgsiiFgmUAblFHVKjK3VzV49VfZROSnAjMTrNCze8zF2
	 TuvGMVM8NT/eN5waW9OISIB379+I7AV/LrecnuSe4TWGMyU5bxLflc/DxYKG8K0oH
	 lPvJX1O3HXWkbHrcRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1rpSYE1YIi-002XJ3; Tue, 02
 Apr 2024 16:51:06 +0200
Message-ID: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>
Date: Tue, 2 Apr 2024 16:51:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] imap-send: use xsnprintf to format command
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IQMdw3Z7i3ZrG3X+r7e5XnmwR65mOvItsD7qQ8JXyzGaMUtbctA
 OqG8WcWLuR5xVnRkwe6ms0wYe77lucRQJ8H4GO8JBzqAKVUgam8l0ZTR7EBL87DWnoVBnqb
 DgqvirPNRxj8jbwj3xeHa6PLGTVFyDVutZIvgLg0sA6GpETKfh4GPr7EheRIl6b5OKiOAPE
 ILwky4TDQYLiwTXKtfm1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wsi+lQErZI4=;AL/Aw9ja6pyTKRX5usdegW9NJew
 dw+IqWACqwzmoQHBlkpQ8WCJlQLnq0aTDGPLYC8KoQyNbs4M2GmRfqQ7NhBfPzBeswOohgrq6
 S374BH7OSpSi2TFDyp9/DA8xmmzLcEi4P59xi+ausCjAvbwtMF3OmfG0d7hxYRHR6PcBxRqjZ
 4RUMsCEQSWqHPWUllpTbySESBBvNVYDOo+Lc87dj0hIG/eD6+OmNzvrmS7UwOLSZ9deFsqLMW
 MlO8rK+SMMGAU723Hj1j86pSdRbUUc6b3XEs1k2H+sMQfEU/5SeyoXP8IfCVTcL+GyTgpS9Lx
 vKJpwCg/SvJC5rp1tA92OByj1GB/m0tJWjH0cQt+vqNLucJKwIAmZyhjH+BrMHmTE1ve5z0Nz
 dXDtGINzt80qw5JOolxLVvQJaeMRxONxNCIm134dHQHi8EYSMK08tfwGieJqPypeIVknXbko/
 0Of2viJw5lE2ovD2gO/77iQfh2AeXB3d0fz/xF1LGJMkSoGoSRa71IJg7xhmN0lDc5fYo0z2B
 iPDn5JAwlmFbOyMWcJb93whw1f+z+yVrqHX1+ftMDLYe9W1eBDQxKxY/vFriD6Atc7KfT8VWc
 Y/hUGzmHbnM/y7BP3Ou76/Sf8FVDAHj4MsP8M/5lL3Kl1gQ7WRtnX6/MQrk9+hQtXLE6nu2Q1
 C8c0wVi9FtSkNXDvHMzfGuVCoDHTUnq4ylkmhZiYYuLQOQeTWtlsaLkzDmLHaVw7cveEAAetp
 JGnu5hsUsbwYdFN3+seb+dIjE1MhOWQeD69LXVyrFAwilyResVwiDDBpN/SbuBgLqg6d6a6EI
 d5YQCtJRYRk2jdxQzE23qWSmaEQHugoFx26ujcmrWoADw=

nfsnprintf() wraps vsnprintf(3) and reports attempts to use too small a
buffer using BUG(), just like xsnprintf().

It has an extra check that makes sure the buffer size (converted to int)
is positive.  vsnprintf(3) is supposed to handle a buffer size of zero
or bigger than INT_MAX just fine, so this extra comparison doesn't make
us any safer.  If a platform has a broken implementation, we'd need to
work around it in our compat code.

Call xsnprintf() instead to reduce code duplication and make the caller
slightly more readable by using this more common helper.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Uploaded this message using the patched command, but that's all the
testing I did.

 imap-send.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index f2e1947e63..4caa8668e6 100644
=2D-- a/imap-send.c
+++ b/imap-send.c
@@ -68,9 +68,6 @@ static void imap_warn(const char *, ...);

 static char *next_arg(char **);

-__attribute__((format (printf, 3, 4)))
-static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
-
 static int nfvasprintf(char **strp, const char *fmt, va_list ap)
 {
 	int len;
@@ -500,19 +497,6 @@ static char *next_arg(char **s)
 	return ret;
 }

-__attribute__((format (printf, 3, 4)))
-static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
-{
-	int ret;
-	va_list va;
-
-	va_start(va, fmt);
-	if (blen <=3D 0 || (unsigned)(ret =3D vsnprintf(buf, blen, fmt, va)) >=
=3D (unsigned)blen)
-		BUG("buffer too small. Please report a bug.");
-	va_end(va);
-	return ret;
-}
-
 static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
 				       struct imap_cmd_cb *cb,
 				       const char *fmt, va_list ap)
@@ -535,11 +519,11 @@ static struct imap_cmd *issue_imap_cmd(struct imap_s=
tore *ctx,
 		get_cmd_result(ctx, NULL);

 	if (!cmd->cb.data)
-		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cmd);
+		bufl =3D xsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cmd);
 	else
-		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
-				  cmd->tag, cmd->cmd, cmd->cb.dlen,
-				  CAP(LITERALPLUS) ? "+" : "");
+		bufl =3D xsnprintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
+				 cmd->tag, cmd->cmd, cmd->cb.dlen,
+				 CAP(LITERALPLUS) ? "+" : "");

 	if (0 < verbosity) {
 		if (imap->num_in_progress)
=2D-
2.44.0
