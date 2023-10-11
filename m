Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D8CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjJKUUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKUUN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 16:20:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14290
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 13:20:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso3594907b3.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697055610; x=1697660410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TC6pt8tnhK/qnA5U61BIEFQRRFy91ddW6vCUthqgIs=;
        b=RzF4VCalrAaV5vQJxKeLZb7d9Skymh9vhL7XSWqvK19Ec4yCCO9DwXdRCuu8N+xdi7
         rI0BWGALhjsE+izdeNJQ34T0h1ZaDOtuZw+lowsR75gBQA4fCS3k2zOeUPeKeCIf+bUH
         fvB3EICNwtXGVW0XWONxYSXefwfTorbvkASY7O1AvefTC+X5UMvync4Q9IQwOtn/lEnt
         3BKa03h6yQd8TlFMOQrLXDD+kvJtqZAlouvtffrdkEWEVv1DNVWRh6yqdRGj/PPpcGCh
         xbu4qe6v1C29Dzv+2i3lT7L3tDprw8HbxzRsWqUaoR06tLuy5pqttMTLKwNCdK4zSi68
         asdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055610; x=1697660410;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3TC6pt8tnhK/qnA5U61BIEFQRRFy91ddW6vCUthqgIs=;
        b=jjAIuntSqKXu182vvHrLQ/twl6oXZqjOr+n98x9cAObFGLZDEPGa3RBjSVuVDB+0LA
         JlLkNfrBpXzr8aPzE/4hEZOi/E2c6xpCdYrVe0W79KN+VF3/gzj1uk50+LMaW7Hca6FK
         fxGmjOuf+5dmV7Ya4Tnp1fR2IIzps4fRu5ZCDxCauldwPCAQcq4SBRj2NdHeIT8VR6Ln
         4RIwAff77yoz5lDC++o2loEQFGsu+Wya6dqq2Ebs0CP8MBeAiw1xqWYznmBlhlZ6KwiK
         7S5bt1Q9CFE45x89eAlnUzQIW2EXxHN9/1kvpI2vkbASwYtu0cPEBxtjGytu7G0nEJJl
         4qCw==
X-Gm-Message-State: AOJu0Yyml9gaTZUHYUpJfAi/EE4PvI4Zb/khV/iplGX89XY4QQK4Jfh7
        eQgTPvr0Cs1x2bt3FIbQicqNGN0PbBdx
X-Google-Smtp-Source: AGHT+IGUIHuJp/5JFd6zlG+JLFm7OEZQGKiTwBbk2wDbsdymJUws58cr5lQZmFVt6IB2+2TFVd8XsS5EnTTY
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a0d:ec0f:0:b0:59b:f138:c835 with SMTP id
 q15-20020a0dec0f000000b0059bf138c835mr419425ywn.5.1697055610651; Wed, 11 Oct
 2023 13:20:10 -0700 (PDT)
Date:   Wed, 11 Oct 2023 20:20:07 +0000
In-Reply-To: <xmqqbkda4ubp.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqbkda4ubp.fsf@gitster.g>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011202008.609921-1-jojwang@google.com>
Subject: [PATCH 1/1] add: enable attr pathspec magic
From:   Joanna Wang <jojwang@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jojwang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lets users limit added files or exclude files based on file
attributes. For example, the chromium project would like to use
this like "git add --all ':(exclude,attr:submodule)'", as submodules
are managed in a unique way and often results in submodule changes
that users do not want in their commits.

This does not change any attr magic implementation. It is only adding
attr as an allowed pathspec in git-add, which was previously
blocked by GUARD_PATHSPEC and a pathspec mask in parse_pathspec()).

With this patch, attr is supported. It is possible that when the attr
pathspec feature was first added in
b0db704652 (pathspec: allow querying for attributes, 2017-03-13),
"PATHSPEC_ATTR" was just unintentionally left out of a few
GUARD_PATHSPEC() invocations. Later, to get a more user-friendly error
message when attr was used with git-add, PATHSPEC_ATTR was added as a
mask to git-add's invocation of parse_pathspec()
84d938b732 (add: do not accept pathspec magic 'attr', 2018-09-18).

git-stash which goes through the same GUARD_PATHSPEC(), currently
does not work with attr.
https://lore.kernel.org/git/CAMmZTi-0QKtj7Q=3DsbC5qhipGsQxJFOY-Qkk1jfkRYwfF=
5FcUVg@mail.gmail.com/T/#u
So a PATHSPEC_ATTR mask has been added to its parse_pathspec and
parse_pathspec_file().

Signed-off-by: Joanna Wang <jojwang@google.com>
---

> Do you know what exactly is not ready, so that perhaps others can
> help figuring out how to make it ready for the attr magic?
I have filed a bug which describes what I have found:
https://lore.kernel.org/git/CAMmZTi-0QKtj7Q=3DsbC5qhipGsQxJFOY-Qkk1jfkRYwfF=
5FcUVg@mail.gmail.com/T/#u

> Why this reindent?
Fixed

> There is a typo here.
Fixed


 builtin/add.c                  |   7 ++-
 builtin/stash.c                |   7 ++-
 dir.c                          |   3 +-
 t/t6135-pathspec-with-attrs.sh | 106 +++++++++++++++++++++++++++++++--
 4 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c27254a5cd..2de83964a3 100644
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
diff --git a/builtin/stash.c b/builtin/stash.c
index 1ad496985a..af1b3a7146 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1760,7 +1760,10 @@ static int push_stash(int argc, const char **argv, c=
onst char *prefix,
 		}
 	}
=20
-	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
+        // For parse_pathspec() and parse_pathspec_file() below, PATHSPEC_=
ATTR is blocked for git stash
+        // because the magic attr does not get properly parsed when the PA=
THSPEC_PREFIX_ORIGIN flag is
+        // used, resulting in incorrect file filtering for attr.
+	parse_pathspec(&ps, PATHSPEC_ATTR, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX=
_ORIGIN,
 		       prefix, argv);
=20
 	if (pathspec_from_file) {
@@ -1773,7 +1776,7 @@ static int push_stash(int argc, const char **argv, co=
nst char *prefix,
 		if (ps.nr)
 			die(_("'%s' and pathspec arguments cannot be used together"), "--pathsp=
ec-from-file");
=20
-		parse_pathspec_file(&ps, 0,
+		parse_pathspec_file(&ps, PATHSPEC_ATTR,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
diff --git a/dir.c b/dir.c
index 8486e4d56f..ee3f3777df 100644
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
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.s=
h
index f70c395e75..403ee5e6b6 100755
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
@@ -239,16 +254,97 @@ test_expect_success 'fail on multiple attr specifiers=
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
+	# attr magic. This test does not advocate stash push to stay that way.
+	# When you teach the command to grok the pathspec, you need to find
+	# another command to replace it for the test.
+	test_must_fail git stash push ":(attr:labelB)" 2>actual &&
+	test_i18ngrep "magic not supported" actual
+'
+
+test_expect_success 'fail if attr magic is used in --pathspec-from-file wh=
en not implemented' '
+	# This is like the test above but for attr magic passed in via --pathspec=
-from-file.
+	cat <<-\EOF >pathspec_file &&
+	:(attr:labelB)
+	EOF
+	test_must_fail git stash push --pathspec-from-file=3Dpathspec_file 2>actu=
al &&
 	test_i18ngrep "magic not supported" actual
 '
=20
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
2.42.0.609.gbb76f46606-goog

