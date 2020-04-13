Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3305C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B1620644
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZSW+gLq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgDMVu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:50:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59644 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgDMVu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 17:50:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51DF4B4BDA;
        Mon, 13 Apr 2020 17:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vr8xvv2Evo27nM0tdJOgzhdYMBg=; b=ZSW+gL
        q56g6XZGWFgtLj0qsEtYCu1OESBEQ3CAr9+F0H4xkuQ4PN8Ol6EGR8tnoqcJXcF3
        1850zD35CSojtXvGWY1Iu/yXSstZsAR7Aqn2ToCKgrUIZSizsGp/icvbFTtw+uJ/
        ZiVSeVO7pSexCeCZgRK0DKy/X7mzjxHdT9qqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVhcDd9BfhGTYoWOOBUtAtnbyr17IjUj
        tvooCbagymh+acA47i4YWnGt14sgnWCXBd2XLWGpi6WAtQfCRYUNH88CrlhBVzra
        Hz4e2mYgv0fH7T2bA1oARJHkXj4Ln0TBUBHjlhzQkuiP3Av0c/MtqUu7/ienEViB
        m8NFObcZOIg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4992DB4BD9;
        Mon, 13 Apr 2020 17:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91FB4B4BD8;
        Mon, 13 Apr 2020 17:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v10 2/8] receive-pack: add new proc-receive hook
References: <xmqq5ze4e6j2.fsf@gitster.c.googlers.com>
        <20200413105809.79988-1-zhiyou.jx@alibaba-inc.com>
Date:   Mon, 13 Apr 2020 14:50:51 -0700
In-Reply-To: <20200413105809.79988-1-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Mon, 13 Apr 2020 18:58:09 +0800")
Message-ID: <xmqq3697cax0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D908FA0C-7DD0-11EA-ADDD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Before making a decision, we must consider some limitations or backward
> compatibility issues.  See the limitations from following code snippet
> of "send-pack.c" and "transport.c":
> ...
> The sideband message stream (stderr of 'proc-receive') will be sent
> directly to the client.  If the client is a very old version of git,
> is is still safe?

These made your assumptions clear to me, I think.

I was expecting that the protocol was purely between receive-pack
and the hook and the communication back to the "push" side was done
by receive-pack, AFTER receive-pack finished talking with the hook,
reading and understanding what the hook did.  And with that
expectation, the protocol to the hook is free of "compatibility"
concern and does not have to be constrained to "one report packet,
which may have to carry multiple updates if the hook updates
multiple refs in response to a single update request packet".

But if you are letting the hook talk directly to the "push" side,
without "receive-pack" even snooping/understanding what is going on,
sure, I can understand why you have to put such a limitation to the
protocol to the hook or use/unuse of the side-band.

I actually think we would need some update (new capability, perhaps)
to the protocol between "push" and "receive-pack" when we want to
fully support things like "you tried to push commit A to
'refs/for/X'; 'refs/for/X' is not created nor updated, but instead
'refs/heads/X' has been updated to commit B, which got created using
info in A".  A partial support can be done by just pretending that
the proposed update for 'refs/for/X' succeeded and nothing else
happened, and that may be a perfectly usable initial version.  But I
would suspect that we eventually would want to be able to tell the
"git push" a bit more, and at that point, we'd probably want new
capabilities between "push" and "receive-pack".

I think we should retain fairly strict control over the vocabulary
used by "receive-pack" to explain what happened on "the server side"
to the client, to avoid fracturing the ecosystem.  With "hook's
output is sent pass-thru back to the client" design, you'd allow a
proprietary proc-receive hook to express what it did in a way that
only a matching proprietary variant of "git push" can understand,
which I do not think is a good thing.

Thanks.
