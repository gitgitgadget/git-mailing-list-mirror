Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B693C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F042C61100
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbhIGSUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:20:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbhIGSUo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:20:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F9A6143835;
        Tue,  7 Sep 2021 14:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WVhiL4t4vvZQc3lIl1ZKKF8DExgDbipfKAbWue
        vrLjw=; b=G92K79c4++3Suz8vs+UGLeGyQhyoXxa0d3r8QlXatdFH5zAnGsr8Yt
        2r1ew6ewbiUsU+1hrOl82Ghbkyiv/emQdU6Ij/W/YUXcblbu8XXIMz/zvu5J0Clg
        guNkk1bIaroOf1FQ1CC9eB8/MvTqMZ0Fe8IyW8JzdAdNZyex+Rm6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89534143834;
        Tue,  7 Sep 2021 14:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0B9C143833;
        Tue,  7 Sep 2021 14:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru>
Date:   Tue, 07 Sep 2021 11:19:33 -0700
In-Reply-To: <87h7f4tf0b.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        01 Sep 2021 19:52:20 +0300")
Message-ID: <xmqqy288b64q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 276A76C4-1008-11EC-A2AC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Here is a patch that fixes diff-index to accept --cc again:

Sorry for the delay; I did not notice there was a patch buried in a
discussion thread.

We might later need to do this suppression in more codepaths if we
find more regressions, but let's have one fix at a time.  

Will queue.

>  builtin/diff-index.c |  6 +++---
>  diff-merges.c        | 14 ++++----------
>  diff-merges.h        |  2 +-

This would deserve new tests that cover the existing use cases,
given that both of us (and other reviewers in the original thread)
did not notice how big a regression we are causing.

We care about --cc naturally falling back to -p when there is only
one other thing to compare with, and also we care about --cc that
allows us to compare during conflict resolution, at least, I think.

It can and should come as a separate step, of course.  Unbreaking
gitk for an already known breakage would be more urgent than hunting
for other breakages, even though the latter might result in a more
thorough fix in the end.

Thanks.
