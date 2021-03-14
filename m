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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39EC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698AC64EBE
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhCNSsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhCNSrp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF330C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e10so7569580wro.12
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J2jh1PYyVEhq/KuWyOAy6rLIOb7OTmdmTDOz+bNe0UY=;
        b=UX7gjUEFkSNirWS6SAAztjAXwwvKPlLvO9kiRW2wGJYppf1QCD28QGyt582mpbrMkL
         KD7N4+EIiXT0SK0vxSCG3kn0QvGrwRVUOccN7dqkLxjhzaHk3UlFzNFlcakbHnxk0Vjg
         p5QKqEfF+YAJ6vIYdG7fMp5x9TCkDB0Zq5xsLH0Y6w5u/cKSfYFZsEN/vjlpA4uYZNdP
         Q8GUZBgq/KNyMZ2YmMWMBA8kxLSBKvAPI3OeU/SvVC1LfI+qbYBMX+vP4PtvfIheuC4y
         MLJifVJAXA3LbQp3Zrd2d0fbpjDamcfPwpfME5HgPNfrFPu+R1V4/7mYBWkoMS1uXUEf
         UyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J2jh1PYyVEhq/KuWyOAy6rLIOb7OTmdmTDOz+bNe0UY=;
        b=Hv/JwFWlkYJ7ewi8v2Fkb6QC2KvTHkuMZx9Ojl0LlLseOCeUKHv7b98XhLxa8cxSrd
         AD1uCTwgsdriLmuoiu8Jf1jGos0s+lTqKJBxsTbmfO/oCAKkaV9YUjxC1WQc2V6py7ZU
         BFcxsbE+pDxR0UwNYDAEMGkA0V9zqiDI5U+DTKdJggde35H3aJMrWmRSx/zUkB/wqjXH
         9QDF9jS6gprFQPk7zuNNct/hh6PGKMTaPK+jsX5t9DeCOva5tVNpqTQ+atnqqp/ImXTM
         Zx0RZZUzG0YdOCW80uMolwygAfNfPLugLOpRydzdoCrZRzj+x68kPC9CDii4eX4N5X+k
         uTcw==
X-Gm-Message-State: AOAM531Cckazytj+CBr3HbR2spLyxorYJCgLJmJotZ0eP+qByfmDm6aM
        Deu9pxk+INUac4zaB98hZRN9Xw+MmbI=
X-Google-Smtp-Source: ABdhPJwmP4UJTYdjJoWfdmW91gY7ZYttxnQF9OBzOkcOe1p+GZ0yh5z6nJW6VG3Ar9XeTTWxD1Fzvw==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr23866564wrj.293.1615747663574;
        Sun, 14 Mar 2021 11:47:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm14122757wrp.31.2021.03.14.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:43 -0700 (PDT)
Message-Id: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:33 +0000
Subject: [PATCH v2 0/9] Fix all leaks in t0001
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 of this series:

 * Addresses all of Peff's comments - many thanks for the review.
 * Adds a patch converting enum bitfields in parse-options.h to use binary
   shifts instead of numerical constants.
 * Adds a patch to free remote_refs in transport_disconnect() instead of
   freeing those refs in the callers of transport_get_remote_refs().

Andrzej Hunt (9):
  symbolic-ref: don't leak shortened refname in check_symref()
  reset: free instead of leaking unneeded ref
  clone: free or UNLEAK further pointers when finished
  worktree: fix leak in dwim_branch()
  init: remove git_init_db_config() while fixing leaks
  init-db: silence template_dir leak when converting to absolute path
  parse-options: convert bitfield values to use binary shift
  parse-options: don't leak alias help messages
  transport: also free remote_refs in transport_disconnect()

 builtin/clone.c        | 14 ++++++++++----
 builtin/init-db.c      | 32 ++++++++++----------------------
 builtin/ls-remote.c    |  4 ++--
 builtin/remote.c       |  8 ++++----
 builtin/reset.c        |  2 +-
 builtin/symbolic-ref.c |  4 +++-
 builtin/worktree.c     | 10 ++++++----
 parse-options.c        | 20 +++++++++++++++++++-
 parse-options.h        | 35 ++++++++++++++++++-----------------
 transport.c            |  2 ++
 10 files changed, 75 insertions(+), 56 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-899%2Fahunt%2Fleaksan-t0001-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-899/ahunt/leaksan-t0001-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/899

