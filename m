Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2276176AA9
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981873; cv=none; b=LHfzGPneQfBc+EkEFoXVf5G3QIOLwR2TpAYxS7dceKjMoRW4MLwB+yIWqpXJAFV+Sam4g0IKBTt0yTEWwU7SxglpA41W8DUn56eGhMxMYRilDocymD4I9j95WvY34eaGuRfjJJ63jjr/OV/umSH5I/0U40ySr0uF5n6sZGEeHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981873; c=relaxed/simple;
	bh=0Jf0WGx6OBntC8VbAFDxwmkndCCqn7i8vhMb5KBdMps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq9M2+xW1p1vWZ8YPiat0OAysdg3lfkEQmjWYHpFZEMuKOYyuJWQWl61UXD8qlwWDf+YCw+AxgAaOQGX5AJBOWwliFdAjPbSxIgjyTaCUBI7xwaA+kC+BR6PVgkL2w+a3e7nG/yDgbFap0iNb9MC7jGsXpiFFQCiK8+JxmE70J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=RLra4Bd8; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="RLra4Bd8"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id XG7MsyipKvFCWXG7ZsRqj9; Fri, 26 Jul 2024 08:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721981774;
	bh=0Jf0WGx6OBntC8VbAFDxwmkndCCqn7i8vhMb5KBdMps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLra4Bd83v+HZ/5qIzfu4SDoYiXyYZPOcNFLKpU4+PytZS/ieoxfRlPu1gbL7UEGU
	 9K2PNvLj8ymHiaxo6K9xJYATPOpjjZJyyPmriIvR2OhIwECJ5gscyYBxsp2YLm+hUL
	 /pGTSZs2x/N2jZPECXj4oz3Fc8js7quDzbCbxtx0+0EVN2xwcOPh4eMWh3LgJ5SqjF
	 UDnJgKnIfei2u/jLVUqw0J4YLHw0IoBtx3FSI3noyvDNw5/wDafsB8LgA4UbS4dk2+
	 1RUpItHdL6eYGmQb15ryBFr5mK8uWW9akdLNx+oPfFyQslz4BWbla09d4VWVruUjH1
	 xvULombT5vPmQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=O+w/vg9W c=1 sm=1 tr=0 ts=66a35b4e
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=1bBlrEcKPFs_eYj-LMwA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] t4034: fix use of one-shot variable assignment with shell function
Date: Fri, 26 Jul 2024 04:15:19 -0400
Message-ID: <20240726081522.28015-3-ericsunshine@charter.net>
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

The behavior of a one-shot environment variable assignment of the form
"VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
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

