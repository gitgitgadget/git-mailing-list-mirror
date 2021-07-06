Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DEC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2299361CA3
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGFWUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:20:30 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B07C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 15:17:50 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w74so1044737oiw.8
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=p29l8sfbVAZghwrcqsfUxg/GlYeAc9Fvj0YYO7T5rRU=;
        b=TV8992GgpcfH5OLVfnBS4HhowxigmTsGFCcTyZl4KRkWtE1NF7SwxuEqOWBJ/cS5QZ
         v1Nghfe4tH8z07kg6sGRZQQ1XVn0inClP5X+5JENoiZ5OBgW5bPjrhS3S+GCiyzW1yad
         x6zUfNL2Z78L29vwZmFuPqimJl/qnRZ4GBrFt6AjHVEYY0V1Lls+qjwyC8S4bxWMbxS6
         nLIGmMSPB45s4Z3kw5RbhpmKe2HBtE+Hgw6QpkNQ13+ghCTI5UuhU9LGtnr6JNmiw6dQ
         xSOPClOo+MtMe15gffn++mA49UoR1Ti04LWLYV9kUzWFkMYT+RO0H/ec/dF1Su/dFvaG
         sGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=p29l8sfbVAZghwrcqsfUxg/GlYeAc9Fvj0YYO7T5rRU=;
        b=Wrvjk1IEyKXaG6uoMexpfatDybGmAC/kD1GHTiBo+JrDgzQSs5O0iVUrJzMgzKPFFJ
         Nw3/QqRunUAdBHzMcl163hEaoeaJLX7mseBVYqPWRgjjw9XfGKFldOWLg+Tsee4pjR02
         RjQv00j0M7jcRaYlP/T2YqLPxHc89lS8hH4g86jv1VC6q4LaOX5EgMD4pz1oOcqVrn9H
         Gv6fRPCmOiswyjNl0BPvfYynnOHRZuzugvu2fvhIGsoaKCo8wVEgl5mbv4IICXSiShFe
         nwbmRzcADvOtXALsJWckLLF3Ry6WDENe0qs2vfamZUhjnjHGcXM4fkGljYuaVtpYn+dz
         PMSw==
X-Gm-Message-State: AOAM530OvzXGRptGiSXXI03PnNCGu4T/L7SRTZXGv/fXR5Oa1F8piRIz
        Hiv9E6mAUQwJRh4xE9HDOM0=
X-Google-Smtp-Source: ABdhPJzMx3KCJ7ZSzQdKLS8P3syH5FgzSig7GP2OXvckgFXRR2RIRvJpVGLfunhHvQ2xGzsRHrLjfA==
X-Received: by 2002:aca:d02:: with SMTP id 2mr14888445oin.73.1625609869712;
        Tue, 06 Jul 2021 15:17:49 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id t12sm2073282oic.33.2021.07.06.15.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 15:17:49 -0700 (PDT)
Date:   Tue, 06 Jul 2021 17:17:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60e4d686cb59d_1c428120810@natae.notmuch>
In-Reply-To: <20210706081738.5th24lypiicnbckv@yadavpratyush.com>
References: <20210628183004.flxirucfv2celll3@yadavpratyush.com>
 <60da5ed21ec8c_1f78f2082a@natae.notmuch>
 <20210706081738.5th24lypiicnbckv@yadavpratyush.com>
Subject: Re: Applying a patch with a diff header in its commit message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav wrote:
> On 28/06/21 06:44PM, Felipe Contreras wrote:
> > Pratyush Yadav wrote:
> > > I have a patch at $DAYJOB that contains a diff header ("diff --git 
> > > a/...") in its commit message, and unfortunately it is not indented. So 
> > > naturally, git-am trips up and thinks it is the start of the main diff 
> > > and tries to apply the diff starting there. It does not apply and the 
> > > patch is rejected as being corrupt.
> > > 
> > > I know one option for me is to manually edit the patch and indent the 
> > > diff header. But I would like to avoid that if possible. Is there any 
> > > way to apply that patch as-is? Is it possible to tell git-am where to 
> > > start looking for the diff?
> > 
> > git apply?
> 
> Sure, that is an option. But then I would have to copy/paste the commit 
> message and add the author information manually. Is there any way to do 
> this automatically? What if I have 100 commits like this?

Ahh, I misread your full question.

> This is a valid Git commit. It would be nice if the Git email tooling 
> could handle it cleanly.

Yes it would, that's definitely a bug.

-- 
Felipe Contreras
