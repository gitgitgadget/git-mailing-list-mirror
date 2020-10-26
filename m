Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56E6C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0922087C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNJT8aNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789472AbgJZSYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:24:22 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44967 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788976AbgJZSYW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 14:24:22 -0400
Received: by mail-qt1-f201.google.com with SMTP id g11so1094152qto.11
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OedA7L053onUYaFOFRbEAZ+cu1DRuRAk+JmYDiASaDo=;
        b=HNJT8aNbUy8BUDkjyJkcY1H2RkyBDEh/8zCroaEOP6+gQ9DpDoKcQgEx8Z+zISCKRe
         N/RTq1f4lf5R7Qi/2JmXknxWhgxXGWyS3D9D70yZNLWp5TJdzVBdoOPoDrg6CjQfk/nu
         Rhp5UQAvQM+8jWY3Dc0KDaNp077CQbayCzA0vvu5MAtBIVtoKwgs3WAIut2jrne3JAeR
         W6NBzYnTCHZgnxZURLEcxiq4RoymTYcbfkvMCTF+UbMkY64Bs1nk92IXwI07KEIxAydd
         RX41jxIZJY/uYWug/pH/TonA7/cBZe+8URJ5+sZDOHflQQN1x/rzwS665KHRu8Q88gVQ
         bONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OedA7L053onUYaFOFRbEAZ+cu1DRuRAk+JmYDiASaDo=;
        b=AWyqc9G6ezePmL/58cqQ2d3uMZYyxZ8tHVGS1kQmHCLSMGuibKOfiU46SdsWB0bliQ
         LcVh+q8WopZpSWdJr9xH6TwfVy+25+i1lpe2ugQ3SY69nIeYqh1Y4v8pQHgnFxcOwQOj
         P7hOT0OnKdWzB61DjW1cPqfDxZbrLHCWLjhn+kPFf/tIokZSVPRDyWaIbTwurt/dRJnY
         DVQiv2EIuvp4BmR2oMkWMgb+ho/Uxg0NMHPXDJk3NS5jd8Q+4X6GxuCt7bwArnV/woGr
         aQcDEOf/fhu7PA3/4EZtSm50INyrcCbBv/LW3+DCfgoiulWRzodUk1x75TmJ6eMi1eDM
         mEsw==
X-Gm-Message-State: AOAM531m/hva5/+YN0cjDwBGVHS9tuzgH/PLbIWn8EuLMHpUCy3l9PzW
        3i10Q2SpVqKZZNh++0XatzYDMKFAqaPpGAIyzYGJ
X-Google-Smtp-Source: ABdhPJyRhhR/4IFv66X5iu52alAW1VOpg1SQ+LClRhgQeIznvXgMr+bampnI8MNJs1CRcNpft2K353z6ryDGcoN+UOI+
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:aa1e:: with SMTP id
 d30mr14365278qvb.24.1603736660829; Mon, 26 Oct 2020 11:24:20 -0700 (PDT)
Date:   Mon, 26 Oct 2020 11:24:17 -0700
In-Reply-To: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
Message-Id: <20201026182417.2105954-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: Questions about partial clone with '--filter=tree:0'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     alexandr.miloslavskiy@syntevo.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com, marc.strapetz@syntevo.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> (1) Is it even considered a realistic use case?
> -----------------------------------------------
> Summary: is '--filter=tree:0' a realistic or "crazy" scenario that is
> not considered worthy of supporting?
> 
> I decided to use Linux repo, which is reasonably large, and it seems
> that '--filter=tree:0' could be desired because it helps with disk
> space (~0.66gb) and network (~0.54gb):

Sorry for the late reply - I have been out of office for a while.

As Taylor said in another email, it's good for some use cases but
perhaps not for the "blame" one that you describe later.

> (2) A command to enrich repo with trees
> ---------------------------------------
> There is no good way to "un-partial" repository that was cloned with
> '--filter=tree:0' to have all trees, but no blobs.
> 
> There seems to be a dirty way of doing that by abusing 'fetch --deepen'
> which happens to skip "ref tip already present locally" check, but
> it will also re-download all commits, which means extra ~0.5gb network
> in case of Linux repo.

That's true. I made some progress with cbe566a071 ("negotiator/noop: add
noop fetch negotiator", 2020-08-18) (which adds a no-op negotiatior, so
the client never reports its own commits as "have") but as you said in
another email, we still run into the problem that if we have the commit
that we're fetching, we still won't fetch it.

> (3) A command to download ALL trees and/or blobs for a subpath
> -----------------------------------------------
> Summary: Running a Blame or file log in '--filter=tree:0' repo is
> currently very inefficient, up to a point where it can be discussed
> as not really working.
> 
> The suggested command will be able to accept a path and download ALL
> trees and/or blobs that match it.
> 
> This will solve many problems at once:
> * Solve (2)
> * Make it possible to prepare for efficient blame and file log
> * Make a new experience with super-mono-repos, where user will now
>    be able to only download a part of it by path.

To clarify: we partially support the last point - "git clone" now
supports "--sparse". When used with "--filter", only the blobs in the
sparse checkout specification will be fetched, so users are already able
to download only the objects in a specific path. Having said that, I
think you also want the histories of these objects, so admittedly this
is not complete for your use case.

> Currently '--filter=sparse:oid' is there to support that, but it is
> very hard to use on client side, because it requires paths to be
> already present in a commit on server.
> 
> For a possible solution, it sounds reasonable to have such filter:
>    --filter=sparse:pathlist=/1/2'
> Path list could be delimited with some special character, and paths
> themselves could be escaped.

Having such an option (and teaching "blame" to use it to prefetch) would
indeed speed up "blame". But if we implement this, what would happen if
the user ran "blame" on the same file twice? I can't think of a way of
preventing the same fetch from happening twice except by checking the
existence of, say, the last 10 OIDs corresponding to that path. But if
we have the list of those 10 OIDs, we could just prefetch those 10 OIDs
without needing a new filter.

Another issue (but a smaller one) is this does not fetch all objects
necessary if the file being "blame"d has been renamed, but that is
probably solvable - we can just refetch with the old name.

Another possible solution that has been discussed before (but a much
more involved one) is to teach Git to be able to serve results of
computations, and then have "blame" be able to stitch that with local
data. (For example, "blame" could check the history of a certain path to
find the commit(s) that the remote has information of, query the remote
for those commits, and then stitch the results together with local
history.) This scheme would work not only for "blame" but for things
like "grep" (with history) and "log -S", whereas
"--filter=sparse:parthlist" would only work with "blame". But
admittedly, this solution is more involved.
