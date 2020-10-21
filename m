Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02372C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D9A24196
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="B50i9RSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411415AbgJUUzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411285AbgJUUzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:55:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE7C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:55:41 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s1so1862293qvm.13
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hh7yTY0BECb7AjkZPHlG6UBQBLPC85OcDgVZh70i/kc=;
        b=B50i9RSXJQtX/8EZehItx5+/gqyPjEVYAqnfKwowuzjwKRlpS/eys/Cmc+f6VJkgLS
         CSkWzGQAPDJlw3E81bgDKbHSbJwR1Mf3PEdpiU5FSpYHoTv1Wxbm7pHr4qJR361/JJ0l
         cvXh/L7MmM0r6czzN+hX4yfUG53KBC+ujr6ZtN8+p5jfRO7gV+ZbFJTrhNZClvmNo37Y
         fUI17mdPgM4bzDlmgTO3Lb/wVZ6/pZ1a+OGJP/2cmjvwe9xG5UlWBlvYpPIvKhjP85aM
         C3P0YSzYSL7C3yIMY1j09nBrLLE7RkYOJh2UXFMSWyzCRDqEkDB75Nzfb2vBy/sPMYeP
         GXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hh7yTY0BECb7AjkZPHlG6UBQBLPC85OcDgVZh70i/kc=;
        b=h9ftO1eVeh1mw+pw+XnlG8jEyfzivRsUOnIhn992R9sXzeqRZlKSxyNPZ5bMzviTRz
         pNkrCTltTZcjruID9qMSlhuE4vI2ymkODrVffKbvG6IZ/aYWJJM1LJFd/6AtSWONmPRC
         Vwcm922RgGU1zm3ewWKybPqRVshwGvF5lhj9Ro3NOZ7y++4jO/hxODBtD5kCCNgUP13B
         29V1l6x1+1y28eYLu1Z1fKcg1a42su1P8uHqD+LFfEXOKPELdjg3Au2/jCaTYTqx6BdR
         pOdFxaUi/+sYkNBR7e2wcd6qT+R2p3gzK6iGTroCLXxwxyauThQxS/0ejterkfnNf5UP
         sIOg==
X-Gm-Message-State: AOAM533kAjSBkydaeWiOgjxJXj+0qU30e7+F8JnxkYQFYU8An/D65rDg
        k6G/CHqamvbs2FhqWJ1OlbAwMA==
X-Google-Smtp-Source: ABdhPJzL/WfXxK2HLSBiImSX/fZxv2CsoOPvAnWbHctiD46BjM0fb9O9qFJFFGPugluKMktAAumM1w==
X-Received: by 2002:a0c:b207:: with SMTP id x7mr2840024qvd.39.1603313740462;
        Wed, 21 Oct 2020 13:55:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id h4sm1965118qtq.41.2020.10.21.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:55:39 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:55:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid /
 _invalid
Message-ID: <20201021205537.GB1270359@nand.local>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
 <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 06:04:33PM +0000, Alex Vandiver via GitGitGadget wrote:
> From: Alex Vandiver <alexmv@dropbox.com>
>
> These were inline'd when they were first introduced, presumably as an
> optimization for cases when they were called in tight loops.  This
> complicates using these functions, as untracked_cache_invalidate_path
> is defined in dir.h.
>
> Leave the inline'ing up to the compiler's decision, for ease of use.

Letting the compiler inline these is fine, but...

> diff --git a/fsmonitor.h b/fsmonitor.h
> index 739318ab6d..6249020692 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -49,14 +49,7 @@ void refresh_fsmonitor(struct index_state *istate);
>   * called any time the cache entry has been updated to reflect the
>   * current state of the file on disk.
>   */
> -static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
> -{
> -	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
> -		istate->cache_changed = 1;
> -		ce->ce_flags |= CE_FSMONITOR_VALID;
> -		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
> -	}
> -}
> +extern void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce);
>
>  /*
>   * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
> @@ -65,13 +58,6 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
>   * trigger an lstat() or invalidate the untracked cache for the
>   * corresponding directory
>   */
> -static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
> -{
> -	if (core_fsmonitor) {
> -		ce->ce_flags &= ~CE_FSMONITOR_VALID;
> -		untracked_cache_invalidate_path(istate, ce->name, 1);
> -		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
> -	}
> -}
> +extern void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce);
>
>  #endif

Any reason that these need to be externed explicitly? Note that these
functions are already externed by default since you haven't said
otherwise (and for no other reason than this'd be the only explicitly
externed function in fsmonitor.h).

Thanks,
Taylor
