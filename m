Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEDF20986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbcJDWsn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:48:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751512AbcJDWsm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:48:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C6D344AC6;
        Tue,  4 Oct 2016 18:48:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bW7ZI85mFFQpQVFs5FUJiwChowM=; b=sd016K
        nD09p1wVyGWoKWkTr130g+ooYJ3RMBCrdF1t6KVrmRlW1OBgbCm4kbo7xn3p46lb
        iih6tt6DP+oho9g8xfodxPobF6KXxx1wi4VDTMbjqD1SF8M8OHlzec3XhJDxEZtz
        EQ+mO/k1PHotch/SM+3LQG8iKtjdXO65xssfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NzXreRBUMeZfw7eGYbZvjJ6RSCY7LGc9
        f8FPCCMS3mL1eQlRLdndpaKrS//9lWxL1L+J840Pda7Sgn+HlDk+PaijwYtXPefe
        DFerzFM6jNOCtx6PdA0GIxdPcx/5sF7pn5JlkPa67D5tqtx60zJUydwlM+TuQrfc
        AIMstT6RQ0Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 927F944AC5;
        Tue,  4 Oct 2016 18:48:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E422844AC3;
        Tue,  4 Oct 2016 18:48:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rich Felker <dalias@libc.org>
Cc:     James B <jamesbond3142@gmail.com>, musl@lists.openwall.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's regex impl
References: <20161004150848.GA7949@brightrain.aerifal.cx>
        <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
        <20161004154045.GT19318@brightrain.aerifal.cx>
        <alpine.DEB.2.20.1610041802310.35196@virtualbox>
        <20161005090625.683fdbbfac8164125dee6469@gmail.com>
        <20161004223322.GE19318@brightrain.aerifal.cx>
Date:   Tue, 04 Oct 2016 15:48:37 -0700
In-Reply-To: <20161004223322.GE19318@brightrain.aerifal.cx> (Rich Felker's
        message of "Tue, 4 Oct 2016 18:33:22 -0400")
Message-ID: <xmqq37kbspbu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B18725D2-8A84-11E6-9CF9-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rich Felker <dalias@libc.org> writes:

> This is especially unfriendly when the semantics of the switch come
> across, at least to some users, as "your system regex is incomplete"
> rather than "git can't use it because git depends on nonstandard
> extensions".

The latter is exactly what Makefile patch that brought this change
says, I think.

    # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
    # feature.

Before the series updated the message to the above, we used to say:

    # Define NO_REGEX if you have no or inferior regex support in your C library.

which _was_ unfair to those who needed to set NO_REGEX for whatever
reason.  It was totally unclear "inferior" relative to what standard
the message was passing its harsh judgement on your C library.
