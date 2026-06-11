Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8E377EAC
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166167; cv=none; b=khtlyd2mMXFplaI9R+S+qiweO67aobuLMCUNjMxkeAjOZ7AbjPKbBmFvamdDyvWvajdO1RztrhQFysMzP+dL4l9mcLFd6jdy2EhrNqIBkXIrL9tM4HlscDBAJp9kky2B0CaNptR2QUUY8YRypH59WuydaJXMFzOYJn22QJ/u1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166167; c=relaxed/simple;
	bh=KHzHKomtSb1Jya4i2VZh+EKXoZQ3V3hfh98eDig96vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz2HYSWrjoPW9hDgaJVlbxGUuTAbVaVGZ3GXHMsgNKuUsUy16duUqxzqujKKSus6FjwNltK02rfzZIl6e26wyOuXzpBO+4auwexx/Y629q42jXGCiUScJi4Oc321KdQRUqpXgTMK+p5IWxOFUWZVrkwlDMy59HaNLFGYdCKzyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Np0BDHNv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Np0BDHNv"
Received: (qmail 106851 invoked by uid 106); 11 Jun 2026 08:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KHzHKomtSb1Jya4i2VZh+EKXoZQ3V3hfh98eDig96vI=; b=Np0BDHNvOe4kW/LtCRFKzMHhwFnQTQ99gVezSC6Cle8lFeLWOY0qF5fnsSbRjn7wGks3XNAKwkfLD1XIkhWVHvqUO1r4rCWRWlUKtXWEEmxH9K8X1xldlQlsWXnNkjTB5Z9F9XUQRwo0zihc85GATru2t8hiygtml6+1vAdNFuKqF8VUO+7611naUt39BqOt6OGZVffBocabYr7Jo6ARedNHWZ7XCj+xh8FsDreTHihEyXiZxgSazeNXa02IUcCZgtPNxAgE1hB7oIFGAvB62wt9yTl/Cd63fj+2/RmrPVyGMn1qY2pDgfXpJjsLwTFyxf3dfxF5/4N54R+hnn6cRA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 08:22:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 315013 invoked by uid 111); 11 Jun 2026 08:22:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 04:22:49 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 04:22:44 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: memoize --contains with generations
Message-ID: <20260611082244.GH2191159@coredump.intra.peff.net>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>

On Mon, Jun 08, 2026 at 07:36:35PM -0700, Tamir Duberstein wrote:

> The wall-time standard deviations were 11.356 seconds and 133.8
> milliseconds, respectively. Separate runs without redirection produced
> the same output with SHA-256
> 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.

Heh. Without the original repo, this sha256 hash is meaningless to us,
isn't it? Ditto for the sha1 the earlier command.

