Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5535AC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A98864E49
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 11:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhBHLq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 06:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhBHLol (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 06:44:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689EC061756
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 03:44:01 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id v19so1990420qvl.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yz0atQO/oJ3tuTOkflU290Atsn/LU/+XhXMJO6j5cpo=;
        b=AmYyQkeu8S7tI0txLhY0GQDFe4WSoxZB/CIg3/S65Pdp5MEoEo4sY6qdf4pAT2Yep9
         pqD2R4JSpjTaVCokw0WmOhO0Ig2FP8Idgw2xgMNzs7DQnAgbkYfIL0pjgIF9JE0vr/wP
         pO67ny9Eoy28ZCVrw1//c+NmQYvbd137LeMTdf40gPVsI9IKHjUV/XfD9NqBuJ5EvyUw
         xD42zGIIJJawuedS4j2q4w9ntrtToLUmx/oYzuPA8N/xCVclxQbzfOzfdM8duSgOq6dH
         J7qNoN+eOfJ4N4q2c3y9P1c8ZKOEZUg/erybkmkwWWaV7DZF3SMeliwXkn3ZcvpPsbpo
         TSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yz0atQO/oJ3tuTOkflU290Atsn/LU/+XhXMJO6j5cpo=;
        b=XPmpj+ctMxzvEH+kMN6w6PsYfcvRim/Xi9APc2JKTR83WLu2wTgNLkPuMX/PkWvGgh
         2dV6sDIqvdhvR57us3XRc+DeyLI8CB0CgrJFJjv609hL8dUO3IuL0kyF9kJiQD79qQUN
         JLQDNES43JjTx8w81HadoKWWvrX8OL4NeJ1Pb+eTYK3w94p/UIc2aJ3hSoo6dzsM+Jjq
         pQgkQpFW/IAUeI1XfrtxKeBP3I5nJOwouTBy6ugV/VmgvsLlSVBDTemb+FNsYA6ykBqn
         idHRwpAO1EK0NmCaXxrTPTfuj/P+P5YPJQq/czKDUA4qkbk8f+2q8Gx9sAw25eB/TPKp
         oGXg==
X-Gm-Message-State: AOAM5326bqZZOLB+uRap9wP+j8MX2q35ll1VnUv90ivYlYjOvHkq2nom
        B+L5lq4Nk1R3tU+8054+uIo=
X-Google-Smtp-Source: ABdhPJyets7+lkpwsBs8IOC9a1ZGbZ6crD6gPyRDixi9GCS3vGIbhc/nzBPq4N60Bwrq8kVPPUnhhg==
X-Received: by 2002:a0c:85c2:: with SMTP id o60mr248318qva.11.1612784640354;
        Mon, 08 Feb 2021 03:44:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id v145sm16803696qka.27.2021.02.08.03.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:43:59 -0800 (PST)
Message-ID: <57d30e7d-7727-8d98-e3ef-bcfeebf9edd3@gmail.com>
Date:   Mon, 8 Feb 2021 06:43:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
 <xmqqsg677j2u.fsf@gitster.c.googlers.com>
 <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2021 3:38 AM, Elijah Newren wrote:
> On Sun, Feb 7, 2021 at 11:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> Before I get too deep into reviewing these patches, I do want
>>> to make it clear that the speed-up is coming at the cost of
>>> a behavior change. We are restricting the "best match" search
>>> to be first among files with common base name (although maybe
>>> I would use 'suffix'?). If we search for a rename among all
>>> additions and deletions ending the ".txt" we might find a
>>> similarity match that is 60% and declare that a rename, even
>>> if there is a ".txt" -> ".md" pair that has a 70% match.
>>
>> Yes, my initial reaction to the idea was that "yuck, our rename
>> detection lost its purity".  diffcore-rename strived to base its
>> decision purely on content similarity, primarily because it is one
>> of the oldest part of Git where the guiding principle has always
>> been that the content is the king.  I think my aversion to the "all
>> of my neighbors are relocating, so should I move to the same place"
>> (aka "directory rename") comes from a similar place, but in a sense
>> this was worse.
>>
>> At least, until I got over the initial bump.  I do not think the
>> suffix match is necessarily a bad idea, but it adds more "magically
>> doing a wrong thing" failure modes (e.g. the ".txt" to ".md" example
>> would probably have more variants that impact the real life
>> projects; ".C" vs ".cc" vs ".cxx" vs ".cpp" immediately comes to
>> mind), and a tool that silently does a wrong thing because it uses
>> more magic would be a tool that is hard to explain why it did the
>> wrong thing when it does.
> 
> Stolee explained a new algorithm different than what I have proposed,

Yes, sorry for adding noise. The point stands that we are changing
the behavior in some cases, so that must be agreed upon. What you
are _actually_ proposing is a much smaller change than I thought,
but it is still worth pointing out the behavior change.

