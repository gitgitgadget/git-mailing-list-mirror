Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2DEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 09:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjFQJNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 05:13:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D7269D
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 02:13:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7CEE28E68;
        Sat, 17 Jun 2023 05:13:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7qbQ2SLnn2AmOuTwPATnkZmcQkw85ymte3gGnd
        MLbzc=; b=CroKyfzWiN/Fsew+H9DAMKWUxZBTDHygo8G5vJC5jfoBZc9ivE9lCZ
        +x0hDpqOHZxqw8iYTfkDTcEPtAQ39AmW5nNedYcQQVFhZNOZjnWqjsLpdkhw0+Yi
        aauUz/POaGTxeH00fKz/LT0/X6Deo7WhsANyWKlqaRxcmCo5zJqn4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0E2728E67;
        Sat, 17 Jun 2023 05:13:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE95528E66;
        Sat, 17 Jun 2023 05:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] http: handle both "h2" and "h2h3" in curl info lines
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20230617044232.GC562686@coredump.intra.peff.net>
        <20230617051559.GD562686@coredump.intra.peff.net>
        <20230617080705.GA2151825@coredump.intra.peff.net>
Date:   Sat, 17 Jun 2023 02:13:03 -0700
In-Reply-To: <20230617080705.GA2151825@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 17 Jun 2023 04:07:05 -0400")
Message-ID: <xmqq352qsb8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2ACE2050-0CEF-11EE-81CC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jun 17, 2023 at 01:15:59AM -0400, Jeff King wrote:
>
>> Ah, I see. It looks like it depends on which version of curl is using.
>> Perhaps the macOS image in CI has been updated (or maybe the new version
>> just became available via brew or something). I was able to replicate on
>> my Linux system by building and linking against curl 8.1.0, and the
>> patch above (modulo some missing parentheses) fixes it.
>
> Oh, and just to solve this one remaining riddle: it was indeed a change
> in the images. If you click through to the log of the failing osx-clang
> job in your first link, then expand "Set up job" and then "Runner
> image", you'll see that it was using:
>
>   https://github.com/actions/runner-images/blob/macOS-12/20230612.1/images/macos/macos-12-Readme.md
>
> which mentions curl 8.1.2. Whereas on your other link (where the jobs
> did not fail), it was last month's:
>
>   https://github.com/actions/runner-images/blob/macOS-12/20230516.1/images/macos/macos-12-Readme.md
>
> which has curl 8.0.1. So presumably every CI run from here forward will
> fail unless we patch it.

Wow, you are (as usual) thorough.  Thanks for digging.
