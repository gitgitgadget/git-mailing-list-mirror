Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB084C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiBXQ2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiBXQ2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:28:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447B090CDA
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r10so184154wma.2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SW+FU/VKC37dd336hxz20pI0MLlwXO4EK6XDEKBzL4w=;
        b=JHif3tuZXWKT94OpE5fwBB6vjuzA7RBjEiVAWynCh3uLd4ld1carVw9EJCI7oddQyv
         S9qy0fdWEDI+5l7MkIDSwmEZbN/Wqd502sp6gQWY2Y8Q1PRe+o6MgYocjqOE9iFs2BME
         RH7EC7D2zahxIWd+M7GlVRinWuM21pFYGLAV66ad7bJrFlaOP/ymMgibJgqaWvdlrDql
         ALIcT6GCpx1zR0Z7lis2XzFIzFgsXYzB+HqFdSrcp9DZ8s0Po112jzUkqVbyRuoGCU1j
         9EOf0o4XKA4Ok6qmlCdo0P9FHOfRdbLrKiRbXeTHm7KrAM+SZKZ3N9PqumBnmtj0p8ln
         6wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SW+FU/VKC37dd336hxz20pI0MLlwXO4EK6XDEKBzL4w=;
        b=DZ7x7wawJH8o59uo2o1fO2/iSg6/DdeQseMGI/VZwRv1FnZ7LNFsSNXvUCqHsf9orj
         wrC9Ur4yaI4mcwJ1VvOeJ+Z1kLPT315oHnW7FFCa7PL4zrmFwx3rGrJekO4FXdji9xEm
         EsyO8syLAFCJOH7dT8a8XKrcKubR7ikC/pXELA0Iei0sgQRIPzIfynocvIvl3La+OHlw
         lMKqrZExTielcv2bWYC6zE49wGUDpl+Oqs/7zqMY4iJrqoRxsebD+HezmwlQvmoexuJD
         bll9usU2tm2Jr1el2vw3r35/slYtp4urDLeJvLJN50/jrJjXsiCB82no9Nfv3T4vde7e
         +Y4A==
X-Gm-Message-State: AOAM5315rLpbhaEl6u1KYi8ZkvgsQsl6f0yMgNkSaI9jvVWn7HdeDs0J
        5lyF9x9zdd29+ELX3ggo9CkDv8/Jfys=
X-Google-Smtp-Source: ABdhPJxRWLFFCaEkjXApXqqzBhKPs9VDfPiioknn3Zb91R/9IAF85XKhE4w/O898a9Ff+FAPmW+Buw==
X-Received: by 2002:a1c:4d0e:0:b0:37c:b85:5404 with SMTP id o14-20020a1c4d0e000000b0037c0b855404mr2881675wmh.184.1645719220128;
        Thu, 24 Feb 2022 08:13:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm1159922wmp.11.2022.02.24.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:39 -0800 (PST)
Message-Id: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:30 +0000
Subject: [PATCH v2 0/8] fetch: add repair: full refetch without negotiation (was: "refiltering")
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a filter is changed on a partial clone repository, for example from
blob:none to blob:limit=1m, there is currently no straightforward way to
bulk-refetch the objects that match the new filter for existing local
commits. This is because the client will report commits as "have" during
fetch negotiation and any dependent objects won't be included in the
transferred pack. Another use case is discussed at [1].

