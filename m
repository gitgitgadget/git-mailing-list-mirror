Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE2C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 22:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDF2206DC
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 22:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mqIvKcqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgKEWPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:15:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59754 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEWPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 17:15:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD87CFA42C;
        Thu,  5 Nov 2020 17:15:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l7n1Z5GbNqOQftvEvxk1eU7ptTM=; b=mqIvKc
        qU8kFw15mTso+ncD1on6y2Gy6Gi72+ATEuxm1GaWRRacfSQomkku8leovOqN0NaJ
        5TIRHHOIcmA7zHuNfEUf8dfrAdCaBn33xyAiToTtJBswSkAWCbRjangMXFpmqUez
        r4h4LnnvAUX1i7hBkk+cmfe3+AsS9b7Za3XwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=inMY/NMuk8jtVzIiodEKX6Yoiq7m9GYu
        JXnq6qzKwgoizBOUp/U2Q+IoCLtts/HYXxUKBaFuN0puBSL7EjJTswZXP4rBZPhp
        CAdBeDR5/nJtrI3dTRXd7n2i+g/D6htJmxXlQay4l+nh7I05N7JU6y0Csd6x+/iE
        T8r+7gVH9JE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6ABBFA42B;
        Thu,  5 Nov 2020 17:15:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E157FA428;
        Thu,  5 Nov 2020 17:15:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 00/13] Add struct strmap and associated utility
 functions
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <20201105132909.GB91972@coredump.intra.peff.net>
        <xmqq8sbfk0ut.fsf@gitster.c.googlers.com>
        <CABPp-BGFa_e-nncnCH5GSjhn47Sxf7Tpn7prsJCWiJo-SWoYNA@mail.gmail.com>
Date:   Thu, 05 Nov 2020 14:15:39 -0800
In-Reply-To: <CABPp-BGFa_e-nncnCH5GSjhn47Sxf7Tpn7prsJCWiJo-SWoYNA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 5 Nov 2020 13:22:14 -0800")
Message-ID: <xmqqimajh2lw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70C3AE34-1FB4-11EB-9DAD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> It makes sense, but check_dup() sounds like its use pattern would be
>>
>>         if (check_dup(it) == NO_DUP)
>>                 add(it);
>>
>> where it is more like "add it but just once".
>>
>> By the way, is a strset a set or a bag?  If it makes the second add
>
> strset is a set; there is no way to get duplicate entries.
>
>> an no-op, perhaps your check_dup() is what strset_add() should do
>> itself?  What builtin/shortlog.c::check_dup() does smells like it is
>> a workaround for the lack of a naturally-expected feature.
>
> Is the expectation that strset_add() would return a boolean for
> whether a new entry was added?

It seems to be a reasonable expectation that the caller can tell if
the add was "already there and was a no-op", judging from what we
saw in the shortlog code, which was the first audience the API was
introduced to support.  It seems to benefit from it if it were
available, and has to work around the lack of it with check_dup()
wrapper.


