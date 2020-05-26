Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9CC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765D920849
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLc1dj8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbgEZXQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 19:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbgEZXQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 19:16:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D6C061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 16:16:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d3so9351452pln.1
        for <git@vger.kernel.org>; Tue, 26 May 2020 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oIL80/JAa6PxPtuvnWyCGKQP0HHgx0IkfEKqVUH3KUg=;
        b=RLc1dj8i1Dd1U7lzN++62GKbpsqQmksWlo0ULQD+ZEizmWZURzeYe7kPpT6MfAb1jg
         GSqNjtNozvhRc3l8BZX40MO6nh4C6fyxgKVV/AK2t4OkN2v+SmvJFF4Yv36ij14Fu5Mn
         8UV3cinXbwhsIhl/DXYq5MZMA6y/vrdSHFgbRLVDHggYRET349L4xXenxjjm+xUCti5t
         IcW7QrIlocaqYvB1V2GsMWI1rQ970q+84xuAhPR2BYNbJW29/M+VqRwhK152YyTCVBaD
         2ffmnAmpqD5cIQurtzTi5KeUzh19CoLKh+oi/LJrZR/wQ6yn/mWNjx5ggOcyLHK3gqsd
         IMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oIL80/JAa6PxPtuvnWyCGKQP0HHgx0IkfEKqVUH3KUg=;
        b=L6/+1Zk3kRVu9d7HM66mDMLE41HbS6Z87obkxjQhZIjfwXCFqjYYlNJiRChj25KpRn
         lU8d6FM40sDwOsilUGAFr2c9pRiU67yV9cWkmqGiRJVlXLPvvV2w9akNcu36MQkUlmy8
         mhR0XTf7qI1KdmCtr6nz2KvSEInqm8Bg+Ayr+Mq/5Ek9OCbmT4Xgql3sh8AUSJSFsLmm
         ptEwqdvreERED2xjU0pkBtwt+P2RkHsgq9rNHdec0jprzzh8L+fzJlJRDLA8gxBbsptA
         Bnh74woVbKiYiCnTEC+w34SH9+PnTvfhkR/Hu+F9PDR2tiO34Hm6yKxJM9AF3Aah4eVA
         po3w==
X-Gm-Message-State: AOAM5322RhBZcXOtde16qfipqdI/xojvV1yZjdHbyhaLiUt5j+Tr02J0
        9frx5vxuCcrfhKKHdf+OrB0=
X-Google-Smtp-Source: ABdhPJwIfAKSRZmnB+ObWiLHD4Bz5F3/4sT3KiGJyf9uGKrLPh27vDPE7R8BFyj/kw+jXRkufW71ew==
X-Received: by 2002:a17:90a:d713:: with SMTP id y19mr1505412pju.113.1590534980191;
        Tue, 26 May 2020 16:16:20 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id b63sm489782pfg.86.2020.05.26.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:16:19 -0700 (PDT)
Date:   Tue, 26 May 2020 16:16:17 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] reftable: technical documentation link fixes
Message-ID: <20200526231617.GA40564@Carlos-MBP>
References: <20200525210232.87550-1-carenas@gmail.com>
 <CAFQ2z_NaCGypqPD6V1k0eXWQYnCm5WE_wz+6vJURd=Cc6nHA4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_NaCGypqPD6V1k0eXWQYnCm5WE_wz+6vJURd=Cc6nHA4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 08:53:08PM +0200, Han-Wen Nienhuys wrote:
> 
> What do I do now? Does Junio fold this in, or do I have to send an
> updated patch series?

since the issue was introduced with 27eede2922 (reftable: file format
documentation, 2020-05-20) which is already in next, then Junio might
just add it to the tip of either hn/reftable or hn/refs-cleanup and
include it with the reroll that would come after the 2.27 release.

if you have other fixes and are planning a reroll on those branches
then it might be better if you squash it in and therefore avoid both
the bug and my typo in the commit message.

Carlo
