Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B644BE92FCF
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 23:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjJEX2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 19:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjJEX0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 19:26:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027D1703
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 16:24:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso2240460276.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 16:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696548287; x=1697153087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fS6QC97PO+nLt801Qa0INNVn3K5fXoCmvTGSSH0Yjr8=;
        b=ivubuQqkUs+xmsJqjyRB0XbOGkc12LM0mSJbgnBAJnXOvE22pH8/dU61+C4Ny6etDP
         YKHKc3e/dEbgPJqDC6lll2/oOKmbEZC3cyNfQ/d8Ree8aMoI9wqu35apQkXR5EC8Os/h
         L1YrnUNoqooRXgI7OBy/A0Cw/Ud0UB9+HpSrM6PnQPpEkofAZZs4Wr8ouPRxeWEeVkqS
         Jz/IlJHqv+NkibXkK6m6zuYlAq/k/Mem5pUl1jqOLO2Fd20ftsChHa4BOFqLW24tCJGb
         r/g88ExVSpDdOuOflQrc4b3G84jKt04AEoDQ/toL/3VR4ELiQJyOXJpyvAMFmU0cG5Cx
         HvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696548287; x=1697153087;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS6QC97PO+nLt801Qa0INNVn3K5fXoCmvTGSSH0Yjr8=;
        b=I1rBmApbxUkm7/7MdeEUmH7VQXWJaJOy5gYpz6lW03+6e3ct7BQiVDTYflgzquFP4e
         OWr2/Q/amigtOJ5RuMkraFvZqGCXFpeUZshptuAYPn9P/eV7BNrIwVxUY1+eFlqHcMfL
         a6BG31SZzCMip8Ee+wsj7YKaE3Nr3bK9EitgouRNtjW7MGEQIXbP4l+k9TNRt0+qk61n
         Wq+0FS8+RZyowk2x7tcJ7eKHWoz82E15+cOp6nGCQyKMdMEXmeAJajOiuDUrxh4fzEYy
         waGGYYYm9whydHK7OMpuEkRuYtVqnx2aUD+jgJUAfwSPmak4SGlAJtiORAfsK6s2tst9
         tOkA==
X-Gm-Message-State: AOJu0YxmXo2SiJXLlIAWqhwL34kYRTozPCasYeNdEYHuQVaeEDOLzMZJ
        Hlqe5hdmmU5mGhGuJwQDImalrxXmFpm+ugGpaKW1kVrJMcK8D8Zgc/vO8emDLmWR9M2yXcOri5f
        2AHH14dJHvSckcR4+kg6zhlBZYilXuwkV3YIiDhcUF1AHWMnIlrjgUu65b1Z+
X-Google-Smtp-Source: AGHT+IGSS8ZbVfqc2sxzsnj2UejT5DoPnPrksxa86/8ASyLi9LCBAyscvv7ky/qzky98RbBL9rSLFUxEuLmM
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a25:c056:0:b0:d81:5c03:df95 with SMTP id
 c83-20020a25c056000000b00d815c03df95mr91397ybf.12.1696548287568; Thu, 05 Oct
 2023 16:24:47 -0700 (PDT)
Date:   Thu,  5 Oct 2023 23:23:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231005232423.1834298-1-jojwang@google.com>
Subject: [PATCH 1/1] Allow attr magic for git-add, git-stash.
From:   Joanna Wang <jojwang@google.com>
To:     git@vger.kernel.org
Cc:     Joanna Wang <jojwang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lets users limit added/stashed files or exclude files based on file
attributes. For example, the chromium project would like to use
this like "git add --all ':(exclude,attr:submodule)'", as submodules
are managed in a unique way and often results in submodule changes
that users do not want in their commits.

This does not change any attr magic implementation. It is only adding
attr as an allowed pathspec in git-add/stash, which was previously
blocked (for stash/add) by GUARD_PATHSPEC and (for add only) a pathspec
mask in parse_pathspec()).

With this patch, attr is supported for the two commands. It is possible
that when the attr pathspec feature was first added in
b0db704652 (pathspec: allow querying for attributes, 2017-03-13),=20
"PATHSPEC_ATTR" was just unintentionally left out of a few
GUARD_PATHSPEC() invocations. Later, to get a more user-friendly error
message when attr was used with git-add, PATHSPEC_ATTR was added as a
mask to git-add's invocation of parse_pathspec() in
84d938b732 (add: do not accept pathspec magic 'attr', 2018-09-18).

