Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FD15AC
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0scdYVXI"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD5F11B
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 18:55:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b3715f3b41so6593367b3.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698890156; x=1699494956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0b658VhwXFWbAXzhC7m6FN4OZ8O11ykDg24FKD0i7g=;
        b=0scdYVXIcWXAJ17WdcbJWTETuHggfWp80KLzos9/wkv7cQxnyu81a0sMoyHIIRY8MX
         PEXo6UAML0enpNNVilL8m0RkMkGAnkqXesSOEMi3r6Ffd/o1VZc2zFKXJkyXwyPPc0Ks
         wK8TcTpgZV2ixlZ0o13oPj/4bzy0tfM6hJGuMTRGUWb9HEBdFbaXVUKytG+eQqav9W65
         fZHxzEplRoth5dZe+BpcvoMfH91j+jNe3GAEzvQGxbufI84Ma6e9tbTgUM3Z4uo6piqH
         j7w/yRGiHQvQVmMMqLqq9r2aKfw1P1MfNnTWCqSxIvDnAOpDoZjHDwh9XrUzDqQckB5B
         l6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698890156; x=1699494956;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0b658VhwXFWbAXzhC7m6FN4OZ8O11ykDg24FKD0i7g=;
        b=cALqnclpQIgNyjuZXpJugVK8eFuAqhe0CzyqWZ1XHxjZb7p3isBtrZABLaPQcoJVld
         3umOpBNngD/KOvAeS6YHVcyicfsAf2wKy8yGp70W7kpMFexBQpa8Cl4t/PElDiCeGIzs
         +Jm9Kdym3wAMiP4N2AqU8w8eAHS0NR1m/RP0L2dafzWd3wmhZsedZd2hjBr9YTAWTYGj
         kHCvqcK75IyCNJzI9L502/7DNIBsnwp81hpGm0PZbfSEZOtJoXkAZm7vgj8UaLOKuCO7
         i0zC9PLI+xNO2iaODvF8n8T+UixOgsTPOgj+W0KMEanU9I0gWv/6fDgecf2bQiM9eO1R
         bK3Q==
X-Gm-Message-State: AOJu0YzoTxpJsVVlDqkHZPGWPNirQusRyvH8b2XvGrF8c92Ro/N2roW0
	1ZBHneslESAg2a3cGIBPuFPGUMyvbZ0S
X-Google-Smtp-Source: AGHT+IEH3DmPdRTzP4+g0WLt6hBMqBvfBBBJZnL/8yw3+7jMOpW4gKVcYHNaVeK2lgwxI6Fxu8TQ+2yElVMd
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a25:4dc2:0:b0:d9c:bdff:e45a with SMTP id
 a185-20020a254dc2000000b00d9cbdffe45amr293753ybb.12.1698890156760; Wed, 01
 Nov 2023 18:55:56 -0700 (PDT)
Date: Thu,  2 Nov 2023 01:55:53 +0000
In-Reply-To: <20231011202008.609921-1-jojwang@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231011202008.609921-1-jojwang@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231102015554.34089-1-jojwang@google.com>
Subject: [PATCH 1/1] attr: enable attr pathspec magic for git-add and git-stash
From: Joanna Wang <jojwang@google.com>
To: jojwang@google.com
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This lets users limit files or exclude files based on file
attributes during git-add and git-stash.
For example, the chromium project would like to use this like
"git add --all ':(exclude,attr:submodule)'", as submodules are managed in a
unique way and often results in submodule changes that users do not want in
their commits.

This does not change any attr magic implementation. It is only adding
attr as an allowed pathspec in git-add and git-stash, which was previously
blocked by GUARD_PATHSPEC and a pathspec mask in parse_pathspec()).
However, this does fix a bug in prefix_magic() where attr values were unint=
entionally removed.
This was hit whenever parse_pathspec() is called with PATHSPEC_PREFIX_ORIGI=
N as a flag,
which was the case for git-stash. More details here:
https://lore.kernel.org/git/CAMmZTi-0QKtj7Q=3DsbC5qhipGsQxJFOY-Qkk1jfkRYwfF=
5FcUVg@mail.gmail.com/

