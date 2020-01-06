Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC316C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1A620731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IASyd33A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgAFRcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:32:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 12:32:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29AAD22531;
        Mon,  6 Jan 2020 12:32:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uw5D2/+VbmL+GlUWsiFOuKDVaRw=; b=IASyd3
        3AGltKe0FXbv3AH5m2zjv46hyOmdYTfczidMo/PH6FdmnRVB0XtuOyEGEmiyJDOg
        ZBhcp2asgOq9U6NET//l1r9Z7jwQqj1xO01YjC6XSLn1jhIhaGylqNienOKOF5NK
        zQjFz5yKal656vvG3Pq6F9Le/Z432Be4splVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZP7LB9lf9Dfrm8qa60sIVdAZC3hEBsOE
        TKP7aHU+vYFhR3zPShKKyZZx/OrUG+RTOnh3w4+/UzLiuR6UMXJ5J2fZTlFJZ2TD
        vFNk1izXKloDojPeKyvUSw1yQ2W7fMFGzK0oQw1fHq+PF7lQPEdmJ3UVrDMYE2DJ
        QXUVoKa5M3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20E3122530;
        Mon,  6 Jan 2020 12:32:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F63A2252C;
        Mon,  6 Jan 2020 12:32:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 09:32:43 -0800
In-Reply-To: <pull.511.git.1578326648.gitgitgadget@gmail.com> (Michael
        Rappazzo via GitGitGadget's message of "Mon, 06 Jan 2020 16:04:07
        +0000")
Message-ID: <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C4497A8-30AA-11EA-A018-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since this change what the expected post-rebase commit comment would look
> like, related test expectations are adjusted to reflect the the new
> expectation. A new test is added for the new expectation.

Doesn't that mean automated tools people may have written require
similar adjustment to continue working correctly if this change is
applied?

Can you tell us more about your expected use case?  I am imagining
that most people use the log messages from both/all commits being
squashed when manually editing to perfect the final log message (as
opposed to mechanically processing the concatenated message), so it
shouldn't matter if the squash! title is untouched or commented out
to them, and those (probably minority) who are mechanical processing
will be hurt with this change, so I do not quite see the point of
this patch.

Thanks.

>
> Signed-off-by: Michael Rappazzo rappazzo@gmail.com [rappazzo@gmail.com]
>
> Michael Rappazzo (1):
>   sequencer: comment out the 'squash!' line
>
>  sequencer.c                   |  1 +
>  t/t3404-rebase-interactive.sh |  4 +---
>  t/t3415-rebase-autosquash.sh  | 36 +++++++++++++++++++++++++++--------
>  t/t3900-i18n-commit.sh        |  4 ----
>  4 files changed, 30 insertions(+), 15 deletions(-)
>
>
> base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-511%2Frappazzo%2Fcomment-squash-subject-line-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-511/rappazzo/comment-squash-subject-line-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/511
