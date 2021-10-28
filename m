Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A75C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA63610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJ1Sdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhJ1Sdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB34C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n10-20020a17090a2bca00b001a61dff6c9dso627114pje.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EDmBBkJCShi4y7i+Jit5Q2C/xdesAY6WLkVfWf2u+ko=;
        b=mwL8ftwE7U78ZVcP56P52iFcp/IOZZ4JIpX6LWt9Rs+tegx7wLcTp8xWWY18d8l3qP
         F8jXhO6aQjpiByF4/yvl/RvEgEAcScMC9z7SYaBdjVz5ZwIUyrZiKzuyhKOQBQ1+yhSa
         2sXTyxc4E9MY6Zu+5K12KWE2CuvX8Y1CaJ1sLY4p9GdOOW4JVNnC3W5pU8hLBPigwMF2
         iDYt31vntFY4aGzEGaiorsryudGURSrDnAEPrCdsnLVOcXS4BRiYHC2e+QEaTQmbJSbM
         jT6GaJWcPQTRIdxy5gleIUEOSIfpMN7Oz3Ke8JSiOYQT4CrAKZCrkWxIYriQQGNT4chn
         2+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EDmBBkJCShi4y7i+Jit5Q2C/xdesAY6WLkVfWf2u+ko=;
        b=3dJwqdwvJvx8Qq2pxLxRT7fNS74Mkk2hCU61iPITpCcMJpMI6jOX5SexBg4jBAtxJu
         Vkp5uRo6gLaIFFWaqUHNQRhRnPrKJ7oOsMJHfKZQfILH+1JgpqVdwRIbdnWHasjbwjx2
         8eEEkE8PlDuNIX+OFnfaRbybc59FsCfDgtTzNeHy9qVYe4407dTEr1RcRO46aONRqmF+
         z6B0xCj8a1yOVAv5h+cyb7xtoo+R15yUi2Ev1s/QS8ZM8+JHPWsh4Qt+MJq7HIbzWjGd
         UYWRPVa7QfHqlnzHlmc3xbUXcK8WVnVkUufzY3ncT5CyX0g1ahaVVVqOuotl7wCJT3MX
         +KEA==
X-Gm-Message-State: AOAM530H22y5Fv9u9/8gE8SeQYcehyg6tqKBCDswCmc9vwmbUs80kveZ
        rA3fYdEISOra6uvqpifwvj7Qj59qP46hEeoENltX9QteINCYGglX6ffKTGG1A9vTXTAy0s0M7mI
        8Mb30JJVOkW53ynPEmdymMKpTjG4trW7wnoyVH8gcX8wGS3OyGhvLZMpp1OLP800=
X-Google-Smtp-Source: ABdhPJxkwNett1WnMbBRNeKWwBU2KsoYVjK7ZqaRVh8JiKGAt4xJyI0fkUUzMOTZidx2K17MEObP5w3lMImbEQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c951:b0:141:68f2:c8fd with SMTP
 id i17-20020a170902c95100b0014168f2c8fdmr5362375pla.21.1635445869525; Thu, 28
 Oct 2021 11:31:09 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:30:55 -0700
In-Reply-To: <20211019224339.61881-1-chooglen@google.com>
Message-Id: <20211028183101.41013-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 0/6] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to make the remotes subsystem work with non-the_repository,
which will allow submodule remotes to be accessed in-process, rather than
through child processes. This is accomplished by creating a struct remote_state
and adding it to struct repository.

One motivation for this is that it allows future submodule commands to run
in-process. An example is an RFC series of mine [1], where I tried to implement
"git branch --recurse-submodules" in-process but couldn't figure out how to read
the remotes of a submodule.

v4 reverts the backpointer introduced in v3. In authoring v3, I had
overlooked the fact that branch == NULL (representing detached HEAD) is
a valid argument to some branch_* functions and as a result, we cannot
always rely on branch->remote_state to tell us the remote_state of a
branch. This was not discovered because of a coding mistake in v3 where
branch was unconditionally dereferenced, even when it was null [2]. v4
adds a test that checks the relevant behavior.

