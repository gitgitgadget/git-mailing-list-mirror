Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62787C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4394760EFE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhJLRbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:31:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhJLRa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:30:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 092E2E5E7F;
        Tue, 12 Oct 2021 13:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sJPpylFFEf9qjfiCubMl/U+mqD5P+cNRODAzum
        1zfHM=; b=Qj9xJk1Hu/m+uZ01/clQyasPU+NlQ+UY7pZwJ1FRkO1HlPedRg+5kd
        57lrAoDgeKLhjzqutkXG2x1GnItsVfw98bhY6k3YBKtRAOMR/ybVOC+UgLJwq55z
        U+LQlS3F9JcQd/5knaOqRsh/aagyo7YPB+xUK+Vrbb4yu/7WdRea0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F202DE5E7E;
        Tue, 12 Oct 2021 13:28:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F0A8E5E7D;
        Tue, 12 Oct 2021 13:28:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
        <xmqqa6je8n5c.fsf@gitster.g> <xmqqo87u777d.fsf@gitster.g>
        <87k0ii446g.fsf@osv.gnss.ru>
Date:   Tue, 12 Oct 2021 10:28:52 -0700
In-Reply-To: <87k0ii446g.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        12 Oct 2021 19:07:51 +0300")
Message-ID: <xmqqzgre40ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF054676-2B81-11EC-8B24-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> More importantly...
>>>
>>> Whenever I think about a new "feature", I try to come up with a
>>> story in which the feature effectively improves the end-user's life,
>>> how it fits in the larger picture, and enables something that is
>>> hard to do by combining other tools.
>>>
>>> The kind of "story" I would aim for is like this.  Suppose we were
>>> selling not "git stash -S" but "git stash -k". ...
>>
>
> [...]
>
>> So in short, I do not think I am strongly opposed to "git stash -S"
>> existing, since I did find one use case story that it could be used,
>> but I do think it is redundant and unnecessary.
>
> Redundant? Yes. Unnecessary? Yes. Useful? Yes. ;-)
>
> I took the steps to propose the new feature after yet another round of
> "how do I quickly store this tiny bit of changes I just figured I need
> for later, out of bunch of VIWIP changes?"
>
>   git stash --staged
>
> is exactly the (currently missing) answer for me, as I have pretty
> interactive tool to stage diff chunks always handy.
>
> What's your answer, I wonder?

I am the one who questions the usefulness of "stash --staged" and
thinks "add -p", "stash -k", test, "commit" is a much better way to
solve the "we have a messy working tree and we want to create a
clean multi-step end result out of it" problem.

I consider "stash --staged" as a solution in search of a problem, so
you'd need to ask somebody else for a problem that "stash --staged"
is suitable for.

And "I want to stash away this tiny bit" is better solved by *not*
doing "git add" it to the index and then stashing.  Rather, I'd just
do "commit" so that I can "rebase -i" to reorganize these bits
later.  Of course, to test the "tiny bit" standalone, I may use
"stash -k" first, but do not see such a senario shows the merit of
using "stash --staged" over other tools.

> That said, I'm also curious what story, if any, do you have for 'git
> stash --patch', as exactly the same story should be applicable to
> proposed 'git stash --staged', as far as I can see.

"stash --patch" is also "Meh" from my point of view.  I do not
strongly object to its existence, it may be a OK tool for a small
scale use, but I suspect it would be more frustrating than helpful
to users when applied in a larger workflow story, just like I view
"git stash --staged".

Thanks.
