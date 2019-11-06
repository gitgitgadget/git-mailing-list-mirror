Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1F21F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfKFBak (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:30:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55207 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfKFBak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:30:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 505D4A0AA5;
        Tue,  5 Nov 2019 20:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nio/e6nnA1v4hffxep9RkFHDfN0=; b=LH1F1h
        7czPQWRYj0ihr39ikPhG0hcDLilI42zStB1jBd66NcBb9IBrQzmyrJzyibNvHbJ8
        F77xzyYnnt4BsQGEHnjJRmyBdrTGqb/tBWUqgBZ7D4OkqcM2TQT3Hg5KG3bqeWVT
        5iir2XzaFKXn1XvS1cAwynDI0SlqC+VPytfEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XJRt+LZYHc+R2UJtpRYtbCMrAraO6wvI
        xC9l2Bck88O8pFOsclI+/knZqS9+b1TW7SFKTNDbJKfmDAT7TBQdd+zfXKLfJ1z/
        z+3JOY/aGBNK7gI6rtsUbLK0egOVlBpLqYW4QPcajXJFYtYGmij1p1AD80o8LpXO
        7/bb0iwAapk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 484ACA0AA4;
        Tue,  5 Nov 2019 20:30:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74A78A0AA3;
        Tue,  5 Nov 2019 20:30:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange rebase's todo list
References: <20191031092618.29073-1-congdanhqx@gmail.com>
        <cover.1572596278.git.congdanhqx@gmail.com>
        <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
        <20191101165921.GD26219@sigill.intra.peff.net>
        <20191102010215.GB17624@danh.dev>
        <20191105080010.GA7415@sigill.intra.peff.net>
Date:   Wed, 06 Nov 2019 10:30:34 +0900
In-Reply-To: <20191105080010.GA7415@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Nov 2019 03:00:10 -0500")
Message-ID: <xmqqftj1yeo5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 088CD650-0035-11EA-B393-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That's normally what we do. The only cases we're covering here are when
> somebody has explicitly asked that the commit object be stored in
> another encoding. Presumably they'd also be using a matching
> i18n.logOutputEncoding in that case, in which case logmsg_reencode()
> would be a noop. I think the only reasons to do that are:
>
>   1. You're stuck on some legacy encoding for your terminal. But in that
>      case, I think you'd still be better off storing utf-8 and
>      translating on the fly, since whatever encoding you do store is
>      baked into your objects for all time (so accept some slowness now,
>      but eventually move to utf-8).
>
>   2. Your preferred language is bigger in utf-8 than in some specific
>      encoding, and you'd rather save some bytes. I'm not sure how big a
>      deal this is, given that commit messages don't tend to be that big
>      in the first place (compared to trees and blobs). And the zlib
>      deflation on the result might help remove some of the redundancy,
>      too.

Perhaps add

    3. You are dealing with a project originated on and migrated
       from a foreign SCM, and older parts of the history is stored
       in a non-utf-8, even though recent history is in utf-8

to the mix?

> The two-part user-format thing goes back to 7e77df39bf (pretty: two
> phase conversion for non utf-8 commits, 2013-04-19). It does seem like
> it would be cheaper to convert the format string into the output
> encoding (it would need to be an ascii superset, but that's already the
> case, since we expect to parse "author", etc out of the re-encoded
> commit object). But again, I have trouble caring too much about the
> performance of this case, as I consider it to be mostly legacy at this
> point. But I also don't write in (say) Japanese, so maybe I'm being too
> narrow-minded about whether people really want to avoid utf-8.

I suspect even the heavy Windows/Mac users in Japan have migrated
out of legacy (the suspicion comes from an anecdote that is offtopic
here).
