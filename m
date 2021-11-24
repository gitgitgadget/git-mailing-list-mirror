Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6DAC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350624AbhKXSjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:39:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55996 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbhKXSjS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 13:39:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75997F9F54;
        Wed, 24 Nov 2021 13:36:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=43/fEjOsAaHjE2ArhY+53L9GMbUaPw0F5EFXfr
        iVWUo=; b=YeQeisUKEvMOddUy3q/nAUssDXWA2ZzNxXNGM+TvpZR1G8uMf2f85D
        XTPyIyz2fOetjioc/vRwsXmG8tk1RhfBHl11zsWJtoCcRewYUeInifnZS3SCujXf
        rZdnSCrP5veftDgLzqg82E3TDZNPq1NPZu1K5PF82qTC/8mRhtq04=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ABA8F9F53;
        Wed, 24 Nov 2021 13:36:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E206F9F51;
        Wed, 24 Nov 2021 13:36:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 2/4] test-read-cache: set up repo after git directory
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <5bc5e8465ab5fe871965e6c6d578efc51e55b505.1637620958.git.gitgitgadget@gmail.com>
        <xmqq4k82781w.fsf@gitster.g>
        <0372ee0b-8dda-c505-2b83-30da74e4fb36@gmail.com>
Date:   Wed, 24 Nov 2021 10:36:05 -0800
In-Reply-To: <0372ee0b-8dda-c505-2b83-30da74e4fb36@gmail.com> (Lessley
        Dennington's message of "Wed, 24 Nov 2021 07:10:33 -0800")
Message-ID: <xmqqtug12yga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63328144-4D55-11EC-A630-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

> On 11/23/21 3:42 PM, Junio C Hamano wrote:
>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>>> From: Lessley Dennington <lessleydennington@gmail.com>
>>>
>>> Move repo setup to occur after git directory is set up. This will ensure
>>> enabling the sparse index for `diff` (and guarding against the nongit
>>> scenario) will not cause tests to start failing, since that change will include
>>> adding a check to prepare_repo_settings() with the new BUG.

>> This looks obviously the right thing to do.  Would anything break
>> because of the "wrong" ordering of events in the original code?
>> IOW, can this "bugfix" be protected with a new test against
>> regression?
>> 
> Yep! Tests 2, 3, 28, and 34 in t1092-sparse-checkout-compatibility.sh
> will fail without this change.

I do not understand.  When 1/4 and 2/4 are applied, no tests in
t1092 fail for me.

I think the presentation order of this series is not reviewer
friendly; "the new BUG" is introduced in a separate step and
obscures the reason why this step is needed.  It is better than
adding "the new BUG" first and let some tests fail and then fix the
breakage the series caused in later steps, though.




