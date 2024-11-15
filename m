Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D02E414
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632054; cv=none; b=DC1Bl3xnNuyJfR2jLE9zqJv0RpfVphjIUyjBPIjWL/Xv1aUe4rJ16tEhGEt3thzD3hQoS79NtTuqDzUqfxPqNvyMpTWitfMM45L5lq/gxye45ZSp7FT0ueEeO2TFQXG3X+iYP/KRx0NWVicMN0v3xAnLEdfzubQH9T3WhIYUJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632054; c=relaxed/simple;
	bh=ZZwKzfObMSaf5XCnkiHTerp3aHr7ZBC+r/aNBXUFPgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kksd4nZ+F0ryJRPNkwLiwsa0DPh4uUlN17AxZ+p7Sl8PxalJu7lpXCPNWlAvk1kwFBxbhAUMXUw6FP65miXm7Cgv2qGeZbxwGKiPdSZLPcYCOlQeDjB5XlXEAqi1hqLrVUSegG9X5+mgC4fA/OCZtsNEIOItBlonPKWd/iDo3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kGSslngI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kGSslngI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731632051;
	bh=ZZwKzfObMSaf5XCnkiHTerp3aHr7ZBC+r/aNBXUFPgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=kGSslngI5LvC5KyhI+vsfDGWCWAIShTSfVVxvgVViJEstKTCl+zn0IK7TH0fstu3Z
	 1T3XoVtmotuhJM0uTCBqdRdd/UBgLozufaAlMIIzcon9M8V/bNcIWG3isLbkzQNrJR
	 JMgInUjBnLbDi8c0d0YAOWE5fIL0FVopcYXnOqVoEnXCbhpF/+Kdm/534lA3eXu2hz
	 OyqT2vb7PVgl+Ewtq5MT1srXIInqqRrGWkO6itMlcJ0jSsOZhof8SFM8dQy8wEzhk/
	 FCjMs9q+xGQ47pAEdCjmm0CQKO0yMYUb1hjznqRLP3aHXlvpY0hkMqa1DumAlaG76S
	 tZidiV5Nl8WDa7cpIxvOobaCpeJAKQ/0tPXro14ISr8BDbiiMgGc5sBR6IEXiHY4KT
	 CtGzOKiMBZlhY8D3wieSseHAxg+NKkiUPI2YYQdI6u4xmHooZ1Q1+vXPHTA7VZUIZP
	 VXpTbhd7xv9eY1dWyuvtu0/nYX/2dhjfn+SBS0NXm6n61GTM9Ej
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4639624445;
	Fri, 15 Nov 2024 00:54:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 1/1] Allow cloning from repositories owned by another user
Date: Fri, 15 Nov 2024 00:54:04 +0000
Message-ID: <20241115005404.3747302-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, Git has allowed users to clone from an untrusted
repository, and we have documented that this is safe to do so:

    `upload-pack` tries to avoid any dangerous configuration options or
    hooks from the repository it's serving, making it safe to clone an
    untrusted directory and run commands on the resulting clone.

