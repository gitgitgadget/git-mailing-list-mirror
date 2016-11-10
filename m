Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0818420229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbcKJXUr (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:20:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57527 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750776AbcKJXUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:20:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BADC4D160;
        Thu, 10 Nov 2016 18:20:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wXQK+PhSqrSaNZIsIrwxYmsb8mo=; b=PzrkYQ
        EFRScHHgdbwWcfWBnEbFhPzmWuo5yxmbGLSOh96f0ism6Vn+NSnzDrxZrST65cqS
        1ejNDW1Al6UBTc5NyYgWM17nlkQhc5AtXtJ+GW23IxnOXX1Wki95JU9PDNRVuQJF
        7PGZ2Py+uVBDnLx0XPMgRTOoJdip8EvO4au4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LeVgigTrXkYZpPRxY4lsDrzaZAKRtZpu
        zrIzJhxmripQlpm+2E3Awb2G8it/EGgxvbU+c3d1ESRxZB9hwSoogC0OoY0ljfWG
        IVYlh3FUxUvM2bzxec71vi+gn4SrVDZEJ9VAF8GE7SN4LoplOXJUQZZNH3No/unq
        7lU3sWvQfxk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7392F4D15F;
        Thu, 10 Nov 2016 18:20:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E297A4D15E;
        Thu, 10 Nov 2016 18:20:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 01/17] ref-filter: implement %(if), %(then), and %(else) atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-2-Karthik.188@gmail.com>
        <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
        <CAOLa=ZS_V5SNSbiC_sT6E9rJMbxCMm=BRaoPL44xBNXAG2pgbA@mail.gmail.com>
Date:   Thu, 10 Nov 2016 15:20:44 -0800
In-Reply-To: <CAOLa=ZS_V5SNSbiC_sT6E9rJMbxCMm=BRaoPL44xBNXAG2pgbA@mail.gmail.com>
        (Karthik Nayak's message of "Thu, 10 Nov 2016 22:41:46 +0530")
Message-ID: <xmqqshqy53cj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EC1C904-A79C-11E6-A54F-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>> Minor nit. I'm not sure what standard we use here at Git, but
>> traditionally, I prefer to see { } blocks on all sections even if only
>> one of them needs it. (That is, only drop the braces when every
>> section is one line.) It also looks weird with a comment since it
>> appears as multiple lines to the reader. I think the braces improve
>> readability.
>>
>> I don't know whether that's Git's code base standard or not, however.
>> It's not really worth a re-roll unless something else would need to
>> change.
>>
> I believe this is the syntax followed in Git, xdiff/xmerge.c:173 and so on.

That is a bad example for two reasons, if you mean this part:

        if ((size = file->recs[i]->size) &&
                        file->recs[i]->ptr[size - 1] == '\n')
                /* Last line; ends in LF; Is it CR/LF? */
                return size > 1 &&
                        file->recs[i]->ptr[size - 2] == '\r';
*       if (!i)
                /* The only line has no eol */
                return -1;
        /* Determine eol from second-to-last line */


What Jacob prefers is this:

---------------------------------------------
        if (cond)
                simple;
        else if (cond)
                simple;
        else
                simple;
---------------------------------------------
        if (cond) {
                simple;
        } else if (cond) {
                no;
                longer;
                simple;
        } else {
                simple;
        }
---------------------------------------------

That is, as long as all arms of if/else if/.../else cascade is
simple, {} is used nowhere in the cascade, but once even one of them
requires {} then all others gain {}.