> I think based on the apparent different meanings of "basename" that
> exist.  I tried to clarify that in response to his email, but I wanted
> to clarify one additional thing here too:
>> diffcore-rename has not in the past based its decision solely on
> content similarity.  It only does that when break detection is on.
> Otherwise, 0% content similarity is trumped by sufficient filename
> similarity (namely, with a filename similarity of 100%).  If the
> filename similarity wasn't sufficiently high (anything less than an
> exact match), then it completely ignored filename similarity and
> looked only at content similarity.  It thus jumped from one extreme to
> another.

This idea of optimizing first for 100% filename similarity is a
good perspective on Git's rename detection algorithm. The canonical
example of this 100% filename similarity is a rename cycle:

	A -> B
	B -> C
	C -> A

Even if the OIDs are distinct and exactly match across these renames,
we see that there are no adds or deletes, so we do not even trigger
rename detection and report A, B, and C as edited instead.

A "rename path" (not cycle) such as:

	A -> B
	B -> C

does trigger rename detection, but B will never be considered. Instead,
"A -> C" will be checked for similarity to see if it is within the
threshold.

Of course, I am _not_ advocating that we change this behavior. These
situations are incredibly rare and we should not sacrifice performance
in the typical case to handle them.

> My optimization is adding an in-between state.  When the basename (the
> part of the path excluding the leading directory) matches the basename
> of another file (and those basenames are unique on each side), then
> compare content similarity and mark the files as a rename if the two
> are sufficiently similar.  It is thus a position that considers both
> filename similarity (basename match) and content similarity together.
> 
>>> This could be documented in a test case, to demonstrate that
>>> we are making this choice explicitly.
>>
>> Yes.  I wonder if we can solve it by requiring a lot better than
>> minimum match when trying the "suffix match" first, or something?
> 
> This may still be a useful idea, and was something I had considered,
> but more in the context of more generic filename similarity
> comparisons.  We could still discuss it even when basenames match, but
> basenames matching seems strong enough to me that I wasn't sure extra
> configuration knobs were warranted.

I think this is a complication that we might not want to add to the
heuristic, at least not at first. We might want to have a follow-up
that adjusts that value to be higher. A natural way would be through
a config option, so users can select something incredibly high like
99%. Another option would be to take a minimum that is halfway between
the existing similarity minimum and 100%.

>> Provided if we agree that it is a good idea to insert this between
>> "exact contents match" and "full matrix", I have one question to
>> Elijah on what the code does.
>>
>> To me, it seems that the "full matrix" part still uses the remaining
>> src and dst candidates fully.  But if "A.txt" and "B.txt" are still
>> surviving in the src/dst at that stage, shouldn't we be saying that
>> "no way these can be similar enough---we've checked in the middle
>> stage where only the ones with the same suffix are considered and
>> this pair didn't turn into a rename"?
> 
> This is a very good point.  A.txt and B.txt will not have been
> compared previously since their basenames do not match, but the basic
> idea is still possible.  For example, A.txt could have been compared
> to source/some-module/A.txt.  And I don't do anything in the final
> "full matrix" stage to avoid re-comparing those two files again.
> However, it is worth noting that A.txt will have been compared to at
> most one other file, not N files.  And thus while we are wasting some
> re-comparisons, it is at most O(N) duplicated comparisons, not O(N^2).
> I thought about that, but decided to not bother, based on the
> following thinking:
> 
> 1) The most expensive comparison is the first one, because when we do
> that one, we first have to populate the list of integers that lines in
> the file hash to.  Subsequent comparisons are relatively cheap since
> this list of integers has already been computed.
> 
> 2) This would only save us from at most N comparisons in the N x M
> matrix (since no file in this optimization is compared to more than
> one other)
> 
> 3) Checking if two files have previously been compared requires more
> code, in what is already a tight nested loop.  My experience
> attempting to modify that tight loop for extra conditions (e.g. don't
> compare files that are too large), is that it's easy to accidentally
> make the code slower.  In fact, this is in part what led to the
> addition of the remove_unneed_paths_from_src() function.

Even storing a single bit to say "these were already compared" takes
quadratic space. The hope is to not have quadratic behavior if it
can be avoided.

> 4) There were plenty of other interesting ideas and maybe I was a tad lazy.  :-)
> 
> I think removing these already-compared cases could be done, but I
> just avoided it.  If we were to do the "attempt to match files with
> the same extension" optimization that Stolee outlines/invents above,
> then we'd definitely need to consider it.  Otherwise, it's just a
> minor additional optimization that someone could add to my patches.

The more I think about it, the less my idea makes sense. I'm sorry
for adding noise to the thread.

Thanks,
-Stolee
