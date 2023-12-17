Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFB44C67
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmmMOgK2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d38bedd799so16939335ad.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702822298; x=1703427098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3JSk+ebwwJtraELeftOiTi17imPn8YPOOJ8LuX0pF4=;
        b=dmmMOgK22hcJrv6WiYRDVwWb3ULXM3n9qmf0SX1Xia4A/l57qdDN23/lHl6GQ+rEMx
         WAuN+8Vr6CrZXBRc09exyKhoJtdV7pBR1C0VP/H9xrojaiLX5Rs9YtS4vVynQGzCnG8X
         CeqvDqO4Oiuuc/d3Lzbvr8AzH1nY1jAyesNVZAs4DAwf5YT7jgjkGt3dv9XGZ7xJ5vHy
         gbzT9M34VXUmwlRXQ2iGi96dDBj0H63N6f393jwCTg1uuqEkob+M6RfJt4Ae3/MlXH6a
         ovuJNGOWM3FPLnqnX4tofBi9omK5sCOWonESHNJop09RKQzSl2bce7IL7d7BEKhkK7Ji
         cNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702822298; x=1703427098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3JSk+ebwwJtraELeftOiTi17imPn8YPOOJ8LuX0pF4=;
        b=rC47XWXLzuKW+cAAygB1Gg9Bz8XUtDK8NTdYlcgFfTASBN4QMV2jMhc082k0J7bVoS
         4NXV72CYs2NxjyL4A954I+W1qqHdzWBE97V7TEvqhb4iL/qOJYnbeevQd2ESZ0Rr2IQk
         F+UyGyhRNi6AsBz6jf+cYOGuRH5+MWx/WCPwb8jGfbCZbX2IyGzW0v4Ini1svWVrd2s6
         U0L3ZUeQnDvuWhuwuJbBcgqj6drMEXeUliNhQjypKyTzvCgY8QWYuLPWwARt/YZR7VVG
         ieZpUFZDmnybxiK3NZ7vAdgJS7yjKctvYl+NX8BzO9DDuaSes2tnZWvFu+heWHcanaAc
         LE9A==
X-Gm-Message-State: AOJu0YwB1p875A5TPnTG8QNybzUE6xISlg8D1gjsfeBjOPbOEbpwW8fI
	A1E3tB5fJvVXFUgeyQs+BnoGfKd8O9Q=
X-Google-Smtp-Source: AGHT+IGe14Z6pN404fatYswgHmmSl+w2Kb79FLV7LdfQ7DUaWYXf3tl9G2/ecYeRoSP3EMyyBufF7w==
X-Received: by 2002:a17:902:cec4:b0:1d0:4cde:6e24 with SMTP id d4-20020a170902cec400b001d04cde6e24mr16720322plg.44.1702822297614;
        Sun, 17 Dec 2023 06:11:37 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0028b005dadb3sm7672045pje.26.2023.12.17.06.11.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:11:37 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/2] t5574: test porcelain output of atomic fetch
Date: Sun, 17 Dec 2023 22:11:33 +0800
Message-Id: <0a6c53de7c8e951bf8f4bc22809df045a4c4a285.1702821462.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com> <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The test case "fetch porcelain output" checks output of the fetch
command. The error output must be empty with the follow assertion:

    test_must_be_empty stderr

But this assertion fails if using atomic fetch. Refactor this test case
to use different fetch options by splitting it into three test cases.

  1. "setup for fetch porcelain output".

  2. "fetch porcelain output": for non-atomic fetch.

  3. "fetch porcelain output (atomic)": for atomic fetch.

Add new command "test_commit ..." in the first test case, so that if we
run these test cases individually (--run=4-6), "git rev-parse HEAD~"
command will work properly. Run the above test cases, we can find that
one test case has a known breakage, as shown below:

    ok 4 - setup for fetch porcelain output
    ok 5 - fetch porcelain output  # TODO known breakage vanished
    not ok 6 - fetch porcelain output (atomic) # TODO known breakage

The failed test case has an error message with only the error prompt but
no message body, as follows:

    'stderr' is not empty, it contains:
    error:

