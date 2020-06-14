Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A7C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 06:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD8E2065C
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCVey7vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgFNGLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgFNGLX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 02:11:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE354C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 23:11:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so5673576pje.4
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:content-transfer-encoding;
        bh=QAoa+iDRXCuGT856N6Kmz1OUUdxg59PqrwezE4tkM00=;
        b=NCVey7vEFs4RTSrj4n68COL3hfk6y2SP5b5ZF2u/Y4ICAG+fHzY7yaWd3pA05AdcVV
         rcx4Suj81JFZ+HmmshTpyu+DpxPCXcXs88ipDrq/f4pzMQhmzAYV+Gh/KyhQSWsziQiC
         /z5pIeIZi8bhkrNB42VRPWF4svFDW+VO3U+vvRdKnFiswBOhrabvJqQw5Pg+snE3BZLr
         OQBCD1OjC5Gtjnn1aJGUzXYyb7DBq+d4FCx7HNCcbLAryjrkEkXmyNvJlYDTCGizWrDN
         NH4b3fWAibUJ+aAWi0tUZAhuBJS804Y4axWZTyO8B0CClRoiJPHgEBiA/RZzgIIKMmq4
         jrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:content-transfer-encoding;
        bh=QAoa+iDRXCuGT856N6Kmz1OUUdxg59PqrwezE4tkM00=;
        b=qIhjw5x7orODwIs1hvw2DX977ziGOyDvPSsw7hanNPLUfMbhxVmowknqMH91XpZarC
         aBXnUR4yR8OdQ8ZA6suQ3HoYr5ufZuR6j4wB2hfhKo1+l0tuj3zMx0TFkWhSWljbeOKK
         FClGkJGyvs/rSBEtcyfMX30ha8/XW47is+yq0E5tpQS5xduS+wCyamrEeTLja1zwoyxQ
         cb/N5SXQHMPS61jZi+I1OGz6lejmk5cj1AesNOzDITBUYX3d1t1B4Gf1XJbzBd7pCjUv
         jOfUfF+XJAstRU96RmlB0a79W4pvCiO1Ui6anFPo4kwRGiWYNHrLERlU4KU4rAN/ZarZ
         FfQg==
X-Gm-Message-State: AOAM531n/dPGnC1Bedu8+ZtrmsKGG5Uqb6EgL1bGpoDjeAMUxjD9PB/Z
        NKtZiIASck6rfpmDtxcrOkYQcTcEVto=
X-Google-Smtp-Source: ABdhPJyH+jR+1iV9yvlf2mWvDoTOKyaQUzxcyFeck+NbLDTCouEZEdTAbGmQKFKKi0juWL7nXjqadA==
X-Received: by 2002:a17:90a:c85:: with SMTP id v5mr5949609pja.114.1592115081884;
        Sat, 13 Jun 2020 23:11:21 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:b99:abc0:e0d9:9ee3:1a9c:5095])
        by smtp.gmail.com with ESMTPSA id gb4sm3467880pjb.6.2020.06.13.23.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:11:20 -0700 (PDT)
Date:   Sun, 14 Jun 2020 11:39:38 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     jnareb@gmail.com
Cc:     stolee@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
Message-ID: <20200614060938.GA3024@Abhishek-Arch>
Reply-To: 8b0facef-c85d-c25c-d49d-2bc1a3836e77@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.06.2020, Jakub Narębski wrote:

> On 12.06.2020, Abhishek Kumar wrote:
> 
> > Commit slab relies on uniqueness of commit->index to access data. As
> > submodules are repositories on their own, alloc_commit_index() (which
> > depends on repository->parsed_objects->commit_count) no longer
> > returns unique values.
> > 
> > This would break tests once we move `generation` and `graph_pos` into
> > a
> > commit slab, as commits of supermodule and submodule can have the same
> > index but must have different graph positions.
> 
> First, commits of supermodule and of submodule are in different graphs,
> so I don't see why they have to be in the same serialized commit-graph
> file.
> 

I should have been clearer in the commit message:

commit->index = ith commit allocated for the repository.

As both supermodule and submodule are repositories, they can have
commits with the same index.

This means that were both the ith commit allocated for supermodule and
submodule respectively.

However, the commit-slab code treats them identically (because of the
same index) and they (incorrectly) have same generation number and graph
position.

Switching to a global counter instead of per-repo counter avoids having
two commits with the same index in the first place.

> Second, Git stores many different types of information on slab already.
> How comes that we have not had any problems till now?  
> 
> There is contains_cache, commit_seen, indegree_slab, author_date_slab,
> commit_base, commit_pos, bloom_filter_slab, buffer_slab,
> commit_rev_name,
> commit_names, commit_name_slab, saved_parents, blame_suspects,
> commit_todo_item.
> 

That's a fair point - It seems rather unlikely that we had not faced
this problem yet.

> > 
> > Let's introduce a counter variable, `parsed_commits_count` to keep
> > track
> > of parsed commits so far.
> 
> All right, thought it might be worth mentioning that it is a global
> variable, or rather a static variable in a function.
> 

Alright, noted.

> > 
> > 
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> > 
> > CI Build for the failing tests:
> > https://travis-ci.com/github/abhishekkumar2718/git/jobs/345413840
> 
> The failed tests are, from what I see:
> - t4060-diff-submodule-option-diff-format.sh
> - t4041-diff-submodule-option.sh
> - t4059-diff-submodule-not-initialized.sh
> 
> 
> > 
> >   alloc.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/alloc.c b/alloc.c
> > index 1c64c4dd16..29f0e3aa80 100644
> > --- a/alloc.c
> > +++ b/alloc.c
> > @@ -101,7 +101,9 @@ void *alloc_object_node(struct repository *r)
> >   
> >   static unsigned int alloc_commit_index(struct repository *r)
> >   {
> > -     return r->parsed_objects->commit_count++;
> > +     static unsigned int parsed_commits_count = 0;
> > +     r->parsed_objects->commit_count++;
> 
> Do we use r->parsed_objects->commit_count anywhere?

We don't use it anywhere else. 14ba97f8 (alloc: allow arbitary
repositories for alloc functions, 2019-05-15) made the count per
repository but it's only been used to assign commit index.

Junio suggested that we could remove commit_count from the struct and
clean up function calls a bit.

> 
> > +     return parsed_commits_count++;
> 
> Does it matter that it is not thread safe, because it is not atomic?
> Shouldn't it be
> 
>   +     static _Atomic unsigned int parsed_commits_count = 0;
> 
>   or
> 
>     +   static _Atomic unsigned int parsed_commits_count =
>     ATOMIC_VAR_INIT(0);
> 
>     (If it is allowed).
> 
>     >   }
>     >   
>     >   void init_commit_node(struct repository *r, struct commit *c)
>     > 

Thanks
Abhishek
