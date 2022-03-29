Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72942C433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 23:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiC2XVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiC2XVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 19:21:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF093FD98
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:19:27 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q11so22873855iod.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V8l3H/QxWu3Afn6oLvYmRtXUJsxXaLepi63rHcD1H3E=;
        b=yjk5hABA2cG3suk8psw8dsnQGU0Twk0dYE5xrYUWUb70H+sQwbiSVe3d8xp/SeqooR
         KcgFRZsnUGA0CPbhzNi5ElcwQvjjLxPPNPAvVQ9n5AJJYIHxc/UKTjAFI0mLEG2fNcKZ
         Ox1Za3UCM163d5DELE915/PfJFQR27yfJYQ9jMVok9UTz1yvmhbmidGrxD2k+zsn43l0
         Npp+PHkGDVn98Pa3Bl+4Bo/DtzF1FL5c/jp69uFmD5Ng16TAbE0ZoGnry4wH3UNh9Kn5
         9/+Dc8yPjH0Prz1ACoSUPOxRsoYs0jEUUCxdgaJo8rMSW2eYGJj+8vSrTs4qS/hVqLjE
         7yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V8l3H/QxWu3Afn6oLvYmRtXUJsxXaLepi63rHcD1H3E=;
        b=UX9T1odSUTVTQ/JVGiQ9T0w3x3Ut7msDW4TG3zBC/BHzGiM4s2U70hzXBzRRWr2OWO
         Z9cZ+dzNBOyJcNBBdnh6Y/Gvu5oPsKTeHa6FcROph2ZjsHWoSqCx8s0+OD5Vh+KRPxT+
         wrCin1JQVf95aprIbD+HbbSAXxPTB0HgLPxxMLk+PVyG7C9K4NVJGC2fH9BLiPARlttW
         +mlFIgpUCzXemfIam3lzqW1SdDOzlfETF1XPF999iF7d8B02gCfvUNoVRzXItgBNw50J
         /sNYhTmpkM8//quMScYKqgJ5fCjsR1Lm/PzKm8dBn4XyF+zfEqg7vIvmLErxFOTdbqaa
         jN+A==
X-Gm-Message-State: AOAM533Hi/MKWt93nD4CjKW1QVSNh/Z3aRb9K7+HfHTBLSWKJGha+uWK
        5g6OmFCtGMR4pFg5t3kBnJIDdg==
X-Google-Smtp-Source: ABdhPJyLQnPv8KQWWhB7IoV+qg04Lugc0hDW55w+8LOf7PfqEtFkQGCja/ff2n/UVJbFc3j3w7VzBQ==
X-Received: by 2002:a05:6638:3881:b0:321:4499:27c9 with SMTP id b1-20020a056638388100b00321449927c9mr17271637jav.53.1648595966890;
        Tue, 29 Mar 2022 16:19:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s185-20020a6b2cc2000000b00648d69f367asm10109532ios.16.2022.03.29.16.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:19:26 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:19:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
Message-ID: <YkOT/TCKPK3LT9gh@nand.local>
References: <20220208235631.732466-1-calvinwan@google.com>
 <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-4-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220328191112.3092139-4-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin,

Junio took a deeper look below, but here are a few small code-hygiene
issues that I noticed while taking a quicker look through this patch.

On Mon, Mar 28, 2022 at 07:11:12PM +0000, Calvin Wan wrote:
> Sometimes it is useful to get information about an object without
> having to download it completely. The server logic has already been
> implemented as “a2ba162cda (object-info: support for retrieving object
> info, 2021-04-20)”. This patch implements the client option for
> it. Currently, only 'size' is supported, however future patches can
> implement additional options.
>
> Add ‘--object-info’ option to fetch. This option allows the client to

The single-quotes here look like smart quotes. I don't think we forbid
these explicitly within commit messages, but using the standard '
(ASCII 0x27) character is more common.

