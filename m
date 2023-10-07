Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE3CE94139
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 00:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjJGA2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjJGA2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 20:28:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBACBD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 17:28:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so41236917b3.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696638493; x=1697243293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnbbPWV0pASPEdOGTTanlM3fdkQCjZUyaowVHTyd3aA=;
        b=v16mjk11T2BMrMNnjgNvA/rzqVP7rmzf24hA2sI5T1+PXJ7ylm9uEb1aaQrowjdk3N
         iYwm6YawlCQy6ueV5c/2WEYnkI0D7l7mFNfTU/WAS0+Dsj5gFSHB2v4MSw9BFo41zPKK
         GHD/h0MV3GsmmVSm/F4CKS+KuKom9iXJP57Ldx7N+tuZ3zhX8pcfXac3lgCo4ARrmuu2
         fqKmWZnUI8h5035W1WenbFo3Ter/K7wB5gXy+TVnskN44XHdCt9MtRWfUW9Fnz8mP2Lp
         Ww0GtLv6BMVzI/3fRedxXuUlV+sFWUPfCetFphRxbeA9t8aE4ZavPRkXDNZ1DM0R3iDr
         qJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696638493; x=1697243293;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DnbbPWV0pASPEdOGTTanlM3fdkQCjZUyaowVHTyd3aA=;
        b=O7uOR8ywigr1Ps9QA5W+FEBqS7LBb2z+MM5/mN5OqDg25zINqRXVzcl4UTujU61zt7
         oTIzxM78Ghe9bSkUd9LJHm/r8gJ2PZ1yvPW2kZiyvucj61/0PP8yBSLMS3E9B2s7s+o1
         cay2OFj49j0wSFy7wDcPp0R7u7H+vioIyH+QHcYeJA8yXjyGQeg3NlbVYCzgrJiLTPJV
         cFA+C0zIiCSjLmv8G29zE1MEtt/obMwa8ZqQEoxn/c4glEXXQS3XUzSkLwjMcdTKX7Qw
         OcalqsoA5yCJgWAaEMCyJ6QM0zDvCZi8mYn6GPGoEWHsWvBXEjGMlf6Zn8jdtfmDVt89
         H3PQ==
X-Gm-Message-State: AOJu0Yzzzwnxv6+5MqxHv4pT5oECFlPER2+lfL4Tct4K6LH88JAHhNUJ
        qmHLuGwSVyM4HbAX/6DIljbvShtcuf8Q
X-Google-Smtp-Source: AGHT+IGpGe2cJCpjWtaza4GAnp6rLbdbUCVfOdgLjcu8plSbiJvttmtSXh9mov3OKQxfpFNkvCtHh8QYY9Q2
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a05:6902:85:b0:d86:5644:5d12 with SMTP id
 h5-20020a056902008500b00d8656445d12mr172903ybs.4.1696638493371; Fri, 06 Oct
 2023 17:28:13 -0700 (PDT)
Date:   Sat,  7 Oct 2023 00:28:10 +0000
In-Reply-To: <xmqqttr3adgg.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqttr3adgg.fsf@gitster.g>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231007002811.2337315-1-jojwang@google.com>
Subject: [PATCH 1/1] add: Enable attr pathspec magic for git-add.
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
b0db704652 (pathspec: allow querying for attributes, 2017-03-13),=20
"PATHSPEC_ATTR" was just unintentionally left out of a few
GUARD_PATHSPEC() invocations. Later, to get a more user-friendly error
message when attr was used with git-add, PATHSPEC_ATTR was added as a
mask to git-add's invocation of parse_pathspec()
84d938b732 (add: do not accept pathspec magic 'attr', 2018-09-18).

git-stash which goes through the same GUARD_PATHSPEC(), currently
does not work with attr. So a PATHSPEC_ATTR mask has been added
to its parse_pathspec and parse_pathspec_file()

Signed-off-by: Joanna Wang <jojwang@google.com>
---

> (perhaps except for the commit title on the Subject: header).
Added 'add:' and specified it is 'patchpsec' magic, but lmk if i'm still mi=
ssing something.

> This is rather a poor statement to make, as it hints that there are
> known breakages this change will reveal that you are not telling us,
>although I suspect that it is not the case.
Yes, sorry I did not mean to make this hint. I was trying to express that
if bugs did come up, we would not abandon this effort and expect someone
else to fix it. I have removed this line. I realized I also don't want
to say we will forever be on the hook for fixing every related bug that com=
es up.

