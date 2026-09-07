Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A6525A90
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811206; cv=none; b=asQspFygf5c+LfQpHjHAR/TlKLG2JrDYXSfgkHT81MXclnvVE/8hfpSCNL82y5cznfpxuJ6ZfJj0fMIh5SBtgzli5VLDutpceSJybTO/axqcXvTuCML0KeDwa0amg5xv4ibVJOpEd51bFYrz+OjP/y7lmqizGPEhRbxyRWxxy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811206; c=relaxed/simple;
	bh=UOOtxNUDDjMQf2JNzWrQhgxbeoOU0OhWUMaCHx7EsXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWCr4DvSkE3vpVH9fgeFsRct3aeI5MHXuWHQdJA/k5vD2wJMVMnjPXKSdRK2EJn6QiMhjNe5Yb/TEWsSDe01So/30fXLnoTFGip3OVaMNW7dnp9sdEvBvBhe0OeV/nOVDU6HopIQv6F/relsdsfcKPv1BIJt9G0rEz5wrVF4Xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xjC3wQ+L; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xjC3wQ+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788811198;
	bh=UOOtxNUDDjMQf2JNzWrQhgxbeoOU0OhWUMaCHx7EsXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=xjC3wQ+LM40LyIPoSl6wxV8tsQERbJSIdtwoJiDKgEc1nQelspRys7CrMWfU4xLYZ
	 c8+ds6OCWA+AT65SLMQO2EN+h5/+TOMnFouwnI5b6DVI6oLDpeIkAxuKOYE4qFOpFo
	 5mE8WnjE6ZEoV1nZGwYt3z9FJz0xIyM3FLIysupspimnc9xNVmBrCpP97D+78+wIPH
	 20gmeGyt0ATT7xZT4MSOZ+0XSvcEce76//klBcDONF7lyuPMugWjm9lkueRp1GVXzH
	 QgqYCruxaM7jeGnat263KncUnA06l0lAUaOwh1dAOVtehxPo+kQQn9Z10zqlMA/0gM
	 cG47yzpr9nQL+BoOXjuAbWtoTNMd3Urry3sycKrvzw6byYjhKDoj09c/iFsTMhm3qb
	 LdNfdVLeZFwF8APGDoi2Cigh2jntJN04hqPg5RpPF64a1Ru7e4ycU/fj3vRnxiV/Jh
	 oEE03Z1hcgWBiieQloeeAp20f9rmoqGfWift8esivnVy6LnJkh9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 54F51231F2;
	Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 7/7] hex: allow only lowercase object IDs in breaking changes mode
Date: Mon,  7 Sep 2026 19:59:40 +0000
Message-ID: <20260907195941.1024289-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260907195941.1024289-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git has historically allowed either lowercase or uppercase hex for
object IDs, but it has always emitted only lowercase.  This has caused
people to expect only lowercase and not handle uppercase.

As an example, Git's own example hooks look for "[0-9a-f]" in several
places, but there are many other Git-adjacent pieces of software,
including Gitolite, which make the assumption that object IDs are always
lowercase.  This is not to criticize the authors of these projects, but
rather to point out how common this assumption is.  In fact, it's so
common that we had only one test in our codebase that failed when we
reject uppercase object IDs.

More critically, it leads people to make security-based assumptions that
an object ID either does not contain uppercase characters or that an
object ID can be expressed uniquely in hex form, neither of which are
currently true.  Git itself normally uses binary object IDs, which
avoids many of these problems, but most other projects deal primarily in
hex object IDs, so they are more affected.

In preparation for Git 3.0, only allow lowercase hex object IDs in
breaking changes mode and document this as well.  Add a new test to
verify we reject new uppercase object IDs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/BreakingChanges.adoc | 5 +++++
 hex-ll.h                           | 4 ++++
 t/t1503-rev-parse-verify.sh        | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359..dbc46d14e3 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -171,6 +171,11 @@ JGit, libgit2 and Gitoxide need to support it.
   matches the default branch name used in new repositories by many of the
   big Git forges.
 
+* Git will accept hex object IDs only in lowercase. The fact that Git has
+	historically allowed uppercase characters in hex object IDs has been the
+	source of a variety of bugs and security problems in software using Git. We
+	don't expect most users to notice any change.
+
 * Git will require Rust as a mandatory part of the build process. While Git
   already started to adopt Rust in Git 2.49, all parts written in Rust are
   optional for the time being. This includes:
diff --git a/hex-ll.h b/hex-ll.h
index 9da76f17e8..2f9c8d7c25 100644
--- a/hex-ll.h
+++ b/hex-ll.h
@@ -6,7 +6,11 @@ enum hexkind {
 	HEX_KIND_LOWER = 1,
 };
 
+#ifdef WITH_BREAKING_CHANGES
+#define HEX_KIND_OID HEX_KIND_LOWER
+#else
 #define HEX_KIND_OID HEX_KIND_MIXED
+#endif
 
 extern const signed char hexval_table[256];
 extern const signed char hexval_lc_table[256];
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 87638a4a2c..f07b45de5a 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -60,6 +60,11 @@ test_expect_success 'works with one good rev' '
 	test "$rev_head" = "$HASH4"
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'rejects uppercase revs' '
+	UC_HASH=$(echo "$HASH1" | tr a-f A-F) &&
+	test_must_fail git rev-parse --verify "$UC_HASH"
+'
+
 test_expect_success 'fails with any bad rev or many good revs' '
 	test_must_fail git rev-parse --verify 2>error &&
 	test_grep "single revision" error &&