> make an object-info command request to a server that supports protocol
> v2. If the server is v2, but does not allow for the object-info
> command request, fetch the objects as if it were a standard fetch
> (however without changing any refs). Therefore, hook `fetch
> object-info` into transport_fetch_refs() to easily fallback if needed.
>
> A previous patch added the `transfer.advertiseObjectInfo` config
> option, of which this patch utilizes to test the fallback.
>
> ---
>  Documentation/fetch-options.txt |   5 ++
>  Documentation/git-fetch.txt     |   1 +
>  builtin/fetch.c                 |  36 ++++++++-
>  fetch-pack.c                    |  42 +++++++++-
>  fetch-pack.h                    |   9 +++
>  t/t5583-fetch-object-info.sh    | 138 ++++++++++++++++++++++++++++++++
>  transport-helper.c              |   8 +-
>  transport-internal.h            |   1 +
>  transport.c                     |  75 ++++++++++++++++-
>  transport.h                     |   9 +++
>  10 files changed, 315 insertions(+), 9 deletions(-)
>  create mode 100755 t/t5583-fetch-object-info.sh
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index f903683189..f1ca95c32d 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -299,3 +299,8 @@ endif::git-pull[]
>  -6::
>  --ipv6::
>  	Use IPv6 addresses only, ignoring IPv4 addresses.
> +
> +--object-info=[<arguments>]::
> +	Fetches only the relevant information passed in arguments from a
> +	specific remote and set of object ids. Object 'size' is currently
> +	the only supported argument.
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 550c16ca61..a13d2ba7ad 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  'git fetch' [<options>] <group>
>  'git fetch' --multiple [<options>] [(<repository> | <group>)...]
>  'git fetch' --all [<options>]
> +'git fetch' --object-info=[<arguments>] <remote> [<object-ids>]
>
>
>  DESCRIPTION
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4d12c2fd4d..0b21bebfca 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -29,6 +29,9 @@
>  #include "commit-graph.h"
>  #include "shallow.h"
>  #include "worktree.h"
> +#include "protocol.h"
> +#include "pkt-line.h"
> +#include "connect.h"
>
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>
> @@ -37,6 +40,7 @@ static const char * const builtin_fetch_usage[] = {
>  	N_("git fetch [<options>] <group>"),
>  	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
>  	N_("git fetch --all [<options>]"),
> +	N_("git fetch --object-info=[<arguments>] <remote> [<object-ids>]"),
>  	NULL
>  };
>
> @@ -86,6 +90,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
>  static int fetch_write_commit_graph = -1;
>  static int stdin_refspecs = 0;
>  static int negotiate_only;
> +static struct string_list object_info_options = STRING_LIST_INIT_NODUP;
>
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -221,6 +226,8 @@ static struct option builtin_fetch_options[] = {
>  		 N_("write the commit-graph after fetching")),
>  	OPT_BOOL(0, "stdin", &stdin_refspecs,
>  		 N_("accept refspecs from stdin")),
> +	OPT_STRING_LIST(0, "object-info", &object_info_options, N_("option"),
> +		 N_("command request arguments")),
>  	OPT_END()
>  };
>
> @@ -2087,6 +2094,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	struct remote *remote = NULL;
>  	int result = 0;
>  	int prune_tags_ok = 1;
> +	struct oid_array object_info_oids = OID_ARRAY_INIT;
>
>  	packet_trace_identity("fetch");
>
> @@ -2168,7 +2176,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (dry_run)
>  		write_fetch_head = 0;
>
> -	if (all) {
> +	if (object_info_options.nr > 0) {

Small nit; since object_info_options.nr should never be negative, we
should instead write "if (object_info_options)".

> +		if (argc == 0 || argc == 1) {
> +			die(_("must supply remote and object ids when using --object-info"));
> +		} else {
> +			struct object_id oid;
> +			remote = remote_get(argv[0]);
> +			for (i = 1; i < argc; i++) {
> +				if (get_oid(argv[i], &oid))
> +					return error(_("malformed object id '%s'"), argv[i]);
> +				oid_array_append(&object_info_oids, &oid);
> +			}
> +		}
> +	} else if (all) {
>  		if (argc == 1)
>  			die(_("fetch --all does not take a repository argument"));
>  		else if (argc > 1)
> @@ -2199,7 +2219,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>
> -	if (negotiate_only) {
> +	if (object_info_options.nr > 0) {
> +		if (!remote)
> +			die(_("must supply remote when using --object-info"));
> +		gtransport = prepare_transport(remote, 1);
> +		if (gtransport->smart_options) {
> +			gtransport->smart_options->object_info = 1;
> +			gtransport->smart_options->object_info_oids = &object_info_oids;
> +			gtransport->smart_options->object_info_options = &object_info_options;
> +		}
> +		if (server_options.nr)
> +			gtransport->server_options = &server_options;
> +		result = transport_fetch_refs(gtransport, NULL);
> +	} else if (negotiate_only) {
>  		struct oidset acked_commits = OIDSET_INIT;
>  		struct oidset_iter iter;
>  		const struct object_id *oid;
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b709a61baf..36e3d1c5d0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1269,6 +1269,27 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
>  	packet_buf_delim(req_buf);
>  }
>
> +void send_object_info_request(int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf = STRBUF_INIT;
> +	int i;

I don't think this would ever be practically exploit-able, since we'd
run past the argument limit long before we hit INT_MAX, but this should
be a size_t instead of an int to match the type of args->oid->nr.

> +
> +	write_command_and_capabilities(&req_buf, args->server_options, "object-info");
> +
> +	if (string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");
> +
> +	for (i = 0; i < args->oids->nr; i++) {
> +		packet_buf_write(&req_buf, "oid %s\n", oid_to_hex(&args->oids->oid[i]));
> +	}

Small nit, the braces around this for-loop are not required.

>  static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  			      struct fetch_pack_args *args,
>  			      const struct ref *wants, struct oidset *common,
> @@ -1604,6 +1625,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen = 1;
>
> +	if (args->object_info) {
> +		state = FETCH_SEND_REQUEST;
> +	}
> +

Ditto here.

>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
> @@ -1613,7 +1638,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);
> -			if (everything_local(args, &ref))
> +			if (!args->object_info && everything_local(args, &ref))
>  				state = FETCH_DONE;
>  			else
>  				state = FETCH_SEND_REQUEST;
> @@ -1999,8 +2024,19 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  		}
>  		args->connectivity_checked = 1;
>  	}
> -
> -	update_shallow(args, sought, nr_sought, &si);
> +
> +	if (args->object_info) {
> +		struct ref *ref_cpy_reader = ref_cpy;
> +		unsigned long size = 0;
> +		while (ref_cpy_reader) {
> +			oid_object_info(the_repository, &(ref_cpy_reader->old_oid), &size);
> +			printf("%s %li\n", oid_to_hex(&(ref_cpy_reader->old_oid)), size);

Both expressions like "&(x)" can be written instead as "&x" without the
outer parenthesis.

Likewise, we do not use %li, that line should instead read:

    printf("%s %"PRIuMAX"\n", oid_to_hex(&ref_cpy_reader->old_oid), (uintmax_t)size);

Thanks,
Taylor
