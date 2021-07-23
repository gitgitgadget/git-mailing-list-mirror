Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD31C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEF860EB1
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhGWQaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGWQaS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:30:18 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6BC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:10:49 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so2738720otq.3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OqyOAJVGr9dYcxi0Od/X6kiSYyjSr1OYQbByhNjcF1U=;
        b=UDpVVqnzlooQLxNltqIJLjbmBGluueDlEMiequIp1qIsm07On6UmHDfkd3u6lnZpxu
         PTA6hutVOwyDxyk3fSZlwRqafyaEnNZqaa7T4+Fkl+7vcrzpPPFkcrPTmVnz71M43iQY
         RphZciSdPJOWQ/7iv8n3iy6GbsgZU1Y3TZcnp9yhpQoh6ROvbgmqwy+LCecgN3rpRTNN
         +fGn8xIB8Q62dqJtDxeQl1CArdoMNJat8WWSkVfdn1W0XOlo02uwLP8hkJhw6NJQIaZO
         Wst+701GcdEY2dORftzuiQfX7gaWRnrMwKJ5V/ZDpzZ/C2xVHZP/HmQd4Y7oO+UrnQCa
         3Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OqyOAJVGr9dYcxi0Od/X6kiSYyjSr1OYQbByhNjcF1U=;
        b=IsO0JAKSUVLexnyv3vg3+9gsI4m13HaOUXiVmww60V5BRq8e65aUTqKD4thAUT+Fkz
         F29SPD8cS7XR8L67z6ZK3kHZ2Q7UhoKzFkF3ZKD3HWYsLQp45BkfnP6cW2LRqrXqRToR
         RaE0hDozHTakXrelSPdodACS/PRoXsvLWjAJduqFubtWU2GVCp6Eydumno6NXN1RDGnB
         Ljs3eGz3Y9jmFUZBi7pgbyeWk5fnseNysWUZ5rmo00vtVYA8Fx5yej9End9AJgu8JcPi
         UeevSvQqtnxxcfCHK7Kfnf8FwBEQPxYKIObNtPwQAGm6fmQtDUAbjtbcJgQ4Df8CqU8c
         cEuQ==
X-Gm-Message-State: AOAM532qzardqcRQ0U2ZF8VTMXDsSgY/kyLxHQhG0SAJcOvhVafvBA3E
        Lmtf+gYnJdOHiXloLMqZ1Q4=
X-Google-Smtp-Source: ABdhPJxX1gPCkX6j38ZZgL6PRiIiJYD5mgU/fzBx/g3u4iDXp4FrpfYhQhK3W/sSE6myMbZw3ydF7Q==
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr3701564otr.51.1627060248502;
        Fri, 23 Jul 2021 10:10:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v11sm3262052ott.68.2021.07.23.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:10:47 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:10:46 -0500
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
Message-ID: <60faf81658201_defb208d4@natae.notmuch>
In-Reply-To: <76d59e73-ae5d-3bef-4aa3-5d1af9611577@iee.email>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
 <20210722000854.1899129-8-felipe.contreras@gmail.com>
 <76d59e73-ae5d-3bef-4aa3-5d1af9611577@iee.email>
Subject: Re: [PATCH 7/7] fast-forward: add help about merge vs. rebase
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> minor nit/query on format..
> On 22/07/2021 01:08, Felipe Contreras wrote:
> > Now that we have a locus for merge versus rebase documentation, we can
> > refer to it on the diverging advice.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-fast-forward.txt | 48 ++++++++++++++++++++++++++++++
> >  advice.c                           |  4 ++-
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
> > index 38c920964f..1989fdec4a 100644
> > --- a/Documentation/git-fast-forward.txt
> > +++ b/Documentation/git-fast-forward.txt
> > @@ -50,6 +50,54 @@ synchronize the two branches.
> >  
> >  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
> >  
> > +MERGE OR REBASE
> > +---------------
> > +
> > +The decision to whether merge or rebase depends on the situation and the
> > +project. Traditionally git has prefered merge over rebase, but that creates a
> > +new commit, and that's frowned up on some projects, so you can't just simply
> > +choose to merge blindly.
> > +
> > +------------
> > +    D---C---B---A origin/master
> > +	 \
> > +	  X---Y master
> > +------------
> > +
> > +The nature of distributed version control systems make this divergence
> > +unavoidable; you must decide how to synchronize this divergence.
> > +
> > +Should you choose to merge, the two heads (master and origin/master) will be joined
> > +together in a new commit:
> > +
> > +------------
> > +	  origin/master
> > +		|
> > +		v
> 
> .. here, in my email reader, the arrow doesn't align to the commit
> because of the single char (+) indent relative to tab spacing. Does this
> cause any problems when formatted in the html/web style?

No, it looks fine.

I don't have a problem with tabs or spaces, but git-pull.txt uses tabs.

> It is good to have diagrams for the visual learners!

Actually, it seems there's no such thing as "visual learners" [1]; we
are all visual learners.

Cheers.

> > +    D---C---B---A---M master
> > +	 \	   /
> > +	  X---Y---+
> > +------------

[1] https://www.theatlantic.com/science/archive/2018/04/the-myth-of-learning-styles/557687/

-- 
Felipe Contreras
