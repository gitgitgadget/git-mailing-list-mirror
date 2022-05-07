Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE0C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446805AbiEGS3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGS3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 14:29:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C4220FD
        for <git@vger.kernel.org>; Sat,  7 May 2022 11:26:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28E2418FAE0;
        Sat,  7 May 2022 14:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b6bQ7TTQF1yZ8yH1rgoiqF+YpC7ReiLNTJZ891
        c6/aI=; b=PgBcp2RG8Q6CCvqbSXpJwUDMpWnNHXVQUtYJHA28V93/ttJvVkJ0Uz
        nbdi0C6hnhjzbRjYbabbLuHlBkwag4LetmrZ/ot+cqG5mf/AQVJfG5omKLw8JxIQ
        yazLjrM1apM7e6ljfCx/akW8eeczPpwxr4wx2OUN81DP7pIGT9z4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 140CC18FADF;
        Sat,  7 May 2022 14:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DE0A18FADC;
        Sat,  7 May 2022 14:25:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] bisect: status improvements when bisect is not
 fully fleshed out
References: <cover.1651796862.git.chris@chrisdown.name>
        <YnZQvuyeu/WZLhXH@chrisdown.name>
Date:   Sat, 07 May 2022 11:25:58 -0700
In-Reply-To: <YnZQvuyeu/WZLhXH@chrisdown.name> (Chris Down's message of "Sat,
        7 May 2022 11:58:06 +0100")
Message-ID: <xmqqk0axgpxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24BC2212-CE33-11EC-AA05-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Down <chris@chrisdown.name> writes:

> Thanks Junio and Taylor for reviewing. I have the following action
> items for v3:
>
> # [1/3] bisect: lowercase "Bisect:" to "bisect:" prior to wider use
>
> - New patch

My preference actually were to leave this change out of the topic.
That is, instead of using "status:" in newer messages, have them use
the same "Bisecting:", so that all the "where we are in the bisect
session?" messages from the command use that same prefix.

I also wonder if the existing "Bisecting:" messages should also be
sent as comment to the log file, using the same bisect_log_printf()
helper (with the v2 patches, they are still using printf() and sent
only to the standard output).

But this, just like "status:" -> "Bisecting:" -> "bisecting:" you
reacted to, is just "I wonder...", and is not a suggestion to make
changes as part of this series.  Something to think about for a
possible follow-up after we complete this topic.

But I do not mind if you want to go the extra mile to do all of the
above as part of the series.  It would make the series to require
more reviews, which is why I generally recommend against extending
the scope of the (initial) topic too much and instead leave as much
additional changes to follow-up series after the initial series is
done.

> # [2/3] bisect: output state before we are ready to compute bisection 
> - Fix multiline comment style in bisect.h
> - Zero-initialise bisect_state directly, don't use memset()
> - Pass the bisect state struct as an argument into bisect_print_status
> - Change from "status:" to "bisecting:"
>
> # [3/3] bisect: output bisect setup status in bisect log
>
> - Use strbuf in bisect_log_printf
> - Change `git bisect log' use an output file in tests instead of piping
>
> I'll wait a bit to see if there's any further feedback and then will send v3.
>
> Thanks!
