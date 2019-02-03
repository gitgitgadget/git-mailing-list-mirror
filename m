Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129D01F453
	for <e@80x24.org>; Sun,  3 Feb 2019 15:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfBCPTW (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 10:19:22 -0500
Received: from avasout05.plus.net ([84.93.230.250]:38300 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfBCPTW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 10:19:22 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id qJYFgh0CwyTttqJYHgEScr; Sun, 03 Feb 2019 15:19:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=XuzUx2N9 c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=-YPemCMMxzMABtQOU-IA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/1] Using sparse in a CI job
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
References: <78f85f0b-176f-0b54-2ec8-4c13fd386733@ramsayjones.plus.com>
 <20190201223959.zmlyg4buwolw2b3p@ltop.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <29138259-51cb-dec5-6f99-865868a00366@ramsayjones.plus.com>
Date:   Sun, 3 Feb 2019 15:19:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201223959.zmlyg4buwolw2b3p@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJQgC0R2hib9v4AyeMsFOKkrgiXDJxv3kIYxObKk6noHJwI9B8HnstFzlggDvSqGKvkaiPzLrzsYcff22w0I2lqGSrv19KAHTTjVUuidBfLQNClP4hA+
 ZKsK8OhRPeDYfD5SyG/SftQwU+C7vZDIQ5NuIOSmCXfticE/p+v60kaEd+rmM0V110aWp34ClUz6lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/02/2019 22:40, Luc Van Oostenryck wrote:
> On Fri, Feb 01, 2019 at 09:01:20PM +0000, Ramsay Jones wrote:
>>
>> I suspect that the Makefile sparse target is not easy to use in a CI
>> job, since the 'sparse' program (via cgcc -no-compile) does not exit
>> with a non-zero value, even when issuing errors and warnings.
> 
> ...
>  
>> We can change that by passing '-Wsparse-error' to 'sparse':
>>
>>   $ make SPARSE_FLAGS=-Wsparse-error change-table.sp
>>       SP change-table.c
>>   change-table.h:53:24: error: dubious one-bit signed bitfield
>>   change-table.h:54:25: error: dubious one-bit signed bitfield
>>   change-table.h:55:25: error: dubious one-bit signed bitfield
>>   change-table.h:56:26: error: dubious one-bit signed bitfield
>>   Makefile:2729: recipe for target 'change-table.sp' failed
>>   make: *** [change-table.sp] Error 1
>>   $ echo $?
>>   2
>>   $ 
>>
>> Note that '-Wsparse-error' not only returns a non-zero exit code (1), but
>> it also changes a 'warning' into an 'error' (see above):
> 
> Yes, I know :(
> The fact that, by default, sparse doesn't fail on errors is wanted
> (otherwise it would break the kernel compile). But that the only way
> to return an error is to use -Wsparse-error (which is supposed to
> replace GCC's -Werror) is a real problem.

Given that I only use sparse as a checker, I actually don't mind
the current behaviour. That would be different if I was using
sparsec/sparsei etc., as a compiler, of course! ;-)

[If I were to suggest any change at all to -Wsparse-error it would
be: do not change the 'warning' to an 'error' (yes, the actual text
label of the message), exit(1) if any errors or warnings, but *if*
only warnings have been issued, then print an "treating warnings
as errors [-Wsparse-error]" message.]

ATB,
Ramsay Jones

