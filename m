Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E9C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AB420665
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkMxkQwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEHxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:53:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C8C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 00:53:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so6265504pfo.12
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OtfHLeMcN2mytYD5LJUlaigozycXpUcol3pAACohCHs=;
        b=hkMxkQwJByjrV0kMqtKv74jeeyvELQiL+jDa/oyzVCfSyjXuhiIyv+LKLiZoNfeuwT
         OBDMETOqNMJIoHITTprNnGkinhC78IV1IsbwJU4dfZBP8e6MK63fSP6KEo23BAUagAmn
         yUZMHQYUrapQZf2wlV+sgeLGaEkq4ZahyTPJxToORZXGVVb1w+x1j7MijJREYyQMRuHd
         qBcBqMMsOIjom4gm9XpobltbVybe3FaoprD6wv2Gr0zB82CQ50Ph1dMf6gwlwIDNKpO5
         1G6E7UJjPpEEchHynOqtqn11SrfjRoH3dl5B9RsiwtzcfKG/p5/tfBxH7SPogmm2qqjO
         9Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OtfHLeMcN2mytYD5LJUlaigozycXpUcol3pAACohCHs=;
        b=MxLIyo5FUZQILEf9+ampdACIjgOFrQuPRgBDrULw4Pv3cdrDaUfakvJhSX0ELNdP03
         V0MpU8gd98VT0tFsFZvwyCceT3suZpaxBqWzceIZvsU+exCohwwdktDsgOHf9zxPkMjn
         +QCVxI1wpQyMiLFwyC55rwJTISf0M9lRDkn3SKfAR16TLSpB6SkH+gec11WlPwNHvf4z
         07WEPf+p0XhBIa4CgPYQR7pSl+dTKY2KrogW08J6Ef8If3AHDWvXjgWxNeHmT8dzlhfQ
         WpQDOdglpJtovpnaSorkMp5JW+CBEdg+YE9UuQl0+1o+kby084uvIH/7bQvzfYZQpeOP
         DAFA==
X-Gm-Message-State: AOAM533KhCt9KUAaINZCjaI+k2UeStBcrpJAb4i9nRUKM5lYXRb3+lpB
        mItpdbM0NsynKshiuQapVDViDoQ8Yig=
X-Google-Smtp-Source: ABdhPJznAuudvMCetrGnB8GvjOZnLpyh/Uf1IbACGiS/7snRdtLsEySjlkjuTZeDDrMvPCOcwG/u1Q==
X-Received: by 2002:a63:784:: with SMTP id 126mr13576444pgh.428.1601884393585;
        Mon, 05 Oct 2020 00:53:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id r6sm11808548pfq.11.2020.10.05.00.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:53:13 -0700 (PDT)
Date:   Mon, 5 Oct 2020 00:53:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] t7450: test verify_path() handling of gitmodules
Message-ID: <20201005075311.GG1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072015.GD2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005072015.GD2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> Commit 10ecfa7649 (verify_path: disallow symlinks in .gitmodules,
> 2018-05-04) made it impossible to load a symlink .gitmodules file into
> the index. However, there are no tests of this behavior. Let's make sure
> this case is covered. We can easily reuse the test setup created by
> the matching b7b1fca175 (fsck: complain when .gitmodules is a symlink,
> 2018-05-04).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7450-bad-meta-files.sh | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t7450-bad-meta-files.sh b/t/t7450-bad-meta-files.sh
> index 6b703b12bc..b73985157f 100755
> --- a/t/t7450-bad-meta-files.sh
> +++ b/t/t7450-bad-meta-files.sh
> @@ -139,7 +139,7 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
>  	grep gitmodulesName output
>  '
>  
> -test_expect_success 'fsck detects symlinked .gitmodules file' '
> +test_expect_success 'create repo with symlinked .gitmodules file' '
>  	git init symlink &&
>  	(
>  		cd symlink &&
> @@ -155,8 +155,14 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
>  		{
>  			printf "100644 blob $content\t$tricky\n" &&
>  			printf "120000 blob $target\t.gitmodules\n"
> -		} >bad-tree &&
> -		tree=$(git mktree <bad-tree) &&
> +		} >bad-tree
> +	) &&
> +	tree=$(git -C symlink mktree <symlink/bad-tree)
> +'

This is super nitpicky, but: test scripts can be hard to maintain when
there's this kind of state carried from assertion to assertion without
it being made obvious.

Can this include "setup" or "set up" in the name to do that?  E.g.

	test_expect_success 'set up repo with symlinked .gitmodules file' '
		...
	'

Thanks,
Jonathan
