Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F1C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiAYTAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:00:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58727 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiAYTAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 14:00:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1230016C83E;
        Tue, 25 Jan 2022 14:00:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0moDJ4fWEKDcdNbcG//s8/XIltzRRTHJGv7v8k
        CkNEE=; b=rPnWlEdATV4nOldgqpFMsmo0aSpi6WnPYwT8X0mqGcETecQVHjgy9s
        kFTrJRurSc3syWsrYw30sg1GgPN7aQny8orMzOjv2EMC3GrZcMc/8Z0SnL2ql4et
        6TcXepgLJ1Laua6G6d3wALOqbhZMUXHlnnw4XF9VhVxfAuMhbziMo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B46816C83D;
        Tue, 25 Jan 2022 14:00:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 799CC16C83C;
        Tue, 25 Jan 2022 14:00:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
References: <xmqqsftc3nd6.fsf@gitster.g>
        <20220125092419.cgtfw32nk2niazfk@carbon>
Date:   Tue, 25 Jan 2022 11:00:39 -0800
In-Reply-To: <20220125092419.cgtfw32nk2niazfk@carbon> (Konstantin Khomoutov's
        message of "Tue, 25 Jan 2022 12:24:19 +0300")
Message-ID: <xmqqa6fjzlm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16E21CF4-7E11-11EC-B2DC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> Sorry, I might have not followed the entire thread, but assignment in
> `local` is a bashism, and dash can only handle the declaration part with
> `local`, not assignment; hence the safe code should read
>
>   local x
>   x="$1"

Interesting.  As "local" is not in POSIX but we still use it for
convenience, we must limit our use to a reasonable subset of
features common to the shells we care about.  Knowing what each
shell can and cannot do safely is essential to us.

The patch posted seemed to run fine with a more recent dash than
what I had trouble with (0.5.10 would work fine with "$1" quoted,
0.5.11 would work fine without $1, just like the RHS of a regular
assignment).  In addition, there are many existing tests that
already use "local var=initial-value" (the message you are
responding to has an output from "grep") and we haven't got problem
reports from dash users about them.

The manual page for recent dash may need an update.
Can you perhaps file a bug on their documentation?

Thanks.
