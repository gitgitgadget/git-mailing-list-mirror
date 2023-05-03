Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C183DC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 22:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjECWFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 18:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECWFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 18:05:52 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5677ED0
        for <git@vger.kernel.org>; Wed,  3 May 2023 15:05:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso3795948276.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683151547; x=1685743547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MpLhkv6D4t6E3AfGToBecFFjemXolAiCfbOrVplI0I=;
        b=Xg7KpVoJiuSZ6qISE7wnqjcqQ2nSKtR3caw8q5UrlXESD765YdMTxg7bLG3+p2uCvi
         cDGpNOWP2RRR7dWK51O6fXLwEwTMkpj3uc8bXeh0Q5s6TmUNiNustph0Bujg3PdEa0YJ
         xMiAoG/bYn/4Lg3vTYuzQ4Hn3bRZqdRsCtB6O0Ask16+v5GUjAO44kYFRMVWLUuOv5F4
         ok+n+gFX/PpoOm+DWfNET1pzEJXJUzywQdmf6lE98sLUlmvfJETz57UV2As9WkvqcC59
         odMEbhjgwtB/5uhLlHtTXeDZcm3DRLXJbcF0GGUGKbT3Kzlh03F49fgDQ8HGFgWASZtI
         cRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683151547; x=1685743547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MpLhkv6D4t6E3AfGToBecFFjemXolAiCfbOrVplI0I=;
        b=hNdBtnYvh7CbTgP+rpZMh8M0stkWiTnbJjitGrmc7/FOdigLBFyUDZZ2BuCpMm83OI
         Hs4KjoTt4VbEdlZxKf/eg7wx2JtgmKiXyB81FRwkJKZkIL1PshYdv3NMqCpKQj2FIx+X
         qBJoMl/2yp9y/Qt1KjAELnpoUM33U5gttJ+3nxGpWjcqdZX0oeMi3jsH41TY7Y60YKdz
         wEZ49F2mplOLb01lwTezltlXEXBIXSlMh4DGVmrLyylVJbYMuL07sU2F3t3PvohafFIj
         hsIlaPRfl+vb5NBWVpqHKDCyuEfSxu3uGnuPo2KVP6jzc5aEHozeqGDrigskPPCMdYHx
         IWPA==
X-Gm-Message-State: AC+VfDystdiZK4ncX6iFaDs9ayHeoAaL7RLJ5M52DBhSUaMPTn7CAp2r
        sZr7r+hUWai7bQxCmBIz+cLw8aV2qbuFXsNikiRpiA==
X-Google-Smtp-Source: ACHHUZ7xl/AeQ7U/HgSYTpwlcQKuzOkyywsfpIYitdJrPKfMJCFk8tFal3FUc4yRI44IhgzjziC85g==
X-Received: by 2002:a25:160a:0:b0:b9f:fce9:f133 with SMTP id 10-20020a25160a000000b00b9ffce9f133mr3696347ybw.30.1683151546900;
        Wed, 03 May 2023 15:05:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l67-20020a0dfb46000000b00545a08184c6sm5615302ywf.86.2023.05.03.15.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:05:46 -0700 (PDT)
Date:   Wed, 3 May 2023 18:05:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Message-ID: <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new multi-valued configuration option,
`pack.extraCruftTips` as an alternative means to mark certain objects in
the cruft pack as rescued, even if they would otherwise be pruned.

Traditionally, cruft packs are generated in one of two ways:

  - When not pruning, all packed and loose objects which do not appear
    in the any of the packs which wil remain (as indicated over stdin,
    with `--cruft`) are packed separately into a cruft pack.

  - When pruning, the above process happens, with two additional tweaks.
    Instead of adding every object into the cruft pack, only objects
    which have mtime that is within the grace period are kept. In
    addition, a "rescuing" traversal is performed over the remaining
    cruft objects to keep around cruft objects which would have aged out
    of the repository, but are reachable from other cruft objects which
    have not yet aged out.

This works well for repositories which have all of their "interesting"
objects worth keeping around reachable via at least one reference.

However, there is no option to be able to keep around certain objects
that have otherwise aged out of the grace period. The only way to retain
those objects is:

  - to point a reference at them, which may be undesirable or
    infeasible,
  - to track them via the reflog, which may be undesirable since the
    reflog's lifetime is limited to that of the reference it's tracking
    (and callers may want to keep those unreachable objects around for
    longer)
  - to extend the grace period, which may keep around other objects that
    the caller *does* want to discard,
  - or, to force the caller to construct the pack of objects they want
    to keep themselves, and then mark the pack as kept by adding a
    ".keep" file.

