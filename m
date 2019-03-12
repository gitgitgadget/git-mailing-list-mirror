Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C8120248
	for <e@80x24.org>; Tue, 12 Mar 2019 19:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCLTcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 15:32:11 -0400
Received: from kwanyin.sergiodj.net ([158.69.185.54]:47518 "EHLO
        kwanyin.sergiodj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfCLTcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 15:32:10 -0400
From:   Sergio Durigan Junior <sergiodj@sergiodj.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
References: <87k1h55bx0.fsf@sergiodj.net>
        <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
        <877ed459eh.fsf@sergiodj.net>
        <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
X-URL:  http://blog.sergiodj.net
Date:   Tue, 12 Mar 2019 15:32:07 -0400
In-Reply-To: <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 12 Mar 2019 12:23:09 -0700")
Message-ID: <8736nr6g94.fsf@sergiodj.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, March 12 2019, Elijah Newren wrote:

> On Tue, Mar 12, 2019 at 9:48 AM Sergio Durigan Junior
> <sergiodj@sergiodj.net> wrote:
>> On Tuesday, March 12 2019, Duy Nguyen wrote:
>>
>> > On Tue, Mar 12, 2019 at 5:18 AM Sergio Durigan Junior
>> > <sergiodj@sergiodj.net> wrote:
>> >> This works without problems most of the time (well, usually there are
>> >> conflicts and all, but that's a burden I have to carry).  However,
>> >> sometimes I notice that git fails with:
>> >>
>> >>   # git rebase origin/master
>> >>   ...
>> >>   Applying: commitX
>> >>   Applying: commitY
>> >>   Applying: commitZ
>> >>   fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
>> >>
>> >> The first thing I did was to check whether the index.lock file existed,
>> >> but it doesn't.
>> >
>> > Is the output this clean? What I'm looking for is signs of automatic
>> > garbage collection kicking in the middle of the rebase. Something like
>> > "Auto packing the repository blah blah for optimum performance".
>>
>> Yeah, this is the exact output.  I also thought about "git gc", but I
>> don't see any output related to it.  Is it possible that it's being
>> executed in the background and not printing anything?
>
> Any chance you have a cronjob or other task execution mechanism that
> is running git commands in various directories (even simple commands
> like 'git status' since it's not read-only contrary to what some
> expect, or 'git fetch' which might trigger a background gc)?

Nope, nothing like this.  AFAIK, nothing is touching that repository at
the same time that I am.  Besides, even if I wait some minutes before
trying again, the bug manifests again.

-- 
Sergio
GPG key ID: 237A 54B1 0287 28BF 00EF  31F4 D0EB 7628 65FC 5E36
Please send encrypted e-mail if possible
http://sergiodj.net/
