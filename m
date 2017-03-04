Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67092023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbdCDTto (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:49:44 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:50808 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdCDTto (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:49:44 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v24JnT96024241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Mar 2017 19:49:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v24JnSIo031310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 4 Mar 2017 19:49:29 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v24JnQ4f022672;
        Sat, 4 Mar 2017 19:49:27 GMT
Received: from [10.175.200.62] (/10.175.200.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Mar 2017 11:49:26 -0800
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com, Jeff King <peff@peff.net>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
 <20170302105157.59791-1-larsxschneider@gmail.com>
 <alpine.DEB.2.20.1703021210170.3767@virtualbox>
 <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
 <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
Date:   Sat, 4 Mar 2017 20:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03/2017 19:08, Vegard Nossum wrote:
> On 04/03/2017 18:23, Lars Schneider wrote:
>> Did Travis find our first 32bit bug? I briefly looked into it
>> and the following new topic on pu seems to cause the issue:
>>
>> http://public-inbox.org/git/20170302172902.16850-1-allan.x.xavier@oracle.com/
>>
>> https://github.com/git/git/commit/aaae0bf787f09ba102f69c3cf85d37e6554ab9fd
>>
>>
>> The "git log" call in the new 4211 test fails with:
>> *** Error in `/usr/src/git/git': malloc: top chunk is corrupt:
>> 0x09ff4a78 ***
>>
>> More output here:
>> https://travis-ci.org/larsxschneider/git/builds/207715343
>
> It looks like it's hitting the bug the patch is supposed to fix.
>
> Are you quite sure it's running the "git" binary that was just built (as
> opposed to e.g. the system binary installed inside the container)?

Nevermind, I can reproduce it locally.

==10205== Invalid write of size 4
==10205==    at 0x4031ED2: memcpy (in 
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==10205==    by 0x811C4B0: memcpy (string3.h:53)
==10205==    by 0x811C4B0: range_set_copy.isra.7 (line-log.c:46)
==10205==    by 0x811C51B: line_log_data_copy_one (line-log.c:628)
==10205==    by 0x811C55D: line_log_data_copy (line-log.c:642)
==10205==    by 0x811C5E3: add_line_range (line-log.c:708)
==10205==    by 0x811D767: line_log_init (line-log.c:745)
==10205==    by 0x808B1CD: cmd_log_init_finish (log.c:204)
==10205==    by 0x808C9C8: cmd_log_init (log.c:213)
==10205==    by 0x808C9C8: cmd_log (log.c:681)
==10205==    by 0x804CF14: run_builtin (git.c:373)
==10205==    by 0x804CF14: handle_builtin (git.c:574)
==10205==    by 0x804D264: run_argv (git.c:626)
==10205==    by 0x804D264: cmd_main (git.c:703)
==10205==    by 0x804C448: main (common-main.c:43)
==10205==  Address 0x4cde9c8 is 0 bytes after a block of size 1,600 alloc'd
==10205==    at 0x402D17C: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==10205==    by 0x402F370: realloc (in 
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==10205==    by 0x819CC0F: xrealloc (wrapper.c:137)
==10205==    by 0x811C1C8: range_set_grow (line-log.c:21)
==10205==    by 0x811C499: range_set_init (line-log.c:32)
==10205==    by 0x811C499: range_set_copy.isra.7 (line-log.c:45)
==10205==    by 0x811C51B: line_log_data_copy_one (line-log.c:628)
==10205==    by 0x811C55D: line_log_data_copy (line-log.c:642)
==10205==    by 0x811C5E3: add_line_range (line-log.c:708)
==10205==    by 0x811D767: line_log_init (line-log.c:745)
==10205==    by 0x808B1CD: cmd_log_init_finish (log.c:204)
==10205==    by 0x808C9C8: cmd_log_init (log.c:213)
==10205==    by 0x808C9C8: cmd_log (log.c:681)
==10205==    by 0x804CF14: run_builtin (git.c:373)
==10205==    by 0x804CF14: handle_builtin (git.c:574)

At a glance, looks like range_set_copy() is using
sizeof(struct range_set) == 12, but
range_set_init/range_set_grow/ALLOC_GROW/REALLOC_ARRAY is using
sizeof(rs->range) == 8.


Vegard
