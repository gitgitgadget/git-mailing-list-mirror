Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC211F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeFEUr5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:47:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33437 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeFEUr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:47:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so3864426wro.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w008NNVk4wq5IZVb/fJSo8OnaoMkGqSdA0CIo4LxBXg=;
        b=NBXAaww4jSbZ+Xnkv8VBxFqMxNOqZ09+AF0Jyhb2BVP7dFIpdUpsqE2zZngh0oD4Sz
         kSB+V+zY2t95H/rfaR+fulk7DlEeHTOzF/ERTW5tylS0C4hp0iuhP1ot5xdhwwvIixqT
         zAAq5O1GYhXULKM98eXAgBctovIfwJdcXzQRJVDXlTKoXVAaVxwaNA+wTqzqIGuZJ5xb
         O/EYFVnXusMFwXxMcaQeUxlHaAVK/+YJX/3gGhqkfN3KxoaKGBqUx5W1a9bxqwkKfki8
         ZQUG1sINTkw2kMMvJH+NB7IhvVYhR6s7wrcY2X+oVJZuol6tPBQC8/JppPeVobLZD7UL
         7CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w008NNVk4wq5IZVb/fJSo8OnaoMkGqSdA0CIo4LxBXg=;
        b=tl4tvubmbBg5QFIM7SdF6OnGl663PCIm3AlATLAf0174a2mUiD09FiryxLFKzoakyY
         D5loIMVJ4+miDq9ApuQFU0evX0jfJjW1LZtvh9kmJEo+RbWQ8Zz0QcgDjBsxV1aAZPdG
         T6JgF8w6XffAfXzB5LKJSE59mRJ1X0GAMrCIyoEdIgqqBEEQMk5UFpi/9AJDRPEI+eA8
         Uw/N9bP8GKxV4m1ogla90j9yq0kctNoogVTTIgdJ+Kl4pu0qOxAHSPkT8ucRSN0K/GNx
         5hogS5R40OpzPzW/uOZknoZVbbAv371VHsw+7R+6zxa9XZn22qM6Lj5ddKeNdiNdt4Lp
         hoyA==
X-Gm-Message-State: APt69E01BR+jO3zr8WSsNHQTHLKnPvWzUMkUPDtgCW+wETOreldmfqsU
        1s9VWjS1+l9mWu4LzgV7k+nTndqM
X-Google-Smtp-Source: ADUXVKJmiyMVVSa3pYQKfUqj+5uhLhtI43JgpGPd3ztfYUlLhG/ydtAVKeIHmy3ZLJzc3OgkD6XA0w==
X-Received: by 2002:adf:de08:: with SMTP id b8-v6mr117688wrm.39.1528231674429;
        Tue, 05 Jun 2018 13:47:54 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u68-v6sm2390263wmu.40.2018.06.05.13.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:47:53 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 00/10] rerere: handle nested conflicts
Date:   Tue,  5 Jun 2018 22:52:09 +0100
Message-Id: <20180605215219.28783-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous round was at
<20180520211210.1248-1-t.gummerer@gmail.com>.

Thanks Junio for the comments on the previous round.

Changes since v2:
 - lowercase the first letter in some error/warning messages before
   marking them for translation
 - wrap paths in output in single quotes, for consistency, and to make
   some of the messages the same as ones that are already translated
 - mark messages in builtin/rerere.c for translation as well, which I
   had previously forgotten.
 - expanded the technical documentation on rerere.  The entire
   document is basically rewritten.
 - changed the test in 6/10 to just fake a conflict marker inside of
   one of the hunks instead of using an inner conflict created by a
   merge.  This is to make sure the codepath is still hit after we
   handle inner conflicts properly.
 - added tests for handling inner conflict markers
 - added one commit to recalculate the conflict ID when an unresolved
   conflict is committed, and the subsequent operation conflicts again
   in the same file.  More explanation in the commit message of that
   commit.

range-diff below.  A few commits changed enough for range-diff
to give up showing the differences in those, they are probably best
reviewed as the whole patch anyway:

