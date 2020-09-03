Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE6C433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EB320722
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DOvu4u/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgICTl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 15:41:57 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC10C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 12:41:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g6so2642472pfi.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3qCDvXvPHYdoBsOv2wfkl68UJTF6Hh8hHTvt4eOIJoA=;
        b=DOvu4u/bU01J5mGRGslRdy2AfTEzlcx+LK8BK8uIn2WrIzelKvJQ1NyU1nQKkg+Agb
         XGZ6E7TDpaEbGQeiE4yUfLTk6tnYzg7RvuexJILPJycp8sK0FCC8iL0ycSrhniOCCA5k
         3mya9WCqOmXHbGKuvGZx0qt3Eo0Kk2J92RdhxdNqzjw7Z9tbPN6KzMYUJBsZKGNvnMDY
         UzH1D71QlSGG1sLZ/+oyzQJuhAdcvrRzVJ/YirnpR2++KzNzWmIX88Lw0XMzylwXVf7A
         FVUAJdZm8Ck4vf/IV2JWW1YDOlseNkot8NFztLEQN0HO5ugwkMQZxriA6Hu5dVeWh0tr
         DuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3qCDvXvPHYdoBsOv2wfkl68UJTF6Hh8hHTvt4eOIJoA=;
        b=R1z+cbsL0QneKfT69Y9tB8qDTBhRXyBBIhjBCmbccvAtIgDdL7KulPjSiLmg39j0Zi
         N4fQ3vscom5cnA4psbMS2de/TWb6AtxCsQ+GL6uXNqdKSetmiMw3pvI2D0F5M3+ZBiYv
         zegcXMhzUWF1aqMtB3xImdqW0cHyZmH/6olHPMcwxkuGf2Vv/G7W0IRc0YycyEB/JMvM
         O0vR+QcdZ8MSfiL3re3DiAVT6y4pjpKQdXN/ackIf+CHB6Gvy4bopz5+kpXjyAv1z2fY
         87m8vxINJwvMzBvLe/h2+BIx1bucfd0wwCFto+8TFf7sE5T5A9I3K+bfp74iK9tabhog
         /tnw==
X-Gm-Message-State: AOAM532HXmirSgzw9PfqKzwJYU9b3u0fOZM7HY5ySF6JIznNKZF7MSBz
        a+nCnYg4hYHhEtYwT4cOX+n0PZF0iajhJIydalh5XSbN/7/AelxyknkEYh6PT0QSCcoF11j1DKL
        Ic9k6G/LnGwXhTWcqygAJPLHTPlYeXJtng8b3aI2H3oZC2LN+CnTjaUVeZOWztAxUHGljed0HTm
        RS
X-Google-Smtp-Source: ABdhPJy9aTRZFwudkNfFLhe4RteRojmN+pbCzXWOe/jRp0UAlam7mkHoloIADsNGHAqEaaVb4lOBU/Qf1mFZlyYQDNqB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7481:b029:d0:89f1:9e35 with
 SMTP id h1-20020a1709027481b02900d089f19e35mr3897452pll.17.1599162114317;
 Thu, 03 Sep 2020 12:41:54 -0700 (PDT)
Date:   Thu,  3 Sep 2020 12:41:48 -0700
In-Reply-To: <xmqqo8mnaa6k.fsf@gitster.c.googlers.com>
Message-Id: <20200903194148.2738968-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8mnaa6k.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v3] fetch: no FETCH_HEAD display if --no-write-fetch-head
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

887952b8c6 ("fetch: optionally allow disabling FETCH_HEAD update",
2020-08-18) introduced the ability to disable writing to FETCH_HEAD
during fetch, but did not suppress the "<source> -> FETCH_HEAD" message
when this ability is used. This message is misleading in this case,
because FETCH_HEAD is not written. Also, because "fetch" is used to
lazy-fetch missing objects in a partial clone, this significantly
clutters up the output in that case since the objects to be fetched are
potentially numerous.

