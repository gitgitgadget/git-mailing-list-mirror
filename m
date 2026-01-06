Received: from mail-108-mta211.mxroute.com (mail-108-mta211.mxroute.com [136.175.108.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599131577B
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692540; cv=none; b=pSNQPPIsdIozKcxNuR9fyGfIykYJzKbicgKGFWkefpR1DW7TcuQCztAHkGylJ5DcIAiQZi72ZXos7SDowZhFLnMaCdqODxqA22h6+H46MTcWTW22KDDQSTwrSy+jEnWrFoT/Gpnt0k40z0z6Z9X7MC+u6kjwDrnib6x2P7VyTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692540; c=relaxed/simple;
	bh=LElEbcswbDG5Y6miNBH3vjTGAKQwq6I8J6RBdY7dFi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nil9LIY+poOm2eMftWOrrSCGeWQArs3FF3BC1zB0nKbzwN+XijK2K7e089x9YXvrLpjsli27zBH3Hdi9KL2mSorHP95aHurL5MD/FRShpQ+Fo08w2Szh7LFWReVRg0AdS69jDHJ3CrLFP25W0z4zpmW/nh9CciJnU6+H2G3samQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=j4cQnsAA; arc=none smtp.client-ip=136.175.108.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="j4cQnsAA"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta211.mxroute.com (ZoneMTA) with ESMTPSA id 19b92aaca700004eea.002
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 06 Jan 2026 09:37:05 +0000
X-Zone-Loop: a18718d2bd18bf49933e9d9108e860b94e317e007360
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=3K47Ymsqi9r005iGIZEY5Vy0Iv7CczFCeBqnbz7XcbE=; b=j4cQnsAAFcPSDH43We1JZ4+B77
	T6k/Ld/ic+xqEuHMj7HbCzFZq1Ui2QJHlIqKIgXqw085fFOLhMuqwvFKptEFXBFiBJabjI5I13x0C
	g+Izayu0ZSAJnIQ14o7r4T59xLPhM1a4jtQ6nRJuTYBSoA0ZyVPgREp63eIqCoh0ImCyhuke37HAC
	BHNAPB639vtNQ4V8sWUrURm7uCGZRLtNLS9CHMzEX5+jsZDsoaZNl0AS4FRyMb2umPRJcc/E0hIgE
	hkc2+qpXvpxczHKggvWvZujh/yNtUTtb8iMLLcCnR3h0g2i95m5Nm82+VmJzpZt/EGlIIhP9hDGf9
	DbmfmE/A==;
From: Ashlesh Gawande <git@ashlesh.me>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	Ashlesh Gawande <git@ashlesh.me>
Subject: [PATCH] t5550: add netrc tests for http 401/403
Date: Tue,  6 Jan 2026 15:04:51 +0530
Message-ID: <20260106093451.748761-1-git@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me

Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
---
Sending netrc test patches as suggested in: https://lore.kernel.org/git/aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net

 t/lib-httpd.sh             |  9 +++++++++
 t/lib-httpd/apache.conf    |  4 ++++
 t/lib-httpd/passwd         |  1 +
 t/t5550-http-fetch-dumb.sh | 25 +++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5091db949b..cdc92b2916 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -325,6 +325,15 @@ set_askpass() {
 	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
 }
 
+set_netrc() {
+	# $HOME=$TRASH_DIRECTORY
+	echo "machine $1 login $2 password $3" > $TRASH_DIRECTORY/.netrc
+}
+
+clear_netrc() {
+	rm "$TRASH_DIRECTORY/.netrc"
+}
+
 expect_askpass() {
 	dest=$HTTPD_DEST${3+/$3}
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index e631ab0eb5..6b8c50a51a 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -238,6 +238,10 @@ SSLEngine On
 	AuthName "git-auth"
 	AuthUserFile passwd
 	Require valid-user
+
+	# return 403 for authenticated user: forbidden-user@host
+	RewriteCond "%{REMOTE_USER}" "^forbidden-user@host"
+	RewriteRule ^ - [F]
 </Location>
 
 <LocationMatch "^/auth-push/.*/git-receive-pack$">
diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
index d9c122f348..3bab7b6423 100644
--- a/t/lib-httpd/passwd
+++ b/t/lib-httpd/passwd
@@ -1 +1,2 @@
 user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
+forbidden-user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ed0ad66fad..e002c7357d 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -102,6 +102,31 @@ test_expect_success 'cloning password-protected repository can fail' '
 	expect_askpass both wrong
 '
 
+test_expect_success 'using credentials from netrc to clone successfully' '
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@host &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
+	expect_askpass none
+'
+clear_netrc
+
+test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@wrong &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
+	expect_askpass both wrong
+'
+clear_netrc
+
+test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
+	expect_askpass none &&
+	grep "The requested URL returned error: 403" err
+'
+clear_netrc
+
 test_expect_success 'http auth can use user/pass in URL' '
 	set_askpass wrong &&
 	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&

base-commit: e0bfec3dfc356f7d808eb5ee546a54116b794397
-- 
2.43.0

