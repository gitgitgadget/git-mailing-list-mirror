Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CD1A255C
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729787; cv=none; b=jucHWqan4fuUvzX8TKsirUDSghnGddTuIsgQz1aAJEh5ceO+myRz9WnZk/4+uM1ooLCLqez+5cp9Bx39onWcSdXlfzNSljggGOU8nf/yzv6BZISb3dXuUVJ6/rCU1hJbI8L2wVP1Y5YeJfsDpSjokTnoyeCfSnGnTdg9DbmNfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729787; c=relaxed/simple;
	bh=6nw145vOf+dcRtLfv7sEgTBlFiQ0CZaBbxc1gyk/bkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYv7/5UtjgFbse/uhYZ+wSAKWl/cK9mHK7/TAsoMz/35UVQsfXL30eua6qiN3pX4XkPM4pflidRT/HdodpJS1y7wA8lzwGoFOE8H5CcbbqoJTdjIzp0pJa/BPhEkDkSZW3pXi9/opSKVpuqCMCEvv9dcS3gt83rED6AtsnwJl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=KmUZvBDS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="KmUZvBDS"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsn1-009c4Y-J2
	for git@vger.kernel.org; Tue, 24 Jun 2025 03:49:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=oUnidrQe82TYPOFJYKz85lbwdhn6PwbqjGtM9RWKnIY=; b=KmUZvBDSuR+gI/W3BBl5Mjd8+r
	6WLud45/1FnBeAAhkW5W9WkNrAh4EEvKeZAAq8qnSizx+DFWaBsuj/7gNOxGqiEynmuLnYx0adZaH
	AeSLgcsKVyysvEp+zfYx49hUwIczFgwjnRa8HzTLcFz5o1vJeyGZkEkTHLub4Ke1b90J2XIL+u6nb
	m9s3V0Zb5EqC2rj7Wz+cxdSEtCCFJ5o+9knStSy1NVoRMAepJBSa/ezp3b+Gyc6f8OTlJdF9zjKT0
	zqbUqLEQTyWSdISEZtHxX0zm2lb4BMRfxNxFciezePBNtvsCNZ/CEpHeV0tF+qiuwPhsd2KxGnYTO
	wGqP773Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsn1-0007fN-9Y
	for git@vger.kernel.org; Tue, 24 Jun 2025 03:49:35 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTsmp-00DjBm-I5; Tue, 24 Jun 2025 03:49:24 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v3 2/3] contrib: warn for invalid netrc file ports in git-credential-netrc
Date: Tue, 24 Jun 2025 10:48:56 +0900
Message-ID: <20250624014857.3748-3-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
References: <20250620041239.27839-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid ports were previously silently dropped; now a warning message
is produced.

Signed-off-by: Maxim Cournoyer <maxim@guixotic.coop>
---
 contrib/credential/netrc/git-credential-netrc.perl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index 514f68d00b..09d77b4f69 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -267,9 +267,14 @@ sub load_netrc {
 		if (!defined $nentry->{machine}) {
 			next;
 		}
-		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
-			$num_port = $nentry->{port};
-			delete $nentry->{port};
+		if (defined $nentry->{port}) {
+			if ($nentry->{port} =~ m/^\d+$/) {
+				$num_port = $nentry->{port};
+				delete $nentry->{port};
+			} else {
+				printf(STDERR "ignoring invalid port `%s' " .
+				       "from netrc file\n", $nentry->{port});
+			}
 		}
 
 		# create the new entry for the credential helper protocol
-- 
2.49.0

