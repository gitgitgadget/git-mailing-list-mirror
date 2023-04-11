Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D6C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDKVaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKVaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:30:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1210E7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:30:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z9so9740265ybs.9
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681248620; x=1683840620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGrRVS0KXksGfbErSOQr+tjvOqxNLTNAcrBHjWu4Vmw=;
        b=bNWVM7ty8+RLw0g/FZp6LpbWoETXVFTUK5dr/m2qndydTA9nvVxZVM3/OravVUy5Bb
         yLhKRNoWcaPpxA4i/yzXXwjD2KhMb8NVSyzmCXn0WWGayVEVQcbzktluVspoK0BUTZb5
         sgnVQX10GkWb43g2fQfgLFbvgKE/3cu9BavKFLlgU/UsbKnZCNi72tG/nk/mm5j7x1Vl
         YvYt20N4ZzrCQmupMTiEVFJdNcG9Aa0XQzOnJdFyFSRmlzuf14wZu2eN6msMfPDsreoF
         LJcbTIvZ9GjdLIiYJtef44aktCZm8PdARm7EImcpq/5HzQfH6hwqoh9kjy6BdZsEmleJ
         PYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248620; x=1683840620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGrRVS0KXksGfbErSOQr+tjvOqxNLTNAcrBHjWu4Vmw=;
        b=aMLrQY8eYgdRfObpPZb3UJin/H3Pb/JlN2esvIslkv8QsyeDP9zlt0WxEo2yk0rkq1
         ekKB+vsEWmlKQ0/DE7tX0Xv85k3Z5VQVW/hqmQg+1cbTezKyCo4jb3Qw8KQJqO0jgkCf
         jpyDldW1lesqTKynD888QCeQh79D4a+3I2PZPMPuJluTxw21DrJH5jK/kuYsSEhk2+c6
         9ZHIoGDaOiEb/ascJZgf/xfRPUCUE3Cv4EUpvRXNHRI4kRbvuHSZHllo6srncQiW3nVL
         uvFkJQiofraFZ5tmj9EcFm5O53wqzO7ladPJ2dOo/RVzCbq/siGrcorRTyVO9RNnU6Di
         ftbw==
X-Gm-Message-State: AAQBX9cKfUEPa9Yj54CrtbNX//NzVSybVCBTI75jUbxPN4rPE4/o0G8M
        QIhHkadY3pm5ec0CiBvochMwUg==
X-Google-Smtp-Source: AKy350b46I8H0z1LUGq+9sczcu1aO00/o9gl0V71brwnvSR8rNbx3tOqtjdT/qisXZg3DPk1slH5OQ==
X-Received: by 2002:a25:456:0:b0:b8e:d00e:f5eb with SMTP id 83-20020a250456000000b00b8ed00ef5ebmr587650ybe.2.1681248620203;
        Tue, 11 Apr 2023 14:30:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v72-20020a252f4b000000b00b7767ca747csm3864567ybv.25.2023.04.11.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:30:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:30:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-revindex: make `load_pack_revindex` take a
 repository
Message-ID: <ZDXRajRky5XtFenU@nand.local>
References: <cover.1681166596.git.me@ttaylorr.com>
 <be4faf11011efcfab479e5785e6c2bbac95309bd.1681166596.git.me@ttaylorr.com>
 <d81c0fe8-580f-dbab-9904-e0ea8459576c@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d81c0fe8-580f-dbab-9904-e0ea8459576c@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 09:45:21AM -0400, Derrick Stolee wrote:
> On 4/10/2023 6:53 PM, Taylor Blau wrote:
> > In a future commit, we will introduce a `pack.readReverseIndex`
> > configuration, which forces Git to generate the reverse index from
> > scratch instead of loading it from disk.
> >
> > In order to avoid reading this configuration value more than once, we'll
> > use the `repo_settings` struct to lazily load this value.
> >
> > In order to access the `struct repo_settings`, add a repository argument
> > to `load_pack_revindex`, and update all callers to pass the correct
> > instance (in all cases, `the_repository`).
>
> If all callers use the_repository, then we could presumably use
> the_repository within the method directly. However, there are some
> cases where the call chain is less obvious that we have already
> entered something that is "repository scoped".
>
> The patch below applies on top of this one and is the result of
> exploring the two callers within pack-bitmap.c. Since they are
> static, I was able to only modify things within that file, but
> found two callers to _those_ methods that were repository scoped,
> so without making this connection we are losing that scope.
>
> There are other non-static methods in pack-bitmap.c that might
> benefit from wiring a repository pointer through (or adding a
> repository pointer to struct bitmap_index to get it for free),
> but I used the trick of defining a local repository pointer at
> the top of the method to make it easier to change in the future.
>
> Thanks,
> -Stolee

> @@ -581,7 +580,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
>  {
>  	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
>
> -	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
> +	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
>  		return bitmap_git;
>
>  	free_bitmap_index(bitmap_git);

Oops; we are indeed dropping the repository pointer that was given to
prepare_bitmap_git() here. It's unfortunate that we have to work through
so many layers to propagate it back down, but I agree that it's the
right thing to do.

> @@ -590,9 +589,10 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
>
>  struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
>  {
> +	struct repository *r = the_repository;

OK; and here we're using the trick you mentioned in the patch message to
avoid having to propagate this even further out. The rest of the patch
looks sensible to me.

In terms of working this one in, it feels odd to include it as a
separate commit since we know the one immediately prior to it is kind of
broken.

Do you want to squash these together? Something else? Anything is fine
with me here.

Thanks,
Taylor
