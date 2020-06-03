Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510ECC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 04:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2723C206C3
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 04:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YIecsaSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgFCEww (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCEwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 00:52:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A2C05BD43
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 21:52:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so774764pfc.5
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/E6QkegOuPEPWWuds+B9AkiVZ00kCgw3Ko/jyj7XgTE=;
        b=YIecsaSS2xUC6nHD7I3bfQVemLeIHX0lpROLCICfb7xjABOWRFHRNC16ZKBzRcCw8V
         g5M58NKHm5l2dCZHoKBDcsao7n4cXqX+YJP2JpsnC+kKg3IA72JtJRClIVd48hfCFZDE
         qkx2+zU3406+pGQjTzB4xs2XdbZYsgKxdiwIWI8Lk6pbjfw64LZuM8MeH8lY27/BWQMk
         yRQ7Jk+fm/n27GQoj2MN6+A2KnuaHV6Jhsfxv2XCaWq+Olas2NM8DS0NBBT1ktC2HvH5
         DZz8zj7kipTOgZfyPu6YKtHPn0PJHPxaoTdk3PSck7ryTRyFxNl+8cTx3ciDFRjWekKt
         9+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/E6QkegOuPEPWWuds+B9AkiVZ00kCgw3Ko/jyj7XgTE=;
        b=g+5MYC0mF7iYgJDp3i+OKoWjmh2bKK9K8BBNr5jBAI1ootD739vgsFwkUp6CnRdOXu
         fwt3cXGrsrUoYqshx/sRK4vTG8yOnQ8Nv+qMgGisLybMOHFkimdtgG6pX1/lgouYu4Xd
         0dWDXGoc5CRKvKYi96HKr+6X+/2DFRnXB1T7Qd3jLJJLDRDKeUysmxzgxXkqeTR42+BY
         8/EWzbP1YuKombK5naidIWclQKZ38/TNJrgnsyLfpr6YiiRczZknmnHbewkFo+vtZ3jG
         WMdS7rFD9lB2deoHcfR3Fe/YjlFGah0iN+9CF94E6FOg1xLP8fHat7Ya5LVXU2KseF+1
         cDvQ==
X-Gm-Message-State: AOAM532pOpbRysyiWRftcZsBsv2AQIil9ZfV0acVUmSUYsxndKXBNnxa
        37MYBT1Ytm1hCi2gxqSwVXVU6w==
X-Google-Smtp-Source: ABdhPJzc1e3YntKhvvfbrSbG3mAZCkYkoH1zedXsw/BD1rtfOVddgWV7REvxpdqVqCvx5pKSbNbAew==
X-Received: by 2002:a17:90a:69c3:: with SMTP id s61mr3360131pjj.212.1591159970964;
        Tue, 02 Jun 2020 21:52:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b16sm629998pfd.111.2020.06.02.21.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 21:52:50 -0700 (PDT)
Date:   Tue, 2 Jun 2020 22:52:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com,
        Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603045248.GA20266@syl.local>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603034213.GB253041@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, Jun 02, 2020 at 08:42:13PM -0700, Jonathan Nieder wrote:
> Hi,
>
> Taylor Blau wrote:
>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  builtin/receive-pack.c   |  4 ++--
> >  commit.h                 |  2 ++
> >  fetch-pack.c             | 10 +++++-----
> >  shallow.c                | 30 +++++++++++++++++++++---------
> >  t/t5537-fetch-shallow.sh | 29 +++++++++++++++++++++++++++++
> >  5 files changed, 59 insertions(+), 16 deletions(-)
>
> I haven't investigated the cause yet, but I've run into an interesting
> bug that bisects to this commit.  Jay Conrod (cc-ed) reports:
>
> | I believe this is also the cause of Go toolchain test failures we've
> | been seeing. Go uses git to fetch dependencies.
> |
> | The problem we're seeing can be reproduced with the script below. It
> | should print "success". Instead, the git merge-base command fails
> | because the commit 7303f77963648d5f1ec5e55eccfad8e14035866c
> | (origin/master) has no history.
>
> -- 8< --
> #!/bin/bash
>
> set -euxo pipefail
> if [ -d legacytest ]; then
>   echo "legacytest directory already exists" >&2
>   exit 1
> fi
> mkdir legacytest
> cd legacytest
> git init --bare
> git config protocol.version 2
> git config fetch.writeCommitGraph true
> git remote add origin -- https://github.com/rsc/legacytest
> git fetch -f --depth=1 origin refs/heads/master:refs/heads/master
> git fetch -f origin 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/*'
> git fetch --unshallow -f origin
> git merge-base --is-ancestor -- v2.0.0 7303f77963648d5f1ec5e55eccfad8e14035866c
> echo success
> -- >8 --

Thanks to you and Jay for the report and reproduction script. Indeed, I
can reproduce this on the tip of master (which is equivalent to v2.27.0
at the time of writing).

> The fetch.writeCommitGraph part is interesting.  When does a commit
> graph file get written in this sequence of operations?  In an
> unshallow operation, does the usual guard against writing a commit
> graph in a shallow repo get missed?

The last 'git fetch' is the one that writes the commit-graph. You can
verify this by sticking a 'ls objects/info' after each 'git' invocation
in your script.

Here's where things get weird, though. Prior to this patch, Git would
pick up that the repository is shallow before unshallowing, but never
invalidate this fact after unshallowing. That means that once we got to
'write_commit_graph', we'd exit immediately since it appears as if the
repository is shallow.

In this patch, we don't do that anymore, since we rightly unset the fact
that we are (were) shallow.

In a debugger, I ran your script and a 'git commit-graph write --split
--reachable' side-by-side, and found an interesting discrepancy: some
commits (loaded from 'copy_oids_to_commits') *don't* have their parents
set when invoked from 'git fetch', but *do* when invoked as 'git
commit-graph write ...'.

I'm not an expert in the object cache, but my hunch is that when we
fetch these objects they're marked as parsed without having loaded their
parents. When we load them again via 'lookup_object', we get objects
that look parsed, but don't have parents where they otherwise should.

I'm going to CC Stolee to see if he has any thoughts on how to handle
this and/or if my idea is on the right track.

> "rm -fr objects/info/commit-graphs" recovers the full history in the
> repo, so this is not a case of writing the wrong shallows --- it's
> only a commit graph issue.
>
> I'll take a closer look, but thought I'd give others a chance to look
> to in case there's something obvious. :)
>
> Thanks,
> Jonathan

Thanks,
Taylor
