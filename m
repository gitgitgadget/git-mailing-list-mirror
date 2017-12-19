Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1F91F406
	for <e@80x24.org>; Tue, 19 Dec 2017 16:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbdLSQd2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 11:33:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52541 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752053AbdLSQdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 11:33:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00826D3EF5;
        Tue, 19 Dec 2017 11:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nYCCem3jAhrVyCdwC926jGNCw58=; b=nuU7Pv
        7XJv4lTK5q8/MuwSRgs/mkGacVXEqTW8ElmQuCCv24Ni8/+wIYZPgbZIWxV77YdS
        U5qZdfeMK8fDNhJxXciOtlPDaA40Payrqzk0AHocCsKk4gTEUdUnppn++uMotWTj
        bW4Il/vEaffnVcCPDJHYFELwmrMKpl0hssX18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fn6xackKzfIVZeqqafLkyV2BigU1h6ve
        mMPL3tOu/F/I+50d5gkkaTiyEDDrJkuLKJi7WvCLwBAqWQG1mUmY3pbcVYT2nfte
        voSDR3v3DvX5WOYAtYMDqWsNPfD/PLhfxfBjuKY2e2llYX024F1xQIKKIJygQdan
        L9lcMuPXi+8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBD21D3EF4;
        Tue, 19 Dec 2017 11:33:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C375D3EF3;
        Tue, 19 Dec 2017 11:33:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: difftool uses hardcoded perl shebang
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
        <20171219162528.GA5804@sigill.intra.peff.net>
Date:   Tue, 19 Dec 2017 08:33:22 -0800
In-Reply-To: <20171219162528.GA5804@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 19 Dec 2017 11:25:28 -0500")
Message-ID: <xmqqlghywuct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 553A16C0-E4DA-11E7-9A58-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a build-time knob. When you build git, try:
>
>   make PERL_PATH='/usr/bin/env perl'
>
> (If you don't build your own git, then you might raise the issue with
> whomever packages your binary).

I somehow thought ANYTHING_PATH was meant to point at the exact path
(as opposed to ANYTHING_COMMAND which is a command line), so it is
within our rights to do

    test -x "$GIT_EXEC_PATH" || die "Your Git installation is broken"

but your suggestion above makes such a sanity check impossible.

I'd understand if it were

	make PERL_PATH=$(type --path perl)

of course, though.

> As an aside, git-difftool is now a C builtin these days, so the problem
> might also go away if you upgrade. ;)

Yup, true, true.
