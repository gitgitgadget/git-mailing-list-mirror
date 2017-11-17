Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77EFA202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 01:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbdKQBlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:41:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62795 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752487AbdKQBlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:41:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33F919EBDF;
        Thu, 16 Nov 2017 20:41:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7YqkriTzp5hj2TZPRdttzdL2iQA=; b=F611lX
        AMWBGjxAGnkebqIBh6+R0kI1I00yPTBxUIWHC7Bq9ERfIA4tXQ72ncYvjtjVSV8l
        MsiIJLamcxnnCjZ70u/pA1Z6YORCIGAC4SGUNKtS92cbCoP6As0kw5U6ESRp44Sd
        SlyjyGPJcvyOf5cu7HHTLvGn3LvNM0UgxiiHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=He5jEuFgzZQQ/TV6L/nIgeatJc3IgX6d
        l3w+gL5Pxs4TUD7u/T7+WI69jKjod7wi62DBe7PHTo84F5xwTaMTN9KyWn5RibMY
        xB3xtwX7/r9YCsbN/nvKLNfCqAhif9YjeLOWpqFXepDJ/BZ97+eHoOriOhDBQwoy
        P6dkzT7wXEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C79C9EBDE;
        Thu, 16 Nov 2017 20:41:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9866B9EBDD;
        Thu, 16 Nov 2017 20:41:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Michelbach <michelbach94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation of post-receive hook
References: <1510872031.23230.7.camel@gmail.com>
Date:   Fri, 17 Nov 2017 10:41:21 +0900
In-Reply-To: <1510872031.23230.7.camel@gmail.com> (Christoph Michelbach's
        message of "Thu, 16 Nov 2017 23:40:31 +0100")
Message-ID: <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AACD922-CB38-11E7-B53B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Michelbach <michelbach94@gmail.com> writes:

> I think the documentation of the post-receive hook is misleading. When reading
> it, it appears as though the post-receive hook is executed even when no commits
> are transferred by a git push because it isn't mentioned anywhere that this is
> necessary for its execution.

In other words, post-receive hook triggers only after it receives
objects.  A mere action of running receive-pack command does not.

> This can easily be fixed by changing
>
>     This hook is invoked by 'git-receive-pack' on the remote repository,
>     which happens when a 'git push' is done on a local repository.

So the existing description is technically correct (i.e. it does
correctly identify who invokes it) but lacks a more interesting and
relevant information (i.e. receive-pack invokes only after receiving
data).

>     This hook is invoked by 'git-receive-pack' on the remote repository,
>     which happens when a 'git push' is done on a local repository and
>     successfully transfers at least 1 commit.

I am not sure "at least 1 commit" is a good phrase to use here.
There are transfer that sends objects but no commit object, and the
above makes it sound as if such a transfer will not trigger the
hook.  Would

	This hook is run by 'git receive-pack' on the remote
	repository, after it receives objects sent by 'git push'.

be clear enough to teach readers that a no-op push that recieve-pack
does not receive any object does not trigger the hook?

