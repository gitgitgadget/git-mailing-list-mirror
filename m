Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C75C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 05:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357328AbiEGFXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 01:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEGFXL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 01:23:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E211F5FF1E
        for <git@vger.kernel.org>; Fri,  6 May 2022 22:19:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id eq14so6853531qvb.4
        for <git@vger.kernel.org>; Fri, 06 May 2022 22:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4w89vxJmWkNza34uRWOBHxvRB7NkHSkJiXl/5P3SKeM=;
        b=AM5ED3iaGUs2tXoP0uAdZI7bxvLYs1VqXxkTc20u2i9eK3II4ewrX675CEgawAdMjq
         UFDLTg/fpqxLm2GLQWvuyK7B49NKSqXtqkrCtavyD95q0xqaXKWPXPYuzxSTlMrzZ4Lm
         7MuBjsTn4tHe/385BfGZ5Obb6OY5Hqs60htYKTRmnSyy1i5KaXhDU6UejN5Wa1rwa9HD
         BS+FwdVt8zL24gAiuup5yrzMK6YTz6XZFKjl00PgqhKOSWR2ulFIm6i/adgXkZIDbZ+8
         bKTMuqrSP7OheLTO37K2aqxaVTuGNHRMpMNdom7WqhxLaFlDpp5Ct4bokVRywu5VPT7V
         UWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4w89vxJmWkNza34uRWOBHxvRB7NkHSkJiXl/5P3SKeM=;
        b=cocDdHdmT5tpdiAcBoun74gR9fENyB2LBgL6g+u5Ve/Csg4uu2bMJ/paLCkh396gdc
         UH8J9pG9v4m5JZIXj/jUBc+rIJok7/naoTnvzBpn/+ie+ZCdCbpcU+4qhIfRUqEH13pe
         5V2ANwpQqQQDngt5ePojElWFsZKgDFdmejUaP1+u4L9EK0ozlgI+uXgN4IB0XDYY1Bx7
         muXy21n3H5g82Eu/fWMBee/2gfNVEEdIbaJLrqEpsCpauR/5dejD2TXMTTKn51rd1U5H
         k/4J+tdJY6jFJlt5VBr4jU8aSPHioprpnKwlFf93YejEvvoEMXB2HvvgpVps2lHoY9wW
         qdzQ==
X-Gm-Message-State: AOAM531bzoWG2itJ+ehYcKZB1q6ynzl6fwgbEB24BzrfJo6mxAv8xilF
        4mh0FYuLcBlNO/nucpDb50fJpYkJy24=
X-Google-Smtp-Source: ABdhPJwwebphnA56pPXm9bCV3569smxmS3lFa4LFrxSLqgFmHdpku5qP0bLjXkUKKFZh6UlBOiRxiw==
X-Received: by 2002:ad4:5742:0:b0:45a:f846:9b31 with SMTP id q2-20020ad45742000000b0045af8469b31mr846802qvx.30.1651900764939;
        Fri, 06 May 2022 22:19:24 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a13d400b0069fc13ce24asm3261845qkl.123.2022.05.06.22.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 22:19:24 -0700 (PDT)
Date:   Fri, 6 May 2022 22:19:22 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jason Hatton <jhatton@globalfinishing.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [Email External to GFS] Re: Git status extremely slow if any
 file is a multiple of 8GBi
Message-ID: <20220507051922.6vay4yk42uraqah4@carlos-mbp.lan>
References: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
 <0d78c98a-841e-719b-add3-acc7a7a2d7c6@web.de>
 <9b6b7ad0-df90-62e0-abb1-c23862ded4ac@iee.email>
 <CY4PR16MB165558026798A6E51E6A005FAFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR16MB165558026798A6E51E6A005FAFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 12:22:36AM +0000, Jason Hatton wrote:
> 
> I have a patch file, but I'm not sure how to actually submit it. I'm going to
> attempt using outlook.

While I haven't used it as much as I should, gitgitgadget[1] allows you to
send your patch through a github PR if that is your thing, which is also
very handy to keep track of feedback when there is too much of it and you
prefer a web interface.

Carlo

[1] https://github.com/gitgitgadget/gitgitgadget

PS. you'll need someone to approve you, but I'll be happy to if you don't know
    anyone else that might be using it.
