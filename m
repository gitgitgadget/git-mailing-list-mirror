Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9877FC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C5C61107
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbhIUDcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhIUDYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:24:03 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E3C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 20:22:35 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q14so21145527ils.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AExEJ9KBEjVpiRscgW4KFVXinfe2Kjq/DzcFScr0lRo=;
        b=LKmYyJypaPgyWST6KfkYKQ7GOZ8Og0D1astAgcH8BKLRFksz2g6IRhzQhkANh9UhBD
         thynrGTHWOoemW6yuiXiWqHaK94Z1Mz0eG/K+DiO14Pqj8t6Ox1Ema3qH00/ej5k9lgN
         9L0sf/tPxLKe2Bxmdy9jW5nnLPgoIgGc7xz5I9AGOwYg2j5ZJoScROL0iCQci4tdw0Dw
         gsOirO93YTnHQCPjTS2qXIfOWr3jKEvpYv33FyNALX7CqLNPT7PQeQnuiUvGgB5j27Dp
         I0ixoxvLhezom0q8jf5AWe9P6AW6rbmEFq8xyaAIqFRDQIyFODd3hyJZGDnS/0q1s8AU
         GYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AExEJ9KBEjVpiRscgW4KFVXinfe2Kjq/DzcFScr0lRo=;
        b=3NNZPB+uIlQsdWrGoqLJqSed6Bs9IGLy6UQWwb6DLPFzhLw8Iymy92iC81PunZPbDK
         aMZ6mFTyeRfFZnuLajLnOuRLcaxw8QrXVf69E3z104CsGtGn3P0ef9w5s+IDl3nV84mJ
         /sBfNo3+5WhGFDICOtfs/N+vdyCDMYadpOURVN8VUjxOExVBzWnRV7BQYk9d79QiJ66l
         aizHyvbq85vtJRYZmjn2UlUVPG5m+EprP6SiCUHCCdQ++WGmpF82E2ZQJMvYxoHmZvtZ
         MfAguDnAAAuzCOnDRFxUbT8wPrPhlzVHwcqn9Z0AW2aHMEhaLRQXxoHaae0idOVjp8tB
         pBwA==
X-Gm-Message-State: AOAM533j1i6gKximeq40g4pU+GG0SqqcnGJisHsNfrsUEDjj0GvBNxok
        Nx/g6ZxM4Hh5/n9irug7NIZGsw==
X-Google-Smtp-Source: ABdhPJzlG9Wt1NxnYB3QvFzNJMc8GEfwZ6fToNJUYYsPe7h7Fic9mzZRI31riZCFKz69hw+wYlOcnA==
X-Received: by 2002:a05:6e02:1789:: with SMTP id y9mr3133753ilu.176.1632194554515;
        Mon, 20 Sep 2021 20:22:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4sm9486991ioo.2.2021.09.20.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 20:22:34 -0700 (PDT)
Date:   Mon, 20 Sep 2021 23:22:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #06; Mon, 20)
Message-ID: <YUlP+X1HClIswzWK@nand.local>
References: <xmqq1r5iaj9j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r5iaj9j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 05:02:00PM -0700, Junio C Hamano wrote:
> * tb/midx-write-propagate-namehash (2021-09-17) 7 commits
>
>  "git multi-pack-index write --bitmap" learns to propagate the
>  hashcache from original bitmap to resulting bitmap.
>
>  Will merge to 'next'?

This one is ready to go:

  https://lore.kernel.org/git/YUUS4Mrh85KPucmi@coredump.intra.peff.net/

Thanks,
Taylor
