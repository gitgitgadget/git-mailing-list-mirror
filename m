Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FD81F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 23:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbeKTKUX (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 05:20:23 -0500
Received: from avasout04.plus.net ([212.159.14.19]:42555 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeKTKUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 05:20:22 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id OtMpgA8wnYyh2OtMqgYyx5; Mon, 19 Nov 2018 23:54:13 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MoN8FVSe c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=8-YUn-EBbAp8NYyjUhMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive
 filesystems
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Duy Nguyen <pclouds@gmail.com>, Carlo Arenas <carenas@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20180817161645.28249-1-pclouds@gmail.com>
 <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
 <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
 <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com>
 <20181119210323.GA31963@duynguyen.home>
 <5ffa3a01-8b76-0b84-a21c-efe912e80333@ramsayjones.plus.com>
Message-ID: <2a6cd6a7-1b6b-2669-c83a-be5483c52fa2@ramsayjones.plus.com>
Date:   Mon, 19 Nov 2018 23:54:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5ffa3a01-8b76-0b84-a21c-efe912e80333@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCjwRlyojAdh6H1Bjsec+jHmGpoZZzozJFRiqC84A+lfAF/Vf582go30qvjqEa0NhAZKUGMTciSkW7jbOQ8CCKOSKXDgmiC4u2M2XYLHyRfkxI2/6OvP
 Nkwka1elRIWf8pRtuNZNC/XawgKhO/q6hCRM7ZITbARHZA6VqYgHeCje
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/11/2018 23:29, Ramsay Jones wrote:
> 
> 
> On 19/11/2018 21:03, Duy Nguyen wrote:
>> First of all, Ramsay, it would be great if you could test the below
>> patch and see if it works on Cygwin. I assume since Cygwin shares the
>> underlying filesystem, it will share the same "no trusting inode"
>> issue with native builds (or it calculates inodes anyway using some
>> other source?).
> 
> Hmm, I have no idea why you would like me to try this patch - care
> to explain? [I just saw, "Has this been tested on cygwin?" and, since
> it has been happily passing for some time, responded yes!]
> 
> Just for the giggles, I removed the !CYGWIN prerequisite from the
> test and when, as expected, the test failed, had a look around:
> 
> $ pwd
> /home/ramsay/git/t/trash directory.t5601-clone
> $ cat icasefs/warning 
> Cloning into 'bogus'...
> done.
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
> 
>   'x'
> $ cd icasefs/bogus
> $ ls -l
> total 0
> -rw-r--r-- 1 ramsay None 0 Nov 19 22:40 x
> $ git ls-files --debug
> ignoring EOIE extension
> X
>   ctime: 1542667201:664036600
>   mtime: 1542667201:663055400
>   dev: 2378432	ino: 324352
>   uid: 1001	gid: 513
>   size: 0	flags: 0
> x
>   ctime: 1542667201:665026800
>   mtime: 1542667201:665026800
>   dev: 2378432	ino: 324352
>   uid: 1001	gid: 513
>   size: 0	flags: 0
> $ 
> 
> So, both X and x are in the index with the same inode number.
> 
> Does that help?

Well, I haven't even looked at the patch, but when I apply it to
the current 'pu' branch (just what I happened to have checked out)
and run that one test:

$ ./t5601-clone.sh
...
ok 96 - shallow clone locally
ok 97 - GIT_TRACE_PACKFILE produces a usable pack
ok 98 - clone on case-insensitive fs
ok 99 - colliding file detection
ok 100 - partial clone
ok 101 - partial clone: warn if server does not support object filtering
ok 102 - batch missing blob request during checkout
ok 103 - batch missing blob request does not inadvertently try to fetch gitlinks
# passed all 103 test(s)
# SKIP no web server found at '/usr/sbin/apache2'
1..103
$ 

... the colliding file detection test passes!

ATB,
Ramsay Jones


