Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDB11F97E
	for <e@80x24.org>; Tue, 13 Nov 2018 01:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbeKMLpO (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:45:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61165 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLpN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:45:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A65C3752D;
        Mon, 12 Nov 2018 20:49:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=40anUZaryyTxoP3nblKMd8yzJF8=; b=FCtW50
        NzKMkdqdNtsseUgwPetE0SmC92jBs0Y6hDxGTu9S5uMI9+wrMLoQRIKb7+XApkuA
        sFfEKXvhioviH36f5wWhiiuLcA1ARVr7K7C895e+EdmUR/ttXsvB011Yef/smK3R
        2XeKzBMA9aGywLpIPmcg4U+HA6yP+R/vnR6EU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RgbKNniU7EAVASBQrHtCtU5I44MB0oCp
        bs7XyO5KCBrbuBnmlTeMtoi5GXexrcCPHpPbw7ldbqBGkF5WMBJchjG2ctkyR564
        GEK/AOZPCriiiPjISdJLihG9WuL1dCzdhXfHVBact8Yaw9u1XuE0DN72LrZz8C10
        fXtpGaDK7eE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 233913752C;
        Mon, 12 Nov 2018 20:49:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20CF237529;
        Mon, 12 Nov 2018 20:49:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior where appropriate
References: <pull.72.git.gitgitgadget@gmail.com>
        <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
        <20181109101148.GB7410@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
        <xmqq1s7r3pqy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811121235120.39@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Nov 2018 10:49:18 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811121235120.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Nov 2018 12:42:45 +0100 (STD)")
Message-ID: <xmqq1s7pzqzl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 566AFE24-E6E6-11E8-9CDD-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> On the other hand, for a file-scope static that is likely to stay as a
>> non-API function but a local helper, it may not be worth it.
>
> Oh, do you think that `reset_head()` is likely to stay as non-API
> function? I found myself in the need of repeating this tedious
> unpack_trees() dance quite a few times over the past two years, and it is
> *always* daunting because the API is *that* unintuitive.
>
> So I *do* hope that `reset_head()` will actually be moved to reset.[ch]
> eventually, and callsites e.g. in `sequencer.c` will be converted from
> calling `unpack_trees()` to calling `reset_head()` instead.

As long as the public API function is well thought out, of course it
is OK.  Ideally, builtin/reset.c can detect when it is making a hard
reset to HEAD and call that same function.  Which may or may not
mean you would also want to tell it to record ORIG_HEAD and remove
MERGE_HEAD and others), perhaps with another bit in that flag word.
