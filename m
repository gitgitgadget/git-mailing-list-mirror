Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6421F453
	for <e@80x24.org>; Fri, 26 Apr 2019 23:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfDZXHm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:07:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62296 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfDZXHm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:07:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CF6213C062;
        Fri, 26 Apr 2019 19:07:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gbar+SujiY2RgqK4in1jqs+/LPU=; b=bgs8eJ
        a8PUOaDUFyF7bJt5Dkig+w35+UV6Vg83CUM1ZZx/9rD3A2coUT5Wl4qO5JzfBIJb
        97u8gaTbG6OYjOZuVSAcs5SM/vCBO7F8oEz/dV9VSMS/k/ONOhmYP2vIR7Bslqqc
        82D+8u4XP7m2aJwRGyFOXd7TXskhrg3o5vCYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JrYzDn4qxKb2iCgZ1rdQf48QXDNPyQA1
        9WgMwJlFHN6mKdRj4A0sXMPt48F5UIqrxzAJ/NjD9yjoUAK9YvvqFn7muvwj1NMp
        7EcPsinw6uP3ejggMrOXhKcwq/yX0pHQ4a2tdmt6xBO8ThEgPwrzZioTT5cxYGe4
        33YllR8lYEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94EDA13C060;
        Fri, 26 Apr 2019 19:07:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0260213C05F;
        Fri, 26 Apr 2019 19:07:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] allow checkout and branch to create branches on a merge base
References: <cover.1556226502.git.liu.denton@gmail.com>
        <cover.1556305561.git.liu.denton@gmail.com>
Date:   Sat, 27 Apr 2019 08:07:34 +0900
In-Reply-To: <cover.1556305561.git.liu.denton@gmail.com> (Denton Liu's message
        of "Fri, 26 Apr 2019 12:21:06 -0700")
Message-ID: <xmqqlfzwtlft.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14777E0C-6878-11E9-83B5-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Thanks for your comments, Eric and Junio.
>
> Eric, I've combined the `test_when_finished` calls together so that the
> statements within appear in a more "logical" order.
>
> Junio, I've taken your suggestion and moved the change into
> `create_branch`. Initially, I didn't want to do this because I didn't
> want to change the semantics of git-branch but introducing the merge
> base syntax seems to be a positive change so let's do it.
> ...
> Denton Liu (3):
>   t2018: cleanup in current test
>   t2018: demonstrate checkout -b merge base bug
>   branch: make create_branch accept a merge base rev

Because "checkout -b new" is supposed to be merely a short-hand for
a "branch new" followed by "checkout new", the lack of "branch new
A...B" is the same "bug" as the lack of "checkout -b new A...B".

The second patch that does not talk about the former but singles out
only the latter is being inconsistent.

One person's lack of feature is a bug to another person, and indeed,
when we did "checkout A...B" in 2009, we weren't interested in doing
the same for "checkout -b new", and nobody thought about adding that
until now, and/or considered the lack of feature as a bug.

We do not "demonstrate" the lack of a new feature in a patch with
expect-failure, followed by another patch that adds the feature that
flips expect-failure to expect-success.  A patch that teaches
"checkout -b" about A...B, that is adding a missing feature, should
not have to do so.  As it is shades of gray between a change being a
bugfix and adding a new feature, switching the style of testing
based on the distinction between them does not make much sense.  Be
consistent and stick to just one style.  And having the test and the
code change (be it adding a missing feature or fixing a bug) in a
single patch makes patch management a lot simpler by making it
harder to lose only one half.

Having a preliminary clean-up as a separate step is a good idea, but
for this topic, I think the latter two should be combined into a
single patch that changes the code and adds tests at the same time.

Thanks.
