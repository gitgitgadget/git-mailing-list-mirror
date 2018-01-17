Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BEA1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeAQVC4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:02:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61785 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeAQVCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:02:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A14AC9514;
        Wed, 17 Jan 2018 16:02:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IgXVAdWxEZthWcmihfWig9sGmtY=; b=qwn7F5
        2t7kMPSrrvwoQvNyPX1B8we5T76ry85uJSwPHEqCeslA2fjL11SRrbvNAMjCxou6
        L68knULp1Hx38edLyo5dhyzPMOpjBTOVWqMzjONl5aVsqLk15aqlzDF4ZhvqATAH
        s4iH5aajIFwRxN903jlz4LcuVpurgss2SjcUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b9dmL56pqPIpMpYroOPykolyvI01nmqJ
        194nViKs9exnhBZuptmGdcEgvtISX994B4BBhSwU5F6Hw0Q/Xqq72YN/cxP00ecG
        Mdi94WWM91NGx5OSc9w1cX7uHGuuFmSVo1LuZk5ORGmRpCmtS0JcBcDUy7eSt80k
        vpJ733kSHy0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C1CC9513;
        Wed, 17 Jan 2018 16:02:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DFE7C9511;
        Wed, 17 Jan 2018 16:02:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Ludwig <chrissicool@googlemail.com>
Cc:     git@vger.kernel.org, Christian Ludwig <chrissicool@gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: Support separate Reply-To address
References: <20180117180801.31049-1-chrissicool@gmail.com>
        <20180117180801.31049-2-chrissicool@gmail.com>
Date:   Wed, 17 Jan 2018 13:02:52 -0800
In-Reply-To: <20180117180801.31049-2-chrissicool@gmail.com> (Christian
        Ludwig's message of "Wed, 17 Jan 2018 19:08:01 +0100")
Message-ID: <xmqqzi5cqjur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8E17590-FBC9-11E7-B1B7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Ludwig <chrissicool@googlemail.com> writes:

> In some projects contributions from groups are only accepted from a
> common group email address. But every individual may want to recieve
> replies to her own personal address. That's what we have 'Reply-To'
> headers for in SMTP.
>
> Introduce an optional '--reply-to' command line option. Unfortunately
> the $reply_to variable name was already taken for the 'In-Reply-To'
> header field. To reduce code churn, use $reply_address as variable
> name instead.
>
> Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
> ---
>  Documentation/git-send-email.txt       |  5 +++++
>  contrib/completion/git-completion.bash |  2 +-
>  git-send-email.perl                    | 18 +++++++++++++++++-
>  t/t9001-send-email.sh                  |  2 ++
>  4 files changed, 25 insertions(+), 2 deletions(-)

Thanks.

While merging this with other topics in flight on 'pu', there were
minor merge conflicts, especially with np/send-email-header-parsing
that ends at b6049542 ("send-email: extract email-parsing code into
a subroutine", 2017-12-15) that attempts to refactor the code that
reads the header lines.  As there is *no* real change that benefits
by the refactoring accompanying the topic, it was a bit hard for me
to say if it is needless code churn or if it is a good refactoring.

I wonder if this change can be a good demonstration to measure the
goodness of it.  IOW, how would these two patches look if rebased on
the result of merging b6049542 to today's 'master'?  Would it make
these two patches cleaner and easier to grok?


