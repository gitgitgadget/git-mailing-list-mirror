Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BDFA208DC
	for <e@80x24.org>; Fri, 25 Aug 2017 16:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbdHYQNd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 12:13:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50271 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933814AbdHYQNb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 12:13:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E60E9D4A3;
        Fri, 25 Aug 2017 12:13:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KwD9ud2PFpdYw3Hx0GrAMBYHwkU=; b=Lb2faf
        RdY5jKKLMWG3aNz7RQgvDRbZCPGDA/l56iaTbr8KdPwRrWnn1uEz8ebRVspgO8c9
        yLBI9WfLL93o0DyQigI5XLg42FV9R9E27+nAr7PwAUNiqJyue1nNibVpqa4TkycV
        lPD/ipv3EnJ77ASsK71IRHLJX/2AqQlQi83bU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m4fYLgvpdTcCAVlPJKXW+rpIKKiblpdr
        XydWQQSWhr//0bP1vAkjtamYQ9+vZoWzorlbWabrO+glpce6k0h1IdMAvUtHRx2B
        5lvihwHIiG2ZGjmKJ9wczWAjQmHEA6qlbJk6tk2EYgfrL83EQCF3pUNLNfoFK8eE
        NUznAP/sgQE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6593A9D4A2;
        Fri, 25 Aug 2017 12:13:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B145F9D4A0;
        Fri, 25 Aug 2017 12:13:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Should rerere auto-update a merge resolution?
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
        <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
        <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
        <alpine.DEB.2.21.1.1708251218460.7424@virtualbox>
Date:   Fri, 25 Aug 2017 09:13:29 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708251218460.7424@virtualbox> (Johannes
        Schindelin's message of "Fri, 25 Aug 2017 12:19:56 +0200 (CEST)")
Message-ID: <xmqqo9r3tyl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55F45B46-89B0-11E7-B52D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In my hands, I need to tell rerere to forget, *and then recreate the merge
> conflict* before I can resolve it again and let rerere learn the new
> resolution.

I can believe that---that is how I originally desiged "forget" to
behave.

Even though My quick tests to prepare a reply to Martin seemed to
show that unmerging was not strictly needed in today's Git in order
to forget and learn new, I wouldn't be surprised if an explicit
unmerging in addition to "rerere forget" was necessary, especially
if the original preimage were very different from the state before
the botched resolution was applied.

