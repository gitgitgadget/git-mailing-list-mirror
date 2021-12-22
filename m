Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D166C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 06:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbhLVGXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:23:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62074 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhLVGXz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 01:23:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58C95109148;
        Wed, 22 Dec 2021 01:23:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d+5dcnrJW77KkNai+cTlfK6sQu4QbYOgUJVHeQ
        ucSxw=; b=RdDgK+ZebFLScdax4ca4mm/D+Qc7YlWhWRN6Nty7/ZZHqKUF8sHx+t
        P/ufqXbEzuFP0Yuir1roH5yfPN5tgPmzdNNCeYxVy8e5dZ1nSy1QnIAtugpXV/KO
        LTQN1jFWSNF483hrYQjbj0Ht7I+GJkDBanOVJ0pl6lquhRvuBv7H0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E3CA109147;
        Wed, 22 Dec 2021 01:23:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76DFC109146;
        Wed, 22 Dec 2021 01:23:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 1/9] tmp_objdir: add a helper function for discarding
 all contained objects
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <fab1b2c69eafbd3f211745886786c1d0ebdc05c2.1640109948.git.gitgitgadget@gmail.com>
        <xmqqmtkto7yf.fsf@gitster.g>
        <CABPp-BEuzorQkesgyNCvS05wsfqaH4Yv5JDFgy+AenrAC+JJNQ@mail.gmail.com>
Date:   Tue, 21 Dec 2021 22:23:51 -0800
In-Reply-To: <CABPp-BEuzorQkesgyNCvS05wsfqaH4Yv5JDFgy+AenrAC+JJNQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 21 Dec 2021 15:51:35 -0800")
Message-ID: <xmqqlf0dkvig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB8EC6C2-62EF-11EC-B2D0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > +void tmp_objdir_discard_objects(struct tmp_objdir *t)
>> > +{
>> > +     remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
>> > +}
>> > +
>>
>> OK.
>>
>> Without a caller, it is a bit hard to judge if a separate helper
>> makes the caller easier to read and understand, or becomes an extra
>> layer of abstraction that obscures the logic.  Hopefully, having a
>> more specific function name with "tmp" and "discard" in it makes the
>> intent at callers more clear than the function that is named after
>> the detail of the operation.
>
> This isn't just a convenience; since tmp_objdir is defined in
> tmp-objdir.c rather than tmp-objdir.h, t->path is not accessible
> outside of tmp-objdir.c.  Because of this, some kind of helper
> function is necessary.

But adding this function as an extra level of abstration is *not*
the only way to expose the feature.  Instead the internal of "struct
tmp_objdir" could be exposed to the caller that wants to discard the
files inside the path.

I think we now have enough material to fill between these two lines
to help readers ;-)

>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > Signed-off-by: Elijah Newren <newren@gmail.com>

Thanks.
