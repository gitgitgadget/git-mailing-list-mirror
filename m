Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9310AC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB7961155
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDBW1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 18:27:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59122 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBW1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 18:27:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89675134417;
        Fri,  2 Apr 2021 18:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+FHKjLgJUisJxi/vmhnunC3ANs=; b=w/Mk0p
        FhpgFttm/ANaeLxUNIYRVWNEVlZMWDOkXH4rspBnbERpheZqCA2pBJde05x4dQns
        tgx6UEDisUzKGhUteGDatYonxza0pfFYFK7jOykihp0L1SpKK1Gc6oSrSwJsLzt3
        ZbLH7hQo0PLOaopMdJnWfw6kwxyjlrzXSIeAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fx6+YqQaTZdeUveG2Uf7Dq/bwTKZDcX/
        Xiyl48s5t5iYsioyeIL3Iasr2vX88hmwrYJvTWk4yxBrmX3sQPRgAp12AapvQMIx
        cofdhJNWUk51g8ufuiutbHGU1obVncJBtQlzF1ZCgmoeA+vNY+fTXP6ne//cN8s5
        APO4CilDcso=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C963134416;
        Fri,  2 Apr 2021 18:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DBA5B134415;
        Fri,  2 Apr 2021 18:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
        <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet>
        <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
        <xmqqa6qg4d0i.fsf@gitster.g>
        <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com>
Date:   Fri, 02 Apr 2021 15:27:34 -0700
In-Reply-To: <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 2 Apr 2021 15:18:09 -0700")
Message-ID: <xmqq7dlk2ug9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF0F762-9402-11EB-B57A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Even if others now disagree with the above, I know I can get a huge
> speedup by changing sequencer to stop per-commit wasteful work (stop
> forking processes like "git commit", don't write control structures if
> the rebase hasn't ended or hit a conflict, don't update the working
> copy or index or reflog).  It's enough of a speedup that if backward
> compatibility won't allow such a method to be used by default, I'd
> still make yet another backend that could be optionally used.  And I'd
> have the default rebase and cherry-pick start printing annoying
> deprecation notices so that users become aware of a faster option.

A faster and less powerful interface is good; I doubt deprecation
would work well. If a workflow depends on things like post-commit
hook, the affected users deserve some way to migrate to --exec or
whatever method to compensate the loss of functionality.