However, this was broken by f4aa8c8bb1 ("fetch/clone: detect dubious
ownership of local repositories", 2024-04-10) in an attempt to make
things more secure.  That change resulted in a variety of problems when
cloning locally and over SSH, but it did not change the stated security
boundary.  Because the security boundary has not changed, it is safe to
adjust part of the code that patch introduced.

To do that and restore the previous functionality, adjust enter_repo to
take two flags instead of one.

The two bits are

 - ENTER_REPO_STRICT: callers that require exact paths (as opposed
   to allowing known suffixes like ".git", ".git/.git" to be
   omitted) can set this bit.  Corresponds to the "strict" parameter
   that the flags word replaces.

 - ENTER_REPO_ANY_OWNER_OK: callers that are willing to run without
   ownership check can set this bit.

The former is --strict-paths option of "git daemon".  The latter is
set only by upload-pack, which honors the claimed security boundary.

Note that local clones across ownership boundaries require --no-local so
that upload-pack is used.  Document this fact in the manual page and
provide an example.

This patch was based on one written by Junio C Hamano.
---
 Documentation/git-clone.txt   |  9 +++++++++
 builtin/upload-pack.c         |  5 ++++-
 daemon.c                      |  6 ++++--
 path.c                        | 10 ++++++----
 path.h                        | 17 ++++++++++++++++-
 t/t0411-clone-from-partial.sh |  3 ---
 t/t5605-clone-local.sh        | 10 ++++++++++
 7 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7acb4cb176..de8d8f5893 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -63,6 +63,9 @@ symbolic link, the clone will fail. This is a security measure to
 prevent the unintentional copying of files by dereferencing the symbolic
 links.
 +
+This option does not work with repositories owned by other users for security
+reasons, and `--no-local` must be specified for the clone to succeed.
++
 *NOTE*: this operation can race with concurrent modification to the
 source repository, similar to running `cp -r <src> <dst>` while modifying
 _<src>_.
@@ -384,6 +387,12 @@ $ cd my-linux
 $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
 
+* Clone a local repository from a different user:
++
+------------
+$ git clone --no-local /home/otheruser/proj.git /pub/scm/proj.git
+------------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 3b6c83fbce..dd63d6eadf 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -39,6 +39,7 @@ int cmd_upload_pack(int argc,
 			    N_("interrupt transfer after <n> seconds of inactivity")),
 		OPT_END()
 	};
+	unsigned enter_repo_flags = ENTER_REPO_ANY_OWNER_OK;
 
 	packet_trace_identity("upload-pack");
 	disable_replace_refs();
