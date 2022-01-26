Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DBCC433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiAZWuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiAZWuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:50:51 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3601C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:50:51 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d3so969525ilr.10
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWhFDX8pjeZ7PeQ1pZHX64N+yVRSDt/Cb2maTgmAUjc=;
        b=WCmU98KdPXd3YMSDPxbYIwaHQcgYwXw8DYVt8PbMvcQjAq09Upv9D+L1qRzWPliuaa
         6bDZ57CnutSJiXrPM+iLtVu8M1L948Qn6axBZooCXE0W2YicF4+MWyLLA3h0qZY19JEn
         v+lItR0+bJtB/upSi/h/zHBTPiIe46BUqN4nIH6WT/NX/UStH2A7bD9UbvIvfxuv0tzz
         WilNfeBE0I8JwQDZKaAPiWSPVtlYlLd0zvRUWo7fpnDbrO7BAKgiV3D9d6I/AvmrejRq
         vCSdKBM3YKzi11mFPZLQv3w+FynqISG1MfCCTg4fY0qxbTTXnyEwCj++xxRYd9RAbUnq
         9zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWhFDX8pjeZ7PeQ1pZHX64N+yVRSDt/Cb2maTgmAUjc=;
        b=YyyVT2c1oGYffbF1qFGomzLILByjFOpz2bh0NHb829pzXZfaZHnwPCc6zfuYOymg7Q
         nsM9TYcIy4Lx72xXrp8AXej3yCB4wkJ/0cAoCGovrphYv5UgFVbVKY4oFwK3XXhl5iOd
         EZYFdHMYSNSH9aKVUaacf7EEXsQwP7nPf+J0Z52GUv5sfhLSfukqjfPzGDclYCesJB2W
         BEqrlEa19MVEsJvG+c9O//mjtCD3IkUVxLzVUIjwrgtMAm/JzP7EOmjwL1FspB6qzvk3
         NoSWT/vtiskncVqTUHhNned0R4+sX9ROaGxOrZTJZHQr/DFbwfs+04/V+epHeCeP/WkT
         PVpA==
X-Gm-Message-State: AOAM5307vnPpfzlxBG20fhupNveVW+R4qvTdpnYJY/iLf3t56/5CQBLk
        B8IGbnnG3BlRdH2kctW1H7HWPJO3ZnhTMw==
X-Google-Smtp-Source: ABdhPJxR2fR1SB7Kueqz2WRbP5VCthP0aUGkOlwT+wzMIsh+Czrlt1fJBDsqTmBAl7a4wIHIAFBxPA==
X-Received: by 2002:a05:6e02:b23:: with SMTP id e3mr899472ilu.32.1643237451263;
        Wed, 26 Jan 2022 14:50:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l13sm7635776ilh.46.2022.01.26.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:50:51 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:50:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 4/5] scalar: teach `diagnose` to gather loose objects
 information
Message-ID: <YfHQSrdkieNuBEXT@nand.local>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 08:41:46AM +0000, Matthew John Cheetham via GitGitGadget wrote:
> +	while ((e = readdir(dir)) != NULL)
> +		if (!is_dot_or_dotdot(e->d_name) &&
> +		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
> +		    !hex_to_bytes(&c, e->d_name, 1)) {

What is this call to hex_to_bytes() for? I assume it's checking to make
sure the directory we're looking at is one of the shards of loose
objects.

Similar to my suggestion on the previous patch, I think that we could
get rid of this function entirely and replace it with a call to
for_each_loose_file_in_objdir().

We'll pay a little bit of extra cost to parse out each loose object's
OID, but it should be negligible since we're not actually opening up
each object.

> diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
> index b1745851e31..f2ec156d819 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -77,6 +77,8 @@ test_expect_success UNZIP 'scalar diagnose' '
>  	unzip -p "$zip_path" diagnostics.log >out &&
>  	test_file_not_empty out &&
>  	unzip -p "$zip_path" packs-local.txt >out &&
> +	test_file_not_empty out &&

A more comprehensive test (here, and in the earlier instances, too)
might be useful beyond just "does this file exist in the archive".

Constructing an example repository where the number of loose objects is
known ahead of time, and then finding that number in the output of
objects-local.txt might be worthwhile to give us some extra confidence
that this is working as intended.

> +	unzip -p "$zip_path" objects-local.txt >out &&
>  	test_file_not_empty out
>  '

Thanks,
Taylor
