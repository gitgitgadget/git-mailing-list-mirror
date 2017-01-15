Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BECC20A17
	for <e@80x24.org>; Sun, 15 Jan 2017 02:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdAOCuc (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 21:50:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55589 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750780AbdAOCub (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 21:50:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF7F61274;
        Sat, 14 Jan 2017 21:50:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b0Ez8o1gHXC+Nyq8QvjvWu751Ik=; b=BhloAK
        TbCHO4Q4CXVejeoHwGgyult1oq1VpVzHEArGHKSkaRdcib0NLEkiP/4Mnr3ySkeJ
        o/y252cZaXan4Q+hC+M6vHFj5ZXhiHRzBFj+HVB6xPsTIMgmISys9hvoxu9njFG3
        /PhOkhp4il0BvzqHFNAYN3Y8VPvVvBw4iR0eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=leurn6PgR4b8ISCwN6gha7EcCtaPXx2J
        qzM7xcQaGKQxNXfg+/eY0rIgHrZnQwBkjOxp2fFclRWOKXC+woDCnEJZhlgz+lKw
        xjeqDOwnFjNWCIM0iIopAGaaaPOx2LAMyDF5sAGmKP9w8CRMEB5J94eXjLPRhCti
        uEYXFIY2zLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0382761272;
        Sat, 14 Jan 2017 21:50:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DCDD61271;
        Sat, 14 Jan 2017 21:50:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's backend
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701141857270.3469@virtualbox>
Date:   Sat, 14 Jan 2017 18:50:28 -0800
In-Reply-To: <alpine.DEB.2.20.1701141857270.3469@virtualbox> (Johannes
        Schindelin's message of "Sat, 14 Jan 2017 19:04:28 +0100 (CET)")
Message-ID: <xmqqmvetc9zf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FEE6160-DACD-11E6-A380-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The problem in this instance was that the authorship is no longer retained
> when continuing after resolving a conflict. Let me stress again that this
> has not been a problem with v1 of sequencer-i, nor with v2. The regression
> was caused by changes required by the code review.
>
> In case you wonder: Yes, I am upset by this.
>
> -- snipsnap --
> Subject: [PATCH] fixup! sequencer: make reading author-script more elegant

I do not think anybody asked to make the code "more elegant".  Quite
frankly, I do not expect elegance in your code (or any of the code
in our codebase, for that matter).  What we want is readable code
that does not make the overall codebase less maintainable that is
correct.  Not reinveting a new codepath when there is already code
that does the thing is one of the things that we may need to do, but
that was not done between these rerolls.

Of course, when trying to share code, the existing code we have that
the new codepath needs to borrow would have to be refactored and
extended, and a new bug can sneak in during the process.  If that
were what happened, I would be a bit more sympathetic, but I suspect
that this "more elegant" thing that needed fix-up is not that.

You may be upset, but I cannot quite bring myself to feel sympathy
in this particular case.





