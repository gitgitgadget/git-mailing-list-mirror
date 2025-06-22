Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4711F2361
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750605968; cv=none; b=TqLxpbNYYdYi/gmTgNAsJm2OnYJu6wg05SthR23DHGZOsmo/LONoINmzPGcRz/Z8ZesATbfLa6wGD/KMiuONh2BjRs+CdO6yviDObbui7j/8Nv7I9feyqs1/n0HyjxFvpk0l+COeElGGNeCMCzOvkBJUSUUqHSL2gbSfOA5Gv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750605968; c=relaxed/simple;
	bh=6nw145vOf+dcRtLfv7sEgTBlFiQ0CZaBbxc1gyk/bkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+XtdEN3i02Rj2dgzh9EjQ9Lhkw8nsNWYAGilkAtdqLOW+9bjoAVIzqSkCx4JMud+U/TntFFTF0QOiU/VHKJsJJg5A3SoACUHPrS/oVycnog21CzO4AmIqEZHD1bycPfl0ZDBIPtYErZ3zUMeL3RuopfM7iyU9p6dthR8CXqYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=IiR+fwJm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="IiR+fwJm"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZv-005c1o-S8
	for git@vger.kernel.org; Sun, 22 Jun 2025 17:25:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=oUnidrQe82TYPOFJYKz85lbwdhn6PwbqjGtM9RWKnIY=; b=IiR+fwJmBd74AY2WS41IS6dG3N
	Zh05qCgW6ceh3KP6Y8jRdDr91ptJzn/DHsvbLf/+Bwc5Vm78ocmEmJOMpnjKvVjyjCmlFkH2UBfNS
	XKJBCd+J9JsB8k0msjm3VuQHJd0/IO7ur2U/Ni89iRnwKtNmbGhZ9L3oEgOxvJnWXMg6VwQA6cHnR
	yPmiA4ZPcrUffV50J8dq4rBHDnSiSBbI6x8lKKiiJxNGeRXnCftm+waNZHLWHwh66v2Lx811Sv87H
	P+7XifJFVopNWQOAxzXCygolTgpYwy7InS9QRRxHm4B/3DrXL660WbpFuXBXQtXzQDO31V8aOeyP4
	eR3CfRvg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZv-0000TY-Jx
	for git@vger.kernel.org; Sun, 22 Jun 2025 17:25:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTMZm-002aWd-E8; Sun, 22 Jun 2025 17:25:47 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH v2 2/3] contrib: warn for invalid netrc file ports in git-credential-netrc
Date: Mon, 23 Jun 2025 00:25:34 +0900
Message-ID: <20250622152535.11837-3-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5dea3a8a86
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

