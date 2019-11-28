Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E7DC432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33442084D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGoY+0O7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfK1MDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:03:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34282 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MDd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:03:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so13071568pff.1
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DRrza1DNESTavUmQNlzJmiIw6qsFCKz6nQWDgv3cKHc=;
        b=nGoY+0O73D5KUHYfWc/ALUwK0bD0Rdh4txF80+pyiRji8uDeF4XGtVmSCuHIzbhjX3
         Cu0D4z2TF/NomW/PUk2yVY4DeFjq5ULfWDgXkzqC9iKKlYEbk3NQrYtwRfxaZ6J32ExN
         TQaxEUiq/9cvc89g4ELDAdtH1WFtbTyTeAacqcrLRc13axmzKWLWRHMzREw51l5vtowL
         vpIhQ/d2X9lRoWuCP8AoWukoCMmVvEpy+18TclS5Ye6WeKPcH0lLJF8LU0Nk6tvvLRxr
         Js5ZDt7loX9to7bajxMcdxCOhgTk3x2WElSwp1TxVElM0IhTAjERhVBjaJ/n5o7SnT8A
         g8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DRrza1DNESTavUmQNlzJmiIw6qsFCKz6nQWDgv3cKHc=;
        b=V7Mz2iOA1LBkS8JpA4RrDIz4prGEf+tLotsbpoJY1so9Nipf+faMQnzya/G0215krt
         U+mXQReW8YzZpiHIjSafKxqBALe7UwP/8VWF6fau6M6elyJRx6zLg2IxT6+VOsaJXbiw
         COY7PSZVShn6w4Ed6AgNxBskXzS/xs9dcj2PcsIjJtwLseGrj93kzaoQn8TRNpAforjc
         nCB3d4dKw2+mlLUPTHrJd9el5+9oWTWlOkS3BDXgFOInmV3pd8yjlrpjSaRMAW9mVbEP
         6pbg8yZv6TP4Nv3cd2B6Ux9wsbaTzP2GOSwx6xsyBh+rpfp0CvunT6Xa38wVB90FuGlE
         sRvg==
X-Gm-Message-State: APjAAAWAY1ikxZiUrAzfcBQvqjDiPeRkNQLtU7aeNkrAp4QJJoCIdltS
        ssFRk0GICDlkwEOr4PjUw0s=
X-Google-Smtp-Source: APXvYqxmzCc7cjly4XekxHjXfO3Olblx4AkXS7RZFYnlLWSdrme79M3+iF6YlOIUQJ1u93YUALCQfA==
X-Received: by 2002:a63:5c0c:: with SMTP id q12mr10411244pgb.197.1574942612571;
        Thu, 28 Nov 2019 04:03:32 -0800 (PST)
Received: from localhost ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id 21sm20978306pfy.67.2019.11.28.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:03:31 -0800 (PST)
Date:   Thu, 28 Nov 2019 19:03:30 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: detect installed gcc in Travis CI
Message-ID: <20191128120330.GA9067@danh.dev>
References: <20191126011536.GA30006@generichostname>
 <20191127161555.26131-1-congdanhqx@gmail.com>
 <20191127164820.GF23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191127164820.GF23183@szeder.dev>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-27 17:48:20+0100, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Wed, Nov 27, 2019 at 11:15:55PM +0700, Doan Tran Cong Danh wrote:
> > Travis CI has continously updated their images, including updating gcc
> > installation.
> > 
> > Save us some headache by checking which version of gcc is installed in
> > the image, and use said version to run the build.
> > 
> > While gcc-10 hasn't been released, yet, add it to the list to save us
> > some headache in the future.
> > 
> > Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> > ---
> >  ci/lib.sh | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index c8c2c38155..4040fc1a22 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -159,12 +159,21 @@ export DEFAULT_TEST_TARGET=prove
> >  export GIT_TEST_CLONE_2GB=YesPlease
> >  
> >  case "$jobname" in
> > -linux-clang|linux-gcc)
> > -	if [ "$jobname" = linux-gcc ]
> > -	then
> > -		export CC=gcc-8
> > -	fi
> > +*-gcc)
> > +	for gitcc in gcc-10 gcc-9 gcc-8
> > +	do
> > +		if command -v $gitcc >/dev/null 2>&1
> > +		then
> > +			export CC=$gitcc
> > +			break;
> > +		fi
> > +	done
> 
> This assummes that some of these gcc-<N> binaries can be found in
> PATH, but that hasn't always been the case in the past: up until end
> of last week Travis CI's xcode10.1 image came with GCC 8 pre-installed
> but not linked and without GCC 9, i.e. neither 'gcc-8' nor 'gcc-9' was
> available in PATH.  While now that image does have GCC 9 properly
> installed, i.e. 'gcc-9' has been available in PATH for almost a week,
> I wouldn't want to rely on that...

I thought gcc-<N> executable should be linked by `brew-install'
itself, no?

This patch applied on top of the patch you replied works fine!

> With your changes if none of the listed gcc-<N> binaries were
> available in PATH, then we would silently build with the generic 'cc',
> which is 'clang' on OSX, and that's definitely not what we want.

I'm addressing this issue with a change in ci/lib.sh below.
By adding /bin/false as a fallback.

If we could agree that the previous patch and this patch, together,
could be good, I'll re-organise it and send again later.

Either that, or squash this into the previous patch

--------8<-------------------
From: Doan Tran Cong Danh <congdanhqx@gmail.com>
Date: Thu, 28 Nov 2019 18:24:58 +0700
Subject: [PATCH/RFC] ci: install latest gcc from brew for macOS build on travis

Until now, we ask brew install the specific version of gcc (gcc@8),
but for some reason, brew decided to install the latest version instead.

With the previous change, we're assuming that gcc-<N> executable is
existed in $PATH, we will find that executable instead.

While we're at it, don't ask brew to link gcc, since it should be taken
by `brew-install' itself.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 2 --
 ci/lib.sh                  | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4e64a19112..a671ee1005 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -48,8 +48,6 @@ osx-clang|osx-gcc)
 	brew install caskroom/cask/perforce
 	case "$jobname" in
 	osx-gcc)
-		brew link gcc ||
-		brew link gcc@8
 		;;
 	esac
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 4040fc1a22..02cdb47419 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -131,7 +131,7 @@ then
 		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
 	}
 
-	BREW_INSTALL_PACKAGES=gcc@8
+	BREW_INSTALL_PACKAGES=gcc
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
@@ -160,7 +160,7 @@ export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
 *-gcc)
-	for gitcc in gcc-10 gcc-9 gcc-8
+	for gitcc in gcc-10 gcc-9 gcc-8 false
 	do
 		if command -v $gitcc >/dev/null 2>&1
 		then
-- 
2.24.0.615.g37f5bfbdea

