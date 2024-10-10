Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EB1EABB3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604601; cv=none; b=uiOZ0WtFKI4zdA3wkjusuyCK5RViO6t90ZIfDo+QGjqE/TnIYb40LGssm8CRL5BqkifpSz7VvN7E1XDCgUiR5mHIKFL1aXTA2KSXfXnetGLH4NXynd3g2hsWfJjFPp1qx9+pSKZf0mVeNLrIhUKLfdB9Dz8Z08Wswrsec73OXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604601; c=relaxed/simple;
	bh=vZ4m+6+T6wBo/Q/VL8ZZwKE0cBp/C/cfDgA2El8hRjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFj9t/h9AUyxGHXRZPSI87JmV6iERfwrVcOad5ELpG25Dr9usTAwBOIcKQuk9JmpU8bGvn4P/7W4RQTqaxgr3cjx7yjTuaJ6yh2KfSOo0Db08CcuNC/xIjI6Z2CufxZvPp3Qim3HgJq9eRnJuqHP0iePWvLErlNTZawCbgZKGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=R7veVgtO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="R7veVgtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=vZ4m+6+T6wBo/Q/VL8ZZwKE0cBp/C/cfDgA2El8hRjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=R7veVgtOi6BFut9DLrzUJ/q2td8434avEo0iKyUoPxdX+PNT006ySltPznSoBjhHl
	 3qHyTcWevsICI5XccBw5BdlCnCa/r7/ZE33pOtXbBQ4n8iRI8DVCQQvnFl6YHHxBHZ
	 LTQMGarYGt+jQPHvnRKLsCGLRrd336p62Codf9zy/QMXhUKYAcNFSUWJYLtZuwxj7a
	 dwKyv4+n8smYghofsuUW//Z9iFDdAW7i3kRG0fXC1WJvYwopL5Tkzs5lr64YTrM2iS
	 09mJ1R3QUDiKB38V4jFcfPdMwcEwyJKpdXiGvHDUMvsZQwORHA59B0T5m9YI7d85VG
	 ZBrHtYPASjb76/5gcc8tBgQIirQAxlK4qMCSSy96BceBXyuVwKSufKzmXroHXZM+fQ
	 +S5ZyzxxqdtKoe3dIKBxyBCtAIHona/mK3OSuDnDnxrisSqKiZbUCP4WGKXkOV9V94
	 JuoNBj1fsgPFzUesxw63gI6UFCbEKa+7n7OjX+E5o9j7cWtSjcV
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 84ADB200C3;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 13/13] gitweb: make use of s///r
Date: Thu, 10 Oct 2024 23:56:21 +0000
Message-ID: <20241010235621.738239-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
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
index c4f92386eb..f0d8fac7ba 100755
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
