Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF9C388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7FF20759
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="NZlZLysS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgKFB0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:26:53 -0500
Received: from avasout02.plus.net ([212.159.14.17]:57495 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKFB0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 20:26:53 -0500
Received: from [10.0.2.15] ([80.189.83.69])
        by smtp with ESMTPA
        id aqWfkOVSt0K1OaqWgke8GD; Fri, 06 Nov 2020 01:26:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604626011; bh=pIrr0Sbg8drZvwE6x9DzESqhkDm+PG4zsIVPzF21lg0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NZlZLysSXcNMZrMQWHJJ/JwbsS6YDCGwGmC7osFyTVB7kRiJZokqhti2+EyWicaFS
         7NujBxIB5uypgNbCjMpIwud8slQ8tL8hbBpbiyYKkttKOH2oUY1g0Iy+0fdqE4Y6CL
         ERSMBRairCy6Tes3CHFLjCTuhBm+iQUmS2VJTctm7VACG5pgyoTFeWYL8fMoV1sHHp
         IANrgsKoXwbpo+FI28WjMy0Z4FEPFQYPniRF9lJYwRDU+XJFeSsTUac9kwuLaKPKVF
         PR/Gar3A3LKGh0nPeC5zWF3zPac+WwkxdyMRJXx5uTo/SbGd6ul7/GVkV7vR55l0t7
         p2HMIzeOMDjjw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=VKYMt3kHM3Z9lWmoeJedNA==:117 a=VKYMt3kHM3Z9lWmoeJedNA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=am6c-Pl-H50Ale08MjkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH 0/8] speed up 'make clean'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
References: <e1d218bb-7658-565e-0931-2411efbb561c@ramsayjones.plus.com>
 <xmqq361niifm.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f107d6be-0924-88b0-bd34-582b1eed172b@ramsayjones.plus.com>
Date:   Fri, 6 Nov 2020 01:26:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqq361niifm.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBpCrXmiqnhWp+LelO/yQF+GODRmTPHK3kUpGp3mgikWOFAuzKlQE+C1BrFg3GyYaly6uTYAFO1qQY20iQWcAtEjmSxJo47Z0ycoi5FHspxbomHXS0Bt
 1aCPudYazomw7UAxegD4Od/yaKzYbnyL/a6Zy1es0XuI824o52benDuQqXLeMs4gdd0ePnJsFoL9bQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/11/2020 21:48, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> [Yes, 'cd Documentation; make clean all' will be slower that a doing
>> separate 'make clean; make', but the extra 10s, or so, will be swamped
>> by the documentation build time! ;-) ]
> 
> Hmph, the "all" part in "make clean all" needs the information we
> read from these generated files, and time must be spent to generate
> them whether "make clean all" or "make clean; make all" is used.  In
> the latter, we may not generate and read them in the first phase,
> but the second one "make all" would need to do so anyway.  So I am
> puzzled why "make clean all" needs to be slower---don't we generate
> and read them only once in either case?
> 

Hmm, interesting. I was all ready to explain the results of the
moc-up of this that I did about a month ago, but thought I should
just check again ... ;-)

This time I used the actual Makefile, rather than a moc-up, and got
different (in some sense, worse) results. What I was going to say
was, no the doc.dep file gets generated twice - but that is not true. :(

However, if you run 'make clean all', you will not be pleased with
the results!

  $ make clean
  ...
  $ make clean all >zzz 2>&1
  $ grep WARNING zzz | wc -l
  26
  $ tail -1 zzz
  make: *** [Makefile:362: git.1] Error 13
  $ 

If you look at the output, you will see that, while processing the
'clean' target, the 'doc.dep' file is created, -included, and then
immediately deleted. While processing the 'all' target I had expected
the 'doc.dep' file to be recreated - but it isn't. It seems to have
done the 'drop the internal data, re-read and re-parse' only the
once, and on the second go round (because it has already generated
it once) does not re-create and re-read the dependency data again.
Thus, the 'all' target is executed without any 'doc.dep' data and
falls over in a heap. :(

[BTW, just doing 'make' does not do a full build. I will look at why
that is later].

Doing 'make clean; make all' works fine, of course.

That will teach me to cut corners! Ho-Hum. Sorry about that.

Thanks.

ATB,
Ramsay Jones