The resulting interface is similar to v2, but with Junio's proposed
safety check [3] - when branch + repository are passed as a pair we
check that the branch belongs to the repository (i.e. it is in the
repository's remote_state struct). This check is only implemented for
non-static functions because the probability of misuse is much higher.
In static functions, this check is wasteful because we frequently
operate on the remote_state + {branch, remote} pair in order to maintain
data consistency and the correct remote_state is often obvious from
context.

In the long run, I believe that there is room for refactoring/interface changes
as to avoid these internal correctness issues, but I think this is a good enough
starting point.

[1] https://lore.kernel.org/git/20210921232529.81811-1-chooglen@google.com/
[2] https://lore.kernel.org/git/xmqqtuhbo2tn.fsf@gitster.g
[2] https://lore.kernel.org/git/xmqqfssozk8r.fsf@gitster.g

Changes since v3:
* Add a test case for pushing to a remote in detached HEAD. This test
  would have caught the segfault that resulted in this reroll.
* Remove the NEEDSWORK saying that init_remotes_hash() should be moved
  into remote_state_new() and just do it.
* Remove the backpointer to remote_state and add a remote_state
  parameter instead.
* In patch 4, add more remotes_* functions. These functions were not
  needed in v3 because of the backpointer.
* In patch 5, add a function that checks if a branch is in a repo. Add a
  branch hashmap that makes this operation fast.
* In patch 6, add more repo_* functions. These functions were not needed
  in v3 because of the backpointer.

Changes since v2:
* Add .remote_state to struct branch and struct remote, changing the
  implementation appropriately.
* In patch 2, properly consider the initialized state of remote_state.
  In v2, I forgot to convert a static inside read_config() into a
  private member of struct remote_state. Fix this.
* In a new patch 3, add helper methods that get a remote via
  remote_state and the remote name.
* Move read_config(repo) calls to the external facing-functions. This keeps
  "struct repository" away from the remote.c internals.

Changes since v1:
* In v1, we moved static variables into the_repository->remote_state in
  two steps: static variables > static remote_state >
  the_repository->remote_state. In v2, make this change in one step:
  static variables > the_repository->remote_state.
* Add more instances of repo_* that were missed.

Glen Choo (6):
  t5516: add test case for pushing remote refspecs
  remote: move static variables into per-repository struct
  remote: use remote_state parameter internally
  remote: remove the_repository->remote_state from static methods
  remote: die if branch is not found in repository
  remote: add struct repository parameter to external functions

 remote.c              | 406 +++++++++++++++++++++++++++++-------------
 remote.h              | 118 ++++++++++--
 repository.c          |   8 +
 repository.h          |   4 +
 t/t5516-fetch-push.sh |   9 +
 5 files changed, 404 insertions(+), 141 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  9b29ec27c6 t5516: add test case for pushing remote refspecs
1:  1f712c22b4 ! 2:  ca9b5ab66a remote: move static variables into per-repository struct
    @@ remote.c: static void add_pushurl(struct remote *remote, const char *pushurl)
      }
      
     @@ remote.c: static int remotes_hash_cmp(const void *unused_cmp_data,
    + 		return strcmp(a->name, b->name);
    + }
      
    - static inline void init_remotes_hash(void)
    - {
    +-static inline void init_remotes_hash(void)
    +-{
     -	if (!remotes_hash.cmpfn)
     -		hashmap_init(&remotes_hash, remotes_hash_cmp, NULL, 0);
    -+	if (!the_repository->remote_state->remotes_hash.cmpfn)
    -+		hashmap_init(&the_repository->remote_state->remotes_hash,
    -+			     remotes_hash_cmp, NULL, 0);
    - }
    - 
    +-}
    +-
      static struct remote *make_remote(const char *name, int len)
    + {
    + 	struct remote *ret;
     @@ remote.c: static struct remote *make_remote(const char *name, int len)
    + 	if (!len)
    + 		len = strlen(name);
    + 
    +-	init_remotes_hash();
    + 	lookup.str = name;
      	lookup.len = len;
      	hashmap_entry_init(&lookup_entry, memhash(name, len));
      
    @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
     +	struct remote_state *r = xmalloc(sizeof(*r));
     +
     +	memset(r, 0, sizeof(*r));
    ++
    ++	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
     +	return r;
     +}
     +
