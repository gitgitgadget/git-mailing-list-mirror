Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FFBC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53BF60E9B
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhHJSoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:44:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhHJSoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:44:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2BA1DA6EA;
        Tue, 10 Aug 2021 14:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rP5s59Ta7Abr8OJTnsPDPmUUW6ye86BCrO3kG1
        7vT94=; b=U10bc7w2XTGGsOJdr4DYDjkz52Cg+9V6OYb5oXEdVYlfYhrvz/LT3U
        jZkuLNLBHoQddMB4HF+umnjpM+yiiDkBJX/EYETA/D81X39pHXwN2ZDjK+5lEFkV
        JDBabFQnvdoqmlB+mjiuZju1ko3/r+3jxr5UYbx9JfX6mP9dcsobU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA60ADA6E9;
        Tue, 10 Aug 2021 14:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DB5EDA6E8;
        Tue, 10 Aug 2021 14:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
        <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
Date:   Tue, 10 Aug 2021 11:43:52 -0700
In-Reply-To: <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 10 Aug 2021 10:01:45 -0700")
Message-ID: <xmqq5ywddtsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E93DE632-FA0A-11EB-9302-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Setting GIT_AUTHOR_* when committing with --amend will only change the
>> author if we also pass --reset-author
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  t/t3403-rebase-skip.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
>> index e26762d0b29..6365c5af2f7 100755
>> --- a/t/t3403-rebase-skip.sh
>> +++ b/t/t3403-rebase-skip.sh
>> @@ -36,7 +36,8 @@ test_expect_success setup '
>>         test_tick &&
>>         GIT_AUTHOR_NAME="Another Author" \
>>                 GIT_AUTHOR_EMAIL="another.author@example.com" \
>> -               git commit --amend --no-edit -m amended-goodbye &&
>> +               git commit --amend --no-edit -m amended-goodbye \
>> +                       --reset-author &&
>
> Makes sense...but doesn't the fact that this test worked either way
> suggest that the specifying of a special author name/email was totally
> superfluous and could just be removed?  If there really was a reason
> for specifying a different name/email, then is the test faulty for not
> checking for it somewhere?

Good point.  The commit tagged with amended-goodbye is later used in
some tests that ensure the author ident does not change across a
rebase.  If this commit gets created without authorship customized
(i.e. before Phillip's fix), we would not catch a possible breakage
to make rebase discard the original authorship information.

But with this fix, we now can catch such a breakage.

Thanks.
