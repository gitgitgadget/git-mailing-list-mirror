Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC98C0015E
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjHLIV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHLIVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 04:21:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F4211B
        for <git@vger.kernel.org>; Sat, 12 Aug 2023 01:21:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F188F19BA46;
        Sat, 12 Aug 2023 04:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1KMYv/qAIotfwo1StdR8ZgceZenFvY6fjfAPiYnSqnc=; b=IOhM
        2Ok07wlUYZMSlssp69B0w+8SkNq22gvdWSdc2I1Rs+vRPZiuMROwMCITaeCwqAJM
        gBw+cs/jyflNUF53ut94sYjdob/S5OBZ2MQb0190JUH1Z/5/KmXWJU1xhfkr4ksO
        QPv9WjFrbX5L28Bzt+seQnvwUMzZekqtw6xoA6E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D27C819BA43;
        Sat, 12 Aug 2023 04:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2398819BA42;
        Sat, 12 Aug 2023 04:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] format-patch: add --description-file option
References: <xmqqttta9h6a.fsf@gitster.g>
        <20230809171530.2564724-1-oswald.buddenhagen@gmx.de>
        <xmqq1qg9qmyq.fsf@gitster.g> <ZNa2VQQzZmaMzM4C@ugly>
Date:   Sat, 12 Aug 2023 01:21:46 -0700
Message-ID: <xmqq7cq0oelh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47689918-38E9-11EE-A3F3-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Fri, Aug 11, 2023 at 02:38:05PM -0700, Junio C Hamano wrote:
>>> +	if (strbuf_read_file(buf, desc_file, 2000) < 0)
>>
>>You would probably want to do "2000" -> "0" here.
>>
> hmm, yeah, i wonder where i got it from, given that there is no
> precedent. i suppose i simply thought that 2k is a reasonably
> expectable max size for a description. if you think the default 8k
> hint is a better idea, then let's go with it.

The suggestion was not about 2000 vs 8kiB, though it seems we stick
to power of 2 everywhere we are explicit.  Unless we know the exact
size from .st_size, that is.

It was primarily about this code not having any need to express its
own preference and go with whatever is the default.

> that's a good point. in fact, passing in the description directly
> would probably fit my use case better ... i just happened to already
> have the code for creating that temp file anyway (for editing), so i
> didn't give it a second thought. i can add both options in the same
> go, given that it's almost no code.

One thing that you may have to be careful about, if you also take
strings directly from the command line, is what to do with multiple
of them.  "git commit -m A -m B" that makes A and B separate
paragraphs with a break between them, I would think, would serve as
a good model that end-users already understand well.

Thanks.

