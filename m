Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E6C63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 17:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC29861417
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhGVRRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGVRRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 13:17:35 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B6BC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 10:58:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id u7so7365159ion.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1o/AXGuyrUb1zYym9Ii8cCHu7F+alGLbgh0J3AK93L8=;
        b=ZZvsg9cYpgINkpeJpgSo30Bj13UcTCzi1Oiv3Z99clY4FfPA/4CQe33ZGOn7Ud1dGa
         30f1eNd8jkDhr2c8Ynaae+IvLt9XesuNehNJSOA/AGsiZ5DTHjtobOR4CHeE2gKwDnmQ
         xcabTHPiGfmjqHUhywATuXJCXLo8/zZk5QdYKPCqVX1v/Dt6pzdamWY70NYeAOVmV54Y
         uEp8K2nX44PIDTrQfHC3EJ+JVvWpzHoRcEczZqCDnAH7jxcu8+2Rw0xBjKVOCxwObe4C
         9ofX2pSk3pZoNEc+Mj1qWKf0YpoCa/njxKzWdY6Wba0+CNUiYNjq5E/y2ve1fY2pJVTq
         /X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1o/AXGuyrUb1zYym9Ii8cCHu7F+alGLbgh0J3AK93L8=;
        b=B/bD90vpqhKHYXU7lODmt6FUKz/A3t8HaOHdDtFvygR0xTN3WaUed4HTP8vtNING/f
         ojnsb3qksoxC6hshTFbsif0/TZlvmaRKpD/gmiwI/TTtQ3V7ktfnilaxbxVhvJDKxboH
         uONsM1WYAlyWTFUnpGHGW6Y2FZp5y39K4LwCNmMdF1VfOJ1f+EViDd/6DokEA/OWdf+o
         Xznr5cRr6FGfkYEmUF6NX4sbkRjjFkDsXXJbfEpdd2JPCgNimUheIZGoE8D1gOOx2ptr
         ng1IoW4iP0jqK7OzIT05ypE+HYAXs7AWHjj4wK0YPfhJJ2xxaC2KJXhkG9b3fiAGVhes
         kYWA==
X-Gm-Message-State: AOAM532vvXFpBcJdBaPIyGGxKlSlY3zi2aHcQt1nwteQEIDZZp7wEgfb
        pQ9k31NBP7DOyBJVbXFgrFcoRw==
X-Google-Smtp-Source: ABdhPJyaas9/15no1xgpgHt6Oo1n39S1qPNSuopay5m7+wwsr+SJ4xFwFjLlugr1L7Ot9G1Fwu29yg==
X-Received: by 2002:a05:6638:39cd:: with SMTP id o13mr686333jav.12.1626976689655;
        Thu, 22 Jul 2021 10:58:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z10sm2567869iln.8.2021.07.22.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:58:09 -0700 (PDT)
Date:   Thu, 22 Jul 2021 13:58:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/5] Makefile: the "cscope" target always creates a
 "cscope.out"
Message-ID: <YPmxsCatUIByQnig@nand.local>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
 <patch-4.5-f8d151f1f6a-20210721T231900Z-avarab@gmail.com>
 <xmqqk0li9tks.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0li9tks.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 09:55:31AM -0700, Junio C Hamano wrote:
> I know we currently care only about cscope.out and it is perfectly
> fine to make the phony cscope depend on cscope.out only, but I'd
> feel safer to keep the exclude patterns and $(RM) clean rule to
> catch them.

I agree. I wondered about whether this patch could just get dropped
entirely, since after removing the changes in .gitignore and the "clean"
rule, the only change left is:

> >  cscope.out: $(FOUND_SOURCE_FILES)
> > -	$(QUIET_GEN)$(RM) cscope* && \
> > -	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
> > +	$(QUIET_GEN)$(RM) cscope.out && \
> > +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b

But that alone is a good change in my mind at least. Then it's clear
that that target is responsible for generating cscope.out and nothing
else.

So I'd be in favor of rewording the patch message and only retaining
this hunk (and dropping the other two).

Thanks,
Taylor
