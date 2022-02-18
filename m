Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A9AC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiBRQ7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiBRQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 11:59:41 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB062944C1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 08:59:24 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17F6B1177B6;
        Fri, 18 Feb 2022 11:59:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tiD3KrZC6GUlOZvuRfkF5q1pg1aNWRaSVvpEwe
        iKrLA=; b=yADm4TTmoNxYupqcZkmsvqPNHScdxbAMd0qOsQd/OklfF5XoeHUUiF
        3v+P8T+whRj5KpTWrlptRH+pJL71/gAvTifGAiB77w6Y7m35Zzg8P3l+LJGz0a0x
        orUeqEueCznwxuhrohYu81xt8y57RzzE6Q8dBOj+xlPEuGNc4PY4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0931177B5;
        Fri, 18 Feb 2022 11:59:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 444971177AF;
        Fri, 18 Feb 2022 11:59:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im>
        <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
        <xmqqczjl8buq.fsf@gitster.g> <Yg9Bkyp1EDvOzzOp@ncase>
Date:   Fri, 18 Feb 2022 08:59:21 -0800
In-Reply-To: <Yg9Bkyp1EDvOzzOp@ncase> (Patrick Steinhardt's message of "Fri,
        18 Feb 2022 07:49:55 +0100")
Message-ID: <xmqqy2282jrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EA56DBE-90DC-11EC-9DB1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 17, 2022 at 12:41:33PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
> [snip]
>> > +test_expect_success 'atomic fetch with failing backfill' '
>> > +	git init clone3 &&
>> > +
>> > +	# We want to test whether a failure when backfilling tags correctly
>> > +	# aborts the complete transaction when `--atomic` is passed: we should
>> > +	# neither create the branch nor should we create the tag when either
>> > +	# one of both fails to update correctly.
>> > +	#
>> > +	# To trigger failure we simply abort when backfilling a tag.
>> 
>> What does this paragraph want the phrase `backfilling tags` to mean?
>> Just from end-user's perspective, there is only one (i.e. if an
>> object that is tagged gets fetched and that tag is not here, fetch
>> it too), but at the mechanism level, there are two distinct code
>> paths (i.e. if OPT_FOLLOWTAGS gets the job done, there is no need to
>> call backfill_tags()).  Which failure does this talk about, or it
>> does not matter which code path gave us the tag?
>
> It refers to `backfill_tags()`. Should I update this comment to clarify?

After reading the patch, the issue is only about the case where we
perform the second fetch and the case where OPT_FOLLOWTAGS does
everything necessary is not relevant.  So hinting that we are
interested to see what a failure in the follow-on fetch does to the
atomicity would be a good idea, and mentioning backfill_tags() would
have been a good way to do so.  Perhaps like "whether a failure in
backfill_tags() correctly aborts..." or something?

Thanks.


    

