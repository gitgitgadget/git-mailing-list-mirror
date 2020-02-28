Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C9DC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 19:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12334246A3
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 19:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol1QPAMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1T6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:58:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36884 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1T6J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 14:58:09 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so1726693pjb.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 11:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sPjV5fpthkrJY/+hdnvdS8/FhUDiNsxP/YmXLdz0rwU=;
        b=ol1QPAMqunRagQT5AjVjnaFTbUPwuprhJr5d0G9Nx2YZqv2Ms8MGZ9uMpQxTKMUtAW
         GH9VtxTE6agp0jFIoWLNGwuEGWlOtgRTwlmBnuxvrSToZDrHrZ/NsOKBiWaGJrlEQw5L
         EbxeJe4Nxdsi8Iy5EtbEr9QHmpdtv+BH5RY7uMKz/n/Si9yQJ+QyPjAGfc/bfyzl3Ao9
         L/nTejG9j/Pojyk79bPppDH7vm4I/x/2Ipu8IHH8KmgL3csL0c1nbouvim590fz/RU4L
         j5X2SaTGz0YkA7jn8p+8Drn4/r8rahyGDmg0yF76n8SBSthk9IrZ95WFeaoRB+kngwDX
         s6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPjV5fpthkrJY/+hdnvdS8/FhUDiNsxP/YmXLdz0rwU=;
        b=hVqeGWSpGxBDR2qy15YHq3OA8X+j15GlVdt72NIn3zD43Rky3CS9iau3sEF9h1gHne
         4wMsKCt/E6GcCi24zq8wGPNtcRjef2AjYQCpgQCnA3RGyFrotb6ZIL2v2L4ozMEIwGDL
         cx9r/o6RVuGXB840tK5y5aVnQYS40a8wsXrzN5Y3m5EMZM+UFiUGb0Rn77JmrSGN4HOh
         dPSSJusvkHi0zr5tRtcIhOEE2xgWOw0MHC2SUklcl6IolgaV6QrV/J2wZnEFrMOF212A
         ejRvbnXcJLN7mJDMZ0jVVpoj5SOvUdQ1qwpFYNnmJLnPzCaPWVwrzQvLXfdzTtvWY46S
         hnOw==
X-Gm-Message-State: APjAAAVfLBtM97gejsbLRyA7BzO9aI7eE6dyPJ05rRqZlRbwAuUDnotL
        5BsXDOcNWY+m8SyiUD0VgYk=
X-Google-Smtp-Source: APXvYqzEGu4PPRpip2/sg06WdSr1hJ/t456S/Y0M9CTwf/lzqGRgBGQ/Q1+dI+DqCLqTiwWQgHGwQA==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr6512221pjp.102.1582919888683;
        Fri, 28 Feb 2020 11:58:08 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w128sm11244332pgb.55.2020.02.28.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 11:58:07 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:58:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH v2] prefix_path: show gitdir when arg is outside repo
Message-ID: <20200228195805.GA190372@google.com>
References: <20200214232933.243520-1-emilyshaffer@google.com>
 <20200215010013.190528-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215010013.190528-1-emilyshaffer@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> When developing a script, it can be painful to understand why Git thinks
> something is outside the current repo, if the current repo isn't what
> the user thinks it is. Since this can be tricky to diagnose, especially
> in cases like submodules or nested worktrees, let's give the user a hint
> about which repository is offended about that path.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  pathspec.c | 3 ++-
>  setup.c    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 128f27fcb7..166d255642 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -439,7 +439,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>  		match = prefix_path_gently(prefix, prefixlen,
>  					   &prefixlen, copyfrom);
>  		if (!match)
> -			die(_("%s: '%s' is outside repository"), elt, copyfrom);
> +			die(_("%s: '%s' is outside repository at '%s'"), elt,
> +			    copyfrom, absolute_path(get_git_work_tree()));

This is producing segfaults when run by magit.  Reproduction recipe:

	cd .git
	git ls-files ..

Expected result:

	fatal: ..: '..' is outside repository

Actual result:

	Segmentation fault

Does this need an extra case to handle when there is no work tree?

Thanks,
Jonathan

>  	}
>  
>  	item->match = match;
> diff --git a/setup.c b/setup.c
> index 12228c0d9c..4ea7a0b081 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -121,7 +121,8 @@ char *prefix_path(const char *prefix, int len, const char *path)
>  {
>  	char *r = prefix_path_gently(prefix, len, NULL, path);
>  	if (!r)
> -		die(_("'%s' is outside repository"), path);
> +		die(_("'%s' is outside repository at '%s'"), path,
> +		    absolute_path(get_git_work_tree()));
>  	return r;
>  }
>  
