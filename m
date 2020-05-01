Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F73C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE0C216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JkSlL9At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgEAWQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAWQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:16:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E9C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:16:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l20so5130819pgb.11
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C4GGFFQ95rypQUHCVZRqsiEmMOWWbXQU0Bpl66h2vgQ=;
        b=JkSlL9AtsAdr75bN1u8choFg9H98/R+CGlUvYfh5sF0c8J3yqx4PBv803MrUZfyhsy
         eS+bSE172uv/43vW2lLZyTjCf3yUlIXs4K36y8ccvvDmh7EjCm9I59m3gmJuX4j8UPFQ
         2ooA0q43QSW94ajpkwL83pnqUiVFVnJfzQsHPxQRZUrYS3ORFgmx806Z4hcfdC1PG9fZ
         4rWcZAcDE/a+ILC2LYSBPfbkSrewFRnV/2AjRytJIrjPRbPNZhcr0NNQvCovxHmVfjwY
         oZxAgPLesXR3jVGH5nxzbcH2QFQ2hdn5HhQdZT05I2lwh21pdJ5BU9cRbg787Q1hzG8A
         Ngig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C4GGFFQ95rypQUHCVZRqsiEmMOWWbXQU0Bpl66h2vgQ=;
        b=lmgEpkUZCBrAhKYvqITy+k2R/EqBou//hfK4cOOpFFVk3QYCUs1m8UPEanNR+Y4pH/
         CvPcBN00MmLkY1dGcO+qsETsHkI91z6i/9mwf0E6suPaJD+HwOGR7hXqqZyzi9XuTwsi
         mpDfVnaIaCT4FgVY/nNv31HC9te/L7Z7jxHs9Q79Vg8W1aZsNv8Mm7d7Gd9UbJik6G/+
         ZyNUDT7ljHcxWhnOnlvJGube32dBzsmrCKpJpEDv/VNElCJ+N57uHkxODRiVMJxvH74r
         gEgJepFY1gwgp629AFsT4O5wXYEw1PXkHqCa5W1X2De8jfYE1SiG3G/KEruUIfkzswqt
         68Ew==
X-Gm-Message-State: AGi0PubjERNHYiESGb9ntFpE7FAw476M8tGseQQG10LmT8AIJYUtqZIW
        q8ymd2QLrMLrmYqzDpZ47K3MBw==
X-Google-Smtp-Source: APiQypIUOlfYoowp+fby6KxD4XWUW3ykw4rJPyPdGbgOmujxxfMhaqSmEUtqIe/Efky2wgL8N2lH5g==
X-Received: by 2002:a63:e050:: with SMTP id n16mr6170059pgj.93.1588371375099;
        Fri, 01 May 2020 15:16:15 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j6sm3019962pfe.134.2020.05.01.15.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:16:14 -0700 (PDT)
Date:   Fri, 1 May 2020 16:16:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Harri =?utf-8?B?TWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] restore: require --source when combining --worktree
 and --staged
Message-ID: <20200501221613.GC41612@syl.local>
References: <20200501082746.23943-1-sunshine@sunshineco.com>
 <20200501082746.23943-2-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501082746.23943-2-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 04:27:45AM -0400, Eric Sunshine wrote:
> The default restore source for --worktree is the index, and the default
> source for --staged is HEAD. When combining --worktree and --staged in
> the same invocation, the restore source is ambiguous ("should it restore
> from the index or from HEAD?"). To avoid such ambiguity, the git-restore
> documentation has always stated that --source must be used when
> combining --worktree and --staged. However, this restriction is not
> actually enforced. Address this deficiency by making the implementation
> match the documented behavior (to wit, error out if --source is not
> specified when combining --worktree and --staged).

This explanation is very helpful, and makes the fix below very natural.
Thanks for a helpful explanation.

> While at it, enhance the documentation to mention the --source
> requirement prominently in the "Description" section (rather than only
> in the description of the --source option itself).
>
> Reported-by: Harri Mehtälä <harri.mehtala@finago.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-restore.txt | 3 ++-
>  builtin/checkout.c            | 3 +++
>  t/t2070-restore.sh            | 5 +++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> index 8e3b339802..8906499637 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -24,7 +24,8 @@ The command can also be used to restore the content in the index with
>
>  By default, the restore sources for working tree and the index are the
>  index and `HEAD` respectively. `--source` could be used to specify a
> -commit as the restore source.
> +commit as the restore source; it is required when combining `--staged`
> +and `--worktree`.
>
>  See "Reset, restore and revert" in linkgit:git[1] for the differences
>  between the three commands.
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8bc94d392b..7a01d00f53 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1604,6 +1604,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>  	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
>  		BUG("these flags should be non-negative by now");
> +	if (opts->checkout_index > 0 && opts->checkout_worktree > 0 &&
> +	    !opts->from_treeish)
> +		die(_("--source required when using --worktree and --staged"));
>  	/*
>  	 * convenient shortcut: "git restore --staged" equals
>  	 * "git restore --staged --source HEAD"
> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> index 076d0df7fc..19efa21fdb 100755
> --- a/t/t2070-restore.sh
> +++ b/t/t2070-restore.sh
> @@ -69,6 +69,11 @@ test_expect_success 'restore --staged uses HEAD as source' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'restore --worktree --staged requires --source' '
> +	test_must_fail git restore --worktree --staged first.t 2>err &&
> +	test_i18ngrep "source required when using --worktree and --staged" err
> +'
> +
>  test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
>  	git init unmerged &&
>  	(
> --
> 2.26.2.526.g744177e7f7

Very sane.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
