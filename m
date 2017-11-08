Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E771F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbdKHAys (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:54:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759011AbdKHAyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:54:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7F0FB7A8B;
        Tue,  7 Nov 2017 19:54:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YXIgWZbsD1VjbrE1zVQgrGuMRBw=; b=Gy4Knx
        NN7v92FDHM9DKq95KmKT3jnhlHugIsBB0A9SB0aSonpsD6GHhKOf5733amLnIPLz
        zeog4de9ME5ZCpt3+pA2QD5IiJToTEQ+gUTf9M43u9CgAfg2hlqUwVml3fAzn2zw
        4eTTWiBOZjPEpTpA1Sf2Rx5DmkuZ4w03jU0kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RwFHRT3FNaCpo0h7UGUHn3QiNtxVh2FX
        8LdVPOHPEnqfyb0CdD5qhxd60d1i675aS1IyS8GuemPo4uditJLGbrPjEHKL0jqi
        muBC3731YDuQoGabnI5rQ6rsVt0My8Ar0rQq3EcCtPwQcdDEtrxeLqXRNp7YvTm5
        Mf3zixyMa9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD734B7A8A;
        Tue,  7 Nov 2017 19:54:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2821EB7A89;
        Tue,  7 Nov 2017 19:54:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
References: <20171102175013.3371-1-git@jeffhostetler.com>
        <20171102124445.fbffd43521cd35f6a71e1851@google.com>
        <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com>
        <xmqq7ev7pfln.fsf@gitster.mtv.corp.google.com>
        <97585434-6d57-dad4-d7aa-e48dacec1b3f@jeffhostetler.com>
        <20171107164118.97cc65c4030de0922b19ddd6@google.com>
Date:   Wed, 08 Nov 2017 09:54:44 +0900
In-Reply-To: <20171107164118.97cc65c4030de0922b19ddd6@google.com> (Jonathan
        Tan's message of "Tue, 7 Nov 2017 16:41:18 -0800")
Message-ID: <xmqq8tfhoai3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A231A36-C41F-11E7-9541-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I can see some use for this parameter - for example, when doing a report
> for statistical purposes (percentage of objects missing, for example) or
> for a background task that downloads missing objects into a cache. Also,
> power users who know what they're doing (or normal users in an
> emergency) can use this option when they have no network connection if
> they really need to find something out from the local repo.
>
> In these cases, the promisor check (after detecting that the object is
> missing) is indeed not so useful, I think. (Or we can do the
> --exclude=missing and --exclude=promisor idea that Jeff mentioned -
> --exclude=missing now, and --exclude=promisor after we add promisor
> support.)

This sounds like a reasonable thing to have in the endgame state to
me.

> Having said that, I would be OK if we didn't have tolerance (and/or
> reporting) of missing objects right now. As far as I know, for the
> initial implementation of partial clone, only the server performs any
> filtering, and we assume that the server possesses all objects (so it
> does not need to filter out any missing objects).

True.  It does not have to exist in an early part, but I do not
think we would terribly mind if it does, if only to help debugging
and development.

Thanks for thinking it through.
