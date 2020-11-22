Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF306C388F9
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 02:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A92B206F7
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 02:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kO9njg+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKVC2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 21:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKVC2g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 21:28:36 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15377C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 18:28:35 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n11so12687352ota.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 18:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXUAOG1RH818CGBhu/CrEU31y4Hq0FzUelo0xaTplXI=;
        b=kO9njg+z/X+IQ4iOeHMIv+6/UpDclz74fQWXT5kQ07jj4h0Zjl6piHZuhqRTmBSEsg
         DEYKMqeBIFs6ztbLTLoeEPHxhn3Be2ZiccRnXuuajCV7CHvzjSkrFJV1pURhNYlKK9tW
         9uA5NC83DpEFgKRJuwFeAQ8LgwihAAwrPYSfaNucg2cHnnjsvJUa9/19oMYIIiJS4HII
         I0RZpy1jEjjE7x/RC0F7B3DomfRXYxhb8Ud9yeLonw160NoG9y50uRSbSE5RFolXRKRk
         5kMRx+QH/dXUGzv+7S2P/7CW3C3I0wdfvxb8KhWLFfkUTPBd73vVl68sGtujYIEZjVYx
         gg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXUAOG1RH818CGBhu/CrEU31y4Hq0FzUelo0xaTplXI=;
        b=svWBXvUc68wwhrIrF/t+PwTHVHc6nd98m+aBEE8Q38rQIod82H8KHCa/OxeJNmfRcG
         k7EygpEWPyZOh+vXK4nsIaHmy8L5YiOeuTh5H48BktTNl4C2O9qZRhesz3jRgSoJvTWI
         yRMtKD5oZ2ikUWzUYK5czOallXLaP2I4m1+Y8leffKpE8YR/p6C/cCbRCSzeG32YYQjf
         Tf1niiSWv4INgJYOCrZ7pyul+zh2ApyrISMJB5L8cJsRXBHyHTKTmMt6ITV1XZKGkFCD
         4wc73cfJgZNaXxJksn05dRx1nBFwRCPGPPqFrgr8QUUaQsTfaVjKbhNeZJUaGRlYaac5
         ZAOQ==
X-Gm-Message-State: AOAM530b6U4PphkzExS9m3abKKvW1f0RqwLYc+L2DqA1+pgQIUNfiX+r
        ZUqoRJ50gbp15t+GgrzJiLcOYQ==
X-Google-Smtp-Source: ABdhPJyhF191+n3EQJIM8smNDGkG2dbgdfx/jydsZUsRrN+6mfGUOYzsgsb6zRJQbAxRo2x09NTsBA==
X-Received: by 2002:a05:6830:1f50:: with SMTP id u16mr18109950oth.265.1606012113979;
        Sat, 21 Nov 2020 18:28:33 -0800 (PST)
Received: from localhost ([198.184.28.250])
        by smtp.gmail.com with ESMTPSA id h8sm3702064otm.72.2020.11.21.18.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 18:28:33 -0800 (PST)
Date:   Sat, 21 Nov 2020 21:28:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X7nMzzMfjm/p9qfj@xnor.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <20201118183225.GB8396@szeder.dev>
 <X7V7X/qDfN0udr2u@nand.local>
 <X7nKRxNy47nTre3b@xnor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7nKRxNy47nTre3b@xnor.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 09:17:43PM -0500, Taylor Blau wrote:
> But, this isn't a new test from this patch's perspective, so I'll make a
> note of why this changed in a replacement.

Here's that patch: let's use it as a replacement when queueing. Thanks
again for noticing.

--- 8< ---

From: Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] pack-bitmap-write: build fewer intermediate bitmaps

The bitmap_writer_build() method calls bitmap_builder_init() to
construct a list of commits reachable from the selected commits along
with a "reverse graph". This reverse graph has edges pointing from a
commit to other commits that can reach that commit. After computing a
reachability bitmap for a commit, the values in that bitmap are then
copied to the reachability bitmaps across the edges in the reverse
graph.

We can now relax the role of the reverse graph to greatly reduce the
number of intermediate reachability bitmaps we compute during this
reverse walk. The end result is that we walk objects the same number of
times as before when constructing the reachability bitmaps, but we also
spend much less time copying bits between bitmaps and have much lower
memory pressure in the process.

The core idea is to select a set of "important" commits based on
interactions among the sets of commits reachable from each selected commit.

