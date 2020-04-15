Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360CC2BB55
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6292063A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="D7aoAY4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414988AbgDOP4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414983AbgDOPz4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 11:55:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ACCC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:55:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p8so108171pgi.5
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+edC90MbJpOAx9k8E92PEcqWKCnd2wt9CiYII7kJK+k=;
        b=D7aoAY4zprKQSjZPUSuiSZLIyu2UsNC5p1L+0jyPYqI60Zl7AP1T2+s+Ohp62EgZgj
         EFdXkwZqe61n6QMtkQRRSve4xwt4bfgAob68SHVQ4GtwwDraNPxvzPrq1BAe3o9liMR2
         1xdgCZLZWy7pYLGc4dC+0BKUMxLKiUCwA0takbMriRamLsL0itozb6rj1W2qJHYIYbwK
         LRX9eugTv/5vV2g4y4y1xNb/3msaocqK/njUcc1g7f3JLO5sbVP/Tq0rHVqKEwHdRGIG
         RZFt6edEyfVauh1p/J92D6+bEERSfe97ZuWa8FHwxvfRUoSjOQlyLbo60kQflqpdW93Z
         m6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+edC90MbJpOAx9k8E92PEcqWKCnd2wt9CiYII7kJK+k=;
        b=tHefOI15g1xVbmiH6cXv5nGqSBZTrIVqjMkYqXx92+Y0kW7EzFM/PFWdfNHqNpiVHz
         AEgoskxTHR6Cc3aoLPcdaAFZL8SjooWrfAKnfpz9Of0AcJEeSz7fHldkNHb58t43v6Hp
         3YKi/0MXbzYETnY8t5OeJTPvgdWuwoT89fqHsJED8x1TGWN1t4Xz19ZhCeWvgENzxbUN
         lU25dDxxAgjU13l5B1UHbpE2PM21dhDOJHgHGwk5Vr5C65gzw9uIgZp2pUOXFA+zW0PB
         FKt4rE4JbEt3wG6ErKZ5qsTtRV3sABn9akhxBhYqxY0TJTsi/j91mC5oL0R5d+xJf18M
         S5JA==
X-Gm-Message-State: AGi0PuaA9e768UkauApZq6dk474MB/205miXcZuumHTdLraDORP/2mw8
        dGjtrQe4ZphG0uDF9/F3yc4PW+/SCAx32bez
X-Google-Smtp-Source: APiQypJxURB0y69RYr5t1Mn9KOEPe9F6YWv7gJ/tWvb1j8rn3c+7Vgsdw8gY2Dt1JaWlp7lCy02qIA==
X-Received: by 2002:a63:ac43:: with SMTP id z3mr26633726pgn.324.1586966154316;
        Wed, 15 Apr 2020 08:55:54 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o187sm14114263pfb.12.2020.04.15.08.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:55:53 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:55:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
Message-ID: <20200415155551.GB22823@syl.local>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com>
 <20200414235057.GA6863@syl.local>
 <cdc80c0b-696f-19b8-d132-592782537b03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdc80c0b-696f-19b8-d132-592782537b03@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 07:55:19AM -0400, Derrick Stolee wrote:
> On 4/14/2020 7:50 PM, Taylor Blau wrote:
> > On Tue, Apr 14, 2020 at 04:31:19PM -0400, Derrick Stolee wrote:
> >> On 4/14/2020 4:22 PM, Elijah Newren wrote:
> >>> Hi,
> >>>
> >>> I was building a version of git for internal use, and thought I'd try
> >>> turning on features.experimental to get more testing of it.  The
> >>> following test error in the testsuite scared me, though:
> >>>
> >>> t5537.9 (fetch --update-shallow):
> >>>
> >>> ...
> >>> + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> [snip]
> >> Well, commit-graphs are not supposed to do anything if we have
> >> shallow clones. We definitely don't load a commit-graph in that
> >> case. Seems like we need an extra check in write_commit_graph()
> >> to stop writing in the presence of shallow commits.
>
> Here, I assumed that the commit-graph wasn't checking the shallow status
> appropriately, but...
>
> > This rang a bell to me, too. There's a bug, but it's due to the mutative
> > side-effects of 'is_repository_shallow' along with '--update-shallow' (a
> > normal 'git fetch' works fine here, with or without
> > fetch.writeCommitGraph).
>
> ...this makes sense as to why this particular case failed.
>
> (Please allow me this brief moment to communicate my extreme dislike
> of shallow clones. There, I'm done.)

Noted ;).

> > Here's a patch that I didn't sign-off on that fixes the problem for me.
> >
> > --- >8 ---
> >
> > Subject: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
> >
> > In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
> > 2019-01-10), the author noted that 'is_repository_shallow' produces
> > visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.
> >
> > This is a problem for e.g., fetching with '--update-shallow' in a
> > shallow repsoitory with 'fetch.writeCommitGraph' enabled, since the
>
> repository
>
> > update to '.git/shallow' will cause Git to think that the repository
> > *isn't* shallow when it is, thereby circumventing the commit-graph
> > compatability check.
>
> compatibility

Whoops, thanks for pointing these out.

