Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC92BC47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E5F216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="E1VXA2vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAWTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgEAWTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:19:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EEFC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:19:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so2173227pfg.2
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZRLUaYHUgmCXdwwVXNZ6zyGkI+A7UWnvD1VH+mBl8x0=;
        b=E1VXA2vjGsqhMC30NtnudRW2NvYEsWfEnoigX3QxAJ6eYRYuaLit09TTvsP5ZLZpJK
         fZb8p/v6LSllsMy6D9i2RATJrBpHIh9+xBw+0vX+v4752ZPdi9tOTtVrTVQ0NJ4VnoQl
         b1YS/PaHSy/zIMueR5sA75oCZHeoKonQy9j+vmCSrebmh0uULbE0Kq0Ugr0E6Ah0TGrg
         lbIL/m5nXZIakV+/3TfcqKGJf2P4jW0flRYnaoGIO9Jxrkc9fftLVFavWTFshsuCrVuf
         jvs/EjEatiPgw1lPSolYsc73iBjrcE9b2vpbUm4m3c9vKR1QQLB5FtY6KUFeVL+scqoq
         4ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRLUaYHUgmCXdwwVXNZ6zyGkI+A7UWnvD1VH+mBl8x0=;
        b=MN7QDtuyaOe1Hk5UW2QQMAxta0g+tcNQn/weOWWtuco/qIwW34RCv90kvT1/rD2xne
         pwjqfIyjQLpWs6xZIFr1gCC8l3ZQal9pDaXbE7f7BhQtnddTKeMcBGWwQboKFiAhHxu9
         VzaZGoNiy1wa1wF3nm7v0svge3oNlHsRuNBmMtDn76VMg2EE0O9aAVSBdQ33uzcXPXtm
         47B98FwKcu5QSw1BNrub5HUN5NCYIYuaoPzyk3YdqYqdprHko1SRwSFUyf+Ap3Q3DHeG
         ofrDyLBeoazEvImRsMVm2QxUfDxJjseZnAHA7nw5vE/Aa6LMw8F5fqiCkchO5VQXzOD9
         KfSA==
X-Gm-Message-State: AGi0PuZ/jvtp0qzcGuhWY3uAUl5O7p1pbXPvw4orJRW65WUOQzv9bcw3
        +tGl2OLPkvvBM4elOnJn8NZcYg==
X-Google-Smtp-Source: APiQypL3RYnahelxtjJ2lBl6NOILo7QZ3uKdcvgm6KeHOU/UYpQAdkjg57krhIhOkoEdzp7qiFa6AQ==
X-Received: by 2002:a63:1823:: with SMTP id y35mr6194076pgl.25.1588371593628;
        Fri, 01 May 2020 15:19:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d20sm2886919pgl.72.2020.05.01.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:19:52 -0700 (PDT)
Date:   Fri, 1 May 2020 16:19:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Harri =?utf-8?B?TWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] restore: default to HEAD when combining --worktree
 and --staged
Message-ID: <20200501221951.GD41612@syl.local>
References: <20200501082746.23943-1-sunshine@sunshineco.com>
 <20200501082746.23943-3-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501082746.23943-3-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 04:27:46AM -0400, Eric Sunshine wrote:
> The default restore source for --worktree is the index, and the default
> source for --staged is HEAD. However, when combining --worktree and

I think that you could very reasonably drop the first sentence here,
especially because it is repeated verbatim from the previous commit.

In fact... this whole paragraph looks similar to me. Maybe just:

  When invoking 'git restore' with both '--worktree' and '--staged', it
  is required that the ambiguity of which source to restore from be
  resolved by also passing '--source'.

