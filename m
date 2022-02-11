Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C6C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiBKUiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:38:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiBKUiT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:38:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9ABD47
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:38:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k13so18739416lfg.9
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnO9+CWmfbiO4HbpQ7AIR+960TmlGSv3gGqx8Y0ozuI=;
        b=PBtndQrYMCYU77cY7EccyuV6KqTKeJ63FUrC5N7Xva2C7X99WWBhgbygtyS0bKHOW5
         HoiMpxgaGbxxAXErT0rWJh7ht869b7aw98yZC8roiGYJUPM9D6x2RGa9WVLzbXzMqFa8
         r+d5YorkeF2p8Y5vPgpn4MxPFVfYWhV2dBGAZTLgX7hZjNqVWOylPUikhnhYX4MrLX02
         zpTjpWWhmC0GOQCNbhXBoQ4ki8edMQqgs4Gpnx7XUPdZ0kj6BOiWT/4/gmCRSTS9no9r
         tnNcgRn2sUOuk1lrVY5N0pTAQ+N6MfbpQyPo0gKb+ZD1UlBFeV3SlMAU08O9ACDgHdqm
         G0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnO9+CWmfbiO4HbpQ7AIR+960TmlGSv3gGqx8Y0ozuI=;
        b=Aaxym4N0Jf3Vs0xYXWN6qn0/MkD/i0PO1k3YSg9d507xGeQJA4AyW5f3CwPs6Wf0iy
         A3T8ocTviryDYabCVT7w3td7xbOLIyUf5yp2bDcydwt8xfPfyf431hWLE/kW3qfRRiJr
         XlYNtUqfM9rRV+MjEd4IgyFxfvOtRkUH+Hh7RkmSkyMZYnEHteW3j6hElRl/v7q/0DSi
         WCdO3Z9vH4YcdoTfdzsZ0kk6sSQTuqGyf74WObLBL26AHxRYx26OXZYRzWl/4MQDGbqZ
         OjAsBCkAcFFH/HTsupJueG3vP3QkqM//Glh85bT+iT4/lkz5TU3F+oeC7SoxzSXqSFq5
         bidg==
X-Gm-Message-State: AOAM532scO2XCkukzUBYIYRLP+m9CEVezTIgg3oDpuZ6Y5I8Cr3048A4
        j+GUe4P2vVypqB/TQddt0TVM5c5CXf6CeSGgGR4=
X-Google-Smtp-Source: ABdhPJxHVNaDzHmjFuye8Yvh2pcumq+Mij5FtN66k54LkTPO6nEMSNo5oOm5WB+moCrceIcXR/vAX+zy6wXpifEQVU4=
X-Received: by 2002:a19:7518:: with SMTP id y24mr2265186lfe.557.1644611893464;
 Fri, 11 Feb 2022 12:38:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
 <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com> <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g>
In-Reply-To: <xmqqr18m8514.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 11 Feb 2022 12:38:02 -0800
Message-ID: <CANQDOdcXssVBAbUU_+_0GKEUey0c9tdC3Oq8Kky_kLdW6uLeYQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies in advance for the delayed reply.  I've finally been able to
return to Git after an absence.

On Tue, Feb 1, 2022 at 4:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +core.fsync::
> > +     A comma-separated list of parts of the repository which should be
> > +     hardened via the core.fsyncMethod when created or modified. You can
> > +     disable hardening of any component by prefixing it with a '-'. Later
> > +     items take precedence over earlier ones in the list. For example,
> > +     `core.fsync=all,-pack-metadata` means "harden everything except pack
> > +     metadata." Items that are not hardened may be lost in the event of an
> > +     unclean system shutdown.
> > ++
> > +* `none` disables fsync completely. This must be specified alone.
> > +* `loose-object` hardens objects added to the repo in loose-object form.
> > +* `pack` hardens objects added to the repo in packfile form.
> > +* `pack-metadata` hardens packfile bitmaps and indexes.
> > +* `commit-graph` hardens the commit graph file.
> > +* `objects` is an aggregate option that includes `loose-objects`, `pack`,
> > +  `pack-metadata`, and `commit-graph`.
> > +* `default` is an aggregate option that is equivalent to `objects,-loose-object`
> > +* `all` is an aggregate option that syncs all individual components above.
>
> I am not quite sure if this is way too complex (e.g. what does it
> mean that we do not care much about loose-object safety while we do
> care about commit-graph files?) and at the same time it is too
> limited (e.g. if it makes sense to say a class of items deserve more
> protection than another class of items, don't we want to be able to
> say "class X is ultra-precious so use method A on them, while class
> Y is mildly precious and use method B on them, everything else are
> not that important and doing the default thing is just fine").
>
> If we wanted to allow the "matrix" kind of flexibility, I think the
> way to do so would be
>
>         fsync.<class>.method = <value>
>
> e.g.
>
>         [fsync "default"] method = none
>         [fsync "loose-object"] method = fsync
>         [fsync "pack-metadata"] method = writeout-only
>

I don't believe it makes sense to offer a full matrix of what to fsync
and what method to use, since the method is a property of the
filesystem and OS the repo is running on, while the list of things to
fsync is more a selection of what the user values. So if I'm hosting
on APFS on macOS or NTFS on Windows, I'd want to set the fsyncMethod
to batch so that I can get good performance at the safety level I
choose.  If I'm working on my maintainer repo, I'd maybe not want to
fsync anything, but I'd want to fsync everything when working on my
developer repo.

> Where do we expect users to take the core.fsync settings from?  Per
> repository?  If it is from per user (i.e. $HOME/.gitconfig), do
> people tend to share it across systems (not necessarily over NFS)
> with the same contents?  If so, I am not sure if fsync.method that
> is way too close to the actual "implementation" is a good idea to
> begin with.  From end-user's point of view, it may be easier to
> express "class X is ultra-precious, and class Y and Z are mildly
> so", with something like fsync.<class>.level = <how-precious> and
> let the Git implementation on each platform choose the appropriate
> fsync method to protect the stuff at that precious-ness.
>

I expect the vast majority of users to have whatever setting is baked
into their build of Git.  For the users that want to do something
different, I expect them to have core.fsyncMethod and core.fsync
configured per-user for the majority of their repos. Some repos might
have custom settings that override the per-user settings: 1) Ephemeral
repos that don't contain unique data would probably want to set
core.fsync=none. 2) Repos hosting on NFS or on a different FS may have
a stricter core.fsyncmethod setting.

(More more text to follow in reply to your next email).
