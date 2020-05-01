Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A9FC47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F764216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XGp9qpW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgEAXKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXKq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 19:10:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB85C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 16:10:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so5201834pgg.4
        for <git@vger.kernel.org>; Fri, 01 May 2020 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sUG28fThwNZWu1+IhTPXdH+rfq4bZLz40PZC69kH9bE=;
        b=XGp9qpW9ipdMD7bV9+dencANK1l2Z5AeCgaOekt/IepAeT0UuN99XlcO9pa8uhYjhn
         OvU1SGMLGuG7MycmSlqYcYiLRoCLDhutFK/CBO5JPJHfEuKseAm+hJjlMYcLcV9+Mdbs
         L+GJ7da7RkW6fPwXcx3T14OFeJXulzI1euWy2MO5RwPtGy9+MXzV26EeDEPmuDsmrKuF
         w1PVpgSl7c+JFRkb5LsBATvkEDdboRn2gBgoD8QqXFwDRKOt7UwJsYY3MbWNppzuVBPD
         GT4ZylFVQgHJWvVmGTSdozlxMZ1DKqxAzAz57PHAqQQxqdPCG6zL3u2ErLF48GH8lMKz
         ENiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sUG28fThwNZWu1+IhTPXdH+rfq4bZLz40PZC69kH9bE=;
        b=sF9ZHlc+vRVbypOvMSZQbr8pOED0B3ytqur1Nyg7/R6IeFtV7wCkX26hdC/3/p8AEy
         IoxuDW2meO+l2gbrklbaOHeKiIU93oDh95S810dBtKhpbxYVd8J0MYoQvxGcaQrdCyo6
         i/RAYBmhLlxiMxn2hy/EvFYogDdFLFTsPylXvW8eXGpvcDMznytdxneWGwR1x4dz/qNZ
         k+Iz7LAHWoQuG6WUC6I7eV3TuDM3jtQC8aP05CtGhvtUcFz9MR25j0LMK3mInRDjbYAF
         gOYsqVvMAX/vAIVvUxhPXdohMiYxt+d2Gl0GSE5YZDIKU3rVTAGvSsMwxH4HlcwlVx5w
         p6GQ==
X-Gm-Message-State: AGi0PuaCLTdF0DMybTUp7lhP+uaMMdJDJEbvdyGR1Ixcj2heiTA1CHKz
        qQY936QLCGow6tOzzcptEGjdE6dsnxE8rKNr
X-Google-Smtp-Source: APiQypJXFVkKcYdw/NAMVWC+zU8gNRl7jeX1rXdhp/DXuANWtKJfGQtO4wR2e4mnzx5FMWDPbkYt3Q==
X-Received: by 2002:a65:58c4:: with SMTP id e4mr6526999pgu.61.1588374643966;
        Fri, 01 May 2020 16:10:43 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id fu12sm641989pjb.20.2020.05.01.16.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:10:43 -0700 (PDT)
Date:   Fri, 1 May 2020 17:10:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 05/12] bloom: parse commit before computing filters
Message-ID: <20200501231042.GB46422@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <ef4c08e401bd57dddf327910032220632a36885f.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef4c08e401bd57dddf327910032220632a36885f.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:22PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When computing changed-path Bloom filters for a commit, we need to
> know if the commit has a parent or not. If the commit is not parsed,
> then its parent pointer will be NULL.
>
> As far as I can tell, the only opportunity to reach this code
> without parsing the commit is inside "test-tool bloom
> get_filter_for_commit" but it is best to be safe.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/bloom.c b/bloom.c
> index eb08571c628..c3b81b1a38a 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -206,6 +206,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  	diffopt.max_changes = max_changes;
>  	diff_setup_done(&diffopt);
>
> +	/* ensure commit is parsed so we have parent information */

I don't think that this comment is critical to the change, since
familiar readers will know why this 'parse_commit' call is here, but I
don't really mind either way...

> +	parse_commit(c);
> +

OK. I figure that we could force the callers to parse these commits, but
I think that this approach makes more sense. This should be a no-op for
already-parsed commits, which means we'll get out of this call pretty
quickly.

The benefit there, of course, would be that we don't have to worry about
some callers forgetting to make sure that they are passing
already-parsed commits, and that the trade-off we make to allow such a
thing is pretty cheap, relatively speaking.

>  	if (c->parents)
>  		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
>  	else
> --
> gitgitgadget

Makes sense, thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
