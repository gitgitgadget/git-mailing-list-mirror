Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4FBC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 05:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiLTFyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 00:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTFyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 00:54:12 -0500
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294610B56
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 21:54:09 -0800 (PST)
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
 <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1671515647;
        bh=DsqMKM5Q27vcsoFR8GXQtkbvkDgMI77640Io7DHfqB0=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Mime-Version:Content-Type:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=MLQHPUvzzVwEwp1yk/WnrW2GIqwIRaD6gm70tg36kusnHvWLX6qoVIruv+6ReL1no
         c6Nrfqxcr3wiN/L/WGBSw72hXAZf30cy0Hux82f4t18LtPRCX670FbFQ3n5ogf4OGV
         +DKgWBqO63PfY0shPWLfBotAZAKVSdSjlLReR6OcL26cALQ6ut09KGIIsFbYAwp6mu
         7C6utneWqNBqMNW/EiCjq8g1CExgp0HqzuEi52nb7YgUUd3RBhKEAYcRneHsGMzHkA
         LEDoUcyCeYBg7Vx7xaAtWGmtMh0cpIt7lxIQrPG8EQ+GcYYXWiJQYPhL0FAilGyPcE
         7Yt2OfEq6Q2HQ==
From:   Toon Claes <toon@to1.studio>
To:     phillip.wood@dunelm.org.uk
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
Date:   Tue, 20 Dec 2022 06:31:40 +0100
In-reply-to: <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
Message-ID: <87a63i7h8h.fsf@to1.studio>
Mime-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for working on this. I'd previously suggested NUL terminating the output
> of "git cat-file -z" to avoid this problem [1]
>
> [1]
> https://lore.kernel.org/git/66b71194-ad0e-18d0-e43b-71e5c47ba111@gmail.com/

What happened to this proposal? I don't see any replies to that. That's
a bit sad, because it would have been nice to have it this behavior from
the start.

> but quoting the object name is a better solution.

I would not say it's a better solution, but it's a less invasive
solution that /minimizes/ breaking changes. Ideally I'd like to have NUL
terminated output for "git cat-file -z". In a success situation I
assume this would return:

    <oid> SP <type> SP <size> NUL
    <contents> NUL

In a failure situation something like:

    <object> SP missing NUL

So when you pass -z you can keep reading until the first NUL and then
you'll know if you should read for contents as well.

Would you consider change behavior to this now?

--
Toon
