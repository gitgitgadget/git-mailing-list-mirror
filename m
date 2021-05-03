Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E7C43461
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989526135F
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhECP0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhECP0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:26:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4379C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:26:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o5so5420853qkb.0
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1rfgmpjgXXuTIozIh9pWLVZFPHTMni53oosl8NYYPys=;
        b=LS0x4jxjcyKmWf7i0Lao3dZloqsUScXEheAw5DSAT+Xk2Jf/ONuhDaV91j9C4s5m6V
         GjLeG+FmzFUMpWL2/1ifvZG60GZUyaa9vEyJ6vwVS90SUinI1RSJXD01kpWHt05XIuQA
         QNLu47DHU9xwMtOqgz+b1zpMIgNj1ghOtqKFhZNF+ppeUz1eI+WVKQgyUVZwyuVA2aSp
         XcPZo+UhSq8GsJuGW/5wwoTgvWke5xpYKI090wf8P/KVCoZNmACWys54dL/2ikZFltlp
         jZpKm3nhUuMBI4D3CpIUPBgo27T42OQ/N+vnhQgfOOoGnYp7hGahll0xw7qRao3ilKZx
         XK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1rfgmpjgXXuTIozIh9pWLVZFPHTMni53oosl8NYYPys=;
        b=ujgHO6aUaY/h6iuL5lgZy+qBDPCxot0S3W8naKpfP+M1Vn1P9ROZmf1zAAnCIuF6br
         FxvP53HiUEMcIrYCy5dqv2mzZFtxaWk1oYJNRqgDqdboqArleMlrvJQuMysCsrFx8k1k
         Xc0QcImPbVI1VgWzZuJKEP3d0Y6oJZWkTVl4zMLiO5DZdstTjJ+u2kdEvsk4BBjMK6mI
         WdjratLljyS2MIZDfNDVYJYaumhcOmxWU1bnOAqmJczqPQCxqgHDkwHREGXOJ+k0Vtg5
         rUg4pqRPD/nbjvHbu6LievfzyJw8RTGq+MnC5RznnkIqdKhlMzPCYShHTaC2l3r+aTc2
         JM1A==
X-Gm-Message-State: AOAM532JOSz36W9Z7rmmtvOcRu/v+30JQ/XVIUCdeuDHQrqdEr4gsq0C
        enUY8oF4i/wT16b3F0a2GWGTp75TpBmmjQ==
X-Google-Smtp-Source: ABdhPJxIdw/l9yH7rI68g5613E7H1OdpMn+1Pa6Tu84BTK3YzzLTaA2gDwWGiw7NmT8Skh3YcBXohQ==
X-Received: by 2002:a37:a2c2:: with SMTP id l185mr19357732qke.290.1620055558066;
        Mon, 03 May 2021 08:25:58 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c14sm103572qtc.5.2021.05.03.08.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:25:57 -0700 (PDT)
Subject: Re: [PATCH 5/6] fetch: teach independent negotiation (no packfile)
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1617929278.git.jonathantanmy@google.com>
 <4696c8e901808853d17af10d5a6d95cd4711c6d5.1617929278.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb441f5b-33db-90a7-1492-e86c4ec1ed1a@gmail.com>
Date:   Mon, 3 May 2021 11:25:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4696c8e901808853d17af10d5a6d95cd4711c6d5.1617929278.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/21 9:10 PM, Jonathan Tan wrote:
> Currently, the packfile negotiation step within a Git fetch cannot be
> done independent of sending the packfile, even though there is at least
> one application wherein this is useful. Therefore, make it possible for
> this negotiation step to be done independently. A subsequent commit will
> use this for one such application - push negotiation.
...
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -346,6 +346,14 @@ explained below.
>  	client should download from all given URIs. Currently, the
>  	protocols supported are "http" and "https".
>  
> +If the 'wait-for-done' feature is advertised, the following argument
> +can be included in the client's request.
> +
> +    wait-for-done
> +	Indicates to the server that it should never send "ready", but
> +	should wait for the client to say "done" before sending the
> +	packfile.
> +

Ok, this is a good way to handle the compatibility case. I'll check
in the next patch how this feature is checked before sending a pack-file
in 'git push'.

