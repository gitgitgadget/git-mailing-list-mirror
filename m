Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E349C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 07:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066252074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 07:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QisGtSUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgG3HtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3HtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 03:49:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB8C061794
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 00:49:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so16060359pgg.10
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQr1U895+R8OSaltxewuoU8Zm2XTHVlN9lB1vg6bqng=;
        b=QisGtSUkaCRzJWpVqHdXLJp746kowCkCJtQ0jRrSPeHPDr1k4TiXrnNYD85xUm6W4A
         8/eUsfC+FCAqfbnc2YvjFyCO2NC/j7QBT7viDyERS0710Ki3e339UHHEiivfG+ipr6o7
         zIOGBSi4//u4YeMBZXsYrGK5RgQq9cubxOX08r3FCYMulDb7RBw5bmLEtMim4Fano6DD
         KGJDkX+XXU/9wUsCv0ATQzC5pKCFocsQlqmKpYoqHw7IldABR3NURd4kP9jhd8qEAgHF
         SyvUZ7cYjYCPcqvI0oNN7iJG9RZ2ZvS1aKbBnD+B9gPiN4AFn6o8ctteoIPhbaVcpH3d
         5YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=vQr1U895+R8OSaltxewuoU8Zm2XTHVlN9lB1vg6bqng=;
        b=VmrNZaEI+fzax0tHSti7vmwZ2QNS3qlyM4RlSPKy3i5XzPuf2+eE5TXJlSRV9V3yWi
         1NOhMxO65vf+Ur5kLLynJs+hMfj8XYibw/q2jgxn907hlwTGghzaWjt6+CBQMjf4XFqL
         98mpEzc6fpjn9ZJngcP/6Wsh+2WbrwzI+juQD7usq1mrg0IIPwjuRKK14IPm5s5uDzfj
         /h4RnsePIoEmNRoKb117VIVjXsQY6gz2E+CRPWv4y6NejJ0SLU+XWT5CP78bjo8Hv7Xj
         9uLh/9CZwsf+2GKXpNg/nsoQSWS09KYVLIUZX6Iz/6BK2diO2Na6Q+DyErACUgwgJ3lM
         qSOA==
X-Gm-Message-State: AOAM5307Z2uoU7BsJ+Bg5ycWnJJLN3xsgAgvM+st2D70cXXVlwCwvryI
        n2bEBPq8AWvvy8j7YnlV8BupGtzek0K9qQ==
X-Google-Smtp-Source: ABdhPJypnkSjR4rk8+l1Mc8BOFENTMkahwRRp15NXBBnBNg6yfY5DNFBhao6j7LSH+QQsNa3UfdWFQ==
X-Received: by 2002:a63:d501:: with SMTP id c1mr33207846pgg.159.1596095345992;
        Thu, 30 Jul 2020 00:49:05 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:208c:7cf0:d18:2f72:fb83:4831])
        by smtp.gmail.com with ESMTPSA id h1sm5141581pgn.41.2020.07.30.00.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 00:49:04 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:17:01 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 0/6] [GSoC] Implement Corrected Commit Date
Message-ID: <20200730074701.GA10743@Abhishek-Arch>
Reply-To: 20200728145458.GA87373@syl.lan
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <20200728145458.GA87373@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728145458.GA87373@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 10:54:58AM -0400, Taylor Blau wrote:
> Hi Abhishek,
> 
> On Tue, Jul 28, 2020 at 09:13:45AM +0000, Abhishek Kumar via GitGitGadget wrote:
> > This patch series implements the corrected commit date offsets as generation
> > number v2, along with other pre-requisites.
> 
> Very exciting. I have been eagerly following your blog and asking
> Stolee about your progress, so I am excited to read these patches.
> 

I am so glad to hear that!

> 
> [...]
> 
> I'm sure that I'll learn more when I get to this point, but I would like
> to hear more about why you want to store the offset rather than the
> corrected commit date itself. It seems that the offset could be either
> positive or negative, so you'd only have the range of a signed integer
> (rather than storing 8 bytes of a time_t for the full breadth of
> possibilities).
> 

Corrected commit dates are at least as big as the committer date, so the
offset (i.e. corrected date - committer date) would never be negative.

We store offsets instead of corrected commit dates because:
- We save 4 bytes for each commit, which amounts to 7-8% of the size of
  commit graph file (of course, dependent on the other chunks used).
- We save some time while writing the commit-graph file too, around
  ~200ms for the Linux repo.

While the savings are modest, writing corrected dates does not offer any
advantage that we could think of, at the time.

> I know also that Peff is working on negative timestamp support, so I
> would want to hear about what he thinks of this, too.

I have read up on Peff's work with negative timestamp support and it's
pretty exciting.

> [...]

Thanks
- Abhishek
