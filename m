Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4C20B04
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uh9f2ZkF"
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17718B
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 10:53:18 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 6a1803df08f44-66fbd3bc8ebso13769736d6.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947598; x=1699552398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2oYZyBpnA/TlVYAVjY77nvd6CQli9pATFAGcSaWE0M=;
        b=uh9f2ZkFbVNHetZsZASw0qGIvQb7VP2pNyHvMZWF9HN2L/cdDYFoFUsWD2eFOja7Iv
         ZMzdiaSwbcSYk/jNmslF+9W5AM1tjy/NzRseH6TkU3/WTdxWVo1WLcAl+V4sUi99ubn+
         /Aji4U5kBYUQcl3CWdHmQGk/SCX+9KhPVCQa2gAWadqWH0crM+MFrPGMRjcYmLf/tA+o
         clbq5MyVEmCAABJ10xGsH7kQywRGxwrJW53HX1sYceZwXGYdhNm7T5oxN8YNGt8wU7gj
         9MJm6/eGamg39SmjOILUqkQk+OckXBon3TT5DJ6nXjvvweNVerjlrtor5WMG3p4yNpEr
         hMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947598; x=1699552398;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2oYZyBpnA/TlVYAVjY77nvd6CQli9pATFAGcSaWE0M=;
        b=nWu/x/IVFU9ZVaE7B11sfXPoGf2JPUNQ1bmEZ/Q0YDTkREI82Gzc5IzRpik2EwZaxp
         pHoWmNiitEzQbxDbtafh8wQKVHftJtdL9mvVOX1tARPby29/27gbKYKbJV1EGgRwiLob
         tUALcYfyBeOa4iTwl4BQXQULltUDoGFQmU3ZxBSmRs8PeT+VCN9DE3390e2/f8Fyu4Qe
         96tRFn+/UjsQQ+rtSAwIoQETlpr/shZvFisAFMSaIn+tqFuvdFpd8IPEirgw5804TUt6
         og9BjC2oXMWOKRA/XOQxVA1Q8zfCXaMkAZCNq74pRIPL3+R5TYePzC4hH6hqCn+5jqZ3
         8nvQ==
X-Gm-Message-State: AOJu0YxS1VhwibvgtTwOwAB6VtWZJC+usV0rHQdh2CCw0DnkJpiWcl+k
	2GSu6za4rxtHB193JhWzzfWtPDEdfZUF
X-Google-Smtp-Source: AGHT+IHV4kVywYTsAD5wZOOkK+NB7Z3UKeaGLPbDwRcoNC7ZrPIr7Jp/9DHtaYdrmxWjPZFl0iFIwrlcnryM
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a0c:bf04:0:b0:675:6383:acf5 with SMTP id
 m4-20020a0cbf04000000b006756383acf5mr31438qvi.9.1698947597935; Thu, 02 Nov
 2023 10:53:17 -0700 (PDT)
Date: Thu,  2 Nov 2023 17:53:15 +0000
In-Reply-To: <xmqqfs1ooil2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqfs1ooil2.fsf@gitster.g>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102175316.2229631-1-jojwang@google.com>
Subject: [PATCH 1/1] attr: enable attr pathspec magic for git-add and git-stash
From: Joanna Wang <jojwang@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, jojwang@google.com
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

> Indeed, if you are going to pass the original "elt" string *anyway*,
> you have all the info in there that you need.  I wonder if it makes
> sense to get rid of the "unsigned magic" bitset from the parameter,
This was my initial strategy but ran into trouble when the magic was
in shorthand form. Upon closer look at how the shorthand works
(e.g. shorthand and longhand can never mix so
':!/(attr:chicken)file' would make <(attr:chicken)file> the match string)
I tried this again by processing the forms separately.
It would still need both the element and element_magic, but I think it
addresses the concerns with future changes where multiple magic match
values could be allowed and the match values could be any string. These
changes would be fine as long as there is no overlap between magic that
takes a user-supplied value and magic that can be expressed in shorthand.


 builtin/add.c                  |   7 ++-
 dir.c                          |   3 +-
 pathspec.c                     |  25 +++++---
 t/t6135-pathspec-with-attrs.sh | 108 +++++++++++++++++++++++++++++++--
 4 files changed, 125 insertions(+), 18 deletions(-)

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
index bb1efe1f39..588a2cde4d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -109,16 +109,23 @@ static struct pathspec_magic {
 	{ PATHSPEC_ATTR,    '\0', "attr" },
 };
=20
-static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
+static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic,=
 const char *element)
 {
-	int i;
-	strbuf_addstr(sb, ":(");
-	for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
-		if (magic & pathspec_magic[i].bit) {
-			if (sb->buf[sb->len - 1] !=3D '(')
-				strbuf_addch(sb, ',');
-			strbuf_addstr(sb, pathspec_magic[i].name);
+	if (element[1] !=3D '(') {
+		/* Process an element in shorthand form (e.g. ":!/<match>") */
+		strbuf_addstr(sb, ":(");
+		for (int i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if ((magic & pathspec_magic[i].bit) && (pathspec_magic[i].mnemonic !=3D=
 '\0')) {
+				if (sb->buf[sb->len - 1] !=3D '(')
+					strbuf_addch(sb, ',');
+				strbuf_addstr(sb, pathspec_magic[i].name);
+			}
 		}
+	} else {
+		/* For an element in longhand form, we simply copy everything up to the =
final ')' */
+		int len =3D strchr(element, ')') - element;
+		strbuf_add(sb, element, len);
+	}
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
=20
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
2.42.0.869.gea05f2083d-goog

