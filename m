Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E61C1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfJBGSe (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:18:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55899 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfJBGSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:18:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3673035DA4;
        Wed,  2 Oct 2019 02:18:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3jQmKKRlXyDJ0aRnSHn1fahryME=; b=XZLDjK
        /tsu+iCg+bLQEC5NsfcEoLe1uPpKgwVoSy+RGlzWmnClJCsZfYTXw0cTpY0KtFaK
        pP5/GXTe19acWfroLfFucKmSGKsn/DecY9E7aufaVpMV1fbCWYT5ITjf4ATprtws
        VZq1yhdb6kxpqZlBvFGMlG5fVJwqCaIvnKuIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bnFnb61fQ2otrIXli2HVngvzIGmoArzO
        if3uTvcVgIR7uNPf0AYltxUmAqYmO534BLZ+ky8t8rXxKVmtzhSemwnGvuQ0AZjU
        a7owX+8l5L6qPrxb0L2VjiSeQF5WOFp/aThgrwsW9dt3SC+FMc1Rysl1OLn1RuQ6
        wLrUnZ2Qkys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DA7835DA3;
        Wed,  2 Oct 2019 02:18:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96F9735DA2;
        Wed,  2 Oct 2019 02:18:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-grep in sparse checkout
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
        <f3101c8f-9709-5bcb-35f0-39ffaf8aa809@gmail.com>
Date:   Wed, 02 Oct 2019 15:18:29 +0900
In-Reply-To: <f3101c8f-9709-5bcb-35f0-39ffaf8aa809@gmail.com> (Derrick
        Stolee's message of "Tue, 1 Oct 2019 14:29:00 -0400")
Message-ID: <xmqq36gbfz62.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7448C170-E4DC-11E9-9EC1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Is that the expected behavior? In a sparse-checkout, wouldn't you _want_
> Git to report things outside the cone?

That should be optional, I would think.  When you declare "by
default, this the subset of the project I am interested in", we
should honor it, I would think.

> At minimum, I would expect a new option to have "git grep" go back to
> the old behavior, so users who really want a tree-wide search can have
> one.

Yeah, a bugfix to honor SKIP_WORKTREE bit, followed by a new feature
to ignore it, would be pretty sensible way to go.

