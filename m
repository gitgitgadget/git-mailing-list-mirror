Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B105CC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 12:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382751AbiAYMAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 07:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389491AbiAYL5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 06:57:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58695C061780
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 03:56:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx6so30309522ejb.0
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 03:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AeZ8WUfj8LPlB2h1EBXeiGr6p91jq4WeoFB8IPz1m+w=;
        b=cxGiyjxrnduhrZqReea3ot6ZC85bWmebsKKODncZZFBUysJgFNLzkzIw0Qoym2aIly
         jJaoC4JXGaZFLEcHmPVeklXwmh/0vvkvP72PVcA26pvE5nyiqehrgJ7ouWxwEgdGENUj
         1mYc1xmlstg82ZByY7TrQd67BjKKn/mtosCWO5i++2MFAvK/4d/qSRMYdqH3eiziKoAz
         Txmy4Zd8sN/8A+NyEjcip+07XdFZtQ8Yv2Bf3YQy3brvjXFPgUsyu99giJSJFHSzQm3K
         YA/klg6vKLlLhZhjjsKEJk/2MMO5n1hWjzrcPvGQNofNmCP9uVFZyKGVr5VlNLDvjmUl
         WcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AeZ8WUfj8LPlB2h1EBXeiGr6p91jq4WeoFB8IPz1m+w=;
        b=oixPoyubdt5+Qq3w9UkGFvtWN3LTEk9msir2kOwWAuswOyZKFwCLQOhmLsVnxlbrcS
         SpsPeQ10tHrPxiJKBOtXCVteqpyj7SZVBi1Ty9fgW5TeE87YjtzEk7V+bF2Cp3Vcusv4
         ShdFeDR8hw/nAJEz/kOL7qNNe3Z/ozwgIj6buBXCa3JBY9ZHvELgkMR5OGbuNtPfWSEo
         dr2f2PohNOLY22TfkCm0wYcNAdRvBm23eb5dcfKjYYrJV/hiv8jqRDqOebetXlQy+NKs
         e1sYkk92NXGllGWkuUCkxZpG44WynkZFaRS/Ku6QZTEPrVv84+p8tvrfP/p2Hk7Ky8eP
         SFWg==
X-Gm-Message-State: AOAM532QsHO61ZY4stPMZ4RIIN2Xv7E7H+vuL9qlHgJcrhhop37tjVH+
        QyMJbH7qpOox9Np4ZnkkVHZYOV4WJ0Q=
X-Google-Smtp-Source: ABdhPJycE/a5f4KnC5iIqWwVzvdtR0b1MAcsanzhqjkg3L8i46ygOpjwv+eaimzsZdmDaNfEvxzXXg==
X-Received: by 2002:a17:906:7c87:: with SMTP id w7mr15991694ejo.347.1643111802646;
        Tue, 25 Jan 2022 03:56:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gg14sm6120545ejb.62.2022.01.25.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 03:56:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCKRF-002fJf-Gp;
        Tue, 25 Jan 2022 12:56:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
Date:   Tue, 25 Jan 2022 12:33:56 +0100
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
 <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
 <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
 <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
 <xmqqk0ep57ou.fsf@gitster.g>
 <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
 <xmqqfspc3k8k.fsf@gitster.g>
 <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
Message-ID: <220125.865yq8ghae.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Michael Herrmann wrote:

> Thank you for your explanations Junio. This is the first part where I differ:
>
>> $ ln -f a b
>
> My hard link is outside the repo. In your example, it makes sense that
> Git has to sever the hard link to be able to give the files different
> contents. In my case and example, this complication is not present.
> And it does not address the main point:
>
> My working tree is clean. `git reset --hard HEAD` (not HEAD^ like you
> had) should not do anything.
>
> Finally, your (kind!) explanation does not give a reason why calling
> `git status` should change the behavior that Git unnecessarily severs
> the hard link.
>
> My suspicion is that Git keeps a cache of the stat(...) result of
> files. An additional hard link increases the .st_nlink count of this
> struct. `git reset` compares the cached stat(...) values to the actual
> ones and sees that one has changed. `git status` does the same but is
> smart enough to realize that the additional hard link does not change
> anything. It writes this to the cache. `git reset` should also be
> smart!

What you're observing is that we tweak the index when various commands
are run, some of that is documented, and others we consider purely
implementation details. Whether we sever a hard link relationship is
definitely on the "implementation detail" side of that.

I.e. that you can observe a behavior difference here doesn't mean that
it's a bug, it means that you're poking at behavior that was never
supposed to work this way, or be stable.

That being said I don't see a reason for why we shouldn't ever support
what you're requesting here in some way. E.g. when we spin up different
a different 'git worktree' on the same storage we could optionally
hardlink to an existing checkout to save space.

This would be useful e.g. for spinning up a bunch of trees to run
compilations on, where much of the checkout tree will be duplicated.

And this probably won't match your use-case, but I wonder how far you
could get with the post-checkout hook, i.e. to have it run around after
a checkout and fix up things that aren't hard links to be hardlinked
appropriately.

I don't know of a tool to take two directories and hardlink things where
possible, but it wouldn't be hard to write. I thought rsync could, but
it appears just to support copying things as hardlink, not "fixing"
files with the same content to be hardlinks after the fact (but maybe
I've just missed a way to operate it).
