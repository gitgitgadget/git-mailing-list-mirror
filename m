Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F414B086
	for <git@vger.kernel.org>; Thu, 23 May 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470402; cv=none; b=ur6Qao0b2hr6pfaAMOcHPk+NZUoMz/6Owy3me/DOFT2PT2x1tdoPMECKY47Uv97yU67kmOfSqhBQNYRsdVGOdDjNXjRvWTsoR/PKIcjyzj1SdOddidyK7wGxg7avcpx7fk/+6mXW6PUJ4MdDUtVCGWFCfnwWl+wRpB1Q5wZulOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470402; c=relaxed/simple;
	bh=5nf85aqZ2EtWNT62l5/c4ErMX4Bdmm3IBVFoh5ifI5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bf7mwWrPmENpNy+iSfh+wRerNyvMnctNxOXJSC0NY2YV6sDtXD4Mgn2SRteffi2JNwje2t4ma+U8iHboFiqRkcChC7lkLuIM6yZq4VUt9CQLBMsgDITxn2OyDQ5ROrLNq9hcxskiYbxaf5qmcRQGMX9yL8aLtAa5hYnZG5GE86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=cgQBZbJG; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="cgQBZbJG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xK2FJSjg9+iJ35EaNS2TUR1ax5V8dRDLUdUjxTM29PI=; i=tom@compton.nu;
	t=1716470400; x=1717680000; b=cgQBZbJG13xe/D/UvSDDpjSocvE4GK0KXMEzXeysHlRpd41
	QXVom2ZGb7KneVY2XDkOnScqSJ8r88CAOsOuCiLHjy9DiSTtopZnZXfyN5MNprkbitujmOxtrIKTn
	FbsQWPSBIpl+COruphDfj4KpGJ8KeeX2/P5mmQosCu5HKWgExd4pnwAnf/4UkV8k3CoXER8NFPfdW
	TagLaJEuSxtHlcWqk2CvgZN+hDuRusTIs4ImzucPtkxTcDgCPo51fZLYv5nx1ApJUD/HgTYUMx2Nd
	zWWiNajGk95YaW493MhiGVfL49ZAJxuicEmZN9XFxm0/bZbIQfj0/4SZMl9qRIwQ==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:42536)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sA8MI-00000008Uft-1i4b;
	Thu, 23 May 2024 14:19:54 +0100
Received: from tom by bericote.compton.nu with local (Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sA8MI-00000008Din-14fw;
	Thu, 23 May 2024 14:19:50 +0100
From: Tom Hughes <tom@compton.nu>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	jonathantanmy@google.com,
	Tom Hughes <tom@compton.nu>
Subject: [PATCH] promisor-remote: add promisor.quiet configuration option
Date: Thu, 23 May 2024 14:19:26 +0100
Message-ID: <20240523131926.1959245-1-tom@compton.nu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a configuration optione to allow output from the promisor
fetching objects to be suppressed/

This allows us to stop commands like git blame being swamped
with progress messages and gc notifications from the promisor
when used in a partial clone.

Signed-off-by: Tom Hughes <tom@compton.nu>
---
 Documentation/config.txt          |  2 ++
 Documentation/config/promisor.txt |  3 ++
 promisor-remote.c                 |  3 ++
 t/t0410-partial-clone.sh          | 47 +++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)
 create mode 100644 Documentation/config/promisor.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 70b448b132..6cae835db9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -487,6 +487,8 @@ include::config/pager.txt[]
 
 include::config/pretty.txt[]
 
+include::config/promisor.txt[]
+
 include::config/protocol.txt[]
 
 include::config/pull.txt[]
diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
new file mode 100644
index 0000000000..98c5cb2ec2
--- /dev/null
+++ b/Documentation/config/promisor.txt
@@ -0,0 +1,3 @@
+promisor.quiet::
+	If set to "true" assume `--quiet` when fetching additional
+	objects for a partial clone.
diff --git a/promisor-remote.c b/promisor-remote.c
index b414922c44..2ca7c2ae48 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -23,6 +23,7 @@ static int fetch_objects(struct repository *repo,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
 	FILE *child_in;
+	int quiet;
 
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
 		static int warning_shown;
@@ -41,6 +42,8 @@ static int fetch_objects(struct repository *repo,
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--filter=blob:none", "--stdin", NULL);
+	if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
+		strvec_push(&child.args, "--quiet");
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 88a66f0904..99257c3792 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -3,6 +3,7 @@
 test_description='partial clone'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 # missing promisor objects cause repacks which write bitmaps to fail
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
@@ -689,6 +690,52 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	! grep "[?]$FILE_HASH" out
 '
 
+test_expect_success TTY 'promisor.quiet=false works' '
+	rm -rf server server2 repo &&
+	rm -rf server server3 repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	git hash-object repo/foo.t >blobhash &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo config promisor.quiet "false" &&
+
+	test_terminal git -C repo cat-file -p $(cat blobhash) 2>err &&
+
+	# Ensure that progress messages are written
+	grep "Receiving objects" err
+'
+
+test_expect_success TTY 'promisor.quiet=true works' '
+	rm -rf server server2 repo &&
+	rm -rf server server3 repo &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" repo &&
+	git hash-object repo/foo.t >blobhash &&
+	rm -rf repo/.git/objects/* &&
+
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "origin" &&
+	git -C repo config promisor.quiet "true" &&
+
+	test_terminal git -C repo cat-file -p $(cat blobhash) 2>err &&
+
+	# Ensure that no progress messages are written
+	! grep "Receiving objects" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.45.1

