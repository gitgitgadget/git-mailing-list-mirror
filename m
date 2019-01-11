Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E982211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 23:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfAKXUL (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 18:20:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44954 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfAKXUK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 18:20:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so16856129wrt.11
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 15:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sybtWGDA5HcaSYbZtBcaNKjwKT+qqTmsZf7NFe9so0M=;
        b=u8FJJiNBgkINF8CZP1R7slRf05zGWJFoaZ9UGtaE1WmY3+2BRXMsSMelrX4Q9Y3ocH
         pJ33jINDt0Onc90DLHvDxM//f0f4rQRsjXP5NcUXKnUkYspiFLJpCVcU690IsfqAcvvd
         vfdFMaLdqm4+tbkAhaw69bHxEJ+uw/jY5GsSr6lwzQyDVGvG60IHLD7SiB6Um1LCCxZu
         ZdUzOU9YLQsJJDGVYfNCdqbGvBoleaWuaosU8Gf+PRvvi9AT7VxYhmvjKXr57vfKSZDo
         19ICeD8wbeP2FsPBu9l/UBKBNFWGwrse6E/840lkIMgZOCMu5l995L70Kzs0mVrYguwy
         CmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sybtWGDA5HcaSYbZtBcaNKjwKT+qqTmsZf7NFe9so0M=;
        b=bIizqc+qpqN6SlAGOdJAz5Z/hB4fSfutAPkJqvpPlOLjlUZGg8RpQdAUtwG4GCvx0c
         yuEa0t8lEuKcfLwuDdAlwT9ajapQDu17+Q6lymOs+MH1q2MC1yN3ZiseBoB1mITAD//7
         KPBPh3bF4N7YpPxNXVptmZQACL1Z7x75fj+z75G6L0fQnvcsUYcNZXLLoCaIS2/Cy2PQ
         NDsctFFBCbBv+kHcHAlvGWc9wwoKX/Qqude7Njn3r31DD3I9q92jUObnaMJ6sJ364Skr
         AB6SexlF1ON63FKB66myG9Zua4hoElIBHbtAmoVFQLao6xBe0pBZdaTH+jfn4tk2JOR3
         XFpQ==
X-Gm-Message-State: AJcUukf1sACpQgSJPvXLB0nbczkivDAjUcYhbPeJiu0FHosfLaesWGcX
        DwnSgepKb6+INBgK/9EHH8Xd/pa2
X-Google-Smtp-Source: ALg8bN5hjGAfolGRLD5+N32APxWPehhqY1+LtvcvyixTeQ20zoWbFm+B8/QV3kd7DzG9HbNQtb5Ksw==
X-Received: by 2002:a5d:4a8e:: with SMTP id o14mr14617171wrq.159.1547248807901;
        Fri, 11 Jan 2019 15:20:07 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i192sm19961139wmg.7.2019.01.11.15.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 15:20:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/6] revision: implement sparse algorithm
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
        <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Jan 2019 15:20:06 -0800
In-Reply-To: <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 14 Dec 2018
        13:22:21 -0800 (PST)")
Message-ID: <xmqqh8eeye6x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When enumerating objects to place in a pack-file during 'git
> pack-objects --revs', we discover the "frontier" of commits
> that we care about and the boundary with commit we find
> uninteresting. From that point, we walk trees to discover which
> trees and blobs are uninteresting. Finally, we walk trees from the
> interesting commits to find the interesting objects that are
> placed in the pack.
>
> This commit introduces a new, "sparse" way to discover the
> uninteresting trees. We use the perspective of a single user trying
> to push their topic to a large repository. That user likely changed
> a very small fraction of the paths in their working directory, but
> we spend a lot of time walking all reachable trees.
>
> The way to switch the logic to work in this sparse way is to start
> caring about which paths introduce new trees. While it is not
> possible to generate a diff between the frontier boundary and all
> of the interesting commits, we can simulate that behavior by
> inspecting all of the root trees as a whole, then recursing down
> to the set of trees at each path.
>
> We already had taken the first step by passing an oidset to
> mark_trees_uninteresting_sparse(). We now create a dictionary
> whose keys are paths and values are oidsets. We consider the set
> of trees that appear at each path. While we inspect a tree, we
> add its subtrees to the oidsets corresponding to the tree entry's
> path. We also mark trees as UNINTERESTING if the tree we are
> parsing is UNINTERESTING.
>
> To actually improve the peformance, we need to terminate our

performance?

> recursion. If the oidset contains only UNINTERESTING trees, then

