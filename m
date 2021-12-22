Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539FEC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 06:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbhLVGUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:20:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54015 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhLVGUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 01:20:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAAD718465A;
        Wed, 22 Dec 2021 01:20:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i9bzNkCJ0Y8qPR/8gkB3Ns6wDsOhakk4vF/VG5
        2mO1w=; b=d69qo31ZirR1yD15W1bJTtr/YDndK4mSCJXQ8ooHf4CEW46SdoDWeY
        SsCCyO4yXXKkbcNAAffM7V1kNjGNcGPz4jzRCA9Cxs7+FKKkFGc0YUfbh5qRur9P
        cR3bRqI55sz3nXYGSnKDVoIUGpcHyq5ofgQR79HilBKX15oiPbuX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3884184659;
        Wed, 22 Dec 2021 01:20:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4E9BF184658;
        Wed, 22 Dec 2021 01:20:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Vicarel <shundra8820@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why does "merge --continue" expect no arguments?
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
        <xmqqlf0dq3t3.fsf@gitster.g>
        <CALRdAffjmvHao8TRfB9YJez1acwHDAq2ZqiqaCRRr5MaWzhxig@mail.gmail.com>
Date:   Tue, 21 Dec 2021 22:20:34 -0800
In-Reply-To: <CALRdAffjmvHao8TRfB9YJez1acwHDAq2ZqiqaCRRr5MaWzhxig@mail.gmail.com>
        (Daniel Vicarel's message of "Tue, 21 Dec 2021 12:51:19 -0500")
Message-ID: <xmqqpmppkvnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46A1FD98-62EF-11EC-8F6A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Vicarel <shundra8820@gmail.com> writes:

> Fair point. I would argue that in my own personal projects, where I am
> the only contributor, sometimes I just want to accept the default
> merge message and move on.  However, one could apply that reasoning to
> _every_ commit message in a personal project, and I certainly don't
> believe in that... so yeah, you've given me something to think about.

Like everybody else, I've had my fair share of "personal projects"
that I was the only developer who lost interest in them in 6 months
to 2 years since their inception---after that nobody would care, and
in such projects, of course, I can remember what I was thinking when
I did some nonsensical change early in their history.  I can survive
sloppy and crappy messages.

But in other projects, I've learned that the author of a commit or a
merge with my name and e-mail address 6 months ago often is a total
stranger for me sitting in front of the display right now.

> I agree that some clearer documentation around `merge --continue` is
> worthwhile, to prevent other developers from thinking like myself.
> Maybe a warning from the CLI after running `merge --continue`,
> recommending `commit` usage instead? Such a warning suggests that the
> option _should_ still be deprecated and removed in the future though.
>
> I am still interested in making a contribution to git, so let me know
> which option you would like me to move forward with at this time:
> adding the CLI warning, or going straight to a deprecation. Unless of
> course you're already on it. :)

Welcome to the development community.

If you want a starter project, among those I listed, perhaps the doc
update would be the quickest one that offers the most to learn from,
as the first road block new developers seem to stumble on is not
coding standard and stuff but social interaction between the patch
submitter and reviewers.

Allowing some selected command line option given to "git merge
--continue" down to underlying "git commit" would be a lot harder
for somebody new to the codebase.  It might make sense to allow
things like "--no-edit" and "--no-verify" to be passed, but you
would never ever want to pass something like "--amend", or (even
worse) a pathspec.  And coming up with a sensible list of allowed
options and arguments would be quite hard.

