Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC3C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60033208C7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eSQMZfQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgKFRcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:32:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63924 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRcV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:32:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C65857B6;
        Fri,  6 Nov 2020 12:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ki+UKRspBKW/bWoyViLA9oEHfg=; b=eSQMZf
        QMaSQnkEhzF6YVK65PPXiCkvhIEUpWQxfnAj1c0iE6NpZdsGr2uQ8LVJ8X1lIFtM
        WCYjeV0RR9B/yL8fm2zLJopDgNbLpuJsZNV1FjHIFf7NVynlhl/RoSF0EVLzjPOc
        eHowllH6a0NXJJuHJ02cBbO9ANeM216f0RqI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=REzd7shhPZVJSjIaMfPZoQtYCa3pHNCJ
        dL9q6hrI4yO7ff1d1iVLDALKpSNlskUzVnIvI/S3c2vTTJNjYXdCaWiZPdKccJEy
        0GvyoLXqAEB7aP/E4xgth4JUSyplqv29u2TRtUnn9fGnITftYmT4sXF6edn2dwLF
        v+DgJ0uCV6M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 306B6857B5;
        Fri,  6 Nov 2020 12:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B105A857B3;
        Fri,  6 Nov 2020 12:32:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 00/15] Add struct strmap and associated utility
 functions
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <xmqq5z6jgs6f.fsf@gitster.c.googlers.com>
        <CABPp-BHoaqGRbfM=5SZ4+s1hQa9eRQsi4kMAb3cZFrP+dqHM0A@mail.gmail.com>
        <20201106024835.GA153035@coredump.intra.peff.net>
Date:   Fri, 06 Nov 2020 09:32:17 -0800
In-Reply-To: <20201106024835.GA153035@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Nov 2020 21:48:35 -0500")
Message-ID: <xmqq1rh6gzmm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04F5AF5C-2056-11EB-96F1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 05, 2020 at 06:42:38PM -0800, Elijah Newren wrote:
>
>> > > Changes since v4:
>> > > ...
>> > >  * Add a patch which updates shortlog to use the new strset API.
>> >
>> > This makes my life so much simpler ;-)
>> >
>> > Would the implementation be very different from Peff's that you can
>> > take the authorship?  Thanks.
>> 
>> Yes; I didn't use his patch, I simply implemented what was needed from
>> scratch.  I'm not attached to being author of this though; the changes
>> were trivial.  Feel free to change as you see fit.
>
> Yeah, I am fine either way with the authorship here. The patch is
> trivial, and I was pretty sure you had written the same or similar
> already. My main point in posting it was to push it over the finish line
> so we didn't forget. ;)

Yes.  I just was double-checking in case Elijah forgot, as I
couldn't tell if it was deliberate.  The way you two agree on
is the best for me, too.

Thanks.
