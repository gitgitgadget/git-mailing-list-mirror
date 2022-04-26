Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE25C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352952AbiDZQYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352941AbiDZQYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:24:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C7119EC8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:21:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87711183EA2;
        Tue, 26 Apr 2022 12:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Ykp72gUwpnDLTGdeG8On+olXMvPyNe4Qn/Sua
        X8uwo=; b=ddW6JW0Edqq2uDdD0LhjePtGYLWK3Wr+LnGqMQGbwLxQ2QanVRH+sg
        88ed92xIleF1ydSbPsmmD1BWaC1OavcJjwk9178Hqz6fJyw+3cKNQvFx/v++TD2T
        qGDiAO8RDlXYTXMstnepVx3LWEsr5ueKtMQ9/R8I0vhO7JJagLPfA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80526183EA0;
        Tue, 26 Apr 2022 12:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A039183E9C;
        Tue, 26 Apr 2022 12:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/7] stash: integrate with sparse index
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
        <f332fec9-da00-0063-4c88-765fa3639ea1@github.com>
Date:   Tue, 26 Apr 2022 09:21:01 -0700
In-Reply-To: <f332fec9-da00-0063-4c88-765fa3639ea1@github.com> (Derrick
        Stolee's message of "Tue, 26 Apr 2022 08:53:52 -0400")
Message-ID: <xmqqy1zrrf2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDDE12CE-C57C-11EC-994D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 4/25/2022 1:49 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>> 
>> Enable sparse index in 'git stash' by disabling
>> 'command_requires_full_index'.
>
>>  ensure_not_expanded () {
>>  	rm -f trace2.txt &&
>> -	echo >>sparse-index/untracked.txt &&
>> +	if test -z $WITHOUT_UNTRACKED_TXT
>
> Do we need quotes around "$WITHOUT_UNTRACKED_TXT"?
>
> I mean, I suppose we don't since the tests pass when this variable
> is unset, but I think it is a good practice to be careful about
> empty variables. Or am I wrong?

Interesting.  I do not think the reason why

	test -z && echo true

says "true" is "-z" noticed an empty string---it is "test $string"
that says "true" when "$string" is not a recognised command and is
not an empty string, no?

You are absolutely right that the above must be quoted.

Thanks for carefully reading.
