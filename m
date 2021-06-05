Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECEC4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91706613C9
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFEB4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEB4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:56:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF9C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 18:54:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so14159510ybp.17
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CDw0C+PTTCs2WvdHoytlWtcWCgpYlRv/Y3C5vuA9ykY=;
        b=Cs4GXlWbc4VRfK/GGOjH4QCDlcW8NQo5jNi65yigUnh4Gyr84ChcrlTIZn8ytqVjss
         MEFJGiouuEfkuERUcrVVEt8fvyOAReChB4PgP+VeoNniwEK/aKSKvlILIwML1ZKxfHst
         yBEksnqW5olubMblNQtNqf5oTmwVhsnWeWbQ4r6SKgv1Tx82k+UMb9pTw2aDOrLWQhmC
         cXbLE2WZgXxfVNDP3+AJcdwBL3DHRdHY1sAJDy3JIWQE/M3Poz6yVi+JauThIdy4OqPg
         A8rkL70hm63dcjpyCurkz9OcZLE5DIm72iINC4kyM2FnZllOmTgSI1S221TxJnQaJwID
         rtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CDw0C+PTTCs2WvdHoytlWtcWCgpYlRv/Y3C5vuA9ykY=;
        b=sOHirQPXvsLTarR3BUotDlO/JMVz7EE/L79Jl7N5EL1loSJRCywo7cfNxomi+mjEmc
         5VrWFCzH0SW7kq5bn286dibvDzkS8X4dnzVuDliIM7UmI/NQf6Bsd8jQJn58ynPu9asn
         ezxNGdr89IrZOVCOXAN2WW+7K5xogPQBj6DVQR7hafrph5i306HIRTO491YbcpAwxdGs
         K7jyV8brfDEOT54aKOTlnKRVFxqtG82xWjSheAA6a8hGMdPDoyT8EMDQT4z27hNnHVGi
         w2HAcID/msnAfClnFMw+R8MW+NpnhM18zVCPUkVcbsSbfwBGnHWAr7VJbHTUZaIiRcRX
         mZag==
X-Gm-Message-State: AOAM532QujcF6EgHp+JIYIs3ziccz3Gau8cVlEZE2fy+7tEVLJVkVVE4
        H3pKY9XcrRhxCoiw+KynAYREG/1/B07zSWk/AXqm
X-Google-Smtp-Source: ABdhPJz6FE1sG7ToiGiPCYkSk0tKYq/J8aB3EnNeVw8K8035wJ1GL28JDqbKKcVkmIBhFt5j+iORf77XFYr3Un49STYT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d8c1:: with SMTP id
 p184mr8516932ybg.10.1622858044694; Fri, 04 Jun 2021 18:54:04 -0700 (PDT)
Date:   Fri,  4 Jun 2021 18:54:02 -0700
In-Reply-To: <CABPp-BHZ0OrADfP3V-hZ1YYf3fQYW3fU-tCJWgs976amG-T1Dg@mail.gmail.com>
Message-Id: <20210605015402.607304-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BHZ0OrADfP3V-hZ1YYf3fQYW3fU-tCJWgs976amG-T1Dg@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 2/4] promisor-remote: support per-repository config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +int repo_has_promisor_remote(struct repository *r);
> > +static inline int has_promisor_remote(void)
> > +{
> > +       return repo_has_promisor_remote(the_repository);
> > +}
> 
> Is part of the plan for supporting partial clones within submodules to
> audit the code for use of these inline wrappers and convert them over
> to the repo_* variants?  I'm particularly interested in the
> has_promisor_remote() function, since there are calls in
> diffcore-rename at least that protect that call with a check against r
> == the_repository.

Good point. Yes, that should be part of the plan - at least, we should
see what those invocations are for.

> > @@ -139,6 +140,9 @@ struct repository {
> >         /* True if commit-graph has been disabled within this process. */
> >         int commit_graph_disabled;
> >
> > +       /* Configurations related to promisor remotes. */
> > +       struct promisor_remote_config *promisor_remote_config;
> > +
> >         /* Configurations */
> >
> >         /* Indicate if a repository has a different 'commondir' from 'gitdir' */
> > --
> > 2.32.0.rc0.204.g9fa02ecfa5-goog
> 
> Looks like a reasonable step in moving away from globals and have
> repository-specific variants of these functions; I didn't spot any
> problems, just one question about additional plans.

Thanks for taking a look.