It is possible that when the attr pathspec feature was first added in
b0db704652 (pathspec: allow querying for attributes, 2017-03-13),
"PATHSPEC_ATTR" was just unintentionally left out of a few GUARD_PATHSPEC()=
 invocations.

Later, to get a more user-friendly error message when attr was used with gi=
t-add,
PATHSPEC_ATTR was added as a mask to git-add's invocation of parse_pathspec=
()
84d938b732 (add: do not accept pathspec magic 'attr', 2018-09-18).
However, this user-friendly error message was never added for git-stash.

Signed-off-by: Joanna Wang <jojwang@google.com>

---

PTAL.
I've updated this to include the fix for git-stash. I was initially going t=
o fix this bug [1]
separately, but I thought it would make more sense to put everything in one=
 patch so attr
could be enabled for both git-add and git-stash and tested.

[1] https://lore.kernel.org/git/CAMmZTi-0QKtj7Q=3DsbC5qhipGsQxJFOY-Qkk1jfkR=
YwfF5FcUVg@mail.gmail.com/



 builtin/add.c                  |   7 ++-
 dir.c                          |   3 +-
 pathspec.c                     |  11 +++-
 t/t6135-pathspec-with-attrs.sh | 108 +++++++++++++++++++++++++++++++--
 4 files changed, 118 insertions(+), 11 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5126d2ede3..d46e4d10e9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -424,7 +424,7 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_ATTR,
+	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
@@ -433,7 +433,7 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 		if (pathspec.nr)
 			die(_("'%s' and pathspec arguments cannot be used together"), "--pathsp=
ec-from-file");
=20
-		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
+		parse_pathspec_file(&pathspec, 0,
 				    PATHSPEC_PREFER_FULL |
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
@@ -504,7 +504,8 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 			       PATHSPEC_LITERAL |
 			       PATHSPEC_GLOB |
 			       PATHSPEC_ICASE |
-			       PATHSPEC_EXCLUDE);
+			       PATHSPEC_EXCLUDE |
+			       PATHSPEC_ATTR);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
diff --git a/dir.c b/dir.c
index 16fdb03f2a..4d1cd039be 100644
--- a/dir.c
+++ b/dir.c
@@ -2179,7 +2179,8 @@ static int exclude_matches_pathspec(const char *path,=
 int pathlen,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
=20
 	for (i =3D 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item =3D &pathspec->items[i];
diff --git a/pathspec.c b/pathspec.c
index bb1efe1f39..40bd8a8819 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -109,7 +109,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_ATTR,    '\0', "attr" },
 };
