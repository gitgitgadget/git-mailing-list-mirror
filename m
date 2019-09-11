Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC841F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfIKSVP (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:21:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56043 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfIKSVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:21:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so4605580wmg.5
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2qWeXSSKScZBnI7US8FQsXFlm6yKA4rQEPtftt7WRU=;
        b=RGTGNIiY6hbPQI91ccKaTow/+k7Yjn8CAcASKWvbN3SqPTX7tPFa1PdhGyoMt3iikg
         QwNdab+erTEJo/+adSM0A+8aiHvftTIpUBhOWssQ2cELSPpjNpzStG2TSXciQQaFuyBg
         r8/usqG3Ws2Id40DXv4kq0l3gvzI0aoCjcB5gYF3gm7iobIQ29gtjrtxWe1FebN1Zgtp
         1kkFZU91tLQB6/eSfLfj++JtIRwnNzN/cJhJ4CsgRsDH5hdc/DC4dUGx/9xPGjl4YVLg
         UuHUM92ypCKKpPMd8vl4sbp5dNGkiURF/qzS8reMJuzlB55lpEuQyvVvYCz0vCve1CLU
         sTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2qWeXSSKScZBnI7US8FQsXFlm6yKA4rQEPtftt7WRU=;
        b=ojZOyzZ1IGaXuX4O7VRMA/hdW2Q+5FnECgNsU1q9XbbUvdIVo47znzj9mkBDfTbKzQ
         Z4XT7Kz8C++0ksCcKKWeHVW8HFXEjw2heD8+RkGWCkeI5J0FuyADejjiZYSLZgbgYbFJ
         mMSxcrlkO+ath5sPdSqY1Vimbh6NHybJmFUANU+0khZ24VD3ayelLeFbXAACF20/yfpl
         jGz5IFf4FrrXWZcfMIngWIwJ84nrE/NmQzBw9CqKMRg9rZhi/k9BRVvjH1sap+QEv+bW
         rllD3A0RTH//PkdJq24JFyV44SjtbO9txJ2FsUu29NDsY24nLfdRpdwIZgKHBG3Zi8F7
         msag==
X-Gm-Message-State: APjAAAXBbL/MM7fb8qXGb3Ky3IyoJaA13Tt3KazssAOQ5wkz84gPpkOO
        qbxeVl6s2EhrE+4sBKMkbmhI61Mp
X-Google-Smtp-Source: APXvYqwA5d7awTiL1gY6zWL9T9hpKSgrEaqLxXfGFXRjElqONHW1aXPBHpqVL3UhssJA2pD8ySDWqg==
X-Received: by 2002:a05:600c:3d0:: with SMTP id z16mr4954669wmd.32.1568226071066;
        Wed, 11 Sep 2019 11:21:11 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id r17sm21193273wrt.68.2019.09.11.11.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 11:21:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/3] make sure stash refreshes the index properly
Date:   Wed, 11 Sep 2019 19:20:24 +0100
Message-Id: <20190911182027.41284-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190903191041.10470-1-t.gummerer@gmail.com>
References: <20190903191041.10470-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to the previous round this round introduces a gentle flag for
refresh_and_write_{index,cache}, which should make this function
suitable for use in the Dscho's builtin-add-i series.  The latter will have to be 

I have also pushed this to https://github.com/tgummerer/git tg/stash-refresh-index

Range-diff below:

