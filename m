Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D59C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB9460230
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhI0NjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:39:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:20046 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234114AbhI0NjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:39:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A5E9D3F404F;
        Mon, 27 Sep 2021 09:37:23 -0400 (EDT)
Received: from test.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 64E743F4047;
        Mon, 27 Sep 2021 09:37:23 -0400 (EDT)
Subject: Re: [PATCH v2 0/7] Builtin FSMonitor Part 1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <87v92r49mt.fsf@evledraar.gmail.com>
 <0ec69aff-40a9-aac1-5fca-08033c967d88@jeffhostetler.com>
 <87ee9f3t0m.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8de10d97-f5a0-b08a-ca36-a86b4280db94@jeffhostetler.com>
Date:   Mon, 27 Sep 2021 09:37:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87ee9f3t0m.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/23/21 4:47 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 23 2021, Jeff Hostetler wrote:
> 
>> On 9/23/21 10:33 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Mon, Sep 20 2021, Jeff Hostetler via GitGitGadget wrote:
>>>
>>>> Here is V2 of Part 1 of my Builtin FSMonitor series.
>>>>
>>>> Changes since V1 include:
>>>>
>>>>    * Drop the Trace2 memory leak.
>>>>    * Added a new "child_ready" event to Trace2 as an alternative to the
>>>>      "child_exit" event for background processes.
>>>>    * Convert the Trace2-related NEEDSWORK items in "start_bg_command()" to use
>>>>      the new "child_ready" event.
>>>>    * Various minor code and documentation cleanups.
>>> I see 7/7 still has a pattern you included only to make a compiler
>>> error
>>> better. I noted in
>>> https://lore.kernel.org/git/87ilyycko3.fsf@evledraar.gmail.com/ that it
>>> make the error worse, on at least clang. You didn't note which compiler
>>> you were massaging, presumably MSVC.
>>>
>>
>> I've been holding my tongue for days on this issue and hoping a third
>> party would step in an render an opinion one way or another.
>>
>> Too me, a forward declaration seemed like no big deal and it does
>> have value as I tried to explain.  And frankly, it felt a little bit
>> like bike-shedding and was trying to avoid that again.
> 
> I agree with you that it's no big deal in the end,
> 
> I thought I made it clear in <87v92r49mt.fsf@evledraar.gmail.com> but
> the main thing I'm commenting on is not that I or anyone else suggested
> Y over X, and you said nah and went for X in the end.
> 
> That's fine, I mean, depending on the comment/issue etc. it's something
> other reviewers & Junio can draw their own conclusions about.
> 
> What I am saying that it's much better for review of iterations of
> patches in general, and especially of a complex multi-part series if
> reviewers don't have to read the cover letter of vX and wonder what's
> omitted/unaddressed in the V(X-1) comments, and then go and re-read the
> discussion themselves. It's not the "nah", but that the "nah" is
> implicit and only apparent when sending an E-Mail like this.
> 
> Of course that's never perfect, you can't summarize every point
> etc. Personally I try to do this, but I've sometimes noticed after the
> fact that I've gotten it wrong etc.
> 
> In the end I and I think anyone else offering their time to review
> things is trying to move the relevant topic forward in one way or
> another. I'd much rather spend my time on a vX discussing new things &
> getting the thing closer to merge-able state, than re-reading all of
> v(X-1) & effectively coming up with my own cover letter summary in my
> head or in my own notes as I read along.
> 
> Anyway, sorry about the bikeshedding getting out of hand, and what seems
> to have been at least partially a misunderstanding in the last couple of
> E-Mails between us, but the above is all I was going for.

Thanks.  Yeah, email is a terrible communication medium and prone
to misunderstandings.  It's easy to forget that at times, since we
spend so much time in it.

Drafting a v(X+1) cover letter is a bit of an art.  It is easy to
err on the less-is-better side when trying to decide how much to
include to explain the new version vs not wanting to including
every little typo or nit.

I tend to drop / cross-off issues that I decide to ignore or not act
upon rather than report them.  However, you're right, I should have
included a brief statement about not changing the stuff mentioned in
7/7, since there was a larger conversation around it.  Sorry.


Jeff
