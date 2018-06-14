Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B0F1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755332AbeFNTw3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:52:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34802 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeFNTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:52:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so7671916wro.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=3mf7mQg57zxpct73PkAkd7KJLo4n+PBDVI4puGMfX9k=;
        b=NcDdQ6RUMAVWAfAsk772SX68UrXl/hJesNhE0s6zMu8+gx1vcfichBQXqM745Vljj7
         u2GFXNM8eGzVLLhZ3/veNiZUiY1qzC/WOm9uhyslD2kt9TzNROGQ5bWHvHlVZxbiC1cB
         hIj6l6+B4thqbHLF3fIlh9iwhBLD9SWlvjqYC8Rvp7EgT8fiT0yadIDN39rPgrCdc2qZ
         pQOkZoZnW39iNwX1G/wRBeh6VCPB/3XpUlJl7t63HqvhkMG6dkwBJdgZ++A/rmZogiFR
         yzDmhb29gSqDA9gZGspLLP/QRTlLxLaeu5G+jDDIptxlzDXxfmUSTtFjuzwbVaf+U6PZ
         gZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=3mf7mQg57zxpct73PkAkd7KJLo4n+PBDVI4puGMfX9k=;
        b=O/a3OwrnRl6Vga5GNEsWuFUZxcJ7RlNYiOmx+irSaWEmxVAAGLrsYBFbZvMWoNe1zS
         SCy7dY3vi8E+JaALuM07CPCO+7qGRSxBl2rfpkf5GYz/G1hkwygQ4UMp4OagcJv2/tNd
         KLuMriKCGErsgUPAzQ/gxyiWAd+BdMycNIR7pC2RI+vqdTiiRE1/NnQ8cN45/OohSNt0
         TkchZrDOi+ejgu1uhyrtdjoWVcOcuq16n7jA+oOhOns3TmmCp0eHn2cg3UFrxMP+lOw3
         NJLOijpsZVRk8Idutw8RRSlJ67utuvJelRh+MKUZMxwr2ofd/oKd4VCzssQvDRitb57d
         zIgg==
X-Gm-Message-State: APt69E1oYL+gxaYyG0cRz1xCKpbUg6RnXrMeqkzQm90tBs9TIU2uo3Pk
        1HPL1DkkbCpAf4uW8mwlf2s=
X-Google-Smtp-Source: ADUXVKJxfXEr9at6Ro6nYtERaAhhYzVMEgXpmEOKJZn7DHKkT8sy4Oua6WzC3Aajiv7q5KopyCIDmA==
X-Received: by 2002:adf:9950:: with SMTP id x74-v6mr3366353wrb.135.1529005946738;
        Thu, 14 Jun 2018 12:52:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 201-v6sm9812772wmm.18.2018.06.14.12.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 12:52:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 4/8] fetch-pack: use ref adv. to prune "have" sent
References: <cover.1527894919.git.jonathantanmy@google.com>
        <cover.1528317619.git.jonathantanmy@google.com>
        <f12342fb2760eb0449c86c66bf44d39f5871be57.1528317619.git.jonathantanmy@google.com>
Date:   Thu, 14 Jun 2018 12:52:25 -0700
Message-ID: <xmqqsh5p2lja.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +test_expect_success 'use ref advertisement to prune "have" lines sent' '
> +	rm -rf server client &&
> +	git init server &&
> +	test_commit -C server both_have_1 &&
> +	git -C server tag -d both_have_1 &&
> +	test_commit -C server both_have_2 &&
> +
> +	# In this test, the ref name that only the server has is a prefix of all
> +	# other refs. This is because in protocol v2, the client sends
> +	# "ref-prefix" to limit the ref advertisement. Naming the ref "bo" means
> +	# that "ref-prefix refs/tags/bo*" is sent, resulting in the client also
> +	# knowing about refs/tags/both_have_2, just as it would when it uses
> +	# protocol v0.

I have a mixed feeling about this test.

The client wants to fetch "bo" and nothing else in this example.
And refs "both_have_*", which have *nothing* to do with the ref the
client actually wants, is advertised merely because "both_have_*"
begins with "bo" with v2.  But that is an implementation detail that
we do not necessarily want to cast in stone, isn't it?  After all,
in future iterations of the protocol, we may find it too excessive
that we have to advertise both_have_1..both_have_10000 when the
client asks for bo and change either the pattern matching rule of
what "ref-prefix refs/tags/bo" matches, or the ref-prefix sent by
the client, and at that point, the expectation that both_have_2 is
sent as "have" but both_have_2^1 is not may have to change, no?

> +	git clone server client &&
> +	test_commit -C server bo &&
> +	test_commit -C client client_has &&
> +
> +	# In both protocol v0 and v2, ensure that the parent of both_have_2 is
> +	# not sent as a "have" line. The client should know that the server has
> +	# both_have_2, so it only needs to inform the server that it has
> +	# both_have_2, and the server can infer the rest.
> +
> +	rm -f trace &&
> +	cp -r client clientv0 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
> +		fetch origin bo &&

> +	grep "have $(git -C client rev-parse client_has)" trace &&
> +	grep "have $(git -C client rev-parse both_have_2)" trace &&
> +	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
> +
> +	rm -f trace &&
> +	cp -r client clientv2 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
> +		fetch origin bo &&
> +	grep "have $(git -C client rev-parse client_has)" trace &&
> +	grep "have $(git -C client rev-parse both_have_2)" trace &&
> +	! grep "have $(git -C client rev-parse both_have_2^)" trace
> +'
> +
>  test_expect_success 'filtering by size' '
>  	rm -rf server client &&
>  	test_create_repo server &&