1:  7cc9f5fff4 ! 1:  2a7bebb20f factor out refresh_and_write_cache function
    @@ Commit message
         about failing to write the index.  However for other callers we're
         going to convert in subsequent patches we will need this distinction.
     
    +    Helped-by: Martin Ågren <martin.agren@gmail.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      ## builtin/am.c ##
    @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
      	unlink(am_path(state, "dirtyindex"));
      
     -	refresh_and_write_cache();
    -+	if (refresh_and_write_cache(REFRESH_QUIET, 0) < 0)
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0)
     +		die(_("unable to write index file"));
      
      	if (repo_index_has_changes(the_repository, NULL, &sb)) {
    @@ cache.h: extern struct index_state the_index;
      #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
      #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
      #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
    -+#define refresh_and_write_cache(refresh_flags, write_flags) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), NULL, NULL, NULL)
    ++#define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
      #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
      #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
      #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
    @@ cache.h: void fill_stat_cache_info(struct index_state *istate, struct cache_entr
     + * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
     + * the lockfile is always either committed or rolled back.
     + *
    ++ * If 'gentle' is passed, errors locking the index are ignored.
    ++ *
     + * Return 1 if refreshing the index returns an error, -1 if writing
     + * the index to disk fails, 0 on success.
     + *
    -+ * Note that if refreshing the index returns an error, we don't write
    -+ * the result to disk.
    ++ * Note that if refreshing the index returns an error, we still write
    ++ * out the result (unless locking failed).
     + */
    -+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);
    ++int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
     +
      struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
      
    @@ read-cache.c: static void show_file(const char * fmt, const char * name, int in_
      	printf(fmt, name);
      }
      
    -+int repo_refresh_and_write_index(struct  repository *repo,
    ++int repo_refresh_and_write_index(struct repository *repo,
     +				 unsigned int refresh_flags,
     +				 unsigned int write_flags,
    ++				 int gentle,
     +				 const struct pathspec *pathspec,
     +				 char *seen, const char *header_msg)
     +{
     +	struct lock_file lock_file = LOCK_INIT;
    ++	int fd, ret = 0;
     +
    -+	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
    -+	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg)) {
    -+		rollback_lock_file(&lock_file);
    -+		return 1;
    -+	}
    -+	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
    ++	fd = repo_hold_locked_index(repo, &lock_file, 0);
    ++	if (!gentle && fd < 0)
     +		return -1;
    -+	return 0;
    ++	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
    ++		ret = 1;
    ++	if (0 <= fd && write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
    ++		ret = -1;
    ++	rollback_lock_file(&lock_file);
    ++	return ret;
     +}
     +
     +
2:  0367d938b1 ! 2:  555c982eae merge: use refresh_and_write_cache
    @@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct comm
     -	refresh_cache(REFRESH_QUIET);
     -	if (write_locked_index(&the_index, &lock,
     -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    -+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
    ++	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
      		return error(_("Unable to write index."));
      
      	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
    @@ builtin/merge.c: static int merge_trivial(struct commit *head, struct commit_lis
     -	refresh_cache(REFRESH_QUIET);
     -	if (write_locked_index(&the_index, &lock,
     -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    -+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
    ++	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
      		return error(_("Unable to write index."));
      
      	write_tree_trivial(&result_tree);
3:  8ed3df9fec ! 3:  cf74fe6053 stash: make sure to write refreshed cache
    @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
      
      	read_cache_preload(NULL);
     -	if (refresh_cache(REFRESH_QUIET))
    -+	if (refresh_and_write_cache(REFRESH_QUIET, 0))
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
      		return -1;
      
      	if (write_cache_as_tree(&c_tree, 0, NULL))
    @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
      
      	if (quiet) {
     -		if (refresh_cache(REFRESH_QUIET))
    -+		if (refresh_and_write_cache(REFRESH_QUIET, 0))
    ++		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
      			warning("could not refresh index");
      	} else {
      		struct child_process cp = CHILD_PROCESS_INIT;
    @@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct st
      
      	read_cache_preload(NULL);
     -	refresh_cache(REFRESH_QUIET);
    -+	if (refresh_and_write_cache(REFRESH_QUIET, 0) < 0) {
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0) {
     +		ret = -1;
     +		goto done;
     +	}
    @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
      	}
      
     -	if (refresh_cache(REFRESH_QUIET)) {
    -+	if (refresh_and_write_cache(REFRESH_QUIET, 0)) {
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0)) {
      		ret = -1;
      		goto done;
      	}

Thomas Gummerer (3):
  factor out refresh_and_write_cache function
  merge: use refresh_and_write_cache
  stash: make sure to write refreshed cache

 builtin/am.c     | 16 ++--------------
 builtin/merge.c  | 13 +++----------
 builtin/stash.c  | 11 +++++++----
 cache.h          | 18 ++++++++++++++++++
 read-cache.c     | 21 +++++++++++++++++++++
 t/t3903-stash.sh | 16 ++++++++++++++++
 6 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.23.0.rc2.194.ge5444969c9

