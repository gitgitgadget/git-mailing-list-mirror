Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87463E81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjJFSBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJFSBq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:01:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3DDB
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:01:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71C17266FC;
        Fri,  6 Oct 2023 14:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/3HxOV8PMpUgU0/WnjSMzZi8HdPu0APP5Y87lq
        fvRLY=; b=DzS9116fhD96ttQWx9CeZOdWKjcnqcMbiB1LSMHM73t3+hdq4C3l3a
        CrFnMRaXoMcsY+Wu5F7QHce6n99BrDhBrY3jt/7mLAPpn1msef6IBXEaZM3zicRg
        XfmTpxJ341wHX1pJoNBnNMaSVNhemD0/4cy2p9XNEZ2xXY+Fx2ZiY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69BD2266FB;
        Fri,  6 Oct 2023 14:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E85CD266FA;
        Fri,  6 Oct 2023 14:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 6 Oct 2023 07:41:51 -0700")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
Date:   Fri, 06 Oct 2023 11:01:39 -0700
Message-ID: <xmqq7cnzaav0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66DA2028-6472-11EE-B61D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > +--cc::
>> > +     Produce dense combined diff output for merge commits.
>> > +     Shortcut for '--diff-merges=dense-combined -p'.
>>
>> Good.
>>
>> > +--remerge-diff::
>> > +     Produce diff against re-merge.
>> > +     Shortcut for '--diff-merges=remerge -p'.
>> ...
> Perhaps:
>
> Produce remerge-diff output for merge commits, in order to show how
> conflicts were resolved.

I do not mind it, but then I'd prefer to see ", in order to show
how" also in the description of "--cc" and "-c" for consistency.

A succinct way to say what they do may be hard to come by, but I
think of them showing places that did not have obvious natural
resolution.

>     For a two-parent merge commit, a merge of these two commits is
>     retried to create a temporary tree object, potentially containing
>     files with conflict markers.  A diff is then shown between that
>     temporary tree and the actual merge commit.  This has the effect
>     of showing whether and how both semantic and textual conflicts
>     were resolved by the user (i.e. what changes the user made after
>     running 'git merge' and before finally committing).

Yes, and because we do not have a back reference from here to the
description for "--remerge-diff" we saw earlier, we'd need the "in
order to" you suggested earlier there, too.

>> Either way, it makes readers wonder what happens to merges with more
>> than 2 parents (octopus merges).  It is not a new problem and this
>> topic should not attempt to fix it.
>
> We could add:
>
> For octopus merges (merges with more than two parents), currently
> only shows a warning about skipping such commits.
>
> if wanted.
>
> But perhaps I've distracted too much from Sergey's topic, and I should
> submit these wording tweaks as a patch on top?  I'm fine either way.

The primary purpose of polishing during a review cycle should be to
help the original contributor to express what they wanted to express
better, so talking about octopus behaviour, which wasn't covered in
the original nor the patch under review, can be left out to avoid
extending the scope of the topic further.

But everything else you said in the message I am responding to falls
into the scope of the "improving existing documentation for various
merge presentation modes" topic, I would think, and they are more or
less usable verbatim, so it would not be too much of a burden to
make sure they are used in the next iteration.

Thanks for a review, and thanks Sergey for streamlining the
documentation around here.


