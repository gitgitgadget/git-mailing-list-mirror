Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74B5C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F0207C4
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M5u3kxgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgI1Xlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:41:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57649 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1Xll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:41:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BD46F1621;
        Mon, 28 Sep 2020 19:41:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JFXeHAJb+LPIGabhNrHCUIG2BzY=; b=M5u3kx
        gqtazAzLEowPWQmijW7Eg4y2/21175vWnibIwRLcuaUzmHlvePjci0dNhtczxwol
        E7kvWaRFFrGNmt4JmTO/t4mMkxzheyRbpw9tCNPcEM7JsTAvgDjlgCdu7iNEuVlA
        S6hF0yY4MUCNiamd/0tN0Ww/gRHRrHW8THoVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mUzDBstLE0ymZFROKYMS/wyPA7bEzslS
        cI2jVfqKjhg9M5OK/gxteJpHSIWo3ZPc3ibtDtF1cK/r0PW01raMaEYybF3QkTuW
        GGxVYcYcOJg+biPrXuHQM1/jQBGWMWdC/ASZCaGp0cSKe+1q2lxjjruN5Z65qhvq
        HDHlb37m7aY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03A62F1620;
        Mon, 28 Sep 2020 19:41:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3AE33F161F;
        Mon, 28 Sep 2020 19:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>, peff@peff.net
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
        <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
        <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
Date:   Mon, 28 Sep 2020 16:41:35 -0700
In-Reply-To: <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 28 Sep 2020 16:26:38 -0700")
Message-ID: <xmqqd025jwpc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 265AB858-01E4-11EB-9A57-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> -test_expect_success 'get: credentials with DOS line endings are invalid if path is relevant' '
>> +test_expect_success 'get: credentials with DOS line endings are valid if path is relevant' '
>
> note that this test was put in place to protect users from regressions
> like the one we got after the release of 2.26.1 where users that had
> '\r' as part of their credentials were getting an error[1]
>
> while I am sympathetic to the change (indeed I proposed something
> similar, but was reminded by Peff that while it looks like a text file
> it was designed to be considered opaque and therefore should use UNIX
> LF as record terminator by specification), I am concerned this could
> result in a similar regression since we know they are still users out
> there that had modified this file manually (something that was not
> recommended) and are currently relying on the fact that these lines
> are invalid and therefore silently ignored.
>
> Carlo
>
> [1] https://lore.kernel.org/git/ad80aa0d-3a35-6d7e-7958-b3520e16c855@ed4u.de/

I think you meant to remind us and this thread of the earlier review
and discussion thread, which begins at

  https://lore.kernel.org/git/20200426234750.40418-1-carenas@gmail.com/

And thanks for doing so---I totally forgot about it.

