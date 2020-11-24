Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BAC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 06:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176662076C
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 06:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOsh3ZTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgKXGHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 01:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgKXGHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 01:07:42 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B8C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 22:07:42 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id g12so15441819qtc.15
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 22:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7xtz7HsNWdHNLXbJtTYnOGo0acsQU+2UuKyMlHBPFTA=;
        b=jOsh3ZTOVLbAt0jFlq4ivQ7HVWQucxyfddOIqQrXLXV96wErVwu4N6JDxng1om9OXZ
         qcvzem/O9vgN7+Zm2r7JQrqkjcHi5Vset15bCMpT0fZAialEAnn7h4H7GqC0C//LRJXR
         IwXma+t4fl/Sp3Z4LbUeSO/hpm6CzykhGuTU9lmT2mK87JmAywAaKzKYBCAviminPpxF
         XXaJaDVk70WVLyvMb4sauqnCyGwiNHGIVWrxDLe9NKgfJ41fUu7wmWzD+ME6j+yHq/WW
         venhFmxlknzKHZPXvh1PQOSDWvWTznuyFvEQOGXlq/1TFE0aYY+pp7RZ8c4AbrtgBbsC
         prFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7xtz7HsNWdHNLXbJtTYnOGo0acsQU+2UuKyMlHBPFTA=;
        b=h7B3kKjTnlIYnhx9FEca3XJ/ENxCQi2nGejU8KfYugCnWAj799rLKt1uHGBmWy1EGE
         WhvvE0lqgRk9TJk0srbosUL8c7Yo5c1n61USHB9yrXWkxd27/tqaPJtyj+pEIDlonh6u
         12Pv4lBQvDbG2cLxG1iQwwv0hck6hSfcJlj6K0in92/NkEfdGWg8japtjNF+umbDiUUQ
         8we4tdMgDIu1haGgey0nJgZueitr17vcuTQ7Od0+UjJzXSsY+cIFUuEJNMWoi6siRwOP
         sbi3qRdkDBfA8z3TMPaBpscslFD0YL4305GEQf8cIV0oxD9OdZbZxGgkCq6kpssMGNiY
         nQlg==
X-Gm-Message-State: AOAM533OlE5i1WyCpshG4vkwzBEl55NxSxeO/fMSbd7SPwYb7H/ws/gY
        rgwlUC1aJ5dT+nthhzGPzLMrACnEEuuy5kNH/GA1
X-Google-Smtp-Source: ABdhPJy/xFpK3mivyFzwA5s2a5zzCYxlY+rCPzqu6iguu9ruJPLSyBZL21vztXacL99r0zE/nRe+Z1iuQP72M0nqqnm8
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:9e20:: with SMTP id
 p32mr3096973qve.44.1606198061486; Mon, 23 Nov 2020 22:07:41 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:07:38 -0800
In-Reply-To: <5262daa3300114fbaccdbc7393882c5435f95f4f.1605649533.git.me@ttaylorr.com>
Message-Id: <20201124060738.762751-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <5262daa3300114fbaccdbc7393882c5435f95f4f.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 18/24] pack-bitmap-write: build fewer intermediate bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this is the "big patch" mentioned in IRC [1]? I'll review just
the commit message of this one first, then go back and review from patch
10 ("pack-bitmap-write: reimplement bitmap writing") up to this
one inclusive.

[1] https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-11-23

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The bitmap_writer_build() method calls bitmap_builder_init() to
> construct a list of commits reachable from the selected commits along
> with a "reverse graph". This reverse graph has edges pointing from a
> commit to other commits that can reach that commit. After computing a
> reachability bitmap for a commit, the values in that bitmap are then
> copied to the reachability bitmaps across the edges in the reverse
> graph.
> 
> We can now relax the role of the reverse graph to greatly reduce the
> number of intermediate reachability bitmaps we compute during this
> reverse walk. The end result is that we walk objects the same number of
> times as before when constructing the reachability bitmaps, but we also
> spend much less time copying bits between bitmaps and have much lower
> memory pressure in the process.

