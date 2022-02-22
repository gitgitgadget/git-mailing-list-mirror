Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBBBC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiBVKHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiBVKHA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:07:00 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086E32B
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:06:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk11so41322742ejb.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=d6sn/Xs9X/kUagkVDLkZ9v+ZkPS3TyYT2J88DCEiT8w=;
        b=Kc/WM+D05wuY/YuumYHqxJuD4d1Y9v6ZCYQdZGauvW8MKvCmHeEdyJMCwByB5MCGb0
         zMxN4Ra8P5tfXleSW34k4Cjy6YgPMxDYVATsa+9N+bkjhkjG7sHXkKJ8Z26qzwpxtjd3
         CDeP5/AR3xdcEgb3Og0hpEXymDjhRw0pQMiR4BNoHAw6C4hMFuWq4QPSlhFliKDr2Oos
         hZYKwQ09asvc1dxVLgfZXTs61qVoaiN3ZLbHy5sa1MlQWc+FVgZ9R6iFRXKvQVL9NwDe
         RcHha0/bjuODRGyD/kl+repBFlE0AoTwlpOctJ6vVjxuowhdAiWelUVbQMYorTCyMoYl
         Bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=d6sn/Xs9X/kUagkVDLkZ9v+ZkPS3TyYT2J88DCEiT8w=;
        b=IRs5YcX878EYAExC8x//UvDjfwhGjG7ssU7SZoKP5Fy1kMLZf7OB2/k6JAa7c5Vptb
         V3d75sBzs3ApADdzg1XLatZnk8SdOg+3FeeC6oFMYBM9imdzhL3psz313Tbax0llqomi
         gkWXd//fvqdh7DBgKLUkRf0qvcyYFLAXuVN5Go7ujgEUqrAvzl+st3HBkHUp4iMhZvlM
         lt7tmKSOC0YFReFu1kfSF+u74lWQUsZ7nMREpLwaOgXQmH3iVS8TXDvy+hbxhdlbjQya
         jOqx1VEroOhCmMVW5kjwsRix1xghCwppeCjQea/GnSQQirf+1p1cSV2kLWTTUcpv9t2C
         Hz+w==
X-Gm-Message-State: AOAM531CmVBp01NM64+HgCI2nSHXfq1qCSy4WJ7+XzM9iXW9muwrmbJa
        CnqYlok4UsjvB6EaQQHMZ9M=
X-Google-Smtp-Source: ABdhPJxu/C0pJyV006GIzYbjfrk5brCbJG3xBgGaqO6gsJ75Q5mT9pxaOGCcRkBmHZW1oRMW+cNUsA==
X-Received: by 2002:a17:906:3941:b0:6d0:ee09:6b67 with SMTP id g1-20020a170906394100b006d0ee096b67mr11676055eje.45.1645524391238;
        Tue, 22 Feb 2022 02:06:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i8sm3803935eda.90.2022.02.22.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:06:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMS3y-005w6R-2w;
        Tue, 22 Feb 2022 11:06:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Date:   Tue, 22 Feb 2022 11:05:20 +0100
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
 <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
Message-ID: <220222.86wnhn8bbt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Elijah Newren wrote:

> On Mon, Feb 21, 2022 at 12:34 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Elijah,
>>
>> In addition to Stolee's feedback...
>>
>> On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:
>>
>> > diff --git a/config.c b/config.c
>> > index 2bffa8d4a01..68e877a1d80 100644
>> > --- a/config.c
>> > +++ b/config.c
>> > @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>> >               return 0;
>> >       }
>> >
>> > +     if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
>> > +             core_expect_files_outside_sparse_patterns = git_config_bool(var, value);
>> > +             return 0;
>> > +     }
>>
>> The `core` section is already quite crowded (for which I am partially
>> responsible, of course).
>>
>> Maybe it would be a good idea to introduce the `sparse` section, using
>> `sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree =
>> false`?
>
> That's a fair point.  At one point Stolee wanted to change from
> core.sparse* to sparse.* -- but by that point we already had users and
> would have had to deal with a bit of a migration story (and wondering
> what to do if people had both old and new config variables set
> inconsistently).
>
> I'm not sure if it's optimal to try to keep the sparse settings
> together (thus put new ones under core), or try to avoid filling core.
> I guess if we moved towards sparse.* now, it might be an easier
> migration story if we only have two options to move.  And besides,
> we're already split between multiple sections with
> extensions.worktreeConfig, core.sparseCheckout{,Cone}, and
> index.sparse already...so maybe adding one more section would be par
> for the course.  ;-)
>
> So, I'm leaning towards sparse.expectFilesOutsideOfPatterns, but I'd
> like to hear Stolee's thoughts too.

Yes, maybe sparse.* etc. is best. I'm fine with whatever you two come up
with.

I just wanted to raise the point that it's less important to consider
names/namespaces for variables one-by-one, and more important that all
the variables in a "family" fit well together, the users can find them
all in one place etc. (ideally, not always possible).


