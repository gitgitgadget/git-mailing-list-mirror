Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2341F461
	for <e@80x24.org>; Thu, 29 Aug 2019 18:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfH2S2J (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:28:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfH2S2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:28:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so4433007wrd.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykd9iGN3wvuEf5AyVDB/Zls4ohpUVZSTFkbVWZ/klbE=;
        b=oiXNXJAZttlOEhNtUQAb7NPQ1oHsSdsVVjt9A9nRoTMbzd04Gcsr/l0h6pegQPENyc
         T+UjXMvrbIa7uc82niH6RBwLg7aGK1KLSxW1hqAHigP1dvyLwpcZByEUYDKFFVCqyw1r
         GSxbWP1YzjpqiRO+F1mnWMO6G3/pLgZqkdCHC+UAbLzuqck8dxmDioeiw4S0MMr5bqu7
         i+vldPE50XEa/M2v0ItOHuFCAdQb8nwt9i5H9xD7tuB9pfKEzgKpxwqUfFX194ScHvMk
         FSNFmXVG9q+pCUMOJnjVTEEmqHI1rF2c75hvUYA5+kwSgisQ7voW+U0jm8c7Zs0Q49SZ
         hnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykd9iGN3wvuEf5AyVDB/Zls4ohpUVZSTFkbVWZ/klbE=;
        b=OVDzGmE75ddsLDUJJNDTV6DkP7nWUu3Jvt9nyV91cGuPGv1c1KQPFcM4aVvuMQRs4y
         aS9dVcghZBGT6ZW5Gb5s7V5HLK26uCXqmnvsvZR6Knzmt+JavEtOn/C3DbovEpePSRmB
         0zUkOROmk9172iaZ6CxWVa+ynMdur60vsGWTcnDlaqc597T3BX3+K1fzMN4rVBDZp/58
         6HsyUC7jme079qwvgYW8pIff7heauPIojiM0Nthpoiz+lcL9BBj7rMQMeezlc9/bZwRp
         R21rL7KHJyIPas1w+sJryJ+xwV4MiU3cD1y8+fVufXqcFiN/vCb5gk5IDPV/xAXmTpXs
         sOCg==
X-Gm-Message-State: APjAAAV9+9zd1jqm/xJo+eEqewubJ/1XNDzW0RfOH8d0ykySTBgq5OnF
        pGiGdnUHCEvJSyNPw++7w+R6nweP
X-Google-Smtp-Source: APXvYqwfq6IX6iab08fWRglh1oz7HQBoNM0Fmt2BdTPjltAuvrjnz7QvB6ts6BK1RwGTs8ybGckrfg==
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr11318326wrw.228.1567103285991;
        Thu, 29 Aug 2019 11:28:05 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id i18sm5168336wrp.91.2019.08.29.11.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:28:04 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] make sure stash refreshes the index properly
Date:   Thu, 29 Aug 2019 19:27:45 +0100
Message-Id: <20190829182748.43802-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190827101408.76757-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Martin for the review of the last round!

Changes compared to the previous round:
- always pass COMMIT_LOCK to write_locked_index
- don't write the error message in repo_refresh_and_write_index, but
  let the caller handle that.  This means that we no longer change any
  error messages.  Potential cleanups in that area can come later.
- Drop the lock variable to the scope it needs.

Range diff below:

1:  7249a3cf4e ! 1:  1f25fe227c factor out refresh_and_write_cache function
    @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
      	unlink(am_path(state, "dirtyindex"));
      
     -	refresh_and_write_cache();
    -+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK) < 0)
    -+		die(_("failed to refresh cache"));
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0) < 0)
    ++		die(_("unable to write index file"));
      
      	if (repo_index_has_changes(the_repository, NULL, &sb)) {
      		write_state_bool(state, "dirtyindex", 1);
    @@ cache.h: void fill_stat_cache_info(struct index_state *istate, struct cache_entr
     +/*
     + * Refresh the index and write it to disk.
     + *
    ++ * 'refresh_flags' is passed directly to 'refresh_index()', while
    ++ * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
    ++ * the lockfile is always either committed or rolled back.
    ++ *
     + * Return 1 if refreshing the cache failed, -1 if writing the cache to
     + * disk failed, 0 on success.
     + */
    @@ read-cache.c: static void show_file(const char * fmt, const char * name, int in_
     +	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
     +	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
     +		return 1;
    -+	if (write_locked_index(repo->index, &lock_file, write_flags))
    -+		return error(_("unable to write index file"));
    ++	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
    ++		return -1;
     +	return 0;
     +}
     +
2:  de5b8c1529 ! 2:  148a65d649 merge: use refresh_and_write_cache
    @@ Commit message
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct commit_list *common,
    - 	struct lock_file lock = LOCK_INIT;
    + 			      struct commit_list *remoteheads,
    + 			      struct commit *head)
    + {
    +-	struct lock_file lock = LOCK_INIT;
      	const char *head_arg = "HEAD";
      
     -	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
     -	refresh_cache(REFRESH_QUIET);
     -	if (write_locked_index(&the_index, &lock,
     -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    --		return error(_("Unable to write index."));
    -+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
    -+		return -1;
    ++	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
    + 		return error(_("Unable to write index."));
      
      	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
    ++		struct lock_file lock = LOCK_INIT;
      		int clean, x;
    + 		struct commit *result;
    + 		struct commit_list *reversed = NULL;
     @@ builtin/merge.c: static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
      {
      	struct object_id result_tree, result_commit;
    @@ builtin/merge.c: static int merge_trivial(struct commit *head, struct commit_lis
     -	refresh_cache(REFRESH_QUIET);
     -	if (write_locked_index(&the_index, &lock,
     -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    --		return error(_("Unable to write index."));
    -+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
    -+		return -1;
    ++	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
    + 		return error(_("Unable to write index."));
      
      	write_tree_trivial(&result_tree);
    - 	printf(_("Wonderful.\n"));
3:  d9efda0f2a ! 3:  e0f6815192 stash: make sure to write refreshed cache
    @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
      
      	read_cache_preload(NULL);
     -	if (refresh_cache(REFRESH_QUIET))
    -+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK))
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0))
      		return -1;
      
      	if (write_cache_as_tree(&c_tree, 0, NULL))
    @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
      
      	if (quiet) {
     -		if (refresh_cache(REFRESH_QUIET))
    -+		if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK))
    ++		if (refresh_and_write_cache(REFRESH_QUIET, 0))
      			warning("could not refresh index");
      	} else {
      		struct child_process cp = CHILD_PROCESS_INIT;
    @@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct st
      
      	read_cache_preload(NULL);
     -	refresh_cache(REFRESH_QUIET);
    -+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK) < 0) {
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0) < 0) {
     +		ret = -1;
     +		goto done;
     +	}
    @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
      	}
      
     -	if (refresh_cache(REFRESH_QUIET)) {
    -+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK)) {
    ++	if (refresh_and_write_cache(REFRESH_QUIET, 0)) {
      		ret = -1;
      		goto done;
      	}

Thomas Gummerer (3):
  factor out refresh_and_write_cache function
  merge: use refresh_and_write_cache
  stash: make sure to write refreshed cache

 builtin/am.c     | 16 ++--------------
 builtin/merge.c  | 17 +++++------------
 builtin/stash.c  | 11 +++++++----
 cache.h          | 13 +++++++++++++
 read-cache.c     | 17 +++++++++++++++++
 t/t3903-stash.sh | 16 ++++++++++++++++
 6 files changed, 60 insertions(+), 30 deletions(-)

-- 
2.23.0.rc2.194.ge5444969c9