OK - as I have seen in the previous patches, and as said here, the edges
of the graph were previously parent to immediate child, but I believe
that patch 12 ("pack-bitmap-write: fill bitmap with commit history")
makes it so that the edges don't need to be direct parent-child
relationships. That patch does not, however, decide what the vertices
and edges should thus be, so that ability could not be used. This patch
seems to do so, and thus makes use of that ability.

> The core idea is to select a set of "important" commits based on
> interactions among the sets of commits reachable from each selected commit.

Makes sense.

> The first technical concept is to create a new 'commit_mask' member in the
> bb_commit struct. Note that the selected commits are provided in an
> ordered array. The first thing to do is to mark the ith bit in the
> commit_mask for the ith selected commit. 

OK - so this commit_mask is like the bitmaps in Git. There is an array,
initially populated with the list of selected commits (which are
selected using another algorithm, which is a separate concern from this
patch set), and each bit in commit_mask corresponds to the corresponding
entry in that array.

From this, I assume that the commit_mask values in the selected
bb_commit structs will start with a nonzero value (written in binary,
having 1 bit set), and the other commit_mask values will start with
zero.

> As we walk the commit-graph, we
> copy the bits in a commit's commit_mask to its parents. At the end of
> the walk, the ith bit in the commit_mask for a commit C stores a boolean
> representing "The ith selected commit can reach C."

The walk is done in topological order - visiting children before
parents. Copying makes sense - if a commit can reach me, it can reach my
parents as well.

> As we walk, we will discover non-selected commits that are important. We
> will get into this later, but those important commits must also receive
> bit positions, growing the width of the bitmasks as we walk. At the true
> end of the walk, the ith bit means "the ith _important_ commit can reach
> C."

OK - so the initial array, initially populated with the list of selected
commits, can be grown and will include other important commits as well.
This is similar to the bitmap revwalk algorithm - the bitmaps in that
algorithm can be grown to include other objects as well.

> MAXIMAL COMMITS
> ---------------
> 
> We use a new 'maximal' bit in the bb_commit struct to represent whether
> a commit is important or not. The term "maximal" comes from the
> partially-ordered set of commits in the commit-graph where C >= P if P
> is a parent of C, and then extending the relationship transitively.

I had to look up what "maximal" means in a partial order. :-P An element
of a partially ordered set is "maximal" if there is no other element
that is "greater" than it. Here, all descendants are "greater" than
their ancestors.

> Instead of taking the maximal commits across the entire commit-graph, 

I was wondering about this :-)

> we
> instead focus on selecting each commit that is maximal among commits
> with the same bits on in their commit_mask. 

Ah, OK. Two commits will have the same commit_mask if the exact same set
of important commits can reach them.

> This definition is
> important, so let's consider an example.
> 
> Suppose we have three selected commits A, B, and C. These are assigned
> bitmasks 100, 010, and 001 to start. Each of these can be marked as
> maximal immediately because they each will be the uniquely maximal
> commit that contains their own bit. 

That is correct. To further elaborate on this explanation, let's say we
have a selected commit C (and since it is selected, the commit_mask in
each commit will have a bit corresponding to whether C can reach it).
Each other commit is either an ancestor, a descendant, or unrelated.

 - C cannot reach descendants.
 - C cannot reach unrelated commits.
 - C can reach all ancestors, but in the partial order, C compares
   "greater" to them anyway.

So every other commit cannot affect C's maximal status.

> Keep in mind that that these commits
> may have different bitmasks after the walk; for example, if B can reach
> C but A cannot, then the final bitmask for C is 011. Even in these
> cases, C would still be a maximal commit among all commits with the
> third bit on in their masks.

Yes.

