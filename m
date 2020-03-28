Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D0C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93D720714
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMIbN1rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1Rxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:53:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1Rxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:53:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so15606530wrw.11
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tF8HFc+OTTktMrYDyx1Q5Kj4L5QirynmrBCNNYyB5R4=;
        b=GMIbN1rgywmzueHS6M+YulLz39xgVeydWuPsIxOu1yRKAQU76IVNEdswzrtB9E0IC9
         htpXtPZTzhVgFP0J3vfjk1JdVAOQBMnpqf1KPOOCleggmQe2wiYEFx+UsWxbYWMHKJ1B
         gz6TjbeC9tvE16nh96v2aNkxqMhXc0CkEJrgMDFaN3nQqIzmcbgpKc8VUaVzeoTRTLcy
         kcgOe/n1pSr0qRAiaOcrvsAPbBu+72+fQ4xlCCYGM/Dlp14twDDJw8vsFB1HNtwZXUay
         Jl4TBuVJU9MU2Fzj9p4b53xm+8CBTxeZud13WZEiF4HiJNevFVvfFu9JG4RbWFipZ/HG
         mrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tF8HFc+OTTktMrYDyx1Q5Kj4L5QirynmrBCNNYyB5R4=;
        b=eC1D0CzvTQ+iPOE0u7vw9jwxuMZapclLhArrrwoRPuxVUiGc+1tv4YO0X/JC9wqBw6
         ZcoX0A+OfhwK3ESY5p/mhIXHd2oXPCxP2nnAV0ktRc4fMq30l9xl1we0TUuAtm2Bimvi
         I+WiwaE1M7j54CDmSmaeqhwbKewYplmpZaLPqPfzbo/79fbpzsZCM8MOWBugJGHJMuyC
         9hcIQGaYbHxQJxHlZXh/dF+pBix5eK7w4FOd0/nsFJaJa2VnaUxIdpsN1LUf5IdFiAK3
         5IWuCmOASb/q+Fkb5EF5jYUWQS+Dk0bFUJH1G0/QmqrPugNd3At4aFRvlUVR39Y9KuGd
         ekXg==
X-Gm-Message-State: ANhLgQ2JwpXwpNXipq/wZDikcbIzhHSSuBRV2cDGbtv8isuNuBPslRap
        YPOTm1gP9kLSnj4Z+swHnaA=
X-Google-Smtp-Source: ADFU+vuuuVWnyQrKakwDPDKmeNQAhKD367k5zHRFKh8aqTayYDSdoBAFpwfEihFGMCawji3e7qBpJg==
X-Received: by 2002:adf:e942:: with SMTP id m2mr5752952wrn.364.1585418012564;
        Sat, 28 Mar 2020 10:53:32 -0700 (PDT)
Received: from szeder.dev (94-21-146-43.pool.digikabel.hu. [94.21.146.43])
        by smtp.gmail.com with ESMTPSA id y200sm13293664wmc.20.2020.03.28.10.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 10:53:31 -0700 (PDT)
Date:   Sat, 28 Mar 2020 18:53:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: refactor docker runner script
Message-ID: <20200328175329.GD2224@szeder.dev>
References: <cover.1585203294.git.congdanhqx@gmail.com>
 <2fada3db3d0c802b45551671dcb75e406e3ed2b6.1585203294.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fada3db3d0c802b45551671dcb75e406e3ed2b6.1585203294.git.congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 02:35:18PM +0700, Đoàn Trần Công Danh wrote:
> We will support alpine check in docker later in this serie.
> 
> While we're at it, tell people to run as root in podman.

Why tell that to people?  Please clarify what podman is and why should
we care.

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  .travis.yml                                 |  2 +-
>  azure-pipelines.yml                         |  4 ++--
>  ci/{run-linux32-docker.sh => run-docker.sh} | 19 +++++++++++++------
>  3 files changed, 16 insertions(+), 9 deletions(-)
>  rename ci/{run-linux32-docker.sh => run-docker.sh} (48%)
> 
> diff --git a/.travis.yml b/.travis.yml
> index fc5730b085..32e80e2670 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -32,7 +32,7 @@ matrix:
>        services:
>          - docker
>        before_install:
> -      script: ci/run-linux32-docker.sh
> +      script: ci/run-docker.sh linux32

The name of the 'Linux32' build job starts with a capital 'L'; please
be consistent with that.

>      - env: jobname=StaticAnalysis
>        os: linux
>        compiler:
> diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> index 675c3a43c9..ef504ff29f 100644
> --- a/azure-pipelines.yml
> +++ b/azure-pipelines.yml
> @@ -489,14 +489,14 @@ jobs:
>         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
>  
>         res=0
> -       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
> +       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-docker.sh linux32 || res=1
>  
>         sudo chmod a+r t/out/TEST-*.xml
>         test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
>  
>         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
>         exit $res
> -    displayName: 'ci/run-linux32-docker.sh'
> +    displayName: 'ci/run-docker.sh linux32'
>      env:
>        GITFILESHAREPWD: $(gitfileshare.pwd)
>    - task: PublishTestResults@2
> diff --git a/ci/run-linux32-docker.sh b/ci/run-docker.sh
> similarity index 48%
> rename from ci/run-linux32-docker.sh
> rename to ci/run-docker.sh
> index 751acfcf8a..c8dff9d41a 100755
> --- a/ci/run-linux32-docker.sh
> +++ b/ci/run-docker.sh
> @@ -1,15 +1,22 @@
>  #!/bin/sh
>  #
> -# Download and run Docker image to build and test 32-bit Git
> +# Download and run Docker image to build and test git

s/git/Git/

>  #
>  
>  . ${0%/*}/lib.sh
>  
> -docker pull daald/ubuntu32:xenial
> +CI_TARGET=${1:-linux32}
> +case "$CI_TARGET" in
> +linux32) CI_CONTAINER="daald/ubuntu32:xenial" ;;
> +*)       exit 1 ;;
> +esac
> +
> +docker pull "$CI_CONTAINER"
>  
>  # Use the following command to debug the docker build locally:
> -# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
> -# root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
> +# <host-user-id> must be 0 if podman is used in place of docker
> +# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/sh "$CI_CONTAINER"
> +# root@container:/# /usr/src/git/ci/run-$CI_TARGET-build.sh <host-user-id>
>  
>  container_cache_dir=/tmp/travis-cache
>  
> @@ -23,8 +30,8 @@ docker run \
>  	--env cache_dir="$container_cache_dir" \
>  	--volume "${PWD}:/usr/src/git" \
>  	--volume "$cache_dir:$container_cache_dir" \
> -	daald/ubuntu32:xenial \
> -	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
> +	"$CI_CONTAINER" \
> +	"/usr/src/git/ci/run-$CI_TARGET-build.sh" $(id -u $USER)
>  
>  check_unignored_build_artifacts
>  
> -- 
> 2.26.0.rc2.357.g1e1ba0441d
> 