The first technical concept is to create a new 'commit_mask' member in the
bb_commit struct. Note that the selected commits are provided in an
ordered array. The first thing to do is to mark the ith bit in the
commit_mask for the ith selected commit. As we walk the commit-graph, we
copy the bits in a commit's commit_mask to its parents. At the end of
the walk, the ith bit in the commit_mask for a commit C stores a boolean
representing "The ith selected commit can reach C."

As we walk, we will discover non-selected commits that are important. We
will get into this later, but those important commits must also receive
bit positions, growing the width of the bitmasks as we walk. At the true
end of the walk, the ith bit means "the ith _important_ commit can reach
C."

MAXIMAL COMMITS
---------------

We use a new 'maximal' bit in the bb_commit struct to represent whether
a commit is important or not. The term "maximal" comes from the
partially-ordered set of commits in the commit-graph where C >= P if P
is a parent of C, and then extending the relationship transitively.
Instead of taking the maximal commits across the entire commit-graph, we
instead focus on selecting each commit that is maximal among commits
with the same bits on in their commit_mask. This definition is
important, so let's consider an example.

Suppose we have three selected commits A, B, and C. These are assigned
bitmasks 100, 010, and 001 to start. Each of these can be marked as
maximal immediately because they each will be the uniquely maximal
commit that contains their own bit. Keep in mind that that these commits
may have different bitmasks after the walk; for example, if B can reach
C but A cannot, then the final bitmask for C is 011. Even in these
cases, C would still be a maximal commit among all commits with the
third bit on in their masks.

Now define sets X, Y, and Z to be the sets of commits reachable from A,
B, and C, respectively. The intersections of these sets correspond to
different bitmasks:

 * 100: X - (Y union Z)
 * 010: Y - (X union Z)
 * 001: Z - (X union Y)
 * 110: (X intersect Y) - Z
 * 101: (X intersect Z) - Y
 * 011: (Y intersect Z) - X
 * 111: X intersect Y intersect Z

This can be visualized with the following Hasse diagram:

	100    010    001
         | \  /   \  / |
         |  \/     \/  |
         |  /\     /\  |
         | /  \   /  \ |
        110    101    011
          \___  |  ___/
              \ | /
               111

Some of these bitmasks may not be represented, depending on the topology
of the commit-graph. In fact, we are counting on it, since the number of
possible bitmasks is exponential in the number of selected commits, but
is also limited by the total number of commits. In practice, very few
bitmasks are possible because most commits converge on a common "trunk"
in the commit history.

With this three-bit example, we wish to find commits that are maximal
for each bitmask. How can we identify this as we are walking?

As we walk, we visit a commit C. Since we are walking the commits in
topo-order, we know that C is visited after all of its children are
visited. Thus, when we get C from the revision walk we inspect the
'maximal' property of its bb_data and use that to determine if C is truly
important. Its commit_mask is also nearly final. If C is not one of the
originally-selected commits, then assign a bit position to C (by
incrementing num_maximal) and set that bit on in commit_mask. See
"MULTIPLE MAXIMAL COMMITS" below for more detail on this.

Now that the commit C is known to be maximal or not, consider each
parent P of C. Compute two new values:

 * c_not_p : true if and only if the commit_mask for C contains a bit
             that is not contained in the commit_mask for P.

 * p_not_c : true if and only if the commit_mask for P contains a bit
             that is not contained in the commit_mask for P.

If c_not_p is false, then P already has all of the bits that C would
provide to its commit_mask. In this case, move on to other parents as C
has nothing to contribute to P's state that was not already provided by
other children of P.

We continue with the case that c_not_p is true. This means there are
bits in C's commit_mask to copy to P's commit_mask, so use bitmap_or()
to add those bits.

If p_not_c is also true, then set the maximal bit for P to one. This means
that if no other commit has P as a parent, then P is definitely maximal.
This is because no child had the same bitmask. It is important to think
about the maximal bit for P at this point as a temporary state: "P is
maximal based on current information."

In contrast, if p_not_c is false, then set the maximal bit for P to
zero. Further, clear all reverse_edges for P since any edges that were
previously assigned to P are no longer important. P will gain all
reverse edges based on C.

The final thing we need to do is to update the reverse edges for P.
These reverse edges respresent "which closest maximal commits
contributed bits to my commit_mask?" Since C contributed bits to P's
commit_mask in this case, C must add to the reverse edges of P.

If C is maximal, then C is a 'closest' maximal commit that contributed
bits to P. Add C to P's reverse_edges list.

