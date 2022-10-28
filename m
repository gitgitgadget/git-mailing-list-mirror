Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5AC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 19:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJ1Tyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1Tyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 15:54:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541252465F9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:54:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y6so2509265iof.9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZT3rPo3t/bYKxR19klDlXAVNuYx/JVlJmY09p/OTQY=;
        b=O3DDCz200Qd7JhHMhxy8GOw67yHaD72kNl6/HN5HYySNCPcPJLOrszG4ei17Gun0NO
         Kq4s4SPHtmAKtA8FQIXFTS37D8+LvPbvvA1uer9xMPYhbP3eXyXjkjLCdbSZ0R5VliGs
         jLl+9QODhqFbU+vtveh1bQnJ6U7vvf6JaqRMLu7i1nGux2DXPPbOgpQp4ean0IeCY4sL
         UmWL5kDFKllWZs7wM4VkS8rJNPXGszjSlra+jpk0GKw/d3/d4JTxMuMzmogNi3TlFS2r
         TFtG9JFW9SkfPFTqomx4gKqSl8LaiyttOSnrSPwxqYLcr/+v0PRha0272y5xoyQdEU7O
         U9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZT3rPo3t/bYKxR19klDlXAVNuYx/JVlJmY09p/OTQY=;
        b=bjfMBSigr5UAseSW/WAJcl4NoONPHgdR5wkmNwNfZq0h8nzpxvh1b5X+QvzjGBOhME
         FzfAGdtQdTzvZnlQ9s7liBA294yrvAq44neleywbVaTu0ldGaI3oaDyI/Z613LAibqCy
         X6fGL+2DKMVWkVOiGdTaHW8IGYW/ejqBpBH3Hxv14r2U4HYu050j2wha+wdTEr2CG10K
         1XBhO2BC1P/n5fKIBiSbWtdqkPn+mJhVfU/jGaawogoX7vZSs/3BXymJhGfqiN9W7SiX
         wr7XZiBB1XQr/vayzf2KfZOTrgH5eNPowyDqsaRGGCgulFI5QV/S56XteMW55wmZuUR5
         gqRA==
X-Gm-Message-State: ACrzQf3z1PMCUbOb3IzfXyaZLB7DSUO72mYXDtwwJy59WZqJQihh3ymX
        LnOjm1EH9B4leC5bxT7MkZg3zg==
X-Google-Smtp-Source: AMsMyM4j6cMjPvIBXEzexgSwThHINPtUQOH9xVWd7s2G2Ek+VE4UKw9n0DMlkRp36GYyUQCjdA/h6g==
X-Received: by 2002:a6b:690a:0:b0:6c6:9bb1:a4c7 with SMTP id e10-20020a6b690a000000b006c69bb1a4c7mr588563ioc.92.1666986881639;
        Fri, 28 Oct 2022 12:54:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a056638110400b00374ff5df5ccsm1993397jal.167.2022.10.28.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:54:41 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:54:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/2] Implement filtering repacks
Message-ID: <Y1wzgOTiKdBcBba0@nand.local>
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20221025122856.20204-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025122856.20204-1-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2022 at 02:28:54PM +0200, Christian Couder wrote:
> So there are only 2 patches now in this v2 series:
>
>   - Patch 1/2 is a preparatory patch.
>
>   - Patch 2/2 introduces the `--filter=<filter-spec>` option.

One thing that I wasn't clear on in this or the previous round(s) was
how we handle setting remote.<name>.promisor and partialclonefilter.

If there is a single remote, then it's obvious that we should set
promisor to "true" and partialCloneFilter to whatever value of
`--filter` the user provided when repacking / GCing.

But what happens if there are multiple remotes? Which get the new
configuration settings modified?

I wonder what breakage happens if we fail to do that (and why such
breakage isn't yet noticed by CI).

Thanks,
Taylor
