Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28DC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0EF60FC1
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhIUUsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhIUUsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:48:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58445C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:46:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d18so321679iof.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XjgyqWtUKryGLoesWw9I0+l//tMdFF4+r+hEUQFlUmI=;
        b=RCBr+FL/5ljt2CpcNX6fp+okV/XIhXw9f21gcFC9e3K+bxhhgDat1K41ly8VuFgCaH
         QGzHR1AsQsM+mTjVk8sPIawex7y6f55mmWHwcHGAEK6FsfwXK4WntYLZ8YMrqP5Is6kX
         3Htk+pU3Z62ElA9ajjjQ9KH7W7dMUBfoXteMJ3dHOwk1NLoLrpsvK9QKJMSr2My8hCm7
         T7Ivr7QpG29SGWYdnS1zG6bN5af6oDGHkMIWcEHrwmjkj7iL7tiTD1g7ZPJNlttSH+Lc
         qIfYmbm8XbinsA8WMZTlcSuwyBUxb7E81OWAgJdTBRVf/8D/NInWeN89B77SQNsgTjFv
         bZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XjgyqWtUKryGLoesWw9I0+l//tMdFF4+r+hEUQFlUmI=;
        b=NW5hs49w1TzVrr26XGxHEhEf7kO+eQs3ECMJQOBuYuVEIopxxzmLVewxEUjYOgePDz
         PhgttX4PqsUyhG/l7zNaL7gQcKngNRoc+Y6XuLfZ/vOvqLX7j0nHbnRtr9be77ipKek3
         wrCsBTUaqq9AagPqyN96bFNYuFBnF4v4uWYmKDhrCtFbbKE1xrrS6vKmaYs7EwXg8UCP
         7AZOykzX9454UgzIUjpufjXifOa/9P7Wq4SfO1XmuuP3GazMp3G90o0bJemF0LHNpjbQ
         SpxW+sONSVrD8EAGKX8rDxjnG+chxt19Nq8tg3H+EbKSSlup3thkgAFppetWOeiYl4X0
         V5zA==
X-Gm-Message-State: AOAM5330bE/WFesUrPYcXWuKb5zeTYTi/CCago2Y0gSRFRJp2/JkD/0y
        /emNKKaM16QYh75IzLreKUzYog==
X-Google-Smtp-Source: ABdhPJyp2ky65kkD/WmgzHWtjg6zeOPHJK3OFYIi80xtPIsphvQ40zNwPRuGwXKdvHNYA/hR/sHFtA==
X-Received: by 2002:a02:90d0:: with SMTP id c16mr1819109jag.106.1632257210816;
        Tue, 21 Sep 2021 13:46:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v8sm22799ilg.25.2021.09.21.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:46:50 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:46:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/5] repo-settings.c: refactor for clarity, get rid of
 hacks etc.
Message-ID: <YUpEubyYwD+Qe+oE@nand.local>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
 <d852d412-4d6a-505f-2c4c-52e81ab4e3f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d852d412-4d6a-505f-2c4c-52e81ab4e3f4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 11:58:34AM -0400, Derrick Stolee wrote:
> On 9/21/2021 9:12 AM, Ævar Arnfjörð Bjarmason wrote:
> > A hopefully final re-roll addressing Taylor's v3 review, except for
> > the suggestion (that I read as) perhaps retaining the test-only code,
> > which I've decided not to do per
> > http://lore.kernel.org/git/87tuieakms.fsf@evledraar.gmail.com
> >
> > [...]
>
> This version looks good to me.

Likewise. Thanks Ævar for addressing my review.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
