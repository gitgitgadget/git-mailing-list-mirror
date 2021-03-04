Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D8BC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4482264E99
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhCDDHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhCDDHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 22:07:30 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C14C061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 19:06:44 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id t1so11865257qvj.8
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 19:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lad0hHuzARwvTKhKpK5dKrzc/NUTh5thaVBItqDFShk=;
        b=NxraKVzYqfZdW5x+mjeY5PO8D5gN2Y2QxRrNHGvAH98zNqiZZlJ02UZG4uxhL+rtx9
         G2gXN2jTugfI1fBRN0e8ba4xy7QmcYSNZIA/ZyA5ts6iCGDFTEf/RgdiA686ozDEwFPp
         woQFMSNMVlXwxW8iyWktoSpaeWuLMDUGjaKnxcYqZi2GsfDHa3SmK6SryyvLxEGnlOmd
         oaYEkRTYnIj3vFSFJUCsZRjZJXqEL5al/qbuAOzVPux3j8ubBgGRV7DP8vO/rvrtjgAZ
         4VYiYxP90cLexEI03d6KjQBuvDMCz5LwOkkLFw78/vMfXq5sjHuF7tt2yM1+ffKqh8cS
         hb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lad0hHuzARwvTKhKpK5dKrzc/NUTh5thaVBItqDFShk=;
        b=l97lPDFla5Ol0jboyg5MYx0ZvrzETCoyvVA0a+x4dWoDQY7WtaT/tSBUDAetpWOeTj
         I/Y4TsXr9OjMLwUNunpNey9PFsIUgqMzU+E4YGlDsCVFiRzgPYmGMgxoGeogwijdP957
         9oXnvx5bpBgCc6HhBhwf+aDGSV0rys3nwt0HLwUSjG7G7fYI2/yESx4YpZypnJKuN1a+
         YEbImXBj2YYkMWvcpqJOltGu6vxVWgwgZcEgRpSPDhdoNuAaz8KowWaon8BtPYR+zF9v
         reOYoJTUO/wRseVkMdpcs2CzyAa2AJcHh0Kt6wjoTWfpRP0rRMPM1dfETOEkR2OgOFsq
         XxZw==
X-Gm-Message-State: AOAM5307L7m1UT4dL/ycselMddSlKzBV4ZzvNktsPx6qpv/1jr8RtUEM
        ImjIftWuGzOg2S7iveV2z1dIIw==
X-Google-Smtp-Source: ABdhPJyDPbwn4PMYKUfDqkT2Bcqk5zi15sKHJGGy5qMGmbXth5+eErn4cTjPUvPKCw/VxProFSt/Cw==
X-Received: by 2002:ad4:4421:: with SMTP id e1mr2080167qvt.48.1614827203894;
        Wed, 03 Mar 2021 19:06:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:661d:484a:c652:586b])
        by smtp.gmail.com with ESMTPSA id d12sm16608788qth.11.2021.03.03.19.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:06:43 -0800 (PST)
Date:   Wed, 3 Mar 2021 22:06:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 15/15] pack-revindex: write multi-pack reverse indexes
Message-ID: <YEBOvgm8yG9RiL0P@nand.local>
References: <YD+rlaYGylVSkg1D@nand.local>
 <20210304020444.1803406-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304020444.1803406-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 03, 2021 at 06:04:44PM -0800, Jonathan Tan wrote:
> > > Any reason why we're using 2 separate "if" statements?
> >
> > Yeah. This first if statement will turn into:
> >
> >   if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
> >
> > so that the pack order is computed in either case (since both the
> > existing write_midx_reverse_index() and the eventual write_midx_bitmap()
> > will be able to use the pack order).
>
> Ah, OK. That's what I was thinking of, but nice to have confirmation.
> Maybe write in the commit message that these are separated because in
> the future, one of the conditions will change.

Thanks; that's a great idea.

Thanks,
Taylor
