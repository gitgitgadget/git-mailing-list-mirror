Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95779C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiAXRkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbiAXRkN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:40:13 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2EC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:40:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y14-20020a17090ad70e00b001b4fc2943b3so11993860pju.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bFGiIMtGDPfiCzZltrVKSj4UcFulJvHMbpfSFD7fzEU=;
        b=H7VrX4XoIRIA56X3nVM+5lpMcb7gEm0sHWjy/o7IqBFA30603XyRJxrDfeI7o21bAp
         HIyF2CTKzWHSeKMVhMJ5aa7L+v+r8jONHqMaCFxNjEDL9QSDDXnInFeIrwqjmE3kX5A0
         QEPSF2f9iJ2xbs7D8SsVFGja95fKQ1mSePUu/dCN1Qa0JjNgfW++C1Lwy50FuXkBJQ6d
         OBeasdEIER2oh5n/WZl6BWyD4G/jO5Vqcm+W9UNgG/dF3VNv9fwj00dBbOVVuPuq5MHf
         tmXxGMSyuYLZHD5P//km7H0UwoDY/ARyvoHIRO/B3eFhrWhh9dfVVF65OeRp3xtEXrA9
         BtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bFGiIMtGDPfiCzZltrVKSj4UcFulJvHMbpfSFD7fzEU=;
        b=xzisrWbUxcruqM8HE3mRkiNi48AQbOuF9Tkw7AHKu1ixR3U+z7sCc2ZD6iFGZABLtf
         QoYRIIBuGS3a28cM1tJ2B2ARe7y45ZsKqdIUiNWASFUzeuedjV8RVdRsCFKP3Z6rwQ5D
         J5+KuZKT0lGxAvGkUjQnP7IAPmjGSA9ZgvkOj2IBVN8isSZlBs3UqBi5JnJAqWMNxHRS
         gBok0qxy5L6J3Z6A8eg3Y3ZN672TrVw5CGsFbXIwCaCPiCSrAC8wJVj2wL9zeYSSxTFx
         sa9hl8JiJAPP/C0dOKKMlsIlYDfzQP65zL2yjFl+kam8v24KB5QZCxHDZuEzlKm8Jr2l
         75rA==
X-Gm-Message-State: AOAM532SikE1dC9ztZi7FqcBXIIqm3N1h4i6kDo59WdHDYGXepi8lZX+
        RQlA5Vo2415bspDAgE5DKc5zGC4d+yJamq52dFBY
X-Google-Smtp-Source: ABdhPJxrTarI7eI/gSE0N8LHX2MiC5fEnIjt5gc+3/oaL2H7fOinNnQJrynQnNg9OHvBebgdKJNzJdqs/C/bXrjKbZ2L
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1c88:: with SMTP id
 oo8mr2937826pjb.212.1643046012300; Mon, 24 Jan 2022 09:40:12 -0800 (PST)
Date:   Mon, 24 Jan 2022 09:40:08 -0800
In-Reply-To: <YeneJrzjp160edGG@nand.local>
Message-Id: <20220124174008.2431481-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YeneJrzjp160edGG@nand.local>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 1/9] t5326: demonstrate bitmap corruption after permutation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Jan 20, 2022 at 09:55:41AM -0800, Jonathan Tan wrote:
> > As an effort to ensure that Git reads coherent .midx, .rev, and .bitmap
> > files, both the .rev and .bitmap files are keyed on the checksum of the
> > .midx file. But the issue here is that a .rev and a .bitmap could both
> > refer to the same .midx checksum when the .rev and .bitmap files are not
> > coherent with respect to each other (e.g. when a Git process has written
> > the .rev, but not the .bitmap yet - but this would appear perfectly
> > ordinary to another concurrently running Git process, since the .midx
> > checksum in the .rev and .bitmap files match).
> 
> Kind of, and it's possible that we're saying the same thing here using
> different words.
> 
> But seeing an out-of-sync .bitmap and .rev is really a symptom of the
> underlying problem, which is that the MIDX checksum could (prior to
> these patches) be unchanged even when the object order it represents
> _does_ change (e.g., in the case of swapping the preferred pack around
> like the test here demonstrates).

Yeah - I think the way you're describing it is that the concept of
preferred packfile is inherent to the .midx, whereas I just think of it
as an input that helps the algorithm choose between the many .midx
possible given a set of packfiles. Maybe these are just two different
ways of looking at the same thing.

> > This problem is exacerbated by the fact that the .rev has its .midx
> > checksum in its filename, whereas the .bitmap has its .midx checksum in
> > its file contents. When generating .midx+.rev+.bitmap, it would write
> > the .bitmap but not the .rev, since a .rev of the same filename already
> > exists.
> 
> This isn't quite right: both have the MIDX's checksum in their filename.
> For example after running `git repack --write-midx --write-bitmap-index`
> on a random repository, I get these MIDX-related files:
> 
>     $ find .git/objects/pack -type f -name 'multi-pack-index*'
>     .git/objects/pack/multi-pack-index-fd71600b4ceb4caf23a538c7829b9284f2b66d73.rev
>     .git/objects/pack/multi-pack-index-fd71600b4ceb4caf23a538c7829b9284f2b66d73.bitmap
>     .git/objects/pack/multi-pack-index

Ah, thanks for the clarification. I saw that bitmaps were overridden
correctly and saw BITMAP_OPT_HASH_CACHE in the bitmap-format
documentation, and made an incorrect assumption.

> Apologies if that all exactly matched up with your understanding, and I
> was just telling you stuff that you already knew. But I figure that this
> bug is subtle enough that a little bit of hair-splitting doesn't hurt
> ;).

Thanks for all the clarification, especially about the bitmap.
