Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFC2C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3EA610FB
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhINKTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhINKTI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:19:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F90C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:17:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d21so11605945wra.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCkCfmvovRXUfxQ79R/syLkfS8VYUJNcwWkQj0KnwpA=;
        b=WwoKEM645aZ38zS8kizctGRXV7iUnX+KfCOJO51Au1x+3dHidKzR7kBTJglW5SzMXX
         t8I0dCoXZ0oDnbcITwhOHiTWxsr9+4RXXKYGPlWA6tSnEXcQZX4NoKjZbKeIQFcLavO3
         BY1TDqWY3bvOEp1KdnUXlXQi8/aKt1FHFSvPWk6dyoBQpTCL1Ju57mIQxIS++DJI/xD9
         mRyRtJcrUeYmVuZp+lOpGEfP20uOQ84qp6OvQVw9KyD+xaKm4vjmG2MMNhQpZeHnaL1g
         uwqebku2OVIncnpAk93rF/ozYV7zzT9mjgi9Xe5+lP2map13tA0PFh5hv69TLOh05Tiq
         9nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cCkCfmvovRXUfxQ79R/syLkfS8VYUJNcwWkQj0KnwpA=;
        b=3DCtbU9fCjXetD0VxCFZFVgpFQshKDXbLKB1Dpiv1OZwS+thMqzEr8lqGnRi4JZKlz
         2gFLYyXWDJkHmAPnwdk9mkJOTxVKCXvqJu3SMw7HRHfai9BlgLF+r9JfN8W+oaLsmQcS
         Y6+CQSlFenY3W4Z/DPgavniWt0Vv3K2E9vw/2PdJeIdeVtD1KMmFUn2vGVAAlv88GBIY
         rnBo8K3C7N29SmB9WwNd2btv16eYJsecithLtGOipsSochufADD9/2MtUW4FXNVBA3qm
         wGkBUc6vEny7TwuqLR6t24s+NXtbpf90awwQcHlbIhZzH2Eq7QIMFdxeNnI19EmTnNfU
         nFAQ==
X-Gm-Message-State: AOAM530Ppr6Ks1rrPmBHY7AKwFq3Ufn7qC+/jSPWakmBgxb4hwSnT9To
        QLDYBRKHpDOtW3aeYRdNr7g=
X-Google-Smtp-Source: ABdhPJxELsFgqlrbNXE1yH8ho2TOwf5wAuWTJE/hrT0O0G0TIO5n6HSwMbmQRpwsms2E4n/Z+4NmVg==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr17865478wra.439.1631614669867;
        Tue, 14 Sep 2021 03:17:49 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id s10sm10088508wrg.42.2021.09.14.03.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:17:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
 <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
 <xmqq5yv4ccc0.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5ef402a4-3477-6227-e08c-041ed373313e@gmail.com>
Date:   Tue, 14 Sep 2021 11:17:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq5yv4ccc0.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 13/09/2021 23:58, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
>> should checkout the commit pointed to by <tag-object>. Instead it gives
> 
> I am not sure if "should checkout the commit pointed to by." is a
> good description.  It does not seem to be sufficiently justified.

My logic was that as we handle commits here it would make sense to 
handle tags as well - I discovered that this did not work when I 
happened to use an annotated tag as the <branch> argument to rebase the 
commits pointed to by the tag and was surprised it did not work when we 
happily accept tags for <upstream> and --onto.

> Did we auto-peel in scripted version of "git rebase" and is this a
> regression when the command was rewritten in C?

As far as I can tell we have never peeled tags here

> If that is not the case, this topic is perhaps slightly below
> borderline "meh" to me.  The optional "first switch to this <branch>
> before doing anything" command-line argument in
> 
>      git rebase [--onto <there>] <upstream> [<branch>]
> 
> was meant to give a branch, and because we treat detached HEAD as
> almost first-class citizen when dealing with branch-ish things, we
> allowed
> 
> 	git rebase master my-topic^0
> 
> to try rebasing my-topic on detached HEAD without losing the
> original.  In other words, you had to be explicit that you meant the
> commit object, not a ref that points at it, to trigger this "rebase
> detached" feature.  The same thing for tags.
> 
> 	git rebase master v12.3^0
> 
> would be a proper request to rebase the history leading to that
> commit.  Without the peeling, it appears the user is asking to
> update the ref that can be uniquely identified with "v12.3", but we
> do not want to rebase a tag.

I wrote this patch as I felt it was an artificial distinction to require 
that <branch> is a branch-ish thing rather than a commit-ish thing. 
Rebase already peels <upstream> and --onto so it feels inconsistent not 
to do it for <branch>. I guess the counter argument to that is users may 
be confused and start complaining that the tag itself is not rebased.

> It would have been a different story if we had a problem when a tag
> is given to "--onto <there>", but I do not think this topic is about
> that case.

No "--onto <tag>" works fine. We also accept a tag object for upstream 
without requiring the user to peel it for us.

> Having said that, even if we decide that we shouldn't accept the tag
> object and require peeled form to avoid mistakes (instead of
> silently peeling the tag ourselves), I do agree that
> 
>>      error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>>
> 
> is a bad error message for this.  It should be something like
> 
> 	error: cannot rebase a tag
> 
> perhaps.

We could do that if we're worried that users would be confused by the 
tag not being rebased if we started automatically peeling <branch>. (I'm 
kind of leaning in that direction at the moment having read your email)

Best Wishes

Phillip

> But if we auto-peeled in an old version, I do not mind this series
> (but let's drop pointless "clean-up" that is not, like what was
> pointed out by Réne).  In such a case, the first paragraph should
> say, instead of "should checkout", that "we used to do X, but commit
> Y broke us and now we die with an error message".
> 
> Thanks.
> 
