Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA49C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0649620706
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 12:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391951AbgLNMjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391213AbgLNMjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 07:39:43 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72477C0613CF
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 04:39:02 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id q22so4471396eja.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 04:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=PM0YzsGEvFEK8qT6kcjNDPf9rror7NbT6uQoezwj1fI=;
        b=ZoIGgZ2mBCA77ALz1yPxfteZCYCkXH9jSEZjnc6sG6zIBy10HJTJQTVaRLHm8mj9W1
         jC0rR4WpU/ez5PmawG8I1kl5cvTkBr7skgOZ/VjQJdHv/eY1IL9QMF2NTZZLZLPdx/xE
         oIJXYQh3VZJgPMsGKCSqWMnyhmQIiq3xTe9yo/ZDT44YcQQYgWUV45f1bnSFMOaktk5b
         OrfxiF6TTN0czr9u8Nl6cNBg5vw7tf+nyw/Q/jFXktY8KOxFApkwe5VS68E/bVTquF2U
         olZSuPgZAhA98j+JkVCXtg5LxZBhSajwz0KGH+Jdf/8revEI0yPQeLwyfTNE239ChGAN
         qf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=PM0YzsGEvFEK8qT6kcjNDPf9rror7NbT6uQoezwj1fI=;
        b=h0I1xO1jKICOL0moedx5hlbeMH8b33STV8RhYmrV/8gHJArykjKuyfBIz3Xc6rLhUo
         W7qErL2HAUOoQ2lDgQ0XfS/HoQ8nVo/4tE8n0QCF84Fs6970i2xqa1xQDRNmwy+rxl6M
         rht8nmYY+HK6Jqar5x148ab3aYj2go7JMxVUN+vuHFjGyJxfY+s1nmGdV3YVaUmxtnyt
         dcku1EuS6OAtkkDjoGYtqPqPy273xHD3Xh9c+giPyVjVuvYOREEBmWV6GWxdb13gE96w
         24JJsn9j8M3ymCr7uESvYKdCqarQ6X8DHLvpfkgrMmYl6zul1DeOaiBAgbmbZ9Vqeky4
         BZvQ==
X-Gm-Message-State: AOAM531i0Mmd4e5P/WERImQPtFhjRH78XOHPeQK5Mr++Y2SuOp5FnLOC
        uaUUi8nA33CJ3CNfkhQl0Ss=
X-Google-Smtp-Source: ABdhPJyZXDAlecJHd73AgWVnc/HkEt7WHDe25oaUs2g3F9EQhC9srUmy0idoLkxneUf3awuXKM6aWQ==
X-Received: by 2002:a17:906:fa88:: with SMTP id lt8mr22394853ejb.408.1607949540896;
        Mon, 14 Dec 2020 04:39:00 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id cf17sm15194554edb.16.2020.12.14.04.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 04:38:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20201211210508.2337494-1-jonathantanmy@google.com>
Date:   Mon, 14 Dec 2020 13:38:58 +0100
Message-ID: <87blewwoil.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 11 2020, Jonathan Tan wrote:

> When cloning an empty repository, a default branch is created. However,
> it is named after the locally configured init.defaultBranch, not the
> default branch of the remote repository.
>
> To solve this, the remote needs to communicate the target of the HEAD
> symref, and "git clone" needs to use this information.
>
> Currently, symrefs that have unborn targets (such as in this case) are
> not communicated by the protocol. Teach Git to advertise and support the
> "unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
> This feature indicates that "ls-refs" supports the "unborn" argument;
> when it is specified, "ls-refs" will send the HEAD symref with the name
> of its unborn target.
>
> On the client side, Git will always send the "unborn" argument if it is
> supported by the server. During "git clone", if cloning an empty
> repository, Git will use the new information to determine the local
> branch to create. In all other cases, Git will ignore it.

I'm not a fan of this change not because of the whole s/master/whatever/
discussion, but because of the magic it adds for seemingly little gain &
without any documentation.

So if I have init.defaultBranch explicitly set that'll be ignored on
"clone", but on "init/git remote add/fetch" it won't?

I think so, and I swear I knew yesterday when I read this patch, but now
I can't remember. Anyway, the point that I avoided re-reading the patch
to find out, because even if there's an on-list answer to that it should
really be documented because I'll forget it next week, and our users
will never know :)

This patch also leaves Documentation/config/init.txt untouched, and now
under lsrefs.unborn it explicitly contradicts the behavior of git:

    Allows overriding the default branch name e.g. when initializing
    a new repository or when cloning an empty repository.

Shouldn't this at the very least be a
init.defaultBranchFromRemote=<bool> which if set overrides
init.defaultBranch? We could turn that to "true" by default and get the
same behavior as you have here, but with less inexplicable magic for the
user, no?

