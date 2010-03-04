From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Wed, 03 Mar 2010 19:31:25 -0800
Message-ID: <7vhbowoj8y.fsf@alter.siamese.dyndns.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
 <201003010800.13996.chriscool@tuxfamily.org>
 <7v635g4ec2.fsf@alter.siamese.dyndns.org>
 <201003040306.16580.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 04 04:31:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn1n0-0001uv-CO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 04:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab0CDDbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 22:31:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953Ab0CDDbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 22:31:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C1E9E096;
	Wed,  3 Mar 2010 22:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7pg9IFu42iSL6mK8SifNnYFNIKs=; b=Pvb2i5
	7lVRUmriCSA0AHSnf9xjlDSwWN7wRQNqw8tjZHx222nq0ztnIbjWmL/1t/5nDG7I
	TYPWNFfdnULAvxj0nTAjOZteCi57cv1fdzf8SMdT+GnYhI9M9/5moxO5qSsZWGVh
	SlfhJdg9KUGMNFsVkJOOyCWzT6/Ysd8n93lN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTbFReI05TfudyV+v1A6o6eCBu8GSBTG
	q7TTMnF6lwUv1E5SjQPn4nIb/HCH/KbQUnu31JZwfLkOYqlQyQnRRU51TQFSh39z
	1/K5WLixv7hAzbY95N6XZG+aaBW4f7VpdU5BVzxVg4kWVxRdYcU4zfxcbE124IGP
	MmhyyXuXWuU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C7A9E085;
	Wed,  3 Mar 2010 22:31:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60F7B9E084; Wed,  3 Mar
 2010 22:31:27 -0500 (EST)
In-Reply-To: <201003040306.16580.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu\, 4 Mar 2010 03\:06\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 709F3A4C-273E-11DF-BD21-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141508>

Christian Couder <chriscool@tuxfamily.org> writes:

> I tried to use the checkout_fast_forward() function from builtin/merge.c but 
> unfortunately it doesn't work. It gives an error like that in the tests :
>
> error: Your local changes to 'file1' would be overwritten by merge.  Aborting.
> Please, commit your changes or stash them before you can merge.
>
> and I don't really understand why. (Though I didn't spend a lot of time on 
> this.)

Shouldn't it be something like this?  The patch is still unnecessarily
large because I wanted to share options between revert and cherry-pick
while giving --ff only to cherry-pick, but I don't understand why it needs
a nine patch series worth of code churn.



 builtin-merge.c  |    2 +-
 builtin-revert.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 cache.h          |    3 +++
 parse-options.c  |   15 +++++++++++++++
 parse-options.h  |    1 +
 5 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 3aaec7b..c043066 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -667,7 +667,7 @@ static int count_unmerged_entries(void)
 	return ret;
 }
 
-static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
+int checkout_fast_forward(const unsigned char *head, const unsigned char *remote)
 {
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
diff --git a/builtin-revert.c b/builtin-revert.c
index eff5268..bfe75c8 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "merge-recursive.h"
+#include "refs.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -35,7 +36,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff;
+static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static const char *commit_name;
@@ -60,8 +61,19 @@ static void parse_args(int argc, const char **argv)
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
+		OPT_END(),
+		OPT_END(),
 	};
 
+	if (action == CHERRY_PICK) {
+		struct option cp_extra[] = {
+			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_END(),
+		};
+		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
+			die("program error");
+	}
+
 	if (parse_options(argc, argv, NULL, options, usage_str, 0) != 1)
 		usage_with_options(usage_str, options);
 
@@ -244,6 +256,17 @@ static NORETURN void die_dirty_index(const char *me)
 	}
 }
 
+static int fast_forward_to(const unsigned char *to, const unsigned char *from)
+{
+	struct ref_lock *ref_lock;
+
+	read_cache();
+	if (checkout_fast_forward(from, to))
+		exit(1); /* the callee should have complained already */
+	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
+	return write_ref_sha1(ref_lock, to, "cherry-pick");
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -265,6 +288,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (action == REVERT && !no_replay)
 		die("revert is incompatible with replay");
 
+	if (action == CHERRY_PICK && allow_ff) {
+		if (signoff)
+			die("cherry-pick --ff cannot be used with --signoff");
+		if (no_commit)
+			die("cherry-pick --ff cannot be used with --no-commit");
+		if (no_replay)
+			die("cherry-pick --ff cannot be used with -x");
+		if (edit)
+			die("cherry-pick --ff cannot be used with --edit");
+	}
+
 	if (read_cache() < 0)
 		die("git %s: failed to read the index", me);
 	if (no_commit) {
@@ -284,8 +318,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	}
 	discard_cache();
 
-	index_fd = hold_locked_index(&index_lock, 1);
-
 	if (!commit->parents) {
 		if (action == REVERT)
 			die ("Cannot revert a root commit");
@@ -314,6 +346,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	else
 		parent = commit->parents->item;
 
+	if (action == CHERRY_PICK && allow_ff
+	    && !hashcmp(parent->object.sha1, head))
+		return fast_forward_to(commit->object.sha1, head);
+
 	if (!(message = commit->buffer))
 		die ("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
@@ -343,6 +379,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	oneline = get_oneline(message);
 
+	index_fd = hold_locked_index(&index_lock, 1);
+
 	if (action == REVERT) {
 		char *oneline_body = strchr(oneline, ' ');
 
diff --git a/cache.h b/cache.h
index d454b7e..7272160 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,4 +1040,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 
+/* builtin-merge.c */
+int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
+
 #endif /* CACHE_H */
diff --git a/parse-options.c b/parse-options.c
index c83035d..8546d85 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -659,3 +659,18 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 	*target = unset ? 2 : 1;
 	return 0;
 }
+
+int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
+{
+	int i, j;
+
+	for (i = 0; i < dst_size; i++)
+		if (dst[i].type == OPTION_END)
+			break;
+	for (j = 0; i < dst_size; i++, j++) {
+		dst[i] = src[j];
+		if (src[j].type == OPTION_END)
+			return 0;
+	}
+	return -1;
+}
diff --git a/parse-options.h b/parse-options.h
index 9429f7e..7581e93 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -187,6 +187,7 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
+extern int parse_options_concat(struct option *dst, size_t, struct option *src);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