This patch series introduces a --repair option to fetch & fetch-pack to
enable doing a full fetch without performing any commit negotiation with the
remote, as for a fresh clone. It builds upon cbe566a071 ("negotiator/noop:
add noop fetch negotiator", 2020-08-18). While a key use case is described
above for partial clones, a user could also use --repair to fix a corrupted
object database by performing a refetch of objects that should already be
present, establishing a better workflow than deleting the local repository
and re-cloning.

 * Using --repair will produce duplicated objects between the existing and
   newly fetched packs, but maintenance will clean them up when it runs
   automatically post-fetch (if enabled).
 * If a user fetches with --repair applying a more restrictive partial clone
   filter than previously (eg: blob:limit=1m then blob:limit=1k) the
   eventual state is a no-op, since any referenced object already in the
   local repository is never removed. More advanced repacking which could
   improve this scenario is currently proposed at [2].

[1]
https://public-inbox.org/git/aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com/
[2]
https://public-inbox.org/git/21ED346B-A906-4905-B061-EDE53691C586@gmail.com/

Changes since RFC (v1):

 * Changed the name from "refilter" to "repair"
 * Removed dependency between server-side support for filtering and repair
 * Added a test case for a shallow clone
 * Post-fetch auto maintenance now strongly encourages
   repacking/consolidation

Robert Coup (8):
  fetch-negotiator: add specific noop initializor
  fetch-pack: add repairing
  builtin/fetch-pack: add --repair option
  fetch: add --repair option
  t5615-partial-clone: add test for fetch --repair
  maintenance: add ability to pass config options
  fetch: after repair, encourage auto gc repacking
  doc/partial-clone: mention --repair fetch option

 Documentation/fetch-options.txt           | 10 +++++
 Documentation/git-fetch-pack.txt          |  4 ++
 Documentation/technical/partial-clone.txt |  3 ++
 builtin/am.c                              |  2 +-
 builtin/commit.c                          |  2 +-
 builtin/fetch-pack.c                      |  4 ++
 builtin/fetch.c                           | 38 ++++++++++++++--
 builtin/merge.c                           |  2 +-
 builtin/rebase.c                          |  2 +-
 fetch-negotiator.c                        |  5 +++
 fetch-negotiator.h                        |  8 ++++
 fetch-pack.c                              | 50 +++++++++++++--------
 fetch-pack.h                              |  1 +
 remote-curl.c                             |  6 +++
 run-command.c                             |  8 +++-
 run-command.h                             |  5 ++-
 t/t5616-partial-clone.sh                  | 54 ++++++++++++++++++++++-
 transport-helper.c                        |  3 ++
 transport.c                               |  4 ++
 transport.h                               |  4 ++
 20 files changed, 186 insertions(+), 29 deletions(-)


base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1138%2Frcoup%2Frc-partial-clone-refilter-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1138/rcoup/rc-partial-clone-refilter-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1138

Range-diff vs v1:

 1:  ca50ce77ae4 ! 1:  d146d8aaaaf fetch-negotiator: add specific noop initializor
     @@ Commit message
      
          Add a specific initializor for the noop fetch negotiator. This is
          introduced to support allowing partial clones to skip commit negotiation
     -    when refetching to apply a modified filter.
     +    when fetching to repair or apply a modified filter.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
 2:  a3c1999936d ! 2:  2d817a65db5 fetch-pack: add partial clone refiltering
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    fetch-pack: add partial clone refiltering
     +    fetch-pack: add repairing
      
     -    Allow refetching with a new partial clone filter by not attempting to
     -    find or negotiate common commits with the remote, and always forcing
     -    a full filtered fetch.
     +    Allow a 'repair fetch' where the contents of the local object store are
     +    ignored and a full fetch is performed, not attempting to find or
     +    negotiate common commits with the remote.
     +
     +    A key use case is to apply a new partial clone blob/tree filter and
     +    refetch all the associated matching content, which would otherwise not
     +    be transferred when the commit objects are already present locally.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
      -		if (((o = lookup_object(the_repository, remote)) != NULL) &&
      -				(o->flags & COMPLETE)) {
      -			continue;
     -+		if (!args->refilter) {
     ++		if (!args->repair) {
      +			/*
      +			* If that object is complete (i.e. it is an ancestor of a
      +			* local ref), we tell them we have it but do not have to
     @@ fetch-pack.c: static void mark_complete_and_common_ref(struct fetch_negotiator *
       
       	save_commit_buffer = 0;
       
     -+	if (args->refilter)
     ++	if (args->repair)
      +		return;
      +
       	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
       	for (ref = *refs; ref; ref = ref->next) {
     - 		struct object *o;
     + 		struct commit *commit;
      @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     - 	int agent_len;
       	struct fetch_negotiator negotiator_alloc;
       	struct fetch_negotiator *negotiator;
     --
     + 
      -	negotiator = &negotiator_alloc;
      -	fetch_negotiator_init(r, negotiator);
     -+	unsigned is_refiltering = 0;
     - 
     +-
       	sort_ref_list(&ref, ref_compare_name);
       	QSORT(sought, nr_sought, cmp_ref_by_name);
     -@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     - 	if (server_supports("filter")) {
     - 		server_supports_filtering = 1;
     - 		print_verbose(args, _("Server supports %s"), "filter");
     --	} else if (args->filter_options.choice) {
     -+	} else if (args->filter_options.choice || args->refilter) {
     - 		warning("filtering not recognized by server, ignoring");
     - 	}
       
     -+	if (server_supports_filtering && args->refilter) {
     -+		is_refiltering = 1;
     -+	}
     -+
     - 	if (server_supports("deepen-since")) {
     - 		print_verbose(args, _("Server supports %s"), "deepen-since");
     - 		deepen_since_ok = 1;
      @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
       	if (!server_supports_hash(the_hash_algo->name, NULL))
       		die(_("Server does not support this repository's object format"));
       
      +	negotiator = &negotiator_alloc;
     -+	if (is_refiltering) {
     ++	if (args->repair) {
      +		fetch_negotiator_init_noop(negotiator);
      +	} else {
      +		fetch_negotiator_init(r, negotiator);
     @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
       	mark_complete_and_common_ref(negotiator, args, &ref);
       	filter_refs(args, &ref, sought, nr_sought);
      -	if (everything_local(args, &ref)) {
     -+	if (!is_refiltering && everything_local(args, &ref)) {
     ++	if (!args->repair && everything_local(args, &ref)) {
       		packet_flush(fd[1]);
       		goto all_done;
       	}
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       
       	negotiator = &negotiator_alloc;
      -	fetch_negotiator_init(r, negotiator);
     -+	if (args->refilter)
     ++	if (args->repair)
      +		fetch_negotiator_init_noop(negotiator);
      +	else
      +		fetch_negotiator_init(r, negotiator);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       			mark_complete_and_common_ref(negotiator, args, &ref);
       			filter_refs(args, &ref, sought, nr_sought);
      -			if (everything_local(args, &ref))
     -+			if (!args->refilter && everything_local(args, &ref))
     ++			if (!args->repair && everything_local(args, &ref))
       				state = FETCH_DONE;
       			else
       				state = FETCH_SEND_REQUEST;
     @@ fetch-pack.h: struct fetch_pack_args {
       	unsigned update_shallow:1;
       	unsigned reject_shallow_remote:1;
       	unsigned deepen:1;
     -+	unsigned refilter:1;
     ++	unsigned repair:1;
       
       	/*
       	 * Indicate that the remote of this request is a promisor remote. The
 3:  d7f4b6c8052 ! 3:  a42d40ac294 builtin/fetch-pack: add --refilter option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    builtin/fetch-pack: add --refilter option
     +    builtin/fetch-pack: add --repair option
      
     -    Add a --refilter option to fetch-pack to force a full fetch when
     -    applying a new filter.
     +    Add a --repair option to fetch-pack to force a full fetch. Use when
     +    applying a new partial clone filter to refetch all matching objects.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ Documentation/git-fetch-pack.txt: be in a separate packet, and the list must end
       	current shallow boundary instead of from the tip of each
       	remote branch history.
       
     -+--refilter::
     -+	Skips negotiating commits with the server in order to reapply a new
     -+	partial clone filter and fetch all matching objects.
     ++--repair::
     ++	Skips negotiating commits with the server in order to fetch all matching
     ++	objects. Use to reapply a new partial clone blob/tree filter.
      +
       --no-progress::
       	Do not show the progress.
     @@ builtin/fetch-pack.c: int cmd_fetch_pack(int argc, const char **argv, const char
       			args.from_promisor = 1;
       			continue;
       		}
     -+		if (!strcmp("--refilter", arg)) {
     -+			args.refilter = 1;
     ++		if (!strcmp("--repair", arg)) {
     ++			args.repair = 1;
      +			continue;
      +		}
       		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
     @@ remote-curl.c: struct options {
       		/* see documentation of corresponding flag in fetch-pack.h */
       		from_promisor : 1,
       
     -+		refilter : 1,
     ++		repair : 1,
       		atomic : 1,
       		object_format : 1,
       		force_if_includes : 1;
     @@ remote-curl.c: static int set_option(const char *name, const char *value)
       	} else if (!strcmp(name, "from-promisor")) {
       		options.from_promisor = 1;
       		return 0;
     -+	} else if (!strcmp(name, "refilter")) {
     -+		options.refilter = 1;
     ++	} else if (!strcmp(name, "repair")) {
     ++		options.repair = 1;
      +		return 0;
       	} else if (!strcmp(name, "filter")) {
       		options.filter = xstrdup(value);
     @@ remote-curl.c: static int fetch_git(struct discovery *heads,
       		strvec_push(&args, "--deepen-relative");
       	if (options.from_promisor)
       		strvec_push(&args, "--from-promisor");
     -+	if (options.refilter)
     -+		strvec_push(&args, "--refilter");
     ++	if (options.repair)
     ++		strvec_push(&args, "--repair");
       	if (options.filter)
       		strvec_pushf(&args, "--filter=%s", options.filter);
       	strvec_push(&args, url.buf);
 4:  3e102724196 ! 4:  79c409d0542 fetch: add --refilter option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    fetch: add --refilter option
     +    fetch: add --repair option
      
     -    Teach fetch and transports the --refilter option to force a full fetch
     -    when applying a new filter.
     +    Teach fetch and transports the --repair option to force a full fetch
     +    without negotiating common commits with the remote. Use when applying a
     +    new partial clone filter to refetch all matching objects.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ Documentation/fetch-options.txt: endif::git-pull[]
       	setting. See linkgit:git-config[1].
       
      +ifndef::git-pull[]
     -+--refilter::
     -+	Reapply a partial clone filter from configuration or `--filter=`, such
     -+	as when the filter definition has changed. Instead of negotiating with
     -+	the server to avoid transferring commits and associated objects that are
     -+	already present locally, this option fetches all objects that match the
     -+	filter.
     ++--repair::
     ++	Instead of negotiating with the server to avoid transferring commits and
     ++	associated objects that are already present locally, this option fetches
     ++	all objects as a fresh clone would. Use this to reapply a partial clone
     ++	filter from configuration or using `--filter=` when the filter
     ++	definition has changed.
      +endif::git-pull[]
      +
       --refmap=<refspec>::
     @@ builtin/fetch.c: static int prune_tags = -1; /* unspecified */
       static int all, append, dry_run, force, keep, multiple, update_head_ok;
       static int write_fetch_head = 1;
      -static int verbosity, deepen_relative, set_upstream;
     -+static int verbosity, deepen_relative, set_upstream, refilter;
     ++static int verbosity, deepen_relative, set_upstream, repair;
       static int progress = -1;
       static int enable_auto_gc = 1;
       static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
     @@ builtin/fetch.c: static struct option builtin_fetch_options[] = {
       	OPT_SET_INT_F(0, "unshallow", &unshallow,
       		      N_("convert to a complete repository"),
       		      1, PARSE_OPT_NONEG),
     -+	OPT_SET_INT_F(0, "refilter", &refilter,
     -+		      N_("re-fetch with a modified filter"),
     ++	OPT_SET_INT_F(0, "repair", &repair,
     ++		      N_("re-fetch without negotiating common commits"),
      +		      1, PARSE_OPT_NONEG),
       	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
       		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
     @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *ref_map)
       		return -1;
       
      +	/*
     -+	 * Similarly, if we need to refilter a partial clone we already have
     -+	 * these commits reachable.  Running rev-list here will return with
     -+	 * a good (0) exit status and we'll bypass the fetch that we
     -+	 * really need to perform.  Claiming failure now will ensure
     -+	 * we perform the network exchange to reapply the filter.
     ++	 * Similarly, if we need to repair, we always want to perform a full
     ++	 * fetch ignoring existing objects.
      +	 */
     -+	if (refilter)
     ++	if (repair)
      +		return -1;
      +
      +
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
       		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
       	if (update_shallow)
       		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
     -+	if (refilter)
     -+		set_option(transport, TRANS_OPT_REFILTER, "yes");
     ++	if (repair)
     ++		set_option(transport, TRANS_OPT_REPAIR, "yes");
       	if (filter_options.choice) {
       		const char *spec =
       			expand_list_objects_filter_spec(&filter_options);
     @@ transport-helper.c: static int fetch_refs(struct transport *transport,
       	if (data->transport_options.update_shallow)
       		set_helper_option(transport, "update-shallow", "true");
       
     -+	if (data->transport_options.refilter)
     -+		set_helper_option(transport, "refilter", "true");
     ++	if (data->transport_options.repair)
     ++		set_helper_option(transport, "repair", "true");
      +
       	if (data->transport_options.filter_options.choice) {
       		const char *spec = expand_list_objects_filter_spec(
     @@ transport.c: static int set_git_option(struct git_transport_options *opts,
       		list_objects_filter_die_if_populated(&opts->filter_options);
       		parse_list_objects_filter(&opts->filter_options, value);
       		return 0;
     -+	} else if (!strcmp(name, TRANS_OPT_REFILTER)) {
     -+		opts->refilter = !!value;
     ++	} else if (!strcmp(name, TRANS_OPT_REPAIR)) {
     ++		opts->repair = !!value;
      +		return 0;
       	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
       		opts->reject_shallow = !!value;
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       	args.update_shallow = data->options.update_shallow;
       	args.from_promisor = data->options.from_promisor;
       	args.filter_options = data->options.filter_options;
     -+	args.refilter = data->options.refilter;
     ++	args.repair = data->options.repair;
       	args.stateless_rpc = transport->stateless_rpc;
       	args.server_options = transport->server_options;
       	args.negotiation_tips = data->options.negotiation_tips;
     @@ transport.h: struct git_transport_options {
       	unsigned update_shallow : 1;
       	unsigned reject_shallow : 1;
       	unsigned deepen_relative : 1;
     -+	unsigned refilter : 1;
     ++	unsigned repair : 1;
       
       	/* see documentation of corresponding flag in fetch-pack.h */
       	unsigned from_promisor : 1;
     @@ transport.h: void transport_check_allowed(const char *type);
       /* Filter objects for partial clone and fetch */
       #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
       
     -+/* Refilter a previous partial clone */
     -+#define TRANS_OPT_REFILTER "refilter"
     ++/* Refetch all objects without negotiating */
     ++#define TRANS_OPT_REPAIR "repair"
      +
       /* Request atomic (all-or-nothing) updates when pushing */
       #define TRANS_OPT_ATOMIC "atomic"
 5:  66c18850aad ! 5:  38af2bbee79 t5615-partial-clone: add test for --refilter
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    t5615-partial-clone: add test for --refilter
     +    t5615-partial-clone: add test for fetch --repair
      
     -    Add a test for partial clone refiltering under protocol v0 and v2.
     +    Add a test for doing a repair fetch to apply a changed partial clone
     +    filter under protocol v0 and v2.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ t/t5616-partial-clone.sh: test_expect_success 'manual prefetch of missing object
      +	git -C src push -u srv main
      +'
      +
     -+# Do partial fetch to fetch smaller files; then verify that without --refilter
     ++# Do partial fetch to fetch smaller files; then verify that without --repair
      +# applying a new filter does not refetch missing large objects. Then use
     -+# --refilter to apply the new filter on existing commits. Test it under both
     ++# --repair to apply the new filter on existing commits. Test it under both
      +# protocol v2 & v0.
     -+test_expect_success 'apply a different filter using --refilter' '
     ++test_expect_success 'apply a different filter using --repair' '
      +	git -C pc1 fetch --filter=blob:limit=999 origin &&
      +	git -C pc1 rev-list --quiet --objects --missing=print \
      +		main..origin/main >observed &&
      +	test_line_count = 4 observed &&
      +
     -+	git -C pc1 fetch --filter=blob:limit=19999 --refilter origin &&
     ++	git -C pc1 fetch --filter=blob:limit=19999 --repair origin &&
      +	git -C pc1 rev-list --quiet --objects --missing=print \
      +		main..origin/main >observed &&
      +	test_line_count = 2 observed &&
      +
      +	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
     -+		--refilter origin &&
     ++		--repair origin &&
      +	git -C pc1 rev-list --quiet --objects --missing=print \
      +		main..origin/main >observed &&
      +	test_line_count = 0 observed
      +'
     ++
     ++test_expect_success 'fetch --repair works with a shallow clone' '
     ++	git clone --no-checkout --depth=1 --filter=blob:none "file://$(pwd)/srv.bare" pc1s &&
     ++	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
     ++	test_line_count = 6 observed &&
     ++
     ++	GIT_TRACE=1 git -C pc1s fetch --filter=blob:limit=999 --repair origin &&
     ++	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
     ++	test_line_count = 6 observed
     ++'
      +
       test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
       	test_create_repo submodule &&
 -:  ----------- > 6:  cfa6dca8ef4 maintenance: add ability to pass config options
 -:  ----------- > 7:  2338c15249a fetch: after repair, encourage auto gc repacking
 6:  6c4d4260bfc ! 8:  20942562a66 doc/partial-clone: mention --refilter option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    doc/partial-clone: mention --refilter option
     +    doc/partial-clone: mention --repair fetch option
      
     -    Add the fetch --refilter option to the partial clone documentation.
     +    Document it for partial clones as a means to refetch with a new filter.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ Documentation/technical/partial-clone.txt: Fetching Missing Objects
         currently fetches all objects referred to by the requested objects, even
         though they are not necessary.
       
     -+- Fetching with `--refilter` will request a complete new filtered packfile from
     ++- Fetching with `--repair` will request a complete new filtered packfile from
      +  the remote, which can be used to change a filter without needing to
      +  dynamically fetch missing objects.
       

-- 
gitgitgadget
