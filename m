Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0017C66
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058623; cv=none; b=KXh0ObF+gzxx0gJpBv8wiJcSvrFHTj+XDEgEZPmJCbgCLjgljkZ33bohXc84O097Ap1eH9aOFoQC2utrGBoUc+uz4CEPJnDGH2cqIk5Wynv8vk+AC+HiZzTGpjj4W8mv4k71jK1Zx/80i3cuLPnqsIksKepor6cZrqfsUvdxBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058623; c=relaxed/simple;
	bh=uhvhiVp19ZnmmaqA5XO2XNQje8OD1SKmOKy953nKHyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ9NvmHzUlbex/LBcSf3GmrWljY2Yx1w593xCzvrzazwXjcHbkev5sgPprXJoQZEyYCF5y2CQ3aS3Gei/PNQWP85ZufUSDHKvDlwm1obz/5wKRoacpAVFiNte3yumsUQ+yY1FczQnICbjRgeLKLPSkYgNMcuOniizj72QkkObJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=WNrCsV2q; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="WNrCsV2q"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Xa5PsVwc3l0ATXa5Uszqw8; Sat, 27 Jul 2024 05:35:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1722058525;
	bh=uhvhiVp19ZnmmaqA5XO2XNQje8OD1SKmOKy953nKHyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WNrCsV2qk24n4MZu/5uYNlW3t4qfD3Gu45HNp36vEhzb2dQI7A4gGGK8dFtBwFSKe
	 UfOUmVXSO4QIiaDjT96pRBpoIBdihCqS9AGJvpHGbE5OgoFmfQKm7jeG5RYDuRs9wn
	 wWlKduQuFN1xAEwEaRLuwdfxkVdrg5u7uNMr8kTkVx45MLynOB7B+rDyPgfas88iuX
	 XKkNESoMrxP6HSh0bVsR1SSODeCDqjG85r2vHShZomHPYSHZIv82P8PzTtv2bmv0X4
	 NSAErsgf7ucFxdE6NwUsQpboo8SVK+cCxlV2aPvB7GnGUdH3durfX1E6MIy+Nk/71I
	 BP5sHG4COTAwg==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=b6u04MGx c=1 sm=1 tr=0 ts=66a4871d
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=1bBlrEcKPFs_eYj-LMwA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/5] t4034: fix use of one-shot variable assignment with shell function
Date: Sat, 27 Jul 2024 01:35:06 -0400
Message-ID: <20240727053509.34339-3-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727053509.34339-1-ericsunshine@charter.net>
References: <20240726081522.28015-1-ericsunshine@charter.net>
 <20240727053509.34339-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDQ4lbQ+rhVLcEemJah5/f2ue7BEFdlFOM4YzRBxrwU87UvUbD1wgqXH1m5WpSOqPj5YK/5iusS/QmsFUvcjNc2JCkE304Ox7tD4YGl8FDhab4FhYcOs
 tnKhBK0/tkfCIr3eelAnmaH8rA0kH5YOTOtsp55RLHbOc3cuEDJHWCNzx7AiZ993GEIw03OObi8ZdPFEf+d2+1ejXjvRwDkWZ31+KZd9PKzCsXluRWAuhQ6r
 WzVg16KYhHnKzMMfJCmTWSvQyA3M9mkF4L7u5OOoQ+7Iqt/FSI1h2DqDrzNSLNW9x2raoCrGV7j7jcn9mIfTXPBhl6AU+LAFFEc7SNgsHRM5qpV0oOy9o5id
 ZWcT2jJB

From: Eric Sunshine <sunshine@sunshineco.com>

The behavior of a one-shot environment variable assignment of the form
"VAR=val cmd" is unspecified according to POSIX when "cmd" is a shell
function. Indeed the behavior differs between shell implementations and
even different versions of the same shell, thus should be avoided.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4034-diff-words.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..4dcd7e9925 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -70,7 +70,7 @@ test_language_driver () {
 		word_diff --color-words
 	'
 	test_expect_success "diff driver '$lang' in Islandic" '
-		LANG=is_IS.UTF-8 LANGUAGE=is LC_ALL="$is_IS_locale" \
+		test_env LANG=is_IS.UTF-8 LANGUAGE=is LC_ALL="$is_IS_locale" \
 		word_diff --color-words
 	'
 }
-- 
2.45.2

