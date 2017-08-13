Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4551F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbdHMTpK (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:45:10 -0400
Received: from avasout06.plus.net ([212.159.14.18]:42298 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdHMTpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:45:10 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id wjl61v00218PUFB01jl8Ef; Sun, 13 Aug 2017 20:45:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=ezJKNaSpGO1By21FmWAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
 <20170813183026.GC31079@mail.zuhause>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
Date:   Sun, 13 Aug 2017 20:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813183026.GC31079@mail.zuhause>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/08/17 19:30, Martin Koegler wrote:
> On Sat, Aug 12, 2017 at 02:47:25PM +0100, Ramsay Jones wrote:
>> On 32-bit Linux, off_t is 64-bit and size_t is 32-bit.
> 
> --- t.c ---
> #include <stddef.h>
> #include <stdio.h>
> 
> int main()
> {
> printf("%d %d\n", sizeof(size_t), sizeof(off_t));
> }
> ------------
> $ gcc -m32 -o t t.c
> $ ./t.c
> 4 4
> 
> So is that really true?

It should be, see commit b97e911643 ("Support for large files
on 32bit systems.", 17-02-2007), where you can see that the
_FILE_OFFSET_BITS macro is set to 64. This asks <stdio.h> et.al.,
to use the "Large File System" API and a 64-bit off_t.

I can't boot my 32-bit installation at the moment, and it seems
that my 64-bit multilib system is not playing ball:

  $ gcc -m32 -D_FILE_OFFSET_BITS=64 -o t t.c
  In file included from /usr/include/stdio.h:27:0,
                   from t.c:2:
  /usr/include/features.h:367:25: fatal error: sys/cdefs.h: No such file or directory
  compilation terminated.
  $ 

ATB,
Ramsay Jones

