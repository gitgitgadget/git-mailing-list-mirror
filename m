Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F3CC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B4660F58
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhIKQW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhIKQW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:22:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05413C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:21:46 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a1so5406486ilj.6
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+4/dQ6ETuUfgMKQ4PWqJtZdD0CXBNrnxJCXGc6hBaq4=;
        b=ZhyxPK7vkslpOuakhnBOhJo2zCQuyP4Fb13cfq8bHRYBHFReKyySAvBNNiFODBDf6h
         6BzEYafF+u0rbSDd3a0AarakCXziI2LOPXaYpVsTVjUT4ypVwyowBI1fAswxTRIYgisY
         2HtB6ZIdm8MRX0g8zNOy1v1toOQgzB5VccmXEVD5J94lF491DTMJXP+7t+uQ+ppUfF0x
         m2GILRm01vnSs/MOYn3XMRbEyIAbS+c5eXGr9Gopx6cXEqqytw3g7NChBOgWHGwydA/j
         dxjBQo2rAAvUrXweqQALzKKvhxOmsgT2WiokRKjrPEMtNSCYWEo52MgI9/EEbT+xGpRQ
         639Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+4/dQ6ETuUfgMKQ4PWqJtZdD0CXBNrnxJCXGc6hBaq4=;
        b=Eo2N4AGt7FWFNjgKk6n+qKduvzS16DsIPibqHNi9ahQ6EzumcztNDoiuNlLv2hZqiN
         Zm/w4Yga6tVDkReERwmok7YfdJuT7frqoWweUTea0V0mnla3TtuNleoTdJ3Dt2saiSIa
         JCbEk1+rtuxKmh4jXQz3y1VgODA3dG9hfpUESgjI/DKaQD+YwaKsyVH5QbmLNrzMmS4V
         ++cs1OyXRZpjImaj+VAS0ZeC+60BALn3Pql68ymidWBBEtb35U2Flsr+FBpkUB1tthlj
         MRHqDlqu0MQpC/X2nnnfhwQ2QZ41LKPVhFroeH9gLDGVpatacGM1mkN0OBqNGxoCHQCu
         8KHg==
X-Gm-Message-State: AOAM531UrrGFO1a0UTL1dpL09XSlFT8lqL5UKFymo3EaJBKbe46980r4
        vTMzmd4Iyf+fqOgn6bVMU9lRmxtTCb6QZoA3
X-Google-Smtp-Source: ABdhPJwRdI6kVo0OX1bSZPewaIisTKaoZ3B0WyinCEyVyDdcQMqmvhQL0YqJpCC/CQz15+hEaguqpA==
X-Received: by 2002:a92:c56e:: with SMTP id b14mr2266966ilj.6.1631377305433;
        Sat, 11 Sep 2021 09:21:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm1081155ioa.13.2021.09.11.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:21:45 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:21:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/8] midx: expose 'write_midx_file_only()' publicly
Message-ID: <YTzXmAOvGp2OiuYZ@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
 <87a6kja0b2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6kja0b2.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:07:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Sep 10 2021, Taylor Blau wrote:
>
> > -		if (ctx->m && midx_contains_pack(ctx->m, file_name))
> > -			return;
> > +		if (ctx->m) {
> > +			if (midx_contains_pack(ctx->m, file_name))
> > +				return;
> > +		} else if (ctx->to_include) {
> > +			if (!string_list_has_string(ctx->to_include, file_name))
> > +				return;
> > +		}
>
> I think this is equivalent to:
>
> 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
> 			return;
> 		else if (!ctx->m && string_list_has_string(...))
> 			return;

They are equivalent, but it took me a minute to convince myself ;). They
are only equivalent because *either* ctx->m or ctx->to_include is
non-NULL.

So it wouldn't be the case that ctx->m being set and the subsequent
midx_contains_pack() call returning zero would cause us to check the
to_include list, because to_include will be NULL if ctx->m isn't.

Anyway, that makes them equivalent, so I'm happy to clean it up and
decrease the nested-ness.

> > +int write_midx_file_only(const char *object_dir, struct string_list *packs_to_include, const char *preferred_pack_name, unsigned flags);
>
> Let's also line-wrap header changes like in the *.c file.

Sure.

Thanks,
Taylor
