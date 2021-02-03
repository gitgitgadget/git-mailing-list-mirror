Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34316C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E2A64F67
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBCDHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhBCDHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:07:32 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322EDC061793
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:07:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id e70so21993574ote.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hpbuy6Aya44emHM+HYA4Ln+Rh9+IBffbc3/qdsDne2I=;
        b=SJC+F/1B6jW6o3F5s/6WEseW9aXdWVjm7ikgNa6OY8sx3a4jcSonS9GG9GrO3cdzuH
         sDkm3Il3eFstNK9rSsQ++u4697FGX0b89tY9iLc3lPlbHaFMT9uceymuCdCg2XvK20/x
         m9rX6QfpJGkXVUq+/eTm1HruDXlUOWgTednnnW5tFk2Ww61Om/NzcMnAbGliW4ui4NzX
         pzWPAsOec6AC+Cvw5fDnAQlOkrq6C6sV4b9Agk0ohG3230C1OW60CFrN9OcVuTqVrFqg
         G8uUAckxVYrazRrxRE1OmiqIsfeAg+ZGsxr+1clHrJeTp2A64X93cYF0y96X1PfduOiQ
         T7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hpbuy6Aya44emHM+HYA4Ln+Rh9+IBffbc3/qdsDne2I=;
        b=GWd9DtPabWLanODEnthpgfWsLn6K3jhFf+kCYK03C9/3Rb4Faswmw+/242z2Vg8n56
         TOfTK5uLm1A2eJqi6oaUwsSa5vBRSYgMBDuEe9NujnMxhaJEZ5nTDV8CvSTfCrEncZCt
         /tOuYA52Bu4TkCHgldk1DpdVrQz5XaqtU0yfrUrMv9hhyhXaoKzRUf1iFDio17zN3XAT
         kxu5xDrqxuKlsloxVZaVSN0LC1D6xuKrdPsfW85LqGSVeFNDiQo6aOIlAol33wwj8jQF
         1CKd00v1/obCelnvA9PeMaMScR+HO3lRr1s/vNNe1NpclzMOw0NnR2IeZvGktUXMVnym
         8UtQ==
X-Gm-Message-State: AOAM533Sv5Vp+VR/YUQ5XSVeiIu4PgMz2oxhe8Nxrmr7GmNWvGN301qO
        5azhGNaJZYVhtKFsgyVwxv6LCM0VJGeCb3q8
X-Google-Smtp-Source: ABdhPJyed12lp7A/+7BQDTBwwXKl7iUq+evkpUMXviLmI7U2SZDiqnGbg/g8UzBE90MYNnQ84rIEgw==
X-Received: by 2002:a05:6830:b:: with SMTP id c11mr644031otp.138.1612321654443;
        Tue, 02 Feb 2021 19:07:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:79cd:7444:bf97:c4d4? ([2600:1700:e72:80a0:79cd:7444:bf97:c4d4])
        by smtp.gmail.com with UTF8SMTPSA id z1sm186201ooo.45.2021.02.02.19.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 19:07:33 -0800 (PST)
Message-ID: <6dc1520f-8130-75e1-6617-67b54cb03933@gmail.com>
Date:   Tue, 2 Feb 2021 22:07:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Content-Language: en-US
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <YBoBBie2t1EhcLAN@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YBoBBie2t1EhcLAN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/2/2021 8:48 PM, Jonathan Nieder wrote:
> Hi,
> 
> Derrick Stolee wrote:
>> On 2/2/2021 8:08 PM, Jonathan Nieder wrote:
> 
>>> At Google, we're running into a commit-graph issue that appears to
>>> have also arrived as part of this last week's rollout.  This one is a
>>> bit worse --- it is reproducible for affected users and stops them
>>> from being able to do day-to-day development:
>>
>> You're shipping 'next' widely? I appreciate the extra eyes on
>> early bits, so we can find more issues and get them resolved.
> 
> Yes.  Changes in 'next' have already gotten all the vetting via code
> review that they're going to get; the difference between changes in
> 'next' and 'master' is that the latter have had some production
> exposure among users of 'next' with the ability to get help from a
> local expert, roll back quickly when there's a problem, and so on.  I
> recommend that anyone with an installation with that ability use
> 'next', to improve the quality of code that ultimately is released
> from 'master'.
> 
> It also helps us get the chance to use our experience to affect the
> direction of a topic before it's too late.

This is a good practice. It's also how I found the issues fixed
in this series, but that's because I install it locally for my own
extra additional testing before shipping it to users.

> [...]
>>> We have some examples of repositories that were corrupted this way,
>>> but we didn't catch them in the act of corruption --- it started
>>> happening to several users with this release so we immediately rolled
>>> back.
>>
>> It is definitely related to the split commit-graph during the
>> upgrade scenario. Your verify output shows that you are using
>> the --split option heavily (possibly with fetch.writeCommitGraph?
>> or are you using 'git maintenance run --task=commit-graph'?)
> 
> Yep, the splits come from fetch.writeCommitGraph.
> 
> [...]
>>> - what is the recommended way to recover from this state?  "git fsck"
>>>   shows the repositories to have no problems.  "git help commit-graph"
>>>   doesn't show a command for users to use; is
>>>   `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
>>>   command?
>>
>> That, followed by `git commit-graph write --reachable [--changed-paths]`
>> depending on what they want.
> 
> Can we package this as something more user-friendly?  E.g.
> 
> 	git commit-graph clear
> 	git commit-graph write --reachable
> 
> If that makes sense to you, I'm happy to send a patch (or to review
> one if someone else gets to it first).  I'm mostly asking to find out
> whether this matches your idea of what the UI should be like.

'clear' is probably fine. I was thinking it might be good to have
an option to the 'write' subcommand to clear the existing data, but
it's probably better as separate steps.

>>> - is there configuration or a patch we can roll out to help affected
>>>   users recover from this state?
>>
>> If you are willing, then take v2 of this series and follow through by
>> clearing the commit-graph files of affected users. Note that you can
>> be proactive using `git commit-graph verify` to see who needs rewrites.
> 
> Does this mean we should change the BUG error message to help affected
> users discover how they can recover for themselves (for example, using
> commands like the above)?

It _is_ a bug that led to this, but it's more about incorrect
commit-graph data which could be caused by anything. Better to
have a better message such as "your commit-graph file is
probably corrupt".

> Also, should "git fsck" call "git commit-graph verify" to make the
> latter more discoverable?

Yes. I thought it did, but I must be incorrect.

Thanks,
-Stolee
