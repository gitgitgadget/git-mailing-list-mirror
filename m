Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81011F45F
	for <e@80x24.org>; Sun,  5 May 2019 04:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfEEECJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 00:02:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65488 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEEECI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 00:02:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 052BF14F27C;
        Sun,  5 May 2019 00:02:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dEb9SxEdbsTzy2vz7IDamdqNe28=; b=xuXtUm
        Q3eOYTIwCnA9Zl8T7EZXN+phg1YqMl815gcS3ZMRPdkv3r3sA0Xr3OpvI3skh40d
        8zyib07tOt6afWX/R3dA54cU2LeXtXRkX93/xlP3sv4R111g1Nc7dffBnYskFyH4
        OVZhLpAxj1Dz8nzEG2m7LtpgX9klptrl4e3vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xdaLEb7R950SB4czLtIWlW1uVm1trdOf
        DnOOHlIAyu22dWGjlRoKOX0ROCokmaW5S4idM6CyKSMZTzm8mZXckyn1ybEO8pdl
        9jgNb0NheKg86+lx2m5D9I+Y2VVWuSS2Mm1M1m0MrJsS0O+w/Lm3Ta+fXYJnZ+mv
        qTQTWlRVbMA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0A4814F27B;
        Sun,  5 May 2019 00:02:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65AA214F27A;
        Sun,  5 May 2019 00:02:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     wh <microrffr@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
        <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
        <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
        <3bf0f04d-83d4-ef13-8e19-a679b4153793@gmail.com>
Date:   Sun, 05 May 2019 13:02:06 +0900
In-Reply-To: <3bf0f04d-83d4-ef13-8e19-a679b4153793@gmail.com> (Phillip Wood's
        message of "Thu, 2 May 2019 16:45:46 +0100")
Message-ID: <xmqq4l69tupt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CC00E24-6EEA-11E9-903D-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've had a look at the rebase -i code and I think it only overwrites
> ignored files when it is fast-forwarding. This matches what merge does
> when fast-forwarding but I'm not convinced either of them should be
> doing this by default (I think checkout doing it is probably asking
> for trouble)...

> I'll put a patch together to fix rebase -i, I'd like to see the
> defaults for merge and checkout changed but I'm not sure that would be
> popular.

I suspect that such a change in behaviour for "rebase -i" is not a
fix but a regression.  Shouldn't it be consistent with checkout and
merge?

> It does seem like surprising behavior though when most
> operations try to preserve untracked files.

Are you conflating untracked and ignored?

Because we haven't adopted 'precious' (or whatever the final name
would be), which is "ignored but not expendable", ignored files are
by definition "ignored and expendable".  When checkout (and merge
that is its more general form) needs to match the working tree to
the index contents and an ingored file is in the way, it should
overwrite it.  

Until we introduce "ignored but not expendable" class, that is.
