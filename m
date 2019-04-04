Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967A420248
	for <e@80x24.org>; Thu,  4 Apr 2019 00:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDDAVL (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 20:21:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45017 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDDAVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 20:21:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so215407pll.11
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pOhA4b0GZphxB/Y75HbAwJZLn4a6ILnsJT7p6ejjMAE=;
        b=eVUOdW1k1ZGZv7p/u2DJqXEHWbPiahSCWldf4awaDbiZjiP0A9scfRu+KdtxfzNraK
         yXE8NhjxKHoQggxSHsrEdNcoW2D8n9xB0o9UmIkY08EvHztmyoPdPuMHrgejGE+BcJw8
         P88MZEKtxShGSROvPNBH4olWCix66qsL8DlDuhhoZiXP9fTBByqWiJJPzW0MQCxuz1q5
         5xbKz0FYiCgeeMOyesfSS32Uv9U7XfheLZw6jfgzfPKAogQT4OUP1J1NcjirEdre3UB2
         frIhM5oyykgDLZkMM4mlZhfplNFDYttow+yo4rAjQ/YtCIKOU5BIA/Vh2EH9Kyv1ewcZ
         R+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pOhA4b0GZphxB/Y75HbAwJZLn4a6ILnsJT7p6ejjMAE=;
        b=JiEvr+VRaEFjuEulTy3tYCRP0Q9+hj75+AbpJsHNgS2h1NB7Jz0tGgKsB6SexJiPU8
         D4K4Cr9Rw3QeZ0oLkvkZ51pPpYN2comA5ra4fLgO4H8NTIpchDq+qhrCmtCIYRTyCe9w
         RUX6MJwxTNbA+AOd0LQvTMFrxOGCoGZeVtSDCbgPMXge4v88Jl8CJ4TGB35abXEzpVvX
         wHg+csLn+LVodieviTnIlTOxglH1Cz0OLi9u4CMlkW7nxbWPayQWRztFPioTBBXJPY+u
         sRR+YqAyHBE+wwzLjv+aji5MAl7XYy7w5h/on8JEUPa2ngkDtGo/xUBsCBwxu4jTw57X
         Z6Lw==
X-Gm-Message-State: APjAAAUkqzAgoI/C54OR29Ubq0HMVukPXr3aqEa82L7JEKD3jTT3944N
        UD7IfQpV6x/T2biu3Q+mfCJMCA==
X-Google-Smtp-Source: APXvYqzMuICKRO/7yjrQ3J03y9S5vH3TI6vHAw0dX40SVK5m5+lyyt0Ngn7zP7EC2qCyFVgLI6FSAA==
X-Received: by 2002:a17:902:8c89:: with SMTP id t9mr3069321plo.265.1554337269614;
        Wed, 03 Apr 2019 17:21:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id t8sm20740044pgp.5.2019.04.03.17.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 17:21:08 -0700 (PDT)
Date:   Wed, 3 Apr 2019 17:21:01 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] clone: do faster object check for partial clones
Message-ID: <20190404002101.GF60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        git@vger.kernel.org
References: <20190403194150.GA27199@sigill.intra.peff.net>
 <20190403205748.107979-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403205748.107979-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.03 13:57, Jonathan Tan wrote:
