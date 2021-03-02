Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA74C4332D
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D34B64ECE
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhCCGdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350272AbhCBShK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 13:37:10 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FEC061797
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 10:36:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s18so13942298pfe.10
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m1dj6A90T2cx77KIN3sr7gUYSAalDAOGHqc1m/O4lE4=;
        b=Z6CvQy+YlzQLICGfnAQ4VXMBgbrtsUNIhZTNJRnsYZCZwDZVTziNvZoNmjzYPNEtGk
         elLWBJ8xD6RivDTlONNWc54JajJIo7vmkynkUsL3KgfWwyxZ7zIX8h1qXjefH/Y5HPl4
         IDQ3XNF8In3x/gzXiTsyWUZR4ZDw8H4DVU20LtI3fGGWuCAbeXHN3o6+IDdG+dXMz87J
         2H2I9lMMiezNygYmTrG6NA8z0mqlhFxUfuTQtpkjjw9+ExvNOtlRUgbA9vK07HFNH1Ir
         P6b75BL09exS8jJBu7VeEXR4/6AxJ/nMKnyo+IEOfNk4+9RjWP57oQ3cfnHKnaTsyrKR
         KmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m1dj6A90T2cx77KIN3sr7gUYSAalDAOGHqc1m/O4lE4=;
        b=geqezWRnlvnLgnV8mXtk9z1TI+KMDwcS7d6+C/zT5E7eZJ/dSHReLANgPcGoR6W/af
         RbgJVFogAJ0MkP55IeTdquiyQuCNol5Zsp2hOTND1Jrkfc3r5TAmGZhI+Kk1SxYo1Aez
         9Rty08wfub1sLMnKWspxKRq/CA1drO/RzHEqlax0SPLAkNrRodWVsblBfbm+QCD7Itwn
         GxApcsh4GdnDI6U1ZFone+d/OSR/MYDTYpMQol7F2vBkkDCEdkipcVKNGfCqDmAMQVe1
         yWO/k4Y84upyo/VTfZAnFtKqDHeXEXjMMMyhvWpe7LFbAEJHceWL4CSDumjTbDArywN8
         zgCg==
X-Gm-Message-State: AOAM533uF2kloBv0RAEwzQCBGEhT7dKqNCinAh3d2wKWcrz78tcSId8z
        kUTM6BTkGv7c71rh37x3KF1fB2Bp3UujzWlGTi+d
X-Google-Smtp-Source: ABdhPJySESOuB3wOqlAW2nGiSA0fdk+9nlNOer99eoEqYrD1oas9V9kOevwkOi9h1lkVnYq4HPCAaCFuYn9MT0YDRLie
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bc87:b029:e3:f6a4:db39 with
 SMTP id bb7-20020a170902bc87b02900e3f6a4db39mr4665598plb.25.1614710183703;
 Tue, 02 Mar 2021 10:36:23 -0800 (PST)
Date:   Tue,  2 Mar 2021 10:36:20 -0800
In-Reply-To: <d4e01a44e72998f88dc253cd04845ac2e6bb165b.1614193703.git.me@ttaylorr.com>
Message-Id: <20210302183620.11040-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d4e01a44e72998f88dc253cd04845ac2e6bb165b.1614193703.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 13/15] pack-revindex: read multi-pack reverse indexes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> midx_to_pack_pos() is the trickiest, since it needs to find an object's
> position in the psuedo-pack order, but that order can only be recovered
> in the .rev file itself. This mapping can be implemented with a binary
> search, but note that the thing we're binary searching over isn't an
> array, but rather a _permutation_.
> 
> So, when comparing two items, it's helpful to keep in mind the
> difference. Instead of a traditional binary search, where you are
> comparing two things directly, here we're comparing a (pack, offset)
> tuple with an index into the multi-pack index. That index describes
> another (pack, offset) tuple, and it is _those_ two tuples that are
> compared.

Well, the binary search is indeed over an array :-)

I understood that the array we're searching over is an array of indexes
into the MIDX in pack-pos order, so I understood what's written here. It
might be easier for other readers if we just say that we're treating the
elements of this array not as indexes into MIDX but as their
corresponding (is-preferred-pack, pack number, offset) tuples. But I'm
fine with retaining the existing wording too.

The patch itself looks good.
