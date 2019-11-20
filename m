Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148DFC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 05:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23F42245F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 05:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HtIrmC+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfKTFaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:30:15 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:45045 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfKTFaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 00:30:15 -0500
Received: by mail-pj1-f42.google.com with SMTP id w8so3645547pjh.11
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 21:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x10QfBKlTmeavuHfm82zKCh75xYT/cAWeMo2v+h62J8=;
        b=HtIrmC+yrvlKhnxgm6BiIuFvviLIo6DHhhJDxCoUvVsibxZfHicV8PBjGbW8DIUMdU
         CMLFKWNXgzMypr0Rq7hK64+7LiegnoJc8k4Fosd6eGSNHj7Y2E523w6rjo5mLrsaxicp
         DWEfQydgfSMVnrPkfhRAOzoIDxXQj3V4sO0SSnScBjBokW1yPRZDl+TY2UVKGzGT3LHp
         9CJnfe1tGOnMB6RxzZuM4gKkT3BEEnx4uAWB19nBv2hlGAsZDceS6Op1BuSAfFmyRHZq
         wWaxNC/FUDN72GosF/XblCNXWxNrhGhecVpWjOxjr+A/R3kqEsQNlB2OyMQ/bdhXtih2
         gcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x10QfBKlTmeavuHfm82zKCh75xYT/cAWeMo2v+h62J8=;
        b=BUr7YeIQR38yUfC87MPDdrbZGLWNnTzqe7BjAIlSArZ56Z1ARxJQrmlErJ7xXFfdzb
         rwDZ7TLK0dFHgeJtqZloPPeWp32gW4SXO0FuCU+Su+v5AfxBMvHTgnwVdo9q10lgDaYi
         etAYm3Zqnbma+d0SOwOXpxRbNVin5Ll8AcodhBrzM3Dk7m9f97viOC5o8OS06h05Lx4A
         pTXDEDmNreIQnk5QgmFcDOJoEIFpkYjHJS1LoeTXwhz5mgaBYEcF7GRHq2tdtjiGkZ76
         49x/HCkGK7feKimgg0LAVh/kBu7qoTvLOpApjonH44hL9+d1mr4a5VG0nNFFttjIYu/3
         GCDg==
X-Gm-Message-State: APjAAAXzL9099YyfDoWzjjkgOP9uzCLRIFlYz3Qyjec+1nU4Gc+BWhs0
        ycC8AmSC3BlfO5VfJ3yHvdCCrA==
X-Google-Smtp-Source: APXvYqxs/005zm4guj46m+DL97CQPq85axbYe6CGNUKwhQx63LLWlBhQmih12CF6cWDgwZmqT6UDMg==
X-Received: by 2002:a17:90a:c2:: with SMTP id v2mr1728769pjd.140.1574227812762;
        Tue, 19 Nov 2019 21:30:12 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:44ca:eab6:8a88:b2d7])
        by smtp.gmail.com with ESMTPSA id d23sm28106738pfo.140.2019.11.19.21.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 21:30:11 -0800 (PST)
Date:   Tue, 19 Nov 2019 21:30:11 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: your mail
Message-ID: <20191120053011.GA41291@syl.local>
References: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,


On Tue, Nov 19, 2019 at 07:49:17PM -0800, Han-Wen Nienhuys wrote:
> Hey folks,
>
> I spent the last few weeks cobbling together an implementation of the
> reftable format in C and in Go. I thought this would be cool to add to
> git-core, but I doubt whether I will have enough time to see such an
> effort through. Maybe some of you would want to try integrating it
> into the Git-core code base?  Example code is here:
>
>   https://github.com/google/reftable/blob/master/c/api.h#L153

Very exciting, and thanks for your work on this. I haven't taken a
close look at the code yet, so I'm sure taking this further involves a
much more careful examination.

I know that Christian Couder (who you CC-d on this thread) was also
working on this for either GitLab or Booking.com.

Christian -- are you still working on this for either one of those
entities? If so, is there some way to unify these two efforts?

> cheers!
> --

Thanks,
Taylor
