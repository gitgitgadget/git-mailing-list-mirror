Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8815D1F667
	for <e@80x24.org>; Sun, 13 Aug 2017 16:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbdHMQgl (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 12:36:41 -0400
Received: from avasout06.plus.net ([212.159.14.18]:39363 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdHMQgk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 12:36:40 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id wgce1v00118PUFB01gcf8V; Sun, 13 Aug 2017 17:36:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=iTWjZBjrYC9huTXt-uQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC] clang-format: outline the git project's coding style
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <20170811175237.GC59325@google.com>
 <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net>
 <xmqq378xxuvk.fsf@gitster.mtv.corp.google.com>
 <20170813044145.xz4o47oog3z5eycg@sigill.intra.peff.net>
 <26bebb5b-857f-1501-5139-a5513d9875ec@ramsayjones.plus.com>
Message-ID: <4ded81fc-a495-023f-02e7-2dbd2ec1be68@ramsayjones.plus.com>
Date:   Sun, 13 Aug 2017 17:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <26bebb5b-857f-1501-5139-a5513d9875ec@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/08/17 17:14, Ramsay Jones wrote:
> 
> 
> On 13/08/17 05:41, Jeff King wrote:
>> On Fri, Aug 11, 2017 at 09:39:11PM -0700, Junio C Hamano wrote:
>>
>>>> Yeah, I just dug in the archive. The script I ran way back when was
>>>> actually clang-format-diff.
>>>
>>> I am confident with the competence of people around here that we can
>>> come up with a reasonable checker for obvious style violations. In
>>> the worst case, we could customize and/or tweak checkpatch.pl and
>>> start from there.
>>
>> I am confident we _can_, too. My question is whether we will. :)
>>
>>> Assuming that we can have such a checker, I am more interested in
>>> the way how people envision such a checker fits in our workflow to
>>> help people.  Earlier Dscho floated an idea to integrate with the
>>> GitHub pull requests in a way similar to how Travis and SubmitGit
>>> are triggered, and I can sort of see how it may help, but I haven't
>>> seen ideas from others.
>>
>> Yeah, I agree. I assume most people already run "make test" locally. I'd
>> be happy enough if we started with a "make style" that offers style
>> suggestions for you to accept. From there we can grow into
>> "automatically apply suggestions" and integrating with things like
>> submitGit.
> 
> As a start, how about something like this:
> 
> -- >8 --
> $ git diff
> diff --git a/Makefile b/Makefile
> index 461c845d3..7555def45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2440,6 +2440,18 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> +ST_C = $(patsubst %.o,%.stc,$(C_OBJ))
> +ST_H = $(patsubst %.h,%.sth,$(LIB_H))
> +
> +$(ST_C): %.stc: %.c FORCE
> +       checkpatch.pl --no-tree --show-types --ignore=NEW_TYPEDEFS,INLINE -f $<
> +
> +$(ST_H): %.sth: %.h FORCE
> +       checkpatch.pl --no-tree --show-types --ignore=NEW_TYPEDEFS,INLINE -f $<
> +
> +.PHONY: style $(ST_C) $(ST_H)
> +style: $(ST_C) $(ST_H)
> +
>  check: common-cmds.h
>         @if sparse; \
>         then \
> $ 
> -- >8 --
> 
> To give it a try:
> 
>     $ make git.stc    # just run checkpatch over git.c
>     $ make cache.sth  # just run checkpatch over cache.h
>     $ make -k style >style.out 2>&1  # yep, large output!
> 
> A bit crude, but workable. ;-)
> 
> Just FYI, for me:
> 
> $ wc -l style.out
> 144076 style.out
> $ 
> $ grep '^WARNING' style.out | cut -d: -f1,2 | sort | uniq -c
>       2 WARNING:AVOID_EXTERNS
>     495 WARNING:BLOCK_COMMENT_STYLE
>     127 WARNING:BRACES
>     213 WARNING:CONSTANT_COMPARISON
>   12584 WARNING:CONST_STRUCT
>       5 WARNING:CVS_KEYWORD
>      26 WARNING:DEEP_INDENTATION
>       2 WARNING:DEFAULT_NO_BREAK
>      77 WARNING:EMBEDDED_FUNCTION_NAME
>       5 WARNING:ENOSYS
>     773 WARNING:FUNCTION_ARGUMENTS
>      39 WARNING:INDENTED_LABEL
>    2610 WARNING:LEADING_SPACE
>       1 WARNING:LINE_CONTINUATIONS
>    2680 WARNING:LINE_SPACING
>    3975 WARNING:LONG_LINE
>     330 WARNING:LONG_LINE_COMMENT
>     380 WARNING:LONG_LINE_STRING
>       2 WARNING:MACRO_WITH_FLOW_CONTROL
>       1 WARNING:MISORDERED_TYPE
>      17 WARNING:MISSING_SPACE
>       1 WARNING:ONE_SEMICOLON
>      77 WARNING:PREFER_PRINTF
>       7 WARNING:QUOTED_WHITESPACE_BEFORE_NEWLINE
>      10 WARNING:RETURN_VOID
>       5 WARNING:SINGLE_STATEMENT_DO_WHILE_MACRO
>       6 WARNING:SIZEOF_PARENTHESIS
>      61 WARNING:SPACE_BEFORE_TAB
>     347 WARNING:SPACING
>     322 WARNING:SPLIT_STRING
>      87 WARNING:STATIC_CONST_CHAR_ARRAY
>       2 WARNING:STORAGE_CLASS
>     538 WARNING:SUSPECT_CODE_INDENT
>      29 WARNING:SYMBOLIC_PERMS
>     279 WARNING:TABSTOP
>       9 WARNING:TRAILING_SEMICOLON
>       3 WARNING:TYPECAST_INT_CONSTANT
>       2 WARNING:UNNECESSARY_BREAK
>      56 WARNING:UNNECESSARY_ELSE
>     568 WARNING:UNSPECIFIED_INT
>       4 WARNING:USE_NEGATIVE_ERRNO
>      26 WARNING:VOLATILE
> $ 

oops, I forgot this:

$ grep '^ERROR' style.out | cut -d: -f1,2 | sort | uniq -c
    216 ERROR:ASSIGN_IN_IF
     46 ERROR:CODE_INDENT
     41 ERROR:COMPLEX_MACRO
    317 ERROR:ELSE_AFTER_BRACE
      3 ERROR:FUNCTION_WITHOUT_ARGS
      1 ERROR:GLOBAL_INITIALISERS
     46 ERROR:INITIALISED_STATIC
      2 ERROR:INLINE_LOCATION
      5 ERROR:MULTISTATEMENT_MACRO_USE_DO_WHILE
    305 ERROR:OPEN_BRACE
    314 ERROR:POINTER_LOCATION
      5 ERROR:RETURN_PARENTHESES
   3464 ERROR:SPACING
      7 ERROR:SWITCH_CASE_INDENT_LEVEL
    326 ERROR:TRAILING_STATEMENTS
     15 ERROR:TRAILING_WHITESPACE
$ 

> Hmm, on reflection, it may be a bit too crude! :-D
> 
> ATB,
> Ramsay Jones
> 
> 
