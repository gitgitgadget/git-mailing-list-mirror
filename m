Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD4C0018C
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1978323407
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgLQBls (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:41:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63950 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQBls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:41:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DD428FC11;
        Wed, 16 Dec 2020 20:41:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3WYO2fJot3Y3Ts3KXTTAybIE/lY=; b=a4jWiu
        qHC0cd31E9gt4bXiX6WMKqnjB/zN3nSgOJHGAeZ4MKNZB6IMgllMXVQKemewmExv
        4y5A1ujUOGxuSrILSx6BpkBhwguDEwma/90l7dTM72wBfvDcZIUXZXIIfpBjy8Zw
        Ef81upeXHaZ91HQ42UDWALrgMJRjydo3p9EBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mZuHTwIC8jS76mKQQFNWtPPi1nMLsR6/
        EbjMNSXvymOtjYEzYJxfwG9vjSJGUWIWAd/C2ySkOI9EnBDUV8xPwPyqDLXUY1Nd
        /WOERNaBN/BOPpRdb6t0MdPNKpfCzAJ0AyVPghrX/wgymNpRInN0Sf/dcL7jscLG
        XaaU9oPQ4so=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54D898FC10;
        Wed, 16 Dec 2020 20:41:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C292A8FC0E;
        Wed, 16 Dec 2020 20:41:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] Drop the PREPARE_FOR_MAIN_BRANCH prereq
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 17:41:05 -0800
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 17 Dec 2020 01:06:59
        +0000")
Message-ID: <xmqqv9d1yzta.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDC795B6-4008-11EB-908C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> To address that, I spent some time to convert just the affected scripts to
> using main, adjusting them in a way where they do not depend on the name git
> init gave the initial branch at all, which allowed me to drop that prereq
> altogether.
>
> None of these changes should be controversial, intentionally so, to allow
> this patch series to go in before v2.30.0 is tagged, so that we can enjoy
> the full coverage of the test suite again.

Thanks for taking care of this one.  The titles all imply that we
are committed to switch the default to 'main', but I understand that
the focus is more about using a hardcoded initial branch in these
tests, so that the tests will not be affected when the default
changes from 'master' to any other value, even when the ":dirname"
and ":random" magic were to be invented and used as the default ;-)

So these may get unwarranted "who says we gained a concensus to
change the default in that direction?" complaint, which might want
to be reworded, ...

>   t3200: finish transitioning to the initial branch name `main`
>   t3201: finalize transitioning to using the branch name `main`
>   t3203: complete the transition to using the branch name `main`
>   t3205: finalize transitioning to using the branch name `main`
>   t5505: finalize transitioning to using the branch name `main`

... but these just make a statement of fact (i.e. these scripts use
X as initial branch name), and less likely to confuse the matter.

>   t1400: use `main` as initial branch name
>   t5510: use `main` as initial branch name
>   t5703: use `main` as initial branch name
>   t6302: use `main` as initial branch name
>   t9902: use `main` as initial branch name

And of course, this is what we want:

>   tests: drop the `PREPARE_FOR_MAIN_BRANCH` prereq

Thanks.
