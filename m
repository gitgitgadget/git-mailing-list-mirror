Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3DC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BA420878
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ydM9BOLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgIYSlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:41:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54849 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYSlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:41:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9D27EC6E6;
        Fri, 25 Sep 2020 14:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+2z8dlAujpBAfUwR5XeS0LQlrz8=; b=ydM9BO
        LCxAi/SvNq+b/UwIV9JuriNGz2XqFO3K+y5VZCyRMwNebgmqG9YQIZs0/lLXRT1Z
        LRj5Cpef/xkFZS+T/BFsB7z4c7tzRfzn2eZ0SuZ4jVlrH7mliZnDuvK8ZQTo8arK
        b1Myzaw3mlfKAkKbhwuLLmFTyi7RRCO3EG4tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wKPmSkZxCQqiXlqqMnr+23Upubrytv/l
        j4Hs7VOQgdnW5VQKxt12CVTgaVQDngwzGPxc3hAAWS7BEFHxPQVd3aR3ZDLkTynA
        13RXHua7H7dMn0JqFvR4oLD4ZrgX3viBhn790IOd6Wj9f4JsTis8OT/d7qXu0lX2
        xfY/2lDzPb8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B31DAEC6E4;
        Fri, 25 Sep 2020 14:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0EA93EC6E3;
        Fri, 25 Sep 2020 14:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] protocol: re-enable v2 protocol by default
References: <20200925183436.GA659633@coredump.intra.peff.net>
Date:   Fri, 25 Sep 2020 11:41:08 -0700
In-Reply-To: <20200925183436.GA659633@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 25 Sep 2020 14:34:36 -0400")
Message-ID: <xmqq4knllmwr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE137632-FF5E-11EA-9D89-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Let's move forward with v2 as the default again. It's possible there are
> still lurking bugs, but we won't know until it gets more widespread use.
> And we can find and squash them just like any other bug at this point.

Ack.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> After seeing yet another round of "if you use the v2 protocol, all of
> your issues fetching a non-tip object for submodules or CI will go away"
> advice today, I was reminded that we haven't picked up the question
> again of when we should look at v2 becoming the default again.
>
>  Documentation/config/feature.txt  | 4 ----
>  Documentation/config/protocol.txt | 3 +--
>  protocol.c                        | 6 +-----
>  3 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index c0cbf2bb1c..cdecd04e5b 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -14,10 +14,6 @@ feature.experimental::
>  +
>  * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
>  skipping more commits at a time, reducing the number of round trips.
> -+
> -* `protocol.version=2` speeds up fetches from repositories with many refs by
> -allowing the client to specify which refs to list before the server lists
> -them.
>  
>  feature.manyFiles::
>  	Enable config options that optimize for repos with many files in the
> diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
> index c46e9b3d00..756591d77b 100644
> --- a/Documentation/config/protocol.txt
> +++ b/Documentation/config/protocol.txt
> @@ -48,8 +48,7 @@ protocol.version::
>  	If set, clients will attempt to communicate with a server
>  	using the specified protocol version.  If the server does
>  	not support it, communication falls back to version 0.
> -	If unset, the default is `0`, unless `feature.experimental`
> -	is enabled, in which case the default is `2`.
> +	If unset, the default is `2`.
>  	Supported versions:
>  +
>  --
> diff --git a/protocol.c b/protocol.c
> index 8d964fc65e..052d7edbb9 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -17,7 +17,6 @@ static enum protocol_version parse_protocol_version(const char *value)
>  enum protocol_version get_protocol_version_config(void)
>  {
>  	const char *value;
> -	int val;
>  	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
>  	const char *git_test_v;
>  
> @@ -31,9 +30,6 @@ enum protocol_version get_protocol_version_config(void)
>  		return version;
>  	}
>  
> -	if (!git_config_get_bool("feature.experimental", &val) && val)
> -		return protocol_v2;
> -
>  	git_test_v = getenv(git_test_k);
>  	if (git_test_v && *git_test_v) {
>  		enum protocol_version env = parse_protocol_version(git_test_v);
> @@ -43,7 +39,7 @@ enum protocol_version get_protocol_version_config(void)
>  		return env;
>  	}
>  
> -	return protocol_v0;
> +	return protocol_v2;
>  }
>  
>  enum protocol_version determine_protocol_version_server(void)
