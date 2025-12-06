Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6401E505
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765027792; cv=none; b=jOdRIpgqaMNIvnMah9uxNMP4ljuHVJX3UlLLlXbImeQ4yrKR5qoPF6M6HW7XnIKWGAEwCpglvcqY/OlU0KqlxYBvotrtTb78QaRl50rjvpyQaUAebcybtXeTtbyqqaO+PRH5zF6KV56w6uxEq3IxUhaE9sGazig+dPhRG3zzI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765027792; c=relaxed/simple;
	bh=7Y1BjzHiYOOlAzzPNdZNZVL4TY/nPAHejxJFusgUjls=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nQRRczA7wGksBop7RgMpgs1lyxyPuyHZtc//+QoXeWxYkGP1Fiku5iQSZTJQywax3/eJvxKbAEvIYL8P9cg+Vbt5cJWcUAA9ozpAlW75uA2832MLOHbtAHxpsB8AbAAQm8myZsb9lZq6e4ErFTZOG08++B8vi91okrmqDfjQ2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YrEBTRyz; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YrEBTRyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765027783; x=1765632583; i=l.s.r@web.de;
	bh=nChqxmNh0u/pRNHz1ono5dzQ+Ho02LkB4x4XmpYx9Tk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YrEBTRyzs5v9/6wCrAWIB6SbNoJJWxswtYNBmI93RmVS29OMlX9wd+RiS7FC6ntw
	 zAaubbF9yVogi6UezZaGzBrVCZqod930f7ib+H+k2lub5BFhvTwbFU9br+m3oE50p
	 IAO00cPpG2O9CUh5FJI8the0BBV0MOOyPu8MbyUS9r33870sNsyAXJsg+IrMQIiFV
	 WP0pDyYKx3PT1yS9fALIl3bryb4d4vH/ezW8X0R/I6TofY6JpHM1JqtWIdwCQKqw6
	 Xm9UPMCNJ7frBgnUkvqbXNRscX5Qe3R/+0EVKav8oUa4BxDJz7+XivZHcmx6y9iBp
	 7BbA0+RoGqJhOP8qRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aDp-1vUtA42lxL-004ShC; Sat, 06
 Dec 2025 14:29:43 +0100
Message-ID: <e014345e-9472-4692-8985-1a56b64eef61@web.de>
Date: Sat, 6 Dec 2025 14:29:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/5] banned.h: ban mktemp(3)
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
X-Provags-ID: V03:K1:jFRCWJp8dUA42zS/UFxi4hvIlAbAXIrAobVsuPv4xyW4syvI/7T
 gTqn2z6P+R9OxCUQFZ3rWzg9XX4ceIeqD+K+Z/xJqMNr2KMuy++fIXg7sN5QOPQCWV1+jWX
 P6/4zDGORJWSqGFEm2Hq4x5B0e8nQ3sDjQyxfC5y2c01we0oOYdvWwq4oiTMhU6bzxJisUE
 VRiFfQeBnUcf80+JXkr7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LsqrFgyH/s8=;tUbNj0A2PkjPvHS+AihyBhfDc8n
 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
 NU9l+qVM=

Older versions of mktemp(3) generate easily guessable file names.  The
function checks if the generated name is used, which is unreliable, as
a file with that name might then be created by some other process before
we can do it ourselves.  The function was dropped from POSIX due to its
security problems.  Forbid its use.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 banned.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/banned.h b/banned.h
index 44e76bd90a..2b934c8c43 100644
=2D-- a/banned.h
+++ b/banned.h
@@ -41,4 +41,7 @@
 #undef asctime_r
 #define asctime_r(t, buf) BANNED(asctime_r)
=20
+#undef mktemp
+#define mktemp(x) BANNED(mktemp)
+
 #endif /* BANNED_H */
=2D-=20
2.52.0
