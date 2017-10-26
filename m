Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3306F20560
	for <e@80x24.org>; Thu, 26 Oct 2017 05:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbdJZFyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 01:54:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750919AbdJZFyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 01:54:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B88479B76A;
        Thu, 26 Oct 2017 01:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iW2Tah5xsCQSp6rDiL8ShshwAd4=; b=V98rYM
        YAgQy+r3MpscvLr1ALP9+Ye1GJM4i0pByVD2Ut+csX0BPT1zNW4Ipz/n+qdgqKaf
        3LhrAUXgvyxk96AQbt5dB9Eg9Q2Xab5nxcRtiKwx/PQhU5WIHdcLMpIh/ZfEVj4Q
        fDvmJ9pFYa+edD125gHWs9MxgykczERfCBpgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cEachMG5Hl8kpYWSStn+sdKKbbOc7oKZ
        eHGfsbLcUesHvAV+EmSpepUve/2+SX3M/bzvg50oZRA0lsEs8gvhqjL0ln6ZSgEq
        mFGoqmG9dT4xaY+nFREJGnOzjximevoUd0e4uDwycEy+fT0LqPQ13Whq868Z1BzT
        n+5etBJ+fYg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEA4B9B768;
        Thu, 26 Oct 2017 01:54:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FED09B765;
        Thu, 26 Oct 2017 01:54:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
        <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
        <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com>
        <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbgjgOhQuK0-zF7oTvuM_gWKF25+uAf-hsHK2Xg4yshhA@mail.gmail.com>
Date:   Thu, 26 Oct 2017 14:54:51 +0900
In-Reply-To: <CAGZ79kbgjgOhQuK0-zF7oTvuM_gWKF25+uAf-hsHK2Xg4yshhA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 25 Oct 2017 09:44:32 -0700")
Message-ID: <xmqqy3nye9n8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FCB00A4-BA12-11E7-8766-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> diff --git a/diff.c b/diff.c
>> index 6fd288420b..eeca0fd3b8 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4202,7 +4202,8 @@ void diff_setup_done(struct diff_options *options)
>>
>>         if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
>>             DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
>> -           DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
>> +           DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL) ||
>> +           DIFF_XDL_TST(options, IGNORE_CR_AT_EOL))
>
> This highlights another part of the flag macros, that could be made nicer.
> All these flags combined are XDF_WHITESPACE_FLAGS, so this
> if could be written without the macros as
>
>   if (options->xdl_ops & XDF_WHITESPACE_FLAGS)

Yes, and I think the codepath that matters most already uses that
form.  Perhaps it is a good idea to do the rewrite without a macro
(XDF_WHITESPACE_FLAGS is already a macro enough).

> (1<<5) is taken twice now.

Good eyes.  I think we use bits #1-#8 now (bit #0 is vacant, so are
#9-#31).

>> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
>> index 04d7b32e4e..8720e272b9 100644
>> --- a/xdiff/xutils.c
>> +++ b/xdiff/xutils.c
>> @@ -156,6 +156,21 @@ int xdl_blankline(const char *line, long size, long flags)
>>         return (i == size);
>>  }
>>
>> +/*
>> + * Have we eaten everything on the line, except for an optional
>> + * CR at the very end?
>> + */
>> +static int ends_with_optional_cr(const char *l, long s, long i)
>> +{
>> +       if (s && l[s-1] == '\n')
>> +               s--;
>
> so first we cut off the '\n',

> That seems correct after some thought;

I added the "trim the LF at the end" to the beginning of the
function at the last minute to cheat, and it is debatable if it is
entirely correct on an incomplete line.

The byte at the end of line, i.e. l[s-1], could be either '\n' or
something else, and the latter is an incompete line at the end of
the file.  When we trimmed the LF and decremented s, CR at l[s-1]
is the CR in CRLF, which we do want to ignore.  If we didn't, then
what is CR sitting at l[s-1]?  It is a lone CR at the end of file,
not a part of CRLF.  Do we really want to ignore it?

If we take the name of the option "ignore-cr-at-eol" literally, yes,
it is a CR sitting at the end of a line, which happens to be an
incomplete one, so we do want to ignore.  But if we think about the
reason why we are adding the option (i.e. to help conversion between
CRLF and LF), it is somewhat iffy.  The lone CR at the end of file
cannot be something that came from CRLF<->LF conversion, and ignoring
it would hide possible problems in conversion or the original data.

> I might offer
> another easier to understand (for me) solution,
> ...
> Though this seems even more complicated
> after having it written down.

This happens to me quite often and my solution to it is to remove
the alternative I tried to formulate after convincing myself that it
is not that much of an improvement ;-).
