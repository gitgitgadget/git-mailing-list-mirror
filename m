Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA4C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398B060F25
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGWTd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGWTd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:33:58 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B370C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:14:31 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id y11-20020a4ade0b0000b029024b4146e2f5so672517oot.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HYhoI5cn+n7bAkxJrZxSl02rsKeijMqN/NBFPW0CUKQ=;
        b=LF6VDX7vGQUQe1W8023AEkj6GeKovzE2PAMhevFE8YQQrIArvNkBohUn5m9d/omfLE
         24upRbpun2halkWY4Op9+6hMztoExanf5YLQPmWAOxZnOjZOTOGZvU0l+e8j8l5mdckV
         jrGwTNYYuZ7sMCWo1f7rnhcAjMwjrngPVwS2dcx2Oc+vXI7uhFbj8kCr0K9Qy4OGXft5
         9hH8zZuRe/rOaTGnzYizqfMk2DGV60gdKCwJAlLLQ5OiA6wnoCn6XbAKvMMtG2DHWM5q
         iFqKPsSp+N70KIxE9xQeTnQnK8Hzqr6cGppwlS3fUv83U5oniMmYGUTOnbrttqydI005
         ZKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HYhoI5cn+n7bAkxJrZxSl02rsKeijMqN/NBFPW0CUKQ=;
        b=P7aI0vGIQZUV2quu7x5tw5WInKpGscGKXX0E7Cluazg8bDRhhJIsSzQqa9a5No4P5J
         Pyj60VOH5t1L2zFJN40J20Q4uM2M/qAgW5DHwXsg4bL3alj6DWxmkU8sFE7+DUBVvjIU
         zfnOazLpJyxBOYPWgSAF6V9TUaXKMLulVbPlZiMEQwGT772AyItJQCAGvq6GvZPDIAoZ
         WYP7rCgnKBVZsvkhZ0hXBhsQMiLpeTm5ofemiky/edoVA8+jpaGdunIX6gxTG6XCLvQy
         cna98WuiRDtotaMOA2AjXcKaLC7M2ry/nmiNREolKotFm9kyHfo4bGWgJvNt8sCQHGW1
         74bg==
X-Gm-Message-State: AOAM5324xO0HxI28DsYPh+250C2005auMUp2hHwAIrvrFZThIUQszBCQ
        AxBbErcD8HglryQBUyLcVxU=
X-Google-Smtp-Source: ABdhPJzPuBttluG/n13yD5KbONjjjAgg8MTpfaGw7kCJKObphYSVgdckJq9r3Ss8NYJodhlYfQ49eQ==
X-Received: by 2002:a4a:b98c:: with SMTP id e12mr3753829oop.67.1627071270520;
        Fri, 23 Jul 2021 13:14:30 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r5sm2328468oti.5.2021.07.23.13.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 13:14:30 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:14:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60fb2324ef527_1073e208f4@natae.notmuch>
In-Reply-To: <b5cdd34b-c50e-f6f4-4462-c869836d309d@iee.email>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
 <20210722000854.1899129-8-felipe.contreras@gmail.com>
 <76d59e73-ae5d-3bef-4aa3-5d1af9611577@iee.email>
 <60faf81658201_defb208d4@natae.notmuch>
 <b5cdd34b-c50e-f6f4-4462-c869836d309d@iee.email>
Subject: Re: [PATCH 7/7] fast-forward: add help about merge vs. rebase
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 23/07/2021 18:10, Felipe Contreras wrote:
> >> It is good to have diagrams for the visual learners!
> > Actually, it seems there's no such thing as "visual learners" [1]; we
> > are all visual learners.
> >
> > Cheers.
> >
> >>> +    D---C---B---A---M master
> >>> +	 \	   /
> >>> +	  X---Y---+
> >>> +------------
> > [1] https://www.theatlantic.com/science/archive/2018/04/the-myth-of-learning-styles/557687/
> It's a double myth, in that many try to suggest that a person has a
> single style (untrue), or that a single style is relevant in a
> particular context, when it should be that sometime individuals fail to
> learn (a particular item) when not provided with a particular style that
> would suit them in the moment. I.e the removal of a particular format
> (e.g. no visuals) will reduce the effectiveness of the manual (excepting
> the 'The pictures are better on radio' aphorism ;-).

The myth (as I understand it) is that people have a primary learning
style (e.g. "I'm a visual learner").

The truth is that everyone benefits from multiple styles.

Either way--myth or no myth--I think we can agree it's better to have
both text and visuals.

Cheers.

-- 
Felipe Contreras
