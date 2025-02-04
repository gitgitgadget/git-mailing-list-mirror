Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24B21B182
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704874; cv=none; b=H9rvzCg1yStjn+neQ2vanhtgw5IWamiJBbGb7ljXkYoWoz+DXgs7zM+jkj9y8DHHROVij4scbSz8lsz9ApHvJcXyYGvLjkUyb5/Koxm4ScvOSYOykDZhFa49LNzJFpJYIwFhaCYmMZVdv8K8CdY89KtOQv3bXeGkZW56EGbTfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704874; c=relaxed/simple;
	bh=I8KtZm02pjRYhTMBh+9JdQFR4WfEa1II8TAtGs17BSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YT2wakpKljsnNWEqxFcIc7u6ay5K+sHbcVrWaHi/jJRJlRDoQkOVMcRmEF+7fHQDNsSdDp7OVyhp1cv3/bNx+5SM1pXAzQBK/yC9vdqI9mRpXZSL/+y1F8mRLue/DuiOYjkSRiKzyJIdf7mLQiqP2bQTJLFwo8uVISBpZ/yu6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0iAjVOYW; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0iAjVOYW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738704854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxQYcySHCtmsTFR1KnTRyi9V3atyVTCNO+Z5+xAQD84=;
	b=0iAjVOYWWGrXHl/tktVBf29TuymN+FZCBjr4/tCnmoSHCz8RhA5f37XErjp14M0/KI1Vzy
	N+t37QdMSRELgrw7z57zruFl6Z0xFcVf82/Bqkq6jPS6ghwBcp1hxmpWrPO6WUHtTUEDV4
	J/VxpoNjJu5ZoY4prYJeknRgW44CO5M=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 0/7] Enable doing a shallow clone of a specific git
 revision
Date: Tue, 04 Feb 2025 22:33:59 +0100
Message-Id: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMiHomcC/23NzWoCMRwE8FeRnBv5f6WbePI9ioeQTWrAbmSzL
 BXZd29caCvqcQZ+M1dV45hjVbvNVY1xzjWXoQXztlHh6IfPqHPfsiIgQSSnp1IGHU5liHqMqWr
 f8ztx11FypJo6tzZ/r4sfh5aPuU5lvKwHM97adQscdWCNsN0iIAijxnV7n8sUTttQvtSNz/RHX
 t7P1FwfvAR0ng3Co+d/T/jCc/MoVpKPngHso5dfbwAZn71o0OQlJWtQnE33flmWH8iAQnRhAQA
 A
X-Change-ID: 20241129-toon-clone-refs-ad3623772f92
In-Reply-To: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The goal of this series is to add an option `--revision` to
git-clone(1).

This series starts with a handful of preparatory refactoring commits
that make it more straight-forward to add this new option. In the last
commit we're actually adding the feature.

This series sets an example on how I think we can further refactor
builtin/clone.c to increase the maintainability of the code.

---
Changes in v5:
- Add separate commit to introduce die_for_incompatible_opt2()
- Small tweaks in documentation about `--[no-]tags` and `--revision`.
- Better explain the refactoring of wanted_peer_refs() in the commit
  message.
- Change type from `int` to `size_t` in wanted_peer_refs().
- Use lookup_commit_or_die() instead lookup_commit_reference() to avoid
  checking the result ourself.
- Add a few code comments to explain some things.
- Stylish cleanups like removal of unneeded empty lines, commented out
  test-code and remarks.
- Link to v4: https://lore.kernel.org/r/20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com

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
Toon Claes (7):
      clone: cut down on global variables in clone.c
      clone: make it possible to specify --tags
      clone: refactor wanted_peer_refs()
      clone: add tags refspec earlier to fetch refspec
      clone: introduce struct clone_opts in builtin/clone.c
      parse-options: introduce die_for_incompatible_opt2()
      builtin/clone: teach git-clone(1) the --revision= option

 Documentation/git-clone.txt |  17 ++-
 builtin/clone.c             | 350 +++++++++++++++++++++++++-------------------
 builtin/replay.c            |   3 +-
 parse-options.h             |   9 ++
 remote.c                    |   2 +-
 remote.h                    |   5 +
 t/meson.build               |   1 +
 t/t5621-clone-revision.sh   | 123 ++++++++++++++++
 8 files changed, 351 insertions(+), 159 deletions(-)
---

Range-diff versus v4:

1:  a563ae1023 = 1:  43fbfe2a1c clone: cut down on global variables in clone.c
2:  031fec1961 ! 2:  68bbf04606 clone: make it possible to specify --tags
    @@ Documentation/git-clone.txt: git clone [--template=<template-directory>]
      	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
      	  [--dissociate] [--separate-git-dir <git-dir>]
     -	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
    -+	  [--depth <depth>] [--[no-]single-branch] [--[no-]-tags]
    ++	  [--depth <depth>] [--[no-]single-branch] [--[no-]tags]
      	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
      	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
      	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
    @@ Documentation/git-clone.txt: corresponding `--mirror` and `--no-tags` options in
     -`--no-tags`::
     -	Don't clone any tags, and set
     +`--[no-]tags`::
    -+	By default tags are cloned, and passing `--tags` doesn't change that.
     +	With `--no-tags`, no tags are cloned, and set
      	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
      	that future `git pull` and `git fetch` operations won't follow
      	any tags. Subsequent explicit tag fetches will still work,
    + 	(see linkgit:git-fetch[1]).
    ++	By default tags are cloned, and passing `--tags` doesn't change that.
    + +
    + Can be used in conjunction with `--single-branch` to clone and
    + maintain a branch with no references other than a single cloned
     
      ## builtin/clone.c ##
     @@