=20
-static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
+static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic,=
 const char *element)
 {
 	int i;
 	strbuf_addstr(sb, ":(");
@@ -118,6 +118,13 @@ static void prefix_magic(struct strbuf *sb, int prefix=
len, unsigned magic)
 			if (sb->buf[sb->len - 1] !=3D '(')
 				strbuf_addch(sb, ',');
 			strbuf_addstr(sb, pathspec_magic[i].name);
+			if (pathspec_magic[i].bit & PATHSPEC_ATTR) {
+				/* extract and insert the attr magic value */
+				char* p =3D strstr(element, "attr:");
+				char buff[128];
+				sscanf(p, "attr%[^)|,]", buff);
+				strbuf_addstr(sb, buff);
+			}
 		}
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
@@ -493,7 +500,7 @@ static void init_pathspec_item(struct pathspec_item *it=
em, unsigned flags,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		/* Preserve the actual prefix length of each pattern */
-		prefix_magic(&sb, prefixlen, element_magic);
+		prefix_magic(&sb, prefixlen, element_magic, elt);
=20
 		strbuf_addstr(&sb, match);
 		item->original =3D strbuf_detach(&sb, NULL);
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.s=
h
index f70c395e75..e46fa176ed 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -64,12 +64,24 @@ test_expect_success 'setup .gitattributes' '
 	fileSetLabel label
 	fileValue label=3Dfoo
 	fileWrongLabel label=E2=98=BA
+	newFileA* labelA
+	newFileB* labelB
 	EOF
 	echo fileSetLabel label1 >sub/.gitattributes &&
 	git add .gitattributes sub/.gitattributes &&
 	git commit -m "add attributes"
 '
=20
+test_expect_success 'setup .gitignore' '
+	cat <<-\EOF >.gitignore &&
+	actual
+	expect
+	pathspec_file
+	EOF
+	git add .gitignore &&
+	git commit -m "add gitignore"
+'
+
 test_expect_success 'check specific set attr' '
 	cat <<-\EOF >expect &&
 	fileSetLabel
@@ -150,6 +162,7 @@ test_expect_success 'check specific value attr (2)' '
 test_expect_success 'check unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
+	.gitignore
 	fileA
 	fileAB
 	fileAC
@@ -175,6 +188,7 @@ test_expect_success 'check unspecified attr' '
 test_expect_success 'check unspecified attr (2)' '
 	cat <<-\EOF >expect &&
 	HEAD:.gitattributes
+	HEAD:.gitignore
 	HEAD:fileA
 	HEAD:fileAB
 	HEAD:fileAC
@@ -200,6 +214,7 @@ test_expect_success 'check unspecified attr (2)' '
 test_expect_success 'check multiple unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
+	.gitignore
 	fileC
 	fileNoLabel
 	fileWrongLabel
@@ -239,16 +254,99 @@ test_expect_success 'fail on multiple attr specifiers=
 in one pathspec item' '
 	test_i18ngrep "Only one" actual
 '
=20
-test_expect_success 'fail if attr magic is used places not implemented' '
+test_expect_success 'fail if attr magic is used in places not implemented'=
 '
 	# The main purpose of this test is to check that we actually fail
 	# when you attempt to use attr magic in commands that do not implement
-	# attr magic. This test does not advocate git-add to stay that way,
-	# though, but git-add is convenient as it has its own internal pathspec
-	# parsing.
-	test_must_fail git add ":(attr:labelB)" 2>actual &&
+	# attr magic. This test does not advocate check-ignore to stay that way.
+	# When you teach the command to grok the pathspec, you need to find
+	# another command to replace it for the test.
+	test_must_fail git check-ignore ":(attr:labelB)" 2>actual &&
 	test_i18ngrep "magic not supported" actual
 '
=20
+test_expect_success 'check that attr magic works for git stash push' '
+	cat <<-\EOF >expect &&
+	A	sub/newFileA-foo
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	git stash push --include-untracked -- ":(exclude,attr:labelB)" &&
+	git stash show --include-untracked --name-status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add --all' '
+	cat <<-\EOF >expect &&
+	sub/newFileA-foo
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	git add --all ":(exclude,attr:labelB)" &&
+	git diff --name-only --cached >actual &&
+	git restore -W -S . &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add -u' '
+	cat <<-\EOF >expect &&
+	sub/fileA
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	>sub/fileA &&
+	>sub/fileB &&
+	git add -u ":(exclude,attr:labelB)" &&
+	git diff --name-only --cached  >actual &&
+	git restore -S -W . && rm sub/new* &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add <path>' '
+	cat <<-\EOF >expect &&
+	fileA
+	fileB
+	sub/fileA
+	EOF
+	>fileA &&
+	>fileB &&
+	>sub/fileA &&
+	>sub/fileB &&
+	git add ":(exclude,attr:labelB)sub/*" &&
+	git diff --name-only --cached >actual &&
+	git restore -S -W . &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git -add .' '
+	cat <<-\EOF >expect &&
+	sub/fileA
+	EOF
+	>fileA &&
+	>fileB &&
+	>sub/fileA &&
+	>sub/fileB &&
+	cd sub &&
+	git add . ":(exclude,attr:labelB)" &&
+	cd .. &&
+	git diff --name-only --cached >actual &&
+	git restore -S -W . &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check that attr magic works for git add --pathspec-fr=
om-file' '
+	cat <<-\EOF >pathspec_file &&
+	:(exclude,attr:labelB)
+	EOF
+	cat <<-\EOF >expect &&
+	sub/newFileA-foo
+	EOF
+	>sub/newFileA-foo &&
+	>sub/newFileB-foo &&
+	git add --all --pathspec-from-file=3Dpathspec_file &&
+	git diff --name-only --cached >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'abort on giving invalid label on the command line' '
 	test_must_fail git ls-files . ":(attr:=E2=98=BA)"
 '
--=20
2.42.0.820.g83a721a137-goog

