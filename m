Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17984202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 15:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934209AbdKGPCn (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 10:02:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933751AbdKGPCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 10:02:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45BEDAF5BA;
        Tue,  7 Nov 2017 10:02:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Ale7fT8jjsYiSJfuGHBpIt6eEA=; b=yOecNG
        gB4a6KNUNo6f6SYmdXTCqVa4qhMyLgor3wP8TnGX5P1cFlfSlNrmtyCgeQGQt5Le
        hCLk6PtbIUI+XAK6i6FMn1S//V8nIAlOFCDdolABU6JulHVUg5IuVXRSaGuiQgiV
        p+Z43dIel3eZRhI5xe+9efup8tYQ4b+N0Od0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ciBN/qUTLLMJoRnX7WpUyFiYajcHUBlP
        YcXVPJ/nnZEyqN0ZFrhRXpJm+Mn3FMaOSe5kJoNQqqhZUxB2nlBxdij8dwDlWhkt
        GFLua9oz0qf2D9KR9NQ5MUYHrqzcuZZkAVL/COD9/IUvZH/oFi/C4OtsapKX6on6
        F6ieS+QuQfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CE00AF5B9;
        Tue,  7 Nov 2017 10:02:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A54C4AF5B8;
        Tue,  7 Nov 2017 10:02:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] xdiff: reassign xpparm_t.flags bits
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <20171107064011.18399-1-gitster@pobox.com>
        <20171107064011.18399-2-gitster@pobox.com>
        <alpine.DEB.2.21.1.1711071336120.6482@virtualbox>
Date:   Wed, 08 Nov 2017 00:02:33 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711071336120.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 13:44:44 +0100 (CET)")
Message-ID: <xmqqr2tadtdi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFB90DC4-C3CC-11E7-993A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
>> index b090ad8eac..cbf5d8e166 100644
>> --- a/xdiff/xdiff.h
>> +++ b/xdiff/xdiff.h
>> @@ -27,22 +27,26 @@
>>  extern "C" {
>>  #endif /* #ifdef __cplusplus */
>>  
>> +/* xpparm_t.flags */
>> +#define XDF_NEED_MINIMAL (1 << 0)
>>  
>> -#define XDF_NEED_MINIMAL (1 << 1)
>
> This change makes me wonder whether the least significant bit was omitted
> on purpose originally. You probably looked at that? May be worth
> mentioning in the commit message.
>
>> -#define XDF_IGNORE_WHITESPACE (1 << 2)
>> -#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
>> -#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
>> -#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
>> +#define XDF_IGNORE_WHITESPACE (1 << 1)
>> +#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 2)
>> +#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 3)
>> +#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | \
>> +			      XDF_IGNORE_WHITESPACE_CHANGE | \
>> +			      XDF_IGNORE_WHITESPACE_AT_EOL)
>>  
>> -#define XDF_PATIENCE_DIFF (1 << 5)
>> -#define XDF_HISTOGRAM_DIFF (1 << 6)
>> +#define XDF_IGNORE_BLANK_LINES (1 << 7)
>> +
>> +#define XDF_PATIENCE_DIFF (1 << 14)
>> +#define XDF_HISTOGRAM_DIFF (1 << 15)
>>  #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
>>  #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
>>  
>> -#define XDF_IGNORE_BLANK_LINES (1 << 7)
>> -
>> -#define XDF_INDENT_HEURISTIC (1 << 8)
>> +#define XDF_INDENT_HEURISTIC (1 << 23)
>>  
>> +/* xdemitconf_t.flags */
>>  #define XDL_EMIT_FUNCNAMES (1 << 0)
>>  #define XDL_EMIT_FUNCCONTEXT (1 << 2)
>
> It is a pity that this diff is not easier to review, but it shows how much
> it was in need of cleaning up. Looks much nicer now.
>
> I wonder, however, what your guiding principle was in determining the
> gaps? I would have expected consecutive bits, except for the one gap to
> make room for the upcoming flag, of course.

There wasn't that deep a thought went into it, actually.  

I wanted to give room for each "groupsof bits" to grow, and gave
each group a byte.  Whitespace bits sits in the first byte (but
ignore-blank-lines work quite different so it grabs the bit from the
other end), fundamental choices of LCS algos is another group that
sits in the second byte, then hunk shifting and other heuristics as
another group.  I guess that the "need minimal" thing could have
been thrown into the last group, but somehow I didn't think it would
grow that much, so I left it at the lowest place.
