Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7298C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiBZQCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 11:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiBZQCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 11:02:24 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766351795FC
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 08:01:49 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a1so738512qta.13
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=Tt0Y33GbxEbrLxBecX8aUNCfDGXF1k6ESavZI9Sz9L4=;
        b=bbhzR7SPhOZ/WCanqn3cWH19NI5VtgECdLT97rdAXa8G7La+Y4uKq7Br+t9UkjA3zN
         VjgCK4BS6AS3I6AtuqBJi5GPSPhbSaco1qLUCnN/dtCJP5VINaTRpI2xns6Psxb+M5MR
         6pR1EriEaT1TNRiEgKJH68Fezzx99n313Tyk14Srt1FX+sJZdYn3YibzJtkG/sKJU4v3
         TFKShVhid59+3uKSEnzMgIRGBFp8Eu9fdqyi8YFQAogkT1fCmCXsZ0djxsgtFsapVBxr
         wQD142LG2cQXmvyPlOps4idhCrFPSuYnY1p1l8w92FRq9+R4HdQu3tSiSd7MjssyoiJ3
         RdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=Tt0Y33GbxEbrLxBecX8aUNCfDGXF1k6ESavZI9Sz9L4=;
        b=xBbrdCXaF2XddXEieNc6arYwshcfIi/6UwxmyJtvbRLVeCNpYSWRkXvqgAn2zXOYeH
         scADHatScrQuFGWRo2Mj4sz5l8FmitQN+gK23YsOHsAGWUdIHyaA0fjwND3zYy8WdQCN
         5rzI9AiQvMgp/3qXiK8IujAahJzVAb3ShBXC5yl/0F8V9mNyLU7K7xMbeu1anxN7ZFua
         sDN+tJIlyhiren0OX9v90iDo1SD8/251Op9Y4nsHL+E/2GR+8EvKSMxrDHBsQnRg/CV+
         +qyCLikFD25Dx5H39aFxmgPxerf8Ia3jLnordy8wxcr/tVPMbLv8SIytpNG2PP7kpdDg
         oGEw==
X-Gm-Message-State: AOAM531fRbK8OL2krRkG0HvGkSvYV/QU05UN6qsTihIKRIfNcRSUCfg7
        cOLpTFWNTZoJw4esyLzTWYY=
X-Google-Smtp-Source: ABdhPJywVxwjRcTOoY754v1siLG0B6ax2awcGOmqsSs31MtbUrZXoEqKCR2Eaxz4V7cJC4fhrMcKYA==
X-Received: by 2002:a05:622a:1902:b0:2dd:33ce:4813 with SMTP id w2-20020a05622a190200b002dd33ce4813mr10889827qtc.659.1645891308538;
        Sat, 26 Feb 2022 08:01:48 -0800 (PST)
Received: from [10.37.129.2] ([2600:1001:b11e:18ab:f5f7:1c48:323c:e2a9])
        by smtp.gmail.com with ESMTPSA id a143-20020a376695000000b00648cb6bb2ecsm2665419qkc.54.2022.02.26.08.01.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Feb 2022 08:01:48 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Date:   Sat, 26 Feb 2022 11:01:46 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
In-Reply-To: <xmqqv8x5v0qc.fsf@gitster.g>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
 <xmqqv8x5v0qc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for everyone's feedback. Really appreciate the collaboration!

On 23 Feb 2022, at 14:31, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
>
>>> For what it's worth, I am fine having a mode of repack which allows us
>>> to remove objects that we know are stored by a promisor remote. But this
>>> series doesn't do that, so users could easily run `git repack -d
>>> --filter=...` and find that they have irrecoverably corrupted their
>>> repository.
>>
>> In some cases we just know the objects we are removing are stored by a
>> promisor remote or are replicated on different physical machines or
>> both, so you should be fine with this.
>
> So, we need to decide if an object we have that is outside the
> narrowed filter definition was (and still is, but let's keep the
> assumption the whole lazy clone mechanism makes: promisor remotes
> will never shed objects that they once served) available at the
> promisor remote, but I suspect we have too little information to
> reliably do so.  It is OK to assume that objects in existing packs
> taken from the promisor remotes and everything reachable from them
> (but missing from our object store) will be available to us from
> there.  But if we see an object that is outside of _new_ filter spec
> (e.g. you fetched with "max 100MB", now you are refiltering with
> "max 50MB", narrowing the spec, and you need to decide for an object
> that weigh 70MB), can we tell if that can be retrieved from the
> promisor or is it unique to our repository until we push it out?  I
> am not sure.  For that matter, do we even have a way to compare if
> the new filter spec is a subset, a superset, or neither, of the
> original filter spec?

let me try to summarize (perhaps over simplify) the main concern folks have
with this feature, so please correct me if I'm wrong!

As a user, if I apply a filter that ends up deleting objects that it turns
out do not exist anywhere else, then I have irrecoverably corrupted my
repository.

Before git allows me to delete objects from my repository, it should be pretty
certain that I have path to recover those objects if I need to.

Is that correct? It seems to me that, put another way, we don't want to give
users too much rope to hang themselves.

I can see why we would want to do this. In this case, there have been a couple
of alternative ideas proposed throughout this thread that I think are viable and
I wanted to get folks thoughts.

1. split pack file - (Rob gave this idea and Taylor provided some more detail on
   how using pack-objects would make it fairly straightforward to implement)

when a user wants to apply a filter that removes objects from their repository,
split the packfile into one containing objects that are filtered out, and
another packfile with objects that remain.

pros: simple to implement
cons: does not address the question "how sure am I that the objects I want to
filter out of my repository exist on a promsior remote?"

2. check the promisor remotes to see if they contain the objects that are about
   to get deleted. Only delete objects that we find on promisor remotes.

pros: provides assurance that I have access to objects I am about to delete from
a promsior remote.
cons: more complex to implement. [*]

Out of these two, I like 2 more for the aforementioned pros.

* I am beginning to look into how fetches work and am still pretty new to the
codebase so I don't know if this is even feasible, but I was thinking perhaps
we could write a function that fetches with a --filter and create a promisor
packfile containing promisor objects (this operaiton would have to somehow
ignore the presence of the actual objects in the repository). Then, we would
have a record of objects we have access to. Then, repack --filter can remove
only the objects contained in this promisor packfile.

>
>> If you are not fine with this because sometimes a user might use it
>> without knowing, then why are you ok with commands deleting refs not
>> checking that there isn't a regular repack removing dangling objects?
>
> Sorry, I do not follow this argument.  Your user may do "branch -D"
> because the branch deleted is no longer needed, which may mean that
> objects only reachable from the deleted branch are no longer needed.
> I do not see what repack has anything to do with that.  As long as
> the filter spec does not change (in other words, before this series
> is applied), the repack that discards objects that are known to be
> reachable from objects in packs retrieved from promisor remote, the
> objects that are no longer reachable may be removed and that will
> not lose objects that we do not know to be retrievable from there
> (which is different from objects that we know are unretrievable).
> But with filter spec changing after the fact, I am not sure if that
> is safe.  IOW, "commands deleting refs" may have been OK without
> this series, but this series may be what makes it not OK, no?
>
> Puzzled.
