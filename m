Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1676DC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 15:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C057D2166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 15:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzrov1if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDPaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:30:11 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50893 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCDPaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 10:30:11 -0500
Received: by mail-pf1-f201.google.com with SMTP id r13so1638533pfr.17
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 07:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VKyXR1qGTDGp0Tl52iW3QQfcapJsBjKasMKbK+GeBrI=;
        b=jzrov1if2+ZWxqCqQGtDuQ8u6EKwZj9dwhZ7PdL1faJKNGp4uu0nclL9VMpzrQXLgZ
         hRsQWnzt0wRwhHmk5Ud4mFlDZprJlWedOT/pILFedoj7Ugjbtm0iVDcv5nmDjKpOFzdD
         aJYfUVUQz9Z3a+PsX8mkpYTiWisBT46pRfu4mPuy1lw0eby8za9amC0tNSEBUYtJXi9C
         cJO5h++Wpg0wxK91/bEAxb1F+Ed1vTd1qPvYPMGXiHmQgjRqPOkTCVXYT5qKDWAcp7wm
         WHLZo9mHV266jbizTtRWAuz2ip0olUWcVBJXrBHAeHJ1ycoZ16sM6udyq5mklmf+dZQw
         9vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VKyXR1qGTDGp0Tl52iW3QQfcapJsBjKasMKbK+GeBrI=;
        b=sT042Y3bRZLzqFhZvx+BZYzS0MIPAN+FmYWzvZd1ZVwNosSqTO6WBpoTo3PjUgRlMd
         wBMunXSvDkoC65zRvdzCtrrgff5FCEwrdikY2haLsx0P+orFZaRFB+whK/JKFJ+4po7c
         /I8/0/nJm3VR3sr8MhTXQPaf3xrZyVVvbXAt36KsoN4fBuEn3m3A2hOqFRaR0+1RcVW6
         EWQN7haytVnn3VB0jf9DzlrZjMx54juPEuyqBMaCKPKU2lpER74kbG230c/vF9n3cdqv
         ZfZLTfQtdTVZcQUe4dvOZ8heAFz6iEHIB62uBAB/Fx1x5xtQP7mxxnYpbvhvgpz+RT5h
         LT6Q==
X-Gm-Message-State: ANhLgQ2RShqeGduPLAz9fWUlEHjwp+RTAUNRWwaK1IVX9y/M1MzlhZgc
        jGsVFLJrKxkiY83RwQUwPSKSmPFU2lfsCBVOecjT
X-Google-Smtp-Source: ADFU+vv9oWKysghdM9wWDY4ugShEob1ELvDL90R0YutYd5Z80p5JYvLIHr3J5d0U+KOJGVBFSoV6Ak2BmjrXsmwy0UXL
X-Received: by 2002:a63:7f09:: with SMTP id a9mr2988033pgd.375.1583335805178;
 Wed, 04 Mar 2020 07:30:05 -0800 (PST)
Date:   Wed,  4 Mar 2020 07:30:02 -0800
In-Reply-To: <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
Message-Id: <20200304153002.233661-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     heba.waly@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > * hw/advise-ng (2020-03-02) 5 commits
> >  - tag: use new advice API to check visibility
> >  - SQUASH???
> 
> A local change that needs to be squashed?
> 
> >  - advice: revamp advise API
> >  - advice: change "setupStreamFailure" to "setUpstreamFailure"
> >  - advice: extract vadvise() from advise()

This just means that Junio has a change that he plans to squash. You can see it
in his repo of Git with all the topic branches. One mirror of his repo is here:

    https://github.com/gitster/git/commits/hw/advise-ng