Otherwise, C has a list of maximal commits that contributed bits to its
bitmask (and this list is exactly one element). Add all of these items
to P's reverse_edges list. Be careful to ignore duplicates here.

After inspecting all parents P for a commit C, we can clear the
commit_mask for C. This reduces the memory load to be limited to the
"width" of the commit graph.

Consider our ABC/XYZ example from earlier and let's inspect the state of
the commits for an interesting bitmask, say 011. Suppose that D is the
only maximal commit with this bitmask (in the first three bits). All
other commits with bitmask 011 have D as the only entry in their
reverse_edges list. D's reverse_edges list contains B and C.

COMPUTING REACHABILITY BITMAPS
------------------------------

Now that we have our definition, let's zoom out and consider what
happens with our new reverse graph when computing reachability bitmaps.
We walk the reverse graph in reverse-topo-order, so we visit commits
with largest commit_masks first. After we compute the reachability
bitmap for a commit C, we push the bits in that bitmap to each commit D
in the reverse edge list for C. Then, when we finally visit D we already
have the bits for everything reachable from maximal commits that D can
reach and we only need to walk the objects in the set-difference.

In our ABC/XYZ example, when we finally walk for the commit A we only
need to walk commits with bitmask equal to A's bitmask. If that bitmask
is 100, then we are only walking commits in X - (Y union Z) because the
bitmap already contains the bits for objects reachable from (X intersect
Y) union (X intersect Z) (i.e. the bits from the reachability bitmaps
for the maximal commits with bitmasks 110 and 101).

The behavior is intended to walk each commit (and the trees that commit
introduces) at most once while allocating and copying fewer reachability
bitmaps. There is one caveat: what happens when there are multiple
maximal commits with the same bitmask, with respect to the initial set
of selected commits?

MULTIPLE MAXIMAL COMMITS
------------------------

Earlier, we mentioned that when we discover a new maximal commit, we
assign a new bit position to that commit and set that bit position to
one for that commit. This is absolutely important for interesting
commit-graphs such as git/git and torvalds/linux. The reason is due to
the existence of "butterflies" in the commit-graph partial order.

Here is an example of four commits forming a butterfly:

   I    J
   |\  /|
   | \/ |
   | /\ |
   |/  \|
   M    N
    \  /
     |/
     Q

Here, I and J both have parents M and N. In general, these do not need
to be exact parent relationships, but reachability relationships. The
most important part is that M and N cannot reach each other, so they are
independent in the partial order. If I had commit_mask 10 and J had
commit_mask 01, then M and N would both be assigned commit_mask 11 and
be maximal commits with the bitmask 11. Then, what happens when M and N
can both reach a commit Q? If Q is also assigned the bitmask 11, then it
is not maximal but is reachable from both M and N.

While this is not necessarily a deal-breaker for our abstract definition
of finding maximal commits according to a given bitmask, we have a few
issues that can come up in our larger picture of constructing
reachability bitmaps.

In particular, if we do not also consider Q to be a "maximal" commit,
then we will walk commits reachable from Q twice: once when computing
the reachability bitmap for M and another time when computing the
reachability bitmap for N. This becomes much worse if the topology
continues this pattern with multiple butterflies.

The solution has already been mentioned: each of M and N are assigned
their own bits to the bitmask and hence they become uniquely maximal for
their bitmasks. Finally, Q also becomes maximal and thus we do not need
to walk its commits multiple times. The final bitmasks for these commits
are as follows:

  I:10       J:01
   |\        /|
   | \ _____/ |
   | /\____   |
   |/      \  |
   M:111    N:1101
        \  /
       Q:1111

Further, Q's reverse edge list is { M, N }, while M and N both have
reverse edge list { I, J }.

PERFORMANCE MEASUREMENTS
------------------------

Now that we've spent a LOT of time on the theory of this algorithm,
let's show that this is actually worth all that effort.

To test the performance, use GIT_TRACE2_PERF=1 when running
'git repack -abd' in a repository with no existing reachability bitmaps.
This avoids any issues with keeping existing bitmaps to skew the
numbers.