This patch introduces a new configuration, `pack.extraCruftTips` which
allows the caller to specify a program (or set of programs) whose output
is treated as a set of objects to treat as "kept", even if they are
unreachable and have aged out of the retention period.

The implementation is straightforward, and pretends as if any objects
listed by one of the `pack.extraCruftTips` hooks is recent-enough to
warrant rescuing (even for non-pruning GCs).

We then add those as tips to another reachability traversal (along with
any recent objects, if pruning), marking every object along the way as
cruft (and thus retaining it in the cruft pack).

A potential alternative here is to introduce a new mode to alter the
contents of the reachable pack instead of the cruft one. One could
imagine a new option to `pack-objects`, say `--extra-tips` that does the
same thing as above, adding the visited set of objects along the
traversal to the pack.

But this has the unfortunate side-effect of altering the reachability
closure of that pack. If parts of the unreachable object graph mentioned
by one or more of the "extra tips" programs is not closed, then the
resulting pack won't be either. This makes it impossible in the general
case to write out reachability bitmaps for that pack, since closure is a
requirement there.

Instead, keep these unreachable objects in the cruft pack instead, to
ensure that we can continue to have a pack containing just reachable
objects, which is always safe to write a bitmap over.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Here is a reworked version of the pack.extraCruftTips feature to reuse
parts of the "rescue old/unreachable, but reachable-from-recent" traversal.

It is somewhat more complicated than the original, and I would
definitely appreciate a close review from a second (or third) set of
eyes ;-).

