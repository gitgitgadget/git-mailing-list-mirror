From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be
 sha1 based
Date: Thu, 27 Mar 2014 18:24:38 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140327142438.GE17333@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
 <xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
 <20140325092215.GB3777@mini.zxlink>
 <xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
 <20140326195201.GB16002@mini.zxlink>
 <xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTBBa-0005uK-S2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbaC0OVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:21:34 -0400
Received: from forward15.mail.yandex.net ([95.108.130.119]:33249 "EHLO
	forward15.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbaC0OVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:21:31 -0400
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward15.mail.yandex.net (Yandex) with ESMTP id EC9AC9E089F;
	Thu, 27 Mar 2014 18:21:11 +0400 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
	by smtp14.mail.yandex.net (Yandex) with ESMTP id 909EF1B600D2;
	Thu, 27 Mar 2014 18:21:11 +0400 (MSK)
Received: from unknown (unknown [93.185.17.156])
	by smtp14.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xDKiUWbtfj-L9OmLkLK;
	Thu, 27 Mar 2014 18:21:09 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: b9c0988a-d8cc-4ca9-a2ca-122e6283d5ac
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395930071; bh=H5peR4ToArsNLJSHwqkF/h58E5877FyniPU6jZ2Rm6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=D1RjXbIHQU7eza2HCoCz928J1KoSxWGbufoeN8XqHAX2BSbQvksYcownIBjhNq5+k
	 geRLEaIGrdYUrHPPfEpPHC6cJ9qs+KyWako68yj+sthsiKqi9k8UlT2ZpuxXjezIsK
	 rI6Gc6j+UjoXp/1YWnLFS28Nykg1ETTMPis4tv8k=
Authentication-Results: smtp14.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WTBEU-0005Vu-EB; Thu, 27 Mar 2014 18:24:38 +0400
Content-Disposition: inline
In-Reply-To: <xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245282>

On Wed, Mar 26, 2014 at 02:34:24PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> 
> > On Tue, Mar 25, 2014 at 10:46:32AM -0700, Junio C Hamano wrote:
> >> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> >> 
> >> > What are the downsides of "__" prefix by the way?
> >> 
> >> Aren't these names reserved for compiler/runtime implementations?
> >
> > Yes, but there are precedents when people don't obey it widely and
> > in practice everything works :)
> 
> I think you are alluding to the practice in the Linux kernel, but
> their requirement is vastly different---their product do not even
> link with libc and they always compile with specific selected
> versions of gcc, no?

Yes, that is correct. Only "__" was so visually appealing that there was
a temptation to break the rules, but...


> > Let it be something portable anyway -
> > how about diff_tree_sha1_low() ?
> 
> Sure.
> 
> As this is a file-scope static, I do not think the exact naming
> matters that much.  Just FYI, we seem to use ll_ prefix (standing
> for low-level) in some places.

... let's then use this "ll_" prefix scheme for consistency.

Corrected patch is below, and I've sent corrections to follow-up
patches as well.

Thanks,
Kirill

(please keep author email)
---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 24 Feb 2014 20:21:46 +0400
Subject: [PATCH v3a] tree-diff: rework diff_tree interface to be sha1 based

In the next commit this will allow to reduce intermediate calls, when
recursing into subtrees - at that stage we know only subtree sha1, and
it is natural for tree walker to start from that phase. For now we do

    diff_tree
        show_path
            diff_tree_sha1
                diff_tree
                    ...

and the change will allow to reduce it to

    diff_tree
        show_path
            diff_tree

Also, it will allow to omit allocating strbuf for each subtree, and just
reuse the common strbuf via playing with its len.

The above-mentioned improvements go in the next 2 patches.

The downside is that try_to_follow_renames(), if active, we cause
re-reading of 2 initial trees, which was negligible based on my timings,
and which is outweighed cogently by the upsides.

NOTE To keep with the current interface and semantics, I needed to
rename the function from diff_tree() to diff_tree_sha1(). As
diff_tree_sha1() was already used, and the function we are talking here
is its more low-level helper, let's use convention for prefixing
such helpers with "ll_". So the final renaming is

    diff_tree() -> ll_diff_tree_sha1()

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v3:

 - further rename diff_tree_sha1_low() -> ll_diff_tree_sha1() to follow Git
   style for naming low-level helpers.

