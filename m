Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A8720437
	for <e@80x24.org>; Tue, 31 Oct 2017 12:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdJaMwH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 08:52:07 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:48477 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdJaMwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 08:52:06 -0400
Received: by mail-qt0-f179.google.com with SMTP id f8so20518368qta.5
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6K7uu77a5dFodiAzD2bwk1C+1Hyj4KIGL02Ha3QA74=;
        b=KvvBWhiQS1kagX0tLwleZZIkAUVzQyr1ALCEHcq/VBwRtVAEo8Vb6oL7NdMV0vumcJ
         yYtl5hXKBOoC9bj5Yt5VN9eDPMwXyhxNf1tj31xTKyvuCn46/GEUo6WxYLrgBqjuPpO+
         gBH6YuAtoBoriG/MSVr1ETAL0MqsgnnxGaxqqOUmamktK3mkl93jPDUSSfRmTnxTiD+9
         iHoXoBHPzjVYkPYdjC2+MIc4KSH2DaoY+ohs+9N2dSeyaUnWnbbaxQdsgJUxHPL4SDNk
         pScJK2M+xRLe9Su7xgZPyaTd95t/63ebb08oBwqWgNuKjNixn4Q0g2bHT2EFB3rwUNdk
         1flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6K7uu77a5dFodiAzD2bwk1C+1Hyj4KIGL02Ha3QA74=;
        b=JXCXS4C/dPNoiuyHCaJC2Kfl+piMOvMQVXtgU0RQCVGXctOgns162wQk1tWoRLQ/R3
         c6tr67ciHVlbBpchrPGgdb19l2vmmIKmlVxl5Ml87WHau+vRD7fnIfQU7UR5vvqJ87mr
         /jI1Lf7A2EX2DqbuM1MFzN7VxC4UwSY6giLhGpWdUmC/wAX/Lv/qO6LJm9Up0bViafOB
         ERRxP0oc11cpJFqhfCbkOy7SGgJom7iHcBhxIneDf1s7cG9zDKzXv+jGix8vsW5lLfRM
         5Db5LnzAR/7kcTLggB/nEqQcruLOTFhLZBFn6mWUIUU1JgvFuE2IAWcmrwufgMoitSzL
         0j6Q==
X-Gm-Message-State: AMCzsaXgUyyxZFN8UNvlS8OHDWsQO/YMdjICIaPgryq2OpcKFP3cf88Z
        djKs4pbiRzMPGUvWK9ACyHg=
X-Google-Smtp-Source: ABhQp+TKm20fsXD45xEC4i7d5LHodwdfTENI8ARi09S4u5gq1EUz9iP/A+Wa9cFY6XdbjcdwHsHAAQ==
X-Received: by 10.237.34.132 with SMTP id p4mr2470390qtc.162.1509454325363;
        Tue, 31 Oct 2017 05:52:05 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q63sm644961qkf.66.2017.10.31.05.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Oct 2017 05:52:04 -0700 (PDT)
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache
 entry order to speed index loading
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org, t.gummerer@gmail.com, l.s.r@web.de,
        jsorianopastor@gmail.com, peff@peff.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <20171024144544.7544-1-benpeart@microsoft.com>
 <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
 <xmqq8tfs3x3m.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8e268809-b596-fd1c-1f39-e040743596cb@gmail.com>
Date:   Tue, 31 Oct 2017 08:51:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tfs3x3m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/30/2017 9:49 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> Any updates or thoughts on this one?  While the patch has become quite
>> trivial, it does results in a savings of 5%-15% in index load time.
>>
>> I thought the compromise of having this test only run when DEBUG is
>> defined should limit it to developer builds (hopefully everyone
>> developing on git is running DEBUG builds :)).  Since the test is
>> trying to detect buggy code when writing the index, I thought that was
>> the right time to test/catch any issues.
> 
> This check is more about catching a possible breakage (and a
> malicious repository) early before we go too far into the operation.
> I do not think this check is about debugging the implementation of
> Git.  How would it be useful to turn it on in DEBUG build?
> 
> While I do think pursuing any runtime improvements better than a
> couple of percents is worth it, I do not think the approach taken by
> this iteration makes much sense; the previous one that at least
> allowed fsck to catch breakage may have been already too leaky to
> catch real issues (i.e. when you are asked to visit and look at an
> unknown repository, you wouldn't start your session with "git fsck"
> to protect yourself), and this round makes it much worse.
> 
> Besides, I see no -DDEBUG from "grep -e '-D[A-Z]*DEBUG' Makefile".
> If this check were about allowing us easier time debugging the
> binary (which I do not think it is), this probably should be
> '#ifndef NDEBUG' instead.
> 

I've tried 3 different ways to remove the overhead of this call from 
regular git operations.

The first was version 1 of the patch which had fsck catch breakage but 
removed it from other commands that read the index.  Since that version 
was not accepted, I took the feedback "I think I like the direction of 
getting rid of the order in post_read_index_from(), not only during the 
normal but also in fsck" to come up with a version 2.

I was hesitant to remove the code completely as I did believe it had 
some value in detecting invalid indexes so went looking for a macro I 
could use to have it 1) not happen during regular user commands but 2) 
still happen for developers.

The NDEBUG macro is guaranteed by the C89 standard 
(http://port70.net/~nsz/c/c89/c89-draft.html#4.1.2 ) to guard the code 
that is only necessary when assertions are in effect so seemed like a 
good choice.  When I used it however, I discovered that the git Makefile 
does not define NDEBUG so using this macro did not have any effect thus 
making the patch useless as the code continues to run in all cases.

On a side note, there are 434 instances of assert which up until this 
experience I believed were being removed in released builds.  As far as 
I can tell, that is not the case.  If removing them is the 
desired/expected behavior, we need to fix our Makefile as it only 
currently defines NDEBUG if USE_NED_ALLOCATOR is defined.

I then searched the code and found 47 instances where the macro DEBUG 
was used.  I (incorrectly) assumed that meant it must be used by other 
git developers.  I personally have a build alias that adds "-j12 
CFLAGS=-DDEBUG" to my make command but apparently I'm in the minority. :)

This assumption led me to the patch version 2 (guarding the code with 
#ifdef DEBUG) as it does meet the request to remove it during normal but 
also fsck and does so with regular/release builds as they are currently 
defined.

It seems that the current round of feedback is more in favor of leaving 
the test in fsck but removing it for other commands.  If that is the 
desired behavior, please use version 1 of the patch.

I'm also happy to flip this to "#ifndef NDEBUG" but that only makes 
sense if the released builds actually set NDEBUG which (I believe) will 
require a patch to Makefile.