> Now define sets X, Y, and Z to be the sets of commits reachable from A,
> B, and C, respectively. The intersections of these sets correspond to
> different bitmasks:
> 
>  * 100: X - (Y union Z)
>  * 010: Y - (X union Z)
>  * 001: Z - (X union Y)
>  * 110: (X intersect Y) - Z
>  * 101: (X intersect Z) - Y
>  * 011: (Y intersect Z) - X
>  * 111: X intersect Y intersect Z
> 
> This can be visualized with the following Hasse diagram:
> 
> 	100    010    001
>          | \  /   \  / |
>          |  \/     \/  |
>          |  /\     /\  |
>          | /  \   /  \ |
>         110    101    011
>           \___  |  ___/
>               \ | /
>                111
> 
> Some of these bitmasks may not be represented, depending on the topology
> of the commit-graph. In fact, we are counting on it, since the number of
> possible bitmasks is exponential in the number of selected commits, but
> is also limited by the total number of commits. In practice, very few
> bitmasks are possible because most commits converge on a common "trunk"
> in the commit history.

This section wasn't very useful to me - but I would appreciate it if
others chimed in to say it was useful to them.

> With this three-bit example, we wish to find commits that are maximal
> for each bitmask. How can we identify this as we are walking?

OK - now we come to the algorithm. I presume the algorithm doesn't only
find commits that are maximal for each bitmask, but also updates the
list of important commits (and thus increasing the size of the bitmask)?
Reading below, I see that the answer to my question is yes. Ah...it
wasn't clear to me that the purpose of finding the maximal commits is
also to add to the list of important commits, but perhaps it will be
obvious to other reasons.

I'll work through the algorithm using the butterfly example below,
reproduced here:

>    I    J
>    |\  /|
>    | \/ |
>    | /\ |
>    |/  \|
>    M    N
>     \  /
>      |/
>      Q

I was going to suggest that we suppose that there are no selected
commits, but it looks like the algorithm would optimize itself out
(meaning that it won't make any commit maximal - which makes sense, I
guess). The example below had I and J as selected commits (which I know
because the commit_mask values for I and J are "0b10" and "0b01"
respectively), so let's go with that.

> As we walk, we visit a commit C. Since we are walking the commits in
> topo-order, we know that C is visited after all of its children are
> visited. Thus, when we get C from the revision walk we inspect the
> 'maximal' property of its bb_data and use that to determine if C is truly
> important. Its commit_mask is also nearly final. 

OK - when a commit is visited, we would already know its "maximal"
status because when we had visited its parents, we already modified
"maximal" (because we update a commit's children when we visit it -
details about this are to follow, presumably).

> If C is not one of the
> originally-selected commits, then assign a bit position to C (by
> incrementing num_maximal) and set that bit on in commit_mask. See
> "MULTIPLE MAXIMAL COMMITS" below for more detail on this.

I presume we only assign a bit position to C if it is "maximal"?

> Now that the commit C is known to be maximal or not, consider each
> parent P of C. Compute two new values:
> 
>  * c_not_p : true if and only if the commit_mask for C contains a bit
>              that is not contained in the commit_mask for P.
> 
>  * p_not_c : true if and only if the commit_mask for P contains a bit
>              that is not contained in the commit_mask for P.

OK, let's try this with I. I'll use the same <commit
letter>:<commit_mask in little-endian order> notation as the one the
commit author uses below to indicate the commit_mask of a commit. We
have I:10 with 2 parents M:00 and N:00, so for both parents, c_not_p is
true and p_not_c is false.

> If c_not_p is false, then P already has all of the bits that C would
> provide to its commit_mask. In this case, move on to other parents as C
> has nothing to contribute to P's state that was not already provided by
> other children of P.

To emphasize, we "move on" regardless of what p_not_c is. In our
example, this is not true in I's case, so let's read on.

After the analysis below, I see why we can "move on".

> We continue with the case that c_not_p is true. This means there are
> bits in C's commit_mask to copy to P's commit_mask, so use bitmap_or()
> to add those bits.

OK. So we have I:10 (unchanged), M:10, N:10. Which as I said above,
makes sense, since if a commit can reach I, it can reach M and N.

> If p_not_c is also true, then set the maximal bit for P to one. This means
> that if no other commit has P as a parent, then P is definitely maximal.
> This is because no child had the same bitmask. It is important to think
> about the maximal bit for P at this point as a temporary state: "P is
> maximal based on current information."
> 
> In contrast, if p_not_c is false, then set the maximal bit for P to
> zero.