So, at this point, it is not quite clear what "the oidset" refers to
to me.  When you are looking at the root tree of one commit, you'd
add the object ID of the tree to the dictionary keyed by the path
(i.e. root of the tree).  You traverse to the parent and keep adding
these root trees, and after a while you'd hit a negative commit and
add its tree with UNINTERESTING bit.  Before that point, the oidset
for the root of the tree has only interesting trees, so you won't
recurse into its contents, but now at the final point you'd walk to
propagate UNINTERESTING bit down?

> we do not continue the recursion. This avoids walking trees that
> are likely to not be reachable from interesting trees. If the
> oidset contains only interesting trees, then we will walk these
> trees in the final stage that collects the intersting objects to
> place in the pack. Thus, we only recurse if the oidset contains
> both interesting and UNINITERESTING trees.
>
> There are a few ways that this is not a universally better option.
>
> First, we can pack extra objects. If someone copies a subtree
> from one tree to another, the first tree will appear UNINTERESTING
> and we will not recurse to see that the subtree should also be
> UNINTERESTING. We will walk the new tree and see the subtree as
> a "new" object and add it to the pack. We add a test case that
> demonstrates this as a way to prove that the --sparse option is
> actually working.

That's an interesting use of the word "working" ;-)

> Second, we can have extra memory pressure. If instead of being a
> single user pushing a small topic we are a server sending new
> objects from across the entire working directory, then we will
> gain very little (the recursion will rarely terminate early) but
> will spend extra time maintaining the path-oidset dictionaries.
> ...
> I used the number of walked trees the main metric above because
> it is consistent across multiple runs. When I ran my tests, the
> performance of the pack-objects command with the same options
> could change the end-to-end time by 10x depending on the file
> system being warm. However, by repeating the same test on repeat
> I could get more consistent timing results. The git.git and
> Linux tests were too fast overall (less than 0.5s) to measure
> an end-to-end difference. The Azure DevOps case was slow enough
> to see the time improve from 15s to 1s in the warm case. The
> cold case was 90s to 9s in my testing.

Understandable.  Projects that tend to be deep (e.g. Java?) would
likely to benefit if they are structured and partitioned very well.

> +struct path_and_oids_entry {
> +	struct hashmap_entry ent;
> +	char *path;
> +	struct oidset set;

Again "set"?  If I understand the description of the logic explained
in the proposed commit log message correctly, then this is a set of
"tree objects at this path", right?  At least calling this "trees"
may give us slightly better indication.

> +static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
> +			     const struct path_and_oids_entry *e1,
> +			     const struct path_and_oids_entry *e2,
> +			     const void *keydata)
> +{
> +	return strcmp(e1->path, e2->path);
> +}
> +
> +int map_flags = 0;

That's too bland a name for a system-wide global variable.  If it is
a file-scope "static", that might be more acceptable.

In any case, let BSS take care of the initialization and do not
initialize an int explicitly to 0.

Is it even used?  At least at this step the comparison callback
function does not seem to make any use of the fn-data, so a better
organization may be to delay the introduction of this variable to a
later step where it actually gets used, at which time, the code may
have a better context to give the variable a more suitable name.

> +static void paths_and_oids_init(struct hashmap *map)
> +{
> +	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, &map_flags, 0);
> +}
> +
> +static void paths_and_oids_clear(struct hashmap *map)
> +{
> +	struct hashmap_iter iter;
> +	struct path_and_oids_entry *entry;
> +	hashmap_iter_init(map, &iter);
> +
> +	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
> +		oidset_clear(&entry->set);
> +		free(entry->path);
> +	}
> +
> +	hashmap_free(map, 1);
> +}
> +
> +static void paths_and_oids_insert(struct hashmap *map,
> +				  const char *path,
> +				  const struct object_id *oid)
> +{
> +	int hash = strhash(path);
> +	struct path_and_oids_entry key;
> +	struct path_and_oids_entry *entry;
> +
> +	hashmap_entry_init(&key, hash);
> +	key.path = xstrdup(path);
> +	oidset_init(&key.set, 0);
> +
> +	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
> +		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
> +		hashmap_entry_init(entry, hash);
> +		entry->path = key.path;
> +		oidset_init(&entry->set, 16);
> +		hashmap_put(map, entry);
> +	} else {
> +		free(key.path);
> +	}

Hmph, having to always allocate only to free sounds wasteful.  

Can't we instead do the look-up with "path" that are given read-only
to us, and allocate only when we are creating the entry in the
dictionary for the first time?  After all, we'd make many look-ups
of the same path to add trees for the same path and only one of them
(i.e. the first one) is used to create an entry in the dictionary.

Or does it not matter?

