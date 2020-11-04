Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38182C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91C3207BB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lMSQzPyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgKDVOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:14:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56136 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDVOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 16:14:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0C34EFBC2;
        Wed,  4 Nov 2020 16:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FmmG+w8mGeI3Z137cO5K+5hDomE=; b=lMSQzP
        yH/XugQ4seTNXpHHIz2K85OapPk0T1iD3/oNnHvGRB4IillJOqrYd3lMQ7jvt671
        3nH/RMb7br+z9QLHqXcgQiKxh71ZrDrVpJvq6K/c9Vskju/dHrifLRO5CBOU6oA3
        qdciKUkFrSbYQ8tmq+OmypEPQeiY7cYhUYw8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TyqUHHxoPJLTB/0CzjV3Duj8ZKJ/Eqw2
        4GMDjF/7Hu5ITcQEcYRknHlogIZSQ4q5p02G+LCWg+oFVyv/HZ29612vlzJqV4l1
        BwndK38xHRwl2RkNyM2h57VLs9aCNHogQkpp2jd8PzUfn19AuItq9T5h85IMZLEK
        VVA7+rlL3yQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8D03EFBC0;
        Wed,  4 Nov 2020 16:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04542EFBBF;
        Wed,  4 Nov 2020 16:14:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 07/11] transport: log received server trace2 SID
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <21bdbf23f39c800b1722c54b666df7a91b5879b5.1604355792.git.steadmon@google.com>
Date:   Wed, 04 Nov 2020 13:14:31 -0800
In-Reply-To: <21bdbf23f39c800b1722c54b666df7a91b5879b5.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:31:05 -0800")
Message-ID: <xmqqpn4slt8o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBFDA878-1EE2-11EB-9FD7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> When a client receives a trace2-sid capability from a protocol v0, v1,
> or v2 server, log the received session ID via a trace2 data event.

Would this pose a new security threat surface?  Just wondering if we
want to ignore the capability if it is not enabled on our end with
the configuration.

Thanks.

> diff --git a/transport.c b/transport.c
> index 47da955e4f..d16be597bd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -286,6 +286,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  	struct git_transport_data *data = transport->data;
>  	struct ref *refs = NULL;
>  	struct packet_reader reader;
> +	int sid_len;
> +	const char *server_trace2_sid;
>  
>  	connect_setup(transport, for_push);
>  
> @@ -297,6 +299,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  	data->version = discover_version(&reader);
>  	switch (data->version) {
>  	case protocol_v2:
> +		if (server_feature_v2("trace2-sid", &server_trace2_sid))
> +			trace2_data_string("trace2", NULL, "server-sid", server_trace2_sid);
>  		if (must_list_refs)
>  			get_remote_refs(data->fd[1], &reader, &refs, for_push,
>  					ref_prefixes,
> @@ -310,6 +314,12 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  				 for_push ? REF_NORMAL : 0,
>  				 &data->extra_have,
>  				 &data->shallow);
> +		server_trace2_sid = server_feature_value("trace2-sid", &sid_len);
> +		if (server_trace2_sid) {
> +			char *server_sid = xstrndup(server_trace2_sid, sid_len);
> +			trace2_data_string("trace2", NULL, "server-sid", server_sid);
> +			free(server_sid);
> +		}
>  		break;
>  	case protocol_unknown_version:
>  		BUG("unknown protocol version");