2:  467247fa9c ! 3:  5d6a245cae remote: use remote_state parameter internally
    @@ Metadata
      ## Commit message ##
         remote: use remote_state parameter internally
     
    -    Introduce a struct remote_state member to structs that need to
    -    'remember' their remote_state. Without changing external-facing
    -    functions, replace the_repository->remote_state internally by using the
    -    remote_state member where it is applicable i.e. when a function accepts
    -    a struct that depends on the remote_state. If it is not applicable, add
    -    a struct remote_state parameter instead.
    +    Without changing external-facing functions, replace
    +    the_repository->remote_state internally by adding a struct remote_state
    +    parameter.
     
         As a result, external-facing functions are still tied to the_repository,
         but most static functions no longer reference
    @@ Commit message
     
      ## remote.c ##
     @@ remote.c: static void add_pushurl(struct remote *remote, const char *pushurl)
    - static void add_pushurl_alias(struct remote *remote, const char *url)
    + 	remote->pushurl[remote->pushurl_nr++] = pushurl;
    + }
    + 
    +-static void add_pushurl_alias(struct remote *remote, const char *url)
    ++static void add_pushurl_alias(struct remote_state *remote_state,
    ++			      struct remote *remote, const char *url)
      {
    - 	const char *pushurl =
    +-	const char *pushurl =
     -		alias_url(url, &the_repository->remote_state->rewrites_push);
    -+		alias_url(url, &remote->remote_state->rewrites_push);
    ++	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
      	if (pushurl != url)
      		add_pushurl(remote, pushurl);
      }
      
    - static void add_url_alias(struct remote *remote, const char *url)
    +-static void add_url_alias(struct remote *remote, const char *url)
    ++static void add_url_alias(struct remote_state *remote_state,
    ++			  struct remote *remote, const char *url)
      {
     -	add_url(remote,
     -		alias_url(url, &the_repository->remote_state->rewrites));
    -+	add_url(remote, alias_url(url, &remote->remote_state->rewrites));
    - 	add_pushurl_alias(remote, url);
    +-	add_pushurl_alias(remote, url);
    ++	add_url(remote, alias_url(url, &remote_state->rewrites));
    ++	add_pushurl_alias(remote_state, remote, url);
      }
      
    + struct remotes_hash_key {
     @@ remote.c: static int remotes_hash_cmp(const void *unused_cmp_data,
      		return strcmp(a->name, b->name);
      }
      
    --static inline void init_remotes_hash(void)
    -+/**
    -+ * NEEDSWORK: Now that the hashmap is in a struct, this should probably
    -+ * just be moved into remote_state_new().
    -+ */
    -+static inline void init_remotes_hash(struct remote_state *remote_state)
    - {
    --	if (!the_repository->remote_state->remotes_hash.cmpfn)
    --		hashmap_init(&the_repository->remote_state->remotes_hash,
    --			     remotes_hash_cmp, NULL, 0);
    -+	if (!remote_state->remotes_hash.cmpfn)
    -+		hashmap_init(&remote_state->remotes_hash, remotes_hash_cmp,
    -+			     NULL, 0);
    - }
    - 
     -static struct remote *make_remote(const char *name, int len)
     +static struct remote *make_remote(struct remote_state *remote_state,
     +				  const char *name, int len)
    @@ remote.c: static int remotes_hash_cmp(const void *unused_cmp_data,
      	struct remote *ret;
      	struct remotes_hash_key lookup;
     @@ remote.c: static struct remote *make_remote(const char *name, int len)
    - 	if (!len)
    - 		len = strlen(name);
    - 
    --	init_remotes_hash();
    -+	init_remotes_hash(remote_state);
    - 	lookup.str = name;
      	lookup.len = len;
      	hashmap_entry_init(&lookup_entry, memhash(name, len));
      
    @@ remote.c: static struct remote *make_remote(const char *name, int len)
      		return container_of(e, struct remote, ent);
      
     @@ remote.c: static struct remote *make_remote(const char *name, int len)
    - 	ret->prune = -1;  /* unspecified */
    - 	ret->prune_tags = -1;  /* unspecified */
    - 	ret->name = xstrndup(name, len);
    -+	ret->remote_state = remote_state;
      	refspec_init(&ret->push, REFSPEC_PUSH);
      	refspec_init(&ret->fetch, REFSPEC_FETCH);
      
    @@ remote.c: static void add_merge(struct branch *branch, const char *name)
     +	remote_state->branches[remote_state->branches_nr++] = ret;
      	ret->name = xstrndup(name, len);
      	ret->refname = xstrfmt("refs/heads/%s", ret->name);
    -+	ret->remote_state = remote_state;
      
    - 	return ret;
    +@@ remote.c: static const char *skip_spaces(const char *s)
    + 	return s;
      }
    + 
    +-static void read_remotes_file(struct remote *remote)
    ++static void read_remotes_file(struct remote_state *remote_state,
    ++			      struct remote *remote)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    + 	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
    +@@ remote.c: static void read_remotes_file(struct remote *remote)
    + 		strbuf_rtrim(&buf);
    + 
    + 		if (skip_prefix(buf.buf, "URL:", &v))
    +-			add_url_alias(remote, xstrdup(skip_spaces(v)));
    ++			add_url_alias(remote_state, remote,
    ++				      xstrdup(skip_spaces(v)));
    + 		else if (skip_prefix(buf.buf, "Push:", &v))
    + 			refspec_append(&remote->push, skip_spaces(v));
    + 		else if (skip_prefix(buf.buf, "Pull:", &v))
    +@@ remote.c: static void read_remotes_file(struct remote *remote)
    + 	fclose(f);
    + }
    + 
    +-static void read_branches_file(struct remote *remote)
    ++static void read_branches_file(struct remote_state *remote_state,
    ++			       struct remote *remote)
    + {
    + 	char *frag;
    + 	struct strbuf buf = STRBUF_INIT;
    +@@ remote.c: static void read_branches_file(struct remote *remote)
    + 	else
    + 		frag = (char *)git_default_branch_name(0);
    + 
    +-	add_url_alias(remote, strbuf_detach(&buf, NULL));
    ++	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
    + 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
    + 			frag, remote->name);
    + 
     @@ remote.c: static int handle_config(const char *key, const char *value, void *cb)
      	const char *subkey;
      	struct remote *remote;
    @@ remote.c: static int handle_config(const char *key, const char *value, void *cb)
     -				->url[j] = alias_url(
     -				the_repository->remote_state->remotes[i]->url[j],
     -				&the_repository->remote_state->rewrites);
    -+					remote_state->remotes[i],
    ++					remote_state, remote_state->remotes[i],
     +					remote_state->remotes[i]->url[j]);
     +			remote_state->remotes[i]->url[j] =
     +				alias_url(remote_state->remotes[i]->url[j],
    @@ remote.c: static int handle_config(const char *key, const char *value, void *cb)
      }
      
      static int valid_remote_nick(const char *name)
    -@@ remote.c: const char *pushremote_for_branch(struct branch *branch, int *explicit)
    - 			*explicit = 1;
    - 		return branch->pushremote_name;
    - 	}
    --	if (the_repository->remote_state->pushremote_name) {
    -+	if (branch->remote_state->pushremote_name) {
    - 		if (explicit)
    - 			*explicit = 1;
    --		return the_repository->remote_state->pushremote_name;
    -+		return branch->remote_state->pushremote_name;
    - 	}
    - 	return remote_for_branch(branch, explicit);
    - }
     @@ remote.c: static struct remote *remote_get_1(const char *name,
      	struct remote *ret;
      	int name_given = 0;
    @@ remote.c: static struct remote *remote_get_1(const char *name,
     +	ret = make_remote(the_repository->remote_state, name, 0);
      	if (valid_remote_nick(name) && have_git_dir()) {
      		if (!valid_remote(ret))
    - 			read_remotes_file(ret);
    +-			read_remotes_file(ret);
    ++			read_remotes_file(the_repository->remote_state, ret);
    + 		if (!valid_remote(ret))
    +-			read_branches_file(ret);
    ++			read_branches_file(the_repository->remote_state, ret);
    + 	}
    + 	if (name_given && !valid_remote(ret))
    +-		add_url_alias(ret, name);
    ++		add_url_alias(the_repository->remote_state, ret, name);
    + 	if (!valid_remote(ret))
    + 		return NULL;
    + 	return ret;
     @@ remote.c: int remote_is_configured(struct remote *remote, int in_repo)
      int for_each_remote(each_remote_fn fn, void *priv)
      {
    @@ remote.h: struct remote_state {
      };
      
      void remote_state_clear(struct remote_state *remote_state);
    -@@ remote.h: struct remote {
    - 
    - 	/* The method used for authenticating against `http_proxy`. */
    - 	char *http_proxy_authmethod;
    -+
    -+	/** The remote_state that this remote belongs to. This is only meant to
    -+	 * be used by remote_* functions. */
    -+	struct remote_state *remote_state;
    - };
    - 
    - /**
    -@@ remote.h: struct branch {
    - 	int merge_alloc;
    - 
    - 	const char *push_tracking_ref;
    -+
    -+	/** The remote_state that this branch belongs to. This is only meant to
    -+	 * be used by branch_* functions. */
    -+	struct remote_state *remote_state;
    - };
    - 
    - struct branch *branch_get(const char *name);
3:  10fbb84496 < -:  ---------- remote: remove the_repository->remote_state from static methods
4:  4013f74fd9 < -:  ---------- remote: add struct repository parameter to external functions
-:  ---------- > 4:  53f2e31f72 remote: remove the_repository->remote_state from static methods
-:  ---------- > 5:  d3281c14eb remote: die if branch is not found in repository
-:  ---------- > 6:  0974994cc6 remote: add struct repository parameter to external functions
-- 
2.33.GIT

