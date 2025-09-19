Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B421FF26
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244186; cv=none; b=YpEEQ3V5T0JJIWT7UChTo0W89xUVdkhL0pCJH60CVDA2RMtphY4nLDWQdE64RLum++tU21U7X34aRugA2+pGnz/awP3jLlx3XpbUdG7rBFeZE005wAkdubZTDgudcw5WIQGeyQALR1loUv5mSmtiw3GIxA++MgjIPvVKo3BYhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244186; c=relaxed/simple;
	bh=9wfzhVwzeNxzil8GcjBUA7/k3aXyPq7SI7ajVqzOZWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbL3aREzWBuTbcy1bDOwvycbwv8sYOhBPVPhhxqQ+NpM73tiIl17CG3rQVJTL+yBHc2X2kLj4HDo4zJujYeOVr40/qTBKLSIX5j4V1bsThjnt7/l9SP3XAiZixs3XXldl9LLiCGTw9aaGLwoOWuE74wJ2cLHNNqZqjSWpZ5ojVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Xnyn1j7D; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xnyn1j7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=9wfzhVwzeNxzil8GcjBUA7/k3aXyPq7SI7ajVqzOZWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Xnyn1j7DN/AMdEaNlwW3RFcTMUduIM7wgGEEJwRjQAkNvTh4sBm7dbjqWwMLB7q6g
	 6q/V68SdxdxOUZa9Vtd4OiHT0vxsGHbBsqvcubsxuTJPchgqhfqpn0c8xomnuiZOXx
	 TYqk3J3Ny6E5J4Nv9iJ2l8gsUTUJebuhqilNaoSibKSf9YDw1fZtojdPpTAOEvaaTC
	 IVGm9zdAVNm7AVcnGhUTa0QTPW9at8ffBR5+UlRJulTdeU7mC14wM3JIXcUGxVbQ1W
	 AwXWYViAWHczX25DDFhdo6glBdevqDqNnsIpBnUnXvYG/OBIkRYxJpQpK0ctJ0gW2D
	 GrX3jkzeyyNV2yr+bAPOIyhyCesEIVv32IdvpLRR0MAmZejDAsmBNYTfqgHdSLfcta
	 jn3qXaahWnYFQIe+KVoAZU/vyXjRAdZ0/n01NfJE3f+L2yxMMDt2zNRjzY9TMjsIJY
	 6+CYp2RvjxAEHxcn9rAnCm5zg6hoEMwJ48aKk888j0hEUjrNCEL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4D97120158;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 6/9] rev-parse: allow printing compatibility hash
Date: Fri, 19 Sep 2025 01:09:08 +0000
Message-ID: <20250919010911.649831-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20250919010911.649831-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, we have a way to print the storage hash, the input hash, and
the output hash, but we lack a way to print the compatibility hash.  Add
a new type to --show-object-format, compat, which prints this value.

If no compatibility hash exists, simply print a newline.  This is
important to allow users to use multiple options at once while still
getting unambiguous output.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-rev-parse.adoc | 11 ++++++-----
 builtin/rev-parse.c              | 11 ++++++++++-
 t/t1500-rev-parse.sh             | 34 ++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index cc32b4b4f0..465ae3e29d 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -324,11 +324,12 @@ The following options are unaffected by `--path-format`:
 	path of the current directory relative to the top-level
 	directory.
 
---show-object-format[=(storage|input|output)]::
-	Show the object format (hash algorithm) used for the repository
-	for storage inside the `.git` directory, input, or output. For
-	input, multiple algorithms may be printed, space-separated.
-	If not specified, the default is "storage".
+--show-object-format[=(storage|input|output|compat)]::
+	Show the object format (hash algorithm) used for the repository for storage
+	inside the `.git` directory, input, output, or compatibility. For input,
+	multiple algorithms may be printed, space-separated. If `compat` is
+	requested and no compatibility algorithm is enabled, prints an empty line. If
+	not specified, the default is "storage".
 
 --show-ref-format::
 	Show the reference storage format used for the repository.
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 44ff1b8342..187b7e8be9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1108,11 +1108,20 @@ int cmd_rev_parse(int argc,
 				const char *val = arg ? arg : "storage";
 
 				if (strcmp(val, "storage") &&
+				    strcmp(val, "compat") &&
 				    strcmp(val, "input") &&
 				    strcmp(val, "output"))
 					die(_("unknown mode for --show-object-format: %s"),
 					    arg);
-				puts(the_hash_algo->name);
+
+				if (!strcmp(val, "compat")) {
+					if (the_repository->compat_hash_algo)
+						puts(the_repository->compat_hash_algo->name);
+					else
+						putchar('\n');
+				} else {
+					puts(the_hash_algo->name);
+				}
 				continue;
 			}
 			if (!strcmp(arg, "--show-ref-format")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 58a4583088..98c5a772bd 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -207,6 +207,40 @@ test_expect_success 'rev-parse --show-object-format in repo' '
 	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 '
 
+
+test_expect_success RUST 'rev-parse --show-object-format in repo with compat mode' '
+	mkdir repo &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		cd repo &&
+		git init --object-format=sha256 &&
+		git config extensions.compatobjectformat sha1 &&
+		echo sha256 >expect &&
+		git rev-parse --show-object-format >actual &&
+		test_cmp expect actual &&
+		git rev-parse --show-object-format=storage >actual &&
+		test_cmp expect actual &&
+		git rev-parse --show-object-format=input >actual &&
+		test_cmp expect actual &&
+		git rev-parse --show-object-format=output >actual &&
+		test_cmp expect actual &&
+		echo sha1 >expect &&
+		git rev-parse --show-object-format=compat >actual &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse --show-object-format=squeamish-ossifrage 2>err &&
+		grep "unknown mode for --show-object-format: squeamish-ossifrage" err
+	) &&
+	mkdir repo2 &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		cd repo2 &&
+		git init --object-format=sha256 &&
+		echo >expect &&
+		git rev-parse --show-object-format=compat >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'rev-parse --show-ref-format' '
 	test_detect_ref_format >expect &&
 	git rev-parse --show-ref-format >actual &&
