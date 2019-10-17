Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E37D1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436940AbfJQURX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:23 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38597 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:22 -0400
Received: by mail-qk1-f202.google.com with SMTP id s28so3382331qkm.5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RTLri+/gferKGmOZgOn1IFHFN7fpRRZd3sMHR0XAEMs=;
        b=ZIjaeXPf89ABvFjIz1J6OuRPjHayjlsi+lttJYxQV5gKX8pPm99h4niOa2HFa6xnb2
         OBGL1loIHWS8gixtDYiPNpgZN/jQsk4MWLuq+hpM45NxzKZKFHTorhVfyQcxTf5D9A8K
         LP5Jf7MHrVL2cwUoEHnlYb609P8+Llx6ke7Huh1RnFNXjaT/oDW/VFnZ++T35lF3Lr0u
         v190OK4tM3V9yUd+VdV6oTJQwy/5QHzfhIv9JTkheSKU1hiaJwoYT9VhTgTV0q3sskk7
         8311i1KtbIHIlbqoAdA3QIM+uOfuzJUA9ygI/GL4eYuZxB/fqLgTpQhwLQpodNm3j7gm
         XPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RTLri+/gferKGmOZgOn1IFHFN7fpRRZd3sMHR0XAEMs=;
        b=Nw5degsYlVL0vNXnNfQEh6608spP7HpKt+JEnDs21YLCBKg9khr4wWSIMfsDiKCrMk
         hIQj44Q/2cK9txMG7GawKhACeSjssKDK2rrOifnjnJUtmHbpKx2kFVIoKYLLu1EvLKTE
         ESKVHNm7zSoRMP/vSpu22m23LfTtUh4NeR9gO9GFtgnUpvNXiZowFQcxm/GK2QWU/Dfy
         585C7xzuF0oJyyua62wFIXOz7AKpr8GaW1NgTXjmQeMBx1DC+oB6oh/n34C5XBZ6wjcw
         yVp2s09QG7IgesQ2wGC3FaI03EEr+QlM56j/0PIVy0dAyhnsXUvNTeS2/bMg99DYon+T
         WDHg==
X-Gm-Message-State: APjAAAWJRz37e1p08XcaSxkdu4aS3mckNHF0oJcdMKBt+n6xPBoNu5PL
        avaMfHTZaIfPCmKoAYwm7rfX5X5NshHnf4MFihis8aV3s0VAv1UzWiGopU5MR2XfZ5b/+8ljc3u
        DNrQyqoFeYcL3km4Y+QfTCV9Lcg+xPp2xJYlLK5lRIyb3Mfc7CPdKmq34Z4IXLf4Wp8Xmp7UhNj
        by
X-Google-Smtp-Source: APXvYqxfsbidObDOqZpriBeeCXVM4qV5xLsktQudUcZ0+HkDX6hxFJpxopaUzTwOhtG3MYRQiPfcxNEWEOz+UI8wYoJo
X-Received: by 2002:a0c:ee49:: with SMTP id m9mr5966989qvs.118.1571343441332;
 Thu, 17 Oct 2019 13:17:21 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:09 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <cover.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 0/7] Better threaded delta resolution in index-pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Stolee and Peff, for taking a look at it. Here is a v2. It is
mostly unchanged, except for expanded commit messages and code comments.

I've also added a documentation clarification that
core.deltaBaseCacheLimit is per-thread, appearing as the first patch in
this patch series.

From patch 3 (now patch 4):

> > +	int i;
> 
> Technically this probably ought to be a size_t as well, but I'm much
> more concerned about the allocation ones, where we might accidentally
> overflow and underallocate a buffer. Overflowing "i" would probably just
> lead to an error or bad result.

I believe this needs to be signed, since we're iterating in reverse
order, so I made it a ssize_t instead (note the extra "s" in front).

From patch 4 (now patch 5):

> > Whenever we make a struct base_data, immediately calculate its delta
> > children. This eliminates confusion as to when the
> > {ref,ofs}_{first,last} fields are initialized.
> 
> That _seems_ like a good idea, but I'm a little worried just because I
> don't entirely understand why it was being done lazily before. If you've
> puzzled all that out, it would be nice to make the argument in the
> commit message.

I've added an explanation in the commit message.

