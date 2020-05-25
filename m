Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66759C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 00:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB812076C
	for <git@archiver.kernel.org>; Mon, 25 May 2020 00:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sKsF1At9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgEYA15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 20:27:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55696 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388431AbgEYA14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 20:27:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D51DDB303;
        Sun, 24 May 2020 20:27:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Whl5Mr0LwuOw0xRQLPEIw8xTX0o=; b=sKsF1A
        t9C++PRs0lqG6YBpInsaxr5ZgbluN9r2txyvBS+7sTfxHS3FhGXFQquCU0HkuBjK
        CYM6cTZpFrPC2rY4rnRA8wF28K7X+HNAUQ61uAwmfzAhi+4EIv6sfiMhxzhqMAUX
        tp/lEve62BMT2+Rdxs1W2cAxXSdVFNCed2hZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlkTMlzdoAgQv5bJcRm23iY8WZaKaeNf
        0paDL39GOLXgpis2YVJXzs7kiknJOAD19wbHlzwNDyOOk8j9Lkd3XCDCvylYbYno
        0j7IVbNVFqI2xxzRmJL1H6PreOqhQAyvag2VOy8AMsfMnC62Maz+q+shed1SHNmm
        2MGvXGYv5UI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85418DB302;
        Sun, 24 May 2020 20:27:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CCD8BDB2FE;
        Sun, 24 May 2020 20:27:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     asottile@umich.edu, git@vger.kernel.org
Subject: Re: git git<tab> completes non-existent command `git gitk`
References: <CA+dzEBnpheB-ZT5+bajKphux-+7gYFx1Msws7mXM=LOJO7pukw@mail.gmail.com>
        <20200524213808.24849-1-matheus.bernardino@usp.br>
Date:   Sun, 24 May 2020 17:27:52 -0700
In-Reply-To: <20200524213808.24849-1-matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Sun, 24 May 2020 18:38:08 -0300")
Message-ID: <xmqqlflgq2nr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92DF3FFA-9E1E-11EA-98CF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This should solve the problem, althought it's admittedly not very elegant...
> Nevertheless, I'd be happy to send a complete patch if folks are happy with the
> workaround.

Please don't.

> In the meantime, you could use:
>
> 	git config completion.commands -gitk
>
> To locally remove the completion for "gitk".

I think an equivalent of this in-core would be the way to go.  I
wonder if there are any commands other than gitk that cannot be
invoked as a subcommand of "git" potty.

t/t9902-completion.sh would be a good place to test this.
