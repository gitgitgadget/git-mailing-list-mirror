Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE64C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhKZVHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 16:07:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61845 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbhKZVFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 16:05:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B32C170EA0;
        Fri, 26 Nov 2021 16:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3gZ5rY0E3mv4mnYxZXp0IJy8MlhmfW3RQJ038t
        FXlC8=; b=b+TtgoWFf26o9DaitCiTs/p33aBinLYsXkpIocWETKMfSQ3dJAX9Gn
        9Q0v+wYwdQ1GCZQsGiW5tZJL/XJRKJ0+2fd7AXQSonw24eucf46wDQrTTwhzJq+C
        xhTA8F8eWb4rkOGPh/o0m4E19hYDc670VnFLs+7LJbP9KSrYc4S8g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43B44170E9F;
        Fri, 26 Nov 2021 16:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 598B9170E9E;
        Fri, 26 Nov 2021 16:02:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
References: <20211117090410.8013-3-fs@gigacodes.de>
        <20211120150401.254408-1-fs@gigacodes.de>
        <20211120150401.254408-4-fs@gigacodes.de>
        <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
        <xmqqh7c4i0jh.fsf@gitster.g> <20211126095509.weeknmg4p6sx7bdn@fs>
Date:   Fri, 26 Nov 2021 13:02:35 -0800
In-Reply-To: <20211126095509.weeknmg4p6sx7bdn@fs> (Fabian Stelzer's message of
        "Fri, 26 Nov 2021 10:55:09 +0100")
Message-ID: <xmqqy25a636c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F4AA85E-4EFC-11EC-A3C3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>>In any case, the comment in front of the block of exec wants to
>>become a bit more detailed than just "# Set up additional fds", with
>>an explanation about which FD is used for what.
>>
>
> How about:
>
> # Set up additional fds to allow i/o with the surrounding test
> # harness when redirecting individual test i/o in test_eval_

This does not quite say how "setting up additional fds" helpss the
test harness, though.  And this ...

> # fd 5 -> stdout
> # fd 6 <- stdin
> # fd 7 -> stderr

... is literal translation of what is written below, without adding
any new information.

> exec 5>&1
> exec 6<&0
> exec 7>&2

I was expecting something along the lines of ...

# What is written by tests to their FD #1 and #2 are sent to
# different places depending on the test mode (e.g. /dev/null in
# non-verbose mode, piped to tee with --tee option, etc.)  Original
# FD #1 and #2 are saved away to #5 and #7, so that test framework
# can use them to send the output to these low FDs before the
# mode-specific redirection.

... but this only talks about the output side.  The final version
needs to mention the input side, too.

Thanks.




