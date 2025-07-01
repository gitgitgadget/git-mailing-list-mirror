Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD623E352
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404967; cv=none; b=hu1tAWc2AYT8iq6Cg8GytN9AJGqlOl/izkPo1dMbwJT6Bhp1UCyfHPV+8QegjnAjq0icbgYEgNVaod9F1YbNciw17D2wEz6TPXGgPnMJHERQbS857wkh4QqEfX3alWJcS1hLu2GuiNkdARtqYuUHH6280GPppY/+PmDOARk2uIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404967; c=relaxed/simple;
	bh=Ckv+cQIJhpHdUOCyanZo0Xn4vPJBY78tqJFOmFOZP98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6l51X6+Xct8bLoMjW/CLB8JL3I6Pe+Y7elvJurLt5N9si3jFhTc0iA9vGsUfmSse9Lrb55n+ypVtGy7J2NcD+uJkb+rW9RC35Isz82B0O3CKnmcj9FQ4vmfTs48QSq+WAEhRoD+KFB7HIh0foN+xQzhDs09tkO+7zDzvU1eqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ltsy71OQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ltsy71OQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=Ckv+cQIJhpHdUOCyanZo0Xn4vPJBY78tqJFOmFOZP98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ltsy71OQlSkHR+CP4A+OS/YU58THcJQMLkAPGQvUWavyupqZb8rNXnwjKy2R6+CDT
	 aiZhkRMiWOW+w6DAryJBnsJPWLRTU2jRCwAqFgOCgphhcJc7Ifz+fyYvi/UeGEniic
	 F7F4ef/au4B0FIqZfy6InU39L7e2ETMwBkblUAcbRNdAKAbO1G7G6Va19VOpcLQJwE
	 58iowMWhgq/iI7Lq1m9bphKncfe0ACCVaBQQp4MAtVPPsu659KE1rqceWVCX/oq+PG
	 urIvEGdEjtFeymphQ5UcAFzRGd+DyAeubea9UD0jck/SyTK9gA4cZi0DKaMFMXD2RR
	 Ph9gxMweMGUGKsJQcCdqRu2HeE/N2cAPDhYKzZsm6e8QHlMHtNg4PS4vahi5jSgKb3
	 Npk35Hkbo0Lp6niS9GyRBkdI6XFyXTGyEJQWsN8+fwjNCVvpPkjfJBoddizjsoDAnL
	 jjUrlJw0hmWGVPPfCELeYTpwvEvrua+0kJQJGyfaILArG3QVlST
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6182D2019A;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 06/11] t: default to compile-time default hash if not set
Date: Tue,  1 Jul 2025 21:22:32 +0000
Message-ID: <20250701212237.766774-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, the default compile-time hash is SHA-1.  However, in the
future, this might change and it would be helpful to gracefully handle
this case in our testsuite.

To avoid making these assumptions, let's introduce a variable that
contains the built-in default hash and use it in our setup code as the
fallback value if no hash was explicitly set.  For now, this is always
SHA-1, but in a future commit, we'll allow adjusting this and the
variable will be more useful.

To allow us to make our tests more robust, allow test_oid to take the
--hash=builtin option to specify this hash, whatever it is.

Additionally, add a DEFAULT_HASH_ALGORITHM prerequisite to check for the
compile-time hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 5 ++++-
 t/test-lib.sh           | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bee4a2ca34..6ec95ea51f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1695,7 +1695,7 @@ test_set_hash () {
 
 # Detect the hash algorithm in use.
 test_detect_hash () {
-	case "$GIT_TEST_DEFAULT_HASH" in
+	case "${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}" in
 	"sha256")
 	    test_hash_algo=sha256
 	    test_compat_hash_algo=sha1
@@ -1767,6 +1767,9 @@ test_oid () {
 	--hash=compat)
 		algo="$test_compat_hash_algo" &&
 		shift;;
+	--hash=builtin)
+		algo="$GIT_TEST_BUILTIN_HASH" &&
+		shift;;
 	--hash=*)
 		algo="${1#--hash=}" &&
 		shift;;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 51370a201c..ef3759ec80 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -536,7 +536,8 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
-GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
+GIT_TEST_BUILTIN_HASH=sha1
+GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
 export GIT_DEFAULT_REF_FORMAT
@@ -1908,6 +1909,10 @@ test_lazy_prereq SHA1 '
 	esac
 '
 
+test_lazy_prereq DEFAULT_HASH_ALGORITHM '
+	test "$GIT_TEST_BUILTIN_HASH" = "$GIT_DEFAULT_HASH"
+'
+
 test_lazy_prereq DEFAULT_REPO_FORMAT '
 	test_have_prereq SHA1,REFFILES
 '
