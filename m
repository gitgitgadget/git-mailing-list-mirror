Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125771F453
	for <e@80x24.org>; Thu, 25 Apr 2019 04:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfDYECt (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 00:02:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54287 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfDYECt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 00:02:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 537546A415;
        Thu, 25 Apr 2019 00:02:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k4iDRSME9gvJ2jXJgu8qHfW7DJ0=; b=qF9x6Y
        6B9omnITtYqOhfm9UXzv7AzjUr/hHNDEgNySs5GRD5jeZASa/H1hG5SLa9a2z2bK
        xxmk2a9g1J1leZqReYsJpGFpTUv+TLMWm9FuFHgS099bnrGwu14sJ8Xr9pU11IMn
        tOA6I0E12+S0QGfwrC2snFlpcUn4Ow/oeG8cE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gux9cxbUOwvG4L/H8ez2Elaf6OogRFiz
        I5FZwCpuKB7qUhoe/YxWo/ZHGxWSDTbZu+ejJkDgzWTm1wVNzAXR/I3nOVIET6Kf
        n+qLqVqC9uQ1JWHkRhNak+uLL3imSe6XTqX67RqAuJaaCsQuabR/UtOKOcVHj5gW
        W/V5137yUu4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D7A86A414;
        Thu, 25 Apr 2019 00:02:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FB396A413;
        Thu, 25 Apr 2019 00:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sitaram Chamarty <sitaramc@gmail.com>
Cc:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
        git@vger.kernel.org
Subject: Re: Checkout file without changing index?
References: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
        <xmqq5zr31poo.fsf@gitster-ct.c.googlers.com>
        <005b0aed-2c20-0c91-e4ad-98b0ec39359d@gmail.com>
Date:   Thu, 25 Apr 2019 13:02:44 +0900
In-Reply-To: <005b0aed-2c20-0c91-e4ad-98b0ec39359d@gmail.com> (Sitaram
        Chamarty's message of "Thu, 25 Apr 2019 09:10:50 +0530")
Message-ID: <xmqqv9z2ybob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBED9106-670E-11E9-95AB-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sitaram Chamarty <sitaramc@gmail.com> writes:

> I'm not in a position to use either of those on at least some of my
> systems, but meanwhile, I thought I'd ask this: what is the difference
> between this and "git show REF:PATH > PATH", in terms of side-effects.
>
> (I.e., any differences other than looking cleaner, not having to repeat
> "PATH" etc.)

For that matter, what's the difference between these two and

	git cat-file --filters REF:PATH >PATH

;-)

I think the major difference is that checkout and restore are facing
an end-user who is typing the command to the terminal interactively,
so it does not make it easy to deposit the contents to an arbitrary
path while taking pathspecs to allow multiple files to be checked
out.  On the other hand, these "get content for a single path out of
the odb and then write it out to wherever I want to" may be more
suited for scripting.

Between the two that are for the-content-at-a-single-path, I would
further expect "git show REF:PATH" output would be less reliable
over time, as we reserve the right to add frills to the output from
the command to make it a more pleasant experience to humans (e.g. it
is not totally inconceivable for the command to notice "ah, this is
a JavaScript source file, so let's pass it through a syntax-aware
highligher), as opposed to placing more emphasis on the byte for
byte fidelity, which is desired for components used in scripts.
Those who would want the latter should be using the plumbing
cat-file.
