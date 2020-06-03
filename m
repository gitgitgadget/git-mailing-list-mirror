Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937FC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 05:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE14020678
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 05:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LbT2WhW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFCFQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCFQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 01:16:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D80C05BD43
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 22:16:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so396563plt.12
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xk9oikbeezqzWPTpr+CwpYcPmx9IuyqGSv/CN5SMvLU=;
        b=LbT2WhW+TF6AMRmiwbRAVsiBOVFHiz72xc0tXT4syob1XlYTlM+GdpIhCyn8OYF6RX
         zHdlaQFjhb3QFVu6/UYaLV0lBglJDIciE4LVvRubHzdzInB5mkbpp4lo6lfmkqc0sJS8
         akT0JytwKL6gmC+pJOGE5E/FrfC6lMtJku7AaKrB+IPrjud8uwBbCnjoITypeCncMHiH
         9gMoN5pzmA10ygF8Qdoq67taKJpGSzTNZYx+A/Dyy/kgARKRtdJLxY/jS7wqwTj7gbMM
         +zGEm04hM5NDjA7Ufe68saKc1+4AKjq2ZTLpqkc0LF9WNyqLZ0ByS5vZRFvXGkb+gRpw
         6qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xk9oikbeezqzWPTpr+CwpYcPmx9IuyqGSv/CN5SMvLU=;
        b=I1mpzFh42HYidCw3FPuqEKid8i3fGfApNXheie+ps8YYemmKQP+zOin9qoLIs12+28
         YxaTKQhszqbo8TQNhqW8X68ucEAJH+sAkjG8JGJ5GuYMBJVlj9kEOwTGreyk70h/YXg5
         CUSa9ZbF0qPZwjvq9Q11jQz0O5X/dNJznPOsNiqdA9wKFuHU6V76H1ZwGo1uKZ5vvWVf
         EgFg+a+sJ8xnLKrB6H6Sk/We7l6QM98p0SWMnI0vj5Kfdi+MsFmlundxeeZn8q0LI2Ey
         2KCvrZRdzTfxiOF3Mu5MHs2siSxG//scZB0G4PxXSdxLZtHeQ5NAY5keZDE2AOPMYwMU
         5Ppw==
X-Gm-Message-State: AOAM5321Y9wkz9j4fUtIu7L4sAVEZus+oe79idmVpfS8zza6tVSW0CVz
        elBWs+k4+DxhOP/3NoCSujQuUQ==
X-Google-Smtp-Source: ABdhPJzIw+nfK/KCras/AAKysJsp7V1zM4leGwsxLdTIvL2iUVE6kgYT7hCG/3YeiaRr7pT9v29TJA==
X-Received: by 2002:a17:902:7002:: with SMTP id y2mr27327637plk.94.1591161394499;
        Tue, 02 Jun 2020 22:16:34 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id gd1sm781063pjb.14.2020.06.02.22.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 22:16:33 -0700 (PDT)
Date:   Tue, 2 Jun 2020 23:16:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com,
        Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603051631.GA20678@syl.local>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
 <20200603045248.GA20266@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603045248.GA20266@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 02, 2020 at 10:52:48PM -0600, Taylor Blau wrote:
