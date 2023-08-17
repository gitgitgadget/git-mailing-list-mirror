Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72292C5479A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354780AbjHQTz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354837AbjHQTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:55:14 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E24E359B
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:55:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-589addee1c1so1990737b3.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692302111; x=1692906911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFuV/GdwE+4f9gAzNGVaT/rmn46N/VDWahprHW5524c=;
        b=iVfNKtnFCO6ffNBXuS+aykX/hadmzUyXoXmTr8wAm0XV5GeleHgldWP2ZfMlPtsRTA
         wlLZIQ+/vXZs31sV69DZ6jZaUyn2sWLBR3bViz+Xv7wHBiV9PsE5c11ohfkoh1agwqzs
         eQtzDFioQ+HC5g6mx+MB6ZRjbvt8WkexL7y4gI2s77VnXIT0/2CohZ0t3TsJZ/YQll8l
         AgOsDDx8KoH+tzuwPl+rzEjyo/s0X8/aZa/H5oAA3lvmOopwtRISVgZWJBQGQrEAaAfl
         ajkLbtY1paFaD/bC8JdslTkFooV8ImTqC5btn7X3zVnfB0eX5J9VrPTEKPOX94Xs5cyH
         v77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302111; x=1692906911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFuV/GdwE+4f9gAzNGVaT/rmn46N/VDWahprHW5524c=;
        b=gjCsPRJMKIV6fHU8/bpnFrfiCugWKTyCu0P9yK+/GdbddbEuaM5gb69/bV2gZSr2iO
         kgI0HHCEGp1XGXVBRFkpiwoX2F2tYL1Tqh9wcAHxbdTb5iSJvdgRQrDh2n5LJdEq0qtG
         tF+tPkcP61GWTP1l593SHfEH+DWTu7YhfAaZ3c07SAkT1bcj5SKDHiknIdDyq3Hkq8hE
         EHfgl1MGrtttzfTOPA+XOtRpGrblllt8wOZkFxoGnWIefoEIMFUGoATh36rP7E1+76MP
         2bN0u2lgGze3RvG0P62VDVj0lhSFOkLO7a+BffBVa/zxo5yMscZYEp/P/IX7mw97vbPu
         sjXA==
X-Gm-Message-State: AOJu0YwYKCfxQxdofMTWVvxAnPOIGQmumVcs2IayDVUpxH+eXNW0A3aM
        PZrrtXCc915dp/Ls002H4/cNBzd9/lOQcmkgzDssdg==
X-Google-Smtp-Source: AGHT+IEoNqgAxFDIOIB/T1B5jOKMuc292dnhIgdiKjFDOw8r9XD2xjLnvW83auV+I+roSttdViX+dA==
X-Received: by 2002:a81:9e4c:0:b0:573:6cf0:4008 with SMTP id n12-20020a819e4c000000b005736cf04008mr470403ywj.26.1692302110049;
        Thu, 17 Aug 2023 12:55:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t145-20020a0dea97000000b00570253fc3e5sm66748ywe.105.2023.08.17.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 12:55:09 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:55:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/6] bloom: annotate filters with hash version
Message-ID: <ZN57Gsz+wk9n6/Da@nand.local>
References: <e23a956401c5619bd46e8ec9b0e1df958cbcbfec.1691426160.git.me@ttaylorr.com>
 <20230811214651.3326180-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811214651.3326180-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 02:46:51PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > In subsequent commits, we will want to load existing Bloom filters out
> > of a commit-graph, even when the hash version they were computed with
> > does not match the value of `commitGraph.changedPathVersion`.
> >
> > In order to differentiate between the two, add a "filter" field to each
> > Bloom filter.
>
> You mean "version", I think.

Oops, yes -- I'm not sure how my editor tab-completed "version" there,
but oh, well :-).

> > @@ -55,6 +55,7 @@ struct bloom_filter_settings {
> >  struct bloom_filter {
> >  	unsigned char *data;
> >  	size_t len;
> > +	int version;
> >  };
>
> We might want to shrink the sizes of len (we have a changed path limit
> so we know exactly how big Bloom filters can get) and version so that
> this struct doesn't take up more space. But if other reviewers think
> that this is OK, I'm fine with that.

I think that making len a size_t here is an appropriate choice. Even
though the maximum length of a Bloom filter is well below the 2^64-1
threshold, we are often looking at a memory-mapped region here, so
keeping track of it with a size_t / off_t seems reasonable to me.

> Another thing that we might want to track is whether the Bloom filter is
> a reference to an existing buffer (and thus does not need to be freed)
> or a reference to a malloc-ed buffer that we must free. But both before
> and after this patch set, a malloc-ed buffer is never overridden by a
> reference-to-existing-buffer, so we should still be fine for now. (This
> patch set does add a scenario in which a reference-to-existing buffer is
> overridden by a malloc-ed buffer, but that's the only new scenario.)

Yeah, I think there is some opportunity for clean-up here. I'll take a
look...

Thanks,
Taylor
