Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D77C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 06:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiGPGWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 02:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPGWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 02:22:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150A88745
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 23:22:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F6D913ADEF;
        Sat, 16 Jul 2022 02:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d/rdJ1U2BpWVnlPyx0iymQULcOTRQpF0/ERo1f
        dRzWU=; b=QGZ7+JAJ3oKjc+HA8XzQ83W6K3dqQ/tb8yZrVi/LGOWtPPC1X1apgm
        vtEB6XRrHOP6KfMWhfhtzjHoTVCMsWhKg6+Xr3zKyjgUkh3u4EiG8KOtGNcs7S+0
        EuvVuOZTsNDZsSMxfsX6+O/fqiQ7Z+7usPWVlWKNkNtqIbGMq8PlY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 178DF13ADEE;
        Sat, 16 Jul 2022 02:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77E7E13ADED;
        Sat, 16 Jul 2022 02:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v4] submodule merge: update conflict error message
References: <20220629224059.1016645-1-calvinwan@google.com>
        <20220712231935.2979727-1-calvinwan@google.com>
        <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr>
Date:   Fri, 15 Jul 2022 23:22:38 -0700
In-Reply-To: <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr> (Johannes
        Schindelin's message of "Fri, 15 Jul 2022 14:57:34 +0200 (CEST)")
Message-ID: <xmqqh73hy3td.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B124D262-04CF-11ED-8E6F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +test_expect_success 'merging should conflict for non fast-forward' '
>> +	(cd merge-search &&
>> +	 git checkout -b test-nonforward-a b &&
>> +	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
>> +	  then
>> +		test_must_fail git merge c >actual
>> +	  else
>> +		test_must_fail git merge c 2> actual
>> +	  fi &&
>> +	 sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
>> +	 grep "$sub_expect" actual &&
>
> No matter how hard I tried to stare at the code, no matter whether I
> looked at `cw/submodule-merge-messages` or `seen`, I cannot see how this
> `grep` could ever succeed when `GIT_TEST_MERGE_ALGORITHM=recursive`: only
> the `ort` code has been taught this new trick.

Indeed.  https://github.com/git/git/runs/7366982085 is how it failed
in 'seen'.

Thanks for helping Calvin.
