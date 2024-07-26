Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146A176AD2
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981873; cv=none; b=HveFiyTJ+4ozPQJJVIGyttrHULYtatwfwTHZ5hdF+GjzQdBv4ADWww8MBTjWasSkvQnK4mPN+5GzAuLCvSl810OSas+HwHIGkyRfxuZhVhGfYQFH2zwjAhMnhE4KH2MNsepawbKjbC1ALoR/Gm8UffBOZ9QLq30MjWQmz3RAH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981873; c=relaxed/simple;
	bh=HSWVSVXP5Aayj4xTZ/KNVNu1zUcDbtAUSlxyJTXdOrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHO5EpXqcAaN+gfDmabgGnWI/c8jAKc8aJrYfbq0jZWaxMP/8NdCMM8sp90Y8lyOwViyJTBoEzKQqCUTm4jsZmvCdSIF9V0MPwGh4atfNqB+CGAw7DGKnqxOOGSSpm054MhMUTdb9AaNEA/DRPcipTIaZD5QIu+3Ci3FiCw3CJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=CIGajTGK; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="CIGajTGK"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id XG7MsyipKvFCWXG7asRqjU; Fri, 26 Jul 2024 08:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721981775;
	bh=HSWVSVXP5Aayj4xTZ/KNVNu1zUcDbtAUSlxyJTXdOrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIGajTGKoH6PXay7L8MZzvl9T4ycCQWX6Tt6nDUwcww4g7epf3S/5093EVjwKml88
	 BAFqv+9h7K7tHEpYNWnfl1TL5tidHltQDcXcJ2uco+QgVw90UG8UmvJXhCoaIr5Xzr
	 m/Yc08kckwfvNdIKxvP2B0EszKnrsy6v0MmO5tp1xrCWIwfUscbLvDDUKNhdME1Hy0
	 vktPkYXyX7wX9tjrgFsx7Ey2B3RQMiku6ovSZoKDD/Mu9KCdXVp8xEQ8BYHmp67Oh5
	 5ZGtVLC2oc6WN2JwKoHOrsWnUApKa6HyQDMen+OrdLldqJUtmdsFTQnBcRIX36v9Kn
	 bBNWnAxLUbkrA==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=O+w/vg9W c=1 sm=1 tr=0 ts=66a35b4f
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=46kcjEQM1sjoQMFQ3FAA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] check-non-portable-shell: improve `VAR=val shell-func` detection
Date: Fri, 26 Jul 2024 04:15:22 -0400
Message-ID: <20240726081522.28015-6-ericsunshine@charter.net>
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
X-CMAE-Envelope: MS4xfPNck9Qxa8Ggr0rV0YfW5ng01ffcJYtUzWB2fM8y0Ei3sxilqrpdeQo+D94zMv0kyICJ0t4wZt7dBls3M002GlhRPnjlLxcB5s9jZiWtsLrRRzWm1Xau
 fnOK+DDZhSP/c5fCTPM3eZEgAwgpdgIczYu9MHI+sQ2JXZuQO9WKsj5lyKs5wLkuj426LsFmOTgksLN6G7S/N/clG6oFRzTPQrJyqokEL71rQwUdSYEvAI/P
 v/LLZvvODgG76dzzNZh2IljbTOqmeWkbxbhT3I4RQpvpnQp/60oIhgm4KCb60dQihUFRhYI0dfGg1nQOTti9sYWvIb33SUesWuUyZorZo94Yrn/pGxKwyDfw
 zdzZA/on

From: Eric Sunshine <sunshine@sunshineco.com>

The behavior of a one-shot environment variable assignment of the form
"VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
function. Indeed the behavior differs between shell implementations and
even different versions of the same shell, thus should be avoided.

As such, check-non-portable-shell.pl warns when it detects such usage.
However, a limitation of the check is that it only detects such
invocations when variable assignment (i.e. `VAR=val`) is the first thing
on the line. Thus, it can easily be fooled by an invocation such as:

    echo X | VAR=val shell-func

Address this shortcoming by loosening the check so that the variable
assignment can be recognized even when not at the beginning of the line.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 903af14294..6ee7700eb4 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -49,7 +49,7 @@ sub err {
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
-	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
+	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" is not portable (use test_env FOO=bar shell_func)';
 	$line = '';
 	# this resets our $. for each file
-- 
2.45.2

