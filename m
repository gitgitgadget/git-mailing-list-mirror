Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B26CC43332
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCDA206B2
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbhAZWB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52777 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbhAZSc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:32:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A28B0AB472;
        Tue, 26 Jan 2021 13:32:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zDqkpd08/PBGShEOIpaPrHQOA1c=; b=HiYxQX
        Lrn1YOUGJW0xpwQ4lcZA2tZyt9CjxDUbsxum1/ctLvzpXKY0/8WhcWsLCKWjP5UU
        4E0tfPkPoch3MkA+qLX7I29hdxSVTSVIWJ1mlTh1el3G5tHQ7yX/VIIMO/syFKcE
        UvWqKTBwRT6mClrWcgCGKpvkV7+JP4O41dRTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k+u+y0RmUiWCSUFMT8Jd8VETCEpch37O
        EPBjYQZfHzzeKlevW/u1IigOZJ6sTz20cH2M4ZdR3nUnocFcgSCZp562gR0uf7i8
        mGNRm94pwrVZi87AaHv3eSEEFGwvVWrJkiD4a6YEbmu7V9G5lxi+loVvSWUU3NlJ
        rCkfM0Lcb5s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99E61AB471;
        Tue, 26 Jan 2021 13:32:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0882BAB46F;
        Tue, 26 Jan 2021 13:32:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
References: <20210123154056.48234-1-mirucam@gmail.com>
        <20210123154056.48234-2-mirucam@gmail.com>
        <gohp6kv9bml9qc.fsf@gmail.com>
        <CAN7CjDANLB85GHVVn32w_Y70bzvadtqdq2uRyc81j7nz+W05jA@mail.gmail.com>
Date:   Tue, 26 Jan 2021 10:32:15 -0800
In-Reply-To: <CAN7CjDANLB85GHVVn32w_Y70bzvadtqdq2uRyc81j7nz+W05jA@mail.gmail.com>
        (Miriam R.'s message of "Mon, 25 Jan 2021 20:23:32 +0100")
Message-ID: <xmqqczxr35xs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D095AE08-6004-11EB-AFE7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

>> Although I compiled and did small test on the above code snippet, don't
>> trust it blindly and perform your own test and judge whether this is the
>> best way to implement this shortcoming.
> Ok, thank you.
> I am not the original author of this subcommand reimplementation
> and I don't know if there is a reason for the difference with the
> error message. Maybe we can wait for some other reviewers opinion.

Sorry I missed this thread.

My understanding is that this topic is an attempt to "reimplement"
what is there in the scripted version, so any deviation of behaviour
obserbable from outside, which is *not* justified, should by
definition be treated as a bug.

If the original author did not explain why the behaviour difference
exists and defend why the new behaviour in the reimplementation is
better, and if you do not think of a good reason why the behaviour
should be different and the new behaviour is better, then let's
treat it in a bug and fix it.

Thanks.
