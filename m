Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78661C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA34610FB
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhINQa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:30:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52343 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhINQa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 12:30:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0242315C14D;
        Tue, 14 Sep 2021 12:29:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ni+U8Eu1K3Www/uLk0l1Kg/LZGlf04KqCZCrwd
        pmct8=; b=LmJpmTxcyJzpHpZpQ8n/s3vqSUyZp2Uzw1PUSZBekAK+5xgCyojlP/
        EUR1M/vKgBFXR2cO1CpwKydrO3MqjelY9ZsGDpQ6Jmue6IzTESd/cbgYShT3sG/Z
        dJMoC2VTQ89130H7K6eN8431I9iRI7oWdndwbf9CfcSlHKkfroJ34=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEA8315C14C;
        Tue, 14 Sep 2021 12:29:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F0D915C14B;
        Tue, 14 Sep 2021 12:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
        <xmqq5yv4ccc0.fsf@gitster.g>
        <5ef402a4-3477-6227-e08c-041ed373313e@gmail.com>
        <8c78eac4-676b-7bd1-0282-d52eb20f87ce@gmail.com>
Date:   Tue, 14 Sep 2021 09:29:04 -0700
In-Reply-To: <8c78eac4-676b-7bd1-0282-d52eb20f87ce@gmail.com> (Phillip Wood's
        message of "Tue, 14 Sep 2021 14:27:17 +0100")
Message-ID: <xmqqbl4v3yun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E15AF0FC-1578-11EC-91F0-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Did we auto-peel in scripted version of "git rebase" and is this a
>>> regression when the command was rewritten in C?
>> As far as I can tell we have never peeled tags here
>
> That's a bit misleading. We have never peeled a tag given as <branch>
> when we parse it. In the scripted version we just passed the tag oid 
> along to rev-list, checkout and reset and they peeled it. So I think
> this is actually a regression in the builtin rebase. I'll update the 
> commit message to reflect that unless we feel that allowing a tag for
> <branch> is a mistake and we should be erroring out to avoid the 
> possible confusion of the tag not being rebased, only the commits it
> points to.

OK, so this is a regression fix.  That makes the change much simpler
to sell.  I'd expect that the description would be along the lines
of something like this, perhaps.

    A rebase started with 'git rebase <A> <B>' is conceptually to
    first checkout <B> and run 'git rebase <A>' starting from that
    state.  'git rebase --abort' in the middle of such a rebase
    should take us back to the state we checked out <B>.

    This used to work, even when <B> is a tag that points at a
    commit, until Git X.Y.Z when the command was reimplemented in C.
    The command now complains that the tag object itself cannot be
    checked out, which may be technically correct but is not what
    the user asked to do.

    Fix this old regression by doing ....

Thanks for digging (and fixing, of course).

