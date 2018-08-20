Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11AE1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 15:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeHTTKi (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 15:10:38 -0400
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:53696 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbeHTTKi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Aug 2018 15:10:38 -0400
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id rjR1fzkgUu3kirmVff6F48; Mon, 20 Aug 2018 15:54:27 +0000
Received: from [IPv6:2601:646:c101:c8a2:90b2:a105:e027:80e1] ([IPv6:2601:646:c101:c8a2:90b2:a105:e027:80e1])
        by resomta-po-09v.sys.comcast.net with ESMTPA
        id rmVPfoZtwkOjvrmVPfpkFu; Mon, 20 Aug 2018 15:54:27 +0000
Subject: Re: "less -F" is broken
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
 <87k1orqpxj.fsf@evledraar.gmail.com>
 <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
 <e7fb0ae0-b3e3-d7ad-7f6e-c114ee563d59@greenwoodsoftware.com>
 <CA+55aFzutOgNbw2jeKox81-9O4+eSDntgrSAqaZrf0-28sTSUg@mail.gmail.com>
From:   Mark Nudelman <markn@greenwoodsoftware.com>
Message-ID: <00804f16-f265-c4a1-332d-4b362548e663@greenwoodsoftware.com>
Date:   Mon, 20 Aug 2018 08:54:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFzutOgNbw2jeKox81-9O4+eSDntgrSAqaZrf0-28sTSUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOcg3qvhJGUg2EDiZ6Taa/C6gvB+aiKB04d7nAZdL7cfeX5WYNClXebepzcxVuLtkIYsDm1XPG4BA2dL106rYDqs+iWwd7s5H9OsoB6l/5u/gi/bICbw
 SFddVqFaomLeIVX1dbJYykW/VJm8fy5FqLCkYhPlcH2/gamCvA5j9wYgHMwPZ61YyDvC1/V0nY7wi9hn+3vCxeO3KyK/HiUHSksT4HGrMxXoc1z7a67voGKa
 uKQ0aqKAnjL8C3b4TWI9PHmpOvb4pZ8/2+Lo1/FuxaVBALIaiDDpKtb2jbzy9cyuA55+CiK/batFG5v7njNtNxgiNbdhDiJvP1dMFX3kx1hIk1AtvwTLIh+c
 bWjHoNtU90FwojQsFc36c9fD19pj5HWe1IGFTY2Q0LTnfr8N5jQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2018 10:10 AM, Linus Torvalds wrote:
> One option that I didn't try to go for - because I just don't know the
> less code base well enough - is to basically make the behavior of '-F'
> be something like this:
> 
>   - as long as all the lines are short and well-behaved, and we haven't
> seen enough lines to fill the screen, act like 'cat' and just feed
> them through
> 
>   - when you fill the screen (or when you hit some other condition that
> makes you go "now I won't exit" - that could be a long line, but maybe
> it could also be the user giving keyboard input for a less command?)
> you send the init sequence and just redraw the whole screen.

I'm not sure that this would be a very nice user experience.  On a 
terminal where the init sequence opens an alternate screen, some lines 
from the start of the file would be printed in the main screen, and then 
the whole file would be viewed in the alternate screen.  After exiting 
less, the user would see his main screen with some lines from the first 
page of the file displayed and then cut off at a seemingly arbitrary 
point.  Seems like that could be confusing and annoying.


> But let's say that that was all the user was interested in, and the
> user presses 'q' to quit less. That doesn't work at all - it will wait
> for that full ten seconds.
> 
> That actually happens even without -F too.
> 
> Wouldn't it be good to react to things like searches to highlight
> something (and to 'quit' for the 'never mind, alteady got it' case)
> even if there isn't enough data to fill the whole screen yet?
> 
> that said, ^C works, and this is not new behavior, so I'm just
> throwing this out as a "maybe a different approach would fix _both_
> the -F behavior _and_ the above traditional issue"?

This issue is, as you say, not related to the -F issue, but arises 
because less doesn't have a way to be reading a file and simultaneously 
react to terminal key presses.  When I first wrote less, there was no 
easy way to do this in Unix.  Less also runs on other OSes which don't 
provide this functionality.  The best I was able to do was to allow 
ctrl-C to interrupt the read.  Of course in a modern OS that has 
select() or similar functionality this could be implemented, but I think 
it would require some largish changes to the architecture.  (Or maybe 
not; I haven't really investigated this in detail.)

BTW, your first message seems to indicate that you didn't find the less 
project on github.  It's at https://github.com/gwsw/less (mentioned in 
the README).  The latest version (v535) has the -F change implemented, 
but I haven't yet released this for beta testing.

--Mark

