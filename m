Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C561F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 07:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfKMHMj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 02:12:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55735 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKMHMj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 02:12:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60B5AA5DC1;
        Wed, 13 Nov 2019 02:12:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xK4K2BOLNVIQH72mRl3Q6xAK+/A=; b=Nm+9k9
        p3jeVQm/+KYCBxsD/3/78VN94fGugXvJi3k89Sgi3H2TBccuX32BxCt/kBuLvzqz
        wf12d0G/Q24O4N3gNZwQPyp5Q7KLsM3S+2SnQVTkHS4CmN+1XDLUUYQayGh3yWBx
        UULRdfU62ybUgM+xhGFSexZLaH8XOQg0sG5C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=onf6iAeAfPD4+V6TmwF46Nbx5DmsrSTe
        xSJMbL0Q1zhkZilAEjW/uE1P0yDoX5c3G9TIh93kUgAHfg8TkSFzI6k7eeACo8Hv
        jPL3P8GkDUKCQ1PI+y0nGnOeoADQ9eMHesKBnt6FfhtkdazuPBakMV0b3+udEaTf
        po4/tDCz8dk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5940BA5DC0;
        Wed, 13 Nov 2019 02:12:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87361A5DBE;
        Wed, 13 Nov 2019 02:12:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mateusz Loskot <mateusz@loskot.net>, git@vger.kernel.org
Subject: Re: Merge commit says refs/heads/<branchname> instead of <branchname>
References: <CABUeae82_qQrR5s_QYsDzkVX6CeVM-B7pT5DZt_BjpL=KJdtBg@mail.gmail.com>
        <20191113051530.GA3547@sigill.intra.peff.net>
Date:   Wed, 13 Nov 2019 16:12:32 +0900
In-Reply-To: <20191113051530.GA3547@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Nov 2019 00:15:30 -0500")
Message-ID: <xmqq8sokb673.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F72AEC02-05E4-11EA-B1D1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If I do:
>
>   git reset --hard tip && git merge --no-edit refs/heads/side
>   git log -1 --oneline
>
> then I get:
>
>   Merge branch 'refs/heads/side'
>
> And the behavior seems the same going back to older versions of Git. Are
> you sure your workflow hasn't changed somehow?
>
> Can you show an example that triggers the behavior for you?

Yes, I am curious, too.

>> I'm failing to find in the docs what drives that change, what
>> configuration option controls such (default?) message.
>> 
>> What may be the reason of that change?
>
> I think any change there would probably be unintentional (but it's hard
> to say for sure without tracking it down).

If older versions of git produced "Merge branch 'side'" when told to
merge 'refs/heads/side', I could sort-of believe it.  And if we no
longer do so and instead record "Merge branch 'refs/heads/side'",
then I actually think that is a desirable change.

By the way, pulling from self follows slightly different rule, i.e.

	$ git pull . refs/heads/side

would likely give you "Merge branch 'side'".



