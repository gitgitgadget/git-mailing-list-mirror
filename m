Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A2AC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 03:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A7023121
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 03:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbhATD04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 22:26:56 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:39226 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbhATD0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 22:26:39 -0500
Received: from [10.42.0.115] (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10K3PmmL022352
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 19 Jan 2021 22:25:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10K3PmmL022352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611113149; bh=+QlOFOvvNTrBs0Lyf9CSMCXoQ8scWA28mHRRiVzbZ00=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tcdI8UIzPvXJ1qFtGlOoIEjqVxP1yOWc+9FqlL/bXaAOB3mc5VD8Z7ffqKMtt06NW
         gsZ5eovJ1h6gBs1dwDcRePp6RImU9GWXFFlzSaMEt53GUrLmFznk9qX9X6ZUBVYz1G
         UgZlbmybLKaF2ydT1SxI46dxCcQPOVmJ5bb2nrfk2YVutWKIkOOWJpSAch1mWprp3h
         BPEPS7WSiMO19/XhsgSEV2q8zVTOJ+LpPOvDqS9RGo/hwfWKJuweZRBlwsa/i8V1WJ
         IExse6FNlyYjV2HdqmOUVNwyYUGN6B+WYvA4GYBVzUNUUDJig+/ANGNaNgLflfKUtJ
         C9nD55Xm643dg==
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
 <20210117110337.429994-2-kmarek@pdinc.us>
 <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
 <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
 <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
 <xmqqr1mij88k.fsf@gitster.c.googlers.com>
 <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
 <xmqq1reginnq.fsf@gitster.c.googlers.com>
From:   Kyle Marek <kmarek@pdinc.us>
Message-ID: <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>
Date:   Tue, 19 Jan 2021 22:25:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq1reginnq.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/21 5:10 PM, Junio C Hamano wrote:
> Kyle Marek <kmarek@pdinc.us> writes:
>
>>> So the condition we saw in your patches, !commit->parents, which
>>> attempted to see if it was root, needs to be replaced with a helper
>>> function that checks if there is any parent that is shown in the
>>> output.
>>> ...
>>> Hmm?
>> Okay, I see what you mean. Fixing --graph to avoid implying ancestry
>> sounds like a better approach to me.
> Sorry, I do not know how you drew that conclusion from my
> description.
>
> All I meant to convey is "roots are not special at all, commits that
> do not have parents in the parts of the history shown are, and care
> must be taken to ensure that they do not appear to have parents".

Yeah, I guess I am confused. I thought "Fixing --graph to avoid implying 
ancestry" was reaching the same point as "care must be taken to ensure 
that [commits without parents shown] do not appear to have parents". (I 
wasn't just talking about root commits at that point)

> And the argument applies equally to either of two approaches.
> Whether the solution chosen is
>
>   (1) to use special set of markers "{#}" for commits that do not
>       have parents in the displayed part of the history instead of
>       the usual "<*>", or
>
>   (2) to stick to the normal set of markers "<*>" but shift the graph
>       to avoid false ancestry.
>
> we shouldn't be special casing "root commits" just because they are
> roots.  Exactly the same issue exists for non-root commits whose
> parents are not shown in the output, if commits from unrelated
> ancestry is drawn directly below them.

I understand. Coming back to the "root commit" situation below.

>> That being said, I spoke to Jason recently, and he expressed interest
>> in optionally marking root commits so they are easy to search for in a
>> graph with something like /# in `less`. I see value in this,
> I do not mind to denote the "this commit may appear directly on top
> of another commit, but there is no ancestry" situation with a
> special set of markers that is different from the usual "<*>" (for
> left, normal and right) set.  I agree pagers are good ways to /search
> things in the output.
>
>> So would you be open to my modifying of the patch in question (patch
>> 1+2 squashed, I guess) to instead use "--mark-roots=<mark>" to
>> optionally mark root commits with a string <mark>, and pursue fixing
>> the --graph rendering issue in another series?
> I do not mind if the graph rendering fix does not happen yet again;
> IIRC the past contributors couldn't implement it, either.
>
> I think this new feature should be made opt-in by introducing a new
> option (without giving it a configuration variable), with explicit
> "--no-<option>" supported to countermand a "--<option>=#" that may
> appear earlier on the command line (or prepare your scripts for
> later introduction of such a configuration variable).

Okay

> I do find it troubling if the <option> has "root" in its name, and I
> would find it even more troubling if the feature somehow treated
> root commits specially but not other commits that do not have their
> parents shown.  It was the primary point I wanted to stress in the
> previous two message [*1*].

I'll come back to this below.

> I am hoping that a single option can give three-tuple that replaces
> the usual "<*>", with perhaps the default of "{#}" or something.

I thought about that, but can we handle any of the three markers being 
multi-byte characters?

> I however offhand do not think of a way to make "left root" appear
> in the output, but because we'd need "right root" that looks
> different from ">" anyway, it may make sense to allow specifying
> "left root" just for symmetry.

I'm thinking on that one. I need to learn more about --left-right. I 
don't know how/when to use it yet.

> [Footnote]
>
> *1* But if we do not think of a good option name without the word
>      "root" in it, I might be talked into a name with "root", as long
>      as we clearly describe (1) that commits that has parents that
>      are not shown in the history are also shown with these letters,
>      and (2) that new contributors are welcome to try coming up with
>      a new name for the option to explain the behaviour better, but
>      are not welcome to argue that the option should special case
>      root commits only because the option is named with "root" in it.

So, on the root vs parents-not-shown commits issue:

You're right. Commits with their parents hidden by the range specifiers 
have the same graphing issue as root commits.

While root commits are not a special case in the sense that --graph 
makes ancestor implications for more than just root commits, root 
commits are a special case when we think about interpreting the presence 
of hidden lineage in --graph output.

Considering one of your examples:

           C
          /
         O---A---B
                  \
           X---Y---Z

When graphing C..Z, git produces output like:

*   0fbb0dc (HEAD -> z) Z
|\
| * 11be529 (master) B
| * 8dd1b85 A
* 851a915 Y
* 27d3ed0 (x) X

We cannot tell from the above graph alone that X is a root and A is not.

So I think it might be useful if I could do --mark-roots='#' 
--mark-hidden-lineage=$'\u22ef' (Unicode Midline Horizontal Ellipsis) to 
produce the following:

*   0fbb0dc (HEAD -> z) Z
|\
| * 11be529 (master) B
| ⋯ 8dd1b85 A
* 851a915 Y
# 27d3ed0 (x) X

Alternatively, it could be argued that --boundary can be used to 
indicate a hidden lineage, since root commits do not have boundary 
commits listed below them. But --boundary draws one more commit than 
necessary, and there still isn't an easy way to search for roots in the 
pager.

I understand that I am now leaving the original scope of the issue, but 
I think it is worth considering.

Of course, I would also like to try fixing the original graphing issue 
in general.

Thoughts?

-- 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Kyle Marek                        PD Inc. http://www.pdinc.us -
- Jr. Developer                     10 West 24th Street #100    -
- +1 (443) 269-1555 x361            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

