Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170F51F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965350AbdGTVi5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:38:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58584 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965050AbdGTVi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:38:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8B098E158;
        Thu, 20 Jul 2017 17:38:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/+t3j6h/a/FcisLTc+/PUcPkj/M=; b=x9uekU
        eUUyvWa4MSTGd5ww3Bp8CdMMq4zs7xVN1vvTSa9dsdE7lF08/ATKAozViBFVM7fJ
        6TVEj7aJb234P8Dfx9bNTw2RyYnp9aYNrXVg8CEV3ySJlVb7PMPemC5u0mpfP+sq
        3BXIEMMaPBHBSCdDCe9BLcUSG4s1UGODYSTqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CadyFrJqA1zLc6bvTa+jjiVt4lHRFRTt
        elfevMzhZ5fp3AmtGmS/DxpPzCNq2afRkjr7nCNruoCzLKT9sSoPZayTtiV5lKYh
        pv19mCBmmwY9L6tf3pB2wctYtyWizHzQZJ/9yMQ0x1FRl0Kq641H+cPxH+z36sfA
        YOQwp25dvBg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C18748E157;
        Thu, 20 Jul 2017 17:38:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177A08E156;
        Thu, 20 Jul 2017 17:38:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v6 00/10] The final building block for a faster rebase -i
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
Date:   Thu, 20 Jul 2017 14:38:46 -0700
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 14 Jul 2017 16:44:32 +0200 (CEST)")
Message-ID: <xmqqfudqkcux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D06180EA-6D93-11E7-8376-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v5:
>
> - replaced a get_sha1() call by a get_oid() call already.
>
> - adjusted to hashmap API changes

Applying this to the tip of 'master' yields exactly the same result
as merging the previous round js/rebase-i-final to the tip of
'master' and then applying merge-fix/js/rebase-i-final to adjust to
the codebase, so the net effect of this reroll is none.  Which is a
good sign, as it means there wasn't any rebase mistake and the evil
merge we've been carrying was a good one.

But at the same time, I prefer to avoid rebasing to newer 'master'
until the codebase starts drifting too far apart, or until a new
feature release is made out of newer 'master'.  This is primarily
because I want dates on commits to mean something---namely, "this
change hasn't seen a need to be updated for 'oops, that was wrong'
since this date".  This use of commit dates as 'priority date'
matters much less for a topic not in 'next', but as a general
principle, my workflow tries to preserve commit dates for all
topics.

For the above reason, I may hold onto this patch series in my inbox
without actually updating js/rebase-i-final topic until the current
cycle is over; please do not mistake it as this new reroll being
ignored.

Thanks.
