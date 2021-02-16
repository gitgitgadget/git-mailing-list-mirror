Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F254DC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BFC64E76
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBPS6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:58:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62373 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBPS6X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:58:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5499A6360;
        Tue, 16 Feb 2021 13:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Se4qUVFzvuwHpCMDfuM9GYhNQew=; b=KE0ewd
        fCfgHf84vDVXKXZIcL+4fCprqQof36ZLzRmS9MeKERifB6EMyV1pC2oqiLIy23d+
        BOPm83BinCKvNLcsxnM9a8y050nxZQs15uMe6n0+Gamh1fyprrSk2FkVE4jbIOm5
        wrRkRiMc+UiL3NvJoMwcGkHksFFMO2ajpN+Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NvEzBMdsuc5TLZ8zdhCLSXKy8gkpc/y3
        YdyMQtJ6Rv7VnoGZpPOgivzU23BeZZCaiWJR3GCFnhfQGye0xdujHD3g72Pb4bU3
        cdgSIDHsWHGSeyGZwNUjfLvFkJXHgpobYpvVUDWoCZGKzXyEEf66A41y1NCPQIbh
        j+fW22mgPmI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB992A635F;
        Tue, 16 Feb 2021 13:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 576C1A635E;
        Tue, 16 Feb 2021 13:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
        <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
        <YCvotU6KVruFuf9/@coredump.intra.peff.net>
Date:   Tue, 16 Feb 2021 10:57:39 -0800
In-Reply-To: <YCvotU6KVruFuf9/@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Feb 2021 10:45:57 -0500")
Message-ID: <xmqq35xvrgbg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7D32BD4-7088-11EB-9EE2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Still, it seems a bit unusual for an executed program to handle tilde
> like this. The usual mechanism is for us to run it with the shell and
> expect to find it in $PATH.

Yes, the user should be able to deal with the $PATH.

> It looks like there's some weirdness here, though; $smtp_server may be a
> hostname, and it looks like we use "/" to distinguish a file path. I
> wonder if allowing "!my-sendmail" would be more consistent with other
> parts of Git (not to mention more flexible).

I am not sure '!' prefix fits well here.

When cloning from something (that is not yet known as an entity that
we must go over the network), we do an equivalent of "test -f" (for
bundles) and "test -d" (for local repositories), and I think the use
of "does it refer to a local file" here matches it as a precedent.

I do find it sloppy that the check uses file_name_is_absolute() that
only checks the shape of the string, without seeing if it actually
exists and is an executable file, though.

Thanks.
