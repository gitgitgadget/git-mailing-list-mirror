Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A90C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA44D64E6D
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 18:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhBHSau (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:30:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54986 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbhBHS35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 13:29:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE1F411B925;
        Mon,  8 Feb 2021 13:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FcDORtB2bWV3TRQC2NMjrJfqXzs=; b=rAdlAc
        0EratP9Tiv9eVa8ty2wFto3ik3l1H+Ek2AEW+6niI48KmbQMy54WbyyNscdYAvEc
        Lr3eBvYWh77xwr/6D5YnKZBhzTvfJviEtibpCJG7tfZNORS2v5OCVSz6XfK8Dz10
        ADFilE+RgHylfgM+u+fk+vy9CWIG/A1wZnXc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jLxF3dJ6o3tZC5jTdGjHJrCgCGhv5yN0
        sFPa5ydz7cFVW803+qI/h0dRrBVKw1XJqcQX2RwiArhUS+3IgcNuH0AmPmENWTd6
        Ug5ja0kXvClfmJHD/KZ7aPhlDbvutZvoDwo9c9SI/e+f6WMHJkB6yMfgL3IH6W38
        XR3IA+A+J5U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7F1811B924;
        Mon,  8 Feb 2021 13:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1CF3F11B922;
        Mon,  8 Feb 2021 13:29:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
        <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
        <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
        <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
        <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
        <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
        <CA+CkUQ_cdUmuP+_yUeCytn=6cc8SjMBE1aTLzWJL-U_V01uzog@mail.gmail.com>
Date:   Mon, 08 Feb 2021 10:29:08 -0800
In-Reply-To: <CA+CkUQ_cdUmuP+_yUeCytn=6cc8SjMBE1aTLzWJL-U_V01uzog@mail.gmail.com>
        (Hariom verma's message of "Mon, 8 Feb 2021 22:37:38 +0530")
Message-ID: <xmqqv9b25s7f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8923179A-6A3B-11EB-A48E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> I suspect that "fix" for "log --pretty" isn't going to work here.
>
> Even if we apply the same "log --pretty"'s fix here. I think we still
> end up having an empty blank line between each ref item.

After sleeping on it and seeing a result of an experiment like
this one, I think that might be unavoidable.

    $ git for-each-ref \
	--format="One%0a%(trailers:key=Signed-off-by:)Two%0a" \
	refs/heads/js/range-diff-wo-dotdot
    One
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    Two
    $ exit

People who write such "Two" without prefixing it with a newline
"%0a" themselves may view such a "fix" a regression.

It is sad that this %(trailers) itself is relatively a new thing,
and I had thought that all the other ingredients are designed to
strip the trailing newline, e.g. try this:

    $ git for-each-ref \
	--format="%(subject)%0a%(trailers:key=Signed-off-by:)" \
	refs/heads/js/range-diff-wo-dotdot
    range-diff(docs): explain how to specify commit ranges
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Notice that %(subject) is followed explicitly by %0a.  I think
%(author:date), etc. would do the same.  But %(trailers) behave
differently, and that is because it expects to be multi-line and
perhaps to mimic %(body)?  In any case, it may be too late to change
its behaviour.  At least I do not think of a good waoy to do so.

By the way, when merged to 'seen' (you can try the above that shows
%(subject) followed by %(trailers) with the tip of 'seen'), it dies
like this:

    $ git for-each-ref \
	--format="%(subject)%0a%(trailers:key=Signed-off-by:)" \
	refs/heads/js/range-diff-wo-dotdot
    free(): double free detected in tcache 2
    Aborted

There must be some interaction with another topic but I didn't dig
deeper.

Thanks.

