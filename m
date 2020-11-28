Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B0C8302B
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959A8221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zsljWY5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgK1Vto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgK1SIE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 13:08:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC42C025457
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 09:27:59 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so7203227pfg.8
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 09:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+yK2YC4Hi4+5grZfgx+Ji16SYXHpoKENHZcjaOchZeI=;
        b=zsljWY5IWePAXm/q6QHYQQoGo1Kfgw8zJe4jOV/nX5rs+8QjhaMHJqz1ck7bOKVw57
         1vx134HT3W144BliMEx48M5FuNT6dxCQylQ26dLicto5JszkVK7qullgpmFxBF3jajC6
         3n8xeG6vw7wArdBbePydFX681ekwf4v3J3E38xIuDiN2S4youzaj7B8Hq76D6AL1y08D
         kgOieLvxmhHy5jfDws9DVbktbt3/zf+KWPVmEDuxn/RZradJHLctpSRy3OSBdvmiaz1r
         Py4KoEUaDkmlG8MTuqZTyJHDCM9EV/HGo9gC3J5y2rWLsDcDUk97tXXN/iWQHz+mru3l
         1riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+yK2YC4Hi4+5grZfgx+Ji16SYXHpoKENHZcjaOchZeI=;
        b=dzRWRt3ZLYoIFu2R0jHtJ4L/qgMvZZgw+DxJHDSgF6uPUPn2ttqAKtfCAdNt3+yU3g
         2HBaGQldtP+7yWwCRaub8rXG5fy13UHph6paTylra4+tEw+DC/4Q4/A0NHtcYVNbHTNa
         bdlcZPzuluVNcjqa4wwgxVuNtOlPSRBA9fN7FFURpK2u+5XXZo5gEGzUiIqtud1gz07A
         BvZTlUeIIsYlo/V1VBNkhTkFnPXEhjyRPnyY41ZbgufBh7wwuSvQm4jUSD8B+yK+RWb8
         krIglzCifx0jF00oVS8qqtT+ZCWzv8pXom2icAyZxyXrCirIdUvIxNSYasAzaJ5CKQe6
         +YLQ==
X-Gm-Message-State: AOAM533cbmho+YNC3/JBWmLTRPXl/IBHgSoOVCkybqTMkIj9b8ThlKZb
        FoSDzYbt6hjovOXeGCTwb4PGnA==
X-Google-Smtp-Source: ABdhPJzN5akS9iQBl2vznCuPRkbTYwPWtkiZayAiw6nxbSaZWPF9+IDGEbh9itd/HkOnUd38qzKQOA==
X-Received: by 2002:a62:f211:0:b029:18c:28cf:89ff with SMTP id m17-20020a62f2110000b029018c28cf89ffmr11832176pfh.71.1606584478715;
        Sat, 28 Nov 2020 09:27:58 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w18sm11413936pfi.216.2020.11.28.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 09:27:57 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:27:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 10/24] pack-bitmap-write: reimplement bitmap writing
Message-ID: <X8KIm7siBMKR2W5S@nand.local>
References: <c9512067293c082ad3082262e50dfd04f1bc1648.1605649533.git.me@ttaylorr.com>
 <20201125005344.935924-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125005344.935924-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 04:53:44PM -0800, Jonathan Tan wrote:
> > +static void store_selected(struct bb_commit *ent, struct commit *commit)
> > +{
> > +	struct bitmapped_commit *stored = &writer.selected[ent->idx];
> > +	khiter_t hash_pos;
> > +	int hash_ret;
> > +
> > +	/*
> > +	 * the "reuse bitmaps" phase may have stored something here, but
> > +	 * our new algorithm doesn't use it. Drop it.
> > +	 */
> > +	if (stored->bitmap)
> > +		ewah_free(stored->bitmap);
>
> I tried to figure out how the "reuse bitmaps" phase stores things in
> this field, but that led me down a rabbit hole that I didn't pursue.
> But anyway, the new bitmap is correctly generated, so clearing the old
> bitmap is safe (except, possibly, wasting time, but I see that in a
> subsequent patch, existing bitmaps will be reused in a new wawy).

Yep. The existing reuse mechanism is thrown out in a later patch.

> Thanks - overall this looks straightforward.

Thanks for taking a look! Very much appreciated.

Taylor
