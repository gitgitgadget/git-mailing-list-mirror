Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA847C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A831361051
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhIFQxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhIFQxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 12:53:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344DC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 09:52:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so5436257wmn.4
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aaSpS5UBkuV9PWI9pW89BOxjMRIwPO6QGiDvGeP32Dw=;
        b=VrJzfXy88jRwjbVh7ZwCALoqQSrHMpMhelRutfHl5HEYLlKmC00tUESLlJHy43osM7
         UwG/SoqKU6J1mG/Xz0PLP3YfGbfODOHW4iRgR5gemvF1dW6UopKrJ096Ed2qU2Jcldlc
         ZdvXQX/d7AOoqnxkpT4t+I2EWgxrHxESgjO3CIb/rJtjlxylrXgYixiV3FCvSqO2Js5j
         Xdzc877QeqCu0EBH9CtI8bM1AIYw93AxSZlergA0Dg07lz2MSVNpcpqJvnD1scdWJmz5
         CKwgUnInGlVeZ0rHcCNQUlyMViDjpmva7o0nxIZSIbFc0s5hHbX2nQWAwPJi6BV1oLuV
         CNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aaSpS5UBkuV9PWI9pW89BOxjMRIwPO6QGiDvGeP32Dw=;
        b=DKXvVhfOFYOA3Pa5bLTOeHjxcQ/7IFc0lNc3tQ5iwpf96tsjGxcHDfqkIxDoFzLepR
         gu/2NqidFcXqbjGUgS0bNZTifnr4Uhd0GLC+fN2gNWKW1Nbwtunk0PNd5qtnzSIZn77n
         4Lj0P7zE8fj6S5FOi+bPB2ToXPqacmx3kBqjuWNoIM/Bcoj50H3mPy2W2HDVQM9zf+J/
         sx3iNkyGvcHrgt7IrfEqhM17gpbozo+td89jGa2lKRAyHmKS45pPPOmt8SASH/kRWK2C
         wecaqr6QpVVYwqhyBROmYj7WMAA1D4tnHtonZEpbUagBpWUydnv2QzvmdXp1bNRwh49m
         BDIw==
X-Gm-Message-State: AOAM5322oFHLG4QifsDS0twq2W0mdaDUq9RHEraI/nq2ZT4myfgm1yll
        xtDZrN0hqs8Qrask4lC+OJmtJ/YyoFE=
X-Google-Smtp-Source: ABdhPJyBIj9cluvC2T295ihPjtisN/FhJtaczJTfhHb1Pf69PzyAkcE01bezknLgnim28vRGvd0sEg==
X-Received: by 2002:a1c:9d50:: with SMTP id g77mr48834wme.67.1630947144291;
        Mon, 06 Sep 2021 09:52:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm45997wmj.29.2021.09.06.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:52:23 -0700 (PDT)
Message-Id: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 16:52:17 +0000
Subject: [PATCH v2 0/5] Gets rid of "if reflog exists, append to it regardless of config settings"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in
CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com

v2 addresses all outstanding comments.

There is one open question: three is a line marked "XXX" in commit 995d450d
("refs: trim newline from reflog message"). I'd think it would print a
double newline before (which seems wrong), but I'm unsure how to get the
codepath to run.

Han-Wen Nienhuys (5):
  refs: trim newline from reflog message
  test-ref-store: tweaks to for-each-reflog-ent format
  t1400: use test-helper ref-store to inspect reflog contents
  refs: drop force_create argument of create_reflog API
  RFC: refs: reflog entries aren't written based on reflog existence.

 builtin/checkout.c             |  2 +-
 builtin/show-branch.c          |  4 +-
 reflog-walk.c                  |  6 +--
 refs.c                         |  9 ++--
 refs.h                         |  4 +-
 refs/debug.c                   |  5 +-
 refs/files-backend.c           | 88 +++++++++++++---------------------
 refs/packed-backend.c          |  3 +-
 refs/refs-internal.h           |  2 +-
 t/helper/test-ref-store.c      |  8 ++--
 t/t1400-update-ref.sh          | 21 ++++----
 t/t1405-main-ref-store.sh      |  6 +--
 t/t1406-submodule-ref-store.sh |  6 +--
 13 files changed, 71 insertions(+), 93 deletions(-)


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1067%2Fhanwen%2Freflog-touch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1067/hanwen/reflog-touch-v2
Pull-Request: https://github.com/git/git/pull/1067

