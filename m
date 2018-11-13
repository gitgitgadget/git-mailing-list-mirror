Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802151F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbeKMWEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 17:04:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65046 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeKMWEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 17:04:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6A933A864;
        Tue, 13 Nov 2018 07:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0zxTJINf7EHnHDZraYRtNa1bgS8=; b=By/gzK
        1HWd9k+hoWnyc48DqTwtOjtiXhAyCsbkVAAlxCnd8LyMQj7u81h5HHuV2i/nFgLb
        HWf8/TqosDJXXs4c5sgaXTaMBJufZf62qMTAEdTxYDAMO25xn/qIbeyWNiR2AK4s
        ZHyLmHq191fBYugQDClV5zMlXXlO8w/931juw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R/UwbtCf80FrnYappIuA1vbYv7ngY4tD
        5wQ+o5LcdhQ2a1G5VDOOEPGE9WOSU4EpWUM7z8rhs+C0vcQfQxFrNyo9nGB8QhZe
        RpqI4vSPxRw+6Cn/yRW5j9DNTpl5O0yDT7kcDSapxGybUbVGFLmIsBZfFQmVZ3qg
        afrk4tBlRz0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF8063A863;
        Tue, 13 Nov 2018 07:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDA1D3A862;
        Tue, 13 Nov 2018 07:06:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] rebase -r: demonstrate bug with conflicting merges
References: <pull.75.git.gitgitgadget@gmail.com>
        <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com>
        <xmqqh8glyajx.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811131109360.39@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Nov 2018 21:06:40 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811131109360.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 13 Nov 2018 11:12:18 +0100 (STD)")
Message-ID: <xmqqtvkluqpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95A184E0-E73C-11E8-866F-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> For a trivially small change/fix like this, it is OK and even
>> preferrable to make 1+2 a single step, as applying t/ part only to
>> try to see the breakage (or "am"ing everything and then "diff |
>> apply -R" the part outside t/ for the same purpose) is easy enough.
>
> I disagree. It helps both development and porting to different branches to
> be able to cherry-pick the regression test individually. Please do not ask
> me to violate this hard-learned principle.

A trivially small change/fix like this, by definition (of "trivial"
and "small" ness), it is trivial to develop and port to different
branches a single patch, and test with just one half (either the
test part or the code-change part) of the change reversed, to ensure
that the codebase is broken without the code-change and to
demonstrate that the code-change does fix the problem revealed by
the test change.  And "porting" by cherry-picking a single patch is
always easier than two patch series.

So you may disagree all you want in your project, but do not make
reviewer's lives unnecessarily harder in this project.

Thanks.
