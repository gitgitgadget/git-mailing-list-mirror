Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45531F42D
	for <e@80x24.org>; Wed, 25 Apr 2018 06:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeDYGZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 02:25:24 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:58126 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeDYGZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 02:25:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40W9DL51R1z5tlf;
        Wed, 25 Apr 2018 08:25:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C3CE7101;
        Wed, 25 Apr 2018 08:25:21 +0200 (CEST)
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
Date:   Wed, 25 Apr 2018 08:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2018 um 02:05 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> It is not uncommon to request that the output remains visible in
>> the terminal. For this, the option --no-pager can be used. But
>> it is a bit cumbersome to type, even when command completion is
>> available. Provide a short option, -N, to make the option easier
>> accessible.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
> 
> Heh, I used to append "|cat", which is four keystrokes that is a bit
> shorter than " --no-pager", but that is only acceptable when you do
> not care about colored output ;-)
> 
> I am not absolutely certain about the choice of a single letter. I
> already checked we do not use "git -N cmd" for anything else right
> now, so I am certain about the availability, but I am not sure if
> capital 'N' is the best choice, when the other side is lowercase 'p'
> (and more importantly, the other side 'p' has mneomonic value for
> 'pagination', but 'N' merely stands for 'no' and could be negating
> anything, not related to pagination). But I agree that a short-hand
> would be welcome.

I considered -P, but thought that it would better be reserved for 
something related to "paths". We have --{html,man,info}-path, which 
would be served better with -[HMI]. That leaves --exec-path, which we 
would probably abbreviate as -x or -X. So, -P is perhaps not that bad 
after all.

We could also choose +p, for which there is some precedent in other 
POSIX tools to mean negated -p, but not in git, I think. 
Implementationwise, it is not that trivial, either, because the section 
handling options is guarded by a check that the word begins with a dash.

Perhaps --no-pager means also "unpaginated" (-u, -U), "linear" (-l, -L), 
"streamed" (-s, -S). Other ideas, anyone?

> 
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 4767860e72..17b50b0dc6 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -11,7 +11,7 @@ SYNOPSIS
>>   [verse]
>>   'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
>>       [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>> -    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
>> +    [-p|--paginate|-N|--no-pager] [--no-replace-objects] [--bare]
>>       [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
>>       [--super-prefix=<path>]
>>       <command> [<args>]
