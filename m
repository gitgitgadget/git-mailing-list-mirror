Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB9C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADB62051A
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qnWu/2r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBJWq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:46:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58620 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgBJWq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:46:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3221D3BAB1;
        Mon, 10 Feb 2020 17:46:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LSgkVcsM/vIDVkVjeRIFhGf0PEQ=; b=qnWu/2
        r7lVpCPGCsA2fZoy9ybQMeeBT40S7l7m42zZ+JuHRY6YYgEGl153tLgd5Zuk+CzT
        NCBtItP9RrzTd22ob0gCWvKCIs+i3bCYJ2w6yUjSrBt1cQNPCoCZSWkky6AeTyhv
        trsA6YDE9HEAkr/kRk5ydFDHBbw6mTKpv/XM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d0BnN+xvJpsJZrQEcrAn7kon1JCWmsnh
        9fIChnfHDOsClkGImtm4XTszNDXw4esPXumxZI3V7H6ZGqrnWZOFKbVdbSRvvEf4
        xpSmoXq/CrNg86FGaZGhWXubSOBfrl5cfhmyuo/Pr/BVLUL56a2ijSo0xcG0n5mw
        21yVNktj+Xs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 297133BAB0;
        Mon, 10 Feb 2020 17:46:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 877463BAAF;
        Mon, 10 Feb 2020 17:46:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:46:23 -0800
In-Reply-To: <pull.548.git.1581311049547.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Mon, 10 Feb 2020 05:04:09 +0000")
Message-ID: <xmqqeev2xdq8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B03601E-4C57-11EA-AD16-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     A new advise_ng() is introduced to gradually replace advise()
>     
>     pros of the new advise():
>     
>      * The caller doesn't need to define a new global variable when
>        introducing a new message.
>      * The caller doesn't need to check the visibility of the message before
>        calling advise_ng().
>      * The caller still needs to come up with advice.frotz config variable
>        and will call advice_ng as follows: advice_ng("advice.frotz",
>        _("helpful message about frotz"));

Readers would expect to see "cons of the same" to follow "pros".

>     After this patch the plan is to migrate the rest of the advise calls to
>     advise_ng and then finally remove advise() and rename advise_ng() to
>     advise()

As I outlined in [1], I think the over-simplified
"advise_ng(<advise.key>, _(<message>), ...)"  would be too limited
to replace the current users, without a pair of helper functions,
one to just check for the guarding advise.key, and the other to
unconditionally show the message (i.e. the latter is what the
current advise() is).

>     [1] 
>     https://public-inbox.org/git/xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com/
