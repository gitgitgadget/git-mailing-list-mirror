Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34706C433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiDFR2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiDFR2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:28:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFB19B046
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:29:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0DA312FBBE;
        Wed,  6 Apr 2022 11:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7uB/npqtDn6WGflYXVWejS9o0R0H0T7NoAV3FA
        YGZYE=; b=pdBusMfBGUbK4pZF0i+qzhhUp4UjBALZqJXMqnvq/vA8RaOQVEE2Xk
        23YqXcVxSIKlC9+HmVBlgKzs+lpu1/x0qbI9Q6LzUzz8XqJYhRBVX2nzwBjAn1MM
        IyLeRdg5YD9gsL9wOaWVuWYYrSv7lAZLnEcQXYnY40ks/DOyZ4oSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A733A12FBBD;
        Wed,  6 Apr 2022 11:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13FE412FBB4;
        Wed,  6 Apr 2022 11:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
        <220405.86sfqrlvoz.gmgdl@evledraar.gmail.com>
        <CAMMLpeSfxMgyJvWp9zTY6vNE4FPYJyY0HwAV-yBFSodac1R-xA@mail.gmail.com>
Date:   Wed, 06 Apr 2022 08:29:23 -0700
In-Reply-To: <CAMMLpeSfxMgyJvWp9zTY6vNE4FPYJyY0HwAV-yBFSodac1R-xA@mail.gmail.com>
        (Alex Henrie's message of "Tue, 5 Apr 2022 10:44:50 -0600")
Message-ID: <xmqqczhu1b8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 567BBDF4-B5BE-11EC-A4E0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

>> Now, the existing message really sucks, we should really should
>> buffering this up somehow and saying "here's the problem with these N
>> files\n<list of N>".
> ...
> Thanks for the extensive feedback. So, there are two problems here:
>
> 1. The current warning is very confusingly worded
>
> 2. The current warning is repetitive if there are a lot of files
>
> For the moment, I'm only trying to address problem #1. Junio asked for
> the file name to be moved to near the beginning of the message and for
> the second sentence to be removed. Tao asked to avoid the verb "check
> out" and said that "touch" was better. What wording would you suggest?

Heh, I do not ask contributors to do anything.  When there is only
one right way to write a code, I may tell them to do exactly that
way, but that is rare.  I only suggest an alternative or two and
have contributors to think themselves.  Ah, I am asking them to
think for themselves in that case, but that does not count ;-)

Anyway.

I do not have a strong opinion between checkout and touch myself.
Switching to "touch" did make it less technically incorrect than
saying "checkout" by making it a bit more vague, which can cut both
ways, but if "touch" can squelch complaints from hair-splitters like
"I did 'git checkout' (no arguments) immediately after I saw the
message but nothing changed", that may be a good change.

Between "we have a problem with long description in 'this file'"
that pushes the most crucial information to the far right in the
output that is necessary to tell where to look for the problem, and
"in 'this file', we have a problem with long description", I would
imagine that readers prefer to see the former, simply because it
lets them spot the pathname easier.  The repetitiveness is an issue
that may need to be addressed separately, and the repetitiveness
might make it look as if repeating the long problem description in
the front part of the message is better by aligning the repetitive
message and by numbing readers' mind, but I do not think that
benefit outweighs the downside of hiding more important information
by pushing it far to the right.

Just my two cents.
