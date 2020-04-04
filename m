Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5EFC2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 23:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECB320672
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 23:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf7jaKNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDDXzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 19:55:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34097 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgDDXzb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 19:55:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so4391843plm.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYLq/GS35xXJYprHpknbUVuKE3Co4R7/Y1Nswbfo+Xo=;
        b=Kf7jaKNgxWAoQcAtqkjcm22zHoKdJeQfb2wPF6YTyyr+nkDpnCjk2Gq3qTrNmydyr5
         fOVqCT5ct9piVahMZCGpH5KGRiv4n65FLONpGMvtlYVjNm3PR2uJtLbpte7PRnRi91Cd
         tAG6ISL6/mcqzZrW6NvFtR3N9WU7BMP4mnNFACS26gOklQy0tJF29KvNE+8eQkqkgXTD
         9zTE7ceE/X13H9RvR0I9hSbqLJCZ1jWUrgEyE6vh3OOYiM4Ub9G+2TDl19AnMWk+jTB5
         3W+dnpWDuEPkHoTDGhycjSfiTlAVRr0k+sLfCg/Tkw/dSdii48u8J/QrBh48MX2x91bM
         wm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYLq/GS35xXJYprHpknbUVuKE3Co4R7/Y1Nswbfo+Xo=;
        b=nhMN123erF2L2vN6sW5yzdal4eLHLMTwDMgbsO/m5m/aSe3hdZt4KYc95IzzOYU1nW
         z5ANMD6WYLOJkhVDNkdGLq/lL2TrwT8nvg9CcHa2OgkLgova3gPN2YRJ9wtGTem9/iQ5
         MFzn9jjR/FBQOHC2EH8bmnYCeyrJIJAMzYbF74OqXL4sYJD1E++AK23Q951RzyTY7C7A
         MA7OliHW8zCkWshH3nM2wy0uiklBTLY2MK04HE3FkWevOtZd2n0KS9BQEYHP/1RPGAoq
         cDEGzOPXqrD4KBK2KfNf+2Pq+HV2mzCzE5I4T8F06+nk3F/K20ACuhxxL3BaW+ooP1Sp
         Mn1A==
X-Gm-Message-State: AGi0PubvC/jlVx9zV8Dx8s6mMAJoM3jt6A6ZDHzEOioWMA9Y4FsFuFWO
        SEXYRhtmiUX37ZLKEihcg+c=
X-Google-Smtp-Source: APiQypJL242Ohx4+S6au+KBcLXknxJLGVv7sUIxkLzJMTT6OXtsmmz2XI/6CVIgbhBWs20n0bjg60g==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr18218778pjb.146.1586044530334;
        Sat, 04 Apr 2020 16:55:30 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s39sm8797832pjb.10.2020.04.04.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 16:55:29 -0700 (PDT)
Date:   Sun, 5 Apr 2020 06:55:28 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: configure GitHub Actions for CI/PR
Message-ID: <20200404235528.GB1896@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <36621bdd31a53046450f73ed197585469b1a1b96.1585658913.git.gitgitgadget@gmail.com>
 <20200403220732.GL2224@szeder.dev>
 <nycvar.QRO.7.76.6.2004041952050.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004041952050.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-04 19:59:37+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > +  linux-clang:
> > > +    runs-on: ubuntu-latest
> > > +    steps:
> > > +    - uses: actions/checkout@v1
> > > +    - name: install dependencies
> > > +      env:
> > > +        CC: clang
> > > +      run: |
> > > +        sudo apt-get update &&
> > > +        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
> >
> > Why install all these dependencies here, when the very next command is
> > 'ci/install-dependencies.sh', whose purpose is to install the
> > dependencies?
> 
> I copy/pasted these from `azure-pipelines.yml`, and agree that they should
> be handled via `ci/install-dependencies.sh` instead.
> 
> Danh (is this the correct way to address you?), if you want to have a look
> at that, go for it. Otherwise I'll try to find some time to do that
> myself.


I've managed to fix this part in the v4 series (only send privately to
Dscho, because I'm waiting for other conversations to settle).

-- 
Danh
