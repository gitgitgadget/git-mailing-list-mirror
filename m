Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB335C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381086AbiAaRqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:46:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57642 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiAaRqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:46:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 926121202BE;
        Mon, 31 Jan 2022 12:46:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b79mv51pLG1yesVj72brxRENyFUgkhNtkEng1W
        YbBSk=; b=XIfgzjH+YdeyuNNxy1bJq2GMKyhgvOIoWYT1Pn/hEpGXn+o/ihFULS
        1kzALFJ1RQBak2Ydygq10Hy0eC1uMoH7PyjZnS+7AR3QrIKe4ox6rer+zXaE49gN
        iYsSJLSpMBwuuosXOxfWyFasV2JZLG/e6vveTjSCREQzNU8OZzZJY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89FC51202BD;
        Mon, 31 Jan 2022 12:46:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE92D1202BC;
        Mon, 31 Jan 2022 12:46:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git ML <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: BUG: Various "advice.*" config doesn't work
References: <220128.867dakcgj0.gmgdl@evledraar.gmail.com>
        <YfgLeVw0rrk7Q5/+@nand.local> <xmqq1r0nke71.fsf@gitster.g>
        <YfgdsnfQ05ywre8l@nand.local>
Date:   Mon, 31 Jan 2022 09:46:32 -0800
In-Reply-To: <YfgdsnfQ05ywre8l@nand.local> (Taylor Blau's message of "Mon, 31
        Jan 2022 12:34:42 -0500")
Message-ID: <xmqqv8xziyrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB081DAA-82BD-11EC-89B8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> What I'm more or less trying to point out is that an unguarded advise()
> function defeats the purpose of the advice API, which should exist to
> avoid mistakes like these (where advice is printed to the user when they
> have already opted out of that advice).

advise() falls into the same category as die(), warning(), and
error().  It is a way to consistently format (and with a better
design to line-wrap, than its older brethren) messages.

We do not have "die_if(condition, format, ...)", but if there were
such a thing, that would be a good analogy to advice_if_enabled().

And a short-hand of die_if() would not make die() any unnecessary.

