Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BE120248
	for <e@80x24.org>; Tue,  2 Apr 2019 23:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDBXDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 19:03:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35130 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDBXDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 19:03:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so7290255pgf.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0/pPOtl/Td+4Fxjp5sCMuPzhsSlY4r3asVn3YOuX3mY=;
        b=T9dvme49SM8K+JkuihKl/UZz7ryNsI6/watb9U+U+rDzmT2RuxBB6S+4dZl+ANkBPw
         1mJKMKalJx2+mr1Fy7HZHF4ApGcXweU2/jWjncODvdw/CgyyHTEXuGUIj7/JiLDKwrkm
         eUJcbPJDRsjLkGzhKDSv1giLd4Fob2M5YTjwiJgKEKDfTLqLcz3VBiTuigcdqsBTTXx7
         oG7zxthmzDOukpE367UDwl6ashxaDvSLvouxVhbDsdpEz8lsjj4WhEVZ8tiJP37KVTC6
         KL7FhF9M/0q7d5uXr4+DJLu79UuFSpt6A3ZIB3bgFjOq1QIDFpwf2bzq8GkcR5Zy8rKS
         wHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0/pPOtl/Td+4Fxjp5sCMuPzhsSlY4r3asVn3YOuX3mY=;
        b=dPyMSwg2RZOJv323bhJ2oAe9PkwtdVSNQ17yqt+jJi6NXh1oJzBsOXydTSz/vbb8Cl
         fqdJ6jrfcCdd8ZjflekhDCdzyOz6yRXK0EQHHDU+Wgno5ljez9XV8P0mrFMet0bElMDf
         YW1TxVIuTdyRGi/EhXw2XDFRSSEczxJBnEjPI+dFF8njvSLZVROGo2PrjID//bMEaAxS
         dbThirjKgokryGwfJsJ1MBFc2GzgAU1r2TYJhBAsKgNBW6GtvOwYQUpnDICYDALScr2i
         Q0VnYdWodUT9RM/8KHQqxnhFqjfmCBss5I8zNBjKGwmLiKnhYGPODV5nZ1RYN8mkYGxI
         iq6g==
X-Gm-Message-State: APjAAAW6A0bLP62QeeQ9USz/TIJtzjwhlxeAh02XfuyPMF7NXcY2k9cQ
        JnZx3EeTOYOm3t6VlH+LvjU1sH7X
X-Google-Smtp-Source: APXvYqwmuh/UG7vOp4jO7JJe8X17ewZETsweFyByy6Qhb6oZ+r7pd0sf8UXvpVGZJmgn+pMwdWy7Bw==
X-Received: by 2002:a65:51c5:: with SMTP id i5mr42158033pgq.189.1554246228919;
        Tue, 02 Apr 2019 16:03:48 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id i16sm22987669pgk.51.2019.04.02.16.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 16:03:47 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:03:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2.5 2/2] tag: prevent nested tags
Message-ID: <20190402230345.GA5004@dev-l>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey reported confusion on the mailing list about a nested tag
which was most likely created by mistake. Jeff King noted that this
isn't a very common case so, most likely, creating a tag-to-a-tag is a
user-error.

Prevent mistakes by erroring and providing advice on nested tags, unless
"--allow-nested-tag" is specified. Fix tests that fail as a result of
this change.

Add tests to ensure that nested tags are disallowed unless the
"--allow-nested-tag" option is provided.

