Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB8C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5B2415A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuJU7nQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507094AbgJUXh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439511AbgJUXh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 19:37:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE19C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:37:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so2046905plx.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CQCgQzjuylGVTvOdzSrpG+2Om02uZHIi5RK8Bz10hk8=;
        b=PuJU7nQTM6KX+MsPCUhvSMIJJ7OsXmJYXg9DjqLUPXBA0wucNcLmQhr/wI4K4HKhjz
         UCpEmGR9R/IfpuLHAU/F05gidMsB3Kshr+R3U4tAzn8JKXcXDQ1dgGSNTxUxSddrPBbS
         TsKivb4NQFAyHb0cRZNk43ECc1gGqTCGhiPTr+ZAIGEOhUiHxhSvv6v2qya2Jlr7/BPn
         JUSpBuUWG2LxRqmm+Wf62Qeo5M3YdRj2Jg9DUBBr1I967sMPQJVqzFicgvSNhLx4nd4M
         eCsoa5r5y5HOP8Wck0+DVypVvQaF/smXOgezJt6/DfPMAsLah8gxDUWAIxbn0cPO5pXA
         uZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CQCgQzjuylGVTvOdzSrpG+2Om02uZHIi5RK8Bz10hk8=;
        b=qugfrO0f1EYC4zp9sPHXk2Nnxyx9Kei102ckjj+7+IOMaKyjtOVLzebf+EgttGOX3l
         HdBpoRtxvkFSX3KmFf1sj3ntAsF87Vk6ItqQ0Qiks2VkgRbWwz9LGPSK+UGmNHImLXnb
         wW+2Mor5+l0z2LaOW9hxE4lKTxVbVl0U2kRN30PzUiU/nLjgdhk15tx1t1rK7VQkqqdN
         +fGRXUwNQUgKvdG9mZNp+Yq301UJ5zaJ9n0KFBWgMudRxUoCBk5uY5OVEupstdCgXCgX
         0xH/uEYCc7mb6M7Q3nTZ+e2WPmCkfvLtI5jaSMAD+PbD6MrlNh1nJ4a9ln+88QE43YOL
         PZAQ==
X-Gm-Message-State: AOAM5314YbF3b5AL+NuTVCJAIlkfO+Q2gv5ndUbz/IawsTxbI86HLniz
        /iLSDCxuxlGPQlnzCZCv4rgIadxRpxiXGA==
X-Google-Smtp-Source: ABdhPJzfOwdR1yynB4s1gj7DBJJ/9SPyu0DNxd/epKSaMqKD8oYnfPphZhXDDiTGuWt6eKcylEHrbw==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr28059pjb.116.1603323475167;
        Wed, 21 Oct 2020 16:37:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id w17sm3433844pfj.33.2020.10.21.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 16:37:54 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:37:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/8] doc: propose hooks managed by the config
Message-ID: <20201021233749.GC2774782@google.com>
References: <20201014232447.3050579-1-emilyshaffer@google.com>
 <20201014232447.3050579-2-emilyshaffer@google.com>
 <87d01jih7w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d01jih7w.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 06:31:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Oct 15 2020, Emily Shaffer wrote:
> 
> > Notes:
> >     Since v4, addressed comments from Jonathan Tan about wording.
> 
> I had some extensive comments on the v4 here:
> https://lore.kernel.org/git/87mu0ygzk1.fsf@evledraar.gmail.com/

Hum, it seems I completely missed it. I'm sorry - that was very rude of
me! I'll have a look now and reply there.

 - Emily
