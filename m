Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D8C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 06:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D8A2336D
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 06:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgLPGVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 01:21:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54055 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPGVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 01:21:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0B9DF74FC;
        Wed, 16 Dec 2020 01:20:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dQe3Mob/A8q+78wYe1n5VUzRGPI=; b=Vv5cSw
        5GY01rN8YuLvza10EmiksisevS21mrd9c6F/j1Rb7LOlxWyo1IDP69j5FNPOeQ8T
        tkO7OeAxK1g2RAkVGHAlrBxUebtEbBMegX+/nwpIepnMfkXqLHz2w36lGRAScBMd
        PDO9Nh2TEMyRhwK183gIqi3qRYvhx9Wpeg5+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZR8jqpySkvu8BSvR6n77CxPs18yKYPG/
        lD2o2gpQUGCx5FnVtjC4HhZSbXnBrH3/bYXZIW5PI/6ba45R1m0NdL4dzUQEAXs6
        YI00pFviwr/u7hORSjmNIFwKXnRqQhA1MMNyVG657SrLTRj7OBWnGaHmBX4PnnsC
        EkAzdSndTQQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98B6EF74FB;
        Wed, 16 Dec 2020 01:20:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D418F74FA;
        Wed, 16 Dec 2020 01:20:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, felipe.contreras@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/3] connect, transport: add no-op arg for future patch
References: <20201211210508.2337494-1-jonathantanmy@google.com>
        <cover.1608084282.git.jonathantanmy@google.com>
        <e24fb6d746279a71f8d6a532790231c2a46468aa.1608084282.git.jonathantanmy@google.com>
Date:   Tue, 15 Dec 2020 22:20:50 -0800
In-Reply-To: <e24fb6d746279a71f8d6a532790231c2a46468aa.1608084282.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 15 Dec 2020 18:07:57 -0800")
Message-ID: <xmqqwnxi46gt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8789AAE-3F66-11EB-BA9E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A future patch will require transport_get_remote_refs() and
> get_remote_refs() to gain a new argument. Add the argument in this
> patch, with no effect on execution, so that the future patch only needs
> to concern itself with new logic.

Please give at least a hint about what this "new argument" will be
passing around through the callchain.  E.g.

	In a future patch we plan to return the name of an unborn
	current branch from deep in the callchain to a caller via a
	new pointer parameter that points at a variable in the
	caller when the caller calls get_remote_refs() and
	transport_get_remote_refs().  Add the parameter to functions
	involved in the callchain, but no caller passes an actual
	argument yet in this step ...