> +
> +	oidset_insert(&entry->set, oid);
> +}
> +
> +static void add_children_by_path(struct repository *r,
> +				 struct tree *tree,
> +				 struct hashmap *map)
> +{
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +
> +	if (!tree)
> +		return;
> +
> +	if (parse_tree_gently(tree, 1) < 0)
> +		return;
> +
> +	init_tree_desc(&desc, tree->buffer, tree->size);
> +	while (tree_entry(&desc, &entry)) {
> +		switch (object_type(entry.mode)) {
> +		case OBJ_TREE:
> +			paths_and_oids_insert(map, entry.path, entry.oid);
> +
> +			if (tree->object.flags & UNINTERESTING) {
> +				struct tree *child = lookup_tree(r, entry.oid);
> +				if (child)
> +					child->object.flags |= UNINTERESTING;
> +			}
> +			break;
> +		case OBJ_BLOB:
> +			if (tree->object.flags & UNINTERESTING) {
> +				struct blob *child = lookup_blob(r, entry.oid);
> +				if (child)
> +					child->object.flags |= UNINTERESTING;
> +			}
> +			break;
> +		default:
> +			/* Subproject commit - not in this repository */
> +			break;
> +		}
> +	}
> +
> +	free_tree_buffer(tree);
> +}

OK.

>  void mark_trees_uninteresting_sparse(struct repository *r,
>  				     struct oidset *set)
>  {
> +	unsigned has_interesting = 0, has_uninteresting = 0;
> +	struct hashmap map;
> +	struct hashmap_iter map_iter;
> +	struct path_and_oids_entry *entry;
>  	struct object_id *oid;
>  	struct oidset_iter iter;
>  
>  	oidset_iter_init(set, &iter);
> -	while ((oid = oidset_iter_next(&iter))) {
> +	while ((!has_interesting || !has_uninteresting) &&
> +	       (oid = oidset_iter_next(&iter))) {
>  		struct tree *tree = lookup_tree(r, oid);
>  
>  		if (!tree)
>  			continue;
>  
> +		if (tree->object.flags & UNINTERESTING)
> +			has_uninteresting = 1;
> +		else
> +			has_interesting = 1;
> +	}
> +
> +	/* Do not walk unless we have both types of trees. */
> +	if (!has_uninteresting || !has_interesting)
> +		return;

OK.

> +	paths_and_oids_init(&map);
> +
> +	oidset_iter_init(set, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct tree *tree = lookup_tree(r, oid);
> +		add_children_by_path(r, tree, &map);
>  	}
> +
> +	hashmap_iter_init(&map, &map_iter);
> +	while ((entry = hashmap_iter_next(&map_iter)))
> +		mark_trees_uninteresting_sparse(r, &entry->set);
> +
> +	paths_and_oids_clear(&map);
>  }
>  
>  struct commit_stack {
> diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
> index 81f6805bc3..45dba6e014 100755
> --- a/t/t5322-pack-objects-sparse.sh
> +++ b/t/t5322-pack-objects-sparse.sh
> @@ -83,22 +83,25 @@ test_expect_success 'sparse pack-objects' '
>  	test_cmp expect_objects.txt sparse_objects.txt
>  '
>  
> +# Demonstrate that the algorithms differ when we copy a tree wholesale
> +# from one folder to another.
> +
>  test_expect_success 'duplicate a folder from f1 into f3' '
>  	mkdir f3/f4 &&
>  	cp -r f1/f1/* f3/f4 &&
>  	git add f3/f4 &&
>  	git commit -m "Copied f1/f1 to f3/f4" &&
> -	cat >packinput.txt <<-EOF &&
> +	cat >packinput.txt <<-EOF
>  	topic1
>  	^topic1~1
>  	EOF
> -	git rev-parse		\
> -		topic1		\
> -		topic1^{tree}	\
> -		topic1:f3 | sort >expect_objects.txt
>  '
>  
>  test_expect_success 'non-sparse pack-objects' '
> +	git rev-parse			\
> +		topic1			\
> +		topic1^{tree}		\
> +		topic1:f3 | sort >expect_objects.txt &&

OK, the change above sort of makes sense ;-)

>  	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
>  	git index-pack -o nonsparse.idx nonsparse.pack &&
>  	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
> @@ -106,10 +109,16 @@ test_expect_success 'non-sparse pack-objects' '
>  '
>  
>  test_expect_success 'sparse pack-objects' '
> +	git rev-parse			\
> +		topic1			\
> +		topic1^{tree}		\
> +		topic1:f3		\
> +		topic1:f3/f4		\
> +		topic1:f3/f4/data.txt | sort >expect_sparse_objects.txt &&

And the reason why f4 and its contents are wastefully sent is
because the whole tree is duplicated, which is understandable.

>  	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
>  	git index-pack -o sparse.idx sparse.pack &&
>  	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
> -	test_cmp expect_objects.txt sparse_objects.txt
> +	test_cmp expect_sparse_objects.txt sparse_objects.txt
>  '
>  
>  test_done
