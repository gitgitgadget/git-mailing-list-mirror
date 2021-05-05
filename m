Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F12C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B6A61059
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhEEBMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 21:12:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53409 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhEEBMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 21:12:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67ED2CB76B;
        Tue,  4 May 2021 21:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nlFMUTE29uc5diYdzoYHt5Lqx8DTx+ShcEXbe6
        25Ig4=; b=LjIj4k80hAfl4qR4i+l+jFTcmavT7Odo3qLIAYChX7frJthvgF9hin
        +K3/Pnf5eCZKtY+yuRieoeagxZq64/s1QnSZA5rh/w4A9ikHmbP7HSk/QCPVsqQ5
        OfDZdzywKSqRZCPd+09WlA3onfeQas3je5kOuaXt66KqQ0HrHHdi8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FDB5CB76A;
        Tue,  4 May 2021 21:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E378FCB769;
        Tue,  4 May 2021 21:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Andrew Oakley <andrew@adoakley.name>,
        Luke Diamand <luke@diamand.org>,
        Git List <git@vger.kernel.org>, Feiyang Xue <me@feiyangxue.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
References: <20210412085251.51475-1-andrew@adoakley.name>
        <20210412085251.51475-3-andrew@adoakley.name>
        <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
        <20210430095342.58134e4e@ado-tr>
        <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
        <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
        <20210504220153.1d9f0cb2@ado-tr>
        <CAKu1iLXOFiUGmQUeoW-YkiiJ8P2+LznXWz4YabEiGktv=nUYjA@mail.gmail.com>
Date:   Wed, 05 May 2021 10:11:20 +0900
In-Reply-To: <CAKu1iLXOFiUGmQUeoW-YkiiJ8P2+LznXWz4YabEiGktv=nUYjA@mail.gmail.com>
        (Tzadik Vanderhoof's message of "Tue, 4 May 2021 14:46:40 -0700")
Message-ID: <xmqqczu656iv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD5636EA-AD3E-11EB-96A0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:

> On Tue, May 4, 2021 at 2:01 PM Andrew Oakley <andrew@adoakley.name> wrote:
>> The key thing that I'm trying to point out here is that the encoding is
>> not necessarily consistent between different commits.  The changes that
>> you have proposed force you to pick one encoding that will be used for
>> every commit.  If it's wrong then data will be corrupted, and there is
>> no option provided to avoid that.  The only way I can see to avoid this
>> issue is to not attempt to re-encode the data - just pass it directly
>> to git.
>
> No, my "fallbackEndocing" setting is just that... a fallback.  My proposal
> *always* tries to decode in UTF-8 first!  Only if that throws an exception
> will my "fallbackEncoding" come into play, and it only comes into play
> for the single changeset description that was invalid UTF-8.  After that,
> subsequent descriptions will again be tried in UTF-8 first.

Hmph, I do not quite see the need for "No" at the beginning of what
you said.  The fallbackEncoding can specify only one non UTF-8
encoding, so even if majority of commits were in UTF-8 but when you
need to import two commits with non UTF-8 encoding, there is no
suitable value to give to the fallbackEncoding setting.  One of
these two commits will fail to decode first in UTF-8 and then fail
to decode again with the fallback, and after that a corrupted
message remains.

>> I think another way to solve the issue you have is the encoding header
>> on git commits.  We can pass the bytes through git-p4 unmodified, but
>> mark the commit message as being encoded using something that isn't
>> UTF-8.  That avoids any potentially lossy conversions when cloning the
>> repository, but should allow the data to be displayed correctly in git.
>
> Yes, that could be a solution.  I will try that out.

If we can determine in what encoding the thing that came out of
Perforce is written in, we can put it on the encoding header of the
resulting commit.  But if that is possible to begin with, perhaps we
do not even need to do so---if you can determine what the original
encoding is, you can reencode with that encoding into UTF-8 inside
git-p4 while creating the commit, no?

And if the raw data that came from Perforce cannot be reencoded to
UTF-8 (i.e. iconv fails to process for some reason), then whether
the translation is done at the import time (i.e. where you would
have used the fallbackEncoding to reencode into UTF-8) or at the
display time (i.e. "git show" would notice the encoding header and
try to reencode the raw data from that encoding into UTF-8), it
would fail in the same way, so I do not see much advantage in
writing the encoding header into the resulting object (other than
shifting the blame to downstream and keeping the original data
intact, which is a good design principle).
