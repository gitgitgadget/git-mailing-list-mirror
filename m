Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E45C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 08:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379678AbiBEICU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 03:02:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53690 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiBEICU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 03:02:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F87D11DB15;
        Sat,  5 Feb 2022 03:02:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+OPejAW/+C1ipHC6ioBEgrZascZlBFYKcYQyHo
        sFAWU=; b=RkHZb8x6iS3OIrmVg3bNrJv0om40IBwwUZpnBqtnfl66SL0u8Q9NR8
        CN8PRf9F8ohYyIT0n4lEf6k2T2fsydGGx87qSm1EmWWFL8FAg72YKNSAPwqJHzSp
        1qUZTNXLQ3++fR9drOzb9juEFUJcRDhPh3C+4QLe0+bpW3oOVmZ/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3571B11DB14;
        Sat,  5 Feb 2022 03:02:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD05911DB13;
        Sat,  5 Feb 2022 03:02:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bojun Chen <bojun.cbj@gmail.com>
Cc:     git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2] receive-pack: purge temporary data if no command is
 ready to run
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
        <20220129063538.24038-1-bojun.cbj@gmail.com>
        <xmqq5ypvpgzr.fsf@gitster.g>
        <CADuS7Apcr0r6F1UQf1WKmVuW+SM_wD1MBPA9Szvd1pF9zJjsUw@mail.gmail.com>
Date:   Sat, 05 Feb 2022 00:02:17 -0800
In-Reply-To: <CADuS7Apcr0r6F1UQf1WKmVuW+SM_wD1MBPA9Szvd1pF9zJjsUw@mail.gmail.com>
        (Bojun Chen's message of "Sat, 5 Feb 2022 15:19:22 +0800")
Message-ID: <xmqq1r0hlp12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F091712A-8659-11EC-8FBA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bojun Chen <bojun.cbj@gmail.com> writes:

>> This check can _almost_ be doable without being able to access the
>> new objects, and as a follow-on work, it might not be a bad little
>> project to see how we can move the call to check_aliased_updates()
>> before this loop we are adding in this patch (#leftoverbits).
>>
>> Thanks.
>
> Thanks for your suggestion, I agree with you. But I'm confused should
> I continue in this patch or start a new patch.

Neither.

You are under no obligation to take such a different project, which
may be vaguely related to this one.  This early return by itself is
a worthwhile improvement, so let's concentrat on finishing this
topic first.