At first it was confusing that (1) the last maximal bit is used when
there is no guarantee that the children are iterated in any particular
order, and (2) the maximal bit is never updated when c_not_p is false.
So I was thinking of a counterexample, but couldn't think of one. So
this algorithm looks correct so far.

For (2), I think of it this way:

    C1 C2 C3
      \ |/
        P

Let's say that C1 has a commit_mask, and C2 and C3 have the exact same
commit_mask. P's maximal bit will be the exact same in the following
situation:

    C1 C2
      \ |
        P

So skipping over C3 is correct. And C3 must be skipped because the
algorithm as written is not idempotent (during the C2 iteration,
commit_mask of P is updated).

For (1), I think of it as follows. The only one that counts is the very
last calculation (which you can see from the algorithm - the maximal bit
is constantly being overridden). During the very last iteration, does P
have any information that Cx does not? If yes, P has a commit_mask that
is unique w.r.t. all its children (since it combines unique information
from its other children that Cx does not, plus some other unique
information that Cx has and its other children do not) and is
therefore maximal. If not, all the information P got is also known by
Cx, so it is definitely not maximal (Cx shares the commit_mask with P,
and is "greater" than P).

> Further, clear all reverse_edges for P since any edges that were
> previously assigned to P are no longer important. P will gain all
> reverse edges based on C.

(I read ahead to see what the reverse edges are.) Indeed, C has all the
information.

> The final thing we need to do is to update the reverse edges for P.
> These reverse edges respresent "which closest maximal commits
> contributed bits to my commit_mask?" Since C contributed bits to P's
> commit_mask in this case, C must add to the reverse edges of P.
> 
> If C is maximal, then C is a 'closest' maximal commit that contributed
> bits to P. Add C to P's reverse_edges list.
> 
> Otherwise, C has a list of maximal commits that contributed bits to its
> bitmask (and this list is exactly one element). Add all of these items
> to P's reverse_edges list. Be careful to ignore duplicates here.

OK - the other end of reverse edges are always to maximal commits.
Propagation in this way (if C is not maximal) makes sense.

> After inspecting all parents P for a commit C, we can clear the
> commit_mask for C. This reduces the memory load to be limited to the
> "width" of the commit graph.

Optimization - OK.

I might as well finish working through the example. Let's start from the
beginning.

    I    J I:10()M J:01()M
    |\  /|
    | \/ |
    | /\ |
    |/  \|
    M    N
     \  /
      |/
      Q

(Brackets are the destinations of reverse edges. M is maximal, ~M is not
maximal.)

Iteration starts with I. I is maximal, but it is also one of the
selected commits, so we need not do anything else. Look at its parents,
starting with M. c_of_p is true, so copy the bits over. p_of_c is false,
so the maximal bit of M is zero, clear all its reverse edges (no-op in
this case, since it has none), and update its reverse edges: C is
maximal so it will just be C. The procedure for N is exactly the same.
So we have:

    I    J I:10()M J:01()M
    |\  /|
    | \/ |
    | /\ |
    |/  \|
    M    N M:10(I)~M N:10(I)~M
     \  /
      |/
      Q

Now onto J. J is maximal, but it is also one of the selected commits, so
we need not do anything else. Look at its parent M. c_of_p is true, so
copy the bits over. p_of_c is true this time. So set the maximal bit to
true. (Indeed, M has information that is independent of J - the stuff
that it got from I.) We need not clear any reverse edges, but must still
update them: J is maximal so we add J. The procedure for N is exactly
the same. So we have:

    I    J I:10()M J:01()M
    |\  /|
    | \/ |
    | /\ |
    |/  \|
    M    N M:11(I,J)M N:11(I,J)M
     \  /
      |/
      Q

Let's go to M. M is maximal, and it is not one of the selected commits,
so widen the commit_mask and set the corresponding bit on M. Look at its
only parent Q. c_of_p is true, so copy the bits over. p_of_c is false,
so the maximal bit of Q is zero, and update its reverse edges as usual.

    I    J I:10()M J:01()M
    |\  /|
    | \/ |
    | /\ |
    |/  \|
    M    N M:111(I,J)M N:11(I,J)M
     \  /
      |/
      Q Q:111(M)~M