or something like that.

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/clone.c      |  2 +-
>  builtin/fetch-pack.c |  3 ++-
>  builtin/fetch.c      |  2 +-
>  builtin/ls-remote.c  |  2 +-
>  builtin/remote.c     |  2 +-
>  connect.c            |  5 ++++-
>  remote.h             |  3 ++-
>  transport-helper.c   |  7 +++++--
>  transport-internal.h | 13 +++++--------
>  transport.c          | 29 ++++++++++++++++++-----------
>  transport.h          |  7 ++++++-
>  11 files changed, 46 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index a0841923cf..70f9450db4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1264,7 +1264,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (!option_no_tags)
>  		strvec_push(&ref_prefixes, "refs/tags/");
>  
> -	refs = transport_get_remote_refs(transport, &ref_prefixes);
> +	refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
>  
>  	if (refs) {
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
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
> index 8b8f56cf6d..99d9052365 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -455,7 +455,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  			     struct ref **list, int for_push,
>  			     const struct strvec *ref_prefixes,
>  			     const struct string_list *server_options,
> -			     int stateless_rpc)
> +			     int stateless_rpc,
> +			     char **unborn_head_target)
>  {
>  	int i;
>  	const char *hash_name;
> @@ -496,6 +497,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  
>  	/* Process response from server */
>  	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +		if (unborn_head_target)
> +			BUG("NEEDSWORK: provide unborn HEAD target to caller while reading refs");
>  		if (!process_ref_v2(reader, &list))
>  			die(_("invalid ls-refs response: %s"), reader->line);
>  	}
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
> diff --git a/transport-helper.c b/transport-helper.c
> index 5f6e0b3bd8..5d97eba935 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1162,13 +1162,16 @@ static int has_attribute(const char *attrs, const char *attr)
>  }
>  
>  static struct ref *get_refs_list(struct transport *transport, int for_push,
> -				 const struct strvec *ref_prefixes)
> +				 const struct strvec *ref_prefixes,
> +				 char **unborn_head_target)
>  {
>  	get_helper(transport);
>  
>  	if (process_connect(transport, for_push)) {
>  		do_take_over(transport);
> -		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
> +		return transport->vtable->get_refs_list(transport, for_push,
> +							ref_prefixes,
> +							unborn_head_target);
>  	}
>  
>  	return get_refs_list_using_list(transport, for_push);
> diff --git a/transport-internal.h b/transport-internal.h
> index 27c9daffc4..5037f6197d 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -18,19 +18,16 @@ struct transport_vtable {
>  	 * the transport to try to share connections, for_push is a
>  	 * hint as to whether the ultimate operation is a push or a fetch.
>  	 *
> -	 * If communicating using protocol v2 a list of prefixes can be
> -	 * provided to be sent to the server to enable it to limit the ref
> -	 * advertisement.  Since ref filtering is done on the server's end, and
> -	 * only when using protocol v2, this list will be ignored when not
> -	 * using protocol v2 meaning this function can return refs which don't
> -	 * match the provided ref_prefixes.
> -	 *
>  	 * If the transport is able to determine the remote hash for
>  	 * the ref without a huge amount of effort, it should store it
>  	 * in the ref's old_sha1 field; otherwise it should be all 0.
> +	 *
> +	 * See transport_get_remote_refs() for information on ref_prefixes and
> +	 * unborn_head_target.
>  	 **/
>  	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
> -				     const struct strvec *ref_prefixes);
> +				     const struct strvec *ref_prefixes,
> +				     char **unborn_head_target);
>  
>  	/**
>  	 * Fetch the objects for the given refs. Note that this gets
> diff --git a/transport.c b/transport.c
> index 47da955e4f..815e175017 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -127,7 +127,8 @@ struct bundle_transport_data {
>  
>  static struct ref *get_refs_from_bundle(struct transport *transport,
>  					int for_push,
> -					const struct strvec *ref_prefixes)
> +					const struct strvec *ref_prefixes,
> +					char **unborn_head_target)
>  {
>  	struct bundle_transport_data *data = transport->data;
>  	struct ref *result = NULL;
> @@ -163,7 +164,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  	int ret;
>  
>  	if (!data->get_refs_from_bundle_called)
> -		get_refs_from_bundle(transport, 0, NULL);
> +		get_refs_from_bundle(transport, 0, NULL, NULL);
>  	ret = unbundle(the_repository, &data->header, data->fd,
>  			   transport->progress ? BUNDLE_VERBOSE : 0);
>  	transport->hash_algo = data->header.hash_algo;
> @@ -281,7 +282,7 @@ static void die_if_server_options(struct transport *transport)
>   */
>  static struct ref *handshake(struct transport *transport, int for_push,
>  			     const struct strvec *ref_prefixes,
> -			     int must_list_refs)
> +			     int must_list_refs, char **unborn_head_target)
>  {
>  	struct git_transport_data *data = transport->data;
>  	struct ref *refs = NULL;
> @@ -301,7 +302,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  			get_remote_refs(data->fd[1], &reader, &refs, for_push,
>  					ref_prefixes,
>  					transport->server_options,
> -					transport->stateless_rpc);
> +					transport->stateless_rpc,
> +					unborn_head_target);
>  		break;
>  	case protocol_v1:
>  	case protocol_v0:
> @@ -324,9 +326,11 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  }
>  
>  static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
> -					const struct strvec *ref_prefixes)
> +					const struct strvec *ref_prefixes,
> +					char **unborn_head_target)
>  {
> -	return handshake(transport, for_push, ref_prefixes, 1);
> +	return handshake(transport, for_push, ref_prefixes, 1,
> +			 unborn_head_target);
>  }
>  
>  static int fetch_refs_via_pack(struct transport *transport,
> @@ -370,7 +374,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>  				break;
>  			}
>  		}
> -		refs_tmp = handshake(transport, 0, NULL, must_list_refs);
> +		refs_tmp = handshake(transport, 0, NULL, must_list_refs, NULL);
>  	}
>  
>  	if (data->version == protocol_unknown_version)
> @@ -765,7 +769,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  		return -1;
>  
>  	if (!data->got_remote_heads)
> -		get_refs_via_connect(transport, 1, NULL);
> +		get_refs_via_connect(transport, 1, NULL, NULL);
>  
>  	memset(&args, 0, sizeof(args));
>  	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
> @@ -1251,7 +1255,8 @@ int transport_push(struct repository *r,
>  
>  		trace2_region_enter("transport_push", "get_refs_list", r);
>  		remote_refs = transport->vtable->get_refs_list(transport, 1,
> -							       &ref_prefixes);
> +							       &ref_prefixes,
> +							       NULL);
>  		trace2_region_leave("transport_push", "get_refs_list", r);
>  
>  		strvec_clear(&ref_prefixes);
> @@ -1370,12 +1375,14 @@ int transport_push(struct repository *r,
>  }
>  
>  const struct ref *transport_get_remote_refs(struct transport *transport,
> -					    const struct strvec *ref_prefixes)
> +					    const struct strvec *ref_prefixes,
> +					    char **unborn_head_target)
>  {
>  	if (!transport->got_remote_refs) {
>  		transport->remote_refs =
>  			transport->vtable->get_refs_list(transport, 0,
> -							 ref_prefixes);
> +							 ref_prefixes,
> +							 unborn_head_target);
>  		transport->got_remote_refs = 1;
>  	}
>  
> diff --git a/transport.h b/transport.h
> index 24558c027d..65de0c9c00 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -241,9 +241,14 @@ int transport_push(struct repository *repo,
>   * advertisement.  Since ref filtering is done on the server's end (and only
>   * when using protocol v2), this can return refs which don't match the provided
>   * ref_prefixes.
> + *
> + * If unborn_head_target is not NULL, and the remote reports HEAD as pointing
> + * to an unborn branch, this function stores the unborn branch in
> + * unborn_head_target. It should be freed by the caller.
>   */
>  const struct ref *transport_get_remote_refs(struct transport *transport,
> -					    const struct strvec *ref_prefixes);
> +					    const struct strvec *ref_prefixes,
> +					    char **unborn_head_target);
>  
>  /*
>   * Fetch the hash algorithm used by a remote.
