Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DADC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34DA264DE7
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBKAgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:36:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62156 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBKAgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 19:36:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C2351174EA;
        Wed, 10 Feb 2021 19:35:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CRVYTZB7GjAxfxoVVwSIi6Ur9IQ=; b=HWpyG4
        1MpmxYZenwhK0UUprhBK+N2xm888P9inckf7pe663bgP3kzTuYe4Vzl+hPINTjAc
        Fe8a0zNwd7+NpCXRSzyMG305bvf1n2RgXj9qoDGSsPNwxXh4i8pjaHk65usyx9Hy
        rln/pTkXHIloS+w+63Co1b6j6vPy+bLllQ8go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NR+OYm9eU0onrP2GyfqMKGEtLkYA3Jtk
        78DkeHaXHp2/t/igDABBJHwrnUp50SK1RtdLezcWPXqF/pWmQ7xJzKHBTeO6kRSK
        /E+zpqBlS200xFz+Qw/l9XA0yTa118QIm7HzFYoOifP7x+gwZsMQ0hCl2PDMFzmU
        Rj6n6ivovzw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64D111174E9;
        Wed, 10 Feb 2021 19:35:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D17241174E8;
        Wed, 10 Feb 2021 19:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify that refs/notes/ do not keep the attached
 objects alive
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
Date:   Wed, 10 Feb 2021 16:35:16 -0800
In-Reply-To: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
        (Martin von Zweigbergk's message of "Wed, 10 Feb 2021 16:00:21 -0800")
Message-ID: <xmqqo8grzbjv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C1908C-6C01-11EB-947B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@google.com> writes:

>  ... In particular, it will keep not only
> +objects referenced by the index, remote-tracking branches, reflogs
> +(which may reference commits in branches that were later amended or
> +rewound), and anything else in the refs/* namespace. Notes saved by
> +'git notes' under refs/notes/ will be kept, but the objects (typically
> +commits) they are attached to will not be.

The notes will not contribute in keeping the objects they are
attached to.  As long as the objects have some paths from refs and
reflog entries (reachability anchors), they will be kept.  These
two are facts.

But I am afraid that the new phrasing can be misread as saying that
an object, if it has notes attached to it, will not be kept, period.

Knowing Git, we can tell immediately that it would be a nonsense
behaviour, but still, I think that is how it can be read, so I
suspect that the new text would invite a misunderstanding in the
opposite direction.

    ... and anything else in the refs/* namespace.  Note that a note
    attached to an object does not contribute in keeping the object
    alive.

would be less misinterpretation-inducing, perhaps.

We could go further to explain by adding something like that
immediately after "keeping the object alive" above, e.g.

    ---when an object becomes unreachable (e.g. a branch gets
    rewound, a commit gets rewritten) and eventually gets pruned, a
    note attached to the object will become dangling (use "git notes
    prune" to remove them).

but I am not sure if that is necessary.  Pruning notes attached to
objects that are pruned may be relevant in the context of discussing
"git gc", I guess.

> +If you are expecting some
> +objects to be deleted and they aren't, check all of those locations
> +and decide whether it makes sense in your case to remove those
> +references.
>  
>  On the other hand, when 'git gc' runs concurrently with another process,
>  there is a risk of it deleting an object that the other process is using

Thanks.
