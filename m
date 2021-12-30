Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B08C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbhL3QmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 11:42:16 -0500
Received: from siwi.pair.com ([209.68.5.199]:31267 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240031AbhL3QmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 11:42:16 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 474D13F40E4;
        Thu, 30 Dec 2021 11:42:15 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C843F3F40B7;
        Thu, 30 Dec 2021 11:42:14 -0500 (EST)
Subject: Re: [PATCH v2 0/9] Trace2 stopwatch timers and global counters
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
 <211229.86ee5wgnug.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a316a9e0-14dc-6277-b7d7-f6f115cc81da@jeffhostetler.com>
Date:   Thu, 30 Dec 2021 11:42:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211229.86ee5wgnug.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/28/21 8:54 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:
> 
> I left some other comments on the series inline, just on the notes in
> the CL:
> 
>>   * Ævar proposed a large refactor of the "_perf" target to have a "fmt()"
>>     varargs function to reduce the amount of copy-n-pasted code in many of
>>     the "fn" event handlers. This looks like a good change based on the
>>     mockup but is a large refactor.
> 
> FWIW what I meant with [1] was not that this series needed to take the
> detour of refactoring trace2/tr2_tgt_perf.c to use such a helper, but
> that for the function additions in this series it might make sense to
> introduce one and use it for the new functions.
> 
> For this series I think it's probably not worth it, so I'm fine with
> leaving this for some other time. Just pointing out that rather than
> your reading of:
> 
>   1. We have some refactorable verbosity
>   2. Refactor all callers
>   3. Change existing code to use that refactoring
>   4. Add new code to use the refactoring
> 
> It's also perfectly fine to do just:
> 
>   1. We have some refactorable verbosity
>   2. Introduce a less verbose
>   3. Add new code to use the helper
> 
> And leave the "refactor all callers" for some other time.
> 
> Anyway, I think for the two callers just leaving it entirely for this
> series is the right thing to do. It was more of a "hrm, that's some odd
> and avoidable verbosity..." comment on me read-through of v1.
> 
> 1. https://lore.kernel.org/git/211220.86czlrurm6.gmgdl@evledraar.gmail.com/

Sorry, but I'm going to call BS on this.  You sent a ~200 line diff
showing how we could refactor and reduce some of the duplicated code.
You have a history of introducing unnecessary refactorings in the middle
of other topics, and this looks like another example of that.  Another
example of distracting everyone from reviewing the actual new code.

And when I say that it should be an independent topic in its own
series, you fall back to the your "oh, it was just a drive-by comment."
and/or "i didn't mean for you to actually do it." and/or "you just
read my email incorrectly."

Drive-by comments don't usually have ~200 line diffs attached....

A drive-by comment would just say that "there is an opportunity to
create a varargs version of the existing io function and reduce
some duplication in the bodies of the existing callers" and be done.
I don't need a 200 line diff to see how you spell that.

Again, sorry to rant, but I'm tired looking like the stupid half
in these conversations.

> 
>>   * Ævar proposed a new rationale for when/why we change the "_event" version
>>     number. That text can be added to the design document independently.
> 
> Hrm, no. In [1] I linked to some earlier musings of mine about what we
> should do about the TR2_EVENT_VERSION (mainly as an FYI since you added
> it, but hadn't commented on that post).
> 
> But my main comment there was that the series wasn't progressing as
> atomic changes. I.e. we promise to change the TR2_EVENT_VERSION version
> every time we change the event format, but v1 first changed the format
> and bumped the version, then made some more changes.

Did you really expect me to change it twice within a single 9 commit
patch series?

This series creates both "timers" and "counters" and will both appear
together if/when they are merged.  From an external point of view,
users would see version 4 added two new event types.  So I either
increment it for "timers" or I increment it for "counters" or I squash
the two commits together and increment it then.

I didn't want to squash them, so I chose the former.

> 
> I think that's probably fine per-se within a git release cycle, but it
> might be a symtom of commits that could be split up to be more atomic (I
> don't know, didn't look in detail).
> 
> However, in this v2 of the series the TR2_EVENT_VERSION bump is entirely
> gone.

You complained when/how I bumped it in V1.  So I removed it.

And I suggested that you commit your "earlier musings".  With
that in place, there would be no need for me to change the
version number (which is what you wanted all along, right?)


> 
> Maybe that means that you so vehemently agree with my proposal in [1] it
> that you'd like to start taking that view for trace2 changes right away
> :-)

s/so vehemently agree with/are tired of debating/

> 
> For me it's fine either way, I think TR2_EVENT_VERSION probably isn't
> that important.
> 
> But if that's the case it should probably be called out more explictly
> in the CL/commit. I.e. even if our "policy" (such as it is) about
> TR2_EVENT_VERSION currently says X we're going to start doing Y here
> intentionally.
> 
> And in that case I should probably turn that suggestion in [1] into a an
> actual PATCH sooner than later...
> 
> 1. https://lore.kernel.org/git/211220.86czlrurm6.gmgdl@evledraar.gmail.com/
> 

Right, I'll add a note to V3 stating that I did not update
the version number.

Jeff
