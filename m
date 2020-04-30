Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEE4C83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729B92082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sG26/NTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD3A7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3A7t (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 20:59:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D6C035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:59:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s8so1942092pgq.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NFOX97bXBUfZegw6CW9WLu6I/bFcDJyoVGzDQcdaPWk=;
        b=sG26/NTJuaojq3TI9kMfQggn6mmiScvtiXJHkEr8oAKhHIdXmOvB3fBMlCIxltJfvb
         31AMopyJXJOr4IwKR9yUUWyhxQhWud3jUHcRWkoDC7YulLWLJY9ZnV9uQcJ4nAwc7MAP
         YZWqjL38Ynx4HomZzadgCFc224TFAupOqFjeoFs14M6/1XX6Khn1wXuGuyglF7SQJ/We
         VDQLvC1CbEZv8as9iXFKWBZI4xfGIjTfpNbascHjCgWabeFNJ/w5+hP1aFwXBqX4ec1L
         xUpkZcynaYebMFKs+QmUcI9OqvG1pwvm1l3huJLn0pIHmxM4RNqLqWBj4BhWOUYcaNsX
         kBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NFOX97bXBUfZegw6CW9WLu6I/bFcDJyoVGzDQcdaPWk=;
        b=a204oZs2ppMXj7aumSPuZF4I2bwknTNPMVdMuE915h8jqEdOhA6qupCrgbZRVzXLgw
         r+ahOp7u/c3BOLEPBpG4P2wkUP3f8rQDDNe4EVtySZFflheJnRqXTXKmgfCd5J5wSAsI
         qgsoGLUGUDCjtYKFibQy9NRG6brIrhDxDlLIIKgtFNn46f0ftLx17xVjPFsFd9kcf348
         yRxb4y0SOWBkxJkS1NwY0tsL2RFsT5+3gC8U3d2SCbHNtNBVreU3ZxjsYPR8+bZFIfbu
         7abltVJ6DbiJMGJO+fBgRU8evrpxGU2okbXs4hRPQG6E6J3A9FBei+ZwU5ITJWXZQZOg
         uXMQ==
X-Gm-Message-State: AGi0PuaRIHk3phFQRU4MXPr4tCRkbw11a2A6xLs/ileT47hlPlZkkvM4
        3lyr8F0LTCMxV3XnOQqx/eK12Q==
X-Google-Smtp-Source: APiQypLGzNUEi8v4JTofXmQHYvLs4q0mM1EHOqYe3N6KXYMo7ts2uXLlm+SZO2KcrbUuhnF3E1pLYw==
X-Received: by 2002:a63:43c3:: with SMTP id q186mr827729pga.411.1588208387476;
        Wed, 29 Apr 2020 17:59:47 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 67sm2029814pfx.108.2020.04.29.17.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 17:59:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 18:59:45 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 2/5] shallow: extract a header file for shallow-related
 functions
Message-ID: <20200430005945.GA23090@syl.local>
References: <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
 <20200430002154.231855-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430002154.231855-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, Apr 29, 2020 at 05:21:54PM -0700, Jonathan Tan wrote:
> First of all, I couldn't apply these patches neither on latest master
> (86ab15cb15 ("The fourth batch", 2020-04-28)) nor on its 2 immediate
> ancestors - what is the base of these patches? (Or is there something
> wrong with my workflow?)

Yes, I should have mentioned in the cover letter that this is based on
'tb/reset-shallow' which is should be part of Junio's next push to
master. I didn't mention it because I figured that it would be on master
by the time anyone wanted to look at these patches ;).

Anyhow, apologies. It should apply cleanly on any branch that has
'tb/reset-shallow' already.

> I'll review based on the patches themselves, but what I've seen looks
> good so far.
>
> > diff --git a/builtin.h b/builtin.h
> > index 2b25a80cde..2e701a023c 100644
> > --- a/builtin.h
> > +++ b/builtin.h
> > @@ -5,6 +5,7 @@
> >  #include "strbuf.h"
> >  #include "cache.h"
> >  #include "commit.h"
> > +#include "shallow.h"
>
> It's a pity that builtin.h has to be modified in this way, but I see
> that it's necessary - a few files that include builtin.h (at least git.c
> and builtin/bisect--helper.c) assume that they have shallow function
> access through this header.

Yeah :/.

> Once I manage to apply these patches myself, I'll verify with
> --color-moved that the lines moved as I expect, but otherwise patch 1
> and 2 look good.

Thanks.

Thanks,
Taylor
