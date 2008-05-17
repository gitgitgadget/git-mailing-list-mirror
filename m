From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 12:03:49 -0700
Message-ID: <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
 <alpine.DEB.1.00.0805161125320.30431@racer>
 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
 <alpine.DEB.1.00.0805171102480.30431@racer>
 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Steven Walter" <stevenrwalter@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sat May 17 21:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxRiO-0005J1-AZ
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 21:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbYEQTEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 15:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbYEQTEK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 15:04:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbYEQTEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 15:04:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32CA5465C;
	Sat, 17 May 2008 15:04:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8F8EA465B; Sat, 17 May 2008 15:03:54 -0400 (EDT)
In-Reply-To: <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat, 17 May 2008 18:12:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 063B9F32-2444-11DD-A27E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82358>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Sat, May 17, 2008 at 4:44 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
>> With this dedication to backwards-compatibility, we'll be at Windows
>> Vista quality in no time.
>
> I very much agree here, given the nature of scripts (that is, being
> very easy to update), I think we should try not to be too strict in
> backwards-compatibility or we'll lose the flexibility that is very
> much needed when developing a Good Product (tm) As long as such
> compatibility breaking changes are marked (in BIG LETTERS) in the
> changelog/release notes I think that would be a 'sacrifice' we should
> consider making.

Don't feed the troll by responding to a cheap shot.

The plumbing output is sacred as it is an API.  We _could_ change it if it
is broken in such a way that it cannot convey necessary information fully,
but we just do not _reword_ for the sake of rewording.  If somebody does
not like it, s/he is complaining too late.  S/he should have been here in
early May 2005 and make the language used by the API closer to what humans
read.  S/he wasn't here.  Too bad, and it is too late.  

And people who complain should look at a bigger picture.  Look at what was
suggested by one of them and think for five seconds:

     $ git checkout mytopic
    -fatal: Entry 'frotz' not uptodate. Cannot merge.
    +fatal: Entry 'frotz' has local changes. Cannot merge.

If you do not see something wrong with this output, your brain has already
been rotten with use of git for too long a time.  Nobody asked us to
"merge" but why are we talking about "Cannot merge"?

Try a different approach along this patch instead.

    $ git-checkout pu
    error: You have local changes to 'Makefile'; cannot switch branches.

There are other places that ask unpack_trees() to n-way merge, detect
issues _and_ let it issue error message on its own, which people who
complained in this thread can identify and improve, but I did this as a
demonstration and replaced only one message.

Yes I know about C99 structure initializers.  I'd love to use them but we
try to be nice to compilers without it.

 builtin-checkout.c |    2 ++
 unpack-trees.c     |   47 +++++++++++++++++++++++++++++++++--------------
 unpack-trees.h     |    9 +++++++++
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 10ec137..83da7ca 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -236,6 +236,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
+		topts.msgs.not_uptodate_file = "You have local changes to '%s'; cannot switch branches.";
+
 		refresh_cache(REFRESH_QUIET);
 
 		if (unmerged_cache()) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 1ab28fd..bec12dc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,28 @@
 #include "progress.h"
 #include "refs.h"
 
+static struct unpack_trees_error_msgs unpack_default_errors = {
+	/* would_overwrite */
+	"Entry '%s' would be overwritten by merge. Cannot merge.",
+
+	/* not_uptodate_file */ 
+	"Entry '%s' not uptodate. Cannot merge.",
+
+	/* not_uptodate_dir */
+	"Updating '%s' would lose untracked files in it",
+
+	/* would_lose_untracked */
+	"Untracked working tree file '%s' would be %s by merge.",
+
+	/* bind_overlap */
+	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+};
+
+#define ERRORMSG(o,fld) \
+	( ((o) && (o)->msgs.fld) \
+	? ((o)->msgs.fld) \
+	: (unpack_default_errors.fld) )
+
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	unsigned int set, unsigned int clear)
 {
@@ -383,10 +405,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 /* Here come the merge functions */
 
-static int reject_merge(struct cache_entry *ce)
+static int reject_merge(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	return error("Entry '%s' would be overwritten by merge. Cannot merge.",
-		     ce->name);
+	return error(ERRORMSG(o, would_overwrite), ce->name);
 }
 
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -430,7 +451,7 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno == ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error("Entry '%s' not uptodate. Cannot merge.", ce->name);
+		error(ERRORMSG(o, not_uptodate_file), ce->name);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -517,8 +538,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
-			error("Updating '%s' would lose untracked files in it",
-			      ce->name);
+			error(ERRORMSG(o, not_uptodate_dir), ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -618,8 +638,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		}
 
 		return o->gently ? -1 :
-			error("Untracked working tree file '%s' "
-			      "would be %s by merge.", ce->name, action);
+			error(ERRORMSG(o, would_lose_untracked), ce->name, action);
 	}
 	return 0;
 }
@@ -751,7 +770,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			return o->gently ? -1 : reject_merge(index);
+			return o->gently ? -1 : reject_merge(index, o);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -759,7 +778,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head))
-		return o->gently ? -1 : reject_merge(index);
+		return o->gently ? -1 : reject_merge(index, o);
 
 	if (head) {
 		/* #5ALT, #15 */
@@ -901,11 +920,11 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		else {
 			/* all other failures */
 			if (oldtree)
-				return o->gently ? -1 : reject_merge(oldtree);
+				return o->gently ? -1 : reject_merge(oldtree, o);
 			if (current)
-				return o->gently ? -1 : reject_merge(current);
+				return o->gently ? -1 : reject_merge(current, o);
 			if (newtree)
-				return o->gently ? -1 : reject_merge(newtree);
+				return o->gently ? -1 : reject_merge(newtree, o);
 			return -1;
 		}
 	}
@@ -931,7 +950,7 @@ int bind_merge(struct cache_entry **src,
 			     o->merge_size);
 	if (a && old)
 		return o->gently ? -1 :
-			error("Entry '%s' overlaps with '%s'.  Cannot bind.", a->name, old->name);
+			error(ERRORMSG(o, bind_overlap), a->name, old->name);
 	if (!a)
 		return keep_entry(old, o);
 	else
diff --git a/unpack-trees.h b/unpack-trees.h
index d436d6c..94e5672 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -8,6 +8,14 @@ struct unpack_trees_options;
 typedef int (*merge_fn_t)(struct cache_entry **src,
 		struct unpack_trees_options *options);
 
+struct unpack_trees_error_msgs {
+	const char *would_overwrite;
+	const char *not_uptodate_file;
+	const char *not_uptodate_dir;
+	const char *would_lose_untracked;
+	const char *bind_overlap;
+};
+
 struct unpack_trees_options {
 	unsigned int reset:1,
 		     merge:1,
@@ -23,6 +31,7 @@ struct unpack_trees_options {
 	int pos;
 	struct dir_struct *dir;
 	merge_fn_t fn;
+	struct unpack_trees_error_msgs msgs;
 
 	int head_idx;
 	int merge_size;
