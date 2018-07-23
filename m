Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EA81F597
	for <e@80x24.org>; Mon, 23 Jul 2018 12:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeGWNuP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 09:50:15 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33002 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbeGWNuP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 09:50:15 -0400
Received: by mail-qt0-f193.google.com with SMTP id c15-v6so443923qtp.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=akDkZZa7UDahikjfdxn+ogru3mznmMl/DfqEl6qV5r4=;
        b=JwT7gU7VzODW7m9VjGib0QO0/OCY+ytnNMXSmwzcP9gAkNEO9h0CdnLSiC/JozIRVS
         kpko4T/quIx57T2Jz9plx/j5qPmv3N4iANLA8ZR8r2cgdqcyyntnP83z44dj8jhRlYwz
         F6jHWRuthYWDpPLdfGW3976cpJe3IOHGw6yimESQDZmXOvSlSfT96yYp8wQJlLI/3qPF
         4IQrGpssgi218xO58tYigy2LdGs8tUSQ46k5/+wi4wUZnbl3SifWC8PRr1rDpSjl8WzH
         TFM1GOCx2eWuan61u5gwWKxaks9UdVNYmZQF9Xco1T5rVchBL1ynMBC+hBzWcNpuK83D
         R1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=akDkZZa7UDahikjfdxn+ogru3mznmMl/DfqEl6qV5r4=;
        b=hg131YsDJ0GXkJdoeV9MBqkME5AWh0pADI1hjnu4G4N7QMuM0aIH6lzos5NVEaFVEr
         O5513pNPlG1bJZqqo3zh/gQb2EvqcuPcF2MXY+gZXmi9WAWWu7OWAXi6h5Z/ABsMbRpG
         HffWEu6Qam4B4CMCpIIRQ57CI6TQPG7ahx7NOSKgQN0DE636PWkNMYfdjmVVCj3ADHCb
         GCVLwHdj5Jl9pfw4Ls4ayxotah4hiBu+L0XmD8wJsBE7lVFyfZHvEBwDwCNIU5qJ5G2s
         z4Rkj8TAqh/seFM/aUDN7JbexskIq9fCoVnPCmFBidP51pCEkezxSCBOpFuJiduQPhGW
         ElEA==
X-Gm-Message-State: AOUpUlGtWCOVZNtdLSJLaSSE8kMzo1ki0436bFzaGPSvaRDY0PIuiSdH
        yGAHJ1lW5JWU09Juwve1anY=
X-Google-Smtp-Source: AAOMgpdjmwc/OTGQBC2vEmrESsAATGFsKpLWX4BAW/8wJWJ6+Ebndn/iZ5ROFJsRoGILNKX/m2OLkw==
X-Received: by 2002:aed:3763:: with SMTP id i90-v6mr12005582qtb.308.1532350149744;
        Mon, 23 Jul 2018 05:49:09 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n36-v6sm7951758qtb.39.2018.07.23.05.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 05:49:08 -0700 (PDT)
Subject: Re: [BUG] merge-recursive overly aggressive when skipping updating
 the working tree
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com>
 <xmqqsh4da9wd.fsf@gitster-ct.c.googlers.com>
 <CABPp-BE_OHxMqmhJ8BisG6HFpGQjsPJ1AE4G9m5bpJWznkq-1Q@mail.gmail.com>
 <xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com>
 <CABPp-BGVtP4-_LYh7SjSSoTwcm+ZiKbCRSuK0MCo_wvUWBj3vg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <906db47d-e7ad-56ab-286d-094b0eaf9f01@gmail.com>
Date:   Mon, 23 Jul 2018 08:49:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGVtP4-_LYh7SjSSoTwcm+ZiKbCRSuK0MCo_wvUWBj3vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/20/2018 7:02 PM, Elijah Newren wrote:
> On Fri, Jul 20, 2018 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> Ah, okay, that's helpful.  So, if there are conflicts, it should be
>>> free to clear the skip_worktree flag.  Since merge-recursive calls
>>> add_cacheinfo() for all entries it needs to update, which deletes the
>>> old cache entry and just makes new ones, we get that for free.
>>
>> Correct.
>>
>>> And conversely, if a file-level merge succeeds without conflicts then
>>> it clearly doesn't "need to materialize a working tree file", so it
>>> should NOT clear the skip_worktree flag for that path.
>>
>> That is not at all implied by what I wrote, though.
>>
>> If it can be done without too much effort, then it certainly is
>> nicer to keep the sparseness when we do not have to materialize the
>> working tree file.  But at least in my mind, if it needs too many
>> special cases, hacks, and conditionals, then it is not worth the
>> complexity---if it is easier to write a correct code by allowing Git
>> to populate working tree files, it is perfectly fine to do so.
>>
>> In a sense, the sparse checkout "feature" itself is a hack by
>> itself, and that is why I think this part should be "best effort" as
>> well.
> 
> That's good to know, but I don't think we can back out easily:
>    - Clearing the skip_worktree bit: no big deal, as you mention above
>    - Avoiding working tree updates when merge doesn't change them: very
> desirable[1]
>    - Doing both: whoops
> 
> [1] https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/
> 
> 
> I don't want to regress the bug Linus reported, so to fix Ben's issue,
> when we detect that a path's contents/mode won't be modified by the
> merge, we can either:
>    - Update the working tree file if the original cache entry had the
> skip_worktree flag set
>    - Mark the new cache entry as skip_worktree if the original cache
> entry had the skip_worktree flag set
> 
> Both should be about the same amount of work; the first seems weird
> and confusing for future readers of the code.  The second makes sense,
> but probably should be accompanied with a note in the code about how
> there are other codepaths that could consider skip_worktree too.
> 
> I'll see if I can put something together, but I have family flying in
> tomorrow, and then am out on vacation Mon-Sat next week, so...
> 

I agree with the priorities around proposed behavior with this scenario.

It would be preferred that the skip worktree bit be preserved but the 
behavior in 2.17 of clearing it and writing the file to the working 
directory is much better than the current 2.18 behavior that makes the 
user think they had somehow deleted the file just by doing the merge.

At this point, it isn't clear to the user what they should do to recover 
without causing harm to the repo.

$ git status
HEAD detached at df2a63d
You are currently cherry-picking commit 7e6d412.
   (all conflicts fixed: run "git cherry-pick --continue")
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)

Changes not staged for commit:
   (use "git add/rm <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)

         deleted:    foo

