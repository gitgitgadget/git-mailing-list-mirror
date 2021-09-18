Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222BC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7670860FC2
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 15:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhIRP7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbhIRP7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 11:59:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341FC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 08:58:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m11so16149225ioo.6
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rn6FSUDvDqpfZPxfO3sKTidK+hEYMea8oW/2SjHJP1E=;
        b=vj41p/o0W2xhfPHz8GlQZm1HbuEoisi5zHrOOk0COd/r0Nb1VPLEulh78EQ5HoRi5M
         oaHVVbI+0s8aLO5Ip4QGSXvTTopLdzwCNd9yAG0CU2mqnVAM9kwrsSs+n/sMwG5NDtwp
         NqgL/ii+oHoGv4R86uKDOt1b3FW8ybMpURZCpqPRzgeXCiHXDMGwWy5DOv60Vn9rNOeF
         jKmDpGOkzwgoX/twz6wAd7G8GrycNhQsLeBZ1bbhoxsvQrzDS88qvgGtuuMYSKeSEn19
         wnjVJCnk78uH94mmGE9npUgrFanG7fcvYLku/v9KLAGQfYI4zIcPdr8u6eUQDKPoM83P
         4v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rn6FSUDvDqpfZPxfO3sKTidK+hEYMea8oW/2SjHJP1E=;
        b=AYDYRMJVnjOzdqkJ1T3eRGHQExRM2uHfRJ53s8DDkNYxzjBitBiL623SgwCX2J5pN7
         PHJL3LFkY/oMnsa1OJyI5jxkQdqqaat7xuLE5Nlby58/h8qgTdea8S0PbVAoDTB0+hQ7
         XqgxHQ2H16TlXX+KZNh+dNLWw9zfIqaOn4ZfVGXPaDUwVPlNgKz2exPeMblJL3a6QIOe
         wOBtGGESNNfU6hWu+1xMQcVA9YFOO7daR1NPRzlmF4lgr06utrAo+mZM2FKAVdRliLE1
         poM73Nvx7kujaJLuBUSST5UIMbDy+RRZFOSFKhgD5SJUaIhdI5w3M2QrYkmq4qC7x+wS
         vyRA==
X-Gm-Message-State: AOAM530rJgMXVXcACVRa68YpYkhfkxt9TG9q/beYo1LGdubsywHPjC9v
        nrMzQgeD0Zr7WBgBiCjoLtUrbA==
X-Google-Smtp-Source: ABdhPJxbwgwoCSz1wXXqHD7FS/otGkc3NVKqp6olCAGyxAOebDEzjNt4eggFuKaHunCdGHXyoC+s1Q==
X-Received: by 2002:a05:6638:1514:: with SMTP id b20mr13225977jat.47.1631980691448;
        Sat, 18 Sep 2021 08:58:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e10sm5315045ili.53.2021.09.18.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:58:11 -0700 (PDT)
Date:   Sat, 18 Sep 2021 11:58:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <YUYMknppMEg9Px/S@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
 <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com>
 <20210917211337.GC2118053@szeder.dev>
 <YUUQzswYL5x74Tps@coredump.intra.peff.net>
 <YUVreesWdRmBYl1C@nand.local>
 <87v92ycpil.fsf@evledraar.gmail.com>
 <YUYMINltnUlM8Ziv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUYMINltnUlM8Ziv@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 11:56:16AM -0400, Taylor Blau wrote:
> > This is a good change, but if you're up for bonus points leaves the docs
> > in an odd where we (as noted in [1]) document the --object-dir and
> > --progress options under OPTIONS, but now only take the former before
> > the sub-command.
>
> Thanks for noticing. I got up and did something in between writing and
> sending this patch, and had a nagging feeling of forgetting something
> before I sent. But I couldn't figure out what ;).

Actually, I stand by the original patch. Yes, the top-level OPTIONS of
git-commit-graph(1) mentions `--[no-]progress`, but the synopsis makes
clear that those are only accepted after the sub-commands.

So I think it's fine as-is.

Thanks,
Taylor
