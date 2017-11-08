Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA321F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 01:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdKHB7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 20:59:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752043AbdKHB7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 20:59:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EC77B05C6;
        Tue,  7 Nov 2017 20:59:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IjNHg8nKTldPrvDusG/38srNvVs=; b=PgfmC4
        nqvmWcmpjV3pxUzSgyFjZOejyuTXF8lKNcfjuwOn8v3eo7BFPum4YKbeZlAURmxJ
        0007CYC5KNhZa98WeTi4yqex6Aa3+KdtJE3W0E7GKN9qJ0p5L1WS33AU6n8STqGA
        WUL2cmIzHSOBGx6EBVKqttqZQORo6YyY6uYDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e6ZyKgO99ze6KTyI2OkEghx6klDRK1TH
        WpHznA0Punb96k40MivlBNaICYaC3unjoWKK3ac/XA9JjMGLUIAGZZoKsjcgnXwl
        9gzVGjvlmJFG2Qh6udKfQ/eKAVsirHMXcQ1zYzDLg0047Lgn0Lrea3sqa1riOZhc
        bEr0TqSEBK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85942B05C5;
        Tue,  7 Nov 2017 20:59:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3351B05C3;
        Tue,  7 Nov 2017 20:59:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Ann T Ropea" <bedhanger@gmx.de>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
References: <20171105162730.31405-1-bedhanger@gmx.de>
        <20171107025321.31028-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
Date:   Wed, 08 Nov 2017 10:59:52 +0900
In-Reply-To: <83D263E58ABD46188756D41FE311E469@PhilipOakley> (Philip Oakley's
        message of "Tue, 7 Nov 2017 23:25:02 -0000")
Message-ID: <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8362B034-C428-11E7-ABFD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> But...
>> ...
>> This change causes quite a few tests to fall over; however, they
>> all have truncated-something-longer-ellipses in their
>> raw-diff-output expected sections, and removing the ellipses
>> from there makes the tests pass again, :-)
>
> The number of failures you report in the test suit suggests that
> someone somewhere will be expecting that notation, and that we may
> need a deprecation period, perhaps with an 'ellipsis' config variable
> whose default value can later be flipped, though that leaves a config
> value needing support forever!

Hmmm, never thought about that. 

I have been assuming that tools reading "--raw" output that is
abbreviated would be crazy, because they have to strip the dots and
the number of dots may not always be three [*1*].

But you are right.  It would be very unlikely that there is no such
crazy tools, so it deserves consideration if we would be breaking
such tools.

On the other hand, if such a crazy tool was still written correctly
(it is debatable what the definition of "correct" is, though), it
would be stripping any number dots at the end, not just insisting on
seeing exactly three dots, and splitting these fields at SP.
Otherwise they would already be broken as they cannot handle
occasional object names that have less than three dots because they
happen to be longer than the more common abbreviation length used by
other objects.  So in practice it might not be _too_ bad.


[Footnote]

*1* When we ask for --abbrev=7, we allocate 10 places and fill the
rest with necessary number of dots after the result of
find_unique_abbrev(), so if an object name turns out to require 8
hexdigits to make it unique, we'll append only two dots to it to
make it 10 so that it aligns nicely with others) and they would
always be reading the full, non abbreviated output.  The story does
not change that much when we do not explicitly ask for a specific
abbreviation length in that we add variable number of dots for
aligning in that case, too.



