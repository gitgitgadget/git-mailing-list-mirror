Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB8C433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1264E20709
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhA0D7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhA0C4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 21:56:07 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303CCC061224
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:47:23 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k193so485224qke.6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xzqVOqLL9y7+ltoByBxV14kgqGTd8ZWXOWVgVyNHxyI=;
        b=TMK9cXIZll/1lXNmF1kwoCGSoHmFtkqfOYPeaCNAJPndIdGxoelZ+K7lbIs0vMUd0Y
         vNQGpmHhf0AxvXLM0i3qunzO/PkYR8xrefFwLMEr1qN6I1JGuxtEQoJJQiFNSaqDXzCq
         eBAU7rgJtv5XtVAoibYTwwTQvLNi1G84r2w42CFMxt47lMxAcgHxzVRrYVs1nA+2Ymb6
         GdUMif1xQl+G3zVQ2j/aaQu0BvG5bqWayU5sca5CHmH+gWZNJL3RIFxfLW5v7zCJo9Y2
         FIew0tCqt29vQ4G8udb7Eom8akircGfSP0VmULgmVHfqEbJW737BQ9jYrUrmMs3YX7KO
         /ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xzqVOqLL9y7+ltoByBxV14kgqGTd8ZWXOWVgVyNHxyI=;
        b=GzRkIGbg6sOIU4yPJD1v684ee8DB/LK+OGKWAFwdV16ERmml9SD9gxTe0vIjI7ZePP
         Y2eg1brcF0DNKYoVRIRbw6Q4VpfWX+KKLgGBerkf/9jft1Libid5Ycl4iNskxZuBgz4r
         n1AwWTMCiXz4uz4zLbgLDDrt8zNjIkqgN0sSJLvzUbKc9MRcC6ei9VDJ/mBXyJ9yEsWF
         c4k34a8HbX/Fo9pv8qHVTTnm4EENu063d0SpMHV92ZwadKj+R57ZqkjkYOGfNEFsXmwS
         YKCUp7l4NxWOwGWUcLnGSTpJJkR7s1845x9lhAsYgc10R0lpetwKoE1nInHx4nksMCus
         8wUA==
X-Gm-Message-State: AOAM531fRpHdNJDhFxghzCdgoIsGrdboEczaCeeBnb4d/z945eRobJYQ
        tr52RdupQyv3RjZZe6eieWzV5g==
X-Google-Smtp-Source: ABdhPJzBdoa8r7SEIFqiklj+B1AoZXy2uFzFBJzWgRXRagWDRTTc36VnwlnOd7GmboDYP8vuFrktkw==
X-Received: by 2002:a37:654:: with SMTP id 81mr6659859qkg.340.1611715642459;
        Tue, 26 Jan 2021 18:47:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id t17sm473917qtq.57.2021.01.26.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:47:21 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:47:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/17] commit-graph: use chunk-format write API
Message-ID: <YBDUOGLkiQ7ocl+D@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <a3d6177a352643721fdc07512629b48d1213157a.1611676886.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3d6177a352643721fdc07512629b48d1213157a.1611676886.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 04:01:12PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph write logic is ready to make use of the chunk-format
> write API. Each chunk write method is already in the correct prototype.
> We only need to use the 'struct chunkfile' pointer and the correct API
> calls.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Nicely done. The majority of this patch was remarkably easy to read,
which I attribute to you doing the necessary prep work to make the
callbacks usable by the new API. Thank you.

> @@ -1941,6 +1896,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>
>  	close_commit_graph(ctx->r->objects);
>  	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
> +	free_chunkfile(cf);

Since chunkfiles are so tightly coupled to hashfiles (i.e., you can only
"construct" a chunkfile given a 'struct hashfile*'), I wonder whether
this should be:

    finalize_chunkfile(cf, ...)

instead. It seems kind of weird to give up ownership of 'f' down to the
chunkfile API only to reach down into it again.

I could even buy that you'd always want to finalize and free a chunkfile
at the same time, and so perhaps the calls could be combined, but that
may be a step too far.

Thanks,
Taylor
