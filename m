Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A753AC433DF
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0B125288
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 20:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="JLFU7+0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgFUUpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgFUUpD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 16:45:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17531C061794
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 13:45:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f23so12054070iof.6
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FOK9/732TKNpmX8sJAWnLtMG9aUpIfhp7VteJF9MtvA=;
        b=JLFU7+0mueG8KuKbk6F3717WDNEAXQi4nLjRbMZzCCBkjGS+nKtB+PUAhv28E1CHan
         qAMycdmseqFBZjeEb8JewKFPTbyA/nlYECWPMoiZ0gtm4YrQoweZZisyV4Qv/9wgobFD
         UOpYTP2PNIoeoB12L5mcxxAGIFMPaz4g3ah5W34xphP4bXeho4eH35awzQkpCsuAvAKa
         IlIfyHk0ggXi/iZOL9Crc61+OtbQFiVpRrjcQwwTdgGBoVUIquwdrYsmQW0/jmBLLMQ2
         V8K88gaENcoSEQ3tp8ONFD9pAYkqL0OMRJqFTpqtoOLJ/TnpaUpC7YEdgB1qJm4zA13z
         X7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FOK9/732TKNpmX8sJAWnLtMG9aUpIfhp7VteJF9MtvA=;
        b=lO78pwt8ZbAr8evl6GAf49lCqk060FvkO1E0hYCQYarjMYN4hf77QWlN8Gy0aBmHcM
         LVzYryrpvsrp2JIFcTxPnqRk2fNqw8ZPFx2Q2V9VU0962KqKEFBAnBpUbGxUlZpAT5CK
         wPdDXgfE0Rkv1fUwafoR39oFpWlMWZyGBrmwuFvPlzU78r9nSCTNBG6YV9c4Fny5ITl5
         hoMuH+e0Rya5FqAKb7+S14U+KIx+N1/rUUUW4nKJFiAHLYRPOoIG/ZR6q/BTlLvJ8okT
         zYnacWQ7imPUx78KMZKg1GHFHPJ7Frt5SuaVgW2Hb31CWY2Kfm5tmpmJxOK0gsLhahr3
         a7RA==
X-Gm-Message-State: AOAM532Fg//b7rAV73oroXjunpBGq/d8XIKJhRKk7XXR0fguKMkCW72p
        OEtqYHOb8mSHnBIlHuiRhMjh/zhgFpOAwExpkhHCGQ==
X-Google-Smtp-Source: ABdhPJwx1BWiJKaqYB1myvduIg+B/p/cg6GH7lFc7wf/yWJ7P6iKAHhnEM1wy1DqwHf2UFBWwjhcecbGPgIqoPpdAGI=
X-Received: by 2002:a02:2b24:: with SMTP id h36mr14991531jaa.104.1592772302393;
 Sun, 21 Jun 2020 13:45:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:150:0:0:0:0 with HTTP; Sun, 21 Jun 2020 13:45:01
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <20200515120333.GA4677@pflmari>
References: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
 <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com>
 <d4313777-ce8c-0b64-997e-17cb719c9ab8@gmail.com> <CAFChFyhZYm88cCo6X_XikT=HRQG9Pp0vyveXmAuComFUJYjRcA@mail.gmail.com>
 <20200515120333.GA4677@pflmari>
From:   Michael Forney <mforney@mforney.org>
Date:   Sun, 21 Jun 2020 13:45:01 -0700
Message-ID: <CAGw6cBuEshq18O_PrrGYuJi5VZ82XK3T9KuShneUqO2Ju0jtHw@mail.gmail.com>
Subject: Re: Possible git bug in commit-graph: "invalid commit position"
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Gary Oberbrunner <garyo@oberbrunner.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-15, Alex Riesen <alexander.riesen@cetitec.com> wrote:
> Gary Oberbrunner, Tue, Feb 04, 2020 23:33:42 +0100:
>> Sorry for the long reply delay; the bug went away and only just showed
>> up again. Here's the info you requested.
>> I'm now running git 2.25.0.
>
> I hit a very similar problem today with 2.26.0. Also in a submodule.
>
> Removing and regenerating the commit graph did not help and I did not have
> the
> commit-graphs directory (only a file). "git commit-graph verify" does not
> find
> anything. Switching writeCommitGraph on and regenerating the commit graph
> makes no difference.
>
> I can trigger it reliably by visiting the broken(?) commit in supermodule
> with:
>
>     git show --submodule=log <commit>
>
> I see nothing special in the commit invovled. It is just a single commit in
> my
> case, and the commit is a merge of two branches.

I hit this bug a while back, and it went away after I deleted the
commit-graph in the submodule and regenerated it (IIRC).

I just ran into it again (on 2.27.0), and this time, I did some digging.

I have a repository containing a number of submodules, and the bug
appeared after I updated one of the submodules, and then looked at
`git log -p` with diff.submodule = log. Just like Alex, I can reliably
trigger the error with `git show --submodule=log <commit>`.

I rebuilt git with some print statements to try to see what's going
on, and got the following:

	/src/oasis/.git/modules/pkg/file/src c81d1ccbf4c224af50e6d556419961dba72666c7
		pos: 4986, num_commits: 6452, num_commits_in_base: 0
	/src/oasis/.git/modules/pkg/file/src 9f2f793847c6aeab9501287b6847dc842c84630f
		pos: 3964, num_commits: 6452, num_commits_in_base: 0
	/src/oasis/.git/modules/pkg/file/src fd7eb1f793944635b92bfa56a84a4dc1dbefb119
		pos: 6383, num_commits: 6452, num_commits_in_base: 0
	/src/oasis/.git/modules/pkg/file/src d955cefc956ba537cfc0556023a65fe80bd2d82b
		pos: 5436, num_commits: 6452, num_commits_in_base: 0
	/src/oasis/.git/modules/pkg/file/src 0c79c693d6a86f7ad7ada2a9a1eb3bdf483f77cc
		pos: 301, num_commits: 6452, num_commits_in_base: 0
	.git fa09b87efa9b9664e4e53ab768cfa5f51a6c6fa2
		pos: 6292, num_commits: 5177, num_commits_in_base: 0
	fatal: invalid commit position. commit-graph is likely corrupt

Using `git commit-graph verify`, I confirmed that the main
repository's commit graph contains 5177 commits, and the submodule
repository's commit-graph contains 6452 commits. Commit fa09b8 is part
of the submodule, not the main repository, so it makes sense that it
is an invalid commit for the main repositories commit-graph.

So, this seems a little fishy. fill_commit_in_graph is getting called
with the main repository and a commit belonging to the submodule.
Looking through the call stack in gdb, I see that the initial calls to
fill_commit_in_graph come from show_submodule_header, which computes
left, right, and merge_bases. Then, those commits are passed to
prepare_submodule_summary, but this function does *not* accept a
submodule parameter. prepare_submodule_summary calls
repo_init_revisions with the_repository, which seems to be the source
of the problem. I think it should be using the submodule repository
instead.

I changed prepare_submodule_summary to accept a repository and to use
that instead, but the issue persisted. Digging deeper, this is because
revision.c:process_parents uses parse_commit_gently, which is a
synonym for repo_parse_commit_gently(the_repository, ...). I changed
it to use repo_parse_commit_gently(revs->repo, ...), and this time,
the problem went away.

I'm not very familiar with the git codebase, but am I on the right
track here? I also noticed a number of other calls to
parse_commit_gently in revision.c, and I think those should pass
revs->repo as well. Does that sound right? If so, I can send a patch
to fix these issues.

-Michael
