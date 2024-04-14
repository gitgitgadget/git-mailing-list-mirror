Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35936121
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713113280; cv=none; b=ZuQyDRl4f7NRcxhBejqWLOPOX2mETxDDQ2+XpM+N2UUuEZ3w98b4EN2tcOG9AWbGgzxmMmJZjqCpfMVphC2eGyYOeM/KRlJ8RjCWRjP+JZccUX7rC7IQCftmdmt0HdVmWvklIOVvl1ID+UtIZO3fXaw4+lgCxdEK4sXuiVK/o9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713113280; c=relaxed/simple;
	bh=pCv7kKxkAhM9DhMCWsRX7hL/0tquEGW9QhPCMnc91qU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a0gUhA5BlTYWFyOqpJwwy/F04SEmMyxENN5knP+BNk8s9jzUaPaqHOlWjz3aHm4oUWko8N3tXiUlQut/6LjqxLqbx5FRcZaz6n3706r7dVkmJqTAPEhrlmUTAqPH/dCsP5RWu2UsWz2COZw+15ft63zS+9xPMPiRdOCwtMYRrgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HljzaJsA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HljzaJsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713113275; x=1713718075; i=l.s.r@web.de;
	bh=JAa1haMVLj7rU3kV6qDwMspgTwKa1Z8Y0UnksEanP4U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HljzaJsA8Z6B3lPicQqjGpli5tNtNlf6KV3f/r//d6i4p2QhwQlQBvdPg4dOej/3
	 3g2rJBo3zv/Keq5ZeXm1X0fb400GFY528YZbyScR3YZIasxPxJJWLWQMB6A4YjsQw
	 sCTn4n+GsbTy0T8Hza3NELLukf0anisfQeFV0SAHn1dI38egVk4aW55dXD261x13b
	 YQKInTKOOpaS8NLrwhnQuX7PfXlmwhpcRxXhji0F9qJl4mHgtl+ugLGFcnpoUZv9H
	 kJ1/H+281N0IAPLWZBuISvv+X8Nd3oyerDf7tT3Ud/JU6XnFlzDw8gjn8j7XsZAtM
	 hnYRfM5tzO1IvUke/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfkd-1sJWNS04gn-00Tnfc; Sun, 14
 Apr 2024 18:47:55 +0200
Message-ID: <3188f4e2-9744-40b1-8f05-0896b8679d25@web.de>
Date: Sun, 14 Apr 2024 18:47:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] git-compat-util: fix NO_OPENSSL on current macOS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BY+/yDakAAjPnnvSE7tT2stYMngbS3b0N1pBdwrBd0IBUn/03uc
 lalv+SwJ6nP6cVW3V8E2U+YqdL8CFqY3LOh+cku1DEjHaZwceto2bZs5zGVq3cea7pPykv3
 07N8OLMEBGs5DppWPFKppVHcPDCRQFKbP4KE/gzNtl4rH9+OOaFTBuIYTGmyGZr9UlbDWt9
 p4mp2dda6s5cevtCXDqdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZZVlW9Jc/mc=;IjKJcxLUHw8np+yuNbi0GQQduu5
 45CS1Vb695SOm92S0pKqXT6ja9oeQPC6krDO4a38uvCE6GQ0tDaGbreis1wEZe8RPPgPCbaw5
 AQ9FugTXEzl9yitsFF5j9p+j11mPIEVCHNIVYacfktbPyhUkvjXPgSToWtiXHgfq50w8ujVSB
 PoDD6fF8XY+qmOu2ARNQI9ddtdP1TH1jtpEb3eLjGk6dufSnBcsL3K7tQBJIy08fMSWebTKR0
 qxCwCZxeH7SfiKKq0sae6A4tjqHLuBJJL1kjpW4/gA+sc9ram8XhrAIG8kwZssjI7kM/DJxcv
 xQGNxFLPH0kDLRIzCnOZ6kJ9zWfWF/cA5plgg5JuEKvd10CcUcYn6oR3fghnjcy7gLgZDxuO7
 rRQOK5pfor6Z76zcUnTxSLnrBTf4l+dYSp0Qg9kdevWiRpplkBifBL08UB/DOOCfpOsEEVaLC
 FiwJJwKtAHe1Q/RLy4e0wPKSOv3gqM0066lqzrlYrz70uuiioJFeORvK6fpjS7ZeZjDsOi1P6
 5ESIQRq8ZLjNXLqGAr3RcQNdmlHUeSs65K0aeexmF1OiyW8ENSjqlRm2wvxoYN/Infn1NngrN
 G+cIGN35w+DjV7wkRq5Klq5lfFZ8d7gHcPP1uK/oGBxXkvU7wTOoYlXAAGRhjJdrG/q+rUB88
 3J+givSihgi1yBQgZeVc1IYafnnWy5voTGkvjpAApWMGtGAHpbJrarQqF1Z1SMjA1cihAFjTs
 LJmBGKdKi7PpBhTnGRphuZ/Qtx7zEkLbidaZ4Vs8dRHuttqlE51ywJnSd91sGTOU/jeVLwZAA
 sLgMjRStaycUq+OCy6OrLTRdgzyWM8l0jziOHQWvgJxjU=

b195aa00c1 (git-compat-util: suppress unavoidable Apple-specific
deprecation warnings, 2014-12-16) started to define
__AVAILABILITY_MACROS_USES_AVAILABILITY in git-compat-util.h.  On
current versions it is already defined (e.g. on macOS 14.4.1).  Undefine
it before redefining it to avoid a compilation error.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
On my system I can remove the whole ifdef __APPLE__ section, as the OS
doesn't include the deprecated OpenSSL anymore.  I get a current version
via Homebrew, which doesn't throw any deprecation warnings, of course.

Not sure if this is the right fix, as the no longer needed section still
undefines __AVAILABILITY_MACROS_USES_AVAILABILITY at the end, which we
may want to keep instead.  But compilation succeeds and tests pass, so
perhaps it's fine.

 git-compat-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5..1a4f5a30c3 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -391,6 +391,7 @@ char *gitdirname(char *);

 #ifndef NO_OPENSSL
 #ifdef __APPLE__
+#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
 #define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
 #include <AvailabilityMacros.h>
 #undef DEPRECATED_ATTRIBUTE
=2D-
2.44.0
