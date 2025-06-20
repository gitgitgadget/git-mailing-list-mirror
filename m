Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57615A8
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382397; cv=none; b=nZ2jLkt/Hz7LrzSPJXNxhnihc6j6fUBljshVMtn6cVAWbYyi33zEOVsbl+R5bvt39RSxpzCMt9ZrrMgtr6KkTAY/q5nz+Mz0P1juZJDJAogh2aNBSc2tqwrDzmWygc4/7r04GcKXa7gJHYXXofWcIxjSKts+1FkSyccu1f11U8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382397; c=relaxed/simple;
	bh=eofmkwneUKsCe6slVGo1J5Gs+NdE5bVH9AZHbb8yaw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv4UG07Q99dzizzKxmPj3bHBoSxff5KVx3QvCc9t6OdpXy0ZXFFsKLti/p9O9j5Dh36r8Dxr4WcDe9VponAhQLUlM1nxQIQTuknItU+IW4i71rjSpojzn5bFEoR3RUgrJ+u/vZ28NtdD+lPHbPl8RfNieplmReyMKIM48m1Rp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Zmnat5Ah; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Zmnat5Ah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382394;
	bh=eofmkwneUKsCe6slVGo1J5Gs+NdE5bVH9AZHbb8yaw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Zmnat5AhYSX86PxRkmWZOGuHRV4hktPBt+Wez1MBqHn/t2+eE6Xa0w6qqwWuQpRU1
	 HzpSkGz1AA2JQhXMOUj3s3OXx91I62U05oap1dVuulfgJSVn74hhwlVmyTsOG7Iypp
	 4XDuL8rn3507Jd5jXM6qRipKGLvQpG/Vufe1RwYKbGHeeK5Xf/b/T4yMpv7luUmQ3Y
	 KQf7jHHnq93s2tec2YMDlwp3JV2xb3dmVioV+kjE2zdXblLaf/P70rM+aenF07OAYH
	 Zant0o15z7X4H5LXTebY5Z8t3bytBjM7TX05Hxv1Q2lp1CRXXNJpirSceoEgadffBt
	 ItvA2SVzYcUZyrf5wxAI2jwoxsLZQPyWv/AqjBiMhlYhg0COFIzgmwpwnEvl71fjYC
	 HRwQPaBhF+hLOnsFyZqROCkExwKgouSEvlpWYI+KeMxt83uY9iAJJlVmEGp40ayDBM
	 zuL24pb8ePOzXM5P74mONOrgbu38kkdCndYqGrVuWvUtYKQ5iJ4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CB82920194;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 03/10] builtin: use default hash when outside a repository
Date: Fri, 20 Jun 2025 01:19:35 +0000
Message-ID: <20250620011943.586596-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have some commands that can operate inside or outside a repository.
If we're operating outside a repository, we clearly cannot use the
repository's hash algorithm as a default since it doesn't exist, so
instead, let's pick the default instead of specifically SHA-1.  Right
now this results in no functional change since the default is SHA-1, but
that may change in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/apply.c       | 2 +-
 builtin/diff.c        | 2 +-
 builtin/hash-object.c | 2 +-
 builtin/index-pack.c  | 2 +-
 builtin/ls-remote.c   | 2 +-
 builtin/patch-id.c    | 2 +-
 builtin/shortlog.c    | 2 +-
 builtin/show-index.c  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a1e20c593d..d642a40251 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -29,7 +29,7 @@ int cmd_apply(int argc,
 	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
 	 */
 	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	argc = apply_parse_options(argc, argv,
 				   &state, &force_apply, &options,
diff --git a/builtin/diff.c b/builtin/diff.c
index c6231edce4..eebffe36cc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -483,7 +483,7 @@ int cmd_diff(int argc,
 	 * configurable via a command line option.
 	 */
 	if (nongit)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 6a99ec250d..213a302e05 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -104,7 +104,7 @@ int cmd_hash_object(int argc,
 		prefix = setup_git_directory_gently(&nongit);
 
 	if (nongit && !the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	if (vpath && prefix) {
 		vpath_free = prefix_filename(prefix, vpath);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bb7925bd29..352ce7f88a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2034,7 +2034,7 @@ int cmd_index_pack(int argc,
 	 * choice but to guess the object hash.
 	 */
 	if (!the_repository->hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
 	if (rev_index) {
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 01a4d4daa1..df09000b30 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -112,7 +112,7 @@ int cmd_ls_remote(int argc,
 	 * depending on what object hash the remote uses.
 	 */
 	if (!the_repository->hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	packet_trace_identity("ls-remote");
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index cdef2ec10a..26f04b0335 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -254,7 +254,7 @@ int cmd_patch_id(int argc,
 	 * the code that computes patch IDs to always use SHA1.
 	 */
 	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	generate_id_list(opts ? opts > 1 : config.stable,
 			 opts ? opts == 3 : config.verbatim);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index fe15e11497..60adc5e7a5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -419,7 +419,7 @@ int cmd_shortlog(int argc,
 	 * git/nongit so that we do not have to do this.
 	 */
 	if (nongit && !the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 9d4ecf5e7b..2c3e2940ce 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -47,7 +47,7 @@ int cmd_show_index(int argc,
 	 *       the index file passed in and use that instead.
 	 */
 	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
 
 	hashsz = the_hash_algo->rawsz;
 