Inspect the "building_bitmaps_total" region in the trace2 output to
focus on the portion of work that is affected by this change. Here are
the performance comparisons for a few repositories. The timings are for
the following versions of Git: "multi" is the timing from before any
reverse graph is constructed, where we might perform multiple
traversals. "reverse" is for the previous change where the reverse graph
has every reachable commit.  Finally "maximal" is the version introduced
here where the reverse graph only contains the maximal commits.

      Repository: git/git
           multi: 2.628 sec
         reverse: 2.344 sec
         maximal: 2.047 sec

      Repository: torvalds/linux
           multi: 64.7 sec
         reverse: 205.3 sec
         maximal: 44.7 sec

So in all cases we've not only recovered any time lost to switching to
the reverse-edge algorithm, but we come out ahead of "multi" in all
cases. Likewise, peak heap has gone back to something reasonable:

      Repository: torvalds/linux
           multi: 2.087 GB
         reverse: 3.141 GB
         maximal: 2.288 GB

While I do not have access to full fork networks on GitHub, Peff has run
this algorithm on the chromium/chromium fork network and reported a
change from 3 hours to ~233 seconds. That network is particularly
beneficial for this approach because it has a long, linear history along
with many tags. The "multi" approach was obviously quadratic and the new
approach is linear.

MISCELLANEOUS
-------------

Unluckily, this patch causes bitmaps to change in such a way that
t5310.66 no longer passes as-is in SHA-256 mode. That test is asserting
that truncated .bitmap files fail gracefully. But noticing that
truncation depends on which bitmaps we try to look at, and exactly where
the truncation is.

Since this commit happens to rearrange the bytes in that exact region by
changing the way commits are selected (and thus shifting around other
bitmaps), move the truncation to a spot where it will be noticed in both
SHA-1 and SHA-256 mode.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c     | 72 +++++++++++++++++++++++++++++++---
 t/t5310-pack-bitmaps.sh | 87 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 10 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 369c76a87c..7b4fc0f304 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -180,8 +180,10 @@ static void compute_xor_offsets(void)

 struct bb_commit {
 	struct commit_list *reverse_edges;
+	struct bitmap *commit_mask;
 	struct bitmap *bitmap;
-	unsigned selected:1;
+	unsigned selected:1,
+		 maximal:1;
 	unsigned idx; /* within selected array */
 };

@@ -198,7 +200,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 {
 	struct rev_info revs;
 	struct commit *commit;
-	unsigned int i;
+	unsigned int i, num_maximal;

 	memset(bb, 0, sizeof(*bb));
 	init_bb_data(&bb->data);
@@ -210,27 +212,85 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	for (i = 0; i < writer->selected_nr; i++) {
 		struct commit *c = writer->selected[i].commit;
 		struct bb_commit *ent = bb_data_at(&bb->data, c);
+
 		ent->selected = 1;
+		ent->maximal = 1;
 		ent->idx = i;
+
+		ent->commit_mask = bitmap_new();
+		bitmap_set(ent->commit_mask, i);
+
 		add_pending_object(&revs, &c->object, "");
 	}
+	num_maximal = writer->selected_nr;

 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");

 	while ((commit = get_revision(&revs))) {
 		struct commit_list *p;
+		struct bb_commit *c_ent;

 		parse_commit_or_die(commit);

-		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
-		bb->commits[bb->commits_nr++] = commit;
+		c_ent = bb_data_at(&bb->data, commit);
+
+		if (c_ent->maximal) {
+			if (!c_ent->selected) {
+				bitmap_set(c_ent->commit_mask, num_maximal);
+				num_maximal++;
+			}
+
+			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
+			bb->commits[bb->commits_nr++] = commit;
+		}

 		for (p = commit->parents; p; p = p->next) {
-			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
-			commit_list_insert(commit, &ent->reverse_edges);
+			struct bb_commit *p_ent = bb_data_at(&bb->data, p->item);
+			int c_not_p, p_not_c;
+
+			if (!p_ent->commit_mask) {
+				p_ent->commit_mask = bitmap_new();
+				c_not_p = 1;
+				p_not_c = 0;
+			} else {
+				c_not_p = bitmap_diff_nonzero(c_ent->commit_mask, p_ent->commit_mask);
+				p_not_c = bitmap_diff_nonzero(p_ent->commit_mask, c_ent->commit_mask);
+			}
+
+			if (!c_not_p)
+				continue;
+
+			bitmap_or(p_ent->commit_mask, c_ent->commit_mask);
+
+			if (p_not_c)
+				p_ent->maximal = 1;
+			else {
+				p_ent->maximal = 0;
+				free_commit_list(p_ent->reverse_edges);
+				p_ent->reverse_edges = NULL;
+			}
+
+			if (c_ent->maximal) {
+				commit_list_insert(commit, &p_ent->reverse_edges);
+			} else {
+				struct commit_list *cc = c_ent->reverse_edges;
+
+				for (; cc; cc = cc->next) {
+					if (!commit_list_contains(cc->item, p_ent->reverse_edges))
+						commit_list_insert(cc->item, &p_ent->reverse_edges);
+				}
+			}
 		}
+
+		bitmap_free(c_ent->commit_mask);
+		c_ent->commit_mask = NULL;
 	}
+
+	trace2_data_intmax("pack-bitmap-write", the_repository,
+			   "num_selected_commits", writer->selected_nr);
+	trace2_data_intmax("pack-bitmap-write", the_repository,
+			   "num_maximal_commits", num_maximal);
 }

 static void bitmap_builder_clear(struct bitmap_builder *bb)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6bf68fee85..1691710ec1 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -20,11 +20,87 @@ has_any () {
 	grep -Ff "$1" "$2"
 }

