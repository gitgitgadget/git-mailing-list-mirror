Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2AC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A564EC3
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhCNSHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:07:46 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:34976 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhCNSHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:07:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 38648E47;
        Sun, 14 Mar 2021 19:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615745242; x=1617559643; bh=QwxxN0swAG20VT4Dec8
        oO3CNu5PXbtm1g2WGkEDuAow=; b=KMYhhKfyPH3VDdFuQqgmFN1/gsD8tRLQqMV
        mob9Osj7qBQDfbzXFpVGB2KiF9eRKIfdJyyFR85j19suaMxF+OO96V2aQh7n5vyu
        Wm5M0LWqhBic3lxU96ik2eqq14l6W5ylZBUjUQl8dUtpFJY/i2KnmUvp/TdfKMWA
        tmOhk9BMuDqADQ9pdO0b+O91tFm498sryKJ6ABDY9V0JIhRZsJtrZzZuW22Ju8NU
        DCJ4ehh23mUrTRlxw0xTsclvMG+ukp2PiizvRfsyQgde9sJhAHBviW0FJc7Pta7n
        WFUA2wEWXqEhU/y+w+WDHSl9xQxrffA3W0GmY4WM76wG4GzJg0EwV4ZJA297bUW9
        O4o+SgVUG2XcEfCI/kks7si4WP+Vuzk6bLxnjbHJsRuOYzrLVMfu1cimv16eIwar
        gapeNrW/4shi+IfZlTxsHixuLa0LlP72HNmBQenaQ4CaqeMX5x3l6VZhTEG9Oqgj
        QrcG+P6nzrfSy4d/mIWnGXj8MOJfPFJb3934w0AEuss03MVbZaj9+82m6UBoae9+
        foXl4DywpkWnYQuERJsGw9RdIMWlVjPMJ3u1NaRgH1+5F1IH3h7u7sFMgf6MSeDo
        cysSNyN+CXHRRsa7MHJsiL49eiQwd3cLnM8e4YUPzRCP1GXKFX/qJ01LdQHOumyv
        S41YRrBM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SjYjIIExSzhc; Sun, 14 Mar 2021 19:07:22 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 785C2B00;
        Sun, 14 Mar 2021 19:07:22 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 3C19A33EB;
        Sun, 14 Mar 2021 19:07:20 +0100 (CET)
Subject: Re: [PATCH 1/7] symbolic-ref: don't leak shortened refname in
 check_symref()
To:     Jeff King <peff@peff.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <ff0f7c167fa5b5da2d843fa03edb70907e6af763.1615228580.git.gitgitgadget@gmail.com>
 <YEZ0jLppB9wOg/af@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <8d413cdb-e264-8381-7254-522c3453f188@ahunt.org>
Date:   Sun, 14 Mar 2021 19:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <YEZ0jLppB9wOg/af@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 08/03/2021 20:01, Jeff King wrote:
> On Mon, Mar 08, 2021 at 06:36:14PM +0000, Andrzej Hunt via GitGitGadget wrote:
> 
>> From: Andrzej Hunt <ajrhunt@google.com>
>>
>> This leak has existed since:
>> 9ab55daa55 (git symbolic-ref --delete $symref, 2012-10-21)
>>
>> This leak was found when running t0001 with LSAN, see also LSAN output
>> below:
>>
>> Direct leak of 19 byte(s) in 1 object(s) allocated from:
>>      #0 0x486514 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>>      #1 0x9ab048 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
>>      #2 0x8b452f in refs_shorten_unambiguous_ref /home/ahunt/oss-fuzz/git/refs.c
>>      #3 0x8b47e8 in shorten_unambiguous_ref /home/ahunt/oss-fuzz/git/refs.c:1287:9
>>      #4 0x679fce in check_symref /home/ahunt/oss-fuzz/git/builtin/symbolic-ref.c:28:14
>>      #5 0x679ad8 in cmd_symbolic_ref /home/ahunt/oss-fuzz/git/builtin/symbolic-ref.c:70:9
>>      #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
>>      #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
>>      #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
>>      #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
>>      #10 0x69cc6e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
>>      #11 0x7f98388a4349 in __libc_start_main (/lib64/libc.so.6+0x24349)
> 
> As a general template for fixing leaks, this information seems pretty
> good. You might want to give a brief reason for why it's a leak (like
> you do already in the second patch). Here it just would be something
> like:
> 
>    shorten_unambiguous_ref() returns an allocated string. We have to
>    track it separately from the const refname.
> 
> Or whatever. It doesn't need to be a novel, but just give an overview of
> what's going that makes the diff obvious.

Good point - I've copied this one verbatim - but it's also a good thing 
to remember if/when I fix further leaks!

> 
> There's also an idiom in Git's codebase when a const pointer may alias
> unowned storage, or a buffer that needs to be freed. Something like:
> 
>    if (print) {
>            char *to_free = NULL;
> 	  if (shorten)
> 	          refname = to_free = shorten_unambiguous_ref(refname, 0);
> 	  puts(refname);
> 	  free(to_free);
>    }
> 
> That avoids duplicating the part of the code that handles the variable.
> In this case it is only a single line, but IMHO it's still easier to
> read, as it makes clear that we call puts() in either case.

That's a nice pattern, and will probably be useful for future leak fixes 
too - I've made this change too!