Jonathan Tan (7):
  Documentation: deltaBaseCacheLimit is per-thread
  index-pack: unify threaded and unthreaded code
  index-pack: remove redundant parameter
  index-pack: remove redundant child field
  index-pack: calculate {ref,ofs}_{first,last} early
  index-pack: make resolve_delta() assume base data
  index-pack: make quantum of work smaller

 Documentation/config/core.txt |   2 +-
 builtin/index-pack.c          | 446 ++++++++++++++++++----------------
 2 files changed, 242 insertions(+), 206 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  0a6777a243 Documentation: deltaBaseCacheLimit is per-thread
1:  7562afbaa9 = 2:  b19d6131e0 index-pack: unify threaded and unthreaded code
2:  a8567333dc ! 3:  f01f069a08 index-pack: remove redundant parameter
    @@ Metadata
      ## Commit message ##
         index-pack: remove redundant parameter
     
    +    find_{ref,ofs}_delta_{,children} take an enum object_type parameter, but
    +    the object type is already present in the name of the function. Remove
    +    that parameter from these functions.
    +
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## builtin/index-pack.c ##
3:  97eddde2ec ! 4:  3359b66b84 index-pack: remove redundant child field
    @@ Metadata
      ## Commit message ##
         index-pack: remove redundant child field
     
    -    Instead, recompute ancestry if we ever need to reclaim memory.
    +    This is refactoring 1 of 2 to simplify struct base_data.
    +
    +    In index-pack, each thread maintains a doubly-linked list of the delta
    +    chain that it is currently processing (the "base" and "child" pointers
    +    in struct base_data). When a thread exceeds the delta base cache limit
    +    and needs to reclaim memory, it uses the "child" pointers to traverse
    +    the lineage, reclaiming the memory of the eldest delta bases first.
    +
    +    A subsequent patch will perform memory reclaiming in a different way and
    +    will thus no longer need the "child" pointer. Because the "child"
    +    pointer is redundant even now, remove it so that the aforementioned
    +    subsequent patch will be clearer. In the meantime, reclaim memory in the
    +    reverse order of the "base" pointers.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    @@ builtin/index-pack.c: static void free_base_data(struct base_data *c)
     -		if (b->data && b != retain)
     -			free_base_data(b);
     +	struct base_data **ancestry = NULL;
    -+	int nr = 0, alloc = 0;
    -+	int i;
    ++	size_t nr = 0, alloc = 0;
    ++	ssize_t i;
     +
     +	if (data->base_cache_used <= delta_base_cache_limit)
     +		return;
    @@ builtin/index-pack.c: static void free_base_data(struct base_data *c)
     +	for (b = youngest_child->base; b != NULL; b = b->base) {
     +		ALLOC_GROW(ancestry, nr + 1, alloc);
     +		ancestry[nr++] = b;
    -+	}
    + 	}
     +	for (i = nr - 1;
     +	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
     +	     i--) {
     +		if (ancestry[i]->data)
     +			free_base_data(ancestry[i]);
    - 	}
    ++	}
     +	free(ancestry);
      }
      
