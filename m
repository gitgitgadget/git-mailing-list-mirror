Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E5BC43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EF92073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k92k6dc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0Qs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:48:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35742 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK0QsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:48:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id n5so8347239wmc.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v5o5Y3f1dqaPsl5gt8+yG6WtQaK1H19xs4+CthB+Ljo=;
        b=k92k6dc31oXokoYs7r1G8Mn+HrOeZx49lDeQUpJ8oR7MsU3fXHfyP1UdMw4SiyRX5F
         i6m0e3jSvoqW1z/VKnNXhHO1QqOl6C1QC2ucE1pwHSpsPlF3iK4Ic0jZKVuu1ldkZQjk
         QV8b1Sex1sO1xKjxU1C9OlHol9vJYR8gfQlWVQx71JBVDrBwGby0yDnLZv0hw80vzeiU
         FAkeQcrmO4GuKX/hJxQ8JEP9QC+xfLJ7o5elZax3WTBVGxBRQM9zk8XUR7lD/P6kK8Ao
         pO3L7zpf69AAJWjBIqdrfMe0LA2b/QDS3T6IEaSN4YLUXXGXatwaBQH+YTw2KEluFN1/
         rogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v5o5Y3f1dqaPsl5gt8+yG6WtQaK1H19xs4+CthB+Ljo=;
        b=W+BUE2/VVADVLhKzTeTwKbhFaJwQ9pNUby8vSMz3LtngIl+z7F7v6U4tO++VzrUCb1
         jywDvuU33sVOscpHbdiyAocRyeMvIMBGxHpK+wPyfH+JZXvmWgkbnyD2s0/mDDQExUU+
         zIAXUXs5eNeTUAIR/NrwyE7OcSHawoONmpzpr4bA632lNJxxgri7M4Cy332LlXQf0DKT
         ENFStLnEmQHkpA5UtLPTMIjX6ZPjizc5dmDTiBIJGW/TBE0IFOMY3yn7WkAfyRCTMARb
         ppgZ57luZYS9Xjk8vJdPw2/kHAWm5BVYksZfTxla/gRYMjyQf2piPkeO0l4IH9JFUHEd
         xkQQ==
X-Gm-Message-State: APjAAAX5h23v+poJ9nN5lHwvgryfufgh2IqCWKLR0o2fNauJQWR2D0m7
        6uWTiVputqvdcfidBZGp+RoixHKY
X-Google-Smtp-Source: APXvYqwdONyWZiRn8aJuTGTEvOhgnBkZYM1vQ/nNKYXLuVJ6GxxvkzeN5VwfZxvluFzd0SzZ7PlW7A==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr5712548wmb.150.1574873303573;
        Wed, 27 Nov 2019 08:48:23 -0800 (PST)
Received: from szeder.dev (x4db309d4.dyn.telefonica.de. [77.179.9.212])
        by smtp.gmail.com with ESMTPSA id y6sm19975856wrr.19.2019.11.27.08.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 08:48:22 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:48:20 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: detect installed gcc in Travis CI
Message-ID: <20191127164820.GF23183@szeder.dev>
References: <20191126011536.GA30006@generichostname>
 <20191127161555.26131-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127161555.26131-1-congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 11:15:55PM +0700, Doan Tran Cong Danh wrote:
> Travis CI has continously updated their images, including updating gcc
> installation.
> 
> Save us some headache by checking which version of gcc is installed in
> the image, and use said version to run the build.
> 
> While gcc-10 hasn't been released, yet, add it to the list to save us
> some headache in the future.
> 
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---
>  ci/lib.sh | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index c8c2c38155..4040fc1a22 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -159,12 +159,21 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_TEST_CLONE_2GB=YesPlease
>  
>  case "$jobname" in
> -linux-clang|linux-gcc)
> -	if [ "$jobname" = linux-gcc ]
> -	then
> -		export CC=gcc-8
> -	fi
> +*-gcc)
> +	for gitcc in gcc-10 gcc-9 gcc-8
> +	do
> +		if command -v $gitcc >/dev/null 2>&1
> +		then
> +			export CC=$gitcc
> +			break;
> +		fi
> +	done

This assummes that some of these gcc-<N> binaries can be found in
PATH, but that hasn't always been the case in the past: up until end
of last week Travis CI's xcode10.1 image came with GCC 8 pre-installed
but not linked and without GCC 9, i.e. neither 'gcc-8' nor 'gcc-9' was
available in PATH.  While now that image does have GCC 9 properly
installed, i.e. 'gcc-9' has been available in PATH for almost a week,
I wouldn't want to rely on that...

With your changes if none of the listed gcc-<N> binaries were
available in PATH, then we would silently build with the generic 'cc',
which is 'clang' on OSX, and that's definitely not what we want.

> +	unset gitcc
> +	;;
> +esac
>  
> +case "$jobname" in
> +linux-clang|linux-gcc)
>  	export GIT_TEST_HTTPD=true
>  
>  	# The Linux build installs the defined dependency versions below.
> @@ -180,11 +189,6 @@ linux-clang|linux-gcc)
>  	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
>  	;;
>  osx-clang|osx-gcc)
> -	if [ "$jobname" = osx-gcc ]
> -	then
> -		export CC=gcc-8
> -	fi
> -
>  	# t9810 occasionally fails on Travis CI OS X
>  	# t9816 occasionally fails with "TAP out of sequence errors" on
>  	# Travis CI OS X
> -- 
> 2.24.0.161.g2616cd003f.dirty
> 
