Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17261F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdKHAnp (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:43:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751792AbdKHAno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:43:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C58EAF743;
        Tue,  7 Nov 2017 19:43:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nUFy4g1xf/+FJlI2X+YcM9dT05o=; b=m0cJU9
        VtO5QNifD0SFxkgX2OdJvUVyCvKAS1jKTlCHv4uitIw/FdlxeF/2jyjsbl0GOUsy
        7DsmmJ0CoN5JK5je1nUd+/PJVb6rDHaryyynUhP2UzF6wt1pfsmR41/oYUCDwEJJ
        su0IHj8mpX2kebY48knWknKFqQuzzloXoh5io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w8qDEL3tBklqgPWF/Y9po9G/7hnIxF3I
        WsAgNJKTGB1aCvrDNxQLc3DA2L6tSpeUURvrYQ/5NCDHC1PxFtgvcZxfsfJZyIqR
        eWk//hJd69gY1I92RarYnqlsugeZGg7a/XbMAervzcriy61SUb8/u6LwMY/y4eoP
        GmWQhDKoyjw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73C7EAF742;
        Tue,  7 Nov 2017 19:43:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5C8DAF741;
        Tue,  7 Nov 2017 19:43:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] diff: --ignore-cr-at-eol
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <20171107064011.18399-1-gitster@pobox.com>
        <20171107064011.18399-3-gitster@pobox.com>
        <alpine.DEB.2.21.1.1711071345430.6482@virtualbox>
Date:   Wed, 08 Nov 2017 09:43:42 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711071345430.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 14:23:00 +0100 (CET)")
Message-ID: <xmqqh8u5ob0h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF62A318-C41D-11E7-84EF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 7 Nov 2017, Junio C Hamano wrote:
>
>> A new option --ignore-cr-at-eol tells the diff machinery to treat a
>> carriage-return at the end of a (complete) line as if it does not
>> exist.
>> 
>> This would make it easier to review a change whose only effect is to
>> turn line endings from CRLF to LF or the other way around.
>
> If the goal is to make CR/LF -> LF conversions easier to review (or for
> that matter, LF -> CR/LF), then this option may not be *completely*
> satisfactory, as it would hide mixed changes (i.e. where some lines are
> converted from CR/LF to LF and others are converted in the other direction
> *in the same patch*).

You are 100% right.

This feature is not about helping to review a patch that wanted to
do CRLF-to-LF (or the other way around) conversion at all.  Just
like the --ignore-space-at-eol is not a feature to make sure that
the only thing you did was to remove trailing whitespaces---it will
also ignore lines you added trailing whitespaces as irrelevant and
uninteresting.

In general, selling these "--ignore-*" whitespace options as a tool
for such a verification is incorrect.

These "--ignore-*" whitespace options are to help reviewing _other_
changes without getting distracted by the class of changes these
options represent.  I guess I may have to update the log message (I
do not think I wrote anything like that in the documentation update).

Thanks for pointing it out.