Range-diff against v2:
1:  da1711b13b ! 1:  27a7f16aab builtin/pack-objects.c: introduce `pack.extraCruftTips`
    @@ Commit message
         is treated as a set of objects to treat as "kept", even if they are
         unreachable and have aged out of the retention period.

    -    The implementation is straightforward: after determining the set of
    -    objects to pack into the cruft pack (either by calling
    -    `enumerate_cruft_objects()` or `enumerate_and_traverse_cruft_objects()`)
    -    we figure out if there are any program(s) we need to consult in order to
    -    determine if there are any objects which we need to "rescue". We then
    -    add those as tips to another reachability traversal, marking every
    -    object along the way as cruft (and thus retaining it in the cruft pack).
    +    The implementation is straightforward, and pretends as if any objects
    +    listed by one of the `pack.extraCruftTips` hooks is recent-enough to
    +    warrant rescuing (even for non-pruning GCs).
    +
    +    We then add those as tips to another reachability traversal (along with
    +    any recent objects, if pruning), marking every object along the way as
    +    cruft (and thus retaining it in the cruft pack).

         A potential alternative here is to introduce a new mode to alter the
         contents of the reachable pack instead of the cruft one. One could
    @@ builtin/pack-objects.c

      /*
       * Objects we are going to pack are collected in the `to_pack` structure.
    -@@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
    +@@ builtin/pack-objects.c: static void enumerate_cruft_objects(void)
      	stop_progress(&progress_state);
      }

    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
     +{
     +	struct child_process cmd = CHILD_PROCESS_INIT;
     +	struct strbuf buf = STRBUF_INIT;
    -+	FILE *out = NULL;
    ++	FILE *out;
     +	int ret = 0;
     +
     +	cmd.use_shell = 1;
     +	cmd.out = -1;
     +
     +	strvec_push(&cmd.args, args);
    -+	strvec_pushv(&cmd.env, (const char **)local_repo_env);
     +
    -+	if (start_command(&cmd)) {
    -+		ret = -1;
    -+		goto done;
    -+	}
    ++	if (start_command(&cmd))
    ++		return -1;
     +
     +	out = xfdopen(cmd.out, "r");
    -+	while (strbuf_getline_lf(&buf, out) != EOF) {
    ++	while (strbuf_getline(&buf, out) != EOF) {
     +		struct object_id oid;
     +		struct object *obj;
    ++		int type;
     +		const char *rest;
     +
     +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
     +			goto done;
     +		}
     +
    -+		obj = parse_object(the_repository, &oid);
    ++		type = oid_object_info(the_repository, &oid, NULL);
    ++		if (type < 0)
    ++			continue;
    ++
    ++		obj = lookup_object_by_type(the_repository, &oid, type);
     +		if (!obj)
     +			continue;
     +
    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
     +	return ret;
     +}
     +
    -+static int enumerate_extra_cruft_tips(void)
    ++static void add_extra_cruft_tips_to_traversal(struct rev_info *revs)
     +{
    -+	struct rev_info revs;
     +	const struct string_list *programs;
     +	int ret = 0;
     +	size_t i;
     +
     +	if (git_config_get_string_multi("pack.extracrufttips", &programs))
    -+		return ret;
    -+
    -+	repo_init_revisions(the_repository, &revs, NULL);
    -+
    -+	revs.tag_objects = 1;
    -+	revs.tree_objects = 1;
    -+	revs.blob_objects = 1;
    -+
    -+	revs.include_check = cruft_include_check;
    -+	revs.include_check_obj = cruft_include_check_obj;
    -+
    -+	revs.ignore_missing_links = 1;
    ++		return;
     +
     +	if (progress)
     +		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
     +	nr_seen = 0;
     +	for (i = 0; i < programs->nr; i++) {
    -+		ret = enumerate_extra_cruft_tips_1(&revs,
    ++		ret = enumerate_extra_cruft_tips_1(revs,
     +						   programs->items[i].string);
     +		if (ret)
     +			break;
    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
     +
     +	if (ret)
     +		die(_("unable to enumerate additional cruft tips"));
    -+
    -+	if (prepare_revision_walk(&revs))
    -+		die(_("revision walk setup failed"));
    -+	if (progress)
    -+		progress_state = start_progress(_("Traversing extra cruft objects"), 0);
    -+	nr_seen = 0;
    -+
    -+	/*
    -+	 * Retain all objects reachable from extra tips via
    -+	 * show_cruft_commit(), and show_cruft_object(), regardless of
    -+	 * their mtime.
    -+	 */
    -+	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
    -+	stop_progress(&progress_state);
    -+
    -+	return ret;
     +}
     +
    - static void read_cruft_objects(void)
    + static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
      {
    - 	struct strbuf buf = STRBUF_INIT;
    + 	struct packed_git *p;
    + 	struct rev_info revs;
    +-	int ret;
    ++	int ret = 0;
    +
    + 	repo_init_revisions(the_repository, &revs, NULL);
    +
    +@@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
    +
    + 	revs.ignore_missing_links = 1;
    +
    +-	if (progress)
    +-		progress_state = start_progress(_("Enumerating cruft objects"), 0);
    +-	ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
    +-						     set_cruft_mtime, 1);
    +-	stop_progress(&progress_state);
    ++	if (cruft_expiration) {
    ++		if (progress)
    ++			progress_state = start_progress(_("Enumerating cruft objects"), 0);
    ++		ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
    ++							     set_cruft_mtime, 1);
    ++		stop_progress(&progress_state);
    ++	}
    ++
    ++	add_extra_cruft_tips_to_traversal(&revs);
    +
    + 	if (ret)
    + 		die(_("unable to add cruft objects"));
     @@ builtin/pack-objects.c: static void read_cruft_objects(void)
    - 	else
    +
    + 	if (cruft_expiration)
    + 		enumerate_and_traverse_cruft_objects(&fresh_packs);
    +-	else
    ++	else {
    ++		/*
    ++		 * call both enumerate_cruft_objects() and
    ++		 * enumerate_and_traverse_cruft_objects(), since:
    ++		 *
    ++		 *   - the former is required to implement non-pruning GCs
    ++		 *   - the latter is a noop for "cruft_expiration == 0", but
    ++		 *     picks up any additional tips mentioned via
    ++		 *     `pack.extraCruftTips`.
    ++		 */
      		enumerate_cruft_objects();
    ++		enumerate_and_traverse_cruft_objects(&fresh_packs);
    ++	}

    -+	enumerate_extra_cruft_tips();
    -+
      	strbuf_release(&buf);
      	string_list_clear(&discard_packs, 0);
    - 	string_list_clear(&fresh_packs, 0);

      ## t/t5329-pack-objects-cruft.sh ##
     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend via loose' '

 Documentation/config/pack.txt |  11 +++
 builtin/pack-objects.c        | 104 +++++++++++++++++++--
 t/t5329-pack-objects-cruft.sh | 171 ++++++++++++++++++++++++++++++++++
 3 files changed, 279 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index d4c7c9d4e4..0b79bd1751 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -67,6 +67,17 @@ pack.deltaCacheLimit::
 	result once the best match for all objects is found.
 	Defaults to 1000. Maximum value is 65535.

