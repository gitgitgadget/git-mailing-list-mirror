Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B32F2021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbcKPASQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:18:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63375 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933639AbcKPASP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:18:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B1E74FD71;
        Tue, 15 Nov 2016 19:18:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=evi2w2WB5gKOwZ3gipAgyUX4IRQ=; b=tn0fDl
        Tu3gJS/bXyse1oVCTiKJevKgGvl/KfixPSHunc1sWnm2DUOw75a+lKksEl8CLIlF
        c1NY5CH8KvTHgLoocCDwAlkEd4rsmC1d3kS9FOiAOs+ShhfthcAi8q/dc0rv+72f
        WIzytVKuFyGki9amYor4qw/IT3qk2/Qljk/WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vSxrmWaF0RmY+fK7QEvSW6cvLTpLlG2A
        u/tCsa2YBsmdAAeu32esqYsRQRezCypfiUwffx09e3xmTrTtrgSwCTBN7mruM/dS
        Q7D08NL45qXecpHiWOxher7fUqQnglHNenCaSZK+Sb1PDAlK7o4kcrJIch3tDJpd
        RUK00ZUYS8U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 938954FD70;
        Tue, 15 Nov 2016 19:18:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 141C24FD6D;
        Tue, 15 Nov 2016 19:18:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
        <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
        <20ffa616-765d-ef73-4133-977561105eff@gmx.net>
Date:   Tue, 15 Nov 2016 16:18:12 -0800
In-Reply-To: <20ffa616-765d-ef73-4133-977561105eff@gmx.net> (Stephan Beyer's
        message of "Tue, 15 Nov 2016 22:40:31 +0100")
Message-ID: <xmqqpolws2ez.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A1EA6AE-AB92-11E6-A1E5-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> Besides the things I'm mentioning in respective patch e-mails, I wonder
> why several bisect--helper commands are prefixed by "bisect"; I'm
> talking about:
>
> 	git bisect--helper --bisect-clean-state
>...
> 	git bisect--helper --bisect-start
> 	etc.
>
> instead of
>
> 	git bisect--helper --clean-state
>...
> 	git bisect--helper --start
> 	etc.
>
> Well, I know *why* they have these names: because the shell function
> names are simply reused. But I don't know why these prefixes are kept in
> the bisect--helper command options. On the other hand, these command
> names are not exposed to the user and may hence not be that important.(?)

That's a good point ;-) 

These are not intended to be end-user entry points, so names that
are bit longer than necessary does not bother me too much.
Hopefully the longer-term endgame would be not to need a separate
"bisect-helper" binary at all but to have a "git bisect" binary
making these requests as subroutine calls, and at that point, the
names of the functions would want to have "bisect" prefix.
