Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3EC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6435F206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8q2Mtwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgCLSEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:04:31 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:55816 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCLSEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:04:31 -0400
Received: by mail-qt1-f202.google.com with SMTP id o10so4509573qtk.22
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5iENwvyP7RaH61n5VzBcFe1Dxx4HsaHMoOMCo0xEIbs=;
        b=h8q2Mtwdn88bCgcZMNKaicXP2+eIiUAfVegnuuDbp5OP84aprgaOXbFEJ9z2lPzK/3
         JTcLh1b7+og0KeZFBlPZFi35romGJZI86/0Q0cx7YGjSyBZhabqYLv0/U3M6YWxGMpn6
         rMj+cLsg4W4BsL7vRpHwZfXMP0ccYGQLT5fbrCwZ9E3c92hy49phlaTAKFYl2mEf2z6n
         tFA0Lgx1egtyXspOR/mSadqIdNE6wgWbSPsFgU601IMqvE0ZIRp71kmkhPVeAZY5PQlA
         DNiFcTO+tXq4lQD4rPwTF0MCTLtFRUvNw2WRXArqUwZ7EeKy3+nsBGPknDuNQW8173bZ
         i/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5iENwvyP7RaH61n5VzBcFe1Dxx4HsaHMoOMCo0xEIbs=;
        b=K8ajDdTZUDWGRoR2bZvJf8nXwQs6HQ/wbfXZGcjm3n6guMaYtYzj1BURF5blOVHap6
         gq8FQBm3/yqHc12V7AKxak7x5LnIQRW66GcY0nKabS210+qq5f1+7tO4XoA/Ze7gyuHm
         efjMeau8sYzLQkAo4boXDJKyaes+pm8DNf7XRd7WZ0++uS7j5xCRfiCrd9AZryMk5kEb
         qK14f5cqXWHKPKY9IzlafT7Rxl9iVaahuUqHwkcpIVGigD/HnXqASyviwy4KXZWsDL9Q
         8B7GbRIoW+RqhkRBPejck7nAaK6aqPUv5Rq7jvq+ttDZSMpjwfrgJqHnJfeZ3XbZmpSA
         /oiQ==
X-Gm-Message-State: ANhLgQ3+f74zs587H/aJM9KWJ361T0UjpfO4kCY13mf5plglZyA1lEth
        ViT2FsNg00oo5ZdzzTWWA2V6UVNrIrlsqGCTLSoa
X-Google-Smtp-Source: ADFU+vvQUujyX4HU5vjSuiO7sKPr8oYw7gni1kn7ifL0r10JZ503i/5OsHB7ZQdpmeelRQsSmHv4Y3LAXGMfmqkRygpd
X-Received: by 2002:ac8:4548:: with SMTP id z8mr8870723qtn.188.1584036269784;
 Thu, 12 Mar 2020 11:04:29 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:04:27 -0700
In-Reply-To: <20200310225641.96556-1-jonathantanmy@google.com>
Message-Id: <20200312180427.192096-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200310225641.96556-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     newren@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Does this suggest that the cherry-pick detection is suboptimal and
> > needs to be improved?  When rebasing, it is typical that you are just
> > rebasing a small number of patches compared to how many exist
> > upstream.  As such, any upstream patch modifying files outside the set
> > of files modified on the rebased side is known to not be PATCHSAME
> > without looking at those new files.
> 
> That's true - and this would drastically reduce the fetches necessary in
> partial clone, perhaps enough that we no longer need this check.
> 
> In the absence of partial clone, this also might improve performance
> sufficiently, such that we no longer need my new option. (Or it might
> not.)

I took a further look at this. patch-ids.c and its caller
(cherry_pick_list() in revision.c) implement duplicate checking by first
generating full diff outputs for the commits in the shorter side,
putting them in a hashmap keyed by the SHA-1 of the diff output (and
values being the commit itself), and then generating full diff outputs
for the commits in the longer side and checking them against the
hashmap. When processing the shorter side, we could also generate
filename-only diffs and put their hashes into a hashset; so when
processing the longer side, we could generate the filename-only diff
first (without reading any blobs) and checking them against our new
hashset, and only if it appears in our new hashset, then do we generate
the full diff (thus reading blobs).

One issue with this is unpredictability to the user (since which blobs
get read depend on which side is longer), but that seems resolvable by
not doing any length checks but always reading the blobs on the right
side (that is, the non-upstream side).

So I would say that yes, the cherry-pick detection is suboptimal and
could be improved. So the question is...what to do with my patch? An
argument could be made that my patch should be dropped because an
improvement in cherry-pick detection would eliminate the need for the
option I'm introducing in my patch, but after some thought, I think that
this option will still be useful even with cherry-pick detection. If we
move in a direction where not only blobs but also trees (or even
commits) are omitted, we'll definitely want this new option. And even if
a user is not using partial clone at all, I think it is still useful to
suppress both the filtering of commits (e.g. when upstream has a commit
then revert, it would be reasonable to cherry-pick the same commit on
top) and reduce disk reads (although I don't know if this will be the
case in practice).
