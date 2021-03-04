Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F44C15508
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD46B64F4D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354586AbhCDBDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58890 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356179AbhCDAzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:55:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF3ADBF18B;
        Wed,  3 Mar 2021 19:54:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q53JVrMXDgHSCpT/j2SMLYdJcZg=; b=XySjPW
        JDe1M0GqupzD4N/3zSwiTPOffQ5WAkLy2HezUA4+SoZK/qTVyVrXC3flSIYS4Hfn
        zGhPTaNpz8rx+oB+GSMo1D/A5xGs4eNnpC3T1oBtvgw2p17N87/G1jUIdmvYUS4v
        hdUCWWrU1RM2mrLCJcDeWP6Wu/woUU+QZY9uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WhYq0dkToYp/mVBlUR0e73SPpIche2/V
        nS0iAVMeANS6gQethN8eHWlCG8tyZGp+zcT9WEKTKgnA5bmvdc1CnDMuUflxVmfZ
        9CzCRSjTk53R1uYiNuUSx7yf6MEdo7PbPgAhkN3r1Ezn9GRXMhXiruS6haUOfStZ
        pzc4kTcbyiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6B1FBF18A;
        Wed,  3 Mar 2021 19:54:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44A31BF189;
        Wed,  3 Mar 2021 19:54:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] format-patch: allow a non-integral version numbers
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
        <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
        <YD9Qv/sTDmOE9jlq@generichostname>
Date:   Wed, 03 Mar 2021 16:54:39 -0800
In-Reply-To: <YD9Qv/sTDmOE9jlq@generichostname> (Denton Liu's message of "Wed,
        3 Mar 2021 01:02:55 -0800")
Message-ID: <xmqqpn0fg2ls.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 334A445A-7C84-11EB-A7FF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hmm, others may disagree but I don't really like the idea of
> `--previous-count`. It may be useful for populating "Range-diff vs <n>"
> instead of just "Range-diff" but I don't think it's worth the cost of
> maintaining this option.

It really depends on the target audience.  As a reviewer who may be
too busy to read every iteration of a series, I would probably find
it useless if it gives just "range-diff" or "range-diff with last"
without saying which exact round.  Obviously, if you are not doing
range-diff, it will not be an issue.  If the patch requires (I
didn't read the latest one) the previous-count to be given when
range-diff or interdiff is not requested, it should probably be
fixed.

I am also OK with any design decision, as long as it will not close
the door for the occasionally requested feature to carry over cover
letter material from the previous round to the current one.

Thanks.