> > This causes problems in shallow repositories with at least shallow refs
> > that have at least one ancestor (since the client won't have those
> > object(s), and therefore can't take the reachability closure over
> > commits to be written to the commit-graph).
> >
> > Address this by introducing 'reset_repository_shallow()', and calling it
> > when the shallow file is updated, forcing 'is_repository_shallow' to
> > re-evaluate whether the repository is still shallow after fetching in
> > the above scenario.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  commit.h     |  1 +
> >  fetch-pack.c |  1 +
> >  shallow.c    | 15 ++++++++-------
> >  3 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/commit.h b/commit.h
> > index 008a0fa4a0..ee1ba139d4 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -251,6 +251,7 @@ int register_shallow(struct repository *r, const struct object_id *oid);
> >  int unregister_shallow(const struct object_id *oid);
> >  int for_each_commit_graft(each_commit_graft_fn, void *);
> >  int is_repository_shallow(struct repository *r);
> > +void reset_repository_shallow(struct repository *r);
> >  struct commit_list *get_shallow_commits(struct object_array *heads,
> >  					int depth, int shallow_flag, int not_shallow_flag);
> >  struct commit_list *get_shallow_commits_by_rev_list(
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 1734a573b0..051902ef6d 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1630,6 +1630,7 @@ static void update_shallow(struct fetch_pack_args *args,
> >  		if (*alternate_shallow_file == '\0') { /* --unshallow */
> >  			unlink_or_warn(git_path_shallow(the_repository));
> >  			rollback_lock_file(&shallow_lock);
> > +			reset_repository_shallow(the_repository);
> >  		} else
> >  			commit_lock_file(&shallow_lock);
> >  		alternate_shallow_file = NULL;
> > diff --git a/shallow.c b/shallow.c
> > index 7fd04afed1..fac383dec9 100644
> > --- a/shallow.c
> > +++ b/shallow.c
> > @@ -40,13 +40,6 @@ int register_shallow(struct repository *r, const struct object_id *oid)
> >
> >  int is_repository_shallow(struct repository *r)
> >  {
> > -	/*
> > -	 * NEEDSWORK: This function updates
> > -	 * r->parsed_objects->{is_shallow,shallow_stat} as a side effect but
> > -	 * there is no corresponding function to clear them when the shallow
> > -	 * file is updated.
> > -	 */
> > -
>
> It's always good to remove these NEEDSWORK comments. I wonder if the
> problem is more complicated than your patch makes it seem, or else
> the original author would have done it correctly at first.
>
> But you are definitely closing out one dangling side-effect, which is
> an improvement.

Yeah, I have no idea if there are other spots that I'm missing (I only
spent a few minutes on this patch before leaving for the day to go eat
dinner), hence why I CC'd Jonathan Tan to see if he had anything else in
mind when he wrote this 'NEEDSWORK' comment.

If he feels that this is a generally good direction, I'm more than happy
to look for other spots myself, address them, and then submit this as a
real patch.

> >  	FILE *fp;
> >  	char buf[1024];
> >  	const char *path = r->parsed_objects->alternate_shallow_file;
> > @@ -79,6 +72,12 @@ int is_repository_shallow(struct repository *r)
> >  	return r->parsed_objects->is_shallow;
> >  }
> >
> > +void reset_repository_shallow(struct repository *r)
> > +{
> > +	r->parsed_objects->is_shallow = -1;
> > +	stat_validity_clear(r->parsed_objects->shallow_stat);
> > +}
> > +
> >  /*
> >   * TODO: use "int" elemtype instead of "int *" when/if commit-slab
> >   * supports a "valid" flag.
> > @@ -362,6 +361,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
> >  		 * shallow file".
> >  		 */
> >  		*alternate_shallow_file = "";
> > +	reset_repository_shallow(the_repository);
> >  	strbuf_release(&sb);
> >  }
> >
> > @@ -411,6 +411,7 @@ void prune_shallow(unsigned options)
> >  			die_errno("failed to write to %s",
> >  				  get_lock_file_path(&shallow_lock));
> >  		commit_lock_file(&shallow_lock);
> > +		reset_repository_shallow(the_repository);
> >  	} else {
>
> These are likely good places to call reset_repository_shallow(),
> but perhaps we should also call it here in commit-graph.c?
>
>  static int commit_graph_compatible(struct repository *r)
>  {
>         if (!r->gitdir)
>                 return 0;
>
>         if (read_replace_refs) {
>                 prepare_replace_object(r);
>                 if (hashmap_get_size(&r->objects->replace_map->map))
>                         return 0;
>         }
>
>         prepare_commit_graft(r);
>         if (r->parsed_objects && r->parsed_objects->grafts_nr)
>                 return 0;
> +       reset_repository_shallow(r);
>         if (is_repository_shallow(r))
>                 return 0;
>
>         return 1;
>  }
>
> Or am I misunderstanding the state that reset_repository_shallow()
> puts us in? My expectation is that is_repository_shallow() will
> act as if the shallow variables had never been set and will look
> for shallow data from disk.

You're not misunderstanding it at all. I don't think that this location
is strictly necessary, since all of the other locations that change
'.git/shallow' are already invaliding the shallow-ness checks, so by the
time we get to this point 'is_repository_shallow' has to take the slow
path and redetermine whether or not we are actually shallow.

So, I don't think this location is strictly necessary, and it's
potentially slowing us down a little bit, but it is hardening us against
other parts of the code that may not call 'reset_repository_shallow'
when they should have.

> Thanks,
> -Stolee

Thanks for the review.

Thanks,
Taylor
