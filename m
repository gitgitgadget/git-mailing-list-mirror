Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E11C4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0750860233
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFCCsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:48:16 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:43841 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCsP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:48:15 -0400
Received: by mail-qk1-f179.google.com with SMTP id r17so4591392qkp.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BS4Osus8r/uulwkv/1Ev2i4HFw8voOAw99SsJJuw2e0=;
        b=Vn+OXpc5pUn/gDHFekt37LXUohK9oQWDYL6jfmf36VegGNxSFY9vX6QXFe043tIMez
         CQu5OgTbkMNGT+MDskLeMc0e/7wWduzAjKHe1hppvZ1HGEwtEc1BBPhoLHAM/duZBHpX
         jRID8x/p3dO8zTrGeiT4OHECenVGYtK072iDeEdjo4nedIdnncAobrrorXxgFe7+K2Y7
         jdDQtmqlMH8h2dZl07/RFHv6L4Bkz3MtHHkkV9/AsK4lS6iL9Wl7eF/xabipq/6/LRPI
         vuuO1oKrlxbr9QdY5Angy69sxlbhYl+lm7QzPc3tfTKTyY+QNgXYeBrBhYgdZ14u/ZIm
         rC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BS4Osus8r/uulwkv/1Ev2i4HFw8voOAw99SsJJuw2e0=;
        b=b/myDOo4dxj3uos++1W4/GYgp0VD/phxsNcxSUiVLc5zPEAbwAQk8m4s9NZZMNI3Ov
         UdsyK4+P1w9m6OxKNI3thO3TEmUPitXRp5PpUxuPAYJ8WxEyUBJp2Sffbi3o93VnKOBy
         unuFlGw+uqKGS4GNdBfq9B5Zqjq9PDUsuK3oIiRgbIGZoiLlCJAXf/ZdjYprP2Z3U5ma
         vF34Ene6SPNoYTum4mGLiIxhuXx3sF/hBAJQbJ/HUgviJIoea3umpusF33xORgYwY0tJ
         o2oRdTchgp4mvNOVPuxLmp0o7W70UnalYRJlgbEiOuMQiDugI5bhL5PgD9Y+uejjU1xC
         SFzQ==
X-Gm-Message-State: AOAM530U5emu+pqnW1om8U6h8eLpx8HcA3Fr7oqBZkVdaBXyJcpnW6T+
        1DiLo+N+LnSTlJE6eKCZG+tPPw7dZv0+3gRZ
X-Google-Smtp-Source: ABdhPJw7Jy4ti0f8FS1u7qRLAfOMEideSle/BI4IbguFTCIDW6AE/4+BGnuzmIQuAE5LAHRvv5xLyg==
X-Received: by 2002:a37:9003:: with SMTP id s3mr30200117qkd.86.1622688318196;
        Wed, 02 Jun 2021 19:45:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id g63sm1116097qkd.92.2021.06.02.19.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 19:45:17 -0700 (PDT)
Date:   Wed, 2 Jun 2021 22:45:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jordi Vilar <git.kernel.org@jordi.vilar.cat>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: proposal for additional search path in config
Message-ID: <YLhCPMMhD9F3qH/l@nand.local>
References: <20210601113554.52585C06174A@lindbergh.monkeyblade.net>
 <CAE-zgtYTutLZWO63QtqZJztMPqi9eHYQfFu6sda8YDf_bVeE3Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.2106021259480.55@tvgsbejvaqbjf.bet>
 <CAE-zgtZroyEwG1k9y-XXAx2NKPF=Lav4YG+f7mF227FEeuxDVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-zgtZroyEwG1k9y-XXAx2NKPF=Lav4YG+f7mF227FEeuxDVw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 07:36:31PM +0200, Jordi Vilar wrote:
> > I am really wary about the security implications of this. Most obviously
> > with the idea of allowing to _override_ commands. Take for example
> > `git-lfs`: the assumption is that it is safe for Git to call `git-lfs`
> > after the initial check-out phase, but with this feature, it would be
> > possible for Git to clone a malicious repository and _immediately_
> > executing code it just cloned, _without_ giving the user a chance to even
> > inspect the code.
>
> You are again right. That's why I was suggesting the conservative
> approach of not prepending to the default search path, but appending
> to it, so there is no chance of overrinding existing tools.

To me, this does not appear to be a conservative approach as you
suggest.

The only difference between exporting PATH=$SEARCH_PATH:$PATH and
PATH=$PATH:$SEARCH_PATH is that the former allows overwriting the
results of looking up a binary in the path, but the latter lets you
resolve locations that $PATH alone would not find.

Suppose you maliciously included a git-lfs binary with your repository.
If you include that binary in your PATH ahead of the existing system
PATH, then you'll replace system git-lfs with your malicious one, which
I think you and I both agree is bad. But if you instead append the
malicious binary onto the right-hand side of your PATH, then you can't
overwrite a git-lfs already on the path, but you *can* trick a system
which doesn't have a version of git-lfs installed into thinking that one
exists.

So your exploit would just be limited to having someone clone your
repository who doesn't already have git-lfs installed into their path,
which I would argue is just as bad.

> Also, config is not versioned, so, right after cloning you wouldn't
> have this option enabled, so you are always safe after cloning [...]

I know that this has come up in some recent-ish discussions, and I have
not been convinced that this makes things any safer.

Thanks,
Taylor