Now, N. N is maximal, and it is not one of the selected commits, so
widen the commit_mask and set the corresponding bit on N. Look at its
only parent Q. c_of_p is true; copy bits; but this time p_of_c is true,
so set the maximal bit to true. Don't clear reverse edges; N is maximal
so add it.

    I    J I:10()M J:01()M
    |\  /|
    | \/ |
    | /\ |
    |/  \|
    M    N M:111(I,J)M N:1101(I,J)M
     \  /
      |/
      Q Q:1111(M,N)M

Checking the answer below, it looks like the commit author and I agree.

> Consider our ABC/XYZ example from earlier and let's inspect the state of
> the commits for an interesting bitmask, say 011. Suppose that D is the
> only maximal commit with this bitmask (in the first three bits). All
> other commits with bitmask 011 have D as the only entry in their
> reverse_edges list. D's reverse_edges list contains B and C.

Yes, this makes sense.

Let me write about "D's reverse_edges list contains B and C" first: The
fact that D has a bitmask of 011 shows no important commits can reach it
other than B or C. Any intermediate commits between B and D would not be
maximal (because B is "greater" than such an intermediate commit, and we
already established that no other important commit can reach D, and
therefore no other important commit can reach any of the commits on the
path between B and D). Same analysis applies for C instead of B. So the
propagated reverse edges would just be B and C.

Now "all other commits with bitmask 011 have D as the only entry in
their reverse_edges list". Since D is the only maximal commit with 011,
any other commit that has 011 (1) must have got it from D, and (2)
cannot be reached by any other important commit. A similar analysis as
in the previous paragraph shows why the reverse_edges list for all these
commits would only contain D.

> COMPUTING REACHABILITY BITMAPS
> ------------------------------
> 
> Now that we have our definition, let's zoom out and consider what
> happens with our new reverse graph when computing reachability bitmaps.
> We walk the reverse graph in reverse-topo-order, so we visit commits
> with largest commit_masks first. After we compute the reachability
> bitmap for a commit C, we push the bits in that bitmap to each commit D
> in the reverse edge list for C. 

That makes sense - the reachability bitmap for D is the reachability
bitmap for C + the reachability bitmap of (D-C). Here we have the first
operand.

> Then, when we finally visit D we already
> have the bits for everything reachable from maximal commits that D can
> reach and we only need to walk the objects in the set-difference.

Walking the objects in the set-difference gives us the second operand.
Makes sense.

> In our ABC/XYZ example, when we finally walk for the commit A we only
> need to walk commits with bitmask equal to A's bitmask. If that bitmask
> is 100, then we are only walking commits in X - (Y union Z) because the
> bitmap already contains the bits for objects reachable from (X intersect
> Y) union (X intersect Z) (i.e. the bits from the reachability bitmaps
> for the maximal commits with bitmasks 110 and 101).

This is probably correct, but I've lost track of what X, Y, and Z are so
I'll just skip this paragraph.

> The behavior is intended to walk each commit (and the trees that commit
> introduces) at most once while allocating and copying fewer reachability
> bitmaps. 

Yes, I can see how this algorithm causes this behavior.

> There is one caveat: what happens when there are multiple
> maximal commits with the same bitmask, with respect to the initial set
> of selected commits?

I'm going to be lazy here and ask, is this possible? As described
below in "MULTIPLE MAXIMAL COMMITS", if a non-selected commit turns out
to be maximal, it will have its very own bit, and thus become the
"progenitor" of all commits with that bit set. (This is not a true
progenitor, because this bit propagates from the children to the
parents and not the other way round - unlike a gene.)

> MULTIPLE MAXIMAL COMMITS
> ------------------------

I think I discussed everything here earlier, so [skip].

> PERFORMANCE MEASUREMENTS
> ------------------------

Numbers look good. [skip]

As discussed above, I'll not review the code this round. [skip code]

Phew...this took longer than expected. I'll see if I can review the rest
of the patches tomorrow.
