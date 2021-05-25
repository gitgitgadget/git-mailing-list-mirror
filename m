Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2FAC47086
	for <git@archiver.kernel.org>; Tue, 25 May 2021 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB1961417
	for <git@archiver.kernel.org>; Tue, 25 May 2021 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhEYVQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 17:16:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58344 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhEYVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 17:16:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3D5513B517;
        Tue, 25 May 2021 17:14:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SvGGwyEG9NO3UOMODEpthnTYhuelNnrtqQ7Qru
        dts6M=; b=sKVd1jyS+TO41lS21HdtH8uWwEsO3iW/SXaQUdPpfJw6tjMpm3DiB0
        hHxT+HpNvDvxjXQARtNBiwQoiu0beSQvHOldwpYuIIzdggjb5OSI425BcfJo2DN8
        4UzVhCDM5PKzksDbBDkkheAjZ5LHkz+vcP/0WKf2YM9oJvIoTNBoc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCE0F13B516;
        Tue, 25 May 2021 17:14:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F98313B515;
        Tue, 25 May 2021 17:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
        <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
        <YKxBIP4lkoPeCYvb@nand.local>
        <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com>
        <xmqqy2c3fhmy.fsf@gitster.g>
        <9d6568ee-c9bf-b349-d1a6-0bb2fcf06dab@gmail.com>
        <xmqq1r9uee3r.fsf@gitster.g>
Date:   Wed, 26 May 2021 06:14:54 +0900
In-Reply-To: <xmqq1r9uee3r.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        26 May 2021 05:46:16 +0900")
Message-ID: <xmqqwnrmcy7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 413FEFDC-BD9E-11EB-A844-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Well, not so well X-<.  It seems that some builds are not happy with
> this change.  See https://github.com/git/git/actions/runs/876229761
> specifically these two:
>
>     https://github.com/git/git/runs/2669177395?check_suite_focus=true#step:7:3549
>     https://github.com/git/git/runs/2669080101?check_suite_focus=true#step:6:988
>
> I suspect that it has something to do with 32-bit platforms?

Reverting the change that was squashed in seems to do the job.
https://github.com/git/git/actions/runs/876338380 is labelled as
'seen' but it is 'next' that failed in the message I am responding
to plus the revert of s/=100000/=-1/g.

Let's queue the 100000 version for now and get the =inf patch
applied after the release.

Thanks.
