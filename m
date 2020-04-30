Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720CEC4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEB3206C0
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ryte83qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgD3VOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:14:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50321 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgD3VOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 17:14:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A5562BB3C0;
        Thu, 30 Apr 2020 17:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SYH4AgnoMQ1I5o4iZC/Lv6EOSU0=; b=ryte83
        qN4sCP0jCHtCpmTEVPu8XXDUXgxvObJn83SA5RcxvLdR5yQZqeyEKlVmxuKAVtja
        /QUONQAiEXP2hiM0j5AV7npau17u9J0zE+TsP6M0ecPj1UlxaYVt7+gd7gqbqEzh
        Jdm3kUev531m2iiY6avb0Gnya3vf3vvNoVfAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WefYrHdgyUMmjMvFRS9IbqE1FJZ8R02R
        8KrOojstjKS+Q/Aj3fo5pd6if1oo2DcfavGRo0mTbE9vfYnSaTSAVlXSWlrR0D/U
        CyCXWvN5c+TzRvec0VBD8CE7Lv4TcMog1nvP6Yw7zprO3v7v87r+4UoRQeKAv8iX
        aFPLNfJ8RnY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D1ABBB3BF;
        Thu, 30 Apr 2020 17:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3B20BB3BD;
        Thu, 30 Apr 2020 17:14:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus lines from store
References: <20200430011959.70597-1-carenas@gmail.com>
        <20200430160642.90096-1-carenas@gmail.com>
        <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
Date:   Thu, 30 Apr 2020 14:14:15 -0700
In-Reply-To: <xmqq1ro4sp1p.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 30 Apr 2020 13:21:06 -0700")
Message-ID: <xmqq7dxwr80o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CBE0D9A-8B27-11EA-B241-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[part of the commit log message]

>> Warn the user indicating the filename and line number so any invalid
>> entries could be corrected but continue parsing until a match is
>> found or all valid credentials are processed.

We should say "Do so only during the 'get' operation; give up giving
any warning for 'erase' or 'store' operation, as keeping track of
the line number of the input file, while having to issue a warning
that has the line number of the output file, is too hard for us" or
something like that here.

I suspect that it might not be "too hard", but we'd need to rename
other_cb to a more specific name first and limit the possibility of
repurposing parse_credential_file().  

For example, other_cb can become "copy_cb", we declare that the
function works in two (and no other) modes, one is to look-up (which
is read-only so we report the input line number in our warning
messges) and the other is to copy-out-with-filtering (which will
leave a file that is different from the input, so we report the
output line number).

To support the copy-out-wiht-filtering mode, we pass the starting
line number into the function (i.e. 'store' may store a new line, so
the first line copied out to the file may be the second line in the
output), and count the output lines there:

	if (other_cb) {
		lines++;
		other_cb(&line);
	}

and of course we won't increment lines++ when we saw a match in the
copy-out-with-filtering mode.  In look-up mode (i.e. copy_cb == NULL),
we count the input lines just like your code.

But I suspect that it may not be worth doing.  But if we decide not
to do so, we should document why we chose (not) to in the commit log
message.

> Validating and warning about bad entries is *not* the main purpose
> of the "credential-store" program, so I fully agree with the design
> of the "get" part.  I am not so sure about the other two operations
> (i.e. "store" and "erase") that do scan all the entries and has
> chance to warn about bad ones, though (note: I am not saying that we
> should parse verbosely---it is just that I do not know why you chose
> not to and I am not convinced that it is a good idea not to warn).

I re-read the incremental log for v8 and found your explanation.

Thanks.
