Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1125A640
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634135; cv=none; b=J3WJhY6Ck3LlvKMa3gYlfalRLpF5O6aBXic5SFiPahfBPGJhPvSVCfz8PH/f4WIw93c1Mm8aZkg5ZpbtLNJzoBy2ae3mn20oJy+sQWwBpZc7V0VVvMCVHL8FEIev52ACl3lWXc+JafnjTz2/keueQSYYC5csEdnNNyHYbnAFinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634135; c=relaxed/simple;
	bh=sDIUjbq18K7BmnjNivthhj/Ype5h4SH4ZRs1Yw96s3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhHmUPufxsWiHgT9ponuLkJxKc5ldBh9syA2fzlAv10BQLk+6vPk7NDchdsNcVp5dNzZowNefP8dYbxq/AyRG2M5Ha+0AicCT0UI+EBQTWvUrYcAd4FpFU8e65tRQsbw4C6xN1MmGqo7bYYKlDIHCOUnLmYeE8l47wTUE1VRB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RnMN9OYg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RnMN9OYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738633619;
	bh=sDIUjbq18K7BmnjNivthhj/Ype5h4SH4ZRs1Yw96s3Y=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RnMN9OYgwMvMJLHpLEyhNqauBKCVSpGRLW8m5yftlYNUM+uU0NK1Y28e8OFjDUMd8
	 BWWdme01GWGRoKs6aFoEY85jbr3/9Cz7B2bE3a3wPRGFLHogNU1C9Sz9H+LSCOqUS1
	 TtOCtP7Ky7XmSnALQPNLZtotSfC6CAQ6e1aVnqJnl3Ls1FXnLvrq77ngMcaJTVXUKJ
	 y9/19UA+oaC6kCCSIt1m1A0SlA/AHDhLpIEvXr9EywdRU9iqUlK8uF3N3EF6jkfSjx
	 s/LlVsRb0/lSX2PIqNmY40NTk6ODpuRrTNpavSLMrDUq3LYen3drWxFJbdqkbORxE3
	 3+bBQHFgWonOWJFDj/X+HelbCPCwDz3XrWlxqf05wfVvAMO1W/P38mjyDkY4BbAKFi
	 nqlt9eAtrfJJoCu+yDKwekrsCvuukXP2N4NrIGgWPHDgpkwqAg/54O6wBSfnvM2WS2
	 vKthRCeo8TtCY98SlolHl5NSM7mPpsFyWm65pojkQaTvQc6uMJt
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9895220067;
	Tue,  4 Feb 2025 01:46:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] thunderbird-patch-inline: avoid bashism
Date: Tue,  4 Feb 2025 01:46:52 +0000
Message-ID: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of "echo -e" is not portable and not specified by POSIX.  dash
does not support any options except "-n", and so this script will not
work on operating systems which use that as /bin/sh.

Fortunately, the solution is easy: switch to printf(1), which is
specified by POSIX and allows the escape sequences we want to use.  This
will allow the script to work with any POSIX shell.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 contrib/thunderbird-patch-inline/appp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I noticed this in Debian bug 772238[0], while looking for any bug
reports that I might be able to fix.  It was reported in 2014 and has
gone unfixed since then, so possibly this script is seeing relatively
little use on Debian and Ubuntu.

I have not CC'd any of the authors because nobody's touched this in over
9 years and none of those people are still active.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=772238

diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 1053872eea..c55c2caa41 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -31,7 +31,7 @@ BODY=$(sed -e "1,/${SEP}/d" $1)
 CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
 DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
 
-CCS=$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
+CCS=$(printf '%s\n%s' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
 	-e 's/^Signed-off-by: \(.*\)/\1,/gp')
 
 echo "$SUBJECT" > $1
