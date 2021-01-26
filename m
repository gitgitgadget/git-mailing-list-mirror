Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403DC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B4B206A4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbhAZWCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbhAZS4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:56:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80ACC0617A7
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:56:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j12so18824335ybg.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=i+iR/8bdIYTGtSJMDFG+b+x2GjkLI5egkLd0BP6L0L8=;
        b=Bl89e2IX5WaynZU9K71r+dWrg1/h1UYzTk7+4DbKCqFn2LpX3l3ciQMs9IixpNs2oN
         l6hr0gCN76iC6qMPj+LKAMW2T84nbyd+dk3sS38cjk+O6GUBh28bLNblcqsuYJWTfol7
         XGL5JviW0WiePWretbn3dg/hSHzdbLxjUY4dWaU/LGozJQdJXuvLrghLIXAee7pgrutD
         MkJxTBIiB03KTQpaHKfsYoxFw8bjcgpBVgWycJsG0+LxAC6VYHQU0GqFfNAsfwT4OL2s
         x9kJYs7hUMP326DxkscNelTacLfJpdCdtEkHIBiUixvv2xZorHfR+XQk9nCnnNr9c6Nb
         3Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i+iR/8bdIYTGtSJMDFG+b+x2GjkLI5egkLd0BP6L0L8=;
        b=ndYtW5tJeJFvKmYKKrY91I2+05RzMVBkgofaOXu6Mtq6Rio34QGpXjw8peX7/sDfJO
         JBM2RpglS+8W7HF7xoC7lo9y380dfT197Q3MaO+jwnjKqSigZIfwzCvglxJ5Wqwzz/2w
         RwBd6JvBHJ3SORMlGuNLJ0rkCJyH79M6qfjWPh7i8XtCo0+EsJ2YajuYKr5ly8UXeDMj
         3ngl/8HbI218kNDXCAe/H2NnO9QqQmD7T1ZfmAaw7G8C8BbZCaOYz9BmBbYBH23RYB0K
         E9mvUEs1x3FAXkrtIf5h2Y+yOQEOR4G6B982DbV0CeuJSr+Sk0kvqSttV2qSwfyhDuSq
         Pzhw==
X-Gm-Message-State: AOAM5328t1t3o1Q4ZHMrwEQ6sYZb3pIkHDN+eEqQ+lmOP9fByFnm/dRl
        siwyk5G7Vtd87V4QZFlvoyAjxskZWZ+mKrG4mt3Og5wB5AnNdpP2+WxnmYjfJRsglrYBUiXJZ5/
        jqx1QssMK+afqBfyRu9WDTy6gpNPcTOIxpr9dFE8ERLW0WbQ2AFvzqMOr2SU0KPFyZwe//P7lh9
        iO
X-Google-Smtp-Source: ABdhPJyfs3LlH8/B4XOHAhnUf/aAX2/gJMPx9VxlktO3KZYacHNvZS5mxJb3lBK9qNTVXzFdOfImnjV3+Eu7aBGJk1HG
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aaa2:: with SMTP id
 t31mr11233645ybi.280.1611687361005; Tue, 26 Jan 2021 10:56:01 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:55:54 -0800
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com>
Message-Id: <cover.1611686656.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v5 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff, for your review. I have addressed your comments (through
replies to your emails and here in this v5 patch set).

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: encapsulate arg in struct
  clone: respect remote unborn HEAD

 Documentation/config.txt                |  2 +
 Documentation/config/init.txt           |  2 +-
 Documentation/config/lsrefs.txt         |  3 ++
 Documentation/technical/protocol-v2.txt | 10 ++++-
 builtin/clone.c                         | 34 +++++++++++-----
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         | 18 +++++----
 builtin/ls-remote.c                     |  9 +++--
 connect.c                               | 32 +++++++++++++--
 ls-refs.c                               | 53 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 remote.h                                |  4 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  8 ++--
 t/t5701-git-serve.sh                    |  2 +-
 t/t5702-protocol-v2.sh                  | 25 ++++++++++++
 transport-helper.c                      |  5 ++-
 transport-internal.h                    |  9 +----
 transport.c                             | 23 ++++++-----
 transport.h                             | 29 ++++++++++----
 20 files changed, 210 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

