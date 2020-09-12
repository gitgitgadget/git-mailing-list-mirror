Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC197C43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E71A21527
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 03:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="z4AiB5l3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgILDtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 23:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgILDtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 23:49:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B18C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 20:49:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so11873637qkn.11
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fTNzfBe/zFQQMJT5eDoJRT9KCYJFklvDZ0MYBECjAgw=;
        b=z4AiB5l3xWVak/vs6dvTXac/HBAt1EZn6/KjDYmjhPqZnwpc5D13R9mcQKyNJ1JJbz
         /iLi+ZG1dAvGemJ47gMHDUq/76UfOvTLcmwRM/rEa13MgGhmwlNCbzFVDsYg+173FHUW
         ixUMbKHwRtAXEeYk/LqtMaKMxC/ZhZZjfbRmRh84uJr8HElRX9BUWCrVi92T6h45hfE/
         86IR+uAU+NedDpi8nmFQQUJU/eqSudMCdyPzHKWf46jhpbUrwHc7SZqxjz+hkq/XMYF5
         +z5RinbCZJEznYSYoC7T1sc+pBl5kiUF8bKc1XT5VZqBMomet+/F9xLTj1Br0OpbeZnQ
         m/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fTNzfBe/zFQQMJT5eDoJRT9KCYJFklvDZ0MYBECjAgw=;
        b=WNPkmwt75tJwV7LwC0CKfG7/2oZRU/QEI/aTZLc4EKGDHw7VjHRjgNMp8CU8ygRwyG
         wKENkcyI1XU5QGevg/ieXiMhpRR0YzVvvpUU5wLVJiZLCUfkkMZ1wDTbalWgwfmBmyY9
         flmt0gd4W8RFkyUmYZKT7VK6t9lyvmR0GOkFfwstpLMcoTuWFcyia+pTWOOGROArO8GS
         MG13e7ITGlpkDPgrl+WApiYrYJC/gT+6ukH2okOsGfvKVqr5bpKSr3WQxbqLIU3JHGpY
         OUSo78xT109XzH/xxKXvrcLVK7AWVbfnn8bWCZb1JZW11RJCM13SRewGR8ae0D6rbEbJ
         pdRQ==
X-Gm-Message-State: AOAM530K0dGRmADM96vsC4yagXqCzVqXbToKS1v98Bw+TjdWXWZiQ1St
        wgnt6MrYvynC5tYxErAa+xcwTw==
X-Google-Smtp-Source: ABdhPJxfqGfH9u0b/wx9sKIHgKuTSkamFy4FxJr/21t419p4dLrczt747P/BTyXWu7eCwpJLtQ+uGw==
X-Received: by 2002:a37:606:: with SMTP id 6mr4403574qkg.177.1599882544263;
        Fri, 11 Sep 2020 20:49:04 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:14f0:d4d0:9608:fa48])
        by smtp.gmail.com with ESMTPSA id x126sm5377639qkb.101.2020.09.11.20.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 20:49:03 -0700 (PDT)
Date:   Fri, 11 Sep 2020 23:49:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] various wt-status/worktree cleanups
Message-ID: <20200912034901.GA4101@nand.local>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 09:03:34PM +0200, Martin Ågren wrote:
> This merges pretty well with `seen` (`jc/quote-path-cleanup`) (and the
> tests still pass). These patches are obviously low priority, nothing
> revolutionary here.

What revision is this series based on, again? Applying the first patch
on top of 'seen' (bf3e2864f3, at the time of writing) produces a
conflict due to the dropped parameter in 'dwim_ref()'.

But, applying in directly on top of Junio's 'jc/quote-path-cleanup' from
his repository handles the first patch just fine, but fails in the
second patch. The conflicts here are in 'wt_shortstatus_unmerged' and
'wt_shortstatus_status'.

I didn't look deeply to figure out what exactly was going on here, but
it would be good to know so that I can play with these patches a bit
myself.

Thanks,
Taylor
