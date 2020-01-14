Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F512C33CB6
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2392B24673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="T4Rbbjo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgANTaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:30:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40921 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:30:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so5621675plr.7
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytcJrYuLQ66/Rm4kHppwgvukKRctOxCfRVO72WR/0JE=;
        b=T4Rbbjo1zJjy+uhF8tRhR8Dx2rHUA4acBjeLll9Lpjz3z9laosyLzC+tN8H0YKwDaY
         9A/JlcbQ4uEplwcaUZHj/YVMvBbmWb0xZQze9AeNdBbZlnTuTXja+KC4GSytC5y9cGzB
         komgXB7qG4LcH2K5V+0f82roUJK80SkDYo9kctGfOKyM1diunRdIqurmCpDtUSBwaEJz
         Lu2otQ3isOiLsz8+l90Krr3xawKbJ6/5MkMXoDxmI6hJzhhERlClJihAiJ1GhJvPP86L
         11Y6CQq/mgi3FWa4GyKB7Kw4VR+iJY6KLPxUxBzsHebL31mNmSDivaCXSz3gCyndAbk8
         AHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytcJrYuLQ66/Rm4kHppwgvukKRctOxCfRVO72WR/0JE=;
        b=SfKGCNTJpUo7oZZEC9kAdsfWoYLnsacXWaOGKOJYCA3vgswrm+xK+oFwjsaft+PsoX
         R5A71u1EbZD9k5nPCtobQhpMVuq31QHEmwLss3Ei+P8F70ShdKgkyeAQMQnKsF36IEzZ
         Xt2J2ASEFwnouVxTTJaQcVm1uwpX9GNl5PiAOfFkXswDVVzvxbojnoREPCE2/2ShMr8W
         NkPUSN+QntFprZ+QFGJr8TSTxA8c0pjEN3saPKFfVPSCyPSi3M27Gjq36NV2CYy7dMaN
         37QHRnk2VEJibzfDe3o0RPWC+41bvoFXNLeYrjvtLst1aAqhkGRgvsyWytK7wuN/os5L
         qWKw==
X-Gm-Message-State: APjAAAWyionRZdD1NiqvWofxhqgdCrhtifr99jxHIo/fWtTx+8+ozyg0
        1XtK/TOtK+eYlpnGq3MzmS5ItQ==
X-Google-Smtp-Source: APXvYqydgqGFyII/2E0z2/g6uaZulRzbQ6J1SCugvaUNdAO4SN7Gcyy9bcYhhf65P3rjy9QhrLWMMw==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr7637803plo.52.1579030233578;
        Tue, 14 Jan 2020 11:30:33 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:142b:64f6:3f95:951f])
        by smtp.gmail.com with ESMTPSA id c19sm20084772pfc.144.2020.01.14.11.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:30:33 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:30:32 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/8] clone: fix --sparse option with URLs
Message-ID: <20200114193032.GA8593@syl.local>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <3ef8e021a586bd986e5a2a7e1bc956daf2d874d2.1579029963.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ef8e021a586bd986e5a2a7e1bc956daf2d874d2.1579029963.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, Jan 14, 2020 at 07:25:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The --sparse option was added to the clone builtin in d89f09c (clone:
> add --sparse mode, 2019-11-21) and was tested with a local path clone
> in t1091-sparse-checkout-builtin.sh. However, due to a difference in
> how local paths are handled versus URLs, this mechanism does not work
> with URLs.

As we discussed off-list, both of us (as well as Peff) were able to
reproduce this issue. I think that this paragraph is a good description
of what's going on heee.

> Modify the test to use a "file://" URL, which would output this error
> before the code change:
>
>   Cloning into 'clone'...
>   fatal: cannot change to 'file://.../repo': No such file or directory
>   error: failed to initialize sparse-checkout

Nice, this should give us confidence that there won't be a regression
here in the future. I don't think that the explanation is complicated
enough for a single commit which introduced an expected failure, so
grouping it all together in this patch seems good to me.

> These errors are due to using a "-C <path>" option to call 'git -C
> <path> sparse-checkout init' but the URL is being given instead of
> the target directory.
>
> Update that target directory to evaluate this correctly. I have also
> manually tested that https:// URLs are handled correctly as well.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/clone.c                    | 2 +-
>  t/t1091-sparse-checkout-builtin.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 4348d962c9..2caefc44fb 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1130,7 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (option_required_reference.nr || option_optional_reference.nr)
>  		setup_reference();
>
> -	if (option_sparse_checkout && git_sparse_checkout_init(repo))
> +	if (option_sparse_checkout && git_sparse_checkout_init(dir))

I agree that 'dir' is the right thing to use here. It's the string we
read from to print "Cloning into ...", which always displays the
directory relative to the cwd. Looking at the implementation in
'git_sparse_checkout_init', this matches my understanding, too.

>  		return 1;
>
>  	remote = remote_get(option_origin);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 37365dc668..58d9c69163 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -90,7 +90,7 @@ test_expect_success 'init with existing sparse-checkout' '
>  '
>
>  test_expect_success 'clone --sparse' '
> -	git clone --sparse repo clone &&
> +	git clone --sparse "file://$(pwd)/repo" clone &&
>  	git -C clone sparse-checkout list >actual &&
>  	cat >expect <<-\EOF &&
>  	/*
> --
> gitgitgadget

This all looks good to me.

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
