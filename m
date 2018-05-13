Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F111F406
	for <e@80x24.org>; Sun, 13 May 2018 13:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEMNWJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 09:22:09 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55878 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751264AbeEMNWJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 May 2018 09:22:09 -0400
X-Greylist: delayed 2199 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 May 2018 09:22:08 EDT
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1fHqNT-0007lS-UJ; Sun, 13 May 2018 14:45:27 +0200
Subject: Re: [PATCH] travis-ci: run gcc-7 on linux-gcc jobs
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20180513091752.14003-1-pclouds@gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <10b243d8-fc81-a172-768d-9b47e94a24b0@virtuell-zuhause.de>
Date:   Sun, 13 May 2018 14:45:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513091752.14003-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1526217729;6d5981bd;
X-HE-SMSGID: 1fHqNT-0007lS-UJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.05.2018 um 11:17 schrieb Nguyễn Thái Ngọc Duy:
> Switch from gcc-4.8 to gcc-7. Newer compilers come with more warning
> checks (usually in -Wextra).  Since -Wextra is enabled in developer
> mode (which is also enabled in travis), this lets travis report more
> warnings before other people do it.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  .travis.yml        | 3 +++
>  ci/lib-travisci.sh | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 5f5ee4f3bd..a77f5f5bd5 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -16,10 +16,13 @@ compiler:
>  
>  addons:
>    apt:
> +    sources:
> +    - ubuntu-toolchain-r-test
>      packages:
>      - language-pack-is
>      - git-svn
>      - apache2
> +    - gcc-7

You could also use gcc-8 here as that is already present according to [1].

[1]:
https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test/+packages

>  matrix:
>    include:
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 109ef280da..ef2848fd45 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -99,6 +99,9 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  export GIT_TEST_OPTS="--verbose-log -x"
>  export GIT_TEST_CLONE_2GB=YesPlease
> +if [ "$jobname" = linux-gcc ]; then
> +	export CC=gcc-7
> +fi
>  
>  case "$jobname" in
>  linux-clang|linux-gcc)
> 

