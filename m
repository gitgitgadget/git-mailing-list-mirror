Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27AE1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 16:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbcHSQTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 12:19:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752067AbcHSQTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 12:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43BD8352E6;
        Fri, 19 Aug 2016 12:19:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YG91An2M+N89+YwN4dqvF9Wa7w0=; b=WZDRE/
        rkbcAEuVqfL2ow2B5nLXlrhRXG1o/B4Ru9x8jA183wLMP8AWTiBWk3xAuZoJQQ31
        qcQosivvyvmWnQANMc+FXWGnQGDVWF76wzYX7BKMpCxgKb6PpJZDtPtY69fjLoFD
        TMCn0IYUECQmqYd0qkoR3DLt6s6qIq/BVYLt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rfF+Cvj27fm/OQR7GPS2QT3QMpKTbDqF
        dj6IBXV/gsvUztVXmWASFISTGf8ogfHG3vktzDgF9ysedklc1w8LU89FdMmK1LCh
        q8iBvMU6wwqh+yKckU2JDjqZ8R8JoeoTRMDQ0JNBQA2XOY38Wt2OmHEdtQLpU7WG
        AR6kI8ouFeo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BEC9352E5;
        Fri, 19 Aug 2016 12:19:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5BA7352E1;
        Fri, 19 Aug 2016 12:19:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
        <tboegi@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
        <20160818154213.GA17141@tb-raspi>
        <alpine.DEB.2.20.1608191423440.4924@virtualbox>
        <20160819150632.wa4wvidzqmrrkcfs@sigill.intra.peff.net>
Date:   Fri, 19 Aug 2016 09:19:47 -0700
In-Reply-To: <20160819150632.wa4wvidzqmrrkcfs@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 19 Aug 2016 11:06:32 -0400")
Message-ID: <xmqqtweg3f4s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C09C3A60-6628-11E6-9334-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Sorry, Torsten, this is not my doing. So I cannot explain why it is not an
>> enum.
>> 
>> I *guess* the rationale for 'c' being the cmdmode of --textconv is "c for
>> convert". That is why I chose "w as in worktree" as new cmdmode.
>
> I think it started as a 'char' because it was representing the
> single-letter options of "cat-file -e", "cat-file -s", etc. And then the
> textconv patches started the monstrosity of "c".

I think it was merely 't' was taken for "-t" (one beauty of using
the OPT_CMDMODE for options with shorthand is that we do not need
any enum, as the short-form options already form an enum), so
"textConv" was the compromise.  It could have been 'T' or even \C-t
;-)

> I don't think cleaning it up needs to be part of your series, but it
> might be nice low-hanging fruit for somebody to clean up on top.

I agree.

I briefly wondered if we want to add a check to ensure uniqueness of
these cmdmode letters in parse_options_check(), but that would
forbid us from having synonymous options (e.g. "am --continue" and
"am --resolved" both map to the same), so it would not work.

