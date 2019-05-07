Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49F71F45F
	for <e@80x24.org>; Tue,  7 May 2019 16:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfEGQHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 12:07:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64886 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfEGQHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 12:07:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6F19149F2F;
        Tue,  7 May 2019 12:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nt2cJI1f19ft
        Ul03luM25A7lWOQ=; b=bRxxom2HNIju4/oLJO+JmZ+2qIb85ZE66cfRx/S3NwNf
        t3/FcadIJFE/N8GWUaihItte5nRpW4b4EUnKG7uXcP3Z+K6wCo9RgLY6H0lHdU10
        5x0Lof2UjC2ucLkGuxiWTRhAbNQhMrfm+simD3lTDJuQr3cW5kJaUUwAEC2Sac8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KiQ+LI
        X7i0mjz1m0yrxfDamDVWpwEF8mCNZFUnO/EC5Rbibxb5LNRisvvsn6Argi59S1Zm
        man1SNYcPrK9sY//y1aVTCStltyW+5lBUKqJtlYcverJQyi3x0gcrWT/OU8dz5fy
        NKXhsNLOQy3BTW+1pXXnnRDj248PqoiSabGnU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC947149F2E;
        Tue,  7 May 2019 12:07:29 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 298E4149F2D;
        Tue,  7 May 2019 12:07:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
        <20190507151530.GO14763@szeder.dev>
Date:   Wed, 08 May 2019 01:07:27 +0900
In-Reply-To: <20190507151530.GO14763@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 7 May 2019 17:15:31 +0200")
Message-ID: <xmqqpnoujlj4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3690802A-70E2-11E9-9E19-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> This patch and the topic 'pw/rebase-abort-clean-rewritten' can't be
> compiled on its own, because it starts using 'struct replay_opts'
> here, which is defined in 'sequencer.h', but 'builtin/rebase.c'
> doesn't include that header yet.  (Though 'pu' already builds fine,
> because commit 0609b741a4 (rebase -i: combine rebase--interactive.c
> with rebase.c, 2019-04-17) in the parallel topic
> 'pw/rebase-i-internal' adds the necessary #include.)

Thanks; that's entirely my fault.  I needed to find a good fork
point and failed to do so.  FTR, when there are too many topics
I need to queue on a given day, I may not have time to compile
check individual topic branches before merging them to the
integration branches, testing the integration branches and pushing
them out.  That was what happened here.

> So, to keep future bisects from potentially tipping over the compiler
> error, this patch should either #include "sequencer.h", or be applied
> on top of 'pw/rebase-i-internal'.

I suspect that the latter was how the patch originally was
developed.