+pack.extraCruftTips::
+	When generating a cruft pack, use the shell to execute the
+	specified command(s), and interpret their output as additional
+	tips of objects to keep in the cruft pack, regardless of their
+	age.
++
+Output must contain exactly one hex object ID per line, and nothing
+else. Objects which cannot be found in the repository are ignored.
+Multiple hooks are supported, but all must exit successfully, else no
+cruft pack will be generated.
+
 pack.threads::
 	Specifies the number of threads to spawn when searching for best
 	delta matches.  This requires that linkgit:git-pack-objects[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5b466839b..6f6e7872cd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,6 +44,7 @@
 #include "pack-mtimes.h"
 #include "parse-options.h"
 #include "wrapper.h"
+#include "run-command.h"

 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -3543,11 +3544,85 @@ static void enumerate_cruft_objects(void)
 	stop_progress(&progress_state);
 }

+static int enumerate_extra_cruft_tips_1(struct rev_info *revs, const char *args)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *out;
+	int ret = 0;
+
+	cmd.use_shell = 1;
+	cmd.out = -1;
+
+	strvec_push(&cmd.args, args);
+
+	if (start_command(&cmd))
+		return -1;
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline(&buf, out) != EOF) {
+		struct object_id oid;
+		struct object *obj;
+		int type;
+		const char *rest;
+
+		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
+			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
+			goto done;
+		}
+
+		type = oid_object_info(the_repository, &oid, NULL);
+		if (type < 0)
+			continue;
+
+		obj = lookup_object_by_type(the_repository, &oid, type);
+		if (!obj)
+			continue;
+
+		display_progress(progress_state, ++nr_seen);
+		add_pending_object(revs, obj, "");
+	}
+
+	ret = finish_command(&cmd);
+
+done:
+	if (out)
+		fclose(out);
+	strbuf_release(&buf);
+	child_process_clear(&cmd);
+
+	return ret;
+}
+
+static void add_extra_cruft_tips_to_traversal(struct rev_info *revs)
+{
+	const struct string_list *programs;
+	int ret = 0;
+	size_t i;
+
+	if (git_config_get_string_multi("pack.extracrufttips", &programs))
+		return;
+
+	if (progress)
+		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
+	nr_seen = 0;
+	for (i = 0; i < programs->nr; i++) {
+		ret = enumerate_extra_cruft_tips_1(revs,
+						   programs->items[i].string);
+		if (ret)
+			break;
+	}
+	stop_progress(&progress_state);
+
+	if (ret)
+		die(_("unable to enumerate additional cruft tips"));
+}
+
 static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
 {
 	struct packed_git *p;
 	struct rev_info revs;
-	int ret;
+	int ret = 0;

 	repo_init_revisions(the_repository, &revs, NULL);

@@ -3560,11 +3635,15 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs

 	revs.ignore_missing_links = 1;

-	if (progress)
-		progress_state = start_progress(_("Enumerating cruft objects"), 0);
-	ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
-						     set_cruft_mtime, 1);
-	stop_progress(&progress_state);
+	if (cruft_expiration) {
+		if (progress)
+			progress_state = start_progress(_("Enumerating cruft objects"), 0);
+		ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
+							     set_cruft_mtime, 1);
+		stop_progress(&progress_state);
+	}
+
+	add_extra_cruft_tips_to_traversal(&revs);

 	if (ret)
 		die(_("unable to add cruft objects"));
@@ -3639,8 +3718,19 @@ static void read_cruft_objects(void)

 	if (cruft_expiration)
 		enumerate_and_traverse_cruft_objects(&fresh_packs);
-	else
+	else {
+		/*
+		 * call both enumerate_cruft_objects() and
+		 * enumerate_and_traverse_cruft_objects(), since:
+		 *
+		 *   - the former is required to implement non-pruning GCs
+		 *   - the latter is a noop for "cruft_expiration == 0", but
+		 *     picks up any additional tips mentioned via
+		 *     `pack.extraCruftTips`.
+		 */
 		enumerate_cruft_objects();
+		enumerate_and_traverse_cruft_objects(&fresh_packs);
+	}

 	strbuf_release(&buf);
 	string_list_clear(&discard_packs, 0);
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 303f7a5d84..3ad16a9fca 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -739,4 +739,175 @@ test_expect_success 'cruft objects are freshend via loose' '
 	)
 '

