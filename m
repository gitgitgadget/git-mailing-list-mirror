From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Tidy up some rev-list-related stuff
Date: Wed, 8 Jun 2005 22:59:43 +0200
Message-ID: <20050608205943.GO982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 23:00:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg7cR-0006tV-0j
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVFHVBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 17:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVFHVBr
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 17:01:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63969 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261618AbVFHU7q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:59:46 -0400
Received: (qmail 8466 invoked by uid 2001); 8 Jun 2005 20:59:43 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch tidies up the git-rev-list documentation and epoch.c, which
are in severe clash with the unwritten coding style now, and quite
unreadable.

The patch mostly wraps lines before or on the 80th column, removes
plenty of superfluous empty lines and changes comments from // to /* */.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---

Jon, since this is your stuff, could you ack the patch, please?
Thanks.

I'm sorry to send patches like this, but I think the files are really
ugly as of now, and not very readable. This should be a definite
improvement in this regard, I hope.

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -17,30 +17,45 @@ Lists commit objects in reverse chronolo
 given commit, taking ancestry relationship into account.  This is
 useful to produce human-readable log output.
 
-If *--merge-order* is specified, the commit history is decomposed into a unique sequence of minimal, non-linear
-epochs and maximal, linear epochs. Non-linear epochs are then linearised by sorting them into merge order, which 
+If *--merge-order* is specified, the commit history is decomposed into a
+unique sequence of minimal, non-linear epochs and maximal, linear epochs.
+Non-linear epochs are then linearised by sorting them into merge order, which
 is described below.
 
-Maximal, linear epochs correspond to periods of sequential development. Minimal, non-linear epochs 
-correspond to periods of divergent development followed by a converging merge. The theory of epochs is described
-in more detail at link:http://blackcubes.dyndns.org/epoch/[http://blackcubes.dyndns.org/epoch/].
-
-The merge order for a non-linear epoch is defined as a linearisation for which the following invariants are true:
-
-    1. if a commit P is reachable from commit N, commit P sorts after commit N in the linearised list.
-    2. if Pi and Pj are any two parents of a merge M (with i < j), then any commit N, such that N is reachable from Pj
-       but not reachable from Pi, sorts before all commits reachable from Pi.
-   
-Invariant 1 states that later commits appear before earlier commits they are derived from.
-
-Invariant 2 states that commits unique to "later" parents in a merge, appear before all commits from "earlier" parents of
-a merge.
-
-If *--show-breaks* is specified, each item of the list is output with a 2-character prefix consisting of one of: 
- (|), (^), (=) followed by a space. 
-Commits marked with (=) represent the boundaries of minimal, non-linear epochs and correspond either to the start of a period of divergent development or to the end of such a period. 
-Commits marked with (|) are direct parents of commits immediately preceding the marked commit in the list.
-Commits marked with (^) are not parents of the immediately preceding commit. These "breaks" represent necessary discontinuities implied by trying to represent an arbtirary DAG in a linear form.
+Maximal, linear epochs correspond to periods of sequential development.
+Minimal, non-linear epochs correspond to periods of divergent development
+followed by a converging merge. The theory of epochs is described in more
+detail at
+link:http://blackcubes.dyndns.org/epoch/[http://blackcubes.dyndns.org/epoch/].
+
+The merge order for a non-linear epoch is defined as a linearisation for which
+the following invariants are true:
+
+    1. if a commit P is reachable from commit N, commit P sorts after commit N
+       in the linearised list.
+    2. if Pi and Pj are any two parents of a merge M (with i < j), then any
+       commit N, such that N is reachable from Pj but not reachable from Pi,
+       sorts before all commits reachable from Pi.
+
+Invariant 1 states that later commits appear before earlier commits they are
+derived from.
+
+Invariant 2 states that commits unique to "later" parents in a merge, appear
+before all commits from "earlier" parents of a merge.
+
+If *--show-breaks* is specified, each item of the list is output with a
+2-character prefix consisting of one of: (|), (^), (=) followed by a space.
+
+Commits marked with (=) represent the boundaries of minimal, non-linear epochs
+and correspond either to the start of a period of divergent development or to
+the end of such a period.
+
+Commits marked with (|) are direct parents of commits immediately preceding
+the marked commit in the list.
+
+Commits marked with (^) are not parents of the immediately preceding commit.
+These "breaks" represent necessary discontinuities implied by trying to
+represent an arbtirary DAG in a linear form.
 
 *--show-breaks* is only valid if *--merge-order* is also specified.
 
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -8,9 +8,10 @@
  *
  */
 #include <stdlib.h>