Range-diff against v4:
1:  d7d2ba597e ! 1:  32e16dfdbd ls-refs: report unborn targets of symrefs
    @@ Commit message
     
         Currently, symrefs that have unborn targets (such as in this case) are
         not communicated by the protocol. Teach Git to advertise and support the
    -    "unborn" feature in "ls-refs" (guarded by the lsrefs.allowunborn
    +    "unborn" feature in "ls-refs" (by default, this is advertised, but
    +    server administrators may turn this off through the lsrefs.allowunborn
         config). This feature indicates that "ls-refs" supports the "unborn"
         argument; when it is specified, "ls-refs" will send the HEAD symref with
         the name of its unborn target.
    @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     +	int flag;
     +	int oid_is_null;
     +
    -+	memset(&oid, 0, sizeof(oid));
     +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
    -+	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
    ++	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
    ++		return; /* bad ref */
     +	oid_is_null = is_null_oid(&oid);
     +	if (!oid_is_null ||
     +	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
    @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
      	memset(&data, 0, sizeof(data));
      
     -	git_config(ls_refs_config, NULL);
    ++	data.allow_unborn = 1;
     +	git_config(ls_refs_config, &data);
      
      	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
    @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
     +	if (value) {
     +		int allow_unborn_value;
     +
    -+		if (!repo_config_get_bool(the_repository,
    ++		if (repo_config_get_bool(the_repository,
     +					 "lsrefs.allowunborn",
    -+					 &allow_unborn_value) &&
    ++					 &allow_unborn_value) ||
     +		    allow_unborn_value)
     +			strbuf_addstr(value, "unborn");
     +	}
    @@ serve.c: struct protocol_capability {
      	{ "fetch", upload_pack_advertise, upload_pack_v2 },
      	{ "server-option", always_advertise, NULL },
      	{ "object-format", object_format_advertise, NULL },
    +
    + ## t/t5701-git-serve.sh ##
    +@@ t/t5701-git-serve.sh: test_expect_success 'test capability advertisement' '
    + 	cat >expect <<-EOF &&
    + 	version 2
    + 	agent=git/$(git version | cut -d" " -f3)
    +-	ls-refs
    ++	ls-refs=unborn
    + 	fetch=shallow
    + 	server-option
    + 	object-format=$(test_oid algo)
2:  51d8a359c7 < -:  ---------- connect, transport: add no-op arg for future patch
-:  ---------- > 2:  4eec551668 connect, transport: encapsulate arg in struct
3:  896be550f1 ! 3:  922e8c229c clone: respect remote unborn HEAD
    @@ Documentation/config/init.txt: init.templateDir::
     +	a new repository.
     
      ## builtin/clone.c ##
    -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
    - 	int submodule_progress;
    - 
    - 	struct strvec ref_prefixes = STRVEC_INIT;
    -+	char *unborn_head_target = NULL;
    - 
    - 	packet_trace_identity("clone");
    - 
    -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
    - 	if (!option_no_tags)
    - 		strvec_push(&ref_prefixes, "refs/tags/");
    - 
    --	refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
    -+	refs = transport_get_remote_refs(transport, &ref_prefixes,
    -+					 &unborn_head_target);
    - 
    - 	if (refs) {
    - 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      		remote_head = NULL;
      		option_no_checkout = 1;
    @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     +			const char *branch;
     +			char *ref;
     +
    -+			if (unborn_head_target &&
    -+			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
    -+				ref = unborn_head_target;
    -+				unborn_head_target = NULL;
    ++			if (transport_ls_refs_options.unborn_head_target &&
    ++			    skip_prefix(transport_ls_refs_options.unborn_head_target,
    ++					"refs/heads/", &branch)) {
    ++				ref = transport_ls_refs_options.unborn_head_target;
    ++				transport_ls_refs_options.unborn_head_target = NULL;
     +			} else {
     +				branch = git_default_branch_name();
     +				ref = xstrfmt("refs/heads/%s", branch);
    @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      		}
      	}
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
    - 	strbuf_release(&key);
      	junk_mode = JUNK_LEAVE_ALL;
      
    -+	free(unborn_head_target);
    - 	strvec_clear(&ref_prefixes);
    + 	strvec_clear(&transport_ls_refs_options.ref_prefixes);
    ++	free(transport_ls_refs_options.unborn_head_target);
      	return err;
      }
     
    @@ connect.c: static int process_ref_v2(struct packet_reader *reader, struct ref **
      	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
      	    *end) {
      		ret = 0;
    +@@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    + 	const char *hash_name;
    + 	struct strvec *ref_prefixes = transport_options ?
    + 		&transport_options->ref_prefixes : NULL;
    ++	char **unborn_head_target = transport_options ?
    ++		&transport_options->unborn_head_target : NULL;
    + 	*list = NULL;
    + 
    + 	if (server_supports_v2("ls-refs", 1))
     @@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
      	if (!for_push)
      		packet_write_fmt(fd_out, "peel\n");
    @@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader
      
      	/* Process response from server */
      	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
    --		if (unborn_head_target)
    --			BUG("NEEDSWORK: provide unborn HEAD target to caller while reading refs");
     -		if (!process_ref_v2(reader, &list))
     +		if (!process_ref_v2(reader, &list, unborn_head_target))
      			die(_("invalid ls-refs response: %s"), reader->line);
    @@ t/t5702-protocol-v2.sh: test_expect_success 'clone with file:// using protocol v
      '
      
     +test_expect_success 'clone of empty repo propagates name of default branch' '
    ++	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
    ++
     +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
    -+	test_config -C file_empty_parent lsrefs.allowUnborn true &&
     +
     +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=main -c protocol.version=2 \
     +		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
     +	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
     +'
    ++
    ++test_expect_success '...but not if explicitly forbidden by config' '
    ++	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
    ++
    ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
    ++	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
    ++	test_config -C file_empty_parent lsrefs.allowUnborn false &&
    ++
    ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
    ++	git -c init.defaultBranch=main -c protocol.version=2 \
    ++		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
    ++	! grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
    ++'
     +
      test_expect_success 'fetch with file:// using protocol v2' '
      	test_when_finished "rm -f log" &&
      
    +
    + ## transport.h ##
    +@@ transport.h: struct transport_ls_refs_options {
    + 	 * provided ref_prefixes.
    + 	 */
    + 	struct strvec ref_prefixes;
    ++
    ++	/*
    ++	 * If unborn_head_target is not NULL, and the remote reports HEAD as
    ++	 * pointing to an unborn branch, transport_get_remote_refs() stores the
    ++	 * unborn branch in unborn_head_target. It should be freed by the
    ++	 * caller.
    ++	 */
    ++	char *unborn_head_target;
    + };
    + #define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
    + 
-- 
2.30.0.280.ga3ce27912f-goog

