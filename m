Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536F91F935
	for <e@80x24.org>; Sat, 24 Sep 2016 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030375AbcIXTbN (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 15:31:13 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:43069 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965133AbcIXTbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 15:31:11 -0400
Received: from PhilipOakley ([92.22.56.237])
        by smtp.talktalk.net with SMTP
        id nsfDbEVe4Y8RwnsfDbLhyF; Sat, 24 Sep 2016 20:31:08 +0100
X-Originating-IP: [92.22.56.237]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=STbUQm/7X+VKdJQF1oCBnA==:117
 a=STbUQm/7X+VKdJQF1oCBnA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=uPzRSOJ5EUrN_o5EWMcA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <35DEF8289BD84B7AB5C3CD53E8BCF83B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ben Peart" <Ben.Peart@microsoft.com>, <pclouds@gmail.com>,
        <git@vger.kernel.org>
References: <20160913142628.15440-1-benpeart@microsoft.com>        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>        <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>        <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>        <007401d21278$445eba80$cd1c2f80$@gmail.com>        <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com>        <xmqqr38fg6tk.fsf@gitster.mtv.corp.google.com>        <BL2PR03MB323ADC371E49EFD1CBBC566F4F60@BL2PR03MB323.namprd03.prod.outlook.com>        <99A866BEF8944598A50C6E061A703297@PhilipOakley> <xmqqd1jtyx01.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
Date:   Sat, 24 Sep 2016 20:31:09 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPvSG8lbjlulCn2WpT85w/Sj9OV0yVW/XU6BPd22CUTn5IjufiaeaC+2rxw+rd26/xhzidShqSGRYqufn6Ia2QlyC/ixGBSNuh+HhbiZDHE/9nAG0y2G
 tPwReSAq9CvEUqpaxbJ0jSNeACAZUMVuOpYZYcQINRIvOLP9w4hkcPepGhFKgjI3ZbT58LmD1nevj90k16a7mp8MM7eF/6hro79UhhtJPV2SlqBQt7V3QQbV
 qHYxntycmoae5Z7Raffn6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> > >"git checkout -b foo" (without -f -m or <start_point>) is defined in
>>> > >the manual as being a shortcut for/equivalent to:
>>> > >
>>> > >        (1a) "git branch foo"
>>> > >        (1b) "git checkout foo"
>>> > >
>>> > >However, it has been our experience in our observed use cases and all
>>> > >the existing git tests, that it can be treated as equivalent to:
>>> > >
>>> > >        (2a) "git branch foo"
>>> > >        (2b) "git symbolic-ref HEAD refs/heads/foo"
>>> > >...
>>> > >
>>> > I am still not sure if I like the change of what "checkout -b" is this
>>> > late in the game, though.
>>>
>>> ...
>>> That said, you're much more on the frontline of receiving negative
>>> feedback about doing that than I am. :)  How would you like to
>>> proceed?
>>
>> I didn't see an initial confirmation as to what the issue really
>> was. You indicated the symptom ('a long checkout time'), but then we
>> missed out on hard facts and example repos, so that the issue was
>> replicable.
>
> I took it as a given, trivial and obvious optimization opportunity,
> that it is wasteful having to traverse two trees to consolidate and
> reflect their differences into the working tree when we know upfront
> that these two trees are identical, no matter what the overhead for
> doing so is.

I agree, and I believe Ben agrees.

>
>> At the moment there is the simple workaround of an alias that executes
>> that two step command dance to achieve what you needed, and Junio has
>> outlined the issues he needed to be covered from his maintainer
>> perspective (e.g. the detection of sparse checkouts). Confirming the
>> root causes would help in setting a baseline.
>>
>> I hope that is of help - I'd seen that the discussion had gone quiet.
>
> Some of the problems I have are:
>
> (1) "git checkout -b NEW", "git checkout", "git checkout HEAD^0"
>     and "git checkout HEAD" (no other parameters to any of them)
>     ought to give identical index and working tree.  It is too
>     confusing to leave subtly different results that will lead to
>     hard to diagnose bugs for only one of them.
>
> (2) The proposed log message talks only about "performance
>     optimization",

>                                while the purpose of the change is more 
> about
>     changing the definition

Here I think is the misunderstanding. His purpose is NOT to change the 
definition (IIUC). As I read the message you reference below (and Ben's 
other messages), I understood that he was trying to achieve what you said 
(i.e. optimise the trivial and obvious opportunity) of selecting for the 
common case (underlying conditions) where the two command sequences are 
identical. If the selected case / conditions is not identical then it is 
defined wrongly...

I suspect that it was Ben's 'soft' explanation that allowed the discussion 
to diverge.


>                                                 of what "git checkout -b 
> NEW" is from
>     "git branch NEW && git checkout NEW" to "git branch NEW && git
>     symbolic-ref HEAD refs/heads/NEW".  The explanation in a Ben's
>     later message <007401d21278$445eba80$cd1c2f80$@gmail.com> does
>     a much better job contrasting the two.
>
> (3) I identified only one difference as an example sufficient to
>     point out why the patch provided is not a pure optimization but
>     behaviour change.  Fixing that example alone to avoid change in
>     the behaviour is trivial (see if the "info/sparse-checkout"
>     file is present and refrain from skipping the proper checkout),

This is probably the point Ben needs to take on board to narrow the 
conditions down. There may be others.

>     but a much larger problem is that I do not know (and Ben does
>     not, I suspect) know what other behaviour changes the patch is
>     introducing, and worse, the checks are sufficiently dense too
>     detailed and intimate to the implementation of unpack_trees()
>     that it is impossible for anybody to make sure the exceptions
>     defined in this patch and updates to other parts of the system
>     will be kept in sync.

I did not believe he was proposing such a change to behaviour, hence his 
difficulty in responding (or at least that is my perception). I.e. he was 
digging a hole in the wrong place.

It is possible that he had accidentally introduced a behavious change, and 
having failed to explictly say "This patch (should) produces no behavious 
change", which then continued to re-inforce the misunderstanding.

>
> So my inclination at this point, unless we see somebody invents a
> clever way to solve (3), is that any change that violates (1),
> i.e. as long as the patch does "Are we doing '-b NEW'?  Then we do
> something subtly different", is not acceptable, and solving (3) in a
> maintainable way smells like quite a hard thing to do.  But it would
> be ideal if (3) is solved cleanly, as we will then not have to worry
> about changing behaviour at all and can apply the optimization for
> all of the four cases equally.  As a side effect, that approach
> would solve problem (2) above.
>
> If we were to punt on keeping the sanity (1) and introduce a subtly
> different "create a new branch and point the HEAD at it", an easier
> way out may be be one of
>
> 1. a totally new command, e.g. "git branch-switch NEW" that takes
>    only a single argument and no other "checkout" options, or
>
> 2. a new option to "git checkout" that takes _ONLY_ a single
>    argument and incompatible with any other option or command line
>    argument, or
>
> 3. an alias that does "git branch" followed by "git symbolic-ref".
>
> Neither of the first two sounds palatable, though.

It will need Ben to come back and clarify, if he did, or did not, want any 
behaviour change (beyond speed of action;-)

Thanks

Philip 

