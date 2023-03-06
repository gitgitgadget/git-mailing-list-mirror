Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E7C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCFWTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCFWT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 17:19:28 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB7136EB
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 14:19:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a2so12139771plm.4
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1678141167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ix/wDzIkv9S4w//YFevbZmskx/vpr0l/zQNbBjyCWyU=;
        b=hsMDs8Xfi/4byCGPvGwJpfMqe20wu1d0CQ3ShT+7AMfF5Rnc+bKaLEWDR4jQvEF3tn
         BVaF+jJvrrRLulJMBObVSVP73NfR+IQhoXOX2PnBc8Y49uKGU93lnaWUXRnBjJb93XK9
         mIEEu4atH11lZOzWpO0CIgzeoIFacnOjmtQD3Qfgi+YHHgmzEznrUkmnCyfR5hb9H2SR
         4+AAP6E+/D5ceRVWOpC7C4UH+ct8SdfiNoIlm5OypxU/+c5L6H6DYA1XkWefNJKoGp6J
         qyzJLjDD036bAYebHrrt/dwZA9OJXIpXFeA+UHqTxuFco9HUBUgsJf+EtyHHYPYAeE0d
         7QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix/wDzIkv9S4w//YFevbZmskx/vpr0l/zQNbBjyCWyU=;
        b=f+og3UQxHtPyxqcjFwXDRsyx4l8ESvXmQh40Q+3rzA1GJ1G7e3FT49E/u2swgBhaF5
         yDtkgDXZEpntChBM5Rb/q6fVe/DipvsPX9u+Gpy1Vz3liZAomxxsmS+w3Yth1EurtJ1B
         4UHTs/aCDPF0qW6SqRBI1Pe/faWLRDnT9g9a2sh3PrTcUlB/AKIBgHEVBnuxD5eEf9+T
         cc4Bqjen0OGc2QSkzFKYtgzuV3EPEASPuUnWxptAm/76uBqmZWqjk/V15u2PwegslIgo
         Psy/JYeP34RSjRTTaQfzJ5NZCVzY6zy9OEVdAKsHi/hvu+hKu8tJ5ebboboC6FTWijvh
         vsMQ==
X-Gm-Message-State: AO0yUKXnQxqpwr600SSEYtR6E52p6qRYTeInbjn7ndYGQlG+WN21gm2I
        vjWVOX73xNNNfn1d7sIovXBd2ngCM6IeXpDB13M=
X-Google-Smtp-Source: AK7set9Ppc7886j6NjM5HR0ygF9Zr/XkZSKMMdKuwM/68bQ8JZMpGD/uBG5OnXLdywiYQLM1PF5xqA==
X-Received: by 2002:a17:90a:fe07:b0:23a:8d2f:5997 with SMTP id ck7-20020a17090afe0700b0023a8d2f5997mr9561675pjb.20.1678141166593;
        Mon, 06 Mar 2023 14:19:26 -0800 (PST)
Received: from F407C5W6RY.office.atlassian.com ([120.156.6.104])
        by smtp.gmail.com with ESMTPSA id gi13-20020a17090b110d00b00234ba1cfacbsm6512828pjb.17.2023.03.06.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:19:25 -0800 (PST)
Date:   Tue, 7 Mar 2023 09:19:19 +1100
From:   Ben Humphreys <behumphreys@atlassian.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge
 state
Message-ID: <ZAZm51aZEfuTkdTm@F407C5W6RY.office.atlassian.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
 <xmqq35eul95b.fsf@gitster.g>
 <ZABNceY3cSWNb75u@F407C5W6RY.office.atlassian.com>
 <CABPp-BEJmnAB4QX_HMnNaZ9vEh_mKiqka_uZRm_E_LNuOBiFsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEJmnAB4QX_HMnNaZ9vEh_mKiqka_uZRm_E_LNuOBiFsg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2023 at 07:35:30AM -0800, Elijah Newren wrote:
> I've got bad news for you and great news for you.
> 
> The bad news: there have not yet been any efforts to build these
> optimizations mentioned above.
> 
> The great news: the fact that this affects you means you are using
> non-bare clones in your mergeability checks, and being forced with
> every merge to first checkout the appropriate branch, and pay for the
> penalty of updating both the index and the working tree both in that
> checkout and during the merge (and perhaps in doing a hard reset
> afterwards) in your mergeability check, despite the fact that a
> mergeability check really only needs a boolean: "does it merge
> cleanly?".  Doing a full worktree-tied merge like this is really
> expensive, and while the above Git changes may have made it even more
> expensive for you, the real savings comes from switching to a bare
> clone and not writing any working tree files or the index.  That's
> available via running `git merge-tree`; see the documentation for the
> --write-tree option in particular.  GitHub switched over to it last
> year and GitLab should be switching soon (or may have already
> completed it; I haven't checked in a bit).
> 
> You are, of course, more than welcome to build the optimizations Junio
> alludes to.  It'd help out various end users.  But for improving
> server side operations, I think switching to `git merge-tree` would
> provide you _much_ bigger benefits.

Many thanks for the detailed reply Elijah; indeed the good news
outweighs the bad news! I've started migrating to merge-tree and it
looks great. Once complete I might take a look at the other
optimizations anyway, as a fun project.

Thanks again!

Best Regards,
Ben Humphreys
