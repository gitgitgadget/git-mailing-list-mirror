Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CC14B092
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337466; cv=none; b=undiH74/Fii+aTPeKod1uTVHr9RPVbYLS5o6uyj8OZowYkbPfG+h+dSDROeu+rMgXBWDDo+m8MtHpDhJbi23oIhDDSb+ojpRtedBg35BCNb++k/fK7KHLmFLgSqslh13SXjic7ErF5GI0Wk7nyyqDMP9gI03slMmeIlmnwfxHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337466; c=relaxed/simple;
	bh=Hhd/fh66OjBr/wDVJ1yQ/O1brYgJfARZT9vEDnjS+L4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Nlvv0t34WiK1kKwxN23EzuedgFLVEiMVWzI2Ly8rZgJHNEzLwhsQA+PltJxonLkLbp33D41IxyT7njqjl1kIvcJBF32wl6eFiky84wRMua9+oKdk9IQAdyVoRQajX5NYhcQ7crxltV5wFgDvw5qgWvZjeu4Jm8wtXWePXQyhkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0y6/BWuD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0y6/BWuD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738337454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsO8SJZKOrJqITqbM3LXOhSxEQvLHdw19xem+1HbXIc=;
	b=0y6/BWuD9YUPuOVlFcEsTlSikdqj1giLixbFyBcLPN7TOgRqsyRjGqe4TduacGxZ+NvIUl
	Ahe2Lxrh2fnftXbj93GegeaJ/oxhQtx6GFoCT9vXe5LUTx2JNLUQBbteQqqRZT9AqFMBzo
	jBJ+5ZUWz2eZXTH36xutq6y9zmij2QE=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 0/6] Enable doing a shallow clone of a specific git
 revision
Date: Fri, 31 Jan 2025 16:30:28 +0100
Message-Id: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTsnGcC/23NQQ7CIBQE0Ks0rKXhf6ilrryHcUEotSQVDDRE0
 /TuUhZqTJczyZtZSDTBmkhO1UKCSTZa73IQh4roUbmbobbPmSBDAYAdnb13VE/eGRrMEKnq+RF
 52+LQIcnqkVv7LIuXa86jjbMPr3KQYGvLFuuwZbIRXNbAgAkOFMr22fpZT7X2d7LxhB+ye58wu
 14roaFTvAH27/nXI+x4nj0IKQZlFGdM/vp1Xd9RDuHUIQEAAA==
X-Change-ID: 20241129-toon-clone-refs-ad3623772f92
In-Reply-To: <20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com>
References: <20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The goal of this series is to add an option `--revision` to
git-clone(1).

Compared to previous version, I'm adding a handful of prepatory
refactoring commits that make it more straight-forward to add this new
option.

This series sets an example on how I think we can further refactor
builtin/clone.c to increase the maintainability of the code.

---
Changes in v4:
- Introduce a new commit to reduce the use of global variables.
- Introduce a new commit to invert the flag --no-tags to --tags.
- Introduce a new commit to refactor wanted_peer_refs() in
  builtin/clone.c.
- Introduce a new commit to shuffle the handling of tags refspec.
- Introduce a new commit to introduce a `struct clone_opts`.
- Link to v3: https://lore.kernel.org/r/20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com

Changes in v3:
- Fail early when the revision was not found on the remote, instead of
  creating a clone that's in an invalid state.
- State more clearly in the commit message adding this option is useful
  for a not uncommon use-case.
- Be explicit in the documentation the ref needs to peel down to a
  commit.
- Die in case we try to update_head() to an object that's not a commit.
- Allow combining `--revision` with `--bare`.
- Add die_for_incompatible_opt2() to parse-options.h and use it for the
  options that are not compatible with the new `--revision` option.
- Small tweaks to the added tests.
- Small touchups on commit messages.
- Link to v2: https://lore.kernel.org/r/20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com

---
Toon Claes (6):
      clone: cut down on global variables in clone.c
      clone: make it possible to specify --tags
      clone: refactor wanted_peer_refs()
      clone: add tags refspec earlier to fetch refspec
      clone: introduce struct clone_opts in builtin/clone.c
      builtin/clone: teach git-clone(1) the --revision= option

 Documentation/git-clone.txt |  17 ++-
 builtin/clone.c             | 345 +++++++++++++++++++++++++-------------------
 parse-options.h             |   9 ++
 remote.c                    |   2 +-
 remote.h                    |   1 +
 t/meson.build               |   1 +
 t/t5621-clone-revision.sh   | 123 ++++++++++++++++
 7 files changed, 345 insertions(+), 153 deletions(-)
