Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A305266573
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861563; cv=none; b=SZiktmj2GeUYtL2+yvk+uLFp5+Fm6ZmDCq2S90fzch0hAkEKk3woroOUUNKLvHXsvFE3i1wpDfS/OvycpV6c6NZtNp6oDE3AXl2RbH5m/1vwd71mTtHkqYi/tUskKdX3KXOfnRZQa2I4W6jzCtjecBeZJGBCwY9YnVnWdVasDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861563; c=relaxed/simple;
	bh=6nw145vOf+dcRtLfv7sEgTBlFiQ0CZaBbxc1gyk/bkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdkS3u5R9G3rTjx0Gp8o2oykY84xZ6nCKYuQPaXvH1on3l8ggNlKRg4Glybuty3QCvzCJAWcuBSLABEcENTSrYWQzJKuO6Guh61al/vFDCiFsojXTtUJiZlOmG33kCYHZIhYM+ltZvDIqaIni09W8RLaCzoE27QRq24/wYMHcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=bCzozjMG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="bCzozjMG"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4R-00EOxs-2J
	for git@vger.kernel.org; Wed, 25 Jun 2025 16:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=oUnidrQe82TYPOFJYKz85lbwdhn6PwbqjGtM9RWKnIY=; b=bCzozjMG45HBBu0RYi0BLoqwFj
	r6j/IcIAwSFjH5F344frB/rx8Uavd3TjEgPmfgV7WL+h9psP2kkaYG8oyAlRUn7FTSH6GmI1Sdppr
	O17x+wDlAfwUv417J1ttel6Iz9OjO28KJWwZaFp/7UOnpnT35AD9EGklZ8KzAmv12LD1FH+AYa1/g
	9cyIlbX1CumRafBJzlZV2bSc7Ae6c7oyQMKyry1lCqK7sBPtlTHOEolLNiTand+RaNkM7hzQP7H9L
	ezFETgGSAeUOcJ5nzYU5FgiMpJr/pYP7pfoZYNZ0SEVw3ra8s+n+9G3YrEvqMdz+DgJJEptCLieS5
	7cqPM/8Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4P-0008MA-Da
	for git@vger.kernel.org; Wed, 25 Jun 2025 16:25:50 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUR4K-00317J-Sc; Wed, 25 Jun 2025 16:25:45 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v4 2/3] contrib: warn for invalid netrc file ports in git-credential-netrc
Date: Wed, 25 Jun 2025 23:25:10 +0900
Message-ID: <20250625142511.28857-3-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <20250625142511.28857-1-maxim@guixotic.coop>
References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
 <20250625142511.28857-1-maxim@guixotic.coop>
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

