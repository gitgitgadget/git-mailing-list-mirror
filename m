Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6AF1F461
	for <e@80x24.org>; Sun, 19 May 2019 16:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfESQ6e (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 12:58:34 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:10971 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESQ6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 12:58:34 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id SIj0hkSTNp7QXSIj0hbJW5; Sun, 19 May 2019 11:07:26 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=iKrn8l-KAAAA:8
 a=UlqV6C1OAAAA:20 a=pGLkceISAAAA:8 a=z23upLkTAAAA:8 a=m4lobr6EWoiEo1stH-gA:9
 a=Dww9lsn3qgEWIgSd:21 a=wQlm3RoOWan2K0NJ:21 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22 a=vz8bQswTWcriz0i0jksL:22
 a=Dsv3lYUHObwL8zqxSzzR:22
Subject: Re: Finer timestamps and serialization in git
To:     esr@thyrsus.com
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        'Derrick Stolee' <stolee@gmail.com>
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <20190515234034.GB124956@thyrsus.com>
 <b4b151ba-ab43-445f-6e49-ee8e28b30859@iee.org>
 <20190519040902.GA32780@thyrsus.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <318a3460-3955-4330-b0bf-5e96e5353178@iee.org>
Date:   Sun, 19 May 2019 11:07:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190519040902.GA32780@thyrsus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfHW66XS6efJ7PpaMIcOsatrF++aNLZ0Z4acfRY0l7z5Es+Myh52RxWzWya+6gfQxWXpvjO7pxkpOSoC8HvpunVmaqkY/AQwHwYqPWFhSV/rnW5cDZdZy
 4rfZ2mctLbe87YpD4J6S6Q7xmzo2WmOm+Z0dktqauJQsrYPp/K5smwI2vovgQzfiVtsBxFYXgRJC9+p7/MyOg46EOJhCnVwmI8RaS28vnKbX4gEcsEpwfTSb
 HMaYmY4UP+11wD4dYjP/zA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On 19/05/2019 05:09, Eric S. Raymond wrote:
> Philip Oakley <philipoakley@iee.org>:
>>> But I don't quite understand your claim that there's no format
>>> breakage here, unless you're implying to me that timestamps are already
>>> stored in the git file system as variable-length strings.  Do they
>>> really never get translated into time_t?  Good news if so.
>> Maybe just take some of the object ID bits as being the fractional time
>> timestamp. They are effectively random, so should do a reasonable job of
>> distinguishing commits in a repeatable manner, even with full round tripping
>> via older git versions (as long as the sha1 replicates...)
> Huh.  That's an interesting idea.  Doesn't absolutely guarantee uniqueness,
> but even with birthday effect the probability of collisions could be pulled
> arbitrarily low.
depends how many bits are in the 'nano-second' resolution long word ;-)
see also
>
>> As I understand it the commit timestamp is actually free text within the
>> commit object (try `git cat-file -p <commit_object>), so the issue is
>> whether the particular git version is ready to accept the additional 'dot'
>> factional time notation (future versions could be extended, but I think old
>> ones would reject them if I understand the test up thread - which would
>> compromise backward compatibility and round tripping).
> Nobody seems to want to grapple with the fact that changing hash formats is
> as large or larger a problem in exactly the same way.
>
> I'm not saying that changing the timestamp granularity justifies a format
> break.  I'm saying that *since you're going to have one anyway*, the option
> to increase timestamp precision at the same time should not be missed.
It is probably the round tripping issue with a non-fixed format (for the 
time string) that will scupper the idea, plus the focus being primarily 
on the DAG as the fundamental lineage (which only gives partial order, 
which can be an issue for other VCS systems that are based on 
incremental changes rather than snapshots)
The transition is well underway see thread: 
https://public-inbox.org/git/20190212012256.1005924-1-sandals@crustytoothpaste.net/ 
for a patch series.

The plan is at: 
https://github.com/git/git/blob/master/Documentation/technical/hash-function-transition.txt 
<https://github.com/git/git/blob/v2.19.0-rc0/Documentation/technical/hash-function-transition.txt>, 

some discussions at thread: 
https://public-inbox.org/git/878t4xfaes.fsf@evledraar.gmail.com/ etc.

The timestamp problem is known see yesterdays thread: 
https://public-inbox.org/git/20190518005412.n45pj5p2rrtm2bfj@glandium.org/

Given that the object ID should be immutable for a round trip, using 
64bits from the sha1-oid as notional 'nano-second' time does give a 
reasonable birthday attack resistance of ~32 bits (i.e. >1M commits with 
identical whole second timestamps). [or choose the sha-256 once the 
transition is well underway]
--
Philip


