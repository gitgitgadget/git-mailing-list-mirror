Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14615C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63C761A54
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbhI3Ve1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 17:34:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57597 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhI3Ve0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 17:34:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5968B14A75C;
        Thu, 30 Sep 2021 17:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OaJjm0y5x04kl+rsvAxzznkspXSC4SSOH5tviD
        FNDWI=; b=v5Yl022dmQFb06lyOyjQEA9WAfryTfxIalGRsbqmP2znoJpjfOadcB
        mM4MWXyN3qxByu1vH9jTHXqzz/jGDZ2WjXfFNwt76D7u7uRpYJyqaqrVsSuFmHgu
        IuX3zVYfGX2KYxdyJsXBwB6A15Ce0XUggnB0/irJAVd0F5XjiZweg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51DA914A75B;
        Thu, 30 Sep 2021 17:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFD7914A75A;
        Thu, 30 Sep 2021 17:32:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
        <YVYNW13aVADaR+g6@nand.local>
        <6e9843d5-bc04-e69c-9e53-7bf18ca30fc8@github.com>
Date:   Thu, 30 Sep 2021 14:32:39 -0700
In-Reply-To: <6e9843d5-bc04-e69c-9e53-7bf18ca30fc8@github.com> (Victoria Dye's
        message of "Thu, 30 Sep 2021 16:11:20 -0400")
Message-ID: <xmqqk0ixagw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0A1661C-2235-11EC-A0F8-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Taylor Blau wrote:
>> On Thu, Sep 30, 2021 at 02:50:56PM +0000, Victoria Dye via GitGitGadget wrote:
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> In anticipation of multiple commands being fully integrated with sparse
>>> index, update the test for index expand and collapse for non-sparse index
>>> integrated commands to use `mv`.
>>> ...
>>>  	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>>> -		git -C sparse-index -c core.fsmonitor="" reset --hard &&
>>> +		git -C sparse-index -c core.fsmonitor="" mv a b &&
>> 
>> Double-checking my understanding as somebody who is not so familiar with
>> t1092: this test is to ensure that commands which don't yet understand
>> the sparse index can temporarily expand it in order to do their work?
>
> Exactly - if a command doesn't explicitly enable use of the sparse index by
> setting `command_requires_full_index` to 0, the index is expanded if/when it
> is first read during the command's execution and collapsed if/when it is
> written to disk. This test makes sure that mechanism works as intended.

Sorry, I do not quite follow.  

So is this "before this series of patches, 'reset --hard' can be
used to as a sample of a command that expands and then collapses,
but because it no longer is a good sample of a command so we replace
it with 'mv a b'"?  Do we need to update this further when "mv a b"
learns to expand and then collapse?
