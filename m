Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E9C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FC7610F9
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 21:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhDIVVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 17:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhDIVVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 17:21:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162DFC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 14:20:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd23so2119989ejb.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AXA+Yikow8teRqWzh5JII8yxGsvjbvvE2A9UT6zvkng=;
        b=mlbAbfBl/W1nV8fT0GQ1T9fgvOeHbiwQfQ3u+mdc+2ytzsndXqT2MfUlSC7Hl6Wk7N
         6Y2JeeftBq4+KdaSGov8XQwtXBk2nqN17+ExZ0m9ki4cSkeVhRvjvIJO4u/wt49hck9w
         GXED37UJpGKPi6Iv0ZdhhBa4dAjM2XbMguSnFpx+h+hcv0phdNsuZdmLLbiOw9FbAdV4
         R+cb2E91dlA2pGadwYULcI/RwvuGYCRKvL1Ifv5J3Wv38iyNTNMTDrocH1gUQV+hh+iA
         Q4WpUe67ToWf0hECr0ianp1XwtvgFJC1QhO6Y0JQkyvhWXjPpUb0zxpcP22uYXT5vCiW
         hNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AXA+Yikow8teRqWzh5JII8yxGsvjbvvE2A9UT6zvkng=;
        b=j5sHYV8WByi/10FWTBgi/N7e3Wq42QiA6fb8VFNiCg2F6xvrch8nNiSSfG4CBzLBhh
         apD4gq+a+hPIWzbNO1ox89O6TSljKiOt1/bop1y6EhqaI1P3e7Lr1rczlkliSXtcRPds
         xzNT2XsiC1/iiBOh6B9nWXQNWLFMCXWZ6oSJhb+fXlGC+iYpVv8Hw3XfcSvFncdDd5Zo
         LHfXxf2yLi5wiyVtpBwbBiM5x/CeBXJNnXfF6vurls3ayBWJjg0W7i6jJK6D2INum/V5
         VEFjINws47OYU6FSKAfxcvtrSyX/mORUyQaKyHDK/cNfhR7cXSbUKOshU7MtQlYUX8uw
         ObGg==
X-Gm-Message-State: AOAM533BQ5iJdX8zbJ95S+wyhwg24cHqL9kczc1eesjBO6ViWcVQXZhd
        rAAUpPfxnED8bpKeMAcG+MOltr0Rxqo=
X-Google-Smtp-Source: ABdhPJwJsHfnr70OeU4D6VwCumhsx1py2lneueSTIp1ZMqm1lXrdMw7RfgbrgmIA9OlGRBiZEjidrg==
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr18039741ejb.335.1618003246893;
        Fri, 09 Apr 2021 14:20:46 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id g20sm2058035edb.7.2021.04.09.14.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 14:20:46 -0700 (PDT)
Date:   Fri, 9 Apr 2021 23:20:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add missing dependencies of 'config-list.h'
Message-ID: <20210409212044.GD2947267@szeder.dev>
References: <20200416211807.60811-2-emilyshaffer@google.com>
 <20210408212915.3060286-1-szeder.dev@gmail.com>
 <87pmz4ig4o.fsf@evledraar.gmail.com>
 <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 07:40:41PM -0400, Jeff King wrote:
> On Fri, Apr 09, 2021 at 12:08:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > -config-list.h:
> > > +config-list.h: Documentation/*config.txt Documentation/config/*.txt
> > >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
> > >  		>$@+ && mv $@+ $@
> > >  
> > >  command-list.h: generate-cmdlist.sh command-list.txt
> > >  
> > > -command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
> > > +command-list.h: $(wildcard Documentation/git*.txt)
> > >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
> > >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
> > >  		command-list.txt >$@+ && mv $@+ $@
> > 
> > This change makes sense.
> 
> I agree it looks like it's moving in the right direction, but I am
> slightly puzzled by the existing code. Why do we need to use $(wildcard)
> for git*.txt, but not for the others?

We don't need $(wildcard) for git*.txt either, because 'make' expands
wildcards in prerequisites, see e.g.:

  https://www.gnu.org/software/make/manual/html_node/Wildcard-Examples.html


On a related note: all config variables are now listed in
Documentation/config/*.txt; Documentation/*config.txt doesn't contain
any, so that could be removed.