-#include <openssl/bn.h>		// provides arbitrary precision integers
-				// required to accurately represent fractional 
-				//mass
+
+/* Provides arbitrary precision integers required to accurately represent
+ * fractional mass: */
+#include <openssl/bn.h>
 
 #include "cache.h"
 #include "commit.h"
@@ -125,7 +126,6 @@ static struct fraction *add(struct fract
 static int compare(struct fraction *left, struct fraction *right)
 {
 	BIGNUM a, b;
-
 	int result;
 
 	BN_init(&a);
@@ -159,7 +159,8 @@ static struct mass_counter *new_mass_cou
 	copy(&mass_counter->seen, get_zero());
 
 	if (commit->object.util) {
-		die("multiple attempts to initialize mass counter for %s\n", sha1_to_hex(commit->object.sha1));
+		die("multiple attempts to initialize mass counter for %s",
+		    sha1_to_hex(commit->object.sha1));
 	}
 
 	commit->object.util = mass_counter;
@@ -174,64 +175,59 @@ static void free_mass_counter(struct mas
 	free(counter);
 }
 
-//
-// Finds the base commit of a list of commits.
-//
-// One property of the commit being searched for is that every commit reachable 
-// from the base commit is reachable from the commits in the starting list only 
-// via paths that include the base commit.
-//
-// This algorithm uses a conservation of mass approach to find the base commit.
-//
-// We start by injecting one unit of mass into the graph at each
-// of the commits in the starting list. Injecting mass into a commit
-// is achieved by adding to its pending mass counter and, if it is not already
-// enqueued, enqueuing the commit in a list of pending commits, in latest 
-// commit date first order.
-//
-// The algorithm then preceeds to visit each commit in the pending queue.
-// Upon each visit, the pending mass is added to the mass already seen for that 
-// commit and then divided into N equal portions, where N is the number of 
-// parents of the commit being visited. The divided portions are then injected 
-// into each of the parents.
-//
-// The algorithm continues until we discover a commit which has seen all the
-// mass originally injected or until we run out of things to do. 
-//
-// If we find a commit that has seen all the original mass, we have found
-// the common base of all the commits in the starting list. 
-//
-// The algorithm does _not_ depend on accurate timestamps for correct operation.
-// However, reasonably sane (e.g. non-random) timestamps are required in order 
-// to prevent an exponential performance characteristic. The occasional 
-// timestamp inaccuracy will not dramatically affect performance but may 
-// result in more nodes being processed than strictly necessary.
-//
-// This procedure sets *boundary to the address of the base commit. It returns 
-// non-zero if, and only if, there was a problem parsing one of the 
-// commits discovered during the traversal.
-//
+/*
+ * Finds the base commit of a list of commits.
+ *
+ * One property of the commit being searched for is that every commit reachable
+ * from the base commit is reachable from the commits in the starting list only
+ * via paths that include the base commit.
+ *
+ * This algorithm uses a conservation of mass approach to find the base commit.
+ *
+ * We start by injecting one unit of mass into the graph at each
+ * of the commits in the starting list. Injecting mass into a commit
+ * is achieved by adding to its pending mass counter and, if it is not already
+ * enqueued, enqueuing the commit in a list of pending commits, in latest
+ * commit date first order.
+ *
+ * The algorithm then preceeds to visit each commit in the pending queue.
+ * Upon each visit, the pending mass is added to the mass already seen for that
+ * commit and then divided into N equal portions, where N is the number of
+ * parents of the commit being visited. The divided portions are then injected
+ * into each of the parents.
+ *
+ * The algorithm continues until we discover a commit which has seen all the
+ * mass originally injected or until we run out of things to do.
+ *
+ * If we find a commit that has seen all the original mass, we have found
+ * the common base of all the commits in the starting list.
+ *
+ * The algorithm does _not_ depend on accurate timestamps for correct operation.
+ * However, reasonably sane (e.g. non-random) timestamps are required in order
+ * to prevent an exponential performance characteristic. The occasional
+ * timestamp inaccuracy will not dramatically affect performance but may
+ * result in more nodes being processed than strictly necessary.
+ *
+ * This procedure sets *boundary to the address of the base commit. It returns
+ * non-zero if, and only if, there was a problem parsing one of the
+ * commits discovered during the traversal.
+ */
 static int find_base_for_list(struct commit_list *list, struct commit **boundary)
 {
-
 	int ret = 0;
-
 	struct commit_list *cleaner = NULL;
 	struct commit_list *pending = NULL;
-
-	*boundary = NULL;
-
 	struct fraction injected;
-
 	init_fraction(&injected);
+	*boundary = NULL;
 
 	for (; list; list = list->next) {
-
 		struct commit *item = list->item;
 
 		if (item->object.util) {
-			die("%s:%d:%s: logic error: this should not have happened - commit %s\n",
-			    __FILE__, __LINE__, __FUNCTION__, sha1_to_hex(item->object.sha1));
+			die("%s:%d:%s: logic error: this should not have happened - commit %s",
+			    __FILE__, __LINE__, __FUNCTION__,
+			    sha1_to_hex(item->object.sha1));
 		}
 
 		new_mass_counter(list->item, get_one());
@@ -242,81 +238,62 @@ static int find_base_for_list(struct com
 	}
 
 	while (!*boundary && pending && !ret) {
-
 		struct commit *latest = pop_commit(&pending);
-
 		struct mass_counter *latest_node = (struct mass_counter *) latest->object.util;
+		int num_parents;
 
 		if ((ret = parse_commit(latest)))
 			continue;
-
 		add(&latest_node->seen, &latest_node->seen, &latest_node->pending);
 
-		int num_parents = count_parents(latest);
-
+		num_parents = count_parents(latest);
 		if (num_parents) {
-
 			struct fraction distribution;
 			struct commit_list *parents;
 
 			divide(init_fraction(&distribution), &latest_node->pending, num_parents);
 
 			for (parents = latest->parents; parents; parents = parents->next) {
-
 				struct commit *parent = parents->item;
 				struct mass_counter *parent_node = (struct mass_counter *) parent->object.util;
 
 				if (!parent_node) {
-
 					parent_node = new_mass_counter(parent, &distribution);
-
 					insert_by_date(&pending, parent);
 					commit_list_insert(parent, &cleaner);
-
 				} else {
-
-					if (!compare(&parent_node->pending, get_zero())) {
+					if (!compare(&parent_node->pending, get_zero()))
 						insert_by_date(&pending, parent);
-					}
 					add(&parent_node->pending, &parent_node->pending, &distribution);
-
 				}
 			}
 
 			clear_fraction(&distribution);
-
 		}
 
-		if (!compare(&latest_node->seen, &injected)) {
+		if (!compare(&latest_node->seen, &injected))
 			*boundary = latest;
-		}
-
 		copy(&latest_node->pending, get_zero());
-
 	}
 
 	while (cleaner) {
-
 		struct commit *next = pop_commit(&cleaner);
 		free_mass_counter((struct mass_counter *) next->object.util);
 		next->object.util = NULL;
-
 	}
 
 	if (pending)
 		free_commit_list(pending);
 
 	clear_fraction(&injected);
-
 	return ret;
-
 }
 
 
-//
-// Finds the base of an minimal, non-linear epoch, headed at head, by
-// applying the find_base_for_list to a list consisting of the parents
-//
+/*
+ * Finds the base of an minimal, non-linear epoch, headed at head, by
+ * applying the find_base_for_list to a list consisting of the parents
+ */
 static int find_base(struct commit *head, struct commit **boundary)
 {
 	int ret = 0;
@@ -332,14 +309,14 @@ static int find_base(struct commit *head
 	return ret;
 }
 
-//
-// This procedure traverses to the boundary of the first epoch in the epoch
-// sequence of the epoch headed at head_of_epoch. This is either the end of
-// the maximal linear epoch or the base of a minimal non-linear epoch.
-//
-// The queue of pending nodes is sorted in reverse date order and each node
-// is currently in the queue at most once.
-//
+/*
+ * This procedure traverses to the boundary of the first epoch in the epoch
+ * sequence of the epoch headed at head_of_epoch. This is either the end of
+ * the maximal linear epoch or the base of a minimal non-linear epoch.
+ *
+ * The queue of pending nodes is sorted in reverse date order and each node
+ * is currently in the queue at most once.
+ */
 static int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
 {
 	int ret;
@@ -350,10 +327,10 @@ static int find_next_epoch_boundary(stru
 		return ret;
 
 	if (HAS_EXACTLY_ONE_PARENT(item)) {
-
-		// we are at the start of a maximimal linear epoch .. traverse to the end
-
-		// traverse to the end of a maximal linear epoch
+		/*
+		 * We are at the start of a maximimal linear epoch.
+		 * Traverse to the end.
+		 */
 		while (HAS_EXACTLY_ONE_PARENT(item) && !ret) {
 			item = item->parents->item;
 			ret = parse_commit(item);
@@ -361,35 +338,35 @@ static int find_next_epoch_boundary(stru
 		*boundary = item;
 
 	} else {
-
-		// otherwise, we are at the start of a minimal, non-linear
-		// epoch - find the common base of all parents.
-
+		/*
+		 * Otherwise, we are at the start of a minimal, non-linear
+		 * epoch - find the common base of all parents.
+		 */
 		ret = find_base(item, boundary);
-
 	}
 
 	return ret;
 }
 
-//
-// Returns non-zero if parent is known to be a parent of child.
-//
+/*
+ * Returns non-zero if parent is known to be a parent of child.
+ */
 static int is_parent_of(struct commit *parent, struct commit *child)
 {
 	struct commit_list *parents;
 	for (parents = child->parents; parents; parents = parents->next) {
-		if (!memcmp(parent->object.sha1, parents->item->object.sha1, sizeof(parents->item->object.sha1)))
+		if (!memcmp(parent->object.sha1, parents->item->object.sha1,
+		            sizeof(parents->item->object.sha1)))
 			return 1;
 	}
 	return 0;
 }
 
-//
-// Pushes an item onto the merge order stack. If the top of the stack is
-// marked as being a possible "break", we check to see whether it actually
-// is a break.
-//
+/*
+ * Pushes an item onto the merge order stack. If the top of the stack is
+ * marked as being a possible "break", we check to see whether it actually
+ * is a break.
+ */
 static void push_onto_merge_order_stack(struct commit_list **stack, struct commit *item)
 {
 	struct commit_list *top = *stack;
@@ -401,54 +378,53 @@ static void push_onto_merge_order_stack(
 	commit_list_insert(item, stack);
 }
 
-//
-// Marks all interesting, visited commits reachable from this commit
-// as uninteresting. We stop recursing when we reach the epoch boundary,
-// an unvisited node or a node that has already been marking uninteresting.
-// This doesn't actually mark all ancestors between the start node and the
-// epoch boundary uninteresting, but does ensure that they will 
-// eventually be marked uninteresting when the main sort_first_epoch 
-// traversal eventually reaches them. 
-//
+/*
+ * Marks all interesting, visited commits reachable from this commit
+ * as uninteresting. We stop recursing when we reach the epoch boundary,
+ * an unvisited node or a node that has already been marking uninteresting.
+ *
+ * This doesn't actually mark all ancestors between the start node and the
+ * epoch boundary uninteresting, but does ensure that they will eventually
+ * be marked uninteresting when the main sort_first_epoch() traversal
+ * eventually reaches them.
+ */
 static void mark_ancestors_uninteresting(struct commit *commit)
 {
 	unsigned int flags = commit->object.flags;
 	int visited = flags & VISITED;
 	int boundary = flags & BOUNDARY;
 	int uninteresting = flags & UNINTERESTING;
+	struct commit_list *next;
 
 	commit->object.flags |= UNINTERESTING;
-	if (uninteresting || boundary || !visited) {
-		return;
 
-		// we only need to recurse if
-		//      we are not on the boundary, and,
-		//      we have not already been marked uninteresting, and,
-		//      we have already been visited.
-
-		//
-		// the main sort_first_epoch traverse will 
-		// mark unreachable all uninteresting, unvisited parents 
-		// as they are visited so there is no need to duplicate
-		// that traversal here.
-		//
-		// similarly, if we are already marked uninteresting
-		// then either all ancestors have already been marked
-		// uninteresting or will be once the sort_first_epoch
-		// traverse reaches them.
-		//
-	}
+	/*
+	 * We only need to recurse if
+	 *      we are not on the boundary and
+	 *      we have not already been marked uninteresting and
+	 *      we have already been visited.
+	 *
+	 * The main sort_first_epoch traverse will mark unreachable
+	 * all uninteresting, unvisited parents as they are visited
+	 * so there is no need to duplicate that traversal here.
+	 *
+	 * Similarly, if we are already marked uninteresting
+	 * then either all ancestors have already been marked
+	 * uninteresting or will be once the sort_first_epoch
+	 * traverse reaches them.
+	 */
 
-	struct commit_list *next;
+	if (uninteresting || boundary || !visited)
+		return;
 
 	for (next = commit->parents; next; next = next->next)
 		mark_ancestors_uninteresting(next->item);
 }
 
-//
-// Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
-// into merge order.
-//
+/*
+ * Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
+ * into merge order.
+ */
 static void sort_first_epoch(struct commit *head, struct commit_list **stack)
 {
 	struct commit_list *parents;
@@ -456,63 +432,59 @@ static void sort_first_epoch(struct comm
 
 	head->object.flags |= VISITED;
 
-	//
-	// parse_commit builds the parent list in reverse order with respect to the order of
-	// the git-commit-tree arguments.
-	//
-	// so we need to reverse this list to output the oldest (or most "local") commits last.
-	//
-
+	/*
+	 * parse_commit() builds the parent list in reverse order with respect
+	 * to the order of the git-commit-tree arguments. So we need to reverse
+	 * this list to output the oldest (or most "local") commits last.
+	 */
 	for (parents = head->parents; parents; parents = parents->next)
 		commit_list_insert(parents->item, &reversed_parents);
 
-	//
-	// todo: by sorting the parents in a different order, we can alter the 
-	// merge order to show contemporaneous changes in parallel branches
-	// occurring after "local" changes. This is useful for a developer
-	// when a developer wants to see all changes that were incorporated
-	// into the same merge as her own changes occur after her own
-	// changes.
-	//
+	/*
+	 * TODO: By sorting the parents in a different order, we can alter the
+	 * merge order to show contemporaneous changes in parallel branches
+	 * occurring after "local" changes. This is useful for a developer
+	 * when a developer wants to see all changes that were incorporated
+	 * into the same merge as her own changes occur after her own
+	 * changes.
+	 */
 
 	while (reversed_parents) {
-
 		struct commit *parent = pop_commit(&reversed_parents);
 
 		if (head->object.flags & UNINTERESTING) {
-			// propagates the uninteresting bit to
-			// all parents. if we have already visited
-			// this parent, then the uninteresting bit
-			// will be propagated to each reachable 
-			// commit that is still not marked uninteresting
-			// and won't otherwise be reached.
+			/*
+			 * Propagates the uninteresting bit to all parents.
+			 * if we have already visited this parent, then
+			 * the uninteresting bit will be propagated to each
+			 * reachable commit that is still not marked
+			 * uninteresting and won't otherwise be reached.
+			 */
 			mark_ancestors_uninteresting(parent);
 		}
 
 		if (!(parent->object.flags & VISITED)) {
 			if (parent->object.flags & BOUNDARY) {
-
 				if (*stack) {
-					die("something else is on the stack - %s\n", sha1_to_hex((*stack)->item->object.sha1));
+					die("something else is on the stack - %s",
+					    sha1_to_hex((*stack)->item->object.sha1));
 				}
-
 				push_onto_merge_order_stack(stack, parent);
 				parent->object.flags |= VISITED;
 
 			} else {
-
 				sort_first_epoch(parent, stack);
-
 				if (reversed_parents) {
-					//
-					// this indicates a possible discontinuity
-					// it may not be be actual discontinuity if
-					// the head of parent N happens to be the tail
-					// of parent N+1
-					//
-					// the next push onto the stack will resolve the 
-					// question
-					//
+					/*
+					 * This indicates a possible
+					 * discontinuity it may not be be
+					 * actual discontinuity if the head
+					 * of parent N happens to be the tail
+					 * of parent N+1.
+					 *
+					 * The next push onto the stack will
+					 * resolve the question.
+					 */
 					(*stack)->item->object.flags |= DISCONTINUITY;
 				}
 			}
@@ -522,27 +494,23 @@ static void sort_first_epoch(struct comm
 	push_onto_merge_order_stack(stack, head);
 }
 
-//
-// Emit the contents of the stack. 
-//
-// The stack is freed and replaced by NULL.
-//
-// Sets the return value to STOP if no further output should be generated.
-//
+/*
+ * Emit the contents of the stack.
+ *
+ * The stack is freed and replaced by NULL.
+ *
+ * Sets the return value to STOP if no further output should be generated.
+ */
 static int emit_stack(struct commit_list **stack, emitter_func emitter)
 {
 	unsigned int seen = 0;
 	int action = CONTINUE;
 
 	while (*stack && (action != STOP)) {
-
 		struct commit *next = pop_commit(stack);
-
 		seen |= next->object.flags;
-
-		if (*stack) {
+		if (*stack)
 			action = (*emitter) (next);
-		}
 	}
 
 	if (*stack) {
@@ -553,13 +521,13 @@ static int emit_stack(struct commit_list
 	return (action == STOP || (seen & UNINTERESTING)) ? STOP : CONTINUE;
 }
 
-//
-// Sorts an arbitrary epoch into merge order by sorting each epoch
-// of its epoch sequence into order.
-//
-// Note: this algorithm currently leaves traces of its execution in the
-// object flags of nodes it discovers. This should probably be fixed.
-//
+/*
+ * Sorts an arbitrary epoch into merge order by sorting each epoch
+ * of its epoch sequence into order.
+ *
+ * Note: this algorithm currently leaves traces of its execution in the
+ * object flags of nodes it discovers. This should probably be fixed.
+ */
 static int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter)
 {
 	struct commit *next = head_of_epoch;
@@ -569,29 +537,24 @@ static int sort_in_merge_order(struct co
 	ret = parse_commit(head_of_epoch);
 
 	while (next && next->parents && !ret && (action != STOP)) {
-
 		struct commit *base = NULL;
 
-		if ((ret = find_next_epoch_boundary(next, &base)))
+		ret = find_next_epoch_boundary(next, &base);
+		if (ret)
 			return ret;
-
 		next->object.flags |= BOUNDARY;
-		if (base) {
+		if (base)
 			base->object.flags |= BOUNDARY;
-		}
 
 		if (HAS_EXACTLY_ONE_PARENT(next)) {
-
 			while (HAS_EXACTLY_ONE_PARENT(next)
 			       && (action != STOP)
 			       && !ret) {
-
 				if (next->object.flags & UNINTERESTING) {
 					action = STOP;
 				} else {
 					action = (*emitter) (next);
 				}
-
 				if (action != STOP) {
 					next = next->parents->item;
 					ret = parse_commit(next);
@@ -599,14 +562,11 @@ static int sort_in_merge_order(struct co
 			}
 
 		} else {
-
 			struct commit_list *stack = NULL;
 			sort_first_epoch(next, &stack);
 			action = emit_stack(&stack, emitter);
 			next = base;
-
 		}
-
 	}
 
 	if (next && (action != STOP) && !ret) {
@@ -616,29 +576,27 @@ static int sort_in_merge_order(struct co
 	return ret;
 }
 
-//
-// Sorts the nodes reachable from a starting list in merge order, we 
-// first find the base for the starting list and then sort all nodes in this 
-// subgraph using the sort_first_epoch algorithm. Once we have reached the base
-// we can continue sorting using sort_in_merge_order.
-//
+/*
+ * Sorts the nodes reachable from a starting list in merge order, we
+ * first find the base for the starting list and then sort all nodes
+ * in this subgraph using the sort_first_epoch algorithm. Once we have
+ * reached the base we can continue sorting using sort_in_merge_order.
+ */
 int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter)
 {
 	struct commit_list *stack = NULL;
 	struct commit *base;
-
 	int ret = 0;
 	int action = CONTINUE;
-
 	struct commit_list *reversed = NULL;
 
 	for (; list; list = list->next) {
-
 		struct commit *next = list->item;
 
 		if (!(next->object.flags & UNINTERESTING)) {
 			if (next->object.flags & DUPCHECK) {
-				fprintf(stderr, "%s: duplicate commit %s ignored\n", __FUNCTION__, sha1_to_hex(next->object.sha1));
+				fprintf(stderr, "%s: duplicate commit %s ignored\n",
+					__FUNCTION__, sha1_to_hex(next->object.sha1));
 			} else {
 				next->object.flags |= DUPCHECK;
 				commit_list_insert(list->item, &reversed);
@@ -647,36 +605,35 @@ int sort_list_in_merge_order(struct comm
 	}
 
 	if (!reversed->next) {
-
-		// if there is only one element in the list, we can sort it using 
-		// sort_in_merge_order.
-
+		/*
+		 * If there is only one element in the list, we can sort it
+		 * using sort_in_merge_order.
+		 */
 		base = reversed->item;
-
 	} else {
-
-		// otherwise, we search for the base of the list
-
-		if ((ret = find_base_for_list(reversed, &base)))
+		/*
+		 * Otherwise, we search for the base of the list.
+		 */
+		ret = find_base_for_list(reversed, &base);
+		if (ret)
 			return ret;
-
-		if (base) {
+		if (base)
 			base->object.flags |= BOUNDARY;
-		}
 
 		while (reversed) {
 			sort_first_epoch(pop_commit(&reversed), &stack);
 			if (reversed) {
-				//
-				// if we have more commits to push, then the
-				// first push for the next parent may (or may not)
-				// represent a discontinuity with respect to the
-				// parent currently on the top of the stack.
-				//
-				// mark it for checking here, and check it
-				// with the next push...see sort_first_epoch for
-				// more details.
-				//
+				/*
+				 * If we have more commits to push, then the
+				 * first push for the next parent may (or may
+				 * not) represent a discontinuity with respect
+				 * to the parent currently on the top of
+				 * the stack.
+				 *
+				 * Mark it for checking here, and check it
+				 * with the next push. See sort_first_epoch()
+				 * for more details.
+				 */
 				stack->item->object.flags |= DISCONTINUITY;
 			}
 		}
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -214,17 +214,13 @@ int main(int argc, char **argv)
 		usage(rev_list_usage);
 
 	if (!merge_order) {		
-	
-	        if (limited) 
+	        if (limited)
 			list = limit_list(list);
 		show_commit_list(list);
-			
 	} else {
-		
 		if (sort_list_in_merge_order(list, &process_commit)) {
 			  die("merge order sort failed\n");
 		}
-					
 	}
 
 	return 0;
