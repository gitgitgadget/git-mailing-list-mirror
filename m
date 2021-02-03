Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD037C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8455061477
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhBCVJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhBCVJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:09:38 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B70DC0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:08:58 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t17so837361qtq.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jT32/eP5Xnw7JYDVVJkjvsWZDrSQf69ajWerRRe7OYM=;
        b=INzx0RG42j8ngz9fTtOc+kRhQwVrviRKj8MzWiFHkvWhNFFRYFQ6HokdNYQc7UcncS
         BiJ+PRKEI7pmN4Y0aabLBg76A8o/TtUbKits7WVmPvAfzmtcWwxQIQPiyV29gzPuWYjk
         pur9xyyhW3SPtc63maCRONsG6kXns7bgoavXDdNSDyDiMwE4sfe7NpO3t7JkzPhBGD9E
         97o542py+b3L3+gmuI8TMSvIrnjAYo5HVxiEGDA4j8ATsdARiMDnpGHaGTwBiYqkvNfS
         YijsEKsaOaF3VHC8V3p2xp2N/52Jp8NwTbxXpq0cbudRy1NEB6pMz81tUO30LATfq2T8
         jyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jT32/eP5Xnw7JYDVVJkjvsWZDrSQf69ajWerRRe7OYM=;
        b=GH+04peaeyzbVaMIWCosiOVElDjiGCOC7sguSo+CpggWkPlQ0L2EDu3t5gQcXfLWw2
         N526qc0SvWCF/Pw8+BNLv0Ncrd2+iFwh+5c2gabFkFs2mll+TOSoGTXGaZANMMwmcscl
         Q1qvm6cStzckK1SlDzDc/t4lsmY26z1n2AYvUNLd6uO7XM//wxJJMRARC4uggV97j4YI
         7r4QQ8qVcSzDkul0C7lREfW3/1smzjt/BxvfAkrzrlMKCXzafJsxS1YLMdC7DIH0OtMm
         eqJzsc1kgVJoReIXZwAwt0JdUAb+NQHNE8oH4TXMbCIbSCkHROGcgLvFQNICTu+kS+n2
         EMVQ==
X-Gm-Message-State: AOAM531AiFJ5FipDf5CrGbQCZvdJNcXvt5ESVogBbvlmRZ9nonh43mQA
        jtKp0Fodl77/47yU50Tb3o3AaA==
X-Google-Smtp-Source: ABdhPJx7XYCeP/BLq5VXs9YNT+tgiE4UD/cDD37+KbG+g5zfJ39hqRU9rMcQckN7FZy9v1W0C5/gJw==
X-Received: by 2002:ac8:6755:: with SMTP id n21mr4269475qtp.57.1612386537482;
        Wed, 03 Feb 2021 13:08:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id x74sm2708357qkb.55.2021.02.03.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:08:56 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:08:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Message-ID: <YBsQ5WhmSPNPyDDs@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <YBoBBie2t1EhcLAN@google.com>
 <6dc1520f-8130-75e1-6617-67b54cb03933@gmail.com>
 <YBrCli7AR/XrB3Pr@nand.local>
 <xmqqk0rpc7uj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0rpc7uj.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:41:08AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Thinking aloud, I'm not totally sure that we should be exposing "git
> > commit-graph clear" to users. The only time that you'd want to run this
> > is if you were trying to remove a corrupted commit-graph, so I'd rather
> > see guidance on how to do that safely show up in
> > Documentation/git-commit-graph.txt.
> >
> > On the other hand, now I'm encouraging running "rm -fr
> > $GIT_DIR/objects/info/commit-graph*", which feels dangerous.
>
> True.
>
> As this is, like pack .idx file, supposed to be "precomputed cached
> data that can be fully recreated using primary information" [*], I
> am perfectly fine to say "commit-graph may have unexplored corners,
> and when you hit a BUG(), you can safely use 'commit-graph clear'
> and recreate it from scratch, or operate without it if you feel you
> do not yet want to trust your data to it for now."  Giving safer and
> easier way to opt out for those who need to get today's release
> done, with enough performance incentive to re-enable it when the
> crunch is over, would be an honest thing to do, I would think.
>
> 	Side note: the index file also used to be considered to hold
> 	such cached data, that can be recreated from the working
> 	tree data and the tip commit.  We no longer treat it that
> 	way, though.
>
> > Somewhere in the middle would be something like:
> >
> >   git -c core.commitGraph=false commit-graph write --reachable
>
> I am a bit worried about the thinking along this line, because it
> gives the users an impression that there is no escaping from
> trusting commit-graph---the one that was created from scratch is
> bug-free and they only need to be cautious about incrementals.
>
> But (1) we do not know that, and (2) it is an unconvincing message
> to somebody who just got hit by a BUG().

This is a convincing counter-point to my proposal. Yeah, I agree that we
shouldn't be advertising that commit-graph is completely trustworthy.

> > which would disable reading existing commit-graph files. Since
> > 85102ac71b (commit-graph: don't write commit-graph when disabled,
> > 2020-10-09), that causes us to exit immediately.
>
> Meaning the three command sequence
>
> 	git commit-graph clear
> 	git commit-graph write --reachable
>         git config core.commitGraph false
>
> to force a clean build of a graph and forbid further updates until
> the bug is squashed???  But should't core.commitGraph forbid reading
> and using the data in the existing files, too?  In which case, shouldn't
> it be equivalent to "git commit-graph clear"?

I think we may be saying the same thing. I was suggesting that if we
reverted 85102ac71b, that 'git -c core.commitGraph=false commit-graph
write ...' would rewrite your commit-graph from scratch (without opening
up existing ones and propagating corruption).

So I was saying that that *would* be a viable "git commit-grpah clear"
(if 85102ac71b were reverted).

Thanks,
Taylor
