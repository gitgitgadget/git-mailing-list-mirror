Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D13620C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbdK0Xjo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:39:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54983 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751731AbdK0Xjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:39:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 611E296A12;
        Mon, 27 Nov 2017 18:39:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i0zXfA5A+T+jKCy1dWxn0UadfVg=; b=nDTWTM
        RBvUOcZkGshdBrzk9EnZGnm7e6jYKJW3YzQfFCSZfsFl2hbQdP6VowOsA4vscYCu
        mBaiemff3TIYmFDKrXb/1wTOP8x00vc9Z2oVEQYebP+by8Xlg6X10eeAAW7jUQ1H
        FejBE5U4lf4BbOQtPV31Y/VJvvMzcq2sDgunI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l8HgotfnjW2H+xEu+sPH3sscgKPm9tlo
        43xnzQg5TJowLwaBm9v2rMQE6n015IdhUP+XRpx+OG3zSfhiT9zAfNfXhRIieltw
        HR7iHaB6mXA5W0FYVs+xF5N8zfaidYwwa4OAUsbrMqOL3TntFLjqQ9FMZq8Zc9ct
        rxWPJio2mRo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AAC96A11;
        Mon, 27 Nov 2017 18:39:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C343C96A10;
        Mon, 27 Nov 2017 18:39:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
References: <20171124195901.2581-1-newren@gmail.com>
        <xmqq4lpgfkyb.fsf@gitster.mtv.corp.google.com>
        <CABPp-BELci79tuiPFVRKQwm_-j6tN-DxqcKsvjD2xG_8ZWNxGw@mail.gmail.com>
Date:   Tue, 28 Nov 2017 08:39:41 +0900
In-Reply-To: <CABPp-BELci79tuiPFVRKQwm_-j6tN-DxqcKsvjD2xG_8ZWNxGw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 27 Nov 2017 08:40:17 -0800")
Message-ID: <xmqqshcz9tqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E2F1F12-D3CC-11E7-A007-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> As a fix, this sorely wants something new in t/ directory.
>
> Well, then perhaps I was wrong to submit it independent of my
> directory rename series.  As noted in the (very lengthy) extended
> commit message explanation, the assumption the previous code made just
> happened to work ...

Here is what I wrote in What's cooking draft (which automatically
gets copied to the merge log message and becomes part of release
notes when a topic graduates) for this thing.  Am I on the right
track?

    The code internal to the recursive merge strategy was not fully
    prepared to see a path that is renamed to try overwriting another
    path that is only different in case on case insensitive systems.
    This does not matter in the current code, but will start to matter
    once the rename detection logic starts taking hints from nearby
    paths moving to some directory and moves a path that is otherwise
    not changed along with them.

