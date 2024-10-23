Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C82747B
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644370; cv=none; b=mlQUNeXlOg4iKShInL/9H7JzzTQTWaOWmGDYqyr2b3TBkwFNNe/G2nO8sOnz/Kk1qp1D3xoQtmBMvx3jUW42WMQqXE0AepsU0u/8JlP2w8H/WClUx6Wo5sHh8Q5kP6QRdhe7BbU3pp/Yd+9u9lOeRZVOzVbK7zt6V9UPp4nI7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644370; c=relaxed/simple;
	bh=WJyRjGsgdCNryK2Q/58Y+LPKhj2ZIP3K64IaoWZQ+zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC3TgbB2HEHmOHFKZF7vGMQLqegc2JlD8qWjW/DAQpZJInq2RiEi4LL/Thec3+x3qPUcRRWgTLhCHxCBGHOWcTZpeCGksKb618eQxwyAfm5CEQ72ga90U4nWskZpTmAnyZXRjIDgbE6VH2OoPn3gay7F7QKlM7jVfuDET2JsAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sqnK6G2X; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sqnK6G2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=WJyRjGsgdCNryK2Q/58Y+LPKhj2ZIP3K64IaoWZQ+zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=sqnK6G2XSt53Oq+X2cdlaWU0KRrx0Vm+PdsaO52sca9IbVtyX2V0Lmtvw4UinlK97
	 FEdrNSRwIxU+7ZDDfkJzi6SI5wDFP2YJdBeDqHS8Yy67kb7rsKzO3K8gMdDcBjTAfP
	 SnOOKhGc4F4eN4ywJUZl2CHLfryyocmpksWKGJyWsLbaYfNoKVR+3rNkPcYBH23bQw
	 k9bHfOFcykaFwXK+MnZq+SsXtX+Idh5mP4/KlehbznEH4wItDJS3at8Ypn7GhBAK05
	 E4FCIVE0WFItQunpqPCdT9ii7nLr7Xv9uLYr6j/kUdZPAMRMeBShNm2Gs+b6355z2Z
	 WyVZsE1XOZnkUIOmbdM5ccAsNJ4An92cCQsHVu52fTGVjjuRSGMCzOHASoKEcTgnao
	 iAO+7oJR4oWMkjGO783Hig5E4VSLGU4jjOmgwbt/LcZAtxpt/AhSFb4DTE/auIflDe
	 XDxGZTyc6BFRW9M+gPPNWvMhc79Kv7IFzdp01I48AuXBlhJJab6
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 976EB200C6;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 12/12] gitweb: make use of s///r
Date: Wed, 23 Oct 2024 00:46:00 +0000
Message-ID: <20241023004600.1645313-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Perl 5.14, released in May 2011, the r modifier was added to the s///
operator to allow it to return the modified string instead of modifying
the string in place. This allows to write nicer, more succinct code in
several cases, so let's do that here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da1486cab2..c4e0008d59 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1188,7 +1188,7 @@ sub evaluate_and_validate_params {
 		if ($search_use_regexp) {
 			$search_regexp = $searchtext;
 			if (!eval { qr/$search_regexp/; 1; }) {
-				(my $error = $@) =~ s/ at \S+ line \d+.*\n?//;
+				my $error = $@ =~ s/ at \S+ line \d+.*\n?//r;
 				die_error(400, "Invalid search regexp '$search_regexp'",
 				          esc_html($error));
 			}
@@ -2700,7 +2700,7 @@ sub git_cmd {
 # Try to avoid using this function wherever possible.
 sub quote_command {
 	return join(' ',
-		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
+		map { my $a = $_ =~ s/(['!])/'\\$1'/gr; "'$a'" } @_ );
 }
 
 # get HEAD ref of given project as hash