Changes since v2:

 - renamed __diff_tree_sha1() -> diff_tree_sha1_low() as the former
   overlaps with reserved-for-implementation identifiers namespace.

Changes since v1:

 - don't need to touch diff.h, as diff_tree() became static.


 tree-diff.c | 60 ++++++++++++++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f137f39..1d02e43 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -141,12 +141,17 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 	}
 }
 
-static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
-		     const char *base_str, struct diff_options *opt)
+static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
+			     const char *base_str, struct diff_options *opt)
 {
+	struct tree_desc t1, t2;
+	void *t1tree, *t2tree;
 	struct strbuf base;
 	int baselen = strlen(base_str);
 
+	t1tree = fill_tree_descriptor(&t1, old);
+	t2tree = fill_tree_descriptor(&t2, new);
+
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
 
@@ -159,39 +164,41 @@ static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
-			skip_uninteresting(t1, &base, opt);
-			skip_uninteresting(t2, &base, opt);
+			skip_uninteresting(&t1, &base, opt);
+			skip_uninteresting(&t2, &base, opt);
 		}
-		if (!t1->size && !t2->size)
+		if (!t1.size && !t2.size)
 			break;
 
-		cmp = tree_entry_pathcmp(t1, t2);
+		cmp = tree_entry_pathcmp(&t1, &t2);
 
 		/* t1 = t2 */
 		if (cmp == 0) {
 			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
-			    hashcmp(t1->entry.sha1, t2->entry.sha1) ||
-			    (t1->entry.mode != t2->entry.mode))
-				show_path(&base, opt, t1, t2);
+			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
+			    (t1.entry.mode != t2.entry.mode))
+				show_path(&base, opt, &t1, &t2);
 
-			update_tree_entry(t1);
-			update_tree_entry(t2);
+			update_tree_entry(&t1);
+			update_tree_entry(&t2);
 		}
 
 		/* t1 < t2 */
 		else if (cmp < 0) {
-			show_path(&base, opt, t1, /*t2=*/NULL);
-			update_tree_entry(t1);
+			show_path(&base, opt, &t1, /*t2=*/NULL);
+			update_tree_entry(&t1);
 		}
 
 		/* t1 > t2 */
 		else {
-			show_path(&base, opt, /*t1=*/NULL, t2);
-			update_tree_entry(t2);
+			show_path(&base, opt, /*t1=*/NULL, &t2);
+			update_tree_entry(&t2);
 		}
 	}
 
 	strbuf_release(&base);
+	free(t2tree);
+	free(t1tree);
 	return 0;
 }
 
@@ -206,7 +213,7 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
 
-static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -244,7 +251,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.break_opt = opt->break_opt;
 	diff_opts.rename_score = opt->rename_score;
 	diff_setup_done(&diff_opts);
-	diff_tree(t1, t2, base, &diff_opts);
+	ll_diff_tree_sha1(old, new, base, &diff_opts);
 	diffcore_std(&diff_opts);
 	free_pathspec(&diff_opts.pathspec);
 
@@ -305,23 +312,12 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	void *tree1, *tree2;
-	struct tree_desc t1, t2;
-	unsigned long size1, size2;
 	int retval;
 
-	tree1 = fill_tree_descriptor(&t1, old);
-	tree2 = fill_tree_descriptor(&t2, new);
-	size1 = t1.size;
-	size2 = t2.size;
-	retval = diff_tree(&t1, &t2, base, opt);
-	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
-		init_tree_desc(&t1, tree1, size1);
-		init_tree_desc(&t2, tree2, size2);
-		try_to_follow_renames(&t1, &t2, base, opt);
-	}
-	free(tree1);
-	free(tree2);
+	retval = ll_diff_tree_sha1(old, new, base, opt);
+	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
+		try_to_follow_renames(old, new, base, opt);
+
 	return retval;
 }
 
-- 
1.9.rc0.143.g6fd479e
