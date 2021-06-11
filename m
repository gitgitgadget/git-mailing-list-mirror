Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5BFC4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0188B610A2
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhFKGpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 02:45:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61121 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKGpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 02:45:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 458A6D5435;
        Fri, 11 Jun 2021 02:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JZeHrDM6UtrpHwakSs0aDUtxBGz6Lc6IUavNE3
        rFtwA=; b=CqE+pcSenB0OVgem/hJzkdqnWER3o1T8pNrMqDuR+Eo95uEySn1F+G
        Etb3QXGa67TeaZuDl4eZ1M3aE4pHrEIKIhAAvBexp0lNe6EOl55atrlsfUAvdep2
        I73hHOjadFbxF6/9KcM+8qZMtk1M7V3w8frIr8OnGNfongK1RMlDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A4F9D5434;
        Fri, 11 Jun 2021 02:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA6B6D5433;
        Fri, 11 Jun 2021 02:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
        <xmqqh7i5ci3t.fsf@gitster.g>
        <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
Date:   Fri, 11 Jun 2021 15:43:19 +0900
In-Reply-To: <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org> (Johannes Sixt's
        message of "Fri, 11 Jun 2021 08:23:30 +0200")
Message-ID: <xmqqy2bg3nqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FBA5A54-CA80-11EB-88E4-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> But I would estimate that most conflicts (in absolute number among all
> developers using Git) arise during rebase operations and cherry-picking,
> i.e., while one is working on their own code. In such sitations, the
> simpler conflict markup is sufficient, because one knows the background
> and reason of the conflicts.

"rebase -i" to reorganize one's own series would be a prime example
of "conflicts you need to resolve in code that is purely your own
and nobody else's", and cherry-picking used while reorganizing one's
own series falls into the same category.  I agree that a simpler
markup would be more appropriate in such cases.

Rebasing to catch up with updated upstream is a different story,
though.  The same for cherry-picking an earlier change to an updated
upstream.

