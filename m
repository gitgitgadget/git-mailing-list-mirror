Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A13B201CF
	for <e@80x24.org>; Fri, 19 May 2017 04:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750718AbdESEAb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 00:00:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48549 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750703AbdESEAa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 May 2017 00:00:30 -0400
X-AuditID: 12074413-0e1ff70000001dc3-e9-591e6dd9c2d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E2.17.07619.9DD6E195; Fri, 19 May 2017 00:00:28 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCC1C.dip0.t-ipconnect.de [87.188.204.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4J40MZ2025000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 19 May 2017 00:00:24 -0400
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock directly
 in this struct
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
 <CAGZ79kbdQ-MqYKH-L9unqEAPUtgQxNv6ANJERKSEQCADjgmm1w@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d7e3d4ac-6383-d919-9f42-bb278fc26b3f@alum.mit.edu>
Date:   Fri, 19 May 2017 06:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbdQ-MqYKH-L9unqEAPUtgQxNv6ANJERKSEQCADjgmm1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHsnVy7S4NUMBYu1z+4wWTxff4Ld
        outKN5NFQ+8VZoslD18zW3RPecto8aOlh9li8+Z2FgcOj52z7rJ7LNhU6tHVfoTN41nvHkaP
        i5eUPT5vkgtgi+KySUnNySxLLdK3S+DKePnxJ2PBIf6KNW/OMTUwNvF0MXJySAiYSNy+epKl
        i5GLQ0hgB5PE6z/v2CGc80wSh75MYAKpEhaIl1j44hQbiC0iUCCx49x7qI5OJomTHz4ygTjM
        AiuYJH6d+84MUsUmoCuxqKcZKMHBwStgL9F9KBkkzCKgKrH/2m12EFtUIELiYecuMJtXQFDi
        5MwnLCDlnAKBEpsXlIKEmQXUJf7Mu8QMYctLbH87h3kCI/8sJB2zkJTNQlK2gJF5FaNcYk5p
        rm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIwAvvYNx1Uu4QowAHoxIP74MVspFCrIll
        xZW5hxglOZiURHlnBMhFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhFRcDyvGmJFZWpRblw6Sk
        OViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHjf5gA1ChalpqdWpGXmlCCkmTg4QYbzAA1v
        BqnhLS5IzC3OTIfIn2JUlBLn3ZwNlBAASWSU5sH1whLSK0ZxoFeEed2A6UmIB5jM4LpfAQ1m
        Ahn8QBpkcEkiQkqqgXEqV/6O0wZPvx+65WVpXMz+g8uBy2s9q9szdzs7a5uzu6tPvTNP1l2f
        Iz9B+//1TQf2S2YvimSYz/mg4fbTg8tXZEloLvp/Pf9oxjRhi2sn9XQ72Pq9ru6cMS/io8JD
        Qc/WCWs/bi7lKT1rcGbNjc+VF1Z6Wb34EFGnOEVq+e81O9+cXppxNJNdiaU4I9FQi7moOBEA
        wFH3QiMDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 07:18 PM, Stefan Beller wrote:
> On Wed, May 17, 2017 at 6:17 AM, Jeff King <peff@peff.net> wrote:
>> On Wed, May 17, 2017 at 02:05:33PM +0200, Michael Haggerty wrote:
>>
>>> Instead of using a global `lock_file` instance for the main
>>> "packed-refs" file and using a pointer in `files_ref_store` to keep
>>> track of whether it is locked, embed the `lock_file` instance directly
>>> in the `files_ref_store` struct and use the new
>>> `is_lock_file_locked()` function to keep track of whether it is
>>> locked. This keeps related data together and makes the main reference
>>> store less of a special case.
>>
>> This made me wonder how we handle the locking for ref_stores besides the
>> main one (e.g., for submodules). The lockfile structs have to remain
>> valid for the length of the program. Previously those stores could have
>> xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
>> and leak their whole structs.
> 
> +cc Brandon, who is eager to go down that road.
> 
>> I suspect the answer is "we don't ever lock anything except the main ref
>> store because that is the only one we write to", so it doesn't matter
>> anyway.
>>
>> -Peff
> 
> 
>> @@ -102,7 +98,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
>>        if (refs->packed) {
>>                struct packed_ref_cache *packed_refs = refs->packed;
>>
>> -               if (refs->packlock)
>> +               if (is_lock_file_locked(&refs->packlock))
>>                        die("internal error: packed-ref cache cleared while locked");
> 
> I think the error message needs adjustment here as well? Maybe
> 
>      die("internal error: packed refs locked in cleanup");

Hmmm, I don't see what's wrong with the current error message (except
for s/internal error/BUG/). In any case, this is meant to be a sanity
check that users should never see, so I wouldn't worry too much about it
either way.

Michael

