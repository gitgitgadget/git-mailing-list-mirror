Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099228504B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444751; cv=none; b=GDb15TIo0nRKUbMXsv/ADYbTbgm1I9HZTtBPZMHpMcAc7gKzOfuMj+SeJrlplr7gl3BkMAV71SexwMuLgueGUBB0A/1IqrY4kTzf4pJy6s9r5iMAvaTCO7l51Z/+7Sc/Tf81IUaU8sopaXOTp33xMe2rP1qnu08pQs9f/4K2CHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444751; c=relaxed/simple;
	bh=rjocp6SKYoQ3akGR8BtPfs/eHyoE05EMA21Ud60sg00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLXthGdK1E5xvJdJQaDSlEcXeq9vJjbQ6bEtaferherzrri361uWoZp0+2S5EhxfwY733KCbHnckAPw4eGDRFc60790cCcNZ/Jv5XYecybS6d+esa4VHVG1pKVECQw5IvOkgIm18G0c6b6P3g9jYXij1ulkfYD7iqlen8oAPgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EVie/U5h; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EVie/U5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759444746;
	bh=rjocp6SKYoQ3akGR8BtPfs/eHyoE05EMA21Ud60sg00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=EVie/U5hVyXPVU5+vKXDFxwXe/oK/IeNJPs6n/6P9ufeFFTNgtonISUD4U03mLV74
	 yR2yn2f+v2MCOqaRwWbbT7eBnMv16DNlu2r6cw7BlRivhNJqTDRqj2p0w/iw0gzahO
	 v1FxhDnkPeOz6XzddaYS1B+aarWoEkgPV/kyeMVH5x1V1JAmmOIuAaCAL+4g65cVad
	 3RuAqRRKeUyD77/o+0tsv+mVw9EgLvnGeMA2mgK4nEk3yctyCqAhEaUOpmzpSsGuXM
	 tAGsMYE4gijm26uaBy8PSIGvufVq0Skgacw6MRwFI4cB+8N0PKPfZlbJ2iE/slejph
	 h+AW7Gk/tvMpf5lYn9ZSHFHtjhUV8ZjQTMXDOK62gCBjRAQZhtNUxmb62n7pjsZB1A
	 OlDy2XtIUxSYn4nw1dN/50fc3MnJ2VoUfOsMKuP1Ys0E8ihvdQlXKwxfDLCq3kkPy0
	 zddfnuJ3FQ6oBC1zH0mi4tLUdK3CI5R4GMg/a6a5KQdMZS6X+vg
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b8e7:3022:3f31:478d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5A3512019F;
	Thu,  2 Oct 2025 22:39:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/9] rev-parse: allow printing compatibility hash
Date: Thu,  2 Oct 2025 22:38:52 +0000
Message-ID: <20251002223855.1022847-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251002223855.1022847-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-1-sandals@crustytoothpaste.net>
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
index 58a4583088..7739ab611b 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -207,6 +207,40 @@ test_expect_success 'rev-parse --show-object-format in repo' '
 	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 '
 
+
+test_expect_success 'rev-parse --show-object-format in repo with compat mode' '
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