1:  901b638400 ! 1:  2825342cc2 rerere: unify error message when read_cache fails
    @@ -1,6 +1,6 @@
     Author: Thomas Gummerer <t.gummerer@gmail.com>
     
    -    rerere: unify error message when read_cache fails
    +    rerere: unify error messages when read_cache fails
     
         We have multiple different variants of the error message we show to
         the user if 'read_cache' fails.  The "Could not read index" variant we
-:  ---------- > 2:  d1500028aa rerere: lowercase error messages
-:  ---------- > 3:  ed3601ee71 rerere: wrap paths in output in sq
2:  c48ffededd ! 4:  6ead84a199 rerere: mark strings for translation
    @@ -9,6 +9,28 @@
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    +diff --git a/builtin/rerere.c b/builtin/rerere.c
    +--- a/builtin/rerere.c
    ++++ b/builtin/rerere.c
    +@@
    + 	if (!strcmp(argv[0], "forget")) {
    + 		struct pathspec pathspec;
    + 		if (argc < 2)
    +-			warning("'git rerere forget' without paths is deprecated");
    ++			warning(_("'git rerere forget' without paths is deprecated"));
    + 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
    + 			       prefix, argv + 1);
    + 		return rerere_forget(&pathspec);
    +@@
    + 			const char *path = merge_rr.items[i].string;
    + 			const struct rerere_id *id = merge_rr.items[i].util;
    + 			if (diff_two(rerere_path(id, "preimage"), path, path, path))
    +-				die("unable to generate diff for '%s'", rerere_path(id, NULL));
    ++				die(_("unable to generate diff for '%s'"), rerere_path(id, NULL));
    + 		}
    + 	} else
    + 		usage_with_options(rerere_usage, options);
    +
     diff --git a/rerere.c b/rerere.c
     --- a/rerere.c
     +++ b/rerere.c
    @@ -53,14 +75,14 @@
      	io.input = fopen(path, "r");
      	io.io.wrerror = 0;
      	if (!io.input)
    --		return error_errno("Could not open %s", path);
    -+		return error_errno(_("Could not open %s"), path);
    +-		return error_errno("could not open '%s'", path);
    ++		return error_errno(_("could not open '%s'"), path);
      
      	if (output) {
      		io.io.output = fopen(output, "w");
      		if (!io.io.output) {
    --			error_errno("Could not write %s", output);
    -+			error_errno(_("Could not write %s"), output);
    +-			error_errno("could not write '%s'", output);
    ++			error_errno(_("could not write '%s'"), output);
      			fclose(io.input);
      			return -1;
      		}
    @@ -68,18 +90,18 @@
      
      	fclose(io.input);
      	if (io.io.wrerror)
    --		error("There were errors while writing %s (%s)",
    -+		error(_("There were errors while writing %s (%s)"),
    +-		error("there were errors while writing '%s' (%s)",
    ++		error(_("there were errors while writing '%s' (%s)"),
      		      path, strerror(io.io.wrerror));
      	if (io.io.output && fclose(io.io.output))
    --		io.io.wrerror = error_errno("Failed to flush %s", path);
    -+		io.io.wrerror = error_errno(_("Failed to flush %s"), path);
    +-		io.io.wrerror = error_errno("failed to flush '%s'", path);
    ++		io.io.wrerror = error_errno(_("failed to flush '%s'"), path);
      
      	if (hunk_no < 0) {
      		if (output)
      			unlink_or_warn(output);
    --		return error("Could not parse conflict hunks in %s", path);
    -+		return error(_("Could not parse conflict hunks in %s"), path);
    +-		return error("could not parse conflict hunks in '%s'", path);
    ++		return error(_("could not parse conflict hunks in '%s'"), path);
      	}
      	if (io.io.wrerror)
      		return -1;
    @@ -105,21 +127,21 @@
      	 * Mark that "postimage" was used to help gc.
      	 */
      	if (utime(rerere_path(id, "postimage"), NULL) < 0)
    --		warning_errno("failed utime() on %s",
    -+		warning_errno(_("failed utime() on %s"),
    +-		warning_errno("failed utime() on '%s'",
    ++		warning_errno(_("failed utime() on '%s'"),
      			      rerere_path(id, "postimage"));
      
      	/* Update "path" with the resolution */
      	f = fopen(path, "w");
      	if (!f)
    --		return error_errno("Could not open %s", path);
    -+		return error_errno(_("Could not open %s"), path);
    +-		return error_errno("could not open '%s'", path);
    ++		return error_errno(_("could not open '%s'"), path);
      	if (fwrite(result.ptr, result.size, 1, f) != 1)
    --		error_errno("Could not write %s", path);
    -+		error_errno(_("Could not write %s"), path);
    +-		error_errno("could not write '%s'", path);
    ++		error_errno(_("could not write '%s'"), path);
      	if (fclose(f))
    --		return error_errno("Writing %s failed", path);
    -+		return error_errno(_("Writing %s failed"), path);
    +-		return error_errno("writing '%s' failed", path);
    ++		return error_errno(_("writing '%s' failed"), path);
      
      out:
      	free(cur.ptr);
    @@ -134,8 +156,8 @@
      
      	if (write_locked_index(&the_index, &index_lock,
      			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    --		die("Unable to write new index file");
    -+		die(_("Unable to write new index file"));
    +-		die("unable to write new index file");
    ++		die(_("unable to write new index file"));
      }
      
      static void remove_variant(struct rerere_id *id)
    @@ -179,8 +201,8 @@
      		return rr_cache_exists;
      
      	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
    --		die("Could not create directory %s", git_path_rr_cache());
    -+		die(_("Could not create directory %s"), git_path_rr_cache());
    +-		die("could not create directory '%s'", git_path_rr_cache());
    ++		die(_("could not create directory '%s'"), git_path_rr_cache());
      	return 1;
      }
      
    @@ -188,8 +210,8 @@
      	 */
      	ret = handle_cache(path, sha1, NULL);
      	if (ret < 1)
    --		return error("Could not parse conflict hunks in '%s'", path);
    -+		return error(_("Could not parse conflict hunks in '%s'"), path);
    +-		return error("could not parse conflict hunks in '%s'", path);
    ++		return error(_("could not parse conflict hunks in '%s'"), path);
      
      	/* Nuke the recorded resolution for the conflict */
      	id = new_rerere_id(sha1);
    @@ -214,11 +236,11 @@
      	filename = rerere_path(id, "postimage");
      	if (unlink(filename)) {
      		if (errno == ENOENT)
    --			error("no remembered resolution for %s", path);
    -+			error(_("no remembered resolution for %s"), path);
    +-			error("no remembered resolution for '%s'", path);
    ++			error(_("no remembered resolution for '%s'"), path);
      		else
    --			error_errno("cannot unlink %s", filename);
    -+			error_errno(_("cannot unlink %s"), filename);
    +-			error_errno("cannot unlink '%s'", filename);
    ++			error_errno(_("cannot unlink '%s'"), filename);
      		goto fail_exit;
      	}
      
    @@ -235,8 +257,8 @@
      	item = string_list_insert(rr, path);
      	free_rerere_id(item);
      	item->util = id;
    --	fprintf(stderr, "Forgot resolution for %s\n", path);
    -+	fprintf_ln(stderr, _("Forgot resolution for %s"), path);
    +-	fprintf(stderr, "Forgot resolution for '%s'\n", path);
    ++	fprintf(stderr, _("Forgot resolution for '%s'\n"), path);
      	return 0;
      
      fail_exit:
3:  e29449406f < -:  ---------- rerere: add some documentation
-:  ---------- > 5:  caad276aca rerere: add some documentation
4:  3b41520b28 ! 6:  ad88a6b8a8 rerere: fix crash when conflict goes unresolved
    @@ -23,14 +23,18 @@
         Now when 'rerere clear' for example is run, it will segfault in
         'has_rerere_resolution', because status is NULL.
     
    -    To fix this, remove the rerere ID from the MERGE_RR file in case we
    -    can't handle it, and remove the folder for the ID.  Removing it
    -    unconditionally is fine here, because if the user would have resolved
    -    the conflict and ran rerere, the entry would no longer be in the
    -    MERGE_RR file, so we wouldn't have this problem in the first place,
    -    while if the conflict was not resolved, the only thing that's left in
    -    the folder is the 'preimage', which by itself will be regenerated by
    -    git if necessary, so the user won't loose any work.
    +    To fix this, remove the rerere ID from the MERGE_RR file in the case
    +    when we can't handle it, and remove the corresponding variant from
    +    .git/rr-cache/.  Removing it unconditionally is fine here, because if
    +    the user would have resolved the conflict and ran rerere, the entry
    +    would no longer be in the MERGE_RR file, so we wouldn't have this
    +    problem in the first place, while if the conflict was not resolved,
    +    the only thing that's left in the folder is the 'preimage', which by
    +    itself will be regenerated by git if necessary, so the user won't
    +    loose any work.
    +
    +    Note that other variants that have the same conflict ID will not be
    +    touched.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    @@ -71,16 +75,13 @@
      	count_pre_post 0 0
      '
      
    -+test_expect_success 'rerere with extra conflict markers keeps working' '
    ++test_expect_success 'rerere with unexpected conflict markers does not crash' '
     +	git reset --hard &&
     +
     +	git checkout -b branch-1 master &&
     +	echo "bar" >test &&
     +	git add test &&
     +	git commit -q -m two &&
    -+	echo "baz" >test &&
    -+	git add test &&
    -+	git commit -q -m three &&
     +
     +	git reset --hard &&
     +	git checkout -b branch-2 master &&
    @@ -88,10 +89,10 @@
     +	git add test &&
     +	git commit -q -a -m one &&
     +
    -+	test_must_fail git merge branch-1~ &&
    -+	git add test &&
    -+	git commit -q -m "will solve conflicts later" &&
     +	test_must_fail git merge branch-1 &&
    ++	sed "s/bar/>>>>>>> a/" >test.tmp <test &&
    ++	mv test.tmp test &&
    ++	git rerere &&
     +
     +	git rerere clear
     +'
5:  411a4ee37e ! 7:  15f9efcba6 rerere: only return whether a path has conflicts or not
    @@ -67,13 +67,13 @@
      	if (io.io.wrerror)
     @@
      	if (io.io.output && fclose(io.io.output))
    - 		io.io.wrerror = error_errno(_("Failed to flush %s"), path);
    + 		io.io.wrerror = error_errno(_("failed to flush '%s'"), path);
      
     -	if (hunk_no < 0) {
     +	if (has_conflicts < 0) {
      		if (output)
      			unlink_or_warn(output);
    - 		return error(_("Could not parse conflict hunks in %s"), path);
    + 		return error(_("could not parse conflict hunks in '%s'"), path);
      	}
      	if (io.io.wrerror)
      		return -1;
6:  fc9f715913 = 8:  1490efaad3 rerere: factor out handle_conflict function
7:  f7dea09a0a < -:  ---------- rerere: teach rerere to handle nested conflicts
-:  ---------- > 9:  6619650c42 rerere: teach rerere to handle nested conflicts
-:  ---------- > 10:  4b11dce7dd rerere: recalculate conflict ID when unresolved conflict is committed

Thomas Gummerer (10):
  rerere: unify error messages when read_cache fails
  rerere: lowercase error messages
  rerere: wrap paths in output in sq
  rerere: mark strings for translation
  rerere: add some documentation
  rerere: fix crash when conflict goes unresolved
  rerere: only return whether a path has conflicts or not
  rerere: factor out handle_conflict function
  rerere: teach rerere to handle nested conflicts
  rerere: recalculate conflict ID when unresolved conflict is committed

 Documentation/technical/rerere.txt | 182 +++++++++++++++++++++
 builtin/rerere.c                   |   4 +-
 rerere.c                           | 246 ++++++++++++++---------------
 t/t4200-rerere.sh                  |  67 ++++++++
 4 files changed, 372 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

-- 
2.18.0.rc1.242.g61856ae69

