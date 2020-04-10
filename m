Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07EC2BB55
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8847A2082D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dudRK/UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDJRlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:41:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35957 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRln (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:41:43 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so997460pjb.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6UrbVznnIZadAxBGS2WNCKflGlLCCnfOeGgsqn8vx8=;
        b=dudRK/UJv+4Yv96PCdoOXHFLKPrxkdPMYkwVrUVjOfJAc4RBJbbNlPUflQxq8aYrMH
         /PD9NYTsY2M9QHXs6j0ZI1+vO4G7G2MpWrc12mydDtmwjg/ucalqbrlj/DNmj4MAjdRq
         0X4y/RIaEx+9Z7XoclmQlV0w0Vf68US6JJYrnsy/8ZwnCO6yrnU+SwIOcWZxsjnd2GIw
         +wrM/q0/DDu5lr1ZXbsJyKLHx6NEEKdAjNxkMjTNS+GnojeSbB3XA3mbTj4SJlSv3jTW
         NfbxwmwSBehhVCQToURxojgMOAjig9JJRJ8nYwXjNPa2o3wXFRmFkDRf+oPos3AoGDp7
         T78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6UrbVznnIZadAxBGS2WNCKflGlLCCnfOeGgsqn8vx8=;
        b=YQmhIMncw6aQ+dsEvgQLucnp/Ae+tm7AuhNdBLhfqhxbPvyhfODJ1nZyMkt47liFo3
         O8VZjRUJS17qlA/PFb3yIjH5BF5HpzbW5aeZrLiEQx9mrpIFCfwQ+rDr6TanRU+jwoRP
         yIySeQ2+pgZTjfS/6F3QxYKYX6QK6luhxiBydjQjq/GnOefzH/amChxd+qCqtOZWwKHV
         cb+lsvCjI3t0nAteMldPo8bOwrgHGihkKeZW+CI8SiZMVp711waq3dmCyM1HM5mkdbiY
         z00b5qSjvW11tI3XXAbJEgniJykXUUKZG32Z6aexPPG7PCBS+b0IY/tduEJBhS3McIm7
         +QyQ==
X-Gm-Message-State: AGi0PuYy9mlh2JShMrRMe1B5eJctoHLppcb5w4PGUxehbJlR+eCTfHTi
        pJHZ32M//XfppT/NA4eOhww=
X-Google-Smtp-Source: APiQypI9kEBmfl949jInqWIi4h2vg/qrQYM9nBc/EMS4YY35AoM3drRs3JXGCdbQd03sLQBL65/tRg==
X-Received: by 2002:a17:90a:5586:: with SMTP id c6mr6629525pji.53.1586540503312;
        Fri, 10 Apr 2020 10:41:43 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o63sm2254677pjb.40.2020.04.10.10.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:41:42 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:41:41 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub Actions
Message-ID: <20200410174141.GB27699@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com>
 <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
 <xmqq1rovl54d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rovl54d.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-10 08:42:10-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Judging from two CI runs for 'pu' ([*1*] and [*2*]), among the
> >> topics that are cooking, there are only a few topics that these
> >> tests are unhappy about.  Perhaps those on Windows can help these
> >> topics to pass these tests?
> >
> > I would like to point out that there is only one single topic that is
> > cause for sorrow here, and it is the reftable one.
> 
> I first thought so, too, but vsbuild failures like the one in
> https://github.com/git/git/runs/575116793 do not appear to be
> caused by that topic (6a8c1d17b8 excludes reftable), so there
> must be somebody else that is broken.

Excerpt from build log:

> fatal error C1083: Cannot open include file: 'config-list.h'

It's from bugreport topic.
I've seen this failure in the past (when testing with pu),
then I saw it disappear.

I thought it was fixed during my testing for v4.

-- 
Danh
