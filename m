Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8378A1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 19:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbeITBQz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:16:55 -0400
Received: from avasout06.plus.net ([212.159.14.18]:47941 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeITBQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:16:55 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2iHxgFiSBWLW22iHygvvKJ; Wed, 19 Sep 2018 20:37:31 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=AFZVbWJ3m9jpNa944rAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] Makefile: add a hdr-check target
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
References: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
 <CAN0heSpNT25PrNwdbQKZo=Q8kpSfwnzuOz34xKHtfF+Fq9ZXmg@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <89478060-85c1-416a-0ad9-54d3f8f1111b@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 20:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSpNT25PrNwdbQKZo=Q8kpSfwnzuOz34xKHtfF+Fq9ZXmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfO1jCb+/o59tjXtR+f0o3Rv9BVIUdtA6iy7ntX70t0Y97rhuzwKE/WJg0erTwiaCS9F5j1wQiSC6bfDwWBT7g9o6ftmKrVZqpfMrqVwSdME4scOWMoMj
 Xs4RwtATrVE9a5h/hZdnSaMXWkLtQPLBCQB+Tv2kmff65xEx0xK0dRwQNS8UjnhEyPfWxsFFrQ4S1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/09/18 18:49, Martin Ågren wrote:
> Hi Ramsay,
> 
> On Wed, 19 Sep 2018 at 02:07, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> @@ -2675,6 +2676,17 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>>  .PHONY: sparse $(SP_OBJ)
>>  sparse: $(SP_OBJ)
>>
>> +GEN_HDRS := command-list.h unicode-width.h
> 
> Most of the things happening around here are obvious steps towards the
> end-goal and seem to logically belong here, together. This one though,
> "generated headers"(?) seems like it is more general in nature, so could
> perhaps live somewhere else.

Yes, generated headers, but no, not more general. ;-)

I originally included those headers directly in the
EXCEPT_HDRS macro, along with the list of excluded
directories (which was much longer at one point).

The 'command-list.h' is generated as part of the build
(and so may or may not be part of the LIB_H macro), whereas
the unicode-width.h header is only re-generated when someone
runs the 'contrib/update-unicode/update_unicode.sh' script
(presumably when a new standard version is announced) and
commits the result.

Both headers fail the 'hdr-check', although both generator
scripts could be 'fixed' so that they passed. I just didn't
think it was worth the effort - neither header was likely
to be #included anywhere else. I guess I could eliminate
that macro, absorbing it into EXCEPT_HDRS, if that would
lead to less confusion ...

[I suspect the fact that LIB_H (almost always) contains
'command-list.h' has not been noticed ... :-P ]

> Actually, we have a variable `GENERATED_H` which seems to try to do more
> or less the same thing. It lists just one file, though, command-list.h.
> And unicode-width.h seems to be tracked in git.git.

Hmm, GENERATED_H seems only to be used by the i18n part of the
makefile and, as a result of its appearance in LIB_H, sometimes
results in command-list.h appearing twice in LOCALIZED_C.
(which is probably not a problem).

ATB,
Ramsay Jones

> Maybe use `GENERATED_H` instead, and list unicode-width.h on the next
> line instead? Or am I completely misreading "GEN_HDRS"?
> 
>> +EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
>> +CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
>> +HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
>> +
>> +$(HCO): %.hco: %.h FORCE
>> +       $(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
>> +
>> +.PHONY: hdr-check $(HCO)
>> +hdr-check: $(HCO)
>> +
>>  .PHONY: style
>>  style:
>>         git clang-format --style file --diff --extensions c,h
> 
