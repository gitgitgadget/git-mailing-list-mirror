Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FFEC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiKCP03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKCP0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 11:26:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53CD5A
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 08:26:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v3so1957855pgh.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bIJK/vcGJ/CZBDOshZYjiWMnQAa38xIGct3dFGLxDFw=;
        b=DRx3LZHsiEfar6kGU6LFY+t34N48s4ZY0Ux1yxXNJC4GU8WlJz9EhQM5rsAV1C3hZD
         8y8HU304wiFPZ8ydGb38Njy/HKCOn5g38JdDtmBVsLWfklc6dR8+MHQhjrPMJ6CnHm6K
         Dmg5S5DBHEtTHM6xu9MZne0VTWSieORaw0WbdzJROHhDRaPTjaoQmkplkocNBtaRtZ+l
         q8ODwxwg/7eYi0maMnljzzIVK5s2qY+GpjH2gj1gbDgenTdWgJier0aeNFRWPei3zmu2
         n/wgyfkU9Sk6NFDKAaq16C0XRsykcalRTrSmsKbdRMW/f/6O90ruuiE9jUNJfwru0Z18
         UR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIJK/vcGJ/CZBDOshZYjiWMnQAa38xIGct3dFGLxDFw=;
        b=MKoqSPQYEIhBbAly0Sbnkw3/cbbC8C05yGv0bB3ClLaxCdczRWfzwLUT3tG6BYr0JZ
         nd3Ybfm3P7pIjFHktMWG7UWyQb4crbg5I+TXoLw7FJbSt8jUJF4VqDQ+kNmiGmC1sNSl
         tdhw4CUZe/sfOJNa10aONj/SfKOcgfh070wBYeLUAFrhm2vFUwW46ciLtE+4/ykQ3MRX
         RLhwgIueULHSphlP/ICwttp1vN0OI6Yh/mJeGePpwniWfcB105ERGjWaTcEr8SwYc191
         B38uP/gVIRh84QGmb8MgFMpn3L/1oUZAuNsD8BWUHwcvdL6iI0KNCScJRQWsuhkdddJR
         5SQw==
X-Gm-Message-State: ACrzQf0akqfAZWY9Qn2de9AO2psOaQBqE4gE1HN6xywYi/vUa5Nz0LYF
        ua3jMnT/7XIleitub6Z21WsTdMTOJUjIgRJRyO0=
X-Google-Smtp-Source: AMsMyM7KWBHXJZQ39MAeZArDhKgRJzuqeJmypZU42EKoh7VC2hvEtKA50caeh7+2Kxl/AoWB3RZC7omvyTfsBHYcPaU=
X-Received: by 2002:a65:53c6:0:b0:46f:cbcb:7402 with SMTP id
 z6-20020a6553c6000000b0046fcbcb7402mr17447937pgr.366.1667489183484; Thu, 03
 Nov 2022 08:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
 <16a8a331-f012-7dae-de1e-f03da95ecb6e@dunelm.org.uk>
In-Reply-To: <16a8a331-f012-7dae-de1e-f03da95ecb6e@dunelm.org.uk>
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Thu, 3 Nov 2022 16:25:57 +0100
Message-ID: <CAFzd1+58MCXC9XZ+R7QFUdtw99KV2mHUHGgQUYvoa0USuYSLog@mail.gmail.com>
Subject: Re: rebase -i --update-refs can lead to deletion of branches
To:     phillip.wood@dunelm.org.uk
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the following reproduction

```
git init &&
git commit --allow-empty -m "Init" &&
git commit --allow-empty -m "A" &&
git checkout -b feature &&
git commit --allow-empty -m "B" &&
git commit --allow-empty -m "C" &&
GIT_SEQUENCE_EDITOR="sed -i -e '/^update-ref/d'" git rebase
--update-refs master^ --interactive
```

After that

```
$ git branch -l
* feature
```

and `master` is gone.  Is that reproduction/test-case sane, even? I
*think* that's what I originally described.

Regards
Caspar Duregger


Am Do., 3. Nov. 2022 um 10:32 Uhr schrieb Phillip Wood
<phillip.wood123@gmail.com>:
>
> Hi Caspar
>
> On 20/10/2022 18:01, herr.kaste wrote:
> > Hi,
> >
> > I have the following:
> >
> > While doing a
> >
> > `$ git rebase --interactive  --update-refs X`
> >
> > I *removed* the "update-ref" lines from the todo list.  The rebase runs
> > as expected and prints e.g.
> >
> > ```
> > Successfully rebased and updated refs/heads/test.
> > Updated the following refs with --update-refs:
> > refs/heads/master
> > refs/heads/permissive-interactive-rebase
> > refs/heads/variable-annotations-meta-block
> > ```
> >
> > After that all refs have been removed/deleted.
> >
> > ```
> > $ git branch  --list
> > * test
> > ```
> >
> > Now, I should just have not used `--update-refs` in the first place but anyway
> > I decide late that I rather don't want to update "master" etc. and it should
> > probably not delete the local refs.
> >
> > Actually, I so love the new feature that I switched it *on* by default, and just
> > wanted to overwrite the behavior in the todo editor.
>
> Sorry for the slow reply, I'm afraid I still haven't found time to look
> at this. As far as I can remember deleting the "update-ref" lines should
> leave the ref unchanged. I've cc'd the author to see if they have any
> insight into what is going on
>
> Best Wishes
>
> Phillip
>
>
> > Regards
> > Caspar Duregger
