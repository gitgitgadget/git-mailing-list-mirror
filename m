Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3881AC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62A4206DB
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 06:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsNJt3Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgC2GgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 02:36:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40876 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgC2GgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 02:36:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so7000880pgj.7
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2S0Klm353L/vMXyXTxmioIO48h1Ca8O+ap6m9kLQcX8=;
        b=XsNJt3Bo02lEGLSfLxmt7qLOk9Mo/jZOrWDXp0uNnKNTsBt7rKBHU4wVNC8j7CLFPL
         BSwE1aXHTuKcEyvZdoa0U23RhnAbvKPjCMRukmE9tlEAFhIZIgLmb92We266A3XWyROv
         van0iQrYyccc52SwewLjqDaEsf23Bqp6tjYtCVCQcrnbe2EkvAv1S0tyXrycb9m96QPF
         UsT7/koYezzIqpP2fNVZgCoksfSPe2TaDH1DC5caxf2DRzET3NifJfj71dJqCjqB+QWq
         DBa5xoAjKVMGMD+VtLr02WMzPNNrWYpswsQiJkhUKNq1+zO8K8/mx7IZMsdhb5UGgda8
         0BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2S0Klm353L/vMXyXTxmioIO48h1Ca8O+ap6m9kLQcX8=;
        b=MkiK75EUJSBjkakXpzoG4c8U3fJavL+///dhQGjv+34XeKmNbkvPGIfYZlDEHkMuVu
         mEUMPqBY0BvP+d2lWoylZ00F5pVPs/2n25AEpo1xJd2o5ZyRlw/xqdlcIW/D3scp+tTF
         31gw2daEk6EmxkIOlhDwTToVx6JliVWh8hsdcLsPBaukz/dznv3H2tXT6PJV2L6JQpve
         AUGfMtHKvTl9/X0bX5ASsdJ0fC4c3aH7nYTGl5lJMMUz35QfNGd1tn8XT15hW6+o/25z
         gNxukkeMGPtlfAcUA5JH7vw0ZqWIsS3PzUU4UwRPt7KFDnq9jfqNswywSDBSI0536TL9
         amCw==
X-Gm-Message-State: ANhLgQ00Zqrw5r+rerK2YPgCeHzdzLCVKZCkpCzj1uXcnR2v/XKpmyLN
        9C98/lenspJ2KsnnrsZVP9M=
X-Google-Smtp-Source: ADFU+vub2xNWh7A4GcFOhNiCCW6EZQswN8EzBak21cJLZ8sFIoCIja1+wQL2NYbZt3cFxjzGfyDl9w==
X-Received: by 2002:a63:30c4:: with SMTP id w187mr7663153pgw.239.1585463771077;
        Sat, 28 Mar 2020 23:36:11 -0700 (PDT)
Received: from localhost ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id 93sm7202903pjo.43.2020.03.28.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 23:36:09 -0700 (PDT)
Date:   Sun, 29 Mar 2020 13:36:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: refactor docker runner script
Message-ID: <20200329063608.GA22082@danh.dev>
References: <cover.1585203294.git.congdanhqx@gmail.com>
 <2fada3db3d0c802b45551671dcb75e406e3ed2b6.1585203294.git.congdanhqx@gmail.com>
 <20200328175329.GD2224@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200328175329.GD2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-28 18:53:29+0100, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Thu, Mar 26, 2020 at 02:35:18PM +0700, Đoàn Trần Công Danh wrote:
> > We will support alpine check in docker later in this serie.
> > 
> > While we're at it, tell people to run as root in podman.
> 
> Why tell that to people?  Please clarify what podman is and why should
> we care.

podman is a docker drop-in placement.
I use it instead of docker to develop this series.

docker requires a service to be run and user in docker system groups,
podman requires neither.

root user in podman is mapped to host user.
I run into trouble when develop this series in my local machine.

> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  .travis.yml                                 |  2 +-
> >  azure-pipelines.yml                         |  4 ++--
> >  ci/{run-linux32-docker.sh => run-docker.sh} | 19 +++++++++++++------
> >  3 files changed, 16 insertions(+), 9 deletions(-)
> >  rename ci/{run-linux32-docker.sh => run-docker.sh} (48%)
> > 
> > diff --git a/.travis.yml b/.travis.yml
> > index fc5730b085..32e80e2670 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -32,7 +32,7 @@ matrix:
> >        services:
> >          - docker
> >        before_install:
> > -      script: ci/run-linux32-docker.sh
> > +      script: ci/run-docker.sh linux32
> 
> The name of the 'Linux32' build job starts with a capital 'L'; please
> be consistent with that.

the old name of the script is run-linux32-docker,
I think it's better to rename the job to all lowercase.
All other jobs, except Documentation and static analysis are in
lowercase.

> 
> >      - env: jobname=StaticAnalysis
> >        os: linux
> >        compiler:
> > diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> > index 675c3a43c9..ef504ff29f 100644
> > --- a/azure-pipelines.yml
> > +++ b/azure-pipelines.yml
> > @@ -489,14 +489,14 @@ jobs:
> >         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> >  
> >         res=0
> > -       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
> > +       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-docker.sh linux32 || res=1
> >  
> >         sudo chmod a+r t/out/TEST-*.xml
> >         test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
> >  
> >         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
> >         exit $res
> > -    displayName: 'ci/run-linux32-docker.sh'
> > +    displayName: 'ci/run-docker.sh linux32'
> >      env:
> >        GITFILESHAREPWD: $(gitfileshare.pwd)
> >    - task: PublishTestResults@2
> > diff --git a/ci/run-linux32-docker.sh b/ci/run-docker.sh
> > similarity index 48%
> > rename from ci/run-linux32-docker.sh
> > rename to ci/run-docker.sh
> > index 751acfcf8a..c8dff9d41a 100755
> > --- a/ci/run-linux32-docker.sh
> > +++ b/ci/run-docker.sh
> > @@ -1,15 +1,22 @@
> >  #!/bin/sh
> >  #
> > -# Download and run Docker image to build and test 32-bit Git
> > +# Download and run Docker image to build and test git
> 
> s/git/Git/

Will change

-- 
Danh
