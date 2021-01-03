Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F528C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 01:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB60A20798
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 01:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhACBYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 20:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhACBYx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 20:24:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F2C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 17:24:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z12so7743258pjn.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 17:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MheNd1iAc8V5DZo95P3icfD7Qs8CRgOMiW4NvP62Bz4=;
        b=kKC5zIAn/RIdZa4f5LGLH/qakizoFCumE8yDAxNYaTBUy0Dhmtxtr2+JFUNbTl7ge2
         ORYlxllx8gvVMlkOJWJjlRJWh4WnIzICOHAhbt3rIwMZzUIR4+gsyFViYUj7vZp68fz2
         hiu0L71pyX7/Gqbl7bB/fpE2y1wAtN47FB9yS0TADGpLdlsYGwTl6LCcSApAJ6t/dPde
         QRndO1ZZhN1O42tnedYT8pYvm8goKysVFQZOezj9jXUY1Xi/m7InYoruSQ8hNtQaJXrK
         eSkpDyLrk7piKnJ0nnUKx9/38nfkCv+lGp7vwU5NBVrBx51bgh3YNrgkcJ42BKRFr89q
         1V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MheNd1iAc8V5DZo95P3icfD7Qs8CRgOMiW4NvP62Bz4=;
        b=M0f1qSaubKcD88r+wkJyTaz9jY8+5sn9bVETdumEiUMqTOTPnGQn2YJDxpTGp6Ap30
         cYy9xWCL1OQuZHuxCKIpDTIl9JnIuseOy77dDpcw+qTNfKKD+wN7qJuVZFH+j0yrTqRR
         ITxhgoDCofXg2RB9ikla0rHcYniq92QeuEOcowpJilLzHXxHWpUTEPClfpzDF1Ir0Izb
         X/rYL2rofpeBEOt0yMtuULeNTsS8L5HIRSQ4eLb7Sw9mJ6+/2VLkF9v7YtK8M624SNOu
         IC7EoORj0u2TPRrNdffpGhFD/poKmF+wPmPe1LR3U5dN07ml4PNilPJioYkEP2ScZKeM
         t3iA==
X-Gm-Message-State: AOAM530eW/Wd6D1g6KFYyMRqJ4sdSqHxuH+FQLdmIjjSZd0wxyK5v6vT
        WLAQ+/0JjYsg0T44uCMiRLaigvENAYU=
X-Google-Smtp-Source: ABdhPJyonYfvnUzACnZZ3cTqbpKjmg1925uHpBvCj5NiKwinkN9GFY+T25LFGQDoTYvcZRFPBLQjZw==
X-Received: by 2002:a17:90a:398d:: with SMTP id z13mr23788272pjb.1.1609637051887;
        Sat, 02 Jan 2021 17:24:11 -0800 (PST)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id 184sm42074511pgi.92.2021.01.02.17.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 17:24:11 -0800 (PST)
Date:   Sat, 2 Jan 2021 17:24:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: allow @{n} to work with n-sized reflog
Message-ID: <X/EcucyFs3Ecuc2K@generichostname>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 01, 2021 at 05:36:06PM -0800, Denton Liu wrote:
> This sequence works
> 
> 	$ git checkout -b newbranch
> 	$ git commit --allow-empty -m one
> 	$ git show -s newbranch@{1}
> 
> and shows the state that was immediately after the newbranch was
> created.
> 
> But then if you do
> 
> 	$ git reflog expire --expire=now refs/heads/newbranch
> 	$ git commit --allow=empty -m two
> 	$ git show -s newbranch@{1}
> 
> you'd be scolded with
> 
> 	fatal: log for 'newbranch' only has 1 entries
> 
> While it is true that it has only 1 entry, we have enough
> information in that single entry that records the transition between
> the state in which the tip of the branch was pointing at commit
> 'one' to the new commit 'two' built on it, so we should be able to
> answer "what object newbranch was pointing at?". But we refuse to
> do so.
> 
> Make @{0} the special case where we use the new side to look up that
> entry. Otherwise, look up @{n} using the old side of the (n-1)th entry
> of the reflog.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

I forgot to mention that the original thread that spawned this idea is
here:

	https://lore.kernel.org/git/xmqqzh8zgcfp.fsf@gitster.c.googlers.com/
