Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2107C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 23:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9023A60FE6
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 23:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbhIWXyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhIWXyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 19:54:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279ACC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 16:52:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id s20so10405649ioa.4
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 16:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RemrGdrweffeKcCTd5LH9Qq9W2XwMFy568fm1//brdo=;
        b=DPgsCeBQIVq9+Ic58GrHXqa+9uNmcqPn866ZEpvYSp+aqoPlPAg+QHQ/hncRHjZifG
         33+dB5CWGOUNmm6F1/XIjj402BCjMEqeHlPApXcnjmC3fZU3Ltx0t59q8jfuy/67SoFw
         bZl22XCCK21OkyTFloAzVkfzhHdJls3RbSNxGYAGXKFQoDfixnMcY4QXBJ7YPEVHsIUH
         6N/7AeK1Wplx1EpCDFj82h/0LWn164YeOL7mkewHYTE1S7LKAmDpAuDRswzxKpsZBOkY
         P2yQVcUbmo+qOxdeEXaLXWDs0mvBcps/DXiNwi5EzpaiVmKku3WS/G1Wr2pSxkP9RLo1
         2hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RemrGdrweffeKcCTd5LH9Qq9W2XwMFy568fm1//brdo=;
        b=euwnozd9I8QF4Lshnwv00P/IucLduVodkyJrluzR/++5bcZkhXPDXIiO6p3S3g9ZSp
         jj5XUEroPuanK/DLgOaEAuY1wDTyrDKFP8NUhn5M4M9iurPpOBIgD7wqoJGtHcV4Fx+8
         nWFlA+8lAAOj4LyGKjUyhOTxm896LeOmmIxNSKu1C0n2wSHNNj3+ZIQIpKSRqWxjWONu
         vhExk4Yy91ZjrHH3zW/ANaZ7JtZh6jhWO4j1XK4k/MxE1f++hHQoF0hjEmujqaFo4VRI
         q8cgObMtjCxaqjJu2O7WrQX59iJLay+0EqdzBWR7eca5ob5F9u9abW3He+7e0OON7fCJ
         IjJA==
X-Gm-Message-State: AOAM531BaVXDH/nVUhRH2Syr/Xz1D10DXNsWlsKa1/3a1/VRsuO+HdUz
        y+2Vx3BLNY7X/0ufR58OdLPMqzJe9cC4RA==
X-Google-Smtp-Source: ABdhPJyQYkKMLe1dgydwTSnxfM00ZXwaVYRMZ4/1KwfrWcywqtNShtgRMB8f6DStUgN6YcLgjs+SFA==
X-Received: by 2002:a02:9282:: with SMTP id b2mr6465863jah.0.1632441164584;
        Thu, 23 Sep 2021 16:52:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g19sm3316080ilb.84.2021.09.23.16.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:52:44 -0700 (PDT)
Date:   Thu, 23 Sep 2021 19:52:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #07; Thu, 23)
Message-ID: <YU0TS+KsWY36oeKU@nand.local>
References: <xmqqa6k2yj1j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6k2yj1j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 04:22:00PM -0700, Junio C Hamano wrote:
> * tb/commit-graph-usage-fix (2021-09-22) 2 commits
>  Will merge to 'next'.

Thanks, this pair of trivial fixes hopefully shouldn't cause many
issues ;).

> * tb/repack-write-midx (2021-09-16) 8 commits
>  Will merge to 'next'?

Probably good to hold off; I know that Google folks made this the
subject of their review club meeting, and had only gotten part of the
way through the series.

> * tb/midx-write-propagate-namehash (2021-09-17) 7 commits
>  Will merge to 'next'?

Yes, please. Peff reviewed this and was happy with the latest version,
which matches your copy.

c.f., https://lore.kernel.org/git/YUUS4Mrh85KPucmi@coredump.intra.peff.net/

Thanks,
Taylor