> These are good things to add to the new test this patch adds.
Tests added.

>Hmph, is it a good idea in general to use ALL_MAGIC in guard?
My original reasoning was using ALL_MAGIC would prevent new magic pathspecs
from being unintentionally left out of commands and if a new magic does not
work with a command, whoever adds it should change ALL_MAGIC back to listin=
g
them individually in the same patch. But yes, listing them individually see=
ms
safer. Better to accidentally leave magic out that can be added with intent=
ion
later rather than make it easy to accidentally leave unsupported magic in.
I switched it back to listing individually.

>It is strongly preferrable, instead of butchering this test that
>guards these two mechanisms from being broken, to find a command
>that still has some restriction on the magic it allows, and use it
>to make sure they still trigger and give "magic not supported" error
>message.
I added the test back with git-stash, which, after more testing i discovere=
d it
actually did not fully work with attr. More info below.

>Unless it matters that these files have recent timestamps, do not
>use "touch", merely to ensure presence of a file.  We often use a
>simple redirection.
Done

>A tangent (to the topic of testing, but relevant to the whole
>patch).  I notice 'stash' is mentioned on the topic, but I do not
>see changes to the codepath that is specific to 'stash', and changes
>to the tests do not demonstrate existing breakage.  The lack of code
>changes probably is because something shared, which is pretected
>with magic guard lifted by the patch, is called from 'stash' as well
>as 'add', or something?
Yes, the previous patch enabled attr with git-stash which was only blocked
at the shared dir.c GUARD_PATHSPEC level. I thought attr was working for gi=
t-stash
but I was wrong after a few more manual tests.
So I added PATHSPEC_ATTR as a mask to stash's parse_pathspec and parse_path=
spec_file.

 builtin/add.c                  |   7 ++-
 builtin/stash.c                |   4 +-
 dir.c                          |  13 ++--
 t/t6135-pathspec-with-attrs.sh | 109 +++++++++++++++++++++++++++++++--
 4 files changed, 117 insertions(+), 16 deletions(-)

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
index 1ad496985a..9c77d3e4e4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1760,7 +1760,7 @@ static int push_stash(int argc, const char **argv, co=
nst char *prefix,
 		}
 	}
=20
-	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
+	parse_pathspec(&ps, PATHSPEC_ATTR, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX=
_ORIGIN,
 		       prefix, argv);
=20
 	if (pathspec_from_file) {
@@ -1773,7 +1773,7 @@ static int push_stash(int argc, const char **argv, co=
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
index 8486e4d56f..9bf9b53ca5 100644
--- a/dir.c
+++ b/dir.c
@@ -2174,12 +2174,13 @@ static int exclude_matches_pathspec(const char *pat=
h, int pathlen,
 		return 0;
=20
 	GUARD_PATHSPEC(pathspec,
-		       PATHSPEC_FROMTOP |
-		       PATHSPEC_MAXDEPTH |
-		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB |
-		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+                       PATHSPEC_FROMTOP |
+                       PATHSPEC_MAXDEPTH |
+                       PATHSPEC_LITERAL |
+                       PATHSPEC_GLOB |
+                       PATHSPEC_ICASE |
+                       PATHSPEC_EXCLUDE |
+                       PATHSPEC_ATTR);
=20
 	for (i =3D 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item =3D &pathspec->items[i];
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.s=
h
index f70c395e75..531b4f4d5e 100755
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
@@ -239,16 +254,100 @@ test_expect_success 'fail on multiple attr specifier=
s in one pathspec item' '
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
+	# another commnad to replace it for the test.
+	test_must_fail git stash push ":(attr:labelB)" 2>actual &&
+	test_i18ngrep "magic not supported" actual
+'
+
+test_expect_success 'fail if attr magic is used in --pathspec-from-file wh=
en not implemented' '
+	# This is like the test above but for attr magic pass in via --pathspec-f=
rom-file.
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
+test_expect_success 'check that attr magic works for git' '
+'
+
 test_expect_success 'abort on giving invalid label on the command line' '
 	test_must_fail git ls-files . ":(attr:=E2=98=BA)"
 '
--=20
2.42.0.609.gbb76f46606-goog