> --staged in the same invocation, git-restore requires the source to be
> specified explicitly via --source since it would otherwise be ambiguous
> ("should it restore from the index or from HEAD?"). This requirement
> makes it cumbersome to restore a file in both the worktree and the
> index.
>
> However, HEAD is also a reasonably intuitive default restore source when
> --worktree and --staged are combined. After all, if a user is asking to
> throw away all local changes to a file (on disk and in the index)
> without specifying a restore source explicitly -- and the user expects
> the file to be restored from _somewhere_ -- then it is likely that the
> user expects them to be restored from HEAD, which is an intuitive and
> logical place to find a recent unadulterated copy of the file.
>
> Therefore, make HEAD the default restore source when --worktree and
> --staged are combined.

I think that this is a very sensible default choice here, so I am OK
with this second patch, too.

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-restore.txt | 14 +++++++-------
>  builtin/checkout.c            |  9 +++------
>  t/t2070-restore.sh            | 12 +++++++++---
>  3 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> index 8906499637..5b61812e17 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -22,10 +22,10 @@ The command can also be used to restore the content in the index with
>  `--staged`, or restore both the working tree and the index with
>  `--staged --worktree`.
>
> -By default, the restore sources for working tree and the index are the
> -index and `HEAD` respectively. `--source` could be used to specify a
> -commit as the restore source; it is required when combining `--staged`
> -and `--worktree`.
> +By default, the restore source for `--worktree` is the index, and the
> +restore source for `--staged` is `HEAD`. When combining `--worktree` and
> +`--staged`, the restore source is `HEAD`. `--source` can be used to specify

This is extremely nit-pick-y, but is this line a little over-long? My
memory is that Documentation should be wrapped at 72 characters instead
of 80. I culd be totally wrong.

> +a different commit as the restore source.
>
>  See "Reset, restore and revert" in linkgit:git[1] for the differences
>  between the three commands.
> @@ -40,10 +40,10 @@ OPTIONS
>  	tree. It is common to specify the source tree by naming a
>  	commit, branch or tag associated with it.
>  +
> -If not specified, the default restore source for the working tree is
> -the index, and the default restore source for the index is
> +If not specified, the default restore source for `--worktree` is
> +the index, and the default restore source for `--staged` is
>  `HEAD`. When both `--staged` and `--worktree` are specified,
> -`--source` must also be specified.
> +the default restore source is `HEAD`.
>
>  -p::
>  --patch::
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7a01d00f53..500c3e23ff 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1604,14 +1604,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>  	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
>  		BUG("these flags should be non-negative by now");
> -	if (opts->checkout_index > 0 && opts->checkout_worktree > 0 &&
> -	    !opts->from_treeish)
> -		die(_("--source required when using --worktree and --staged"));
>  	/*
> -	 * convenient shortcut: "git restore --staged" equals
> -	 * "git restore --staged --source HEAD"
> +	 * convenient shortcut: "git restore --staged [--worktree]" equals
> +	 * "git restore --staged [--worktree] --source HEAD"
>  	 */
> -	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
> +	if (!opts->from_treeish && opts->checkout_index)
>  		opts->from_treeish = "HEAD";
>
>  	/*
> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> index 19efa21fdb..89e5a142c9 100755
> --- a/t/t2070-restore.sh
> +++ b/t/t2070-restore.sh
> @@ -69,9 +69,15 @@ test_expect_success 'restore --staged uses HEAD as source' '
>  	test_cmp expected actual
>  '
>
> -test_expect_success 'restore --worktree --staged requires --source' '
> -	test_must_fail git restore --worktree --staged first.t 2>err &&
> -	test_i18ngrep "source required when using --worktree and --staged" err
> +test_expect_success 'restore --worktree --staged uses HEAD as source' '
> +	test_when_finished git reset --hard &&
> +	git show HEAD:./first.t >expected &&
> +	echo dirty >>first.t &&
> +	git add first.t &&
> +	git restore --worktree --staged first.t &&
> +	git show :./first.t >actual &&
> +	test_cmp expected actual &&
> +	test_cmp expected first.t
>  '
>
>  test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
> --
> 2.26.2.526.g744177e7f7

All looks good to me, here, too.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