Therefore, suppress this message when --no-write-fetch-head is passed.
In order to do this, a new variable that keeps track of what the user
said explicitly about FETCH_HEAD (which may or may not have the same
value as the existing one tracking whether FETCH_HEAD is written) is
introduced.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on origin/jt/lazy-fetch.

OK - updated the code, added a test for the "--dry-run
--no-write-fetch-head" case, and updated commit message and code
comment.
---
 builtin/fetch.c          | 21 +++++++++++++++++----
 t/t0410-partial-clone.sh |  7 +++++--
 t/t5510-fetch.sh         | 25 +++++++++++++++++--------
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 320ba9471d..9addd1f2d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int user_specified_write_fetch_head = 1;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
 static int progress = -1;
@@ -164,7 +165,7 @@ static struct option builtin_fetch_options[] = {
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
-	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+	OPT_BOOL(0, "write-fetch-head", &user_specified_write_fetch_head,
 		 N_("write fetched references to the FETCH_HEAD file")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOL('u', "update-head-ok", &update_head_ok,
@@ -1023,11 +1024,20 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else if (user_specified_write_fetch_head) {
+				/*
+				 * If the user specified --write-fetch-head
+				 * (or, equivalently, did not specify
+				 * --no-write-fetch-head), inform the user that
+				 * this ref was written to FETCH_HEAD (or, if
+				 * --dry-run was specified, would have been
+				 *  written).
+				 */
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
@@ -1822,8 +1832,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	/* FETCH_HEAD never gets updated in --dry-run mode */
-	if (dry_run)
+	/*
+	 * FETCH_HEAD never gets updated in --dry-run mode, nor if user passed
+	 * --no-write-fetch-head
+	 */
+	if (dry_run || !user_specified_write_fetch_head)
 		write_fetch_head = 0;
 
 	if (all) {
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index d681e90640..584a039b85 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -183,7 +183,7 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 '
 
 test_expect_success 'fetching of missing objects' '
-	rm -rf repo &&
+	rm -rf repo err &&
 	test_create_repo server &&
 	test_commit -C server foo &&
 	git -C server repack -a -d --write-bitmap-index &&
@@ -194,7 +194,10 @@ test_expect_success 'fetching of missing objects' '
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "origin" &&
-	git -C repo cat-file -p "$HASH" &&
+	git -C repo cat-file -p "$HASH" 2>err &&
+
+	# Ensure that no spurious FETCH_HEAD messages are written
+	! grep FETCH_HEAD err &&
 
 	# Ensure that the .promisor file is written, and check that its
 	# associated packfile contains the object
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2a1abe91f0..83b2504519 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -543,16 +543,25 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
 '
 
-test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
-	rm -f .git/FETCH_HEAD &&
-	git fetch --dry-run . &&
-	! test -f .git/FETCH_HEAD
+test_expect_success 'fetch --dry-run does not touch FETCH_HEAD, but still prints what would be written' '
+	rm -f .git/FETCH_HEAD err &&
+	git fetch --dry-run . 2>err &&
+	! test -f .git/FETCH_HEAD &&
+	grep FETCH_HEAD err
 '
 
-test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
-	rm -f .git/FETCH_HEAD &&
-	git fetch --no-write-fetch-head . &&
-	! test -f .git/FETCH_HEAD
+test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD, and does not print what would be written' '
+	rm -f .git/FETCH_HEAD err &&
+	git fetch --no-write-fetch-head . 2>err &&
+	! test -f .git/FETCH_HEAD &&
+	! grep FETCH_HEAD err
+'
+
+test_expect_success '--no-write-fetch-head and --dry-run does not touch FETCH_HEAD, and does not print what would be written' '
+	rm -f .git/FETCH_HEAD err &&
+	git fetch --dry-run --no-write-fetch-head . 2>err &&
+	! test -f .git/FETCH_HEAD &&
+	! grep FETCH_HEAD err
 '
 
 test_expect_success '--write-fetch-head gets defeated by --dry-run' '
-- 
2.28.0.526.ge36021eeef-goog