This is the first use of the '%n$<fmt>' style of printf format in the
*.[ch] files in our codebase, but it's supported by POSIX[1] and there
are existing uses for it in po/*.po files, so hopefully it won't cause
any trouble. It's more obvious for translators than having to repeat the
argument three times because each use of '%s' could potentially have a
different string but this makes it obvious that they're the same.

[1]: http://pubs.opengroup.org/onlinepubs/7908799/xsh/fprintf.html

Reported-by: Robert Dailey <rcdailey.lists@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Hi all,

I forgot to incorporate Ævar's recommendation of using the '%n$<fmt>'
style of printf format. This patch now includes that.

Thanks,

Denton

 Documentation/config/advice.txt |  2 ++
 Documentation/git-tag.txt       | 16 +++++++++++++++-
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/tag.c                   | 23 ++++++++++++++++++++++-
 t/annotate-tests.sh             |  2 +-
 t/t0410-partial-clone.sh        |  2 +-
 t/t4205-log-pretty-formats.sh   |  2 +-
 t/t5305-include-tag.sh          |  2 +-
 t/t5500-fetch-pack.sh           |  2 +-
 t/t6302-for-each-ref-filter.sh  |  4 ++--
 t/t7004-tag.sh                  | 12 ++++++++++--
 t/t9350-fast-export.sh          |  4 ++--
 13 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 88620429ea..ec4f6ae658 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -90,4 +90,6 @@ advice.*::
 	waitingForEditor::
 		Print a message to the terminal whenever Git is waiting for
 		editor input from the user.
+	nestedTag::
+		Advice shown if a user attempts to recursively tag a tag object.
 --
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index a74e7b926d..e65548b1a0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
-	<tagname> [<commit> | <object>]
+	[--allow-nested-tag] <tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
 	[--points-at <object>] [--column[=<options>] | --no-column]
@@ -193,6 +193,20 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
+--allow-nested-tag::
+	Usually nestedly tagging a tag object is a mistake and the
+	command prevents you from making such a tag. This option
+	bypasses the safety and allows this to happen.
++
+Note that there is nothing logically wrong with nesting tags and, in
+fact, there may be some valid use-cases, such as showing a cryptographic
+chain of custody by signing someone else's signed tag. However, in
+practice, this is typically a mistake so we prevent it from happening by
+default unless specifically requested.
++
+Automatically erroring on nested tags was introduced in Git version
+2.22.0.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/advice.c b/advice.c
index 567209aa79..ce5f374ecd 100644
--- a/advice.c
+++ b/advice.c
@@ -26,6 +26,7 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
+int advice_nested_tag = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -81,6 +82,7 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
+	{ "nestedTag", &advice_nested_tag },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index f875f8cd8d..cb5d361614 100644
--- a/advice.h
+++ b/advice.h
@@ -26,6 +26,7 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
+extern int advice_nested_tag;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/tag.c b/builtin/tag.c
index faae364e0f..8df31e13f0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -22,7 +22,7 @@
 #include "ref-filter.h"
 
 static const char * const git_tag_usage[] = {
-	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
+	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [--allow-nested-tag]\n"
 		"\t\t<tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
@@ -198,6 +198,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
 struct create_tag_options {
 	unsigned int message_given:1;
 	unsigned int use_editor:1;
+	unsigned int allow_nested_tag;
 	unsigned int sign;
 	enum {
 		CLEANUP_NONE,
@@ -206,6 +207,17 @@ struct create_tag_options {
 	} cleanup_mode;
 };
 
+static const char message_advice_nested_tag[] =
+	N_("The object '%1$s' referred to by your new tag is already a tag.\n"
+	   "\n"
+	   "If you meant to create a tag of a tag, use:\n"
+	   "\n"
+	   "\tgit tag --allow-nested-tag %1$s\n"
+	   "\n"
+	   "If you meant to tag the object that it points to, use:\n"
+	   "\n"
+	   "\tgit tag %1$s^{}");
+
 static void create_tag(const struct object_id *object, const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
 		       struct object_id *prev, struct object_id *result)
@@ -218,6 +230,13 @@ static void create_tag(const struct object_id *object, const char *tag,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
+	if (type == OBJ_TAG && !opt->allow_nested_tag) {
+		error(_("refusing to make a nested tag"));
+		if (advice_nested_tag)
+			advise(_(message_advice_nested_tag), tag);
+		exit(1);
+	}
+
 	strbuf_addf(&header,
 		    "object %s\n"
 		    "type %s\n"
@@ -404,6 +423,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
 		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BOOL(0, "allow-nested-tag", &opt.allow_nested_tag,
+					N_("allow nested tags to be made")),
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 6da48a2e0a..9849ee30ea 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -70,7 +70,7 @@ test_expect_success 'blame 1 author' '
 
 test_expect_success 'blame by tag objects' '
 	git tag -m "test tag" testTag &&
-	git tag -m "test tag #2" testTag2 testTag &&
+	git tag -m "test tag #2" --allow-nested-tag testTag2 testTag &&
 	check_count -h testTag A 2 &&
 	check_count -h testTag2 A 2
 '
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bce02788e6..00922d4649 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -16,7 +16,7 @@ pack_as_from_promisor () {
 
 promise_and_delete () {
 	HASH=$(git -C repo rev-parse "$1") &&
-	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
+	git -C repo tag -a -m message my_annotated_tag --allow-nested-tag "$HASH" &&
 	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
 	# tag -d prints a message to stdout, so redirect it
 	git -C repo tag -d my_annotated_tag >/dev/null &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..039f652418 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -511,7 +511,7 @@ test_expect_success 'set up log decoration tests' '
 
 test_expect_success 'log decoration properly follows tag chain' '
 	git tag -a tag1 -m tag1 &&
-	git tag -a tag2 -m tag2 tag1 &&
+	git tag -a tag2 -m tag2 --allow-nested-tag tag1 &&
 	git tag -d tag1 &&
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index a5eca210b8..be17bfa9b4 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -68,7 +68,7 @@ test_expect_success 'check unpacked result (have commit, have tag)' '
 test_expect_success 'create hidden inner tag' '
 	test_commit commit &&
 	git tag -m inner inner HEAD &&
-	git tag -m outer outer inner &&
+	git tag -m outer --allow-nested-tag outer inner &&
 	git tag -d inner
 '
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 49c540b1e1..a71ac97a61 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -562,7 +562,7 @@ test_expect_success 'test --all wrt tag to non-commits' '
 		hello tag
 	EOF
 	) &&
-	git tag -a -m "tag -> tag" tag-to-tag $tag &&
+	git tag -a -m "tag -> tag" --allow-nested-tag tag-to-tag $tag &&
 
 	# `fetch-pack --all` should succeed fetching all those objects.
 	mkdir fetchall &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fc067ed672..5eed5da6d2 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup some history and refs' '
 	git checkout -b side &&
 	test_commit four &&
 	git tag -m "An annotated tag" annotated-tag &&
-	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
+	git tag -m "Annonated doubly" --allow-nested-tag doubly-annotated-tag annotated-tag &&
 
 	# Note that these "signed" tags might not actually be signed.
 	# Tests which care about the distinction should be marked
@@ -24,7 +24,7 @@ test_expect_success 'setup some history and refs' '
 		sign=
 	fi &&
 	git tag $sign -m "A signed tag" signed-tag &&
-	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
+	git tag $sign -m "Signed doubly" --allow-nested-tag doubly-signed-tag signed-tag &&
 
 	git checkout master &&
 	git update-ref refs/odd/spot master
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0b01862c23..d5e705fa1d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1265,7 +1265,7 @@ echo "A message for another tag" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to another tag should succeed' '
-	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
+	git tag -s -m "A message for another tag" --allow-nested-tag tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
 	test_cmp expect actual
 '
@@ -1690,7 +1690,7 @@ test_expect_success '--points-at finds annotated tags of commits' '
 '
 
 test_expect_success '--points-at finds annotated tags of tags' '
-	git tag -m "describing the v4.0 tag object" \
+	git tag -m "describing the v4.0 tag object" --allow-nested-tag \
 		annotated-again-v4.0 annotated-v4.0 &&
 	cat >expect <<-\EOF &&
 	annotated-again-v4.0
@@ -1700,6 +1700,14 @@ test_expect_success '--points-at finds annotated tags of tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'recursive tagging should fail without --allow-nested-tag' '
+	test_must_fail git tag -m nested nested annotated-v4.0
+'
+
+test_expect_success 'recursive tagging should pass with --allow-nested-tag' '
+	git tag --allow-nested-tag -m nested nested annotated-v4.0
+'
+
 test_expect_success 'multiple --points-at are OR-ed together' '
 	cat >expect <<-\EOF &&
 	v2.0
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..3f48d60d7f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -441,8 +441,8 @@ test_expect_success 'set-up a few more tags for tag export tests' '
 	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
 	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
 	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
-	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
-	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
+	git tag    tag-obj_tag     -m "tagging a tag" --allow-nested-tag tree_tag-obj &&
+	git tag -a tag-obj_tag-obj -m "tagging a tag" --allow-nested-tag tree_tag-obj
 '
 
 test_expect_success 'tree_tag'        '
-- 
2.21.0.832.gd5ec0d3bee

