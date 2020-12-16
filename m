Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B30C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8125B23357
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 06:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLPGRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 01:17:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60584 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLPGRB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 01:17:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3488C874F5;
        Wed, 16 Dec 2020 01:16:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BTnuy7XpQ46w+M3pDfjQMXtfkG0=; b=swyHqV
        zDwaWoFCITE3cPX3u1XAnhhcqXgpKdx93/29c5GyQiyYYNvbC3/RFUgkWEmbdhBW
        3N4dUS3UY4zQt7S9aA5hfgTr1kezczCXG/KlKAuZMaEK45fCWTE3dYglf+BRS9KU
        hhlyZDA5I/qn5AhDdbAQXLlYBbQNzo+bL7zN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XDmwZqOsmOXj3EljIw43gIXd7wYZVDD3
        76TVUWJIs1XbHfbE8+psLwFoCzFI71RvV4BEUUWD/51UtOhTf07aNkckUWAEy/vm
        pLgkE5RpTvUqthweUIbeQOP+JAYZD5oDlpjnX/YT5ZdKlxmFwu4oYxpLHjax6n7b
        Kg05gwSp/kg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B7D1874F4;
        Wed, 16 Dec 2020 01:16:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6338874F3;
        Wed, 16 Dec 2020 01:16:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, felipe.contreras@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
References: <20201211210508.2337494-1-jonathantanmy@google.com>
        <cover.1608084282.git.jonathantanmy@google.com>
        <7f5b50c7b284f2630fe5be6455cc5d3e03b1eb70.1608084282.git.jonathantanmy@google.com>
Date:   Tue, 15 Dec 2020 22:16:14 -0800
In-Reply-To: <7f5b50c7b284f2630fe5be6455cc5d3e03b1eb70.1608084282.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 15 Dec 2020 18:07:56 -0800")
Message-ID: <xmqq1rfq5l8x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34060C9A-3F66-11EB-A596-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

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

OK, so the idea is

 - lsrefs.unborn controls on the serving side if this new feature is
   advertised to the incoming clients;

 - the client side can ask "unborn" and that is recorded in
   data.unborn bit at the beginning of ls_refs();

 - the response may show an unborn symbolic ref when "unborn" was asked.

which looks internally consistent.

> @@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	if (!ref_match(&data->prefixes, refname_nons))
>  		return 0;
>  
> -	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +	if (oid)
> +		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +	else
> +		strbuf_addf(&refline, "unborn %s", refname_nons);

A line that has token "unborn" instead of a full object name in hex
is something existing clients are not prepared to receive and grok.
It is not immediately clear how this new code makes sure that
clients that did not ask for "unborn" in what was parsed at the
beginning of ls_refs() will not see such a line.  Presumably, no
existing caller of send_ref passes NULL in oid and the only one
that does so is the one in send_possibly_unborn_head() when the HEAD
points at an unborn branch.

OK.

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

I'd suggest renaming this one, which masks the global null_oid of
"const struct object_id" type.  This code does not break only
because is_null_oid() happens to be implemented as a static inline,
and not as a C-preprocessor macro, right?

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

Are there differences between allow and advertise?  Would
lsrefs.allowUnborn that is a boolean, thus allowing the value to be
parsed by git_config_bool(), make more sense here, I wonder.  Or is
this meant as some future enhancement, e.g. you plan to have some
servers that allow "unborn" request even though they do not actively
advertise the support of the feature?  Without documentation update
or an in-code comment, it is rather hard to guess the intention
here.

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

Somehow, it appears to me that writing it in a way along with this
line ...

		else if (!strcmp("unborn", arg))
			data.unborn = data.allow_unborn;

... would make more sense.  Whether we allowed "unborn" request or
not, when the other side says "unborn", we are handling the request
for the unborn feature, and the condition with strcmp() alone
signals that better (in other words, when we acquire more request
types, we do not want to pass the control to "else if" clauses that
may come after this part when we see "unborn" request and when we
are configured not to accept "unborn" requests.

It does not make any difference in the current code, of course, and
it is more about future-proofing the cleanness of the code.

> -	head_ref_namespaced(send_ref, &data);
> +	if (data.unborn)
> +		send_possibly_unborn_head(&data);
> +	else
> +		head_ref_namespaced(send_ref, &data);

I found the "send_possibly 70% duplicates what the more generic
head_ref_namespaced() does" a bit disturbing.

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

Thanks.
