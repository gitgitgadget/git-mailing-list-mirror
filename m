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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108CC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDFC21787
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeFlo8WE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfK1MdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:33:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37188 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1MdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:33:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so11477958wmf.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WOkw52ljb7D1I67GDBxxbOzgyFGqR3+1DRd0benVzsY=;
        b=XeFlo8WECAaquMmJN9pttv0uSZIFygiCrdwXiCzU2YBdC3bTlqj+EqwOomMugTgb1i
         NWzOV3CfkjZHIwoPL9x4bbmuhkI+cWCubsWrREmasvnQrqOhK0Tz7An+70h7W6MoPO/W
         nqiKwL9F5waAXgtxnNCLl0EUe2yX2xw2WMuoc91FiclTgVqb1Bhsso6My2m9U47fhgq6
         vVHdcLhSeXqh591eZMmVLgPtfo4EVMNId2TTG0Kliv061GYC/IaLF/SghZLYfmTYXPtZ
         MYTfbO9zb97c1iC6/led/cg7n6ecQCTijpw16BDt27jzN+0wpyGX4+p43DB+hJlyrGQZ
         m56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WOkw52ljb7D1I67GDBxxbOzgyFGqR3+1DRd0benVzsY=;
        b=h8ECgl30DQ9ABI3v1/HR4aaF+PFa8xCu3NKg8ixCDBLHOfJCHAE76xP0smGuXioArI
         FH62sBef0Ra0NG2bUQsssVPhZg1OuMc667X75evduaFCOYUbdJvkp/aAXxntA/7XMZB1
         lwU73JFxfI2nR+qYLsY1uorOrgqb+HoGQEmlrKU/csxDLk5uGf6FqDnb4artpusj8zxW
         Aw8AwnGyW7cfLQAXyS5ytrcY6X+k+cxOSO61I5S7lljAbZApkhBFc1djULbyWDu98hfN
         VW6ARHyK0HNBuaRZn4yvJq+DZYEJRvuWHdTrJ3/gjGvysguI4R7m0tXDaMVc6rW7HV33
         t0XA==
X-Gm-Message-State: APjAAAWJdolYAX3daou1pWLGaJfHq6l/A1PelxnA8Dy3CICxWJhJZ4XT
        bKVRP1Jh6FHorwwnLNex58rsjOnT
X-Google-Smtp-Source: APXvYqyOamqXhpxz4ycVj5NadYg4FhJkfRQm0ZuNRWzPHwPRljC/Vl4+2xWADPcj+kCYSWeawRBpeg==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr9796693wmc.81.1574944399848;
        Thu, 28 Nov 2019 04:33:19 -0800 (PST)
Received: from szeder.dev (x4db4186a.dyn.telefonica.de. [77.180.24.106])
        by smtp.gmail.com with ESMTPSA id a24sm8014561wmb.29.2019.11.28.04.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 04:33:18 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:33:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: detect installed gcc in Travis CI
Message-ID: <20191128123316.GG23183@szeder.dev>
References: <20191126011536.GA30006@generichostname>
 <20191127161555.26131-1-congdanhqx@gmail.com>
 <20191127164820.GF23183@szeder.dev>
 <20191128120330.GA9067@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191128120330.GA9067@danh.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 28, 2019 at 07:03:30PM +0700, Danh Doan wrote:
> On 2019-11-27 17:48:20+0100, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Wed, Nov 27, 2019 at 11:15:55PM +0700, Doan Tran Cong Danh wrote:
> > > Travis CI has continously updated their images, including updating gcc
> > > installation.
> > > 
> > > Save us some headache by checking which version of gcc is installed in
> > > the image, and use said version to run the build.
> > > 
> > > While gcc-10 hasn't been released, yet, add it to the list to save us
> > > some headache in the future.
> > > 
> > > Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> > > ---
> > >  ci/lib.sh | 24 ++++++++++++++----------
> > >  1 file changed, 14 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/ci/lib.sh b/ci/lib.sh
> > > index c8c2c38155..4040fc1a22 100755
> > > --- a/ci/lib.sh
> > > +++ b/ci/lib.sh
> > > @@ -159,12 +159,21 @@ export DEFAULT_TEST_TARGET=prove
> > >  export GIT_TEST_CLONE_2GB=YesPlease
> > >  
> > >  case "$jobname" in
> > > -linux-clang|linux-gcc)
> > > -	if [ "$jobname" = linux-gcc ]
> > > -	then
> > > -		export CC=gcc-8
> > > -	fi
> > > +*-gcc)
> > > +	for gitcc in gcc-10 gcc-9 gcc-8
> > > +	do
> > > +		if command -v $gitcc >/dev/null 2>&1
> > > +		then
> > > +			export CC=$gitcc
> > > +			break;
> > > +		fi
> > > +	done
> > 
> > This assummes that some of these gcc-<N> binaries can be found in
> > PATH, but that hasn't always been the case in the past: up until end
> > of last week Travis CI's xcode10.1 image came with GCC 8 pre-installed
> > but not linked and without GCC 9, i.e. neither 'gcc-8' nor 'gcc-9' was
> > available in PATH.  While now that image does have GCC 9 properly
> > installed, i.e. 'gcc-9' has been available in PATH for almost a week,
> > I wouldn't want to rely on that...
> 
> I thought gcc-<N> executable should be linked by `brew-install'
> itself, no?

'brew install' does not link already installed but not linked
packages, but instructs the user to run 'brew link' instead; see

  https://public-inbox.org/git/20191127162416.19391-1-szeder.dev@gmail.com/

