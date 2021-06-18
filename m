Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC8C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC88761209
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhFRVen (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhFRVem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:34:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E622DC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:32:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so8855145pgu.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LK9JP4oAHn6eVH3SRYZjc8Gk1cjDMbfMio8nutdU8FA=;
        b=XNycLRhFA9hSCmIjV+jrJVkHz7tgkpBTfmmysAIG1gx/f7VspDHzYWnpXno4sMIr3Q
         MKKKjpPMS1cgbUfSTL5p4c01RoDUNiTu5aocCYQmuyF2JQTBCFwcNFZ9O2P3IdRsREjh
         mHAX5S4i8Wl4wJHndok5vEk+WcBKv3kHF+m+QhkOx1Tt58SNff7CFh0ANpMsdr3+N7VJ
         p1pu+VxP1Ou1Oqh1HUK4+UeaxiV96DUC3zOEPQHmnFAcKzkdkD5NfM6gyN7TfnkK9i4f
         PzTPyZ/fNLNm+4XSqzEmQUZQ/1saKpeVlFHzV8sx5bpCTA4mZIHAWtg/2Vfz/j5XwJfS
         WdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LK9JP4oAHn6eVH3SRYZjc8Gk1cjDMbfMio8nutdU8FA=;
        b=bQ9Anessts/nqWKlp6TMIa+6GJrD+k/wB7oab3VRHrwhwhxyXvkxsku7wxjHznA38s
         6VoBNAToyy7GeABZRg117fk+R6USP4LWfELhH4zf5HBsVGpdqpR9MuMLzMb66ooyHxQL
         8OEDg9LBhRCrt2NEzn3nr597wVYlqV4ZZhVPrzuiDsCsrYDxWVqZSLaF5GqbzBujaMCV
         fnu3I/KNzdzQ3e896H/jkmC5lyVZUC9KJio7CMwh5RxTfIwRXdsazczYhrRrWJvaaXlX
         6Qijmwea40fEbee4ZoFlTY6TdmdSdpph81UyWWCGm35QIVtOsvdMoCMg4VdAQuVf47UP
         d+VA==
X-Gm-Message-State: AOAM533ZlUU2oFcUCaGwxlwmdD6dRphmG4QnFiG+dvgL2OxCf8FvMJO0
        dLWC7avlSN/lw968GaP8QDNN+A==
X-Google-Smtp-Source: ABdhPJwHfNmgTcXWys5uEk3eFy9uukWbjtff27+OGs7O7XelHE5qoBltkGq6FnDtDjGDBftljVO/uw==
X-Received: by 2002:aa7:838b:0:b029:2ea:3332:dd8a with SMTP id u11-20020aa7838b0000b02902ea3332dd8amr7247061pfm.74.1624051951064;
        Fri, 18 Jun 2021 14:32:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
        by smtp.gmail.com with ESMTPSA id s22sm9340013pfd.94.2021.06.18.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:32:30 -0700 (PDT)
Date:   Fri, 18 Jun 2021 14:32:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] clone,fetch: remote-suggested auto-updating hooks
Message-ID: <YM0Q6AynHC675ndd@google.com>
References: <cover.1623881977.git.jonathantanmy@google.com>
 <0f03e956c183d827c186b6fb85b92bfd31d2dc47.1623881977.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f03e956c183d827c186b6fb85b92bfd31d2dc47.1623881977.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 04:31:49PM -0700, Jonathan Tan wrote:
