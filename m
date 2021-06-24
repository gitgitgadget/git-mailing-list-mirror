Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4FC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62F1613F2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFXOeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFXOd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 10:33:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5EC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 07:31:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso3782074otm.8
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=V14zKB7Him+ej4rb1VujgTiS3/tm4SBeaLFKMIye5C0=;
        b=M1qKhHkOGcHX5q/mADoUaUhLWavkzeH3muCbbIAL7CNHmkTOBlyhvpVbRsY0sE+A2D
         4dP1hNyTWeq/gfcJ3COqCbNryVOrmq8QMiv6d28bjX4Mf7TqBMOKbfKNG5TkT+TLKbiQ
         2D/AsL9ZiUe37qThkXTk550YA6ZF34hbNwiNPpSukClgn5QXwr6QLJEXOAH10qJ2vFBy
         E+UOHUnomGDIWuA0LwHp613F4OSESkHdw5i/w0s53R1ArF28vRAw4+prpWiFF2Ofzb7T
         Ox9oOORoIJVEQauZf7z0BKOJn/ISYMVhgtCBAFfvA/vtTbZWE03QNUUzlOhnodqPWJ/h
         bXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=V14zKB7Him+ej4rb1VujgTiS3/tm4SBeaLFKMIye5C0=;
        b=lHY7/ngcoL/LhjaQsySw6asViHpqpEpTeOML4oo2ipxQbU85m4Ycja+y5qkT5TqmUR
         Jz419w81aCXR0P2VkHjdVVGAs6rKRhgpMTRin5XAu26crPw5TS0x0E6VC2d+zsLhrg2t
         v2psQOO4x+8iIl+kjd9jg19niDwxsD+VnzsEr0gfgGVxCFrbJDGMyVmY5V8Bh6jDHNeI
         y5dZxywnk9BrsL3pe09ADY0Uc892Dxszw+nHksx3KAXIyVRygCQlT2aNo6CtrLndBItv
         Q/2UQRd4SuTPxLHW8BIVgOrkVcPS4tmpPepvxz50AhmxbMxgNvxd652xWdISZ/wrOSgP
         VNNw==
X-Gm-Message-State: AOAM530lT6wo7z60+L/YXumowiDegNm6DzHYMWhbR0ReN5GKMKRl66wR
        E2MIVXzXc+VD4boSziESZbw=
X-Google-Smtp-Source: ABdhPJxcip7vZ2nCv/ZMvHN5gWF2NVL0swv43zxVekr7evYrnjrLQL6SkykG/xrtZ3KtI6sI1YhPvA==
X-Received: by 2002:a9d:4813:: with SMTP id c19mr5039295otf.250.1624545098785;
        Thu, 24 Jun 2021 07:31:38 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id p25sm639379ood.4.2021.06.24.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:31:38 -0700 (PDT)
Date:   Thu, 24 Jun 2021 09:31:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d49748b8538_2fb2082c@natae.notmuch>
In-Reply-To: <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 21/06/2021 18:52, Felipe Contreras wrote:

> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
> >  ------------
> >  	  A---B---C master on origin
> >  	 /
> > -    D---E---F---G master
> > +    D---E master
> >  	^
> >  	origin/master in your repository
> >  ------------
> >  
> >  Then "`git pull`" will fetch and replay the changes from the remote
> >  `master` branch since it diverged from the local `master` (i.e., `E`)
> > -until its current commit (`C`) on top of `master` and record the
> > -result in a new commit along with the names of the two parent commits
> > -and a log message from the user describing the changes.
> > +until its current commit (`C`) on top of `master`.
> > +
> > +After the remote changes have been synchronized, the local `master` will
> > +be fast-forwarded to the same commit as the remote one, therefore
> 
> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?

No, there's multiple steps:

 1. origin/master is synchronizd with master on origin
 2. master is fast-forwarded to origin/master

So, after 1 is done, 2 will happen.

-- 
Felipe Contreras