> > On Wed, Apr 03, 2019 at 10:27:21AM -0700, Josh Steadmon wrote:
> > 
> > > For partial clones, doing a full connectivity check is wasteful; we skip
> > > promisor objects (which, for a partial clone, is all known objects), and
> > > excluding them all from the connectivity check can take a significant
> > > amount of time on large repos.
> > > 
> > > At most, we want to make sure that we get the objects referred to by any
> > > wanted refs. For partial clones, just check that these objects were
> > > transferred.
> > 
> > This isn't strictly true, since we could get objects from elsewhere via
> > --shared or --reference. Those might not be promisor objects.
> 
> I don't think local clones (which --shared or --reference implies) can
> be partial, but the bigger point is below.
> 
> > Shouldn't we be able to stop a traversal as soon as we see that an
> > object is in a promisor pack?
> > 
> > I.e., here:
> > 
> > > +	if (opt->check_refs_only) {
> > > +		/*
> > > +		 * For partial clones, we don't want to walk the full commit
> > > +		 * graph because we're skipping promisor objects anyway. We
> > > +		 * should just check that objects referenced by wanted refs were
> > > +		 * transferred.
> > > +		 */
> > > +		do {
> > > +			if (!repo_has_object_file(the_repository, &oid))
> > > +				return 1;
> > > +		} while (!fn(cb_data, &oid));
> > > +		return 0;
> > > +	}
> > 
> > for each object where you ask "do we have this?" we could, for the same
> > cost, ask "do we have this in a promisor pack?". And the answer would be
> > yes for each in a partial clone.
> > 
> > But that would also cleanly handle --shared, etc, that I mentioned. And
> > more importantly, it would _also_ work on fetches. If I fetch from you
> > and get a promisor pack, then there is no point in me enumerating every
> > tree you sent. As long as you gave me a tip tree, then you have promised
> > that you'd give me all the others if I ask.
> > 
> > So it seems like this should be a feature of the child rev-list, to stop
> > walking the graph at any object that is in a promisor pack.
> 
> We currently already do a less optimal version of this - we pass
> --exclude-promisor-objects to rev-list, which indeed stops traversal at
> any promisor objects (whether in a promisor pack or referenced by one).
> As far as I know, the problem is that to do so, we currently enumerate
> all the objects in all promisor packs, and all objects that those
> objects reference (which means we inflate them too) - so that we have an
> oidset that we can check objects against.
> 
> A partial solution is for is_promisor_object() to first check if the
> given object is in a promisor pack, avoiding generating the set of
> promisor objects until necessary. This would work in a blob:none clone
> with the refs pointing all to commits or all to blobs, but would not
> work in a tree:none clone (or maybe, in this case, the clone would be
> small enough that performance is not a concern, hmm).
> 
> Maybe the ideal solution is for rev-list to check if an object is in a
> promisor pack and if --exclude-promisor-objects is active, we do not
> follow any outgoing links.

I am not sure that this actually saves us any work vs. the original
method of marking promisor objects as uninteresting. Marking the objects
uninteresting involves calling for_each_packed_object(some_callback_fn, ...,
FOR_EACH_OBJECT_PROMISOR_ONLY). But this is also exactly the setup that
is_promisor_object() runs the first time it's called. In fact, it looks
to me like the callback function used by the latter is more expensive
than the former. Is there some alternative to is_promisor_object() that
doesn't involve this object enumeration?

I've tried implementing this approach anyway (diff against master is
below), but I can't get a version that passes t0410-partial-clone.sh
(cases 17 and 19). In case 17, the rev-list emits one extra line
corresponding to the blob for baz.t. I'm not sure why the original
implementation thinks that baz.t is a promisor object but my WIP version
doesn't.

I'll keep poking at this tomorrow, I just thought I should comment on
what I've found so far in case anyone can spot where I'm going wrong.



diff --git a/list-objects.c b/list-objects.c
index dc77361e11..1cb85f1662 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -326,6 +326,12 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		const char *path = pending->path;
+		trace_printf("DEBUG: Examining object: %s\n", oid_to_hex(&obj->oid));
+		if (ctx->revs->exclude_promisor_objects &&
+		    is_promisor_object(&obj->oid)) {
+			trace_printf("DEBUG: Skipping object: %s\n", oid_to_hex(&obj->oid));
+			continue;
+		}
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
@@ -356,6 +362,13 @@ static void do_traverse(struct traversal_context *ctx)
 	strbuf_init(&csp, PATH_MAX);
 
 	while ((commit = get_revision(ctx->revs)) != NULL) {
+		trace_printf("DEBUG: Examining commit: %s\n", oid_to_hex(&commit->object.oid));
+		if (ctx->revs->exclude_promisor_objects &&
+		    is_promisor_object(&commit->object.oid)) {
+			trace_printf("DEBUG: Skipping commit: %s\n", oid_to_hex(&commit->object.oid));
+			continue;
+		}
+
 		/*
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
diff --git a/revision.c b/revision.c
index eb8e51bc63..85974e941d 100644
--- a/revision.c
+++ b/revision.c
@@ -3067,17 +3067,6 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
-static int mark_uninteresting(const struct object_id *oid,
-			      struct packed_git *pack,
-			      uint32_t pos,
-			      void *cb)
-{
-	struct rev_info *revs = cb;
-	struct object *o = parse_object(revs->repo, oid);
-	o->flags |= UNINTERESTING | SEEN;
-	return 0;
-}
-
 define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
@@ -3316,11 +3305,6 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
-	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, revs,
-				       FOR_EACH_OBJECT_PROMISOR_ONLY);
-	}
-
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bce02788e6..55ac29f650 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -342,7 +342,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	GIT_TRACE="$(pwd)/rev_trace" git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
 	! grep $COMMIT out &&
 	! grep $TREE out &&
 	! grep $BLOB out &&
