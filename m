Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118CC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ECF61042
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhHSSvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:51:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62571 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSSvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:51:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F7AB15762A;
        Thu, 19 Aug 2021 14:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bUqwHMiID8VloQtrdyn2uWvcHY5EXs1RUQ24e1
        usOns=; b=UejPsYoq+LV6HEhUEq0JP7/lea6lbCg1OKQlkvGvSYWrCB+7fHWKcu
        R2rQVt2RhwPfPziajQEqA1ZNADB2jl9bUJ8AJJ8wEJmsh7ZBjro22AitpQMpTe+7
        eKMVzJc9lHG7u2um7Ga1Aigb/fWbOWNsRtqw3qXo9IhBrw8MZ7lxQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 178B4157629;
        Thu, 19 Aug 2021 14:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 539EE157628;
        Thu, 19 Aug 2021 14:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com> <xmqqeeb3hlcq.fsf@gitster.g>
        <87a6lgl9gq.fsf@osv.gnss.ru> <xmqqczqb7mds.fsf@gitster.g>
        <87fsv7f7wx.fsf@osv.gnss.ru>
Date:   Thu, 19 Aug 2021 11:50:41 -0700
In-Reply-To: <87fsv7f7wx.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        18 Aug 2021 11:56:14 +0300")
Message-ID: <xmqqim011d6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B45D522-011E-11EC-AE94-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> We need to note that the "-m" implied by "--first-parent" is "if we
>> were to show some comparison, do so also for merge commits", not the
>> "if the user says '-m', it must mean that the user wants to see
>> comparison, period, so make it imply '-p'".  The latter is what was
>> reverted.
>
> Yes, there is minor backward incompatibility indeed, and that was
> expected. This could be seen from the patch in the same series that
> fixes "git stash" by removing unneeded -m.
>
> The fix for the scripts is as simple as removing -m from "--first-parent
> -m". It's a one-time change.
> ...
>> I agree that we both (and if there were other reviewers, they too)
>> mistakenly thought that the change in behaviour was innocuous enough
>> when we queued the patch, but our mistakes were caught while the
>> topic was still cooking in 'next', and I have Jonathan to thank for
>> being extra careful.
>
> So, what would be the procedure to get this change back, as this minor
> backward incompatibility shouldn't be the show-stopper for the change
> that otherwise is an improvement?

Your repeating "minor" does not make it minor.  Anything you force
existing users and scripts to change is "fixing the scripts", but
"working around the breakage you brought to them", which is closer
to being a show-stopper.  I understand that you like this feature a
lot, but you'd need to be a bit more considerate to your users and
other people.

I think it is a design mistake to make a plain vanilla "-m" to imply
"-p" (or any "output of result of comparison"), simply because the
implication goes in the other direction, so there will never be "get
this change back", period, but see below.

"git log" when showing a commit and asked to "output result of
comparison" like patch, combined diff, raw diff, etc. would:

 - show the comparison for non-merge commits and when
   "--first-parent" is specified (the latter is natural since it
   makes us consistently pretend that the merges were squash
   merges).

 - shows the comparison for merge commits when -m is given.

but because "--cc" and "-c" (which are used to specify how the
result of comparison is shown; they are not about specifying if
"normally we show only non-merges" is disabled) do not make sense in
the context of non-merge commits (in other words, the user is better
off giving "-p" if merges are not to be shown), they are made to
imply "-m".  And that is a sensible design choice.  On the other
hand, "--raw" (which is used to specify how the result of comparison
is shown; it not about specifying if "normally we show only
non-merges" is disabled) does make sense in the context of non-merge
commits, so unlike "--cc"/"-c", it does not imply "-m".  And that
also is a sensible design choice.  "-p" falls into the same bucket
as "--raw", so it should not imply "-m".

But some folks may not like "log -p" to be silent about comparison
for merge commits (like you are).  To accomodate them, it might make
sense to have a configuration that says "I like -m, so when -p or
--raw or any 'how to show comparison result' option is given, please
make it imply '-m'", but it should not be the default.

Thanks.