+test_expect_success 'additional cruft tips may be specified via pack.extraCruftTips' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# Create a handful of objects.
+		#
+		#   - one reachable commit, "base", designated for the reachable
+		#     pack
+		#   - one unreachable commit, "cruft.discard", which is marked
+		#     for deletion
+		#   - one unreachable commit, "cruft.old", which would be marked
+		#     for deletion, but is rescued as an extra cruft tip
+		#   - one unreachable commit, "cruft.new", which is not marked
+		#     for deletion
+		test_commit base &&
+		git branch -M main &&
+
+		git checkout --orphan discard &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.discard &&
+
+		git checkout --orphan old &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.old &&
+		cruft_old="$(git rev-parse HEAD)" &&
+
+		git checkout --orphan new &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.new &&
+		cruft_new="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D discard old new &&
+		git reflog expire --all --expire=all &&
+
+		# mark cruft.old with an mtime that is many minutes
+		# older than the expiration period, and mark cruft.new
+		# with an mtime that is in the future (and thus not
+		# eligible for pruning).
+		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $cruft_old)" &&
+		test-tool chmtime +1000 "$objdir/$(test_oid_to_path $cruft_new)" &&
+
+		# Write the list of cruft objects we expect to
+		# accumulate, which is comprised of everything reachable
+		# from cruft.old and cruft.new, but not cruft.discard.
+		git rev-list --objects --no-object-names \
+			$cruft_old $cruft_new >cruft.raw &&
+		sort cruft.raw >cruft.expect &&
+
+		# Write the script to list extra tips, which are limited
+		# to cruft.old, in this case.
+		write_script extra-tips <<-EOF &&
+		echo $cruft_old
+		EOF
+		git config pack.extraCruftTips ./extra-tips &&
+
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# Ensure that the "old" objects are removed after
+		# dropping the pack.extraCruftTips hook.
+		git config --unset pack.extraCruftTips &&
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+
+		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
+		cp cruft.expect cruft.old &&
+		sort cruft.raw >cruft.expect &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# ensure objects which are no longer in the cruft pack were
+		# removed from the repository
+		for object in $(comm -13 cruft.expect cruft.old)
+		do
+			test_must_fail git cat-file -t $object || return 1
+		done
+	)
+'
+
+test_expect_success 'multi-valued pack.extraCruftTips' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		git branch -M main &&
+
+		git checkout --orphan cruft.a &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.a &&
+		cruft_a="$(git rev-parse HEAD)" &&
+
+		git checkout --orphan cruft.b &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.b &&
+		cruft_b="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D cruft.a cruft.b &&
+		git reflog expire --all --expire=all &&
+
+		echo "echo $cruft_a" | write_script extra-tips.a &&
+		echo "echo $cruft_b" | write_script extra-tips.b &&
+		echo "false" | write_script extra-tips.c &&
+
+		git rev-list --objects --no-object-names $cruft_a $cruft_b \
+			>cruft.raw &&
+		sort cruft.raw >cruft.expect &&
+
+		# ensure that each extra cruft tip is saved by its
+		# respective hook
+		git config --add pack.extraCruftTips ./extra-tips.a &&
+		git config --add pack.extraCruftTips ./extra-tips.b &&
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# ensure that a dirty exit halts cruft pack generation
+		git config --add pack.extraCruftTips ./extra-tips.c &&
+		test_must_fail git repack --cruft -d 2>err &&
+		grep "unable to enumerate additional cruft tips" err &&
+
+		# and that the existing cruft pack is left alone
+		test_path_is_file "$mtimes"
+	)
+'
+
+test_expect_success 'additional cruft blobs via pack.extraCruftTips' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		blob=$(echo "unreachable" | git hash-object -w --stdin) &&
+
+		# mark the unreachable blob we wrote above as having
+		# aged out of the retention period
+		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $blob)" &&
+
+		# Write the script to list extra tips, which is just the
+		# extra blob as above.
+		write_script extra-tips <<-EOF &&
+		echo $blob
+		EOF
+		git config pack.extraCruftTips ./extra-tips &&
+
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft >actual &&
+		echo $blob >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--
2.40.1.477.g73ad7b90e1.dirty
