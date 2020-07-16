Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9991AC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4467F206F4
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/GmZzDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgGPXum (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:50:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65433 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgGPXul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 19:50:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11C9AE9890;
        Thu, 16 Jul 2020 19:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tc3qybpC/2HBFtK9zKGoYSmXqtQ=; b=L/GmZz
        DbLrgZYIgLqMZYUCiHC/57/ghG6WHTLODe/TCZyBAfrLXCLVw40UuIYTBEqisQdw
        /dNd72miJXN+Bu1bDEezJ42qp3gLK7MHdfCXhpQwGRQDJ3gV1WSjCQHU3lIcEQsj
        7l5t09duFPyH/nGJ27m8kwqLcy4kQ1qR6avS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WdBo4KAP1M0+CaGiRjj8VbKAB8a+cap4
        7M7pLODU7WkYjWQJRJWkw9NoTyw3kWrM2or+QEY45VZnTlILt0LA5e5vTvc7Eh6W
        qXFFed5MUXiVaYYtdW6eRzO8KNlI+6IdTi24Q/DMVOZyRWRhIAncaTbwaXcdqJ4h
        1frzI1TmeRI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0956CE988F;
        Thu, 16 Jul 2020 19:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48387E988E;
        Thu, 16 Jul 2020 19:50:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200716062054.GA3242764@google.com>
        <20200716062818.GC3242764@google.com>
        <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
        <20200716110007.GD376357@coredump.intra.peff.net>
        <xmqqd04vigpy.fsf@gitster.c.googlers.com>
        <20200716223719.GA899@gmail.com>
Date:   Thu, 16 Jul 2020 16:50:34 -0700
In-Reply-To: <20200716223719.GA899@gmail.com> (Jonathan Nieder's message of
        "Thu, 16 Jul 2020 15:37:19 -0700")
Message-ID: <xmqqh7u7f29h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2516542A-C7BF-11EA-A3C5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> - defining the list of repository format v0 supported extensions as
>   "these and no more", futureproofing along the lines suggested in
>   Peff's patch.  I like the general approach taken there since it
>   allows parsing the relevant config in a single pass, so I think
>   it basically takes the right approach.  (That said, it might be
>   possible to simplify a bit with further changes, e.g. by using the
>   configset API.)
>
>   When doing this for real, we'd want to document the set of
>   supported extensions.  That is especially useful to independent
>   implementers wanting to support Git's formats, since it tells
>   them "this is the minimum set of extensions that you must
>   either handle or error out cleanly on to maintain compatibility
>   with Git's repository format v0".

Good.

> - improving the behavior when an extension not supported in v0 is
>   encountered in a v0 repository.  For extensions that are supported
>   in v1 and not v0, we should presumably error out so the user can
>   repair the repository, and we can put the "noop" extension in that
>   category for the sake of easy testing.  We can also include a check
>   in "git fsck" for repositories that request the undefined behavior
>   of v0 repositories with non-v0 extensions, for faster diagnosis.
>
>   What about unrecognized extensions that are potentially extensions
>   yet to be defined?  Should these be silently ignored to match the
>   historical behavior, or should we error out even in repository
>   format v0?  I lean toward the latter; we'll need to be cautious,
>   though, e.g. by making this a separate patch so we can easily tweak
>   it if this ends up being disruptive in some unanticipated way.

I disagree with your first paragraph.  Those that weren't honored by
mistake back in v0 days, in addition to those that aren't known to us
even now, should just be silently ignored, not causing an error.

> - making "git init" use repository format v1 by default.  It's been
>   long enough that users can count on Git implementations supporting
>   it.  This way, users are less likely to run into v0+extensions
>   confusion, just because users are less likely to be using v0.

Absolutely.  I would think this is a very good move.

> Does that sound like a good plan to others?  If so, are there any
> steps beyond the two first patches in jn/v0-with-extensions-fix that
> we would want in order to prepare for it in 2.28?
>
> My preference would be to move forward in 2.28 with the first two
> patches in that topic branch (i.e., *not* the third yet), since they
> don't produce any user facing behavior that would create danger for
> users or clash with this plan.

Yup, I agree.  I'd give another name to the third commit and then
rewind jn/v0-with-extensions-fix by one to prevent mistakes from
happening.  Thanks.


