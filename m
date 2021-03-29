Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88A6C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E8F6198F
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC2Var (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhC2Vad (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:30:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1CC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:30:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q26so13944512qkm.6
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F5W4yuzcvwH9xQxP7SxMRastaaucdexjHgqHYaz5ukw=;
        b=gTBvZSTE6k2ubQTOUmifDaWVjoHrdfa6xG5ap4yLjDdOzMXjyuIDe9SWU2Wh5823wP
         PKruty0JBJN7maAfeZwaPZcv1M9z655KiVHl4rqS20vfqodZgbMZeUZuSISQp0f96Sqi
         1/tTO26IIUevrgIFBDqmL2aztXAVGHngJzu6ZrX4tJdTMcmosTkGJRvWJ9F3lmjMuK9S
         sL0uwRL7rt0B1d7/46emo4sevfka7V1+mafOjGLLe/p6YYiobDnBtA0F8531dlA4vBuQ
         llQQvFWX32iUP7YBywI5BQOyiMUDjRcQ/M91ZIUZjxTAvrweplIvurswiQWQA4i7YGic
         zTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F5W4yuzcvwH9xQxP7SxMRastaaucdexjHgqHYaz5ukw=;
        b=tKTz3s/XClGdeCqtzQLWhkBzmB4wFwX0ZNmKprNKf30OSIvON8GeaapxLtCx3DcxCz
         diAJUdfpeXnDFP76OhYlJWOnUtHZCPgdgINM4Tw2EAXrxabwbqdxU4Dg4NTx89YkMyDT
         qTJvAe1ZUI7r0FpEWmbCFQGZzUKNNcRCZ6rnT10kt41AT1fAdkA+1dYOgJ+YSiYf1Mm4
         jylV9hofBQur+9wE7Hd59ByvvTa5m+dgbHfJ7Lg5YiWSjleFAc4VtyQe6LzqTgb7OOuj
         AFYFSiLsT/nyoWn5hhVEO3y6eBzSFVK53dUDT4/gVBYEC3EheSha+ITJJgEvzziUe6lr
         RVpw==
X-Gm-Message-State: AOAM530CprDXxjg+Xcn87FYKPutgGbUSvyGLuhTkYpgTzjQBaNrV7pNR
        K66jz/0fCZvgb7VIuTH2RbAHUg==
X-Google-Smtp-Source: ABdhPJyzAQnPyzXZ66zM2PHUz4x863S/DHK+akmhdFLiumF0H7GMBsqK2AlYlpDQrFA2csvac9c0eA==
X-Received: by 2002:a37:660e:: with SMTP id a14mr26331502qkc.35.1617053431870;
        Mon, 29 Mar 2021 14:30:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id g4sm11965546qtg.86.2021.03.29.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:30:31 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:30:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 15/16] pack-revindex: write multi-pack reverse indexes
Message-ID: <YGJG9sALir6FuW44@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <fa3acb5d5af3aab46dd2a9703e4da03928625346.1615482270.git.me@ttaylorr.com>
 <YGHNwin9zcrP00dI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGHNwin9zcrP00dI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 08:53:22AM -0400, Jeff King wrote:
> On Thu, Mar 11, 2021 at 12:05:38PM -0500, Taylor Blau wrote:
>
> > Implement the writing half of multi-pack reverse indexes. This is
> > nothing more than the format describe a few patches ago, with a new set
> > of helper functions that will be used to clear out stale .rev files
> > corresponding to old MIDXs.
>
> Looks good.
>
> > +struct clear_midx_data {
> > +	char *keep;
> > +	const char *ext;
> > +};
> > +
> > +static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
> > +				const char *file_name, void *_data)
>
> This will clean up _any_ stale midx .rev file. So even if we miss one
> when writing a new midx (due to a bug, race, power loss, etc), we'll
> catch it later.
>
> We _might_ want to also teach various tempfile-cleanup code run by gc to
> likewise look for unattached midx .rev files, but I don't think we
> necessarily have to do it now.

Agreed there on both counts.

> >  void clear_midx_file(struct repository *r)
> >  {
> >  	char *midx = get_midx_filename(r->objects->odb->path);
> > @@ -1049,6 +1162,8 @@ void clear_midx_file(struct repository *r)
> >  	if (remove_path(midx))
> >  		die(_("failed to clear multi-pack-index at %s"), midx);
> >
> > +	clear_midx_files_ext(r, ".rev", NULL);
> > +
> >  	free(midx);
>
> The sole caller now doesn't pass the "keep" hash, so we'd always delete
> all of them. I guess we'll see that change once somebody starts actually
> writing them.

That's right. I hope that the benefits of splitting the MIDX bitmaps
topic into two series has generally outweighed the drawbacks, but in
instances like these it can be kind of annoying.

Thanks,
Taylor
