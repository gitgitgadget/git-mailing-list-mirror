Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D79C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC74A2078C
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIfzAWBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFKX24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgFKX24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 19:28:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E6C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 16:28:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so3209989pgb.10
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CiOoqRhtdKy0RctCMXZk7Pk8L2ww47yGjnoRJU214wE=;
        b=mIfzAWBWsDyp20JlFjjMgq7AM7dcTU+i7BELEnh4jlLwVPlrfj5HKRF1cyQObzG3cM
         JUyd0/RCT/bNdByTNv5N7YgoxbNVvebJq+7s3QSnwkcRSermA41lEt/HEdOt30rKt5s5
         m6FwlLCLQ9+ZLTnKL7Jd24REdxZ4nAjV1WZU46U455A9SQ4cvQg+dRd58HMGi2XXZwYp
         nIymB0aYnAwhmb8vvpqVkc7lPex4UAVa1WEz/J7HlGlQbSC88GOMoPDdbDgEVqRzkRQ9
         gCrZv65hadYyk9LEGtkexbtPGWNnck3sumVDor/IxvFcLImHdnWv6necYrhZQz8YElSD
         FBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CiOoqRhtdKy0RctCMXZk7Pk8L2ww47yGjnoRJU214wE=;
        b=EsHGrmZFdMCO+oyc5OUyvo+DpadVny8+6kRdZiuJVy6imbDbP9Bl7M4+iTiwr+0W/x
         5X1+po9k2kiUopEyPtDQK7gkc+b0GlcyY2Ho4tthXbwugPIRaoRfTf57wjIx+88n6PUf
         9sOUcwSTmyRYSy6SP4JeZTgIKmTwziLbKXv5grIBi5Lqtb6WuYqMlmeMJjv3L5pT2/ef
         6kfR841QpqWEoJFCateMOL/Dr4B1py/hRNKZYASVIB67n/2v06tueSflQZyQvzX2cBjw
         2C0avqHmPYOyFx7E7r1DhufsLMS0+mh9dGOCoYTFXGum98sU9gyefWp9SFl/RNwwNHlm
         B42Q==
X-Gm-Message-State: AOAM531oe622rsu0RysZiiqUvNZNVoVzS5mm6WttL/JJjMXwXjWe8YwR
        o5K9EPcpKKFWAGTyClcl7cI=
X-Google-Smtp-Source: ABdhPJxcG9fYBZTXhYBBCANG0sxluJRYa0y3c1JBiZH7ELPdoChUxpLgzRQmdxXzdbI/lhPId73pNQ==
X-Received: by 2002:a65:4488:: with SMTP id l8mr8542380pgq.327.1591918135792;
        Thu, 11 Jun 2020 16:28:55 -0700 (PDT)
Received: from death-star ([49.206.15.108])
        by smtp.gmail.com with ESMTPSA id a14sm4028316pfc.133.2020.06.11.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 16:28:55 -0700 (PDT)
Date:   Fri, 12 Jun 2020 04:58:51 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
Message-ID: <20200611232851.GA55419@death-star>
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
 <xmqq4krhjql1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4krhjql1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for replying!

On Thu, Jun 11, 2020 at 01:27:22PM -0700, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > The `diff-files' command and related commands which call `cmd_diff_files()',
> > consider the "intent-to-add" files as a part of the index when comparing the
> > work-tree against it. This was previously addressed in [1] and [2] by turning
> > the option `--ita-invisible-in-index' (introduced in [3]) on by default.
> >
> > For `diff-files' (and `add -p' as a consequence) to show the i-t-a files as
> > as new, `ita_invisible_in_index' will be enabled by default here as well.
> >
> > [1] 0231ae71d3 (diff: turn --ita-invisible-in-index on by default, 2018-05-26)
> > [2] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist in
> >                 index", 2016-10-24)
> > [3] b42b451919 (diff: add --ita-[in]visible-in-index, 2016-10-24)
> 
> Is there any place where we still run the internal diff machinery to
> compare the index and the working tree without setting the
> ita_invisible_in_index bit on with this patch applied, and if so,
> why?  Does the justification why that other place needs to leave
> the bit off apply to this codepath as well?

Yes, I believe that there exist some use cases for `ita_invisible_in_index'
to be unset. For instance, `index_differs_from' which is used in a quite a
few places -- like "commit", "revert", and "rebase" -- which require a
"no change" to be returned.

This commit: [1] addressed the issue where the cache-tree was producing
the same tree as the current commit when it involved "intent-to-add"
entries, instead of aborting.

[1] 018ec3c820 (commit: fix empty commit creation when there's no changes
                but ita entries, 2016-10-24) 

> What I am trying to get at is if this is helping only one usecase
> for "diff-files" while breaking other usecases.

Currently, `run_add_p' (for "add"; which this patch addresses
the fix), and `push_to_deploy' (in "receive-pack"; where this
is the intended behavior), call "diff-files" as a subprocess,
in which case the `ita_invisible_in_index' bit is explicitly
set. For all other cases, calls are made directly
to `run_diff_files' and will be unaffected by this change.
 
> On the other hand, if there is no longer anybody who wants
> ita_invisible_in_index off, perhaps we can get rid of the bit and
> lose many conditionals.
