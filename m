Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A44320372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbdJMAJM (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:09:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65078 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752884AbdJMAJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:09:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F8C3A618E;
        Thu, 12 Oct 2017 20:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=azqWNd6gtXhP6gtLJomPSkwoX4Y=; b=q2qhc7
        abeQ5PCwh1WWLnZL9nnEjco/OaFWy5awQwTSBUazzP1qzJDKHgxmy75QWrtZ6LmA
        fN0yB43tGUATmGYQ1Wc+7d0WjXuRN7bN3WyiaAgAmmXZFDHufFFqARxHhnnM1iHh
        1Kl2D+YFQeT4/kVecy437PY+Yc1iZxolAHq+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iC1wBkHcP+dzjMxiL0JRAMcnv5T49lc4
        CNDt0P5CQKp4VrVPqaJ/OwWoMmJWS1Pqti84lO9uYpfIcQn4tuhJD6xTLGWdBe8f
        jRpmg5Y8HKkXXm9iJnKIEFT+8IDUQov1pJRxuMoXzT13E+mrxVWizhLJRF96pvB6
        TDqZkL70uFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88CE2A618D;
        Thu, 12 Oct 2017 20:09:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08C4BA618C;
        Thu, 12 Oct 2017 20:09:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
Date:   Fri, 13 Oct 2017 09:09:09 +0900
In-Reply-To: <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 12 Oct 2017 08:31:53 -0400")
Message-ID: <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD21D116-AFAA-11E7-8DB0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Also
> as an aside, I think this patch means that:
>
>   git -c color.ui=always add -p
>
> is broken (as would a hypothetical "git --default-color=always add -p").
> That's sufficiently insane that I'm not sure we should care about it.

Do you mean that "'-c color.ui=always' from the command line is
passed down to the invocations of 'git' the 'add' command makes, and
would break output from 'diff-index' that 'add -i' wants to parse"?

With the breakage that motivated "downgrade only for on-disk" change
in mind, I do think that is the right behaviour.  Those third-party
scripts we broke knew how '-c color.ui=always' works and depended on
it, and I consider that the command line configuration getting
passed around as an integral part of 'how it works'.  "Fixing" it
will break them again.

Let's take it as a signal that tells us that the script writers know
what they are doing and leave it as a longish rope they can play with.

