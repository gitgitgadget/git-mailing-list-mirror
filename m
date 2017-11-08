Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3F11F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 01:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbdKHBot (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 20:44:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751021AbdKHBos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 20:44:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB64BB8316;
        Tue,  7 Nov 2017 20:44:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mhG3FGnvmrBEmfirdhp9j9z+nEo=; b=ZEbIM6
        0AlgTWnlRsf02NxGkUJi6JDHbjm14JAo9cIqeNL68qzOC/JQYcUmGn/V9QzDsA67
        7PqUncQT1NjwwdW+81NE7SaRwABz9BmuhY6bMbRz/5ot1JqZQoDg6+PwNqpKDAWX
        iI9xjwiCiMyW0NEpu8NYFqoiUgL1ehYUCnPjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k3qRaQ1R6J0Lkv89/mzs3ieYRoDucwPW
        O4t+tfvwcWlohWAKW0EgJSz6eHN8EiRGEiakmKhZrlg6Bhp4hQir7SFkr5LF/4g1
        k08wPFBdtXPHfvyQ49Dl25hfydMN742GW7Hxq7+HMdK3fU85J0opw82SI3J019Fp
        2blixHb1Wos=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C43C7B8315;
        Tue,  7 Nov 2017 20:44:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45E9DB8314;
        Tue,  7 Nov 2017 20:44:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 Outreachy] mru: use double-linked list from list.h
References: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
        <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
        <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net>
Date:   Wed, 08 Nov 2017 10:44:46 +0900
In-Reply-To: <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 2 Oct 2017 04:20:20 -0400")
Message-ID: <xmqqshdpmtm9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66F218D8-C426-11E7-A1AD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think there are a few ugly bits in the result (like that
> initializer for packed_git_mru :) ), so I'd prefer not to merge this
> down until we do that final step.
>
> So the big question is: who wants to do it?
>
> I think you've done a good job here, and this would count for your
> Outreachy application's contribution. But if you'd like to do that next
> step, you are welcome to.
>
> We could also consider it a #leftoverbits that perhaps some other
> Outreachy candidate would pick up[1].
>
> In the meantime, Junio, I think we'd want to queue this with the intent
> to graduate it to "pu" or possibly "next", but not "master". Then if
> somebody (Olga or another applicant) produces the endgame patch, we can
> queue it on top and move it further. And if nobody does, I can pick it
> after the application period is over.

So... do we still want to keep this in 'next', or does somebody
wants to do honors?  

I'd really prefer *not* to see you or me ending up finishing it up,
but at the same time, I really hate seeing a halfway or 3/4 done
topic hanging around in 'pu'.

> [1] For those who find this mail through the archive, there's more
>     discussion in this thread:
>
>       https://public-inbox.org/git/CAL21BmnvJSaN+Tnw7Hdc5P5biAnM5dfWR7gX5FrAG1r_D8th=A@mail.gmail.com/
