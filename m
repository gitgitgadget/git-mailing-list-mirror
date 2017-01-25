Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A2C1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdAYVjs (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:39:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60154 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751881AbdAYVjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:39:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79463645A6;
        Wed, 25 Jan 2017 16:39:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LIhiUAaGETQbjNLZKAwjMFTuWZo=; b=WrInKi
        aoFMwBJW2gY1RUazyeGUdPR+yYH3/NgQoFY+l6jdwj3sCyX5JbW14EslVRiLzKQ+
        zKPONJucyGVDWQ0TmQeKSaiW625fQL64VfNJ4ceqkRuz7BMxj87y+OQ/zmRXGtZm
        UgqspMVVpCJW5EiXD92Ndvoo2T9rXSeifH4Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3EO/rcPQV3spSPKQwvd8O5SlKLhKSFw
        84C88CEgDtfHcfwNoaq8zzG4DSQn4qaruMHAohygabYBXB2HyppgB6aXLms6rA7L
        MDkRsHRbjjFinyZNnlqAHwIYKNfQrakdX3SxsrJGv96HLZkRkNiXasBh1JgMUL9G
        8sxHKGJd6Ug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70464645A5;
        Wed, 25 Jan 2017 16:39:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8EFB645A3;
        Wed, 25 Jan 2017 16:39:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
        <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 13:39:44 -0800
In-Reply-To: <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 16:15:30 -0500")
Message-ID: <xmqqy3xy95un.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA0C5486-E346-11E6-A063-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 25, 2017 at 05:58:42PM +0100, Johannes Schindelin wrote:
>
>> This change is necessary to allow the files in .git/hooks/ to optionally
>> have the file extension `.exe` on Windows, as the file names are
>> hardcoded otherwise.
>
> Make sense as a goal.
>
>> -	if (access(path.buf, X_OK) < 0)
>> +	if (access(path.buf, X_OK) < 0) {
>> +#ifdef STRIP_EXTENSION
>> +		strbuf_addstr(&path, ".exe");
>
> I think STRIP_EXTENSION is a string.  Should this line be:
>
>   strbuf_addstr(&path, STRIP_EXTENSION);
>
> ?

Yup, I think that is more in line with how git.c (the other user of
the macro) uses it.