> Hi Jonathan,
>
> On Tue, Jun 02, 2020 at 08:42:13PM -0700, Jonathan Nieder wrote:
> > Hi,
> >
> > Taylor Blau wrote:
> >
> > > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > > ---
> > >  builtin/receive-pack.c   |  4 ++--
> > >  commit.h                 |  2 ++
> > >  fetch-pack.c             | 10 +++++-----
> > >  shallow.c                | 30 +++++++++++++++++++++---------
> > >  t/t5537-fetch-shallow.sh | 29 +++++++++++++++++++++++++++++
> > >  5 files changed, 59 insertions(+), 16 deletions(-)
> >
> > I haven't investigated the cause yet, but I've run into an interesting
> > bug that bisects to this commit.  Jay Conrod (cc-ed) reports:
> >
> > | I believe this is also the cause of Go toolchain test failures we've
> > | been seeing. Go uses git to fetch dependencies.
> > |
> > | The problem we're seeing can be reproduced with the script below. It
> > | should print "success". Instead, the git merge-base command fails
> > | because the commit 7303f77963648d5f1ec5e55eccfad8e14035866c
> > | (origin/master) has no history.
> >
> > -- 8< --
> > #!/bin/bash
> >
> > set -euxo pipefail
> > if [ -d legacytest ]; then
> >   echo "legacytest directory already exists" >&2
> >   exit 1
> > fi
> > mkdir legacytest
> > cd legacytest
> > git init --bare
> > git config protocol.version 2
> > git config fetch.writeCommitGraph true
> > git remote add origin -- https://github.com/rsc/legacytest
> > git fetch -f --depth=1 origin refs/heads/master:refs/heads/master
> > git fetch -f origin 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/*'
> > git fetch --unshallow -f origin
> > git merge-base --is-ancestor -- v2.0.0 7303f77963648d5f1ec5e55eccfad8e14035866c
> > echo success
> > -- >8 --
>
> Thanks to you and Jay for the report and reproduction script. Indeed, I
> can reproduce this on the tip of master (which is equivalent to v2.27.0
> at the time of writing).
>
> > The fetch.writeCommitGraph part is interesting.  When does a commit
> > graph file get written in this sequence of operations?  In an
> > unshallow operation, does the usual guard against writing a commit
> > graph in a shallow repo get missed?
>
> The last 'git fetch' is the one that writes the commit-graph. You can
> verify this by sticking a 'ls objects/info' after each 'git' invocation
> in your script.
>
> Here's where things get weird, though. Prior to this patch, Git would
> pick up that the repository is shallow before unshallowing, but never
> invalidate this fact after unshallowing. That means that once we got to
> 'write_commit_graph', we'd exit immediately since it appears as if the
> repository is shallow.
>
> In this patch, we don't do that anymore, since we rightly unset the fact
> that we are (were) shallow.
>
> In a debugger, I ran your script and a 'git commit-graph write --split
> --reachable' side-by-side, and found an interesting discrepancy: some
> commits (loaded from 'copy_oids_to_commits') *don't* have their parents
> set when invoked from 'git fetch', but *do* when invoked as 'git
> commit-graph write ...'.
>
> I'm not an expert in the object cache, but my hunch is that when we
> fetch these objects they're marked as parsed without having loaded their
> parents. When we load them again via 'lookup_object', we get objects
> that look parsed, but don't have parents where they otherwise should.

Ah, this only sort of has to do with the object cache. In
'parse_commit_buffer()' we stop parsing parents in the case that the
repository is shallow (this goes back to 7f3140cd23 (git repack: keep
commits hidden by a graft, 2009-07-23)).

That makes me somewhat nervous. We're going to keep any objects opened
prior to unshallowing in the cache, along with their hidden parents. I
suspect that this is why Git has kept the shallow bit as sticky for so
long.

I'm not quite sure what to do here. I think that any of the following
would work:

  * Keep the shallow bit sticky, at least for fetch.writeCommitGraph
    (i.e., pretend as if fetch.writecommitgraph=0 in the case of
    '--unshallow').

  * Dump the object cache upon un-shallowing, forcing us to re-discover
    the parents when they are no longer hidden behind a graft.

The latter seems like the most complete feasible fix. The former should
work fine to address this case, but I wonder if there are other
call-sites that are affected by this behavior. My hunch is that this is
a unique case, since it requires going from shallow to unshallow in the
same process.

I have yet to create a smaller test case, but the following should be
sufficient to dump the cache of parsed objects upon shallowing or
un-shallowing:

diff --git a/shallow.c b/shallow.c
index b826de9b67..06db857f53 100644
--- a/shallow.c
+++ b/shallow.c
@@ -90,6 +90,9 @@ static void reset_repository_shallow(struct repository *r)
 {
 	r->parsed_objects->is_shallow = -1;
 	stat_validity_clear(r->parsed_objects->shallow_stat);
+
+	parsed_object_pool_clear(r->parsed_objects);
+	r->parsed_objects = parsed_object_pool_new();
 }

 int commit_shallow_file(struct repository *r, struct shallow_lock *lk)

Is this something we want to go forward with? Are there some
far-reaching implications that I'm missing?

> I'm going to CC Stolee to see if he has any thoughts on how to handle
> this and/or if my idea is on the right track.
>
> > "rm -fr objects/info/commit-graphs" recovers the full history in the
> > repo, so this is not a case of writing the wrong shallows --- it's
> > only a commit graph issue.
> >
> > I'll take a closer look, but thought I'd give others a chance to look
> > to in case there's something obvious. :)
> >
> > Thanks,
> > Jonathan
>
> Thanks,
> Taylor

Thanks,
Taylor
