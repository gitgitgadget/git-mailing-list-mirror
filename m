Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F354920357
	for <e@80x24.org>; Mon, 17 Jul 2017 18:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdGQSbY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 14:31:24 -0400
Received: from 5.itsy.de ([188.40.84.14]:42122 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbdGQSbX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 14:31:23 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 1BA61646B4
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 20:31:22 +0200 (CEST)
Subject: Re: Detect invalid submodule names from script?
References: <41004589-4a98-2084-b542-51b7458f607b@durchholz.org>
 <CAGZ79kYvup5yOqsgbphwvQe-2sKfXO3a8E1S548WLOXRp4SB_g@mail.gmail.com>
From:   Joachim Durchholz <jo@durchholz.org>
To:     Git Mailing List <git@vger.kernel.org>
Message-ID: <3109accd-5e7b-fdab-4d2e-734c42abf939@durchholz.org>
Date:   Mon, 17 Jul 2017 20:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYvup5yOqsgbphwvQe-2sKfXO3a8E1S548WLOXRp4SB_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.07.2017 um 19:49 schrieb Stefan Beller:
> On Mon, Jul 17, 2017 at 4:17 AM, Joachim Durchholz <jo@durchholz.org> wrote:
>> Hi all
>>
>> I'm hacking some script that calls into git, and I need to detect whether a
>> repository was configured with a submodule name that will work on "git
>> submodule init" and friends.
> 
> There is no such a thing as "git submodule valid-name" unfortunately.
> Looking through "git submodule add", I think it is safe to assume
> that any string valid as a subsection in git-config is a valid submodule name.

That's what I have been thinking myself.

> Our man page says:
> 
>      Subsection names are case sensitive and can contain any characters
>      except newline (doublequote " and backslash can be included by escaping
>      them as \" and \\, respectively).
> 
> I am not sure about the quality of submodule shell code to handle the quotations
> for double quote and backslash correctly, so I would suggest not using them,
> either.

The quality is pretty dubious for path names (where I have torture tests 
in place).
I haven't done these tests for module names yet. I doubt it's going to 
look prettier though.

>> I *can* run a git init and see whether it works, but I need to be 100% sure
>> that the error was due to an invalid submodule name and not something else.
>> Bonus points for every version of git for which it works.
> 
> I do not think Git offers a universal solution across versions except actually
> running "submodule init" and then making an educated guess if the error
> comes from bad naming or something else.

Yeah, I think that's the way to go - clone into a local temp directory, 
set up the submodule to a sane module and subdirectory name, and if that 
works, test what happens with the original configuration.

I'd have preferred something less elaborate though.
E.g. SVN has a --xml option that will output everything in XML format. 
(Not useful for shell scripting but easy for almost any other scripting 
language.)

> This sounds like you're taking user input or otherwise untrustworthy data
> as submodule names?

I'm auto-downloading submodules as configured in 3rd-party repositories.
Which means untrusted data is copied to the user's home directory, so I 
definitely need to make sure that nothing nasty can happen.

My current code is a /bin/sh script.
Given the security/reliability/robustness problems I keep encountering, 
the temptation to rewrite this in Python has been steadily growing, 
though I'm not quite there yet.

Regards,
Jo
