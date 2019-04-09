Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BF320248
	for <e@80x24.org>; Tue,  9 Apr 2019 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDITKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 15:10:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41753 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDITKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 15:10:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so9976863plj.8
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLkqJNdko3yyTGbBk/Lx2bBbjjE4Js7j+TxbUik1qXM=;
        b=deCENqVnB6PkDLbeaqjG/WShbjuXkGmfa/CwPZmL21M9trtltyhC3gJMvJfolNAS6S
         V0nZs9UU5dMPvv8b8ZNFxKfWvhW3rnDEDq8LB4HpzTYJ0Xk4tj0hy9wtR975P1pCFNpw
         ocn/vdTqwZSdvMF6g+pmziypo3iSElZjE2gMRYZUtHgr0Lg1IELA2q/aoh11j2Xk9p2r
         shFyL4RtU9s+6qCvc0ZVmqMGRbSMMmNZSY+o8VS05jnqYHkrIP88PoMzkxdiIewoe8Rv
         2gxIkVKr+yCge0uF3W5dwhgndX+zkAv/g6iBz1Py53ty5lKpUkFcY7mEKok6IC4QZOZd
         wTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLkqJNdko3yyTGbBk/Lx2bBbjjE4Js7j+TxbUik1qXM=;
        b=JcvoqDj7QrIrtOx/UqohqBumCcQxsd1RkcsgjeNa2XrmmCQtZAN1DUhExiwE8kcDqX
         7FuzOCRKTitwBvkl2yceWXkBLjeIvB0jZeE/yag7+dGim4AKqtnNjaFne1rrVKkZl4NA
         CMehZDrCOdD70onN+ucp/ZYcqZtA9admAhNIZvMw0T4j8kIxB7sm3GGY2JQ+3N3CQUrn
         /gUN+YagCJGkJlSmDa9cxEMxTIRkieqcv2bqyOxb0rnyGI339b6zgjEdQgwm3hgrUehz
         IeKlvUztLfI1frOyZdOlkZjqdK157K9GsDO488bgOEldjSLDJql3fPdu6sgxo9xH7cgy
         AFaw==
X-Gm-Message-State: APjAAAU62td9mFviHBOIAGUjAZ1ZVk7//zbadg2ppSdQfpixFT+Zbeqd
        xk5kNHH6lFtlKMLdto8rjZCrFQ==
X-Google-Smtp-Source: APXvYqxxIibtHd7SeB6xpqmmT7Aqn0JrmN+SiByU8bZkhPF1SwoBlvyWYaSPRicJmveyJuJkcL7O+Q==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr19849748plb.169.1554837049782;
        Tue, 09 Apr 2019 12:10:49 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id c1sm47241570pfd.114.2019.04.09.12.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 12:10:48 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines
From:   Barret Rhoden <brho@google.com>
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines> <20190407214635.12984-1-michael@platin.gs>
 <2747b3b2-0447-0d03-dc7e-c7fa460a303b@google.com>
Message-ID: <0e53bcba-e27c-228d-a36d-6d3575605d7a@google.com>
Date:   Tue, 9 Apr 2019 15:10:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2747b3b2-0447-0d03-dc7e-c7fa460a303b@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/19 11:56 AM, Barret Rhoden wrote:
> Anyway, being able to look outside the current blame_chunk would help in 
> those scenarios.  Specifically, I'm talking about letting blame_chunk() 
> point anywhere in the parent.  Right now, it can only look in the 
> parent's part of the chunk passed to blame_chunk, which can be 
> relatively small.

I hacked up the ability to look outside of a diff chunk.  The change to 
the heuristic-independent part of the code was very minor, both in code 
and in performance.

The change to make the fingerprinting algorithm from my RFC patch look 
at the entire parent was pretty minor too - I can also cache the 
fingerprints.  The main drawback is performance, but Michael's new 
fingerprinting code alleviates this.

Here's a quick analysis.  When run on a 1000 line C file, with large 
changes from an ignored commit, after the file has been paged in (so, 
run twice):

not ignoring at all:
-------------
real	0m0.062s
user	0m0.042s
sys	0m0.021s

scan only in the parent chunk:
----------------------------
real	0m0.097s
user	0m0.085s
sys	0m0.012s

scan parent chunk, scan entire parent on failure:
-------------------------
real	0m1.773s
user	0m1.752s
sys	0m0.021s

scan the entire parent:
-----------------------
real	0m3.049s
user	0m3.024s
sys	0m0.024s

Scanning the parent chunk first helped a lot.  Scanning the entire 
parent is O(nr_parent_lines * nr_lines_changed).  In my test file, 
that's about 1000 * 600.

It still takes a little while even when checking the parent chunk first. 
  Let's call that one the 'smaller scan.'

Caching the fingerprints (meaning, calculate once and attach to the 
blame_origin) didn't help much here.  It's actually worse, possibly due 
to fingerprinting more than I needed to.

smaller scan, without caching:
----------------
real	0m1.651s
user	0m1.626s
sys	0m0.025s

smaller scan, with caching:
----------------
real	0m1.774s
user	0m1.753s
sys	0m0.021s


Let's try Michael's new fingerprinting code (get_fingerprint() and 
fingerprint_similarity())

smaller scan, caching:
-------------------
real	0m0.240s
user	0m0.215s
sys	0m0.025s

smaller scan, no caching:
----------------------
real	0m0.295s
user	0m0.266s
sys	0m0.029s

full parent scan, caching:
--------------------------
real	0m0.377s
user	0m0.356s
sys	0m0.021s

full parent scan, no caching:
-----------------------------
real	0m0.458s
user	0m0.430s
sys	0m0.028s

And for completenesss,

scan only in the parent chunk:
------------------------------
real	0m0.072s
user	0m0.048s
sys	0m0.024s


So first off, Michael's new fingerprinting is much better.  Caching the 
fingerprints also helps.  Overall, it's fast enough now that I don't 
notice the delay.

I'll reroll the patchset with the ability to find lines in the entire 
parent, and see what you all think.

Barret



