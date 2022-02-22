Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC486C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 19:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiBVTgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiBVTgB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 14:36:01 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09687B4A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:35:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r7so16202550iot.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mrRW89h3xwE3VOC5kSzYp8pGGmPV1YcIdjOHz3y9Zs=;
        b=iwviH7ilNsR9pTOoSATQddRzs5zxaFDZiq+tcuijNS2pI9d/pdLhKNGGw18e4SsOaL
         wfNKoal9Vg94cl4hYqxU0u1X4pyQxuv9CPnD8mZinYB5uPiDUuz88gShuLG0lQFdXFaL
         +UWdGRvDjRpjBOWNJp7Yn9Yf7EmuyB9MzPb4jCS0xefunTyCfWmwMI6Kjh1RaJZptRA+
         P43m0ZvgGOdtPxRhdEzKkBeJKYJfTu87JynlAxdUXkqMo9Zzc0XcrCBgPdAzYVK99sXm
         XW2AtzjzzYpRKIJ+fi61DN4oZZvqcYnyOhaFb5nLGqsYymsvVgyunRxmGozBjVsTRWBe
         m7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mrRW89h3xwE3VOC5kSzYp8pGGmPV1YcIdjOHz3y9Zs=;
        b=X78Iq6ekZU5h1m/1ONCrwaUeq5sDPz1emRrVK/THCuyqsOmVZwF/BYV6MWDb7T9Ph9
         ArR787iNMldFq9LscM9LPykNd4DPc/IYtPCgZRcMGkx2DLIRsq+U/svUYrVEEvL8CQ6p
         BKH/ybzxArK9cJEm2tmeJ4yXNgaS1Z7duaUV8xLl8LDdGU0HId5LVuR766uvDfN4lwrK
         7zZqJ4WTm67RI7xQ6zGaglh3dcx+nGirYJ2IS3C1eiiDf+TdOaleLQzS/jgyMiGZkCDc
         jlYgFdneuV0SA0Eiu0vRVx/crNBo7HdvFSN8lHLnw23FSAZ5CFDFuf68gmsN5ENZ/csV
         d2lQ==
X-Gm-Message-State: AOAM530sAHRysp80FSZVZcIwtA/TtdR0kb+AdSfzPxtlJqJmNLsM8eGI
        jMcKnrUMDmaHadQAW4Fpv+REPQ==
X-Google-Smtp-Source: ABdhPJzwJ0CA/jAegiIlecOiqWTrBHlDS34LLrZvYALt553zOpyuNXn1gdU/6TX7LfLgjQhOm+b63A==
X-Received: by 2002:a02:cf26:0:b0:314:c65d:22ab with SMTP id s6-20020a02cf26000000b00314c65d22abmr12842697jar.183.1645558534161;
        Tue, 22 Feb 2022 11:35:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11sm5567059ilg.53.2022.02.22.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:35:33 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:35:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhU7BK5uOS5OK/ZB@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CFECF0B1-A94F-4372-AFC9-C0469A17E9A5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CFECF0B1-A94F-4372-AFC9-C0469A17E9A5@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 01:52:09PM -0500, John Cai wrote:
> > Another option would be to prune the repository according to objects
> > that are already made available by a promisor remote.
>
> Thanks for the discussion around the two packfile idea. Definitely
> interesting.  However, I'm leaning towards the second option here
> where we ensure that objects that are about to be deleted can be
> retrieved via a promisor remote. That way we have an easy path to
> recovery.

Yeah, I think this may have all come from a potential misunderstanding I
had with the original proposal. More of the details there can be found
in [1].

But assuming that this proposal isn't about first offloading some
objects to an auxiliary (non-Git) server, then I think refiltering into
a single pack makes sense, because we trust the remote to still have
any objects we deleted.

(The snag I hit was that it seemed like your+Christian's proposal hinged
on using _two_ filters, one to produce the set of objects you wanted to
get rid of, and another to produce the set of objects you wanted to
keep. The lack of cohesion between the two is what gave me pause, but it
may not have been what either of you were thinking in the first place).

Anyway, I'm not sure "spitting" a repository along a `--filter` into two
packs is all that interesting of an idea, but it is something we could
do if it became useful to you without writing too much new code (and
instead leveraging `git pack-objects --stdin-packs`).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YhUeUCIetu%2FaOu6k@nand.local/
