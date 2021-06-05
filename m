Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F27C4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D461613BF
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFEBqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:46:45 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:46786 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhFEBqp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:46:45 -0400
Received: by mail-yb1-f202.google.com with SMTP id p2-20020a2599820000b02905394c6727easo14082828ybo.13
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e/nd21HFd+pWBMrp5NyDPU6EqnKIo8KYPcrJXW0kVFA=;
        b=r0k7v0aGoxImaQpvnQeF5ijZE51aRvTESbQnhUkhfLjl+t0CQEMuH66t6Bu6qOggWO
         QrCGrdIIqjZjnGRofM8kW9JsIBflZe/HdswX9+7EM2hQpT2/mPPb6tZQ/vf3G0T39S6z
         Fp56BLETKRAbcMOMPSiKYp1ACSQURLqPVFGwCu3cOz8cnboWkZdKDJLVNazZpecntH2y
         hLunZ/tC+K/WMq2MzXjo2VWymWDkR3L8FsWil3lYWyEnuyg8nrj4noF1G2CS1/1liczk
         m3NLQP4Vmq2DuVVzugBeovj7ogdyx12wBUpP18MXt89LLY3au20B88oeDdAhCa++lT1q
         c05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e/nd21HFd+pWBMrp5NyDPU6EqnKIo8KYPcrJXW0kVFA=;
        b=fFCsesQohQjgml1HnBTCYYnGEKOyL2wElQ/d+Vns8bloLLVm86LTWBIgfmfp+9vLi4
         sgrFGGZRRnrxAdASX38NVhkI03fkhdFECDGS0AF8fFukWiBpnm7u68Ddxlbi/jrD/qu5
         DFe21cUSYZ3RbEAX/lEijyk6OGkz7RmxTPxUkT5KBO4jP2mbYQeq84vPJWHwd6/2pXtU
         rJbnnBzR/NIERiMeVku+Ny+ugrXmmbDaxzHwGCeyDFH2ux8/ubD07GEoJY0snjWHgq/H
         315C9a5gri6cxTaBgRTOGsoY9Fg9fiGzj2L0lVUAIvvW/8gUYNIodBUV8+q9E+JuNqJc
         hGmA==
X-Gm-Message-State: AOAM531EFYBYmwYL+hcd8YE++e/UDdhoQv4oCQpX1++27u8KTPBAOJ9j
        rHR3IrMkvYDlYWK57VZdrL6kBeTQzadbKk3iBk2M
X-Google-Smtp-Source: ABdhPJyDEFYStMmqjGfAHhWVKwGRSGSiD7IckUc0YjmpNCSGexvkdj5etfdDRAHVNlam8EVz19aoQWgwnY6DS/Nf8YPI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:6ed4:: with SMTP id
 j203mr9827923ybc.344.1622857437856; Fri, 04 Jun 2021 18:43:57 -0700 (PDT)
Date:   Fri,  4 Jun 2021 18:43:55 -0700
In-Reply-To: <YLqIaVbA/uDa2qgh@nand.local>
Message-Id: <20210605014355.606010-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YLqIaVbA/uDa2qgh@nand.local>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 2/4] promisor-remote: support per-repository config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jun 01, 2021 at 02:34:17PM -0700, Jonathan Tan wrote:
> > Instead of using global variables to store promisor remote information,
> > store this config in struct repository instead, and add
> > repository-agnostic non-static functions corresponding to the existing
> > non-static functions that only work on the_repository.
> >
> > The actual lazy-fetching of missing objects currently does not work on
> > repositories other than the_repository, and will still not work after
> > this commit, so add a BUG message explaining this. A subsequent commit
> > will remove this limitation.
> 
> Makes sense to me. I found my answer to the question that I raised
> during my review of the previous patch, and I think it would make sense
> to address in an amended version of this patch.

Just to clarify, what is the question and what is the answer?

> Other than that, the translation all looked very faithful to me.
> 
> > -void promisor_remote_reinit(void)
> > +void repo_promisor_remote_reinit(struct repository *r)
> >  {
> > -	initialized = 0;
> > -	promisor_remote_clear();
> > -	promisor_remote_init();
> > +	promisor_remote_clear(r->promisor_remote_config);
> 
> Ah, this is probably where I would have expected to see
> r->promisor_remote_config->repository_format_partial_clone freed as
> well.
> 
> I wondered whether or not that should have been freed, since on first
> read it seemed that this function was mostly concerned with the list of
> promisor remotes rather than the structure containing them. But on a
> closer look, we are re-initializing the whole structure with
> promisor_remote_init(), which runs the whole promisor_remote_config
> callback again.
> 
> So I do think we want to free that part of the structure, too, before
> reinitializing it. I would probably do it in promisor_remote_clear().

I'll add that in the next version.

> > @@ -235,9 +244,11 @@ int promisor_remote_get_direct(struct repository *repo,
> >  	if (oid_nr == 0)
> >  		return 0;
> >
> > -	promisor_remote_init();
> > +	promisor_remote_init(repo);
> >
> > -	for (r = promisors; r; r = r->next) {
> > +	if (repo != the_repository)
> > +		BUG("only the_repository is supported for now");
> 
> I could go either way on whether this is worthy of a BUG() or not, but I
> don't really have much of a strong feeling about it.

This BUG() will be removed in patch 4. I'm OK either way (adding BUG()
here and removing it in patch 4, or never adding BUG() in the first
place).
