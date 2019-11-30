Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86720C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501F420801
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lC43ZwrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfK3OhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:37:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63621 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfK3OhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 09:37:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 600BE3B795;
        Sat, 30 Nov 2019 09:37:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G041xVNfm2NWWSXcqHR9+Jk7mm8=; b=lC43Zw
        rHsSOKyA2LSq8Hl6Qll7l+//O9uU4pBp0GNY0nb5RmfWAYi45pGSopvIg+u47t0o
        Z966fCP5IojHKZr3UbKcv2B04vW8FH7WSGx500mDR7ndTLa4lF2DXrZhypPzW4jL
        llQC22uBVdlbo5tsh+0Rg6STUiVEYc4kWq+6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HMuuwVpQsYlzzuPdve9u5jmSDCDAh6JL
        W2dechyu7jZyJUYHK4cdISrZ4luQpYJrsh5iU7qU43g/QJjxlzxjR08s5oxifM5t
        9md4d3zPkSJVdz94mJnb+QHJ5L1wPfUSm9nKniMGpGV6dmXmMOojHwE9agSEXPFB
        qN/gPZi7bXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50A4A3B794;
        Sat, 30 Nov 2019 09:37:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D9033B793;
        Sat, 30 Nov 2019 09:36:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ryenus@gmail.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 0/2] commit-graph: use start_delayed_progress()
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
        <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
        <20191126122022.GB10290@sigill.intra.peff.net>
        <fe7c0e41-8379-4933-4ff1-026d3f1f8472@gmail.com>
Date:   Sat, 30 Nov 2019 06:36:57 -0800
In-Reply-To: <fe7c0e41-8379-4933-4ff1-026d3f1f8472@gmail.com> (Derrick
        Stolee's message of "Tue, 26 Nov 2019 10:39:14 -0500")
Message-ID: <xmqq36e54eie.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD3051F0-137E-11EA-9702-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/26/2019 7:20 AM, Jeff King wrote:
>> On Mon, Nov 25, 2019 at 09:28:21PM +0000, Derrick Stolee via GitGitGadget wrote:
>> 
>>> Update in V5:
>>>
>>> I took Peff's advice for using "env" to use this delay in the GC test.
>> 
>> Thanks. No further complaints from me. :)
>> 
>> There's an open issue to investigate unpack-trees sending progress to a
>> non-stderr tty (which you can see in the test suite by setting
>> GIT_PROGRESS_DELAY=0), but I think that should be handled separately.
>> My limited digging suggests that it goes back to 2007 or earlier.
>
> This is on my personal to-do list. Thanks!

Thanks, all.  It seems that this round is ready for 'next'?
