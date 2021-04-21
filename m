Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BEC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82423613B2
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbhDUR0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:26:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63304 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbhDUR0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 13:26:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4408311F1A7;
        Wed, 21 Apr 2021 13:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0I7R1pk4a+jMoi6OfCWbhK8EkbQ=; b=TdIxRr
        +ZTHqRqdGJ5rHxqR7uBqeqbBzJftGzvI+kOPNCbxBCBD2vp5Yfhs1HFNmxMuhPnC
        whR7IHF/hjcmfBvLjJCdjbOm2HNkKnr9k9460UWBbb4EDMPyYc/j875icTNyINDi
        JUiZi++U7U2l96+NN18crKTks1BrZJNSXTFK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eP133Kyi8zJ2D0h/VX6nBd7gavCdFT/Y
        x4h9yqU0UWEB9dOPQmCX/PndhtXDmZa5oscRX39081FdI+PWFennCTWkbXiDLgnm
        AP9QtCaXRHUWAb6LCWGMIl/i2ZHCiNSfOcMVlXJBkOBNx/ZB/JkBM97sBpclP3gi
        ecs6TnfyF3g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C74F11F1A6;
        Wed, 21 Apr 2021 13:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8104911F1A2;
        Wed, 21 Apr 2021 13:26:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     trygveaa@gmail.com, git@vger.kernel.org, larsxschneider@gmail.com,
        chriscool@tuxfamily.org, Johannes.Schindelin@gmx.de,
        pranit.bauva@gmail.com, tanushreetumane@gmail.com,
        mirucam@gmail.com
Subject: Re: [PATCH v2] test: add test for git bisect skip with --term*
 arguments
References: <20210418151459.GC10839@aaberge.net>
        <20210421040808.14185-1-bagasdotme@gmail.com>
Date:   Wed, 21 Apr 2021 10:25:59 -0700
In-Reply-To: <20210421040808.14185-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 21 Apr 2021 11:08:10 +0700")
Message-ID: <xmqqa6przh08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4B42710-A2C6-11EB-96E7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Trygve Aaberge reported the current git bisect breakage on [1].
> After starting bisection with --term-new and --term-old arguments to git
> bisect start, skipping with git bisect skip does not change HEAD as
> expected.
>
> Let's add the test to catch this breakage.

I expected, as you said in your first version, that it would be
added as part of an existing test script for "git bisect".  And I
suspect that you can reuse the history the existing tests in the
script already use, so you won't have to add the first "initialize"
piece.  If the tested sequence should work but does not yet work due
to lack of a fix to a known bug, the test should be marked as
test_expect_failure instead of test_expect_success.

>   * style changes requested by Junio

Heh, I didn't request anything.  I merely pointed out the parts that
violate the style guide, so if anything, the guide requested you and
I was just a messenger ;-).

Thanks.