In a later commit, we will fix this issue.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5574-fetch-output.sh | 89 +++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 90e6dcb9a7..b579364c47 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -61,11 +61,10 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
 
-test_expect_success 'fetch porcelain output' '
-	test_when_finished "rm -rf porcelain" &&
-
+test_expect_success 'setup for fetch porcelain output' '
 	# Set up a bunch of references that we can use to demonstrate different
 	# kinds of flag symbols in the output format.
+	test_commit commit-for-porcelain-output &&
 	MAIN_OLD=$(git rev-parse HEAD) &&
 	git branch "fast-forward" &&
 	git branch "deleted-branch" &&
@@ -74,15 +73,10 @@ test_expect_success 'fetch porcelain output' '
 	FORCE_UPDATED_OLD=$(git rev-parse HEAD) &&
 	git checkout main &&
 
-	# Clone and pre-seed the repositories. We fetch references into two
-	# namespaces so that we can test that rejected and force-updated
-	# references are reported properly.
-	refspecs="refs/heads/*:refs/unforced/* +refs/heads/*:refs/forced/*" &&
-	git clone . porcelain &&
-	git -C porcelain fetch origin $refspecs &&
+	# Backup to preseed.git
+	git clone --mirror . preseed.git &&
 
-	# Now that we have set up the client repositories we can change our
-	# local references.
+	# Continue changing our local references.
 	git branch new-branch &&
 	git branch -d deleted-branch &&
 	git checkout fast-forward &&
@@ -91,36 +85,53 @@ test_expect_success 'fetch porcelain output' '
 	git checkout force-updated &&
 	git reset --hard HEAD~ &&
 	test_commit --no-tag force-update-new &&
-	FORCE_UPDATED_NEW=$(git rev-parse HEAD) &&
-
-	cat >expect <<-EOF &&
-	- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
-	- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
-	  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
-	! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
-	* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
-	  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
-	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
-	* $ZERO_OID $MAIN_OLD refs/forced/new-branch
-	  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
-	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
-	* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
-	EOF
-
-	# Execute a dry-run fetch first. We do this to assert that the dry-run
-	# and non-dry-run fetches produces the same output. Execution of the
-	# fetch is expected to fail as we have a rejected reference update.
-	test_must_fail git -C porcelain fetch \
-		--porcelain --dry-run --prune origin $refspecs >actual &&
-	test_cmp expect actual &&
-
-	# And now we perform a non-dry-run fetch.
-	test_must_fail git -C porcelain fetch \
-		--porcelain --prune origin $refspecs >actual 2>stderr &&
-	test_cmp expect actual &&
-	test_must_be_empty stderr
+	FORCE_UPDATED_NEW=$(git rev-parse HEAD)
 '
 
+for opt in "" "--atomic"
+do
+	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
+		test_when_finished "rm -rf porcelain" &&
+
+		# Clone and pre-seed the repositories. We fetch references into two
+		# namespaces so that we can test that rejected and force-updated
+		# references are reported properly.
+		refspecs="refs/heads/*:refs/unforced/* +refs/heads/*:refs/forced/*" &&
+		git clone preseed.git porcelain &&
+		git -C porcelain fetch origin $opt $refspecs &&
+
+		cat >expect <<-EOF &&
+		- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
+		- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
+		! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
+		* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
+		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
+		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
+		EOF
+
+		# Change the URL of the repository to fetch different references.
+		git -C porcelain remote set-url origin .. &&
+
+		# Execute a dry-run fetch first. We do this to assert that the dry-run
+		# and non-dry-run fetches produces the same output. Execution of the
+		# fetch is expected to fail as we have a rejected reference update.
+		test_must_fail git -C porcelain fetch $opt \
+			--porcelain --dry-run --prune origin $refspecs >actual &&
+		test_cmp expect actual &&
+
+		# And now we perform a non-dry-run fetch.
+		test_must_fail git -C porcelain fetch $opt \
+			--porcelain --prune origin $refspecs >actual 2>stderr &&
+		test_cmp expect actual &&
+		test_must_be_empty stderr
+	'
+done
+
 test_expect_success 'fetch porcelain with multiple remotes' '
 	test_when_finished "rm -rf porcelain" &&
 
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