---

Range-diff versus v3:

-:  ---------- > 1:  b16d266d95 clone: cut down on global variables in clone.c
-:  ---------- > 2:  8a78ad94ac clone: make it possible to specify --tags
-:  ---------- > 3:  156602ecda clone: refactor wanted_peer_refs()
-:  ---------- > 4:  1df83a1207 clone: add tags refspec earlier to fetch refspec
-:  ---------- > 5:  8acaad897d clone: introduce struct clone_opts in builtin/clone.c
1:  6424e444c1 ! 6:  ed3195d705 builtin/clone: teach git-clone(1) the --revision= option
    @@ Commit message
         cannot be selected upon git-clone(1).
     
         Add option `--revision` to git-clone(1). This option accepts a fully
    -    qualified reference, or a raw commit hash. This enables the user to
    -    clone and check out any revision they want. `--revision` can be used in
    -    conjunction with `--depth` to do a minimal clone that only contains the
    -    sources for a single revision. This can be useful for automated tests
    -    running in CI systems.
    +    qualified reference, or a hexadecimal commit ID. This enables the user
    +    to clone and check out any revision they want. `--revision` can be used
    +    in conjunction with `--depth` to do a minimal clone that only contains
    +    the blob and tree for a single revision. This can be useful for
    +    automated tests running in CI systems.
     
    -    This type of shallow clone could also be achieved with the following set
    -    of commands:
    +    Using option `--branch` and `--single-branch` together is a similar
    +    scenario, but serves a different purpose. Using these two options, a
    +    singlet remote tracking branch is created and the fetch refspec is set
    +    up so git-fetch(1) will receive updates on that branch from the remote.
    +    This allows the user work on that single branch.
     
    -        git init the-repo
    -        cd ./the-repo
    -        git remote add origin <url>
    -        git fetch --depth=1 origin <commit-id>
    -        git checkout <commit-id>
    -
    -    Adding this new option to git-clone(1) simplifies this not uncommon
    -    use-case. And besides simplifying this, it enables the use of
    -    git-clone(1) over git-fetch(1). This is beneficial in case bundle URIs
    -    are available on the server. Bundle URIs are only used on clone, not on
    -    fetch, so using allowing the user to use git-clone(1) here makes them
    -    benefit from bundle URIs if advertised by the server.
    +    Option `--revision` on contrary detaches HEAD, creates no tracking
    +    branches, and writes no fetch refspec.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
      	in the resulting repository.
      
     +`--revision` _<rev>_::
    -+	This clones the given revision, and that revision only. The argument can
    -+	be a ref name (e.g. `refs/heads/main`) that peels down to a commit, or a
    -+	raw commit hash.
    -+	The given revision is checked out, and for any revision other than a
    -+	branch (i.e. ref starting with `refs/heads/`), the HEAD is detached.
    -+	This option is incompatible with `--branch`, `--mirror`, and `--bare`.
    ++	Create a new repository, and fetch the history leading to the given
    ++	revision _<rev>_ (and nothing else), without making any remote-tracking
    ++	branch, and without making any local branch, and point `HEAD` to
    ++	_<rev>_. When creating a non-bare repository, the revision is checked
    ++	out on a detached `HEAD`. The argument can be a ref name
    ++	(e.g. `refs/heads/main` or `refs/tags/v1.0`) that peels down to a
    ++	commit, or a hexadecimal object name.
    ++	This option is incompatible with `--branch` and `--mirror`.
     +
      `-u` _<upload-pack>_::
      `--upload-pack` _<upload-pack>_::
      	When given, and the repository to clone from is accessed
     
      ## builtin/clone.c ##
    -@@ builtin/clone.c: static char *option_template, *option_depth, *option_since;
    - static char *option_origin = NULL;
    - static char *remote_name = NULL;
    - static char *option_branch = NULL;
    -+static char *option_rev = NULL;
    - static struct string_list option_not = STRING_LIST_INIT_NODUP;
    - static const char *real_git_dir;
    - static const char *ref_format;
    -@@ builtin/clone.c: static struct option builtin_clone_options[] = {
    - 		   N_("use <name> instead of 'origin' to track upstream")),
    - 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
    - 		   N_("checkout <branch> instead of the remote's HEAD")),
    -+	OPT_STRING(0, "revision", &option_rev, N_("rev"),
    -+		   N_("clone single revision <rev> and check out")),
    - 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
    - 		   N_("path to git-upload-pack on the remote")),
    - 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
    +@@
    + 
    + struct clone_opts {
    + 	int wants_head;
    ++	int detach;
    + };
    + #define CLONE_OPTS_INIT { \
    + 	.wants_head = 1 /* default enabled */ \
    +@@ builtin/clone.c: static void update_remote_refs(const struct ref *refs,
    + 	}
    + }
    + 
    +-static void update_head(const struct ref *our, const struct ref *remote,
    ++static void update_head(struct clone_opts *opts, const struct ref *our, const struct ref *remote,
    + 			const char *unborn, const char *msg)
    + {
    + 	const char *head;
    +-	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
    ++	if (our && !opts->detach && skip_prefix(our->name, "refs/heads/", &head)) {
    + 		/* Local default branch link */
    + 		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL) < 0)
    + 			die(_("unable to update HEAD"));
     @@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref *remote,
      	} else if (our) {
      		struct commit *c = lookup_commit_reference(the_repository,
      							   &our->old_oid);
    ++
     +		if (!c)
    -+			die(_("unable to update HEAD"));
    ++			die(_("couldn't look up commit object for '%s'"), our->name);
     +
      		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
      		refs_update_ref(get_main_ref_store(the_repository), msg,
      				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
    -@@ builtin/clone.c: static void write_refspec_config(const char *src_ref_prefix,
    - 	struct strbuf key = STRBUF_INIT;
    - 	struct strbuf value = STRBUF_INIT;
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 	int option_filter_submodules = -1; /* unspecified */
    + 	struct string_list server_options = STRING_LIST_INIT_NODUP;
    + 	const char *bundle_uri = NULL;
    ++	char *option_rev = NULL;
    + 
    + 	struct clone_opts opts = CLONE_OPTS_INIT;
    + 
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 			   N_("use <name> instead of 'origin' to track upstream")),
    + 		OPT_STRING('b', "branch", &option_branch, N_("branch"),
    + 			   N_("checkout <branch> instead of the remote's HEAD")),
    ++		OPT_STRING(0, "revision", &option_rev, N_("rev"),
    ++			   N_("clone single revision <rev> and check out")),
    + 		OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
    + 			   N_("path to git-upload-pack on the remote")),
    + 		OPT_STRING(0, "depth", &option_depth, N_("depth"),
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 		strbuf_addstr(&branch_top, src_ref_prefix);
    + 
    + 		git_config_set("core.bare", "true");
    +-	} else {
    ++	} else if (!option_rev) {
    + 		strbuf_addf(&branch_top, "refs/remotes/%s/", remote_name);
    + 	}
      
    --	if (option_mirror || !option_bare) {
    -+	if (!option_rev && (option_mirror || !option_bare)) {
    - 		if (option_single_branch && !option_mirror) {
    - 			if (option_branch) {
    - 				if (starts_with(our_head_points_at->name, "refs/tags/"))
     @@ builtin/clone.c: int cmd_clone(int argc,
    - 	char *repo_to_free = NULL;
    - 	char *path = NULL, *dir, *display_repo = NULL;
    - 	int dest_exists, real_dest_exists = 0;
    --	const struct ref *refs, *remote_head;
    -+	const struct ref *refs = NULL, *remote_head;
    - 	struct ref *remote_head_points_at = NULL;
    - 	const struct ref *our_head_points_at;
    - 	char *unborn_head = NULL;
    + 
    + 	remote = remote_get_early(remote_name);
    + 
    +-	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
    +-			branch_top.buf);
    ++	if (!option_rev)
    ++		refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
    ++				branch_top.buf);
    + 
    + 	path = get_repo_path(remote->url.v[0], &is_bundle);
    + 	is_local = option_local != 0 && path && !is_bundle;
     @@ builtin/clone.c: int cmd_clone(int argc,
      
      	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
    @@ builtin/clone.c: int cmd_clone(int argc,
     +				  !!option_branch, "--branch");
     +	die_for_incompatible_opt2(!!option_rev, "--revision",
     +				  option_mirror, "--mirror");
    ++	// TODO --no-single-branch
     +
      	if (reject_shallow)
      		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
      	if (option_depth)
     @@ builtin/clone.c: int cmd_clone(int argc,
    - 		strvec_push(&transport_ls_refs_options.ref_prefixes,
    - 			    "refs/tags/");
    + 	if (transport->smart_options && !deepen && !filter_options.choice)
    + 		transport->smart_options->check_self_contained_and_connected = 1;
      
    --	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
    +-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
     +	if (option_rev) {
    -+		refspec_clear(&remote->fetch);
    -+		refspec_init(&remote->fetch, REFSPEC_FETCH);
    -+		refspec_append(&remote->fetch, option_rev);
    ++		option_tags = 0;
    ++		option_branch = 0;
    ++		option_single_branch = 0;
    ++		opts.wants_head = 0;
    ++		opts.detach = 1;
     +
    -+		strvec_clear(&transport_ls_refs_options.ref_prefixes);
    -+		refspec_ref_prefixes(&remote->fetch,
    -+				     &transport_ls_refs_options.ref_prefixes);
    -+
    -+		if (transport_ls_refs_options.ref_prefixes.nr == 0)
    -+			/*
    -+			 * We need to talk to the server to determine the hash
    -+			 * algorithm, but when no ref prefixes are set the
    -+			 * server announces all known refs, so ask the server to
    -+			 * only tell us about HEAD.
    -+			 */
    -+			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
    ++		refspec_append(&remote->fetch, option_rev);
     +	}
    -+
    -+	refs = transport_get_remote_refs(transport,
    -+					 &transport_ls_refs_options);
      
    - 	/*
    - 	 * Now that we know what algorithm the remote side is using, let's set
    + 	if (option_tags || option_branch)
    + 		refspec_append(&remote->fetch, TAG_REFSPEC);
     @@ builtin/clone.c: int cmd_clone(int argc,
    - 		}
    - 	}
    + 		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
    + 				  option_branch);
      
    --	if (refs)
    -+	if (option_rev) {
    -+		struct ref **tail = &mapped_refs;
    ++	/*
    ++	 * As part of transport_get_remote_refs() the server tells us the hash
    ++	 * algorithm, which we require to initialize the repo. But calling that
    ++	 * function without any ref prefix, will cause the server to announce
    ++	 * all known refs. If the argument passed to --revision was a hex oid,
    ++	 * ref_prefixes will be empty so we fall back to asking about HEAD to
    ++	 * reduce traffic from the server.
    ++	 */
    ++	if (opts.wants_head || transport_ls_refs_options.ref_prefixes.nr == 0)
    ++		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
     +
    -+		get_fetch_map(refs, &remote->fetch.items[0], &tail, 1);
    -+	} else if (refs) {
    - 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
    -+	}
    + 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
      
    - 	if (mapped_refs) {
    - 		/*
    + 	/*
     @@ builtin/clone.c: int cmd_clone(int argc,
      		if (!our_head_points_at)
      			die(_("Remote branch %s not found in upstream %s"),
    @@ builtin/clone.c: int cmd_clone(int argc,
     +		if (!our_head_points_at)
     +			die(_("Remote revision %s not found in upstream %s"),
     +			    option_rev, remote_name);
    ++		//mapped_refs->name[0] = 0;
      	} else if (remote_head_points_at) {
      		our_head_points_at = remote_head_points_at;
      	} else if (remote_head) {
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 		free(to_free);
    + 	}
    + 
    +-	write_refspec_config(src_ref_prefix, our_head_points_at,
    +-			remote_head_points_at, &branch_top);
    ++	if (!option_rev)
    ++		write_refspec_config(src_ref_prefix, our_head_points_at,
    ++				     remote_head_points_at, &branch_top);
    + 
    + 	if (filter_options.choice)
    + 		partial_clone_register(remote_name, &filter_options);
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 			   branch_top.buf, reflog_msg.buf, transport,
    + 			   !is_local);
    + 
    +-	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
    ++	update_head(&opts, our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
    + 
    + 	/*
    + 	 * We want to show progress for recursive submodule clones iff
     
      ## parse-options.h ##
     @@ parse-options.h: static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
    @@ t/meson.build: integration_tests = [
        't5617-clone-submodules-remote.sh',
        't5618-alternate-refs.sh',
        't5619-clone-local-ambiguous-transport.sh',
    -+  't5620-clone-revision.sh',
    ++  't5621-clone-revision.sh',
        't5700-protocol-v1.sh',
        't5701-git-serve.sh',
        't5702-protocol-v2.sh',
     
    - ## t/t5620-clone-revision.sh (new) ##
    + ## t/t5621-clone-revision.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t5620-clone-revision.sh (new)
     +	git clone --revision=refs/heads/feature . dst &&
     +	git rev-parse refs/heads/feature >expect &&
     +	git -C dst rev-parse HEAD >actual &&
    ++	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
     +	test_cmp expect actual &&
    -+	git for-each-ref refs/heads/feature > expect &&
    -+	git -C dst for-each-ref > actual &&
    -+	test_cmp expect actual
    ++	git -C dst for-each-ref refs >expect &&
    ++	test_must_be_empty expect &&
    ++	test_must_fail git -C dst config remote.origin.fetch
     +'
     +
     +test_expect_success 'clone with --depth and --revision being a branch' '
     +	test_when_finished "rm -rf dst" &&
    -+	git clone --depth=1 --revision=refs/heads/feature . dst &&
    ++	git clone --no-local --depth=1 --revision=refs/heads/feature . dst &&
     +	git rev-parse refs/heads/feature >expect &&
     +	git -C dst rev-parse HEAD >actual &&
    -+	test_cmp expect actual
    ++	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
    ++	test_cmp expect actual &&
    ++	git -C dst for-each-ref refs >expect &&
    ++	test_must_be_empty expect &&
    ++	test_must_fail git -C dst config remote.origin.fetch &&
    ++	git -C dst rev-list HEAD >actual &&
    ++	test_line_count = 1 actual
     +'
     +
     +test_expect_success 'clone with --revision being a tag' '
    @@ t/t5620-clone-revision.sh (new)
     +	git clone --revision=refs/tags/v1.0 . dst &&
     +	git rev-parse refs/tags/v1.0^{} >expect &&
     +	git -C dst rev-parse HEAD >actual &&
    -+	test_cmp expect actual
    ++	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
    ++	test_cmp expect actual &&
    ++	git -C dst for-each-ref refs >expect &&
    ++	test_must_be_empty expect &&
    ++	test_must_fail git -C dst config remote.origin.fetch
     +'
     +
     +test_expect_success 'clone with --revision being HEAD' '
    @@ t/t5620-clone-revision.sh (new)
     +	git clone --revision=HEAD . dst &&
     +	git rev-parse HEAD >expect &&
     +	git -C dst rev-parse HEAD >actual &&
    -+	test_cmp expect actual
    ++	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
    ++	test_cmp expect actual &&
    ++	git -C dst for-each-ref refs >expect &&
    ++	test_must_be_empty expect &&
    ++	test_must_fail git -C dst config remote.origin.fetch
     +'
     +
     +test_expect_success 'clone with --revision being a raw commit hash' '
    @@ t/t5620-clone-revision.sh (new)
     +	git clone --revision=$oid . dst &&
     +	echo $oid >expect &&
     +	git -C dst rev-parse HEAD >actual &&
    -+	test_cmp expect actual
    ++	test_must_fail git -C dst symbolic-ref -q HEAD >/dev/null &&
    ++	test_cmp expect actual &&
    ++	git -C dst for-each-ref refs >expect &&
    ++	test_must_be_empty expect &&
    ++	test_must_fail git -C dst config remote.origin.fetch
     +'
     +
     +test_expect_success 'clone with --revision and --bare' '
     +	test_when_finished "rm -rf dst" &&
     +	git clone --revision=refs/heads/main --bare . dst &&
     +	oid=$(git rev-parse refs/heads/main) &&
    -+	git -C dst cat-file -t $oid > actual &&
    ++	git -C dst cat-file -t $oid >actual &&
     +	echo "commit" >expect &&
    -+	test_cmp expect actual
    ++	test_cmp expect actual &&
    ++	git -C dst for-each-ref refs >expect &&
    ++	test_must_be_empty expect &&
    ++	test_must_fail git -C dst config remote.origin.fetch
     +'
     +
     +test_expect_success 'clone with --revision being a short raw commit hash' '


---

base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
change-id: 20241129-toon-clone-refs-ad3623772f92

Thanks
--
Toon

