Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3636C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90848206E6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 19:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1TOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:14:53 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:8560 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1TOx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 15:14:53 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jIGux-000468-8E; Sat, 28 Mar 2020 19:14:51 +0000
Subject: Re: [RFC] Proposal: New options for git bisect run to control the
 interpretation of exit codes
To:     Stephen Oberholtzer <stevie@qrpff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <CAD_xR9f7jHnCByOaOVJvxdW2c5dPHM8OUDwZhcPL1iTVR3NzmQ@mail.gmail.com>
 <CAP8UFD3dr3XdZSm88qoGDajSoFMx-TJZfxsMGqhFMKA6dEWj4A@mail.gmail.com>
 <CAD_xR9cC_MrrqGoHuBsfuVAQ=qVMd0rjXvp22+8ed-D=4TQRbA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <24c58c80-c274-6a64-051c-90329432b85d@iee.email>
Date:   Sat, 28 Mar 2020 19:14:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAD_xR9cC_MrrqGoHuBsfuVAQ=qVMd0rjXvp22+8ed-D=4TQRbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry this is late.
On 16/01/2020 02:40, Stephen Oberholtzer wrote:
>> The above doesn't tell what happens if a status is both on the
>> --old-status and on the --new-status lists...
> No, the below does.
>
>>>  * Otherwise, the command is treated as having experienced a fatal error,
>>>    and run will terminate with a nonzero exit status.
>> ...so it seems that it is an error only when such a status code is
>> actually received by `git bisect run`.
>>
>> Some people could argue though that `--new-status=0 --old-status=0`
>> should be detected as an error as soon as `git bisect run` is
>> launched.
> There are a few reasons for not raising an error immediately:
> - Such a check would not be free.  While the example you gave is
> simple enough, things can quickly get complicated.  A generalized
> version would have to check every single status from 0 to 255
>   (that said, I can see some value in proactively checking 0 and 1
> before starting the run, just as a sanity check)
> -  If there _is_ an ambiguous exit code, it doesn't actually matter
> unless it's actually encountered
> - If the user makes such a mistake, the bisection doesn't go off the
> rails; it just halts.  

Will such a mistake be _reported_ (suitable message) to the user? This
would at least short circuit misunderstandings as to the reason for the
halting of the bisect.
> A simple 'git bisect good' or 'git bisect bad',
> followed by another call to "run" with corrected options, will address
> the issue.
>
Philip
