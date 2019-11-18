Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4DD1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 02:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfKRCWs (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 21:22:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRCWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 21:22:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25FF3A9EE6;
        Sun, 17 Nov 2019 21:22:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hKJFiP1KF4lyF6UJra/Dq6KHMHM=; b=GKZGDD
        984YNhuKurlSHyAKSIPCb/TO0BczBgnpAyAhVbosLmz9s2Sl5enmT0BOKTXNVRMS
        C+PTsJnY6dZmiIgAju+8YmD5eyqEjtfI1cZHAxjVs0xxYgPNsMvTyFKMl+Y1Yj/r
        iyiUfWkbo8yPQMWsBuLNwxqnUIipJn9bN+9s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FKiE7WaCu8e701BQ9uM0oGkcYXCfkjEt
        U1Hrkomv6ODT27jv0oGmiUBbwhF9V8+HnsmZVHiKkjSg2SeOao/4oj5hpAGZ1Y1h
        Cs6ykec1SUSC9roeNtJxodxmC2RHLY1Vq7++gEzqwa1HJgZ6yWp06zXRTthtsXHU
        NqLhMmip2BI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E0AFA9EE5;
        Sun, 17 Nov 2019 21:22:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D445A9EE3;
        Sun, 17 Nov 2019 21:22:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/8] build-in add -i: implement all commands in the main loop
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <xmqqwoby2ais.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Nov 2019 11:22:41 +0900
In-Reply-To: <xmqqwoby2ais.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 18 Nov 2019 11:17:31 +0900")
Message-ID: <xmqqpnhp3oum.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D3F8828-09AA-11EA-A331-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> Based on the js/builtin-add-i branch, this patch series implements the rest
>> of the commands in git add -i's main loop: update, revert, add_untracked, 
>> patch, diff, and quit. Apart from quit, these commands are all very similar
>> in that they first build a list of files, display it, let the user choose
>> which ones to act on, and then perform the action.
>
> So, this obviously depends on the previous "let's start the main
> loop" series, in which I recall you found at least one remaining bug
> after sending the latest round.
>
> I'd prefer to queue this on top of the iteration of that series,
> which would hopefully become the final one, which would let me avoid
> one rebase of this series ;-)
>
> Thanks.

I found the v7 on the list, which is what I wanted to queue this on
top of.  So my wait is over ;-)

Thanks.
