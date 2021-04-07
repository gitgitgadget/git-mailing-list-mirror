Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACEC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D2A6124C
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhDGXfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:35:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDGXfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:35:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69C3213621D;
        Wed,  7 Apr 2021 19:35:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DTMRPRzmwCpd
        CFX7pyVbZWaQZio=; b=Q2HmQClODoKvxN7EKDWC1fRtjSwVRGLZzrCWlv8iAZUK
        4hCDG54sF22mnxobKYbAXmj8wDmjl6sCxX6qFP9nhyzOzPpmi/pR3FY3+xo3exR8
        /oNfPpnicMDuLU4CXkxMXPfxp3wiWGz3paMxbavY2qH8/jTBNrRjDZvITdSwIBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MA8Zil
        mWfBxMzdrUgbI19EbuvJNLpG1uiB23CnMkcY5lCZ1tomf8bVrAjfu5w0JpCory07
        etcNJ3YjbwxOSy75vS0ecVFTQQwrD7wnZ9gvX9FXJ7dXHJGV96Prl6zjMwsfY+0G
        KNN2jyjuD0nIO3Ow7GyUsEJ56tI+PRyuWZ8QY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61B6D13621C;
        Wed,  7 Apr 2021 19:35:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9A9313621B;
        Wed,  7 Apr 2021 19:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/9] t4013: add tests for log.diffMerges config
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-7-sorganov@gmail.com>
        <87v98xitjh.fsf@evledraar.gmail.com>
Date:   Wed, 07 Apr 2021 16:35:06 -0700
In-Reply-To: <87v98xitjh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Apr 2021 01:06:26 +0200")
Message-ID: <xmqqh7khwtw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3A93014-97F9-11EB-A11F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +test_expect_success 'deny wrong log.diffMerges config' '
>> +	git config log.diffMerges wrong-value &&
>> +	test_expect_code 128 git log &&
>> +	git config --unset log.diffMerges
>
> Don't use "git config", but "test_config" at the start, then you don't
> need the --unset at the end, it'll happen automatically. Ditto for the
> following tests.

More importantly, test_config arranges the unset to happen even if
a step in the middle (e.g. test_expect_code in the above example)
fails.  In the posted version, the control would not reach the
"git config --unset" and leaves the configuration behind.

And that is the biggest reason why the above should use test_config.

Thanks for a good suggestion.