It seems if you're a user and wonder why a clone of a bare repo doesn't
give you "init" defaults the only way you'll find out is
GIT_TRACE_PACKET and the like.

Another reason I'm not a fan of it is because it's another piece of
magic "clone" does that you can't emulate in "init/fetch". We have
e.g. --single-branch as an existing case of that (although you can at
least do that with parse ls-remote -> init -> config -> fetch), and
that's a case that doesn't fit into a refspec.

But shouldn't there at least be a corresponding "fetch" option? On init
we'll create head, but "git fetch --clobber-my-idea-of-HEAD-with-remote
..."?

Maybe not for reasons I haven't thought of, but I'd at least be much
happier with an updated commit message justifying another special-case
in clone that you can't do with "init/fetch".

And on the "litte gain" side of things: I very much suspect that the
only users who'll ever use this will be some big hosting providers (but
maybe not, the commit doesn't suggest a use-case). Wouldn't this be even
more useful in those cases by just a pre-receive hook on their side
detecting an initial push refusing "master", and:

    git push -o yes-use-old-init-default <...>

Instead of a patch to git to do the same & which would take $SOMEYEARS
to be rolled out, since it depends on client-side understanding.

Comment on the patch below (okey I did read some of it:):

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index e597b74da3..dfe03aa114 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
>  	When specified, only references having a prefix matching one of
>  	the provided prefixes are displayed.
>  
> +If the 'unborn' feature is advertised the following argument can be
> +included in the client's request.
> +
> +    unborn
> +	The server may send symrefs pointing to unborn branches in the form
> +	"unborn <refname> symref-target:<target>".
> +
>  The output of ls-refs is as follows:
>  
>      output = *ref
>  	     flush-pkt
> -    ref = PKT-LINE(obj-id SP refname *(SP ref-attribute) LF)
> +    obj-id-or-unborn = (obj-id | "unborn")
> +    ref = PKT-LINE(obj-id-or-unborn SP refname *(SP ref-attribute) LF)
>      ref-attribute = (symref | peeled)
>      symref = "symref-target:" symref-target
>      peeled = "peeled:" obj-id
> diff --git a/builtin/clone.c b/builtin/clone.c
> index a0841923cf..217c87fddf 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -980,6 +980,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	int submodule_progress;
>  
>  	struct strvec ref_prefixes = STRVEC_INIT;
> +	char *unborn_head_target = NULL;
>  
>  	packet_trace_identity("clone");
>  
> @@ -1264,7 +1265,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (!option_no_tags)
>  		strvec_push(&ref_prefixes, "refs/tags/");
>  
> -	refs = transport_get_remote_refs(transport, &ref_prefixes);
> +	refs = transport_get_remote_refs(transport, &ref_prefixes,
> +					 &unborn_head_target);
>  
>  	if (refs) {
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
> @@ -1323,10 +1325,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		remote_head = NULL;
>  		option_no_checkout = 1;
>  		if (!option_bare) {
> -			const char *branch = git_default_branch_name();
> -			char *ref = xstrfmt("refs/heads/%s", branch);
> +			const char *branch;
> +			char *ref;
> +
> +			if (unborn_head_target &&
> +			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
> +				ref = unborn_head_target;
> +				unborn_head_target = NULL;
> +			} else {
> +				branch = git_default_branch_name();
> +				ref = xstrfmt("refs/heads/%s", branch);
> +			}
>  
>  			install_branch_config(0, branch, remote_name, ref);
> +			create_symref("HEAD", ref, "");
>  			free(ref);
>  		}
>  	}
> @@ -1373,6 +1385,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&key);
>  	junk_mode = JUNK_LEAVE_ALL;
>  
> +	free(unborn_head_target);
>  	strvec_clear(&ref_prefixes);
>  	return err;
>  }
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 58b7c1fbdc..9f921dfab4 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -220,7 +220,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	version = discover_version(&reader);
>  	switch (version) {
>  	case protocol_v2:
> -		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
> +		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
> +				args.stateless_rpc, NULL);
>  		break;
>  	case protocol_v1:
>  	case protocol_v0:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ecf8537605..a7ef59acfc 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1393,7 +1393,7 @@ static int do_fetch(struct transport *transport,
>  
>  	if (must_list_refs) {
>  		trace2_region_enter("fetch", "remote_refs", the_repository);
> -		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
> +		remote_refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
>  		trace2_region_leave("fetch", "remote_refs", the_repository);
>  	} else
>  		remote_refs = NULL;
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 092917eca2..4cf3f60b1b 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -118,7 +118,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	if (server_options.nr)
>  		transport->server_options = &server_options;
>  
> -	ref = transport_get_remote_refs(transport, &ref_prefixes);
> +	ref = transport_get_remote_refs(transport, &ref_prefixes, NULL);
>  	if (ref) {
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
>  		repo_set_hash_algo(the_repository, hash_algo);
> diff --git a/builtin/remote.c b/builtin/remote.c
> index c1b211b272..246e62f118 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -950,7 +950,7 @@ static int get_remote_ref_states(const char *name,
>  	if (query) {
>  		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
>  			states->remote->url[0] : NULL);
> -		remote_refs = transport_get_remote_refs(transport, NULL);
> +		remote_refs = transport_get_remote_refs(transport, NULL, NULL);
>  		transport_disconnect(transport);
>  
>  		states->queried = 1;
> diff --git a/connect.c b/connect.c
> index 8b8f56cf6d..3c35324b4c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -376,7 +376,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
>  }
>  
>  /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
> -static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
> +static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
> +			  char **unborn_head_target)
>  {
>  	int ret = 1;
>  	int i = 0;
> @@ -397,6 +398,25 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
>  		goto out;
>  	}
>  
> +	if (!strcmp("unborn", line_sections.items[i].string)) {
> +		i++;
> +		if (unborn_head_target &&
> +		    !strcmp("HEAD", line_sections.items[i++].string)) {
> +			/*
> +			 * Look for the symref target (if any). If found,
> +			 * return it to the caller.
> +			 */
> +			for (; i < line_sections.nr; i++) {
> +				const char *arg = line_sections.items[i].string;
> +
> +				if (skip_prefix(arg, "symref-target:", &arg)) {
> +					*unborn_head_target = xstrdup(arg);
> +					break;
> +				}
> +			}
> +		}
> +		goto out;
> +	}
>  	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
>  	    *end) {
>  		ret = 0;
> @@ -455,7 +475,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  			     struct ref **list, int for_push,
>  			     const struct strvec *ref_prefixes,
>  			     const struct string_list *server_options,
> -			     int stateless_rpc)
> +			     int stateless_rpc,
> +			     char **unborn_head_target)
>  {
>  	int i;
>  	const char *hash_name;
> @@ -488,6 +509,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  	if (!for_push)
>  		packet_write_fmt(fd_out, "peel\n");
>  	packet_write_fmt(fd_out, "symrefs\n");
> +	if (server_supports_feature("ls-refs", "unborn", 0))
> +		packet_write_fmt(fd_out, "unborn\n");
>  	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
>  		packet_write_fmt(fd_out, "ref-prefix %s\n",
>  				 ref_prefixes->v[i]);
> @@ -496,7 +519,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  
>  	/* Process response from server */
>  	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> -		if (!process_ref_v2(reader, &list))
> +		if (!process_ref_v2(reader, &list, unborn_head_target))
>  			die(_("invalid ls-refs response: %s"), reader->line);
>  	}
>  
> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..fdb644b482 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -32,6 +32,8 @@ struct ls_refs_data {
>  	unsigned peel;
>  	unsigned symrefs;
>  	struct strvec prefixes;
> +	unsigned allow_unborn : 1;
> +	unsigned unborn : 1;
>  };
>  
>  static int send_ref(const char *refname, const struct object_id *oid,
> @@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	if (!ref_match(&data->prefixes, refname_nons))
>  		return 0;
>  
> -	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +	if (oid)
> +		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +	else
> +		strbuf_addf(&refline, "unborn %s", refname_nons);
>  	if (data->symrefs && flag & REF_ISSYMREF) {
>  		struct object_id unused;
>  		const char *symref_target = resolve_ref_unsafe(refname, 0,
> @@ -74,8 +79,28 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	return 0;
>  }
>  
> -static int ls_refs_config(const char *var, const char *value, void *data)
> +static void send_possibly_unborn_head(struct ls_refs_data *data)
>  {
> +	struct strbuf namespaced = STRBUF_INIT;
> +	struct object_id oid;
> +	int flag;
> +	int null_oid;
> +
> +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
> +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
> +	null_oid = is_null_oid(&oid);
> +	if (!null_oid || (data->symrefs && (flag & REF_ISSYMREF)))
> +		send_ref(namespaced.buf, null_oid ? NULL : &oid, flag, data);
> +	strbuf_release(&namespaced);
> +}
> +
> +static int ls_refs_config(const char *var, const char *value, void *cb_data)
> +{
> +	struct ls_refs_data *data = cb_data;
> +
> +	if (!strcmp("lsrefs.unborn", var))
> +		data->allow_unborn = !strcmp(value, "allow") ||
> +			!strcmp(value, "advertise");
>  	/*
>  	 * We only serve fetches over v2 for now, so respect only "uploadpack"
>  	 * config. This may need to eventually be expanded to "receive", but we
> @@ -91,7 +116,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  
>  	memset(&data, 0, sizeof(data));
>  
> -	git_config(ls_refs_config, NULL);
> +	git_config(ls_refs_config, &data);
>  
>  	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
>  		const char *arg = request->line;
> @@ -103,14 +128,35 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  			data.symrefs = 1;
>  		else if (skip_prefix(arg, "ref-prefix ", &out))
>  			strvec_push(&data.prefixes, out);
> +		else if (data.allow_unborn && !strcmp("unborn", arg))
> +			data.unborn = 1;
>  	}
>  
>  	if (request->status != PACKET_READ_FLUSH)
>  		die(_("expected flush after ls-refs arguments"));
>  
> -	head_ref_namespaced(send_ref, &data);
> +	if (data.unborn)
> +		send_possibly_unborn_head(&data);
> +	else
> +		head_ref_namespaced(send_ref, &data);
>  	for_each_namespaced_ref(send_ref, &data);
>  	packet_flush(1);
>  	strvec_clear(&data.prefixes);
>  	return 0;
>  }
> +
> +int ls_refs_advertise(struct repository *r, struct strbuf *value)
> +{
> +	if (value) {
> +		char *str = NULL;
> +
> +		if (!repo_config_get_string(the_repository, "lsrefs.unborn",
> +					    &str) &&
> +		    !strcmp("advertise", str)) {
> +			strbuf_addstr(value, "unborn");
> +			free(str);
> +		}
> +	}
> +
> +	return 1;
> +}
> diff --git a/ls-refs.h b/ls-refs.h
> index 7b33a7c6b8..a99e4be0bd 100644
> --- a/ls-refs.h
> +++ b/ls-refs.h
> @@ -6,5 +6,6 @@ struct strvec;
>  struct packet_reader;
>  int ls_refs(struct repository *r, struct strvec *keys,
>  	    struct packet_reader *request);
> +int ls_refs_advertise(struct repository *r, struct strbuf *value);
>  
>  #endif /* LS_REFS_H */
> diff --git a/remote.h b/remote.h
> index 3211abdf05..967f2178d8 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -198,7 +198,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  			     struct ref **list, int for_push,
>  			     const struct strvec *ref_prefixes,
>  			     const struct string_list *server_options,
> -			     int stateless_rpc);
> +			     int stateless_rpc,
> +			     char **unborn_head_target);
>  
>  int resolve_remote_symref(struct ref *ref, struct ref *list);
>  
> diff --git a/serve.c b/serve.c
> index f6341206c4..30cb56d507 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -62,7 +62,7 @@ struct protocol_capability {
>  
>  static struct protocol_capability capabilities[] = {
>  	{ "agent", agent_advertise, NULL },
> -	{ "ls-refs", always_advertise, ls_refs },
> +	{ "ls-refs", ls_refs_advertise, ls_refs },
>  	{ "fetch", upload_pack_advertise, upload_pack_v2 },
>  	{ "server-option", always_advertise, NULL },
>  	{ "object-format", object_format_advertise, NULL },

All of this looks good to me, and re unrelated recent questions about
packfile-uri I had it's really nice to have a narrow example of adding a
simple ls-refs time verb / functionality like this to the protocol.

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 7f082fb23b..d3bd79987b 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -102,11 +102,12 @@ test_expect_success 'redirected clone -v does show progress' '
>  '
>  
>  test_expect_success 'chooses correct default initial branch name' '
> -	git init --bare empty &&
> +	git -c init.defaultBranch=foo init --bare empty &&
> +	test_config -C empty lsrefs.unborn advertise &&

Isn't this reducing test coverage? You're changing an existing
argument-less "init --bare" test's behavior,

>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>  	git -c init.defaultBranch=up clone empty whats-up &&
> -	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
> -	test refs/heads/up = $(git -C whats-up config branch.up.merge)
> +	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
> +	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
>  '

Also re the above point about discoverability: Right below this we test
"init --initial-branch=guess". Wouldn't a way to unify bring
fetch/init/clone functionality be to use that as a jump-off point,
i.e. clone having --use-remote-initial-branch, init optionally leaving
behind a (broken) empty/nonexisting HEAD, and "fetch" with an argument
also supporting --use-remote-initial-branch or something.

> +test_expect_success 'clone of empty repo propagates name of default branch' '
> +	git -c init.defaultbranch=mydefaultbranch init file_empty_parent &&
> +	test_config -C file_empty_parent lsrefs.unborn advertise &&
> +
> +	git -c init.defaultbranch=main -c protocol.version=2 \
> +		clone "file://$(pwd)/file_empty_parent" file_empty_child &&

Nit. Let's spell config.likeThis not config.likethis when not in the C
code.