+# To ensure the logic for "maximal commits" is exercised, make
+# the repository a bit more complicated.
+#
+#    other                         master
+#      *                             *
+# (99 commits)                  (99 commits)
+#      *                             *
+#      |\                           /|
+#      | * octo-other  octo-master * |
+#      |/|\_________  ____________/|\|
+#      | \          \/  __________/  |
+#      |  | ________/\ /             |
+#      *  |/          * merge-right  *
+#      | _|__________/ \____________ |
+#      |/ |                         \|
+# (l1) *  * merge-left               * (r1)
+#      | / \________________________ |
+#      |/                           \|
+# (l2) *                             * (r2)
+#       \____________...____________ |
+#                                   \|
+#                                    * (base)
+#
+# The important part for the maximal commit algorithm is how
+# the bitmasks are extended. Assuming starting bit positions
+# for master (bit 0) and other (bit 1), and some flexibility
+# in the order that merge bases are visited, the bitmasks at
+# the end should be:
+#
+#      master: 1       (maximal, selected)
+#       other: 01      (maximal, selected)
+# octo-master: 1
+#  octo-other: 01
+# merge-right: 111     (maximal)
+#        (l1): 111
+#        (r1): 111
+#  merge-left: 1101    (maximal)
+#        (l2): 11111   (maximal)
+#        (r2): 111101  (maximal)
+#      (base): 1111111 (maximal)
+
 test_expect_success 'setup repo with moderate-sized history' '
-	test_commit_bulk --id=file 100 &&
+	test_commit_bulk --id=file 10 &&
 	git checkout -b other HEAD~5 &&
 	test_commit_bulk --id=side 10 &&
+
+	# add complicated history setup, including merges and
+	# ambiguous merge-bases
+
+	git checkout -b merge-left other~2 &&
+	git merge master~2 -m "merge-left" &&
+
+	git checkout -b merge-right master~1 &&
+	git merge other~1 -m "merge-right" &&
+
+	git checkout -b octo-master master &&
+	git merge merge-left merge-right -m "octopus-master" &&
+
+	git checkout -b octo-other other &&
+	git merge merge-left merge-right -m "octopus-other" &&
+
+	git checkout other &&
+	git merge octo-other -m "pull octopus" &&
+
 	git checkout master &&
+	git merge octo-master -m "pull octopus" &&
+
+	# Remove these branches so they are not selected
+	# as bitmap tips
+	git branch -D merge-left &&
+	git branch -D merge-right &&
+	git branch -D octo-other &&
+	git branch -D octo-master &&
+
+	# add padding to make these merges less interesting
+	# and avoid having them selected for bitmaps
+	test_commit_bulk --id=file 100 &&
+	git checkout other &&
+	test_commit_bulk --id=side 100 &&
+	git checkout master &&
+
 	bitmaptip=$(git rev-parse master) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
@@ -32,9 +108,12 @@ test_expect_success 'setup repo with moderate-sized history' '
 '

 test_expect_success 'full repack creates bitmaps' '
-	git repack -ad &&
+	GIT_TRACE2_EVENT_NESTING=4 GIT_TRACE2_EVENT="$(pwd)/trace" \
+		git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
-	test_line_count = 1 output
+	test_line_count = 1 output &&
+	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
+	grep "\"key\":\"num_maximal_commits\",\"value\":\"111\"" trace
 '

 test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
@@ -356,7 +435,7 @@ test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 270 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
--
2.29.2.312.gabc4d358d8

