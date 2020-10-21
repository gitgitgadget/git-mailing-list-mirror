Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A115C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A9D221F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t4++PFma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502241AbgJUSzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:55:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63304 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502103AbgJUSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:55:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 680327E7F5;
        Wed, 21 Oct 2020 14:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jDuZkMelPt3CITRkxy6tSm8TuyY=; b=t4++PF
        maL00KtO6RNmialaOMn/sHbGUaHnDPvhoY6OgK8sOfVP7LARXUxdHyXREm5vBuBP
        kTnHCnSkiUpTI5s61G2xCgbfblwzlI3bJA7mnungJA7KzAH6EjjoLYe7QMb3rCMX
        UKuO0Zt3qFfQtCuuv+zlx0JlMlBwiH43aaYJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mdTpucYCeLPNAmKGZUJgAbJURY2OSnc3
        m/fvR+3ovM9+jM8BIImwl3LJQU07R9kHt/uM2ZfRJuZnMZx1XzSZiyKrZYd3UrPY
        lZ+5y7Zx6HxX2HgEY3VDX8tUdnTmic3Xwcoi1qs+eN9ElED9mONsM4V7qvWQxoaW
        7QXJcW9tE4I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EB567E7F4;
        Wed, 21 Oct 2020 14:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4BC47E7F1;
        Wed, 21 Oct 2020 14:55:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nathaniel@google.com,
        rsbecker@nexbridge.com, sandals@crustytoothpaste.net,
        santiago@nyu.edu
Subject: Re: [WIP v2 1/2] Adding a record-time-zone command option for commit
References: <xmqqk0vtki66.fsf@gitster.c.googlers.com>
        <20201021050146.3001222-1-shengfa@google.com>
Date:   Wed, 21 Oct 2020 11:55:20 -0700
In-Reply-To: <20201021050146.3001222-1-shengfa@google.com> (Shengfa Lin's
        message of "Wed, 21 Oct 2020 05:01:46 +0000")
Message-ID: <xmqqzh4f76jr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7F10286-13CE-11EB-94C6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

> Thanks for the comments and sorry for not describing the design.
> I will add it here.

Thanks.  Please do not forget to add it to the updated patch, too.
That's where it matters most---you do not necessarily have to
explain things to _me_, but you should, to everybody who will read
"git log" in the future in order to understand what we did and why.

> First, I would like to use a "global" variable to keep track of whether
> record-time-zone is set and default to true. Then in various places such
> as commit, pull, merge and rebase; we can add command option that can
> modify this value.
>
> Then in datestamp in date.c, we can check this value; offset would be
> initialized to 0 and only be set if record_time_zone is true. Additionally,
> date_string from the same file would take an extra argument to indicate if
> we want to use nagative sign for zero offset. Then the timestamp along with
> sign and 4 digits offset would be stored in "git_default_date" as buf
> "1603255519 -0000". I think of this as the "encoding" step.

Yes, we could check it in datestamp(), but ... 

> Initially, I thought this would be sufficient to show "-0000" in commit log
> message. However, I found that the show_date function is used for "decoding";
> converting timestamp and tz to more readable format. Then I realize the
> function won't distinguish between +0 and -0 as it only takes in a tz as
> argument. As a result,...

... I would have imagined that you do not have to deal with all
those complications if you don't hook this to such a low level of
the call graph.  That is why I wondered:

>> I may be totally off, ... but wouldn't it be just the
>> matter of touching the single callsite of datestamp() in ident.c, so
>> that after it gets git_default_date string filled, null out the last
>> 5 bytes in it with "-0000" if record_tz is off?

Without any change to datestamp() you made in the patch, the call to
the function from ident.c may give us back a string that ends with
the integer that is the number of seconds since epoch, and sign plus
4 digits, e.g. +0900 or -0800, that would reveal the true timezone.
I would have thought that these five bytes can be replaced with
-0000 under some condition (including "the global is set" which is a
sign that the feature is being used, but not limited to that one---
we may need to make sure the call to ident_default_date() to fill
git_default_date.buf is done on behalf of the user to get a new
timestamp to record the user's activity, not doing something like
"git commit -C <existing commit>").  I do not immediately see a
reason why such a change near the surface level, which does not
disrupt the workings of the code at lower levels, would not work.

Thanks.