3:  b926bcc1df ! 3:  ac0babfc2a clone: refactor wanted_peer_refs()
    @@ Commit message
     
         Over time this function grown to be very complex. Refactor it.
     
    +    Previously, there was a separate code path for when
    +    `option_single_branch` was set. It resulted in duplicated code and
    +    deeper nested conditions. After this refactor the code path for when
    +    `option_single_branch` is truthy modifies `refs` and then falls through
    +    to the common code path. This approach relies on the `refspec` being set
    +    correctly and thus only mapping refs that are relevant.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## builtin/clone.c ##
    @@ builtin/clone.c: static struct ref *wanted_peer_refs(const struct ref *refs,
      	}
      
     -	if (!option_mirror && !option_single_branch && option_tags)
    -+	for (int i = 0; i < refspec->nr; i++)
    ++	for (size_t i = 0; i < refspec->nr; i++)
     +		get_fetch_map(refs, &refspec->items[i], &tail, 0);
     +
     +	/*
4:  2201b996b3 ! 4:  8a98961fd5 clone: add tags refspec earlier to fetch refspec
    @@ Commit message
     
         In clone.c we call refspec_ref_prefixes() to copy the fetch refspecs
         from the `remote->fetch` refspec into `ref_prefixes` of
    -    `transport_ls_refs_options`. Afterward we add the tags prefix
    +    `transport_ls_refs_options`. Afterwards we add the tags prefix
         `refs/tags/` prefix as well. At a later point, in wanted_peer_refs() we
         process refs using both `remote->fetch` and `TAG_REFSPEC`.
     
    @@ builtin/clone.c: static struct ref *wanted_peer_refs(const struct ref *refs,
      		if (!option_branch)
      			refs = to_free = guess_remote_head(head, refs, 0);
     @@ builtin/clone.c: static struct ref *wanted_peer_refs(const struct ref *refs,
    - 	for (int i = 0; i < refspec->nr; i++)
    + 	for (size_t i = 0; i < refspec->nr; i++)
      		get_fetch_map(refs, &refspec->items[i], &tail, 0);
      
     -	/*
    @@ builtin/clone.c: int cmd_clone(int argc,
      	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
     +
     +	if (option_tags || option_branch)
    ++		/*
    ++		 * Add tags refspec when user asked for tags (implicitly) or
    ++		 * specified --branch, which argument might be a tag.
    ++		 */
     +		refspec_append(&remote->fetch, TAG_REFSPEC);
     +
      	refspec_ref_prefixes(&remote->fetch,
5:  14fb827c41 ! 5:  b338eec186 clone: introduce struct clone_opts in builtin/clone.c
    @@ builtin/clone.c: static struct ref *find_remote_branch(const struct ref *refs, c
     +		struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
     +		if (head)
     +			tail_link_ref(head, &tail);
    -+
     +		if (option_single_branch)
      			refs = to_free = guess_remote_head(head, refs, 0);
     -		else {
    @@ builtin/clone.c: static struct ref *find_remote_branch(const struct ref *refs, c
     -			tail = &local_refs;
     -			refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
     -		}
    -+	}
    -+
    -+	else if (option_single_branch) {
    ++	} else if (option_single_branch) {
     +		local_refs = NULL;
     +		tail = &local_refs;
     +		refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
      	}
      
    - 	for (int i = 0; i < refspec->nr; i++)
    + 	for (size_t i = 0; i < refspec->nr; i++)
     @@ builtin/clone.c: int cmd_clone(int argc,
      	struct string_list server_options = STRING_LIST_INIT_NODUP;
      	const char *bundle_uri = NULL;
    @@ remote.h: struct ref *alloc_ref(const char *name);
      struct ref *copy_ref(const struct ref *ref);
      struct ref *copy_ref_list(const struct ref *ref);
      int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
    ++/*
    ++ * Put a ref in the tail and prepare tail for adding another one.
    ++ * *tail is the pointer to the tail of the list of refs.
    ++ */
     +void tail_link_ref(struct ref *ref, struct ref ***tail);
      
      int check_ref_type(const struct ref *ref, int flags);
-:  ---------- > 6:  d312865d63 parse-options: introduce die_for_incompatible_opt2()
6:  d87d155dfc ! 7:  8ddbc6eb41 builtin/clone: teach git-clone(1) the --revision= option
    @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
      	`--branch` can also take tags and detaches the `HEAD` at that commit
      	in the resulting repository.
      
    -+`--revision` _<rev>_::
    ++`--revision=<rev>`::
     +	Create a new repository, and fetch the history leading to the given
     +	revision _<rev>_ (and nothing else), without making any remote-tracking
     +	branch, and without making any local branch, and point `HEAD` to
    @@ builtin/clone.c: static void update_remote_refs(const struct ref *refs,
      		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL) < 0)
      			die(_("unable to update HEAD"));
     @@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref *remote,
    + 			install_branch_config(0, head, remote_name, our->name);
    + 		}
      	} else if (our) {
    - 		struct commit *c = lookup_commit_reference(the_repository,
    - 							   &our->old_oid);
    -+
    -+		if (!c)
    -+			die(_("couldn't look up commit object for '%s'"), our->name);
    +-		struct commit *c = lookup_commit_reference(the_repository,
    +-							   &our->old_oid);
    ++		struct commit *c = lookup_commit_or_die(&our->old_oid,
    ++						        our->name);
     +
      		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
      		refs_update_ref(get_main_ref_store(the_repository), msg,
    @@ builtin/clone.c: int cmd_clone(int argc,
     +				  !!option_branch, "--branch");
     +	die_for_incompatible_opt2(!!option_rev, "--revision",
     +				  option_mirror, "--mirror");
    -+	// TODO --no-single-branch
     +
      	if (reject_shallow)
      		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
    @@ builtin/clone.c: int cmd_clone(int argc,
     -	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
     +	if (option_rev) {
     +		option_tags = 0;
    -+		option_branch = 0;
     +		option_single_branch = 0;
     +		opts.wants_head = 0;
     +		opts.detach = 1;
    @@ builtin/clone.c: int cmd_clone(int argc,
     +	}
      
      	if (option_tags || option_branch)
    - 		refspec_append(&remote->fetch, TAG_REFSPEC);
    + 		/*
     @@ builtin/clone.c: int cmd_clone(int argc,
      		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
      				  option_branch);
    @@ builtin/clone.c: int cmd_clone(int argc,
     +		if (!our_head_points_at)
     +			die(_("Remote revision %s not found in upstream %s"),
     +			    option_rev, remote_name);
    -+		//mapped_refs->name[0] = 0;
      	} else if (remote_head_points_at) {
      		our_head_points_at = remote_head_points_at;
      	} else if (remote_head) {
    @@ builtin/clone.c: int cmd_clone(int argc,
      	/*
      	 * We want to show progress for recursive submodule clones iff
     
    - ## parse-options.h ##
    -@@ parse-options.h: static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
    - 				  0, "");
    - }
    - 
    -+static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
    -+					     int opt2, const char *opt2_name)
    -+{
    -+	die_for_incompatible_opt4(opt1, opt1_name,
    -+				  opt2, opt2_name,
    -+				  0, "",
    -+				  0, "");
    -+}
    -+
    - /*
    -  * Use these assertions for callbacks that expect to be called with NONEG and
    -  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
    -
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
        't5617-clone-submodules-remote.sh',


---

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20241129-toon-clone-refs-ad3623772f92

Thanks
--
Toon

