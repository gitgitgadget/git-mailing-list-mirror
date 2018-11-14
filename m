Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403AE1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 02:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeKNM54 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 07:57:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60445 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeKNM54 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 07:57:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5145118337;
        Tue, 13 Nov 2018 21:56:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eS69yzMpRzgYL2W5e4l62dimIuw=; b=XUE7FU
        Wcb7se0uQ9Hsq7qQia7d7L0FXtepxhJjqIeSU7pntYxXm8542RmBWmrnOD8taFeX
        JZGRJOTPOlyIyjLJHrMvZ23I51NLO2S8g0SWDOQDjPrQZvo6UQXKmSak91Vw9ZUi
        Re6DL+OXFvDYaiu5PeUlcVku+AZbiLQ46YNfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kjm9ltYMwRcT/F5AoM+poujZJqybP2fg
        +LASW7HpGLox9o8/nBGSgFuZR/JycLL8r1ka8Yz9yT28QWm53ZHolWRVoz4rhV2C
        9fRR+X3WDMoKT/Jgh6c66V673Zv5JsBhN3agxi1E/nWAtrqNc4bG8ZDK626VoCr4
        fTXqTgPnbXE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4917D18336;
        Tue, 13 Nov 2018 21:56:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DA2618335;
        Tue, 13 Nov 2018 21:56:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: use CXXFLAGS for linking fuzzers
References: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
        <xmqq36s5y8l2.fsf@gitster-ct.c.googlers.com>
        <20181113185032.GC126896@google.com>
Date:   Wed, 14 Nov 2018 11:56:37 +0900
In-Reply-To: <20181113185032.GC126896@google.com> (Josh Steadmon's message of
        "Tue, 13 Nov 2018 10:50:32 -0800")
Message-ID: <xmqqsh04qsd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E86883F0-E7B8-11E8-A2B2-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> OSS-Fuzz only provides one set of CXXFLAGS for use on both compiling
> project C++ project files as well linking the fuzzers themselves. So in
> the event that Git ever added any C++ sources, they would need to use
> the same set of CXXFLAGS.

OK.

> Given that, do you agree with Stefan that it is more intuitive to define
> CXXFLAGS next to the fuzzer build rules, since that's the only place
> it's used for now?

I am not sure.  Until we gain other C++ targets (in other words,
while linking with fuzzer is the only consumer of CXXFLAGS), I'd
consider it similar to SPARSE_FLAGS and SPATCH_FLAGS, i.e. settings
specific to an auxiliary tool that supports our development process,
and it would make more sense to define it near them higher in the
Makefile.

I'd probably feel differently if this were called FUZZ_CXXFLAGS or
something like that, which would make its natural home next to
the rule to build $(FUZZ_PROGRAMS), though.