4:  5d9687145d ! 5:  7f18480c45 index-pack: calculate {ref,ofs}_{first,last} early
    @@ Metadata
      ## Commit message ##
         index-pack: calculate {ref,ofs}_{first,last} early
     
    +    This is refactoring 2 of 2 to simplify struct base_data.
    +
         Whenever we make a struct base_data, immediately calculate its delta
         children. This eliminates confusion as to when the
         {ref,ofs}_{first,last} fields are initialized.
     
    +    Before this patch, the delta children were calculated at the last
    +    possible moment. This allowed the members of struct base_data to be
    +    populated in any order, superficially useful when we have the object
    +    contents before the struct object_entry. But this makes reasoning about
    +    the state of struct base_data more complicated, hence this patch.
    +
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## builtin/index-pack.c ##
5:  ca4997017d = 6:  910b15219f index-pack: make resolve_delta() assume base data
6:  4f7c252a7c ! 7:  2f2e36d3ef index-pack: make quantum of work smaller
    @@ Metadata
      ## Commit message ##
         index-pack: make quantum of work smaller
     
    +    Currently, when index-pack resolves deltas, it does not split up delta
    +    trees into threads: each delta base root (an object that is not a
    +    REF_DELTA or OFS_DELTA) can go into its own thread, but all deltas on
    +    that root (direct or indirect) are processed in the same thread.
    +
    +    This is a problem when a repository contains a large text file (thus,
    +    delta-able) that is modified many times - delta resolution time during
    +    fetching is dominated by processing the deltas corresponding to that
    +    text file.
    +
    +    This patch contains a solution to that. When cloning using
    +
    +      git -c core.deltabasecachelimit=1g clone \
    +        https://fuchsia.googlesource.com/third_party/vulkan-cts
    +
    +    on my laptop, clone time improved from 3m2s to 2m5s (using 3 threads,
    +    which is the default).
    +
    +    The solution is to have a global work stack. This stack contains delta
    +    bases (objects, whether appearing directly in the packfile or generated
    +    by delta resolution, that themselves have delta children) that need to
    +    be processed; whenever a thread needs work, it peeks at the top of the
    +    stack and processes its next unprocessed child. If a thread finds the
    +    stack empty, it will look for more delta base roots to push on the stack
    +    instead.
    +
    +    The main weakness of having a global work stack is that more time is
    +    spent in the mutex, but profiling has shown that most time is spent in
    +    the resolution of the deltas themselves, so this shouldn't be an issue
    +    in practice. In any case, experimentation (as described in the clone
    +    command above) shows that this patch is a net improvement.
    +
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## builtin/index-pack.c ##
    @@ builtin/index-pack.c: struct base_data {
      	struct object_entry *obj;
      	int ref_first, ref_last;
      	int ofs_first, ofs_last;
    ++	/*
    ++	 * Threads should increment retain_data if they are about to call
    ++	 * patch_delta() using this struct's data as a base, and decrement this
    ++	 * when they are done. While retain_data is nonzero, this struct's data
    ++	 * will not be freed even if the delta base cache limit is exceeded.
    ++	 */
     +	int retain_data;
    ++	/*
    ++	 * The number of direct children that have not been fully processed
    ++	 * (entered work_head, entered done_head, left done_head). When this
    ++	 * number reaches zero, this struct base_data can be freed.
    ++	 */
     +	int children_remaining;
      
      	/* Not initialized by make_base(). */
    @@ builtin/index-pack.c: struct base_data {
      	unsigned long size;
      };
      
    ++/*
    ++ * Stack of struct base_data that have unprocessed children.
    ++ * threaded_second_pass() uses this as a source of work (the other being the
    ++ * objects array).
    ++ */
     +LIST_HEAD(work_head);
    ++
    ++/*
    ++ * Stack of struct base_data that have children, all of whom have been
    ++ * processed or are being processed, and at least one child is being processed.
    ++ * These struct base_data must be kept around until the last child is
    ++ * processed.
    ++ */
     +LIST_HEAD(done_head);
    ++
    ++/*
    ++ * All threads share one delta base cache.
    ++ */
     +size_t base_cache_used;
     +size_t base_cache_limit;
     +
    @@ builtin/index-pack.c: static void free_base_data(struct base_data *c)
     -	struct base_data *b;
     -	struct thread_local *data = get_thread_data();
     -	struct base_data **ancestry = NULL;
    --	int nr = 0, alloc = 0;
    --	int i;
    +-	size_t nr = 0, alloc = 0;
    +-	ssize_t i;
     +	struct list_head *pos;
      
     -	if (data->base_cache_used <= delta_base_cache_limit)
    @@ builtin/index-pack.c: static void free_base_data(struct base_data *c)
      }
      
      static int is_delta_type(enum object_type type)
    +@@ builtin/index-pack.c: static void sha1_object(const void *data, struct object_entry *obj_entry,
    + }
    + 
    + /*
    +- * This function is part of find_unresolved_deltas(). There are two
    +- * walkers going in the opposite ways.
    +- *
    +- * The first one in find_unresolved_deltas() traverses down from
    +- * parent node to children, deflating nodes along the way. However,
    +- * memory for deflated nodes is limited by delta_base_cache_limit, so
    +- * at some point parent node's deflated content may be freed.
    +- *
    +- * The second walker is this function, which goes from current node up
    ++ * Walk from current node up
    +  * to top parent if necessary to deflate the node. In normal
    +  * situation, its parent node would be already deflated, so it just
    +  * needs to apply delta.
     @@ builtin/index-pack.c: static void *get_base_data(struct base_data *c)
      		if (!delta_nr) {
      			c->data = get_data_from_pack(obj);
    @@ builtin/index-pack.c: static int compare_ref_delta_entry(const void *a, const vo
      }
      
     -static void resolve_base(struct object_entry *obj)
    -+static void *do_work(void *data)
    - {
    +-{
     -	struct base_data *base_obj = make_base(obj, NULL);
     -
     -	find_unresolved_deltas(base_obj);
     -}
     -
    --static void *threaded_second_pass(void *data)
    --{
    + static void *threaded_second_pass(void *data)
    + {
     -	set_thread_data(data);
     +	if (data)
     +		set_thread_data(data);
    @@ builtin/index-pack.c: static int compare_ref_delta_entry(const void *a, const vo
     -			work_unlock();
     -			break;
     +		if (list_empty(&work_head)) {
    ++			/*
    ++			 * Take an object from the object array.
    ++			 */
     +			while (nr_dispatched < nr_objects &&
     +			       is_delta_type(objects[nr_dispatched].type))
     +				nr_dispatched++;
    @@ builtin/index-pack.c: static int compare_ref_delta_entry(const void *a, const vo
     +			}
     +			child_obj = &objects[nr_dispatched++];
     +		} else {
    ++			/*
    ++			 * Peek at the top of the stack, and take a child from
    ++			 * it.
    ++			 */
     +			parent = list_first_entry(&work_head, struct base_data,
     +						  list);
     +
    @@ builtin/index-pack.c: static int compare_ref_delta_entry(const void *a, const vo
     +
     +			if (parent->ref_first > parent->ref_last &&
     +			    parent->ofs_first > parent->ofs_last) {
    ++				/*
    ++				 * This parent has run out of children, so move
    ++				 * it to done_head.
    ++				 */
     +				list_del(&parent->list);
     +				list_add(&parent->list, &done_head);
     +			}
     +
    ++			/*
    ++			 * Ensure that the parent has data, since we will need
    ++			 * it later.
    ++			 *
    ++			 * NEEDSWORK: If parent data needs to be reloaded, this
    ++			 * prolongs the time that the current thread spends in
    ++			 * the mutex. A mitigating factor is that parent data
    ++			 * needs to be reloaded only if the delta base cache
    ++			 * limit is exceeded, so in the typical case, this does
    ++			 * not happen.
    ++			 */
     +			get_base_data(parent);
     +			parent->retain_data++;
      		}
    @@ builtin/index-pack.c: static int compare_ref_delta_entry(const void *a, const vo
     +		if (parent)
     +			parent->retain_data--;
     +		if (child->data) {
    ++			/*
    ++			 * This child has its own children, so add it to
    ++			 * work_head.
    ++			 */
     +			list_add(&child->list, &work_head);
     +			base_cache_used += child->size;
     +			prune_base_data(NULL);
     +		} else {
    ++			/*
    ++			 * This child does not have its own children. It may be
    ++			 * the last descendant of its ancestors; free those
    ++			 * that we can.
    ++			 */
     +			struct base_data *p = parent;
     +
     +			while (p) {
    @@ builtin/index-pack.c: static void resolve_deltas(void)
      	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
      		init_thread();
      		for (i = 0; i < nr_threads; i++) {
    - 			int ret = pthread_create(&thread_data[i].thread, NULL,
    --						 threaded_second_pass, thread_data + i);
    -+						 do_work, thread_data + i);
    - 			if (ret)
    - 				die(_("unable to create thread: %s"),
    - 				    strerror(ret));
    -@@ builtin/index-pack.c: static void resolve_deltas(void)
    - 		cleanup_thread();
    - 		return;
    - 	}
    --	threaded_second_pass(&nothread_data);
    -+	do_work(&nothread_data);
    - }
    - 
    - /*
     @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
      	for (i = 0; i < nr_ref_deltas; i++) {
      		struct ref_delta_entry *d = sorted_by_pos[i];
    @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
     -		base->data = data;
     -		base->size = size;
     -		find_unresolved_deltas(base);
    ++
    ++		/*
    ++		 * Add this as an object to the objects array and call
    ++		 * threaded_second_pass() (which will pick up the added
    ++		 * object).
    ++		 */
     +		append_obj_to_pack(f, d->oid.hash, data, size, type);
    -+		do_work(NULL); /* will pick up new object in objects array (added by append_obj_to_pack) */
    ++		threaded_second_pass(NULL);
    ++
      		display_progress(progress, nr_resolved_deltas);
      	}
      	free(sorted_by_pos);
-- 
2.23.0.866.gb869b98d4c-goog

