Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76784C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B28560FEA
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFUSjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhFUSjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:39:40 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37077C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:37:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d22-20020a056a0024d6b0290304cbae6fdcso506535pfv.21
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVoyc3ANunS4LdzD0h5JECaMuchJE/4qYA/r94NtEi0=;
        b=bW7V94ZFqMNeZqP0KMZVMqnLn5b7EXnSntSmsBaIdjG+B8vJkpwVIGjbjR4kclq0Y8
         +6I37WvAVhbTLj3hYADMOq+Cjzzg8DeEX4A49rc2qduOkrxFCFEqh4VICfLf80MLXRO6
         8NVPBTpkOxqcdfsKLUC0z7a/WjcwJCduL01VuP4oZWX/te5GWNXLl9iZabw+lCQnDVmu
         rNXGYuO+xexs01RAgolHtpmjZlWdoulkrz/dijYz02GT3DIcVDFe1zzGCuVV8r2D0FvX
         fv6vxDln5vt/fkYX8lNPgP1IsO0y7Ch1lsRg00ARrMCOngz6baxiqj5zTOgHQF5DU0le
         AnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVoyc3ANunS4LdzD0h5JECaMuchJE/4qYA/r94NtEi0=;
        b=R/MXRNefF7ZSugdu98B1zbjyhoW5lQVi4QrDxRTUDOX8QoqJ59MBZMDD7Vo4K9krfL
         kMKXWIBVWOaukUZx0LDsUVGaZhjYQFr1OyUPYmWN8VVxx8X9fYPDYzqir4egUkUJ3ZDa
         TzRZO2uQZg8v6UJuqN3LU2yhfCZ+04BSV10XdinQhjAINcBE8Cw891LaWXrvVukKb3iR
         FcjZ4ygzUW49sHGfb0hUbIgAnk3EgPHCzjlWr4w2BOkMzwuMDirDrnlUxUYEIYv/cm6m
         3AuFOspa2FRMaAmi3MI8DO3+RKzQ3JBM/s/By2I5uQvhIDTae3P2qoW7KBAPMssChXjA
         pqFA==
X-Gm-Message-State: AOAM530IRZAVEyT0w4UbwjHm+0Q0xBa1uZewpJK2muFVuJ7jA7qu8+ui
        jpHvJR6DCtkbXrwzG8UAUg6X41p5j40gEJ4O2gWD
X-Google-Smtp-Source: ABdhPJwFCNFwh5l+1Nq1At4C1lZ4uErfVuj6ajunl58mZE6Wt/l4B8AXfeqmPn6Bq599imKZxqTwi28WYHyc3PK1N85O
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d645:b029:11d:d075:cf43 with
 SMTP id y5-20020a170902d645b029011dd075cf43mr19091747plh.14.1624300644685;
 Mon, 21 Jun 2021 11:37:24 -0700 (PDT)
Date:   Mon, 21 Jun 2021 11:37:22 -0700
In-Reply-To: <CAOjrSZtKxEbMEbNZ+KEDfoJSOBSyKPY+PQRaP9sb7xgXiEFJZg@mail.gmail.com>
Message-Id: <20210621183722.1167322-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAOjrSZtKxEbMEbNZ+KEDfoJSOBSyKPY+PQRaP9sb7xgXiEFJZg@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     mattr94@gmail.com
Cc:     rsbecker@nexbridge.com, jonathantanmy@google.com,
        emilyshaffer@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Related question, if a project had a collection of suggested hooks,
> and a contributor wanted
> to update them in relation to a new feature or code change, would they
> then have to create two
> separate patches/PRs?  That feels like it would decentralize discussions/review?
> 
> For example, if I maintained a project on GitHub and a contributor
> wanted to add a clang-tidy
> invocation as a suggested hook, as well as a config file for it.  What
> would the suggested workflow be?
> 
> "Open 2 Pull Requests one that updates both branches and do reviews
> independently"?
> 
> If it was a mailing list would I have to send two separate patches?

With the current design, the answer is "yes" to both. Having said that,
for this particular case, I think that the clang-tidy config file can be
reviewed and merged first, and then the clang-tidy hook. (The hook needs
to be written to also work in the absence of the config file, since the
user may have checked out an older version, so as far as I can tell,
there is no need for precise timing as to when the hook is merged.)