Any bugs this may trigger will be fixed in follow-up patches.

Signed-off-by: Joanna Wang <jojwang@google.com>
---

I have tested this thoroughly with different flags, non-root directories,
and other magic pathspecs, but may be unaware of some edge cases.

The GUARD_PATHSPEC() in dir.c is a potential part of the call stack of
fill_directory(), which is called by add, stash, grep, ls-files,
sparse-checkout, and status.
However, this patch only seems to add new behavior to git-add and git-stash=
.
grep, ls-files, and status already support attr pathspecs and running some =
of
these commands with the debugger confirms this GUARD_PATHSPEC() is never re=
ached.
But again I am not aware of all edge cases. For sparse-checkout I'm not sur=
e
if/how pathspec can be used, but either way did not see new behavior.

For context, attr magic support for git-add is part of work discussed here:
https://lore.kernel.org/git/xmqqfs2yjgvr.fsf@gitster.g/T/#t

 builtin/add.c                  |  5 +++--
 dir.c                          |  8 +-------
 t/t6135-pathspec-with-attrs.sh | 34 ++++++++++++++++++++++++++--------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c27254a5cd..ef0b8d55fd 100644
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
index 8486e4d56f..55c9607b1a 100644
--- a/dir.c
+++ b/dir.c
@@ -2173,13 +2173,7 @@ static int exclude_matches_pathspec(const char *path=
, int pathlen,
 	if (!pathspec || !pathspec->nr)
 		return 0;
=20
-	GUARD_PATHSPEC(pathspec,
-		       PATHSPEC_FROMTOP |
-		       PATHSPEC_MAXDEPTH |
-		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+	GUARD_PATHSPEC(pathspec, PATHSPEC_ALL_MAGIC);
=20
 	for (i =3D 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item =3D &pathspec->items[i];
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.s=
h
index f70c395e75..e11d8cb119 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -64,12 +64,23 @@ test_expect_success 'setup .gitattributes' '
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
+	EOF
+	git add .gitignore &&
+	git commit -m "add gitignore"
+'
+
 test_expect_success 'check specific set attr' '
 	cat <<-\EOF >expect &&
 	fileSetLabel
@@ -150,6 +161,7 @@ test_expect_success 'check specific value attr (2)' '
 test_expect_success 'check unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
+	.gitignore
 	fileA
 	fileAB
 	fileAC
@@ -175,6 +187,7 @@ test_expect_success 'check unspecified attr' '
 test_expect_success 'check unspecified attr (2)' '
 	cat <<-\EOF >expect &&
 	HEAD:.gitattributes
+	HEAD:.gitignore
 	HEAD:fileA
 	HEAD:fileAB
 	HEAD:fileAC
@@ -200,6 +213,7 @@ test_expect_success 'check unspecified attr (2)' '
 test_expect_success 'check multiple unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
+	.gitignore
 	fileC
 	fileNoLabel
 	fileWrongLabel
@@ -239,14 +253,18 @@ test_expect_success 'fail on multiple attr specifiers=
 in one pathspec item' '
 	test_i18ngrep "Only one" actual
 '
=20
-test_expect_success 'fail if attr magic is used places not implemented' '
-	# The main purpose of this test is to check that we actually fail
-	# when you attempt to use attr magic in commands that do not implement
-	# attr magic. This test does not advocate git-add to stay that way,
-	# though, but git-add is convenient as it has its own internal pathspec
-	# parsing.
-	test_must_fail git add ":(attr:labelB)" 2>actual &&
-	test_i18ngrep "magic not supported" actual
+test_expect_success 'check that attr magic works for git-add' '
+	# attr magic was previously blocked for git-add. With attr magic
+	# enabled for git-add, add a basic test to make sure it works as
+	# expected and add more tests if more bugs are discovered.
+	cat <<-\EOF >expect &&
+	sub/newFileA-foo
+	EOF
+	touch sub/newFileA-foo &&
+	touch sub/newFileB-foo &&
+	git add --all ":(exclude,attr:labelB)" &&
+	git diff --name-only --cached >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'abort on giving invalid label on the command line' '
--=20
2.42.0.582.g8ccd20d70d-goog

