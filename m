Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA4176AB9
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981873; cv=none; b=vCYNFtaDwBxkpo6FmLBZInS9XsYfPeyhr0+VMQbD227JK4uSMbYDTlCgjkTmzUX/lw1ap03bWCKuK5+d4nR4zRsQlZwSyiHIh18aNFY0iQ8sHg4qqJhi0LajM0IvNTJWYhsoGoG4qnqln3MTCTKk0DiCd2Wc3tchrEF7pgDiSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981873; c=relaxed/simple;
	bh=I2d1inHlPh4lMOySsiLS9Rdx4TX2rdWg6Ha+yKaNoW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A52PgWBvoSVwh72tlaysw/PTXUnVCdQ2lWLGdALXNUNnrzihK5Dm3WuWmD5q0W0JEjlo+Rv6YxF/JHdNwktWhM3+ZCwkGWosVIDx/VsIyuau+R6a0U3X0gFqQWIANRlXl0+klF7F2KYhN/SOLqWCZYh7YqmTDmSCfMkalled4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=aOylWZoX; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="aOylWZoX"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id XG7MsyipKvFCWXG7asRqjF; Fri, 26 Jul 2024 08:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721981774;
	bh=I2d1inHlPh4lMOySsiLS9Rdx4TX2rdWg6Ha+yKaNoW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOylWZoX6ikBzadPcR/Fd5a332fI+zPAdE4X+pB0wlnD7Wzh16b5+cCkiwE0BL/lG
	 rEbCCBzpfSM0A2D7kX7HFpUzqk4+h6vuEeJeeAXRBl3kL1GU8ErnY+0uLMNTZ79+Rr
	 1qCMo7R+A86OYzvp1vAz0IA536C2iSgjXXTcN6qRHIMA2gbkRee2HQCqmQiJwtjXSK
	 G9mUbawp4KWgUjbuZ2MH3c6RbhyPTsZ18mdBlbWkaOH2MQPh0v4EhGsGDE66EFnDQW
	 +RTRO0KZfPrgvTfACzAAAlVKEiOnyEoHIxmr8CWhcAZq3cUxdSh48GCAx8MaWrCimk
	 XntG3uh/D1CjA==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=O+w/vg9W c=1 sm=1 tr=0 ts=66a35b4e
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=tEj-drDq3PFC0m8d5k0A:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] check-non-portable-shell: loosen one-shot assignment error message
Date: Fri, 26 Jul 2024 04:15:20 -0400
Message-ID: <20240726081522.28015-4-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726081522.28015-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240726081522.28015-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCZ7xnSSVoddY7wDS7a9UL3rdRG1jOIJargj9BEkfqQzFXcaEqnpmVouXaKKtdw7/Jyy+032g33Ixq+rY33GJHdod8FeH2+k7388fg3Q3LptxynKITXz
 Wq1tOO8olzfFH8kZ52m1UrcHVfMpef28wb8iAxwCOxhmrf3gO4mRc58CdyHT9+Ac1B6tErITJQ3f4u2YudTa/gc0Z9AGKdviHV8VYHe03lrpfMK0m/gwPImq
 1SMO5PusgVG7NmdFSEKD0lrr4pjW+7j2nVBgWOhEE2VEpKBynxtr3lRksVFzTVn1J+AkoZe4slZogTckJaZy42nOhWGEedsY2+2tC8XqOFdQyGl4zQal2YRO
 u6iqgkEz

From: Eric Sunshine <sunshine@sunshineco.com>

When a0a630192d (t/check-non-portable-shell: detect "FOO=bar
shell_func", 2018-07-13) added the check for one-shot environment
variable assignment for shell functions, the primary reason given for
avoiding them was that, under some shells, the assignment outlives the
invocation of the shell function, thus could potentially negatively
impact subsequent commands in the same test, as well as subsequent
tests.

However, it has recently become apparent that this is not the only
potential problem with one-shot assignments and shell functions. Another
problem is that some shells do not actually export the variable to
commands which the function invokes[1]. More significantly, however, the
behavior of one-shot assignments with shell functions is considered
undefined by POSIX[2].

Given this new understanding, the presented error message ("assignment
extends beyond 'shell_func'") is too specific and potentially
misleading. Address this by emitting a less specific error message.

(Note that the wording "is not portable" is chosen over the more
specific "has undefined behavior according to POSIX" for consistency
with almost all other error message issued by this "lint" script.)

[1]: https://lore.kernel.org/git/xmqqbk2p9lwi.fsf_-_@gitster.g/
[2]: https://lore.kernel.org/git/xmqq34o19jj1.fsf@gitster.g/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b2b28c2ced..179efaa39d 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -50,7 +50,7 @@ sub err {
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
-		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+		err '"FOO=bar shell_func" is not portable';
 	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.45.2

