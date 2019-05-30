Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF281F462
	for <e@80x24.org>; Thu, 30 May 2019 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfE3Uc7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 16:32:59 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:55412 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3Uc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 16:32:59 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45FK5h47k8z5tlK;
        Thu, 30 May 2019 22:32:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 26045208D;
        Thu, 30 May 2019 22:32:56 +0200 (CEST)
Subject: Re: [PATCH] userdiff: two simplifications of patterns for rust
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
 <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
 <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
 <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com>
 <a7d42d82-7d84-bf25-55ce-5c57a7ce70e9@kdbg.org>
 <CAMxuvaxW9fc4ft=aERSUt4+n237bdtDpKJMvyKq=H7yz-VLWbg@mail.gmail.com>
 <2d32b107-9278-faa0-4fea-afe662031272@kdbg.org>
 <875zprn4zr.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e898920d-46bf-781a-de2f-6452bf5bae05@kdbg.org>
Date:   Thu, 30 May 2019 22:32:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zprn4zr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.19 um 20:59 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Thu, May 30 2019, Johannes Sixt wrote:
> 
>> - Do not enforce (but assume) syntactic correctness of language
>>   constructs that go into hunk headers: we only want to ensure that
>>   the keywords actually are words and not just the initial part of
>>   some identifier.
>>
>> - In the word regex, match numbers only when they begin with a digit,
>>   but then be liberal in what follows, assuming that the text that is
>>   matched is syntactially correct.
> 
> I don't know if this is possible for Rust (but very much suspect so...),
> but I think that in general we should aim to be more forgiving than not
> with these patterns.

The C/C++ pattern is actually very forgiving in the hunk header pattern:
It takes every line that begins with an un-indented letter. That works
very well in in C because C does not have nested functions and it is
typical that the function definition lines are not indented. But that
breaks down with C++: indented function definitions are very common;
they happen inside class and namespace definitions. Such functions are
not picked up, and we live with that so far (at least, I do).

> Because, as the history of userdiff.c shows, new keywords get introduced
> into these languages, and old git versions survive for a long time. If
> the syntax is otherwise fairly regular perhaps we don't need to hardcode
> the list of existing keywords?

We are talking about (1) hunk header lines (not something really
important) and (2) programming languages: new keywords don't pop up
every month. Granted, inventing new languages is en vogue these days.
But really, I mean, WTH?

Having available keywords to recognize hunk header candidates helps a
lot. I thought long about a possible pattern for C++, but I gave up,
because the language is so rich and there are no suitable keywords.

-- Hannes
