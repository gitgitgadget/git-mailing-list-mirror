Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E0A20958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756057AbdCWQEj (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:04:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56146 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754542AbdCWQEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:04:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D9389F2B;
        Thu, 23 Mar 2017 12:04:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5vKdI1T1FB5U8bkYhCXSqNftTDk=; b=ZJ+LcN
        ekI4eOhqruW4wS6vyYphWkK6lKj/xKW80bPxYPCPDu6O2Y9XG77QIUkfsWCFaiTp
        Qm5ZSHUGIHIJaejKtJcRhkJG7x7iMwaF23wxLls/7xVxfMuqV40aNSaqlKYFOmBP
        H/7eBtZGBgK0IsQ1ZR7uwtQ8OLU2g3N7s0d08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWB9WOby+p0g/uXHeBCztv5UFopHH4ca
        podrnhG1XNzijmHuY60DWjY9hjEKnHSxWuA6BLW2cZYP1DsbYBbGI62Iddbh/k+j
        JvjfQtGI/zbIaSq+K0Dq0i0vBPAhh1IKVVvh8w6H2/65v43JWst1de/RbWbnmFob
        s2qDcznq8QE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B7C789F2A;
        Thu, 23 Mar 2017 12:04:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA24689F29;
        Thu, 23 Mar 2017 12:04:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] sequencer: make commit options more extensible
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <c0c836e1f1739af25ad875419ee6125b53ac6a1a.1490194846.git.johannes.schindelin@gmx.de>
Date:   Thu, 23 Mar 2017 09:04:34 -0700
In-Reply-To: <c0c836e1f1739af25ad875419ee6125b53ac6a1a.1490194846.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 22 Mar 2017 16:01:53 +0100
        (CET)")
Message-ID: <xmqqa88cf08d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69239AC6-0FE2-11E7-BC3E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It was pointed out during review of the sequencer-i patch series (which
> taught the sequencer to execute an interactive rebase) that it may be
> cumbersome to keep extending the signature of the run_git_commit()
> function whenever a new commit option is needed.
>
> While that concern had merit, back then I was reluctant to change even
> more than was already asked for (which typically introduces regressions,
> this late in the review process, which is no fun for nobody).
>
> Now, with fresh eyes, and with an actual need, is a good time to change
> the strategy from adding individual flag parameters to coalescing them
> into a single flags parameter.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I think the first two paragraphs are not about explaining this
commit.  You do not have to justify the past---some suggestions
given during the review may end up not getting followed for
different reasons, which may be good or bad, but what happened has
happened, and the backstory is not useful for understanding why this
is a good change to a reader of "git log".

What belongs to the explanation / justification for this change is
that the interface to run_git_commit() that forces to add one
boolean parameter whenever a new "switch" is required is cumbersome
and it is better to use a flags word that is a collection of bits.
When you reroll this for s/signed int/unsigned int/, please just
describe that in the log. Having the backstory under three-dash
lines may help reviewers who remember the original topic that
introduced the maintenance burden this commit fixes.

Thanks.
