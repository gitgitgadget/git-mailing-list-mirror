Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8323C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB64760F8F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhINWnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhINWnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:43:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D8C061762
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:41:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v19so771601pjh.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMcgCSvf1a8m8sR8pLeZyKey2ckLfmTJexSF+PUwVlk=;
        b=kGV8H3bp32CrujEB7AllBTQgTd9eBaeqnB/5JkX/GSTk9wYfpuhGCHFCnLOh/zPIp1
         Q8etLO7fecebas82jZmRWelWPSzhD4+8lYcbB/BYBxdRySEwBiiflrl5L8zBNYk0CmVs
         gKS6VvK1Y+aGFNwvlXYXcg4I07cnBxwB+txCXgJ3z1ugPx7jrNeJP8484MeNkKOaI3T9
         WI27oblB75YOTAdUDS9/994Sw/LdqeAJn3WZfwX0JKeFwg+MPRin0BPNbV31kzuwl3OK
         1vEd5rmOqSKVJVZcwrZYwzbJOMD2Ovj3TmonMsYSo2uHdKK/lijO06wn+n33qpykQMlH
         nd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMcgCSvf1a8m8sR8pLeZyKey2ckLfmTJexSF+PUwVlk=;
        b=uGC8xWvtycD7EeenzODUoROu9e/qn3ZLInHhfVuxANa1n5T96QIJUFlaHKKRqepPQc
         HU0EbPVsnSb+Ocp5okmFzYARpuERv0bCG0e/eroSPDJioWbdBnMa/sxvQ5OwbaHAMAYm
         xdpSbLsa/p20e4Jih1rETTjXHTunkaV+PCrci+WX+VhPvFGomoBk/ZpUX6ME9ayA0iVi
         FKQe8TXNaUFGP5nf7XbKTFUzuT4eqjph6qXnB01DbJCeBUk6W1/KTtAO1gseqcxPvM8R
         p3dqevj3OaUjfwgVljX3OoMgCXOlSJD8+E3HU0fi74IZf1ZvZfOqCGlPCQfKo7ty0Wy6
         LCdg==
X-Gm-Message-State: AOAM530F/sTCqyFOnN7s1V2a33XsY2E8U/hzkj6RYrTjZoX5L9FxEYyy
        5pRO0C50PKScRQLZhlOhG2hCIYfRubC+mA==
X-Google-Smtp-Source: ABdhPJxMpMgbN+ErHU4oDtfjBU00HTsoaXRMdmFnNYYexWEnYB5JdAAphXEuzLtNigyMz4cki6HXdg==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr4710319pjj.117.1631659315458;
        Tue, 14 Sep 2021 15:41:55 -0700 (PDT)
Received: from chooglen-macbookpro.roam.corp.google.com ([2620:15c:2d1:206:3406:2272:8ea6:cc78])
        by smtp.gmail.com with ESMTPSA id f18sm10651330pfc.161.2021.09.14.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:41:54 -0700 (PDT)
From:   Glen Choo <chooglen@google.com>
X-Google-Original-From: Glen Choo <chooglen@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 14 Sep 2021 15:41:51 -0700
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     hanwen@google.com, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
Message-ID: <YUElL3RI0VTnjE5C@chooglen-macbookpro.roam.corp.google.com>
References: <CAFQ2z_PKKZJY1kC1QJo8Zwq_yNh5QNGc3S5bq1jBfSfK3vQwRQ@mail.gmail.com>
 <20210826222439.3915402-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826222439.3915402-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 03:24:39PM -0700, Jonathan Tan wrote:
> > If they have to know about the object store, have you considered
> > passing the repository pointer
> > in xxx_ref_store_create() ? Then there is no possibliity to mismatch
> > the repository pointers and with the ref store.
> 
> I thought about that, but didn't want to make things worse - the effort
> in this patch set is, after all, to attempt to increase the dissociation
> between the ref stores and a certain object store (that is,
> the_repository's object store), and I thought that reintroducing an
> association (albeit to arbitrary object stores instead of a hardcoded
> object store) would be a step back.
> 
> But this may be the way to go - the ref stores already have a gitdir
> field that we could replace with a struct repository field.

I'm curious about how we'd want to resolve the general problem of ref
stores referencing odbs. 

A discussion I had with Jonathan Nieder suggests that ref stores are
doing two slightly related, but not equivalent things:

- a logical ref database that preserves its own consistency
- a layer of ref storage in such a ref database

In the current state of affairs, the files ref store and the packed ref
store seem to behave as a single logical ref database. An example of
this (that I care about in particular) is in refs/files-backend.c where
the files backend validates oids using the_repository's odb.
refs/packed-backend.c doesn't do any such validation, and presumably
just relies on the correctness of refs/files-backend.c. I assume that
this also explains why some functions in refs_be_packed are stubs.

The answer to whether or not a ref store should refer to a certain
object store seems unresolved because a ref store is trying to do two
separate things. Perhaps it is reasonable to associate a ref database
with an object store (so that it can validate its refs), but we would
prefer to dissociate the physical ref storage layer from the object
store. (I'm paraphrasing Johnathan Nieder here, this isn't an original
thought).

Perhaps this is a question we want to resolve when considering reftable
and other ref databases.
