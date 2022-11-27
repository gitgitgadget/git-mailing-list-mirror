Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA99FC4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 00:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiK0A2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK0A2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 19:28:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7010FD0
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:28:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so3308076plw.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoIz2H7nxZ11z3z0eJ8YV8OCZ4v6PJjAbzoy2j8PT4o=;
        b=c0BPSxqZAzMyg47CBm7JXpoTQWLbSUh2foNtgncbe91qx0XZFNS16eQ84n2lwv5tRX
         Leq9JmJVS3zh0N1JSv6oj05XwCuANExVDRqL4wohy3uI/YGzNzjYLw0QLlqRNCklwDEr
         klVzWb7frmGPLjokvGjZJjL8IQloAtGDxIW/UXm1ZdnzEvdHM5CQEcRfUjPjC6FwLVc0
         Q+Nj/josiQ0PNScMIpkqVV0tIR7hu8P5wrJfhBcGxtH7PS8JUSVeYp8HIkToN6SXm+zP
         HFZ9nwAwOTj5VzjBFLvCfEq+B7WSfw2kV/atwfs2RWX+WdCjR+xWyTFzURicJr4jbf2I
         DBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoIz2H7nxZ11z3z0eJ8YV8OCZ4v6PJjAbzoy2j8PT4o=;
        b=lqTZRvh6nfOe9D8F18LpTytgvWamdzI/8v9KDID1/ihut8eTNjy9kHhv/9YidzYcjs
         XEUdpp3xJK00zZsRE5rVmYzLalnOfFQR02Puk7FIfWvtsEEHNZorye5iWYV46VVh+xd3
         aaR7oOxHsFYHJieMAcRHPUA7DEaVwqGMNkhHjPbkEVAm/WQq58l/RT+AMhgdHEydusRZ
         BXvQvTjFTWGESeyAvYK00d8hxJvDoUJHnlKfrf3cmLzagEIB28MJtInbAwh/NWvQ2o2Q
         EZ8hfdM8vQZi+jsfBRxcBbMrc1DsSJr929DKrZguSS5FVmdSSR0B7TC1SY8PJhOpcb31
         K9Mg==
X-Gm-Message-State: ANoB5pnY43HiwFp3lSlRKtMkD1O0JG4aXyw23kvMWVmqrDt7HLwJclpD
        mlDbhqlCBJMdHTUHq/hCEpg=
X-Google-Smtp-Source: AA0mqf6Euv2V5Hy4hj42nVjoleat386vltMCwi1lRseKV96Vijw/DHCVospaQGUKIrl1zC5IT4K84g==
X-Received: by 2002:a17:902:7042:b0:188:f1b4:cf35 with SMTP id h2-20020a170902704200b00188f1b4cf35mr25666810plt.54.1669508916145;
        Sat, 26 Nov 2022 16:28:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017f74cab9eesm5934178plf.128.2022.11.26.16.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 16:28:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 3/4] ci: p4 on Linux has the same version as on macOS
References: <20221124153934.12470-1-worldhello.net@gmail.com>
        <20221125095954.4826-4-worldhello.net@gmail.com>
Date:   Sun, 27 Nov 2022 09:28:34 +0900
In-Reply-To: <20221125095954.4826-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 25 Nov 2022 17:59:53 +0800")
Message-ID: <xmqqa64db5ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> There would be a segmentation fault when running p4 v16.2 on ubuntu
> 22.04 which is the latest version of ubuntu runner image for github
> actions.
>
> By checking each version from [1], p4d version 21.1 and above can work
> properly on ubuntu 22.04. But version 22.x will break some p4 test
> cases. So p4 version 21.x is exactly the version we can use.
>
> With this update, the versions of p4 for Linux and macOS happen to be
> the same. So we can add the version number directly into the "P4WHENCE"
> variable, and reuse it in p4 installation for macOS.

Makes sense.  This needs to be retitled from a statement of the fact ...

> Subject: Re: [PATCH v4 3/4] ci: p4 on Linux has the same version as on macOS

... to description of a choice _we_ made, e.g.

    ci: use the same version of p4 on both Linux and macOS

or something like that.

Other than that, looks good.

Thanks.

> By removing the "LINUX_P4_VERSION" variable from "ci/lib.sh", the
> comment left above has nothing to do with p4, but still applies to
> git-lfs. Since we have a fixed version of git-lfs installed on Linux,
> we may have a different version on macOS.
>
> [1]: https://cdist2.perforce.com/perforce/
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/install-dependencies.sh | 4 ++--
>  ci/lib.sh                  | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 97a1a1f574..b569893b38 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -5,7 +5,7 @@
>  
>  . ${0%/*}/lib.sh
>  
> -P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
> +P4WHENCE=https://cdist2.perforce.com/perforce/r21.2
>  LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
>  UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
>   tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
> @@ -40,7 +40,7 @@ macos-latest)
>  	mkdir -p $HOME/bin
>  	(
>  		cd $HOME/bin
> -		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz" &&
> +		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
>  		tar -xf helix-core-server.tgz &&
>  		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
>  	)
> diff --git a/ci/lib.sh b/ci/lib.sh
> index eb203662c5..927b4529b0 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -246,7 +246,6 @@ ubuntu-*)
>  	# were recorded in the Homebrew database upon creating the OS X
>  	# image.
>  	# Keep that in mind when you encounter a broken OS X build!
> -	export LINUX_P4_VERSION="16.2"
>  	export LINUX_GIT_LFS_VERSION="1.5.2"
>  
>  	P4_PATH="$HOME/custom/p4"
