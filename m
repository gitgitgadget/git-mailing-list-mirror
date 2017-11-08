Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4691F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 01:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdKHBg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 20:36:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750920AbdKHBgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 20:36:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C539B016F;
        Tue,  7 Nov 2017 20:36:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jqzo8L/wk0I3/19wZYr7JHrdoLk=; b=jukuGC
        Z1Qs0ZsStj8nGRmtuvSo5mJmdcvplAy77WDlA8gG7RH1kR8VCFfeQVLiP/BAPRYp
        MhmWP18JFcFexUJZKHCSX73Ps3I4EFnBHTsPMTUjUQSsxxicUOtVCyt0kfvbh8ti
        MGCEo4atS4ptaaamDwXtpZZDZ+YNBC3bBmIP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j16OkPyf1K2GoDXqQgc5fWSVGdK8d2N7
        Jk1MGca8XMul6pfmM5zjRavuz+bMSQSnlfgG9Ea1V2FT32IXpOFgtcdxF/+Mr690
        1Ia3KBU4NrTKmevD2b/DuFisFBW/iPU2guARadkUHeS8ICufG7FO3j1XaU+OT5qV
        YPsyhnHFhF0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 447D4B016E;
        Tue,  7 Nov 2017 20:36:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9364B016C;
        Tue,  7 Nov 2017 20:36:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v3 0/3] for-each-ref: add :remoteref and :remotename specifiers
References: <cover.1507205895.git.johannes.schindelin@gmx.de>
        <cover.1510072200.git.johannes.schindelin@gmx.de>
Date:   Wed, 08 Nov 2017 10:36:52 +0900
In-Reply-To: <cover.1510072200.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 17:30:52 +0100 (CET)")
Message-ID: <xmqqwp31mtzf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CB31734-C425-11E7-B6A9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v2:
>
> - fixed the commit message of 1/3 to no longer talk about :remote.

OK.  It now matches what we have had since October 5th in my tree.

> - used the push atom in 2/3, made the code look more as suggested by Junio.

I am pleasantly surprised (mostly because I didn't realize that the
code has already prepared all the info necessary to do this in the
atom enumeration phase) that this change was quite easy and doably
very cleanly.

> - fixed the oneline of 2/3 to use a verb ("report").
>
> - butchered Junio's proposed documentation update for 2/3 to hopefully make
>   the description of :remotename and :remoteref a lot clearer.

Well I wasn't attempting to propose anything---as I said, I couldn't
concisely phrase what the description in v2 wanted to say in clearer
terms, so I gave a lengthy and fuller description.

It feels a bit out-of-place to see "can be updated" in the
description of a read-only operation for-each-ref, as we see below:

>  -Also respects `:remotename` to state the name of the *remote* instead
>  -of the ref, and `:remoteref` to state the name of the *reference* as
>  -locally known by the remote.
>  +For any remote-tracking branch `%(upstream)`, `%(upstream:remotename)`
>  +and `%(upstream:remoteref)` refer to the name of the remote and the
>  +name of the tracked remote ref, respectively. In other words, the
>  +remote-tracking branch can be updated explicitly and individually by
>  +using the refspec `%(upstream:remoteref):%(upstream)` to fetch from
>  +`%(upstream:remotename)`.

but I think this should do for now.  It certainly is much clearer
than the previous round.

Will queue, and merge to 'next' soonish.

Thanks.
