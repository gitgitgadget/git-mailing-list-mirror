Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C64720899
	for <e@80x24.org>; Thu, 27 Jul 2017 17:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbdG0RFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 13:05:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55638 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751446AbdG0RFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 13:05:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E35809E475;
        Thu, 27 Jul 2017 13:05:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aqluBGSkHq24LffGHHyu8HRxJZ0=; b=b3VtEX
        jfxJEcXILgmMsaLYrTKvoHi5lE5RVi05VrbSpmU6J0ryx9oBPxFc8i0If6uxfG+B
        PneXrwZkM1NrSwcW4ZaVMnDY6ynp7cjQ2BqfjBPX2DRwwrQBom8FGmZ17NgNVB06
        oRr503PM2Fy8JbZCOFirLi/n0sLVAs3UiiRl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dqZQLolKw/q1Yveb3miw8vxo/gzEr/7g
        eTnfzbSf0MudlLY5kKTr0E9d4ARDVyZzvsKUkq0Bmp7gM7M4TG59LyamDyxnyWPq
        cysvmMYLln4eKErTNc4B8NFfxXZRwIH/DwViYFXdr3uoOClrx0F8GwESBybljFaR
        HCSLQNVoUeo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC26F9E474;
        Thu, 27 Jul 2017 13:05:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DC0A9E471;
        Thu, 27 Jul 2017 13:05:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Subject: Re: Expected behavior of "git check-ignore"...
References: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>
        <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley>
        <CAEBDL5X3wr=4A+W_sQzSE9BazoxoS2bwcOBZV5Jw=WCWZHAi6A@mail.gmail.com>
        <xmqq4lu1ej0d.fsf@gitster.mtv.corp.google.com>
        <CAEBDL5U=pcqwzeQstiBBJpXngXeB4xTfKb7mos68kRAeumc5Rg@mail.gmail.com>
Date:   Thu, 27 Jul 2017 10:05:33 -0700
In-Reply-To: <CAEBDL5U=pcqwzeQstiBBJpXngXeB4xTfKb7mos68kRAeumc5Rg@mail.gmail.com>
        (John Szakmeister's message of "Thu, 27 Jul 2017 07:20:12 -0400")
Message-ID: <xmqqd18lolnm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE56BD2E-72ED-11E7-B658-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Szakmeister <john@szakmeister.net> writes:

> On Mon, Jul 24, 2017 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [snip]
>> I am reasonably sure that the command started its life as a pure
>> debugging aid.
>>
>> The treatment of the negation _might_ impose conflicting goals to
>> its purpose as a debugging aid---a user who debugs his .gitignore
>> file would want to know what causes a thing that wants to be ignored
>> is not or vice versa, and use of the exit status to indicate if it
>> is ignored may not mesh well with its goal as a debugging aid, but I
>> didn't think about the potential issues deeply myself while writing
>> this response.  As you mentioned, use of (or not using) "-v" could
>> be used as a sign to see which behaviour the end-user expects, I
>> guess.
>
> Is there another way of checking to see if a file is ignored?  If so,...

Maybe I sounded like waffling, but I do think "check-ignore" when
used as an end-user tool should be that command, to get a preview of
what would happen if you gave the path to "git add".  

I was merely giving a possible explanation why it may not behave
like so in the current code, i.e. those who used it for debugging
their .gitignore files may have felt that the current way to handle
negation were more convenient during their debugging session.

But I think there is a way out to satisfy both groups of people.

What if we (re)define that "-v" is a way to ask "which entry, if
any, decides the final fate of this path?" question, and that is a
sign that the user is using it to debug their .gitignore?  And we
use the exit status to mean "Yeah, there is an explicit entry that
decides the fate of the path" in that case, which is what the
current behaviour seems to be---the command exits with non-zero
status only when there is nothing that matches in the exclude
mechanism (which makes the final fate of the path to be 'not
ignored').

And we interpret the lack of "-v" as a signal that the user wants to
learn the fate of a given path via the exit status of the command,
which will "fix" the exit code to match the expectation in your
initial message in this thread.

Would that work well?