@@ -54,7 +55,9 @@ int cmd_upload_pack(int argc,
 
 	dir = argv[0];
 
-	if (!enter_repo(dir, strict))
+	if (strict)
+		enter_repo_flags |= ENTER_REPO_STRICT;
+	if (!enter_repo(dir, enter_repo_flags))
 		die("'%s' does not appear to be a git repository", dir);
 
 	switch (determine_protocol_version_server()) {
diff --git a/daemon.c b/daemon.c
index a40e435c63..756c3f0b02 100644
--- a/daemon.c
+++ b/daemon.c
@@ -152,6 +152,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	size_t rlen;
 	const char *path;
 	const char *dir;
+	unsigned enter_repo_flags;
 
 	dir = directory;
 
@@ -242,14 +243,15 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		dir = rpath;
 	}
 
-	path = enter_repo(dir, strict_paths);
+	enter_repo_flags = strict_paths ? ENTER_REPO_STRICT : 0;
+	path = enter_repo(dir, enter_repo_flags);
 	if (!path && base_path && base_path_relaxed) {
 		/*
 		 * if we fail and base_path_relaxed is enabled, try without
 		 * prefixing the base path
 		 */
 		dir = directory;
-		path = enter_repo(dir, strict_paths);
+		path = enter_repo(dir, enter_repo_flags);
 	}
 
 	if (!path) {
diff --git a/path.c b/path.c
index 93491bab14..4dcf3c8d40 100644
--- a/path.c
+++ b/path.c
@@ -684,7 +684,7 @@ char *interpolate_path(const char *path, int real_home)
  * links.  User relative paths are also returned as they are given,
  * except DWIM suffixing.
  */
-const char *enter_repo(const char *path, int strict)
+const char *enter_repo(const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
 	static struct strbuf used_path = STRBUF_INIT;
@@ -692,7 +692,7 @@ const char *enter_repo(const char *path, int strict)
 	if (!path)
 		return NULL;
 
-	if (!strict) {
+	if (!(flags & ENTER_REPO_STRICT)) {
 		static const char *suffix[] = {
 			"/.git", "", ".git/.git", ".git", NULL,
 		};
@@ -736,7 +736,8 @@ const char *enter_repo(const char *path, int strict)
 		if (!suffix[i])
 			return NULL;
 		gitfile = read_gitfile(used_path.buf);
-		die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
+		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
+			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
 		if (gitfile) {
 			strbuf_reset(&used_path);
 			strbuf_addstr(&used_path, gitfile);
@@ -747,7 +748,8 @@ const char *enter_repo(const char *path, int strict)
 	}
 	else {
 		const char *gitfile = read_gitfile(path);
-		die_upon_dubious_ownership(gitfile, NULL, path);
+		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
+			die_upon_dubious_ownership(gitfile, NULL, path);
 		if (gitfile)
 			path = gitfile;
 		if (chdir(path))
diff --git a/path.h b/path.h
index e91d19fff6..5f6c85e5f8 100644
--- a/path.h
+++ b/path.h
@@ -156,7 +156,22 @@ int calc_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
 
 char *interpolate_path(const char *path, int real_home);
-const char *enter_repo(const char *path, int strict);
+
+/* The bits are as follows:
+ *
+ * - ENTER_REPO_STRICT: callers that require exact paths (as opposed
+ *   to allowing known suffixes like ".git", ".git/.git" to be
+ *   omitted) can set this bit.
+ *
+ * - ENTER_REPO_ANY_OWNER_OK: callers that are willing to run without
+ *   ownership check can set this bit.
+ */
+enum {
+	ENTER_REPO_STRICT = (1<<0),
+	ENTER_REPO_ANY_OWNER_OK = (1<<1),
+};
+
+const char *enter_repo(const char *path, unsigned flags);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index 932bf2067d..2aff6261e4 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -29,7 +29,6 @@ test_expect_success 'local clone must not fetch from promisor remote and execute
 	test_must_fail git clone \
 		--upload-pack="GIT_TEST_ASSUME_DIFFERENT_OWNER=true git-upload-pack" \
 		evil clone1 2>err &&
-	test_grep "detected dubious ownership" err &&
 	test_grep ! "fake-upload-pack running" err &&
 	test_path_is_missing script-executed
 '
@@ -39,7 +38,6 @@ test_expect_success 'clone from file://... must not fetch from promisor remote a
 	test_must_fail git clone \
 		--upload-pack="GIT_TEST_ASSUME_DIFFERENT_OWNER=true git-upload-pack" \
 		"file://$(pwd)/evil" clone2 2>err &&
-	test_grep "detected dubious ownership" err &&
 	test_grep ! "fake-upload-pack running" err &&
 	test_path_is_missing script-executed
 '
@@ -49,7 +47,6 @@ test_expect_success 'fetch from file://... must not fetch from promisor remote a
 	test_must_fail git fetch \
 		--upload-pack="GIT_TEST_ASSUME_DIFFERENT_OWNER=true git-upload-pack" \
 		"file://$(pwd)/evil" 2>err &&
-	test_grep "detected dubious ownership" err &&
 	test_grep ! "fake-upload-pack running" err &&
 	test_path_is_missing script-executed
 '
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index d9a320abd2..286099390c 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -154,6 +154,16 @@ test_expect_success 'cloning a local path with --no-local does not hardlink' '
 	! repo_is_hardlinked force-nonlocal
 '
 
+test_expect_success 'cloning a local path with --no-local from a different user succeeds' '
+	git clone --upload-pack="GIT_TEST_ASSUME_DIFFERENT_OWNER=true git-upload-pack" \
+		--no-local a nonlocal-otheruser 2>err &&
+	! repo_is_hardlinked nonlocal-otheruser &&
+	# Verify that this is a git repository.
+	git -C nonlocal-otheruser rev-parse --show-toplevel &&
+	! test_grep "detected dubious ownership" err
+
+'
+
 test_expect_success 'cloning locally respects "-u" for fetching refs' '
 	test_must_fail git clone --bare -u false a should_not_work.git
 '
