Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27776208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757575AbdHYRsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:48:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757572AbdHYRsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99C2895FF0;
        Fri, 25 Aug 2017 13:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vfLhcBQGqVow4AOKMkmo/VWUrYE=; b=yBr1ub
        MY/hiL7O9EQ+HKR44jekOpDzapKFREiBxxCzPIWIguCKEv+ag/b406B08lmGpKCD
        EknLIP2L3qCxgFrvmGoq6NEJcjhUX1JMQm9sF55Eec4HeAjjl9zW9B5q0LkeNCAO
        azq6h3mReBWhytY0LHdRHBP/mvAxoS6wsMOZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eljwxt+iP67OI5NVhiB4oJrIJQUCKaw2
        9HkrYn8OGEkPRvgywaHOvAm58mJioT6qsEr9IXFiyvpR9AgTIphQ6+HYsicPXXry
        n5qK9G72IuJULvEZtNHBOYi4ft3zWtTfjqssnJF9B8rEGHov0AHpdDUmy0G2ElKi
        o7+mOErg6lc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9199295FEF;
        Fri, 25 Aug 2017 13:48:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7BB195FEE;
        Fri, 25 Aug 2017 13:48:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
References: <20170824225328.8174-1-bmwill@google.com>
        <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
Date:   Fri, 25 Aug 2017 10:48:50 -0700
In-Reply-To: <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 25 Aug 2017 10:29:02 -0700")
Message-ID: <xmqqpobjsflp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8118BD0-89BD-11E7-B55A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But what if we instead think of it not as "protocol v2" but as "can I
> give the server some hints that it may end up ignoring", then we end up
> with something more like:
>
>   C: please run upload-pack (btw, I'm only interested in refs/heads/foo)
>   S: advertisement + caps (hopefully limited to foo, but client is prepared to receive all)
>   ... etc, as before ...

Nice.  The caps that come back can tell us between the cases where
they only had refs/heads/foo and nothing else, or if they limited
their output to it among many others we told them to ignore, so
there is no ambiguity.

> Or alternatively, I guess make this optional to start with, and
> let early adopters turn it on and complain to their server vendors
> for a while before flipping the default to on.

That sounds like a safe transition plan.
