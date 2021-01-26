Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF66C4332D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2308F206A4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbhAZWFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:05:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62749 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbhAZVzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 16:55:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD944113AF3;
        Tue, 26 Jan 2021 16:54:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vTEXtrnR8PKHgcm8VN9WXSJV+M8=; b=SE1e3I
        agcJJ3/84hm3v79bVRhZRn4ucRlObJO5lcomiCV7HWh424N7SkIWo8OD58hTl3Fh
        9zHOfJ5GRTVylPig87855eD517265PM5sMHyOpCrvCZrEPHx82br/5vEGzVbVLWm
        eTMu6vcOiLHLODgqCYef23xURWRTS/XXg/c8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hfjrokuf/+9Bp2TwufOUp633ScjoIIwu
        B6XalvreX4Y765noxHmI2a1P6wyAUrPNmvFJB1FHb+BuhR3WU77O93cmHLq2EloZ
        WJ6lfd+4uG9cewUySs7mI78xSX01q0pti02OKVFsS4x8lxyES9+AABQCDWGTsfRv
        6sdL4uuTsP4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D60C1113AF2;
        Tue, 26 Jan 2021 16:54:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 269DF113AF1;
        Tue, 26 Jan 2021 16:54:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 2/3] connect, transport: encapsulate arg in struct
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
        <4eec55166889f16e41b10ae65002fd2c821b6762.1611686656.git.jonathantanmy@google.com>
Date:   Tue, 26 Jan 2021 13:54:52 -0800
In-Reply-To: <4eec55166889f16e41b10ae65002fd2c821b6762.1611686656.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 26 Jan 2021 10:55:56 -0800")
Message-ID: <xmqq4kj31hzn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F639286-6021-11EB-9056-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In a future patch we plan to return the name of an unborn current branch
> from deep in the callchain to a caller via a new pointer parameter that
> points at a variable in the caller when the caller calls
> get_remote_refs() and transport_get_remote_refs().
>
> In preparation for that, encapsulate the existing ref_prefixes
> parameter into a struct. The aforementioned unborn current branch will
> go into this new struct in the future patch.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/clone.c      | 18 +++++++++++-------
>  builtin/fetch-pack.c |  3 ++-
>  builtin/fetch.c      | 18 +++++++++++-------
>  builtin/ls-remote.c  |  9 +++++----
>  connect.c            |  4 +++-
>  remote.h             |  4 +++-
>  transport-helper.c   |  5 +++--
>  transport-internal.h |  9 +--------
>  transport.c          | 23 ++++++++++++-----------
>  transport.h          | 21 ++++++++++++++-------
>  10 files changed, 65 insertions(+), 49 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 58b7c1fbdc..c2d96f4c89 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -220,7 +220,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	version = discover_version(&reader);
>  	switch (version) {
>  	case protocol_v2:
> -		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
> +		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
> +				args.stateless_rpc);
>  		break;

This seems to be an unrelated line-wrapping, but there are overlong
lines that are longer than this line in the same function.

Everything else looks sensible to change the assumption that a strvec
is sufficient for the communication in the codepaths and make it more
easily extended by passing a ls-refs-options structure, which makes
quite a lot of sense.

> diff --git a/transport.h b/transport.h
> index 24558c027d..1f5b60e4d3 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -233,17 +233,24 @@ int transport_push(struct repository *repo,
>  		   struct refspec *rs, int flags,
>  		   unsigned int * reject_reasons);
>  
> +struct transport_ls_refs_options {
> +	/*
> +	 * Optionally, a list of ref prefixes can be provided which can be sent
> +	 * to the server (when communicating using protocol v2) to enable it to
> +	 * limit the ref advertisement.  Since ref filtering is done on the
> +	 * server's end (and only when using protocol v2),
> +	 * transport_get_remote_refs() could return refs which don't match the
> +	 * provided ref_prefixes.
> +	 */
> +	struct strvec ref_prefixes;
> +};
> +#define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
> +

And of course, the first step only carries the strvec we have been
passing around, i.e. does not lose or gain features.

Looking good.  Thanks.