Range-diff vs v1:

  1:  ff0f7c167fa5 !  1:  c7bb403ae381 symbolic-ref: don't leak shortened refname in check_symref()
     @@ Metadata
       ## Commit message ##
          symbolic-ref: don't leak shortened refname in check_symref()
      
     +    shorten_unambiguous_ref() returns an allocated string. We have to
     +    track it separately from the const refname.
     +
          This leak has existed since:
          9ab55daa55 (git symbolic-ref --delete $symref, 2012-10-21)
      
     @@ builtin/symbolic-ref.c: static int check_symref(const char *HEAD, int quiet, int
       			return 1;
       	}
       	if (print) {
     --		if (shorten)
     ++		char *to_free = NULL;
     + 		if (shorten)
      -			refname = shorten_unambiguous_ref(refname, 0);
     --		puts(refname);
     -+		if (shorten) {
     -+			const char *shortened_refname;
     -+
     -+			shortened_refname = shorten_unambiguous_ref(refname, 0);
     -+			puts(shortened_refname);
     -+			free((void *)shortened_refname);
     -+		} else {
     -+			puts(refname);
     -+		}
     ++			refname = to_free = shorten_unambiguous_ref(refname, 0);
     + 		puts(refname);
     ++		free(to_free);
       	}
       	return 0;
       }
  2:  a7b6b873460f !  2:  da05fc72b77a reset: free instead of leaking unneeded ref
     @@ Metadata
       ## Commit message ##
          reset: free instead of leaking unneeded ref
      
     -    dwim_ref() allocs a new string into ref. Instead of setting to NULL to discard
     -    it, we can FREE_AND_NULL.
     +    dwim_ref() allocs a new string into ref. Instead of setting to NULL to
     +    discard it, we can FREE_AND_NULL.
      
          This leak appears to have been introduced in:
          4cf76f6bbf (builtin/reset: compute checkout metadata for reset, 2020-03-16)
  3:  107e98d00e16 !  3:  a74bbcae7363 clone: free or UNLEAK further pointers when finished
     @@ Commit message
              #4 0x51e9bd in wanted_peer_refs /home/ahunt/oss-fuzz/git/builtin/clone.c:574:21
              #5 0x51cfe1 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1284:17
              #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
     -    vv    #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
     +        #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
              #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
              #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
              #10 0x69c42e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
              #11 0x7f8fef0c2349 in __libc_start_main (/lib64/libc.so.6+0x24349)
      
     -    Direct leak of 165 byte(s) in 1 object(s) allocated from:
     -        #0 0x49a6b2 in calloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
     -        #1 0x9a72f2 in xcalloc /home/ahunt/oss-fuzz/git/wrapper.c:140:8
     -        #2 0x8ce203 in alloc_ref_with_prefix /home/ahunt/oss-fuzz/git/remote.c:867:20
     -        #3 0x8ce1a2 in alloc_ref /home/ahunt/oss-fuzz/git/remote.c:875:9
     -        #4 0x72f63e in process_ref_v2 /home/ahunt/oss-fuzz/git/connect.c:426:8
     -        #5 0x72f21a in get_remote_refs /home/ahunt/oss-fuzz/git/connect.c:525:8
     -        #6 0x979ab7 in handshake /home/ahunt/oss-fuzz/git/transport.c:305:4
     -        #7 0x97872d in get_refs_via_connect /home/ahunt/oss-fuzz/git/transport.c:339:9
     -        #8 0x9774b5 in transport_get_remote_refs /home/ahunt/oss-fuzz/git/transport.c:1388:4
     -        #9 0x51cf80 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1271:9
     -        #10 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
     -        #11 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
     -        #12 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
     -        #13 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
     -        #14 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
     -        #15 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)
     -
          Direct leak of 178 byte(s) in 1 object(s) allocated from:
              #0 0x49a53d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
              #1 0x9a6ff4 in do_xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:41:8
     @@ Commit message
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	char *path, *dir, *display_repo = NULL;
     + {
     + 	int is_bundle = 0, is_local;
     + 	const char *repo_name, *repo, *work_tree, *git_dir;
     +-	char *path, *dir, *display_repo = NULL;
     ++	char *path = NULL, *dir, *display_repo = NULL;
       	int dest_exists, real_dest_exists = 0;
       	const struct ref *refs, *remote_head;
      -	const struct ref *remote_head_points_at;
     -+	const struct ref *remote_head_points_at = NULL;
     ++	struct ref *remote_head_points_at = NULL;
       	const struct ref *our_head_points_at;
       	struct ref *mapped_refs;
       	const struct ref *ref;
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	path = get_repo_path(repo_name, &is_bundle);
      -	if (path)
      +	if (path) {
     -+		free(path);
     ++		FREE_AND_NULL(path);
       		repo = absolute_pathdup(repo_name);
      -	else if (strchr(repo_name, ':')) {
      +	} else if (strchr(repo_name, ':')) {
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	strbuf_release(&branch_top);
       	strbuf_release(&key);
      +	free_refs(mapped_refs);
     -+	free_refs((void *)remote_head_points_at);
     -+	free_refs((void *)refs);
     ++	free_refs(remote_head_points_at);
      +	free(dir);
      +	free(path);
      +	UNLEAK(repo);
  4:  d46a4e701620 !  4:  a10ab9e68809 worktree: fix leak in dwim_branch()
     @@ Commit message
      
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static void print_preparing_worktree_line(int detach,
     - 
       static const char *dwim_branch(const char *path, const char **new_branch)
       {
     --	int n;
     -+	int n, branch_exists;
     + 	int n;
     ++	int branch_exists;
       	const char *s = worktree_basename(path, &n);
       	const char *branchname = xstrndup(s, n);
       	struct strbuf ref = STRBUF_INIT;
     --
     + 
       	UNLEAK(branchname);
      -	if (!strbuf_check_branch_ref(&ref, branchname) &&
      -	    ref_exists(ref.buf)) {
      -		strbuf_release(&ref);
      +
     -+	branch_exists = (!strbuf_check_branch_ref(&ref, branchname) &&
     -+			 ref_exists(ref.buf));
     ++	branch_exists = !strbuf_check_branch_ref(&ref, branchname) &&
     ++	                ref_exists(ref.buf);
      +	strbuf_release(&ref);
      +	if (branch_exists)
       		return branchname;
  5:  d30365d96765 =  5:  206a82200ca1 init: remove git_init_db_config() while fixing leaks
  6:  6f81f3b2ab28 =  6:  aa345e50782f init-db: silence template_dir leak when converting to absolute path
  -:  ------------ >  7:  2b03785bd4cb parse-options: convert bitfield values to use binary shift
  7:  fb456bee0f69 !  8:  4397c1fd8020 parse-options: don't leak alias help messages
     @@ Commit message
            7c280589cf (parse-options: teach "git cmd -h" to show alias as alias, 2020-03-16)
      
          The preprocessed options themselves no longer contain any indication
     -    that a given option is/was an alias: the easiest and fastest way to
     -    figure it out is to look back at the original options. Alternatively we
     -    could iterate over the alias_groups list - but that would require nested
     -    looping and is likely to be a (little) less efficient.
     +    that a given option is/was an alias - therefore we add a new flag to
     +    indicate former aliases. (An alternative approach would be to look back
     +    at the original options to determine which options are aliases - but
     +    that seems like a fragile approach. Or we could even look at the
     +    alias_groups list - which might be less fragile, but would be slower
     +    as it requires nested looping.)
      
          As far as I can tell, parse_options() is only ever used once per
          command, and the help messages are small - hence this leak has very
     @@ Commit message
      
          Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
      
     +    fold
     +
       ## parse-options.c ##
      @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all)
        *
     @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all
        */
       static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
       					 const struct option *options)
     +@@ parse-options.c: static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
     + 			newopt[i].short_name = short_name;
     + 			newopt[i].long_name = long_name;
     + 			newopt[i].help = strbuf_detach(&help, NULL);
     ++			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
     + 			break;
     + 		}
     + 
      @@ parse-options.c: static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
       	return newopt;
       }
       
     -+static void free_preprocessed_options(const struct option ** preprocessed_options, const struct option *original_options)
     ++static void free_preprocessed_options(struct option *options)
      +{
      +	int i;
      +
     -+	if (!*preprocessed_options) {
     ++	if (!options)
      +		return;
     -+	}
     -+	for (i = 0; original_options[i].type != OPTION_END; i++) {
     -+		if (original_options[i].type == OPTION_ALIAS) {
     -+			free((void *)(*preprocessed_options)[i].help);
     ++
     ++	for (i = 0; options[i].type != OPTION_END; i++) {
     ++		if (options[i].flags & PARSE_OPT_FROM_ALIAS) {
     ++			free((void *)options[i].help);
      +		}
      +	}
     -+	free((void *)*preprocessed_options);
     ++	free(options);
      +}
      +
       static int usage_with_options_internal(struct parse_opt_ctx_t *,
       				       const char * const *,
       				       const struct option *, int, int);
     -@@ parse-options.c: int parse_options(int argc, const char **argv, const char *prefix,
     - 		  int flags)
     - {
     - 	struct parse_opt_ctx_t ctx;
     --	struct option *real_options;
     -+	const struct option *preprocessed_options, *original_options = NULL;
     - 
     - 	disallow_abbreviated_options =
     - 		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
     - 
     - 	memset(&ctx, 0, sizeof(ctx));
     --	real_options = preprocess_options(&ctx, options);
     --	if (real_options)
     --		options = real_options;
     -+	preprocessed_options = preprocess_options(&ctx, options);
     -+	if (preprocessed_options) {
     -+		original_options = options;
     -+		options = preprocessed_options;
     -+	}
     - 	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
     - 	switch (parse_options_step(&ctx, options, usagestr)) {
     - 	case PARSE_OPT_HELP:
      @@ parse-options.c: int parse_options(int argc, const char **argv, const char *prefix,
       	}
       
       	precompose_argv_prefix(argc, argv, NULL);
      -	free(real_options);
     -+	free_preprocessed_options(&preprocessed_options, original_options);
     ++	free_preprocessed_options(real_options);
       	free(ctx.alias_groups);
       	return parse_options_end(&ctx);
       }
     +
     + ## parse-options.h ##
     +@@ parse-options.h: enum parse_opt_option_flags {
     + 	PARSE_OPT_NOCOMPLETE = 1 << 8,
     + 	PARSE_OPT_COMP_ARG = 1 << 9,
     + 	PARSE_OPT_CMDMODE = 1 << 10,
     ++	PARSE_OPT_FROM_ALIAS = 1 << 11,
     + };
     + 
     + enum parse_opt_result {
  -:  ------------ >  9:  a907f2460d42 transport: also free remote_refs in transport_disconnect()

-- 
gitgitgadget
