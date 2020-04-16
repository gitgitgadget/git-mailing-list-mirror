Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBC8C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5AF208E0
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VfvPVV6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405021AbgDPArs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404980AbgDPArh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 20:47:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFBC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 17:47:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so615329pjb.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7LNyJHpEZu6zDaiNuqbgk+LKDrIYZdrZiYOtsu6Z+Fg=;
        b=VfvPVV6vzg4qC94mewalhZsP54vWwOF9gcUYX09pfUHxR6NvLQZ9o+pNduMN6PWmVi
         Lh5Ssm+UwJAZJrR2ysc4REMdACdIJXcI6V8jfNfNhYQbVd4ZTfSPI0w1oVWVcezCZWgC
         Za9ca2hPCdluNmQelxEZ712ksXn9YRhG4C6nxFjRMyTGdceeQnwzOzkq7lJsSyZGWLpT
         8D0jTC6ruBiMNEWjOKzjbNwJLg+ilXavQ1Zq1vrCJwuBuG2+sWf/4hlTfHkD5qzEy7VZ
         VSzgLsjFznd2ky11D8een4FAGzOq+r93s1q7CuKirnFl02Hi+iwezeC7NYndWmHIo58Y
         WXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7LNyJHpEZu6zDaiNuqbgk+LKDrIYZdrZiYOtsu6Z+Fg=;
        b=G7V32BVIvDD2xR95j/BzDmT9ZDaDVn/1gZZRtsIVdqtNICOJqY358ZPGD2+9w9tUCo
         zQ6BlAMMPwOss5aRX61Du6Pzv1XmLyY2FB8sEmNpIg3CLQ6HX9XgxFnLQQX5G1akBK1D
         2H+ClL9Y1cVCo60ZXJ/AvkPuAyD3+AO4xCr/6jJQ7XPTGnsQtCFOPuuL8GrKJ0Y+NMYh
         c6gppV4QZN7e5i394lBKkAIlnfv9lKUV8Fjjqun1k8m+nLGUeMHd0BzfZiPvzDDLwSdV
         vwGHEfrKBCd4Y7VMUGQqQ958enc1j4CnPZKYI59KQDQRZvXbAlvLuqW69R0wqpQtLmmN
         MIZg==
X-Gm-Message-State: AGi0PuYlBdeqlMYLNUUEYVlkkOmwNTa5hVvi8i6UhdDTGAksv3/nGGsJ
        HMg7E/4CcrbeVHsksDqK1IkhuA==
X-Google-Smtp-Source: APiQypKBNevmQXUQMZa1I3ej158WvAhnUZyAxT65tIpeN2otqFLdPY3DcbJolJPzcaPRKjeYKUCziA==
X-Received: by 2002:a17:90a:a40e:: with SMTP id y14mr1977952pjp.151.1586998057024;
        Wed, 15 Apr 2020 17:47:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z63sm14984448pfb.20.2020.04.15.17.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:47:35 -0700 (PDT)
Date:   Wed, 15 Apr 2020 18:47:34 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
Message-ID: <20200416004734.GA36156@syl.local>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <20200415205442.GC216285@google.com>
 <CABPp-BE+bC8aECT4Ak_kSObXV-euq7vCnYeUYBEjYmW4Pko=rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE+bC8aECT4Ak_kSObXV-euq7vCnYeUYBEjYmW4Pko=rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 03:54:09PM -0700, Elijah Newren wrote:
> On Wed, Apr 15, 2020 at 1:54 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Hi,
> >
> > Elijah Newren wrote:
> >
> > > I was building a version of git for internal use, and thought I'd try
> > > turning on features.experimental to get more testing of it.  The
> > > following test error in the testsuite scared me, though:
> > >
> > > t5537.9 (fetch --update-shallow):
> > >
> > > ...
> > > + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> > > remote: Enumerating objects: 18, done.
> > > remote: Counting objects: 100% (18/18), done.
> > > remote: Compressing objects: 100% (6/6), done.
> > > remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> > > Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> > > From ../shallow/
> > >  * [new branch]      master     -> shallow/master
> > >  * [new tag]         heavy-tag  -> heavy-tag
> > >  * [new tag]         light-tag  -> light-tag
> > > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > > fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
> > >
> > > Passing -c fetch.writeCommitGraph=false to the fetch command in that
> > > test makes it pass.
> >
> > Oh!  Thanks for checking this.  At $DAYJOB this was the week we were
> > going to roll out features.experimental.  Time to roll that back...
> >
> > How did you go about the experiment?  Does Taylor's patch make it pass?
>
> Yes, Taylor's patch makes the experiment pass.  My experiment was
> pretty simple; modify the code so that features.experimental defaults
> to true:

I'm glad to hear that it is passing now. I would like to have Jonathan
Tan chime in on whether or not this patch is making sense, but if so,
I'll prepare it for real and send it out.

Thanks,
Taylor