> 
> Upon cloning, if a ref refs/remotes/origin/suggested-hooks is present,
> Git will inform the user that they can run a command to install those
> hooks and keep them auto-updated upon eacn fetch. If that command is
> run, hooks will be installed (overriding existing ones) and every fetch
> will check if that ref would be updated, and if yes, reinstall the hooks
> from the new commit that the ref points to.
> 
> NEEDSWORK: Write a more detailed commit message once the design is
> finalized.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/clone.c  | 10 ++++++
>  builtin/fetch.c  | 21 ++++++++++++
>  builtin/hook.c   | 13 +++++---
>  hook.c           | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hook.h           |  2 ++
>  t/t5601-clone.sh | 36 +++++++++++++++++++++
>  6 files changed, 162 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2a2a03bf76..0ab4494bcd 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1393,6 +1393,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			   branch_top.buf, reflog_msg.buf, transport,
>  			   !is_local);
>  
> +	for (ref = mapped_refs; ref; ref = ref->next) {
> +		if (ref->peer_ref &&
> +		    !strcmp(ref->peer_ref->name,
> +			    "refs/remotes/origin/suggested-hooks")) {
> +			fprintf(stderr, _("The remote has suggested hooks in refs/remotes/origin/suggested-hooks.\n"
> +					  "Run `git hook autoupdate` to download them, install them, and turn on automatic update of hooks.\n"));

It is possible to clone but to name your origin something besides
'origin', isn't it? *looks..* I guess 'origin' is added by default, but
couldn't a user rename their origin remote later on, or want hooks from
somewhere else? For example:

 - User creates a fork with GitHub web UI
 - User clones their own fork (origin = nasamuffin/someproject)
 - User decides they should probably get latest and greatest code from
   upstream instead, so they add new remote (upstream =
   someproject/someproject)
 - The hooks are in someproject/someproject, and maybe only showed up
   after user forked from web UI. Oops.

Anyway, it might be nice to have this generalized to any remote, not
just 'origin' - maybe I even want to pull in hooks from upstream as well
as hooks from downstream fork with confidential patches added. (I had a
remote setup like this when working on OpenBMC, so it is not beyond
realm of possibility.)

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 769af53ca4..0618d1f091 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "hook.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -84,6 +85,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
>  static int fetch_write_commit_graph = -1;
>  static int stdin_refspecs = 0;
>  static int negotiate_only;
> +static int hook_autoupdate;
>  
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -123,6 +125,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(k, "hook.autoupdate")) {
> +		hook_autoupdate = git_config_bool(k, v);
> +		return 0;
> +	}
> +

Checking if we should look for hook changes every time we fetch. Ok.

> @@ -1313,6 +1320,20 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
>  				 ref_map);
>  	transport_unlock_pack(transport);
>  	trace2_region_leave("fetch", "consume_refs", the_repository);
> +
> +	if (hook_autoupdate) {
> +		struct ref *ref;
> +
> +		for (ref = ref_map; ref; ref = ref->next) {
> +			if (ref->peer_ref &&
> +			    !strcmp(ref->peer_ref->name,
> +				    "refs/remotes/origin/suggested-hooks")) {
> +				hook_update_suggested();
> +				break;
> +			}
> +		}
> +	}
> +

And if fetch gave us a ref like suggested-hooks, then we should go do
hook update operation. Ok.

> +static int autoupdate(int argc, const char **argv, const char *prefix)
> +{
> +	git_config_set("hook.autoupdate", "true");
> +	hook_update_suggested();
> +	return 0;
> +}

The name is a little bit vague to me - this function turns on autoupdate
and performs one hook update, so I think the name at least should cover
that it's related to hooks, and that it's doing setup.

If we wanted to gate "automagically turn on autoupdate" behind a
system-level config like I mentioned in my review of the cover letter,
we could do it here, for example by setting "hook.autoupdate" to the
value of "experimental.autoupdatehooks" (or whatever name is least
painful).

