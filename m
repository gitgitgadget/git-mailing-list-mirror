Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF25420A2B
	for <e@80x24.org>; Thu, 21 Sep 2017 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdIUBXk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:23:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59746 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751000AbdIUBXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:23:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A872E92AC9;
        Wed, 20 Sep 2017 21:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0rZljh0/KgM3qSjbLplRhr8QMWM=; b=I++z0y
        XIVfLQ1M2cdx0SvJQizsxntukZEjgFENdiZYPAk8VN0CMIlZDjMFevtxBK1XEeRH
        ruvj29JI5SvUw5DEJK9dpVI3p8qIBru/J/vTorWb6a7PLjTyxphvHwjKFOjVLYSU
        34SrjOmAnSUL51G4R56bqug14MahQAxkManR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u9d6Xum19HFCUPB5PGQdxnA97lDgqwAX
        FgA6zIkk8fuAAFmGKjiy5xZGma0vDJ3iPn03jPN3ZVM0B1wQd/BQQFNXaE6E1N0k
        01Q4JWvHBoeN5EtJMnz+1WuuJ5Fc47z8ora9Gygunk2I4s/XPPrZZe9k2BKBPfxq
        1+CAeKG8xmU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A036492AC8;
        Wed, 20 Sep 2017 21:23:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E78F92AC7;
        Wed, 20 Sep 2017 21:23:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
References: <1505626069.9625.6.camel@gmail.com>
        <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
        <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
Date:   Thu, 21 Sep 2017 10:23:36 +0900
In-Reply-To: <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 20 Sep 2017 15:36:30 -0400")
Message-ID: <xmqqpoakn8tj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E98DE44-9E6B-11E7-9263-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I sketched out a possible solution in:
>
>   https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/
>
> though I share your concerns over whether people would be annoyed to see
> the existing "stash show" output changed.

Forgot about that one.  I sometimes do "stash show -p | apply", so
changing what is included without any option would be annoying, and
not having an option to restore the original behaviour would be
doubly irritating.  

Perhaps "stash show [--[untracked|index|worktree]]" to show only
one, without the "==> I am this variant <==" label, would be
workable, and with no option we would do --worktree that is the
traditional output.

In addition "stash show --all" could be the output in your earlier
patch.  I like the way it uses the '.' pathspec to squelch the
entire thing when there is no change ;-)

Thanks.
