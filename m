Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD7FC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8835224125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSHyfaG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAUSAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:00:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58508 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUSAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:00:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57D9EA0BD1;
        Tue, 21 Jan 2020 13:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xLhsxGa06HZ+XWYksKgb6zCec+k=; b=CSHyfa
        G5rkPvlA/i4xcy0s4rexvKYdnsnhuE5aGELnEnFnn5AkLnbP8l5bJr3VSSM/tkPR
        UArd5q9zrvptZXI7MTxdPewkknDdUkcGbiLUo/cRfZ1DmiDeKswCfikrLqcjZYUY
        sFAPvSgPx1LoxcXvbt1t9fvcV527m9MdDkcF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ibSRm/5t/P/Y0hAOuSsrPdV8P+LBBYOj
        n8AM9rtJPI51LdaIeQKi1TrZ3/nq8KyWTBkQTQgWR/V0jbDU7EKJoSdZP5Iyme7v
        noNwWhp7Z9mTn7gyfXmKg416/mwCyfBQgDIXw8iNT9pxhSof1f/8+Tz+oymxamnl
        dLj27r3fOp4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FCC5A0BCF;
        Tue, 21 Jan 2020 13:00:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BAAFA0BCE;
        Tue, 21 Jan 2020 13:00:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] Re-fix rebase -i with SHA-1 collisions
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <20200116235411.GZ6570@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2001171050000.46@tvgsbejvaqbjf.bet>
        <20200117223734.GA6570@camp.crustytoothpaste.net>
Date:   Tue, 21 Jan 2020 10:00:09 -0800
In-Reply-To: <20200117223734.GA6570@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 17 Jan 2020 22:37:34 +0000")
Message-ID: <xmqqeevsbsgm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE2DDA06-3C77-11EA-ADE2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> The question whether to move the SHA-256 support patch into your series is
>> more a question to Junio, i.e. which patch series will be merged down
>> faster.
>
> I need to do a reroll of part 8, so I'll pick it into a future series
> (part 9) of test fixes and drop my patch.  That way it won't interfere
> with either series making progress, but it will still be included at the
> end.

Alright.  Thanks for coordinating between you two.