>  int commit_contains(struct ref_filter *filter, struct commit *commit,
>  		    struct commit_list *list, struct contains_cache *cache)
>  {
> -	if (filter->with_commit_tag_algo)
> +	int result;
> +
> +	if (!list)
> +		return 1;
> +	if (filter->with_commit_tag_algo ||
> +	    generation_numbers_enabled(the_repository))
>  		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
> -	return repo_is_descendant_of(the_repository, commit, list);
> +
> +	result = repo_is_descendant_of(the_repository, commit, list);
> +	if (result < 0)
> +		exit(128);
> +	return result;

There's a little more going on here than I expected from the commit
message. Is it important for us to short-circuit the empty list and just
return 1? Or did the existing helper functions already handle that?

Looking at contains_tag_algo(), I think it would actually return
CONTAINS_NO here (though I didn't test it). So this is actually a change
in behavior for "git tag" if that's correct. I doubt it is triggerable
in practice, though, as we would simply never call commit_contains() in
the first place with an empty list. But if we are going to add in this
logic, I think it makes sense to do so as a separate commit (describing
what it is doing and why it's not (yet) a triggerable bug).

Checking the result of repo_is_descendant_of() makes sense, as discussed
earlier. But probably that should come as its own patch, since it's an
independent bug-fix. I'm also tempted to say it should call die()
instead of a direct exit, though it does look like the error exit paths
from repo_is_descendant_of() would all have produced their own messages.


And one side note. While looking at the implementation of
repo_is_descendant_of(), I did notice something curious: it also
switches algorithms based on the presence of generation numbers! So it
should also be cutting off the traversal early when possible. But I
guess its main problem is that we call it independently for each
candidate, so it may traverse the same (useful) stretch of history
multiple times.

So probably an alternative approach to this patch would be feeding all
of the candidates at once, the way we do with reach_filter() via
filter_refs(). I'm not sure if we have the right functions available for
that (naively, --contains and --merged are inversions of each other, so
swapping the arguments to tips_reachable_from_bases() might work, but I
didn't think very hard on it).

I wonder if that might perform better or worse. I'm content to leave it
for another day, though, as switching to the memoizing depth-first algo
here is a pretty easy change.

> -	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
> +	git rev-list --first-parent --max-count=8192 HEAD >contains-commits &&
> +	test_file_not_empty contains-commits &&
> +	git update-ref refs/contains-perf-base "$(tail -n 1 contains-commits)" &&
> +	awk "{
> +		printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
> +	}" contains-commits |
> +		git update-ref --stdin &&
> +	git pack-refs --include "refs/contains-perf/*" &&

My head almost exploded reading the embedded quoting in that awk
invocation. But I can't think offhand of a better way to do it. You
can't use test_seq because it needs both the number and the original
string. You can do it with sed, but it probably ends up even more
unreadable.

But OK, we are making a bunch of refs based on first-parent history.

> +	tree=$(git rev-parse HEAD^{tree}) &&
> +	base=$(git rev-parse HEAD) &&
> +	target=$(echo target | git commit-tree "$tree" -p "$base") &&
> +	git update-ref refs/contains-diverged/target "$target" &&
> +	for i in $(test_seq 1 4)
> +	do
> +		commit=$(echo candidate-$i |
> +			git commit-tree "$tree" -p "$base") &&
> +		git update-ref refs/contains-diverged/candidate-$i "$commit" ||
> +		return 1
> +	done &&

And then a few candidate refs that are not reachable from other refs, or
from each other. OK.

I think you could just write:

  git commit-tree HEAD^{tree} -p HEAD

instead of doing separate rev-parses, but it's probably not a big deal
either way.

> +test_expect_success 'verify contains results' '
> +	git for-each-ref --contains=refs/contains-perf-base \
> +		refs/contains-perf/ >actual &&
> +	test_line_count = $(wc -l <contains-commits) actual &&
> +
> +	echo refs/contains-diverged/target >expect &&
> +	GIT_TEST_COMMIT_GRAPH=0 \
> +		git -c core.commitGraph=false for-each-ref \
> +			--format="%(refname)" \
> +			--contains=refs/contains-diverged/target \
> +			refs/contains-diverged/ >actual &&
> +	test_cmp expect actual
> +'

This is a funny test to have in the middle of a perf script (which
hardly anybody ever runs). If we are concerned about the correctness,
should this be in a non-perf test script? Though I'd imagine something
like it is already covered there.

There's a lot of subtlety in what we're verifying, too. In the first
half, we are checking that all of the commits in contains-perf contain
the base.  And that base is the final element of the contains-commits
list. Which made me wonder what happens in a branch history, since that
list is linearized. But because we used --first-parent to generate it,
it _is_ linear, and the results work out. So OK, I don't think it's
wrong, but I am struggling to understand the meaning of the test.

The second half is just checking that...the other refs which are not
contained in "target" are not mentioned? OK, but why do it only with
commit graphs off. Why not both off and on? Again, I'm not sure I
understand what we're trying to focus on here.

> +test_perf 'contains: git for-each-ref --contains' '
> +	git for-each-ref --contains=refs/contains-perf-base \
> +		refs/contains-perf/ >/dev/null
> +'

Yay, actual perf tests. Here we have a ton of matches, and they all walk
over the same chunk of history. Should get much faster, though it's
mostly a synthetic test.

For --merged, we already have separate tests with each of for-each-ref,
branch, and tag. Should we have the same here for --contains? And should
we be using the input repo data, rather than our synthetic test? It is
nice to show off the performance with the synthetic test, but ultimately
the point of the perf suite is feeding it real workloads and looking for
regressions.

> +test_perf 'contains without generations: divergent refs' '
> +	GIT_TEST_COMMIT_GRAPH=0 \
> +		git -c core.commitGraph=false for-each-ref \
> +			--contains=refs/contains-diverged/target \
> +			refs/contains-diverged/ >/dev/null
> +'

OK, and this one should find that most of them are not contained, but
the depth-first algorithm could walk all the way down to the roots. But
we don't run it at all, since we disable commit graphs!

So what are we trying to measure here? If it left commit graphs enabled,
I think we could demonstrate that using the depth-first algorithm with
generation numbers does not make anything _worse_. I.e., that
for-each-ref and branch did not regress from the change.

> +test_expect_success 'missing ancestors are reported by contains filters' '
> +	test_when_finished "git update-ref -d refs/heads/missing-parent" &&
> +	{
> +		echo "tree $(git rev-parse HEAD^{tree})" &&
> +		echo "parent $MISSING" &&
> +		git cat-file commit HEAD |
> +			sed -n -e "/^author /p" -e "/^committer /p" &&
> +		echo &&
> +		echo "missing parent"
> +	} >commit &&
> +	broken=$(git hash-object -t commit -w commit) &&
> +	git update-ref refs/heads/missing-parent "$broken" &&
> +	for option in --contains --no-contains
> +	do
> +		test_must_fail git for-each-ref "$option=HEAD" \
> +			refs/heads/missing-parent >out 2>err &&
> +		test_must_be_empty out &&
> +		test_grep "parse commit $MISSING" err ||
> +		return 1
> +	done
> +'

This is a great thing to test, but probably should be pulled out into
a separate patch along with the fix to check the return code.

The commit construction looks OK, and is nicer than corrupting the
repository by deleting a real object. Given that we are pulling the
idents from an existing commit, it might be simpler to just use the
whole commit as a template, like:

  git cat-file commit HEAD |
  sed "s/^parent /parent $MISSING/"

but it may be a matter of taste.

-Peff
