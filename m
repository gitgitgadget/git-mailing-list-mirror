Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B7C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69833613DF
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 22:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhGPWNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 18:13:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51319 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhGPWNT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 18:13:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C5BA14A10C;
        Fri, 16 Jul 2021 18:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JSid4yPyAfxIJa0B4Guduxzr54Hil+bdqQGgqN
        UhPAI=; b=O2JeaDMlFgQLuc4CXSojrs86AcOIRROeKdouwDjxyY6Q+pSNV+LA4y
        8C9szFhJHk2nNQqWIxX45rKut/U2BtA6/pfKP7VycPuPv2l00h+6GhL5rJUfXM8F
        r1WqQbBbXKSMNfFeEc6+KWBJnL6Qhg0nNfBu1NsWy8qAejtGC1ig0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6510214A10A;
        Fri, 16 Jul 2021 18:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AEEBC14A109;
        Fri, 16 Jul 2021 18:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH 0/2] Normalize newlines in merge & interpret-trailer
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 15:10:20 -0700
In-Reply-To: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com> (Luca Weiss
        via GitGitGadget's message of "Fri, 16 Jul 2021 07:43:34 +0000")
Message-ID: <xmqqsg0dq59v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CE50C98-E682-11EB-B9B6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Luca Weiss via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These two patches fix a problem where the trailer would be appended to the
> commit message without an empty line, so parsing the trailers again
> afterwards would fail.
>
> In practice either one of the patches fixes the exact behavior I see but in
> both cases it makes sense to normalize the newlines.
>
> The exact use case where this issue was found is a "git merge --no-edit"
> with a commit-msg hook that adds a trailer immediately afterwards. The input
> the commit-msg script gets is not terminated by a newline (which is fixed by
> the second commit) while the first one makes interpret-trailer capable of
> handling such input without a final newline.

When you fold some of what you wrote in the above into the proposed
commit log message proper when you send an updated version of the
series, please pay special attention to the phrases like "empty
line", "normalize newline" and "terminated by a newline".

 - As there are some folks who use Git on Windows on this list, when
   we say "normalize the newlines", they will think of CRLF vs LF,
   but I do not think that is what you are talking about here.

 - As I asked in my review of one of your patches, please explain
   where the incomplete line comes from (e.g. saying "if the user
   ends the edited log message with an incomplete line" would make
   it clear how we missed such an incomplete line to come into the
   system).

 - I am guessing that "without an empty line" is because we usually
   append trailers with one newline after the last line of the log
   message, with the expectation that the existing log message ends
   with a complete line, but an incomplete line at the end of the
   log message absorbs the newline and makes it as part of the last
   line that is now a complete line?  And a trailer block that is
   not separated with a blank line from the last paragraph of the
   message body is not taken as a trailer block, causing the later
   parsing to fail, but from your description it was unclear how
   the trailer block is added without the paragraph break.

Thanks.