> @@ -202,6 +203,8 @@ static struct option builtin_fetch_options[] = {
>  			TRANSPORT_FAMILY_IPV6),
>  	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>  			N_("report that we have only objects reachable from this object")),
> +	OPT_BOOL(0, "negotiate-only", &negotiate_only,
> +		 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),

It seems a little strange for this step, which is mostly used for tests,
to be so visible. I think it would be too much work to create a test
helper with an equivalent implementation, so maybe describe this option
as only for tests in Documentation/git-fetch.txt.
  
> -	if (remote) {
> +	if (negotiate_only) {
> +		struct oidset acked_commits = OIDSET_INIT;
> +		struct oidset_iter iter;
> +		const struct object_id *oid;
> +
> +		if (!remote)
> +			die(_("Must supply remote when using --negotiate-only"));

Please use lowercase letters to start your error messages.

> +		gtransport = prepare_transport(remote, 1);
> +		if (gtransport->smart_options) {
> +			gtransport->smart_options->acked_commits = &acked_commits;
> +		} else {
> +			warning(_("Protocol does not support --negotiate-only, exiting."));
> +			return 1;
> +		}
> +		if (server_options.nr)
> +			gtransport->server_options = &server_options;
> +		result = transport_fetch_refs(gtransport, NULL);
> +
> +		oidset_iter_init(&acked_commits, &iter);
> +		while ((oid = oidset_iter_next(&iter)))
> +			printf("%s\n", oid_to_hex(oid));
> +		oidset_clear(&acked_commits);
> +	} else if (remote) {

...

> +static int add_to_object_array(const struct object_id *oid, void *data)
> +{
> +	struct object_array *a = data;
> +
> +	add_object_array(parse_object(the_repository, oid), "", a);
> +	return 0;
> +}

Why parse_object() over lookup_object()?

> +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +			   const struct string_list *server_options,
> +			   int stateless_rpc,
> +			   int fd[],
> +			   struct oidset *acked_commits)

It might be worth a careful doc comment to say that we _must_
have already verified the wait-for-done capability.

> +{
> +	struct fetch_negotiator negotiator;
> +	struct packet_reader reader;
> +	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
> +	struct strbuf req_buf = STRBUF_INIT;
> +	int haves_to_send = INITIAL_FLUSH;
> +	int in_vain = 0;
> +	int seen_ack = 0;
> +	int last_iteration = 0;

As will become clear later, create:

	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;

> +
> +	fetch_negotiator_init(the_repository, &negotiator);
> +	mark_tips(&negotiator, negotiation_tips);
> +
> +	packet_reader_init(&reader, fd[0], NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_DIE_ON_ERR_PACKET);
> +
> +	oid_array_for_each((struct oid_array *) negotiation_tips,
> +			   add_to_object_array,
> +			   &nt_object_array);
> +
> +	while (!last_iteration) {
> +		int haves_added;
> +		struct object_id common_oid;
> +		int received_ready = 0;
> +
> +		strbuf_reset(&req_buf);
> +		write_fetch_command_and_capabilities(&req_buf, server_options);
> +
> +		packet_buf_write(&req_buf, "wait-for-done");
> +
> +		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
> +		in_vain += haves_added;
> +		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
> +			last_iteration = 1;
> +
> +		/* Send request */
> +		packet_buf_flush(&req_buf);
> +		if (write_in_full(fd[1], req_buf.buf, req_buf.len) < 0)
> +			die_errno(_("unable to write request to remote"));
> +
> +		/* Process ACKs/NAKs */
> +		process_section_header(&reader, "acknowledgments", 0);
> +		while (process_ack(&negotiator, &reader, &common_oid,
> +				   &received_ready)) {
> +			struct commit *commit = lookup_commit(the_repository,
> +							      &common_oid);
> +			if (commit)
> +				commit->object.flags |= COMMON;

Making note of this portion of the code: you can update a min_generation
value here, decreasing it if we see a smaller generation.

> +			in_vain = 0;
> +			seen_ack = 1;
> +			oidset_insert(acked_commits, &common_oid);
> +		}
> +		if (received_ready)
> +			die(_("unexpected 'ready' from remote"));
> +		else
> +			do_check_stateless_delimiter(stateless_rpc, &reader);
> +		if (can_all_from_reach_with_flag(&nt_object_array, COMMON,
> +						 REACH_SCRATCH, 0,
> +						 GENERATION_NUMBER_ZERO))

And finally here you can use min_generation. Otherwise, you will suffer
performance problems when there is a deep history but this returns false.

As long as min_generation is the minimum generation of a commit with the
COMMON flag, you will be correct to use that limit.

> +			last_iteration = 1;
> +	}
> +	strbuf_release(&req_buf);

Don't forget to clear the COMMON flag before returning.

> +}
> +

> +/*
> + * Execute the --negotiate-only mode of "git fetch", adding all known common
> + * commits to acked_commits.
> + */> +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +			   const struct string_list *server_options,
> +			   int stateless_rpc,
> +			   int fd[],
> +			   struct oidset *acked_commits);

