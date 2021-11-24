Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F0C433FE
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 14:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354738AbhKXOdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354160AbhKXOc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 09:32:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96823C140FE6
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 05:05:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so10353789edd.0
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WTol4Yyy0PUPBeis2vl0+ZYUgRkzgp/aHo2OTPOANGg=;
        b=d3cJpxQXweTGnyayv1T7xoEYW2eUBlbk/gVWs7xJUO8pZmlFWA3Jo/NGBvNZQfPxMg
         MW8TfhEq+8W4a6HagrIVh/iRbN1sWgev2G5HB1FmlzRUj2w5er9FDWimHr9vqq1Ykvbc
         TYJWKGeXjGECSOj4JkJfMhhbi8VA9+xqkq8lWHKLJQ0rwnEBJFtbwFkHecX5LFQuIkTY
         C/Y7FudcXutjTI46RDCnqLTMVTbnv/lMQpaV2I53A0nYV8BL0d64vymKjQ9o9nck4rXU
         XREovCA4O7wd4BA8g1aO+zww6h+1ruNBXcELoHJUwe+gUbBkCh6d9y6ejnbXNQuU7+12
         /Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WTol4Yyy0PUPBeis2vl0+ZYUgRkzgp/aHo2OTPOANGg=;
        b=bXYOQow0KvmzxqIij5y3SD5KMpa5dCzn4ic2EcNFDkbJyOIJtq2xkjYtzNJXLuE7Z+
         LU3lUGXxBpc0EyUr3MUewz3mfQADbEoe/4oBlAeeOpWbRSbjfDDnrHQWSnDkOT9UH96W
         RmGubvvCq7JJhT3KLj0ZV27bEWLY53kpMks+m6YkRDEQ0+S0RfTb9hdL4m+Kt+C2lsgV
         8iNqR4Fgk3iUWUuV7rnzzhBv1uTVISaVv3wO/D4OD+O5unFhEobvh7HTpW0CX4xVmmpQ
         1vu7IZe8we0RH2wAe2mlrqj/AmRp0c1/pKSh3AafgH3hzfdpn/8RZK/USQX19cceQcqE
         0tOw==
X-Gm-Message-State: AOAM531zQ6jVXIllIny3e70aa9gn5n5cdUWGWFzB+jY2aIFt4ugSaF3G
        /dCmfctKh6UvXAY4q4hBwMVwyg==
X-Google-Smtp-Source: ABdhPJziu4Jv2zWRPod6i7917O+CjptyN0zlm91+Gg11u07HvZCopWmbGMvOmQT+J+2LSwjOMbJElw==
X-Received: by 2002:a17:906:7ccf:: with SMTP id h15mr19692975ejp.386.1637759105768;
        Wed, 24 Nov 2021 05:05:05 -0800 (PST)
Received: from [10.45.33.40] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id w7sm7434479ede.66.2021.11.24.05.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 05:05:05 -0800 (PST)
Message-ID: <6c7b5e1d-77b3-8af2-78e5-3519ec6ee13d@unity3d.com>
Date:   Wed, 24 Nov 2021 14:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] fast-export: fix surprising behavior with --first-parent
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <xmqqh7c25qsj.fsf@gitster.g>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <xmqqh7c25qsj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/11/2021 01.41, Junio C Hamano wrote:
> "William Sprent via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: William Sprent <williams@unity3d.com>
>>
>> When invoking git-fast-export with the --first-parent flag on a branch
>> with merges, fast-export would early-out on processing the first merge
>> on the branch. If combined with --reverse, fast-export would instead
>> output all single parent commits on the branch.
> 
> I do not doubt we would want to make the command behave sensibly
> with all options it accepts, but let me first ask a more basic and
> possibly stupid question.
> 
> What is "git fast-export --first-parent <options>" supposed to do
> differently from "git fast-export <options>" (with the same set of
> options other than "--first-parent")?  Should it omit merge commits
> altogether, pretending that the first single-parent ancestor it
> finds on the first parent chain is a direct parent of a
> single-parent descendant, e.g. if the real history were with two
> single-parente commits A and B, with two merges M and N, on the
> mainline, making the resulting commits into a single strand of two
> pearls, with A and B before and after the rewrite to have the same
> tree objects?
> 
>      ---A---M---N---B             ---A---B
>            /   /           ==>
>           X   Y
> 
> Or should it pretend merge commits have only their first parent as
> their parents, i.e.
> 
>      ---A---M---N---B             ---A---M---N---B
>            /   /           ==>
>           X   Y
> 
> "git fast-export --help" does not even mention "--first-parent" and
> pretend that any and all [<git-rev-list-args>...] are valid requests
> to make to the command, but I am wondering if that is what we intend
> to support in the first place.  In builtin/fast-export.c, I do not
> see any attempt to do anything differently when "--first-parent" is
> requested.  Perhaps we shouldn't be even taking "--first-parent" as
> an option to begin with.
> The "--reverse" feels even more iffy.  Are we reversing the history
> with such an export, i.e. pretending that parents are children and
> merges are forks?
> 
>      ---A---M---N---B             B---N---M---A---
>            /   /           ==>         \   \
>           X   Y                         X   Y
> 
> Or are we supposed to produce the same history in the end, just
> spewing older commits first in the output stream?  I am not sure
> what purpose such a request serves---the "fast-import" downstream
> would need the same set of objects before it can create each commit
> anyway, so I am not sure what the point of giving "--reverse" is.
> 
> If there is no sensible interpretation for some of the options that
> are valid in rev-list in the context of "fast-export" command, should
> we just error out when we parse the command line, instead of producing
> nonsense output stream, I wonder.
> 


I agree with the concerns. I just skimmed the list of flags that git 
rev-list take, and I'm pretty sure that there are both flags that don't 
make sense at all in the context of fast-export, and that there are 
flags where it is unclear what the behavior of fast-export would be when 
passed.

However, I do think that having git fast-export support history limiting 
is useful. And I also think that the workflow of crafting a git rev-list 
command (perhaps using --graph) which outputs the part of history you 
want, and then applying it to git fast-export is fairly straight 
forward. But I also agree that "git fast-export --reverse" is nonsense.

I've thought about this a bit, and I wonder if having "git fast-export" 
accept revisions on stdin in a similar format as "git rev-list 
--parents" outputs would be an API that would be flexible enough, but 
without the oddities of allowing all rev-list flags. Or maybe there 
should be a list of acceptable rev-list flags which fast-export should 
accept. I don't really know.

For the specific question of what "--first-parent" should output, my 
thinking is that I would expect "git fast-export --first-parent" to 
output the same set of commits as "git rev-list --first-parent", which 
would be latter of your examples, i.e.

      ---A---M---N---B

Similarly, I guess if the user wanted

      ---A---B

then they could pass "--no-merges" as well, which would leave out the 
merge commits.

With regards to this patch in particular, we now overrides any 
"--reverse" flag that the user passes, so I can make "git fast-export 
--reverse" cause an error while I'm at it, if that is desired behavior.
