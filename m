Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078FC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6762063A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wvFpq1Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDGWjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:39:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42826 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGWjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:39:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id v2so402744plp.9
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z53XxueW0ndDTRreWIOI5Gch0Gv1lzFes3Gs2SGj/XQ=;
        b=wvFpq1Uay3I65/DdHsgBLG1PvLvnUGBggYfO1Up1r6VJ6DOPRqZtCn0uUHpGArMIUA
         YXqiA4C1qNgq/3+aAoyBfmDkj8t+M1kJWnzZ2+0WtdZX2Jpk58Ao+GlPVbTyBcplsZK+
         2spsPJVGs00LAx7nh96j74756KoEC1G2UiqadvNm0jEgS7Eno/yQFH3QC5lKvA/5GcFg
         tLpAS66apgoeMdid6nQJEuAtZySXb4q7f3PZWQEYN6JvCbynVRv//k+EDQonlxoq9Rjs
         nZZ1h7XAO4W1tl4sAQYsISE1qkkyjS6WimD6CJsTjcISs2MyLDnAxnzd4tDGdk0+NLtB
         /0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z53XxueW0ndDTRreWIOI5Gch0Gv1lzFes3Gs2SGj/XQ=;
        b=gKkHbDuhHW9PkufPVadQ/pBOJAt/ek64wXxJabSaVs/5O7Ff0jnZV7u8oYNxOLPnBg
         eC+K9nUJ3T0V/UUo5Ro3PBje+nUY6l9hwkxjZNhQdaovqFrpTbExZnlcDTqpYNNTY32Y
         YbekuIdscYE8K7FQSqxPGnOI8RBXuQRSpRwD3mpJuH5k83+i/WCzkC7l2OTKcCQ28vmP
         HLV4SM8Rh8DlG1r9En/v/i70kvjU7P4vtJpbuhmq3DYGgR4D7P9a9VsMzNE0dpHPV1Iz
         NbvC1qK7CDNRAoAd2YO+Fc2Z16SK50h5eyvyqTFOVhczRG2xctCaFxcEMX4kwPOWiTGP
         PwnA==
X-Gm-Message-State: AGi0PuY1W7n+/IeNFXgpp1yqyOIEiJzU05jiO+1SkcBlIKoUD9Hg3N5C
        hNblBI0wFFUqiAMDmAKOHSrGoA==
X-Google-Smtp-Source: APiQypL5kgF53TNvDPXepSi0NZlEb3QYQge9grTrOzB4vbBftcagyb8QZ3Fm4W+1kmAB6W7CQycVbg==
X-Received: by 2002:a17:902:a404:: with SMTP id p4mr4500440plq.167.1586299179658;
        Tue, 07 Apr 2020 15:39:39 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id nl7sm2767254pjb.36.2020.04.07.15.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:39:39 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:39:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t0007: fix a typo
Message-ID: <20200407223938.GB22683@syl.local>
References: <pull.598.git.1586009782089.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.598.git.1586009782089.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Sat, Apr 04, 2020 at 02:16:21PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix typo "identites"
>
>     I am fairly certain that 879ed7539357 (t: add tests for "git var",
>     2012-11-28) did not meant to use the French spelling (for which the
>     accent would be missing, anyway).

;-).

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-598%2Fdscho%2Ftyop-identites-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-598/dscho/tyop-identites-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/598
>
>  t/t0007-git-var.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 1f600e2cae5..88b9ae81588 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -17,7 +17,7 @@ test_expect_success 'get GIT_COMMITTER_IDENT' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identites are strict' '
> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identities are strict' '

Looks obviously good.

>  	(
>  		sane_unset GIT_COMMITTER_NAME &&
>  		sane_unset GIT_COMMITTER_EMAIL &&
>
> base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
> --
> gitgitgadget

Thanks,
Taylor
