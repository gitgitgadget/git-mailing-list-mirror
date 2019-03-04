Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE52B20248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCDUbk (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:31:40 -0500
Received: from avasout04.plus.net ([212.159.14.19]:43823 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCDUbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 15:31:39 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 0uFMhp2HZAOoy0uFNhlHUw; Mon, 04 Mar 2019 20:31:37 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=3Luv61TOzu5PQKMIbvUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if
 possible
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
 <8e4b7966-7a3e-a081-bfc1-9e60303b8eab@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1903041210410.45@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b4ea52cb-bbd1-5b55-d3d8-b09285bb2e6f@ramsayjones.plus.com>
Date:   Mon, 4 Mar 2019 20:31:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1903041210410.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNRHWRkjnEzGRkbfF1upbOox0a4Ab0u50XeRoINf0/CIu1l5IR1WP/2BKYh2LjiUqeZAjMI1P2Q3oHd6txqzbIOwGqzO9C/rIQiWyHSWwvVNRbW2b5+y
 Aqg4Z40/DUgX5vW38lXE4xNdRIG8mrNSUgntuPZmAV4QyRVEu3vl3zav+XXP7rUkOfwHyOeuf1ANOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/03/2019 12:38, Johannes Schindelin wrote:

>> So, tl;dr: soon, I will be submitting a patch to remove the
>> 'hdr-check' target completely, for now anyway.
> 
> You mentioned later that you might be the only person using that target,
> and if that were so, I would agree.

It is obviously difficult to judge such a thing, but I suspect
that the number is very low, if not exactly one. ;-)

> However, I started looking into adding `hdr-check` to the Azure Pipeline
> we have (which would make a *ton* of sense, if you ask me), along with the

Hmm, I am in two minds about this - I feel duty bound to warn you
that, if you go ahead with this idea, you will likely create a
rod for your own back! :-D

If the false positive rate can be kept reasonably low, then this
would be a good idea. However, some projects are just not a good
fit for this kind of thing (and Git may be one of them).

> `sparse` thing we talked about.
> 
> So I am a bit opposed to removing that target.

OK, I took the 'nuclear' route because this affects people (to a
greater or lesser degree) even when they don't know/care about
this target. If it is just (or mostly) me, then it didn't seem
worth causing issues for you (or anyone else working on GTW?).

>>> By the way, "make hdr-check" already fails for me on master, as I do
>>> not have libgcrypt installed, and it unconditionally checks
>>> sha256/gcrypt.h.
>>
>> Yep, for me too. There is a similar problem if you build with
>> NO_CURL and don't have the 'curl/curl.h' header file, etc ...
> 
> I think all it needs to do is to pass `$(ALL_CFLAGS)` to gcc (although we
> might need to add something like `#if defined(SHA256_GCRYPT) ... #endif`
> guards to `sha256/gcrypt.h` to make it work in Peff's case).

Just adding $(ALL_CFLAGS) to the command-line is not a cure-all,
unfortunately! :( Also, the 'sha256/gcrypt.h' should be excluded
from the list of headers to check, conditionally, based on the
build variable SHA256_GCRYPT. 

> But given that this target really is meant to catch all kinds of errors,
> I'd be in favor of declaring that target requiring things like libgcrypt's
> header files to be installed. We can easily make that happen in our CI
> builds.

That would help, but you may not be able to cover all the platform
specific build options available. dunno. (I haven't given it enough
thought).

>> The next version was essentially the same patch that started this thread
>> from Johannes (ie. the 'git ls-files' patch), given that the 'tags'
>> targets had found it necessary. However, when I did some 'informal'
>> timing tests (ie 5x 'time make ...' and average), this did not make any
>> noticeable difference for me (_even_ on cygwin!). ;-)
> 
> My complaint is not about the speed in a regular clone, but about *my*
> special clone, where I have some 50+ worktrees (that I really like to keep
> in the same directory, thankyouverymuch, I ignore them via
> `.git/info/exclude`, and I really like to have them all tucked away neatly
> under the `/usr/src/git/` directory) and also some 30+ cloned repositories
> in `3rdparty/` for random testing (including a bare clone of the Linux
> kernel, of course also ignored via `.git/info/exclude`).

Oh, wow! I can't imagine ever doing anything like that. However,
it is a perfectly valid setup and the build system should not
make it hard for you to work the way you want.

> In that scenario, my version of `find` takes ages, only to finally even
> throw a segmentation fault (!).
At least the segfault curtailed your misery! :-D

>> So, I already have a 'hdr-check-fixup' branch (I think I have
>> already mentioned it), in which the first commit looks like:
>>
>>   diff --git a/Makefile b/Makefile
>>   index c5240942f2..3401d1b9fb 100644
>>   --- a/Makefile
>>   +++ b/Makefile
>>   @@ -2735,9 +2735,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>>    .PHONY: sparse $(SP_OBJ)
>>    sparse: $(SP_OBJ)
>>    
>>   +HC_HDRS := $(wildcard *.h negotiator/*.h block-sha1/*.h ppc/*.h ewah/*.h \
>>   +       sha1dc/*.h refs/*.h vcs-svn/*.h)
> 
> But of course that would also share at least to a lesser extend the
> shortcomings of a static list.

Yes, but it is no worse than ...

> I still like the `ls-files` method the best.
> 
>>    GEN_HDRS := command-list.h unicode-width.h
>>   -EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
>>   -CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))

... the original, manually maintained, exception list!

(This patch was written before the 'sha256/' directory existed.
So the fact that it 'fixes' the GCRYPT error is simply an accident
of timing! Today, it would be conditionally added to the exception
list. Yes, I watched that error go from the 'pu' branch down to
the 'master' branch).

>>   +CHK_HDRS = $(filter-out $(GEN_HDRS),$(HC_HDRS))
>>    HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
>>    
>>    $(HCO): %.hco: %.h FORCE
>>   
>>
>> ... which drops the use of LIB_H entirely.
>>
>> So, if we really need to solve the problem, allowing for some
>> unrelated headers in your worktree, then we can only use a
>> static list, or a 'git ls-files' approach.
> 
> Or we can use `ls-files`, and fall back to your wildcard idea if
> `ls-files` fails for some reason (typically because `.git/` is missing,
> e.g. in case of an unpacked source .tar).

Yes, I think an 'git ls-files' approach is the way to go. (I am not
sure that the 'hdr-check' target would be of any use 'offline' at
all, but I suppose we could use a generated file in that case).

>> Anyway, for now, since I seem to be the only person using this
>> target, I think we should just remove it while I think again.
>> (I can put it in my config.mak, so there will be no loss for me).
> 
> As I said above, I would rather keep it, with the `ls-files` and `:=`
> fixup.

I would be happy with that, if you are. :-D

ATB,
Ramsay Jones

