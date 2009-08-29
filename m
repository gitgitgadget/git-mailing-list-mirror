From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Sat, 29 Aug 2009 15:34:45 -0700
Message-ID: <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 00:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhWWZ-0003n1-Pd
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 00:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZH2Wft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbZH2Wft
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 18:35:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbZH2Wex (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 18:34:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 650563B8B7;
	Sat, 29 Aug 2009 18:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUZtV9DX30DSoy+aEaaez8OUSEo=; b=rYvprN
	JJ5a2pPXhIz0Ukv5LIaSwlXLnRiWn9Xrndg8gAw60xegGNqojJOJxBvy8+DIU++R
	v1iTxvHKbFkGK/W3j2fBC0yXAiI0y/CoJSR9VqeeMcw4vRQBT+Wm0U9YHwK0++3o
	keaEjcCDSU/j/NxCOHdF8G+YhYgrgzKqWeDOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H46Ken16IjLqaLWnhFtHzINWrN1hsZGk
	OWAGl9sHmXYtJW+wG3w0R+ut3ybW3SXGAZcDvSC+Q8zRgAvgEMfbbiFJzOhHICOz
	+l+pJyYMUO6gVymiB44csKsLZaXIHGkLxFXOFWSNEoGVZ0MlUINdlxPet47Tl2cq
	QqTzpdt4jhc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 371AB3B8B5;
	Sat, 29 Aug 2009 18:34:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D07493B8B3; Sat, 29 Aug 2009
 18:34:46 -0400 (EDT)
In-Reply-To: <20090828190531.GB11488@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 28 Aug 2009 15\:05\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2AF6B96E-94EC-11DE-9D74-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127386>

Jeff King <peff@peff.net> writes:

>   - inserted as blank files, then you may be a bit surprised by the fact
>     that it looks like you added a blank version, but at least you will
>     still see a diff against the working tree file, alerting you to the
>     fact that maybe they weren't entirely ready for commit.
>
> So I think of the three, the last one is the least surprising. The other
> option is to die and force the user to resolve the issue, which is what
> we do now. It does actually tell you the problem "bar: not added yet",
> though we could perhaps improve on that message a bit.

I am slightly in favor of leaving the things as they are, as the error
message is quite clear.

The third option would probably loo like this, which is not too bad,
though.

 builtin-commit.c       |    2 +-
 builtin-write-tree.c   |    3 +++
 cache-tree.c           |   29 ++++++++++++++---------------
 cache-tree.h           |    4 +++-
 git-stash.sh           |    2 +-
 merge-recursive.c      |    2 +-
 test-dump-cache-tree.c |    2 +-
 7 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..fc97d54 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -595,7 +595,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
 	if (cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0) {
+			      active_cache, active_nr, 0) < 0) {
 		error("Error building trees");
 		return 0;
 	}
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index b223af4..6fce25e 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -23,6 +23,9 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	struct option write_tree_options[] = {
 		OPT_BIT(0, "missing-ok", &flags, "allow missing objects",
 			WRITE_TREE_MISSING_OK),
+		OPT_BIT(0, "intent-as-empty", &flags,
+			"write intent-to-add entries as empty blobs",
+			WRITE_TREE_ADD_INTENT_AS_EMPTY),
 		{ OPTION_STRING, 0, "prefix", &prefix, "<prefix>/",
 		  "write tree object for a subdirectory <prefix>" ,
 		  PARSE_OPT_LITERAL_ARGHELP },
diff --git a/cache-tree.c b/cache-tree.c
index d917437..7377066 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -148,7 +148,7 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
 }
 
 static int verify_cache(struct cache_entry **cache,
-			int entries)
+			int entries, int flags)
 {
 	int i, funny;
 
@@ -156,7 +156,9 @@ static int verify_cache(struct cache_entry **cache,
 	funny = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
-		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
+		if (ce_stage(ce) ||
+		    (!(flags & WRITE_TREE_ADD_INTENT_AS_EMPTY) &&
+		     (ce->ce_flags & CE_INTENT_TO_ADD))) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
@@ -237,8 +239,7 @@ static int update_one(struct cache_tree *it,
 		      int entries,
 		      const char *base,
 		      int baselen,
-		      int missing_ok,
-		      int dryrun)
+		      int flags)
 {
 	struct strbuf buffer;
 	int i;
@@ -284,8 +285,7 @@ static int update_one(struct cache_tree *it,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
-				    missing_ok,
-				    dryrun);
+				    flags);
 		if (subcnt < 0)
 			return subcnt;
 		i += subcnt - 1;
@@ -328,7 +328,9 @@ static int update_one(struct cache_tree *it,
 			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
+		if (mode != S_IFGITLINK &&
+		    !(flags & WRITE_TREE_MISSING_OK) &&
+		    !has_sha1_file(sha1))
 			return error("invalid object %06o %s for '%.*s'",
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 
@@ -345,7 +347,7 @@ static int update_one(struct cache_tree *it,
 #endif
 	}
 
-	if (dryrun)
+	if (flags & WRITE_TREE_DRY_RUN)
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
 	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
 		strbuf_release(&buffer);
@@ -365,14 +367,13 @@ static int update_one(struct cache_tree *it,
 int cache_tree_update(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
-		      int missing_ok,
-		      int dryrun)
+		      int flags)
 {
 	int i;
-	i = verify_cache(cache, entries);
+	i = verify_cache(cache, entries, flags);
 	if (i)
 		return i;
-	i = update_one(it, cache, entries, "", 0, missing_ok, dryrun);
+	i = update_one(it, cache, entries, "", 0, flags);
 	if (i < 0)
 		return i;
 	return 0;
@@ -565,11 +566,9 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 
 	was_valid = cache_tree_fully_valid(active_cache_tree);
 	if (!was_valid) {
-		int missing_ok = flags & WRITE_TREE_MISSING_OK;
-
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
-				      missing_ok, 0) < 0)
+				      flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <= newfd) {
 			if (!write_cache(newfd, active_cache, active_nr) &&
diff --git a/cache-tree.h b/cache-tree.h
index 3df641f..4ee03bb 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,11 +29,13 @@ void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int);
+int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int);
 
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
+#define WRITE_TREE_ADD_INTENT_AS_EMPTY 4
+#define WRITE_TREE_DRY_RUN 8
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/git-stash.sh b/git-stash.sh
index d61c9d0..735e511 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -63,7 +63,7 @@ create_stash () {
 	msg=$(printf '%s: %s' "$branch" "$head")
 
 	# state of the index
-	i_tree=$(git write-tree) &&
+	i_tree=$(git write-tree --intent-as-empty) &&
 	i_commit=$(printf 'index on %s\n' "$msg" |
 		git commit-tree $i_tree -p $b_commit) ||
 		die "Cannot save the current index state"
diff --git a/merge-recursive.c b/merge-recursive.c
index 10d7913..dea5400 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -211,7 +211,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0)
+			      active_cache, active_nr, 0) < 0)
 		die("error building trees");
 
 	result = lookup_tree(active_cache_tree->sha1);
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 1f73f1e..a6ffdf3 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -59,6 +59,6 @@ int main(int ac, char **av)
 	struct cache_tree *another = cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, 0, 1);
+	cache_tree_update(another, active_cache, active_nr, WRITE_TREE_DRY_RUN);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
