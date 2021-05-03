Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9EC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AD86121D
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhECUbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECUbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:31:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE642C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 13:30:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s22so4587991pgk.6
        for <git@vger.kernel.org>; Mon, 03 May 2021 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N5HSkF9de7OzXFk060NoyQwwVH5s1MlMSBIUaC9p45Y=;
        b=cB0tUfUxwZwRn+HzEjFfBJAyPDXbFYvFfJDmDmxXjNo2usF323PlD7+PJuXLxzj9D+
         EkQb6Z2Ea7yI+tO8klMmDEZjOM42qxzhwqNlSB9jNhrcTNhHOvT12q51cF/bh48buvjQ
         chxVtchN7uDjqFy2cBjMvGhBLJb6oPLL+LWuuk6mKA4NqTWHkWEvzezh9Z+EVmFpA0XV
         vjvW/3lC7d5/afxqI/Zt5fkIQG10CKHyPcdGpEbt4P0OiNFpxfV0ebPwmy6b6LsSce9G
         ppRefmI0fCGikvLTBCRWtJrh5FgOX1gCUMsipZNuhpi8j2J79tKD9bCQBUBzoWTE26iF
         YFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N5HSkF9de7OzXFk060NoyQwwVH5s1MlMSBIUaC9p45Y=;
        b=oba/dFQq4IRFJAP2gqFSO9ZLbPqAtf+GofRRUnvjI+Xo2HguYIlr++VtUW1MLtAj1o
         EPNNDxERwiXi8y2f6tAGs7yB3wHEEbrx9BVaN6wq5aPxcoMv8W6UQSnULu62QW4gkHqX
         OM5fkkL47Jb6H4eHyviRuD/d0OTF7JXKVYGW1gn7m+AB1hfn9xc4iBYAXG/KZt9vSfA+
         PIOH5Bf5k3TmW/nkbc1+mHFUCXMfWVi82djFuD+eb5MjyZB9br4ZefQFu06eJGU5Cmh9
         cXmI6vKGF28we14UnlXWYXi4tC6ch0c+iqphLFLyJ3UJ8Qei/sqBemgsEhDqVlGn20O2
         MjZA==
X-Gm-Message-State: AOAM530Mje/BO957GMaMXH8dNLiIsmVSBbxRPaZcmPU6htRngbJ1rKyp
        sPBAD6Gaaa0OwdPUsxIy7pwdJg==
X-Google-Smtp-Source: ABdhPJzsfuXuU4fun7EMzFPIUxdGoAsTGsfSgAmhCyClp4o7FyXc9fAdgE4YsO/eCPd+RSmm1PWarQ==
X-Received: by 2002:a17:90a:e298:: with SMTP id d24mr23606296pjz.144.1620073844078;
        Mon, 03 May 2021 13:30:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f655:ab1e:aa80:f15a])
        by smtp.gmail.com with ESMTPSA id x4sm10034982pfr.160.2021.05.03.13.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 13:30:43 -0700 (PDT)
Date:   Mon, 3 May 2021 13:30:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks into
 a function
Message-ID: <YJBdbi50Hz+ekOtt@google.com>
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
 <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
 <xmqqft0447lu.fsf@gitster.g>
 <xmqqpmz4qtxi.fsf@gitster.g>
 <xmqqft00qtrj.fsf@gitster.g>
 <87tuoggwmy.fsf@evledraar.gmail.com>
 <xmqqblaopbep.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblaopbep.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 05:08:30PM -0700, Junio C Hamano wrote:
> 
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Fri, Apr 09 2021, Junio C Hamano wrote:
> > ...
> >> What's the status of that topic, if there weren't other topics in
> >> flight that interfere with it, by the way?  Is it otherwise a good
> >> enough shape to be given priority and stable enough to get other
> >> topics rebased on top of it?
> >
> > I see I've mentioned [1] in passing to you before, but in summary I have
> > some major qualms about parts of it, but very much like the overall
> > direction/goal of having hooks in config.
> >
> > Elevator pitch summary of the lengthy [1]: hooks in config: good, but
> > having a "git hook" command introduce some nascent UI for managing a
> > subset of git-config: somewhere between "meh" / "bad idea" (see security
> > concerns in [1]) / "not needed". I.e. I demonstrated that we can replace
> > it with a trivial git-config wrapper, if the series doesn't go out of
> > its way to make it difficult (i.e. we can/should stick all config for a
> > given hook in the same <prefix>, and not re-invent the
> > "sendemail.identity" special-case).
> >
> > I'd very much like the author to respond to that :) And/or for others to
> > chime in with what they think.
> >
> > 1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
> 
> OK, Emily, I guess the ball is in your court now?

The topic is not ready for submission besides interference. I have a
list of things to do and was sidetracked with other work (the submodule
RFC, etc.). This week I am working on getting this series polished and
ready to go.

 - Emily