Here is a good place to specifically mention the wait-for-done capability,
or else this method will die() when seeing the "ready" from the server.

> +setup_negotiate_only () {
> +	SERVER="$1"
> +	URI="$2"
> +
> +	rm -rf "$SERVER" client
> +
> +	git init "$SERVER"
> +	test_commit -C "$SERVER" one
> +	test_commit -C "$SERVER" two
> +
> +	git clone "$URI" client
> +	test_commit -C client three
> +}
> +
> +test_expect_success 'file:// --negotiate-only' '
> +	SERVER="server" &&
> +	URI="file://$(pwd)/server" &&
> +
> +	setup_negotiate_only "$SERVER" "$URI" &&
> +
> +	git -C client fetch \
> +		--no-tags \
> +		--negotiate-only \
> +		--negotiation-tip=$(git -C client rev-parse HEAD) \
> +		origin >out &&
> +	COMMON=$(git -C "$SERVER" rev-parse two) &&
> +	grep "$COMMON" out
> +'
> +
> +test_expect_success 'file:// --negotiate-only with protocol v0' '
> +	SERVER="server" &&
> +	URI="file://$(pwd)/server" &&
> +
> +	setup_negotiate_only "$SERVER" "$URI" &&
> +
> +	test_must_fail git -c protocol.version=0 -C client fetch \
> +		--no-tags \
> +		--negotiate-only \
> +		--negotiation-tip=$(git -C client rev-parse HEAD) \
> +		origin 2>err &&
> +	test_i18ngrep "negotiate-only requires protocol v2" err
> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> @@ -1035,6 +1078,52 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
>  	test_i18ngrep "disallowed submodule name" err
>  '
>  
> +test_expect_success 'http:// --negotiate-only' '
> +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> +	URI="$HTTPD_URL/smart/server" &&
> +
> +	setup_negotiate_only "$SERVER" "$URI" &&
> +
> +	git -C client fetch \
> +		--no-tags \
> +		--negotiate-only \
> +		--negotiation-tip=$(git -C client rev-parse HEAD) \
> +		origin >out &&
> +	COMMON=$(git -C "$SERVER" rev-parse two) &&
> +	grep "$COMMON" out
> +'
> +
> +test_expect_success 'http:// --negotiate-only without wait-for-done support' '
> +	SERVER="server" &&
> +	URI="$HTTPD_URL/one_time_perl/server" &&
> +
> +	setup_negotiate_only "$SERVER" "$URI" &&
> +
> +	echo "s/ wait-for-done/ xxxx-xxx-xxxx/" \
> +		>"$HTTPD_ROOT_PATH/one-time-perl" &&
> +
> +	test_must_fail git -C client fetch \
> +		--no-tags \
> +		--negotiate-only \
> +		--negotiation-tip=$(git -C client rev-parse HEAD) \
> +		origin 2>err &&
> +	test_i18ngrep "server does not support wait-for-done" err
> +'
> +
> +test_expect_success 'http:// --negotiate-only with protocol v0' '
> +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> +	URI="$HTTPD_URL/smart/server" &&
> +
> +	setup_negotiate_only "$SERVER" "$URI" &&
> +
> +	test_must_fail git -c protocol.version=0 -C client fetch \
> +		--no-tags \
> +		--negotiate-only \
> +		--negotiation-tip=$(git -C client rev-parse HEAD) \
> +		origin 2>err &&
> +	test_i18ngrep "negotiate-only requires protocol v2" err
> +'
> +
>  # DO NOT add non-httpd-specific tests here, because the last part of this
>  # test script is only executed when httpd is available and enabled.
>  
> diff --git a/transport-helper.c b/transport-helper.c
> index 4cd76366fa..4be035edb8 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -684,6 +684,16 @@ static int fetch(struct transport *transport,
>  		return transport->vtable->fetch(transport, nr_heads, to_fetch);
>  	}
>  
> +	/*
> +	 * If we reach here, then the server, the client, and/or the transport
> +	 * helper does not support protocol v2. --negotiate-only requires
> +	 * protocol v2.
> +	 */
> +	if (data->transport_options.acked_commits) {
> +		warning(_("--negotiate-only requires protocol v2"));
> +		return -1;
> +	}
> +