Range-diff vs v1:

 1:  d48207d6858 ! 1:  995d450da42 test-ref-store: tweaks to for-each-reflog-ent format
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    test-ref-store: tweaks to for-each-reflog-ent format
     +    refs: trim newline from reflog message
      
     -    Follow the reflog format more closely, so it can be used for comparing
     -    reflogs in tests without using inspecting files under .git/logs/
     +    Commit 523fa69c ("reflog: cleanse messages in the refs.c layer") standardizes
     +    how write entries into the reflog. This commit standardizes how we get messages
     +    out of the reflog. Before, the files backend implicitly added '\n' to the end of
     +    reflog message on reading, which creates a subtle incompatibility with alternate
     +    ref storage backends, such as reftable.
     +
     +    We address this by stripping LF from the message before we pass it to the
     +    user-provided callback.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## t/helper/test-ref-store.c ##
     -@@ t/helper/test-ref-store.c: static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
     - 		       const char *committer, timestamp_t timestamp,
     - 		       int tz, const char *msg, void *cb_data)
     - {
     --	printf("%s %s %s %"PRItime" %d %s\n",
     --	       oid_to_hex(old_oid), oid_to_hex(new_oid),
     --	       committer, timestamp, tz, msg);
     -+	const char *newline = strchr(msg, '\n') ? "" : "\n";
     -+	printf("%s %s %s %" PRItime " %+05d\t%s%s", oid_to_hex(old_oid),
     -+	       oid_to_hex(new_oid), committer, timestamp, tz, msg, newline);
     - 	return 0;
     + ## builtin/show-branch.c ##
     +@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     + 				show_one_commit(rev[i], 1);
     + 			}
     + 			else
     +-				puts(reflog_msg[i]);
     ++				puts(reflog_msg[i]); /* XXX - this puts a
     ++							newline. Did we put two
     ++							newlines beforehand? */
     + 
     + 			if (is_head)
     + 				head_at = i;
     +
     + ## reflog-walk.c ##
     +@@ reflog-walk.c: void get_reflog_message(struct strbuf *sb,
     + 
     + 	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
     + 	len = strlen(info->message);
     +-	if (len > 0)
     +-		len--; /* strip away trailing newline */
     + 	strbuf_add(sb, info->message, len);
       }
       
     +@@ reflog-walk.c: void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
     + 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
     + 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
     + 		if (oneline) {
     +-			printf("%s: %s", selector.buf, info->message);
     ++			printf("%s: %s\n", selector.buf, info->message);
     + 		}
     + 		else {
     +-			printf("Reflog: %s (%s)\nReflog message: %s",
     ++			printf("Reflog: %s (%s)\nReflog message: %s\n",
     + 			       selector.buf, info->email, info->message);
     + 		}
     + 
     +
     + ## refs/files-backend.c ##
     +@@ refs/files-backend.c: static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
     + 	int tz;
     + 	const char *p = sb->buf;
     + 
     +-	/* old SP new SP name <email> SP time TAB msg LF */
     +-	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
     +-	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
     ++	/* old SP new SP name <email> SP time TAB msg */
     ++	if (!sb->len || parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
     + 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
     +-	    !(email_end = strchr(p, '>')) ||
     +-	    email_end[1] != ' ' ||
     ++	    !(email_end = strchr(p, '>')) || email_end[1] != ' ' ||
     + 	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
     + 	    !message || message[0] != ' ' ||
     +-	    (message[1] != '+' && message[1] != '-') ||
     +-	    !isdigit(message[2]) || !isdigit(message[3]) ||
     +-	    !isdigit(message[4]) || !isdigit(message[5]))
     ++	    (message[1] != '+' && message[1] != '-') || !isdigit(message[2]) ||
     ++	    !isdigit(message[3]) || !isdigit(message[4]) ||
     ++	    !isdigit(message[5]))
     + 		return 0; /* corrupt? */
     + 	email_end[1] = '\0';
     + 	tz = strtol(message + 1, NULL, 10);
     +@@ refs/files-backend.c: static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
     + 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
     + 				scanp = bp;
     + 				endp = bp + 1;
     ++				strbuf_trim_trailing_newline(&sb);
     + 				ret = show_one_reflog_ent(&sb, fn, cb_data);
     + 				strbuf_reset(&sb);
     + 				if (ret)
     +@@ refs/files-backend.c: static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
     + 				 * Process it, and we can end the loop.
     + 				 */
     + 				strbuf_splice(&sb, 0, 0, buf, endp - buf);
     ++				strbuf_trim_trailing_newline(&sb);
     + 				ret = show_one_reflog_ent(&sb, fn, cb_data);
     + 				strbuf_reset(&sb);
     + 				break;
     +@@ refs/files-backend.c: static int files_for_each_reflog_ent(struct ref_store *ref_store,
     + 	if (!logfp)
     + 		return -1;
     + 
     +-	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
     ++	while (!ret && !strbuf_getline(&sb, logfp))
     + 		ret = show_one_reflog_ent(&sb, fn, cb_data);
     + 	fclose(logfp);
     + 	strbuf_release(&sb);
     +@@ refs/files-backend.c: static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
     + 	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
     + 				   message, policy_cb)) {
     + 		if (!cb->newlog)
     +-			printf("would prune %s", message);
     ++			printf("would prune %s\n", message);
     + 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
     +-			printf("prune %s", message);
     ++			printf("prune %s\n", message);
     + 	} else {
     + 		if (cb->newlog) {
     +-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
     +-				oid_to_hex(ooid), oid_to_hex(noid),
     +-				email, timestamp, tz, message);
     ++			fprintf(cb->newlog, "%s %s %s %" PRItime " %+05d\t%s\n",
     ++				oid_to_hex(ooid), oid_to_hex(noid), email,
     ++				timestamp, tz, message);
     + 			oidcpy(&cb->last_kept_oid, noid);
     + 		}
     + 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
     +-			printf("keep %s", message);
     ++			printf("keep %s\n", message);
     + 	}
     + 	return 0;
     + }
      
       ## t/t1405-main-ref-store.sh ##
      @@ t/t1405-main-ref-store.sh: test_expect_success 'for_each_reflog()' '
     - 
       test_expect_success 'for_each_reflog_ent()' '
       	$RUN for-each-reflog-ent HEAD >actual &&
     -+	cat actual &&
       	head -n1 actual | grep one &&
      -	tail -n2 actual | head -n1 | grep recreate-main
      +	tail -n1 actual | grep recreate-main
     @@ t/t1405-main-ref-store.sh: test_expect_success 'for_each_reflog()' '
       
       test_expect_success 'for_each_reflog_ent_reverse()' '
       	$RUN for-each-reflog-ent-reverse HEAD >actual &&
     - 	head -n1 actual | grep recreate-main &&
     +-	head -n1 actual | grep recreate-main &&
      -	tail -n2 actual | head -n1 | grep one
      +	tail -n1 actual | grep one
       '
 -:  ----------- > 2:  11b296a55e9 test-ref-store: tweaks to for-each-reflog-ent format
 2:  dab8e115faf ! 3:  9ec09cc64cd t1400: use test-helper ref-store to inspect reflog contents
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t1400-update-ref.sh ##
     -@@ t/t1400-update-ref.sh: test_expect_success 'symref empty directory removal' '
     - 	test_path_is_file .git/logs/HEAD
     - '
     +@@ t/t1400-update-ref.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + . ./test-lib.sh
       
     + Z=$ZERO_OID
      +TAB='	'
     + 
     + m=refs/heads/main
     + n_dir=refs/heads/gu
     +@@ t/t1400-update-ref.sh: test_expect_success 'symref empty directory removal' '
       cat >expect <<EOF
       $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
       $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
 3:  048e2d17077 = 4:  aa25fd9b7de refs: drop force_create argument of create_reflog API
 4:  2f11fd77180 ! 5:  f6a7c5ad56e RFC: refs: reflog entries aren't written based on reflog existence.
     @@ refs/files-backend.c: static int log_ref_setup(struct files_ref_store *refs,
       	char *logfile;
       
      +	*logfd = -1;
     ++	if (!force_create && !should_autocreate_reflog(refname))
     ++		return 0;
     ++
       	files_reflog_path(refs, &logfile_sb, refname);
       	logfile = strbuf_detach(&logfile_sb, NULL);
       
     -@@ refs/files-backend.c: static int log_ref_setup(struct files_ref_store *refs,
     - 			else
     - 				strbuf_addf(err, "unable to append to '%s': %s",
     - 					    logfile, strerror(errno));
     +-	if (force_create || should_autocreate_reflog(refname)) {
     +-		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
     +-			if (errno == ENOENT)
     +-				strbuf_addf(err, "unable to create directory for '%s': "
     +-					    "%s", logfile, strerror(errno));
     +-			else if (errno == EISDIR)
     +-				strbuf_addf(err, "there are still logs under '%s'",
     +-					    logfile);
     +-			else
     +-				strbuf_addf(err, "unable to append to '%s': %s",
     +-					    logfile, strerror(errno));
      -
     - 			goto error;
     - 		}
     +-			goto error;
     +-		}
      -	} else {
      -		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
      -		if (*logfd < 0) {
     @@ refs/files-backend.c: static int log_ref_setup(struct files_ref_store *refs,
      -				goto error;
      -			}
      -		}
     ++	if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
     ++		if (errno == ENOENT)
     ++			strbuf_addf(err,
     ++				    "unable to create directory for '%s': "
     ++				    "%s",
     ++				    logfile, strerror(errno));
     ++		else if (errno == EISDIR)
     ++			strbuf_addf(err, "there are still logs under '%s'",
     ++				    logfile);
     ++		else
     ++			strbuf_addf(err, "unable to append to '%s': %s",
     ++				    logfile, strerror(errno));
       	}
       
       	if (*logfd >= 0)
     -@@ refs/files-backend.c: static int log_ref_setup(struct files_ref_store *refs,
     + 		adjust_shared_perm(logfile);
       
       	free(logfile);
     - 	return 0;
     +-	return 0;
      -
     - error:
     - 	free(logfile);
     - 	return -1;
     +-error:
     +-	free(logfile);
     +-	return -1;
     ++	return (*logfd < 0) ? -1 : 0;
     + }
     + 
     + static int files_create_reflog(struct ref_store *ref_store, const char *refname,
      
       ## t/t1400-update-ref.sh ##
      @@ t/t1400-update-ref.sh: test_expect_success "(not) changed .git/$m" '
     @@ t/t1400-update-ref.sh: test_expect_success "(not) changed .git/$m" '
       	GIT_COMMITTER_DATE="2005-05-26 23:30" \
       	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
      @@ t/t1400-update-ref.sh: test_expect_success 'symref empty directory removal' '
     - 	test_path_is_file .git/logs/HEAD
     - '
       
     --TAB='	'
       cat >expect <<EOF
       $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
      -$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
     @@ t/t1400-update-ref.sh: test_expect_success 'symref empty directory removal' '
       test_expect_success "verifying $m's log (logged by touch)" '
       	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
       	test-tool ref-store main for-each-reflog-ent $m > actual &&
     -@@ t/t1400-update-ref.sh: test_expect_success "set $m (logged by config)" '
     - 	test $A = $(git show-ref -s --verify $m)
     - '
     - 
     -+TAB='	'
     - cat >expect <<EOF
     - $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
     - $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch

-- 
gitgitgadget