> +
>  int cmd_hook(int argc, const char **argv, const char *prefix)
>  {
>  	const char *run_hookdir = NULL;
> @@ -152,10 +159,6 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, builtin_hook_options,
>  			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN);
>  
> -	/* after the parse, we should have "<command> <hookname> <args...>" */
> -	if (argc < 2)
> -		usage_with_options(builtin_hook_usage, builtin_hook_options);
> -
>  	git_config(git_default_config, NULL);
>  
>  
> @@ -185,6 +188,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
>  		return list(argc, argv, prefix);
>  	if (!strcmp(argv[0], "run"))
>  		return run(argc, argv, prefix);
> +	if (!strcmp(argv[0], "autoupdate"))
> +		return autoupdate(argc, argv, prefix);
>  
>  	usage_with_options(builtin_hook_usage, builtin_hook_options);
>  }
> diff --git a/hook.c b/hook.c
> index 3ccacb72fa..5730e6e501 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -4,6 +4,12 @@
>  #include "config.h"
>  #include "run-command.h"
>  #include "prompt.h"
> +#include "commit.h"
> +#include "object.h"
> +#include "refs.h"
> +#include "tree-walk.h"
> +#include "tree.h"
> +#include "streaming.h"
>  
>  /*
>   * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> @@ -515,3 +521,81 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
>  
>  	return cb_data.rc;
>  }
> +
> +static int is_hook(const char *filename)
> +{
> +	int i;
> +
> +	for (i = 0; i < hook_name_count; i++) {
> +		if (!strcmp(filename, hook_name[i]))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +void hook_update_suggested(void)
> +{
> +	struct object_id oid;
> +	struct object *obj;
> +	struct tree *tree;
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +	struct strbuf path = STRBUF_INIT;
> +
> +	if (read_ref("refs/remotes/origin/suggested-hooks", &oid)) {
> +		warning(_("no such ref refs/remotes/origin/suggested-hooks, not updating hooks"));
> +		return;
> +	}
> +
> +	obj = parse_object(the_repository, &oid);
> +	if (obj == NULL) {
> +		warning(_("object pointed to by refs/remotes/origin/suggested-hooks '%s' does not exist"),
> +			oid_to_hex(&oid));
> +		return;
> +	}
> +	if (obj->type != OBJ_COMMIT) {
> +		warning(_("object pointed to by refs/remotes/origin/suggested-hooks '%s' is not a commit"),
> +			oid_to_hex(&oid));
> +		return;
> +	}
> +
> +	tree = get_commit_tree((struct commit *) obj);
> +	if (parse_tree(tree)) {
> +		warning(_("could not parse tree"));
> +		return;
> +	}
> +
> +	init_tree_desc(&desc, tree->buffer, tree->size);
> +	while (tree_entry(&desc, &entry)) {
> +		int fd;
> +
> +		if (!is_hook(entry.path)) {
> +			warning(_("file '%s' is not a hook; ignoring"),
> +				entry.path);
> +			continue;
> +		}
> +		if (S_ISDIR(entry.mode) || S_ISGITLINK(entry.mode)) {
> +			warning(_("file '%s' is not an ordinary file; ignoring"),
> +				entry.path);
> +			continue;
> +		}
> +
> +		strbuf_reset(&path);
> +		strbuf_git_path(&path, "hooks/%s", entry.path);
> +		fd = open(path.buf, O_WRONLY | O_CREAT, 0755);
> +		if (fd < 0) {
> +			warning_errno(_("could not create file '%s'; skipping this hook"),
> +				      path.buf);
> +			continue;
> +		}
> +		if (stream_blob_to_fd(fd, &entry.oid, NULL, 1)) {
> +			warning(_("could not write to file '%s'; skipping this hook"),
> +				path.buf);
> +			continue;
> +		}
> +		close(fd);
> +	}
> +	strbuf_release(&path);
> +
> +	return;
> +}

I saw that you wanted to reduce reliance on es/config-based-hooks, which
makes sense; but if you wanted to do it the configgy way, I'd instead
add a local config-based hook with a command something like `exec -
<<<$(git show refs/suggested-hooks:presubmit)` (that's not quite
perfect, but I hope gets the point across - materialize the file from
the local ref and execute it, rather than copying it into .git/hooks).

One bonus of doing it that way is that user can commit to their local
suggested-hooks branch and try out their new hook (and even send a
review from there with the change they liked). Hrm.

> diff --git a/hook.h b/hook.h
> index d902166408..b0bfd3719b 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -140,3 +140,5 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options);
>  void free_hook(struct hook *ptr);
>  /* Empties the list at 'head', calling 'free_hook()' on each entry */
>  void clear_hook_list(struct list_head *head);
> +
> +void hook_update_suggested(void);
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index c0688467e7..21b96a4999 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -752,6 +752,42 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
>  	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
>  '
>  
> +test_expect_success 'detect suggested hook branch during clone' '
> +	rm -rf server client &&
> +
> +	test_create_repo server &&
> +	echo "echo foo" >server/pre-commit &&
> +	git -C server add pre-commit &&
> +	test_commit -C server hook-and-not-hook &&
> +	git -C server checkout -b suggested-hooks &&
> +	git clone server client 2>err &&
> +	test_i18ngrep "The remote has suggested hooks" err
> +'
> +
> +test_expect_success 'autoupdate' '
> +	git -C client hook autoupdate &&
> +
> +	# Check correct config written
> +	git -C client config --local hook.autoupdate >actual &&
> +	echo "true" >expect &&
> +	test_cmp expect actual &&
> +
> +	# Check hook written
> +	cat client/.git/hooks/pre-commit >actual &&
> +	echo "echo foo" >expect &&
> +	test_cmp expect actual &&
> +
> +	# Install new hook and fetch it
> +	echo "echo bar" >server/pre-commit &&
> +	git -C server commit -am "new hook" &&
> +	git -C client fetch &&
> +
> +	# Check new hook written
> +	cat client/.git/hooks/pre-commit >actual &&
> +	echo "echo bar" >expect &&
> +	test_cmp expect actual
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>  
> -- 
> 2.32.0.272.g935e593368-goog
> 