This method continues to do a lot that doesn't seem specific to
--negotiate-only. The warning message seems incorrect to me, but
is also seems like this would break several cases when using
protocol v0. It is equally possible that I'm misunderstanding
what is going on here.

> +	if (data->options.acked_commits) {
> +		if (data->version < protocol_v2) {
> +			warning(_("--negotiate-only requires protocol v2"));
> +			ret = -1;
> +		} else if (!server_supports_feature("fetch", "wait-for-done", 0)) {
> +			warning(_("server does not support wait-for-done"));
> +			ret = -1;
> +		} else {
> +			negotiate_using_fetch(data->options.negotiation_tips,
> +					      transport->server_options,
> +					      transport->stateless_rpc,
> +					      data->fd,
> +					      data->options.acked_commits);
> +			ret = 0;
> +		}
> +		goto cleanup;
> +	}

These prereqs look right. This makes it look rather strange that
negotiate_using_fetch() returns void (and has several die() calls inside)
and could instead return an 'int' that is consumed here (and use
error() calls instead of die()).

>  	refs = fetch_pack(&args, data->fd,
>  			  refs_tmp ? refs_tmp : transport->remote_refs,
>  			  to_fetch, nr_heads, &data->shallow,
>  			  &transport->pack_lockfiles, data->version);
>  
> -	close(data->fd[0]);
> -	close(data->fd[1]);
> -	if (finish_connect(data->conn))
> -		ret = -1;
> -	data->conn = NULL;
...

> +cleanup:
> +	close(data->fd[0]);
> +	close(data->fd[1]);
> +	if (finish_connect(data->conn))
> +		ret = -1;
> +	data->conn = NULL;
> +

Good to keep these after skipping a big chunk of the fetch logic.

> +
> +	/*
> +	 * If set, whenever transport_fetch_refs() is called, add known common
> +	 * commits to this oidset instead of fetching any packfiles.
> +	 */
> +	struct oidset *acked_commits;

nit: s/If set/If allocated/

> @@ -1668,10 +1673,13 @@ int upload_pack_v2(struct repository *r, struct strvec *keys,
>  		case FETCH_PROCESS_ARGS:
>  			process_args(request, &data);
>  
> -			if (!data.want_obj.nr) {
> +			if (!data.want_obj.nr && !data.wait_for_done) {
>  				/*
> -				 * Request didn't contain any 'want' lines,
> -				 * guess they didn't want anything.
> +				 * Request didn't contain any 'want' lines (and
> +				 * the request does not contain
> +				 * "wait-for-done", in which it is reasonable
> +				 * to just send 'have's without 'want's); guess
> +				 * they didn't want anything.
>  				 */
>  				state = FETCH_DONE;
>  			} else if (data.haves.nr) {
> @@ -1723,7 +1731,7 @@ int upload_pack_advertise(struct repository *r,
>  		int allow_sideband_all_value;
>  		char *str = NULL;
>  
> -		strbuf_addstr(value, "shallow");
> +		strbuf_addstr(value, "shallow wait-for-done");

It might be nice to have this wait-for-done capability configurable.
I'd likely want this on by default, but in case there is an issue it
is easier to change config values than ship new binaries.

This is a pretty big patch. It might have been nice to split the
server-side stuff out as its own patch with a follow-up for the client
code and the tests.

Thanks,
-Stolee
