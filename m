From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3] builtin-branch: improve output when displaying remote branches
Date: Fri, 13 Feb 2009 04:40:18 -0500
Message-ID: <1234518018-94636-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902130006r4f125752wa207056d72630e84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	j.sixt@viscovery.net, madduck@madduck.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 10:41:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXuYU-0001TV-Bo
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 10:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbZBMJkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 04:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZBMJkY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 04:40:24 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:59113 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZBMJkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 04:40:23 -0500
Received: by an-out-0708.google.com with SMTP id c2so630702anc.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 01:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9H9tTUZr+sd8kEw3df2wpvTIE7zWutzvRMumWxYGn6E=;
        b=Z+vnFSglx+rG8ho+auQfUKp8Di/PqFYztyX+he/B6KRUMFfVzH5ooI+87liEjVvndk
         WNUPeyhPv/TZkYvbqdMoiR+AAKcNbEzDPVru8cRIGWx+ribOFni7WPzGcD7W2lw9UBph
         3XgWJGIyNm8LjOnDVo5Ly4ZoIf5/k20HxvYkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E6IEjMbMix846cKE/b71fzRkX0ZiHK7ArYlCSPHSFx0DZgKbZUL3cLnEJALJpH+d1G
         goCFRxVU1w6iIToS0yy29DV/BtCZMP80ekCWToU2tFLI7m+7q36lcwA5VV4unXctpEPJ
         NTiKm3fVDV6CUoTUbK0IW++ql+sVjsXOUegXA=
Received: by 10.100.32.6 with SMTP id f6mr2510243anf.90.1234518021956;
        Fri, 13 Feb 2009 01:40:21 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d21sm1992433and.46.2009.02.13.01.40.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 01:40:21 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
In-Reply-To: <76718490902130006r4f125752wa207056d72630e84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109735>

When encountering a symref (typically refs/remotes/<remote>/HEAD),
display the ref target.

When displaying local and remote branches, prefix the remote branch
names with "remotes/" to make the remote branches clear from the local
branches. If displaying only the remote branches, the prefix is not
shown since it would be redundant.

Sample output:

$ git branch
  foo -> master
* master
  rather-long-branch-name

$ git branch -v
  foo                     -> master
* master                  51cecb2 initial
  rather-long-branch-name 51cecb2 initial

$ git branch -v --no-abbrev
  foo                     -> master
* master                  51cecb2dbb1a1902bb4df79b543c8f951ee59d83 initial
  rather-long-branch-name 51cecb2dbb1a1902bb4df79b543c8f951ee59d83 initial

$ git branch -r
  frotz/HEAD -> frotz/master
  frotz/master
  origin/HEAD -> origin/master
  origin/UNUSUAL -> refs/heads/master
  origin/master

$ git branch -a
  foo -> master
* master
  rather-long-branch-name
  remotes/frotz/HEAD -> frotz/master
  remotes/frotz/master
  remotes/origin/HEAD -> origin/master
  remotes/origin/UNUSUAL -> refs/heads/master
  remotes/origin/master

$ git branch -rv
  frotz/HEAD     -> frotz/master
  frotz/master   e1d8130 added file2
  origin/HEAD    -> origin/master
  origin/UNUSUAL -> refs/heads/master
  origin/master  e1d8130 added file2

$ git branch -av
  foo                     -> master
* master                  51cecb2 initial
  rather-long-branch-name 51cecb2 initial
  remotes/frotz/HEAD      -> frotz/master
  remotes/frotz/master    e1d8130 added file2
  remotes/origin/HEAD     -> origin/master
  remotes/origin/UNUSUAL  -> refs/heads/master
  remotes/origin/master   e1d8130 added file2

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Improvements since v2 - http://thread.gmane.org/gmane.comp.version-control.git/109200/focus=109706

 * Moved the sample output into the commit message as suggested by Hannes

 * Refactored an if statement into a loop as suggested by Junio. This adds more
   LOC of now, but hopefully it will pay off in the future as git branch learns
   to emit other branch types than local and remote.

   I personally disagree w/doing this now as there are other places that will
   need to be touched to handle a third (or more) branch type. I think at the
   time the next branch type is added, that is when to look for this type of
   refactoring. Right now it seems like needless churn to me.

   With that off my chest, I will defer to the maintainer. :-)

 * Junio delicately pointed out that I was an idiot :-) :-) :-) to call
   prefixcmp(), just to call skip_prefix() immediately afterward. I think I did
   better job this time.

 builtin-branch.c |  105 ++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 56a1971..7607f6a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -181,7 +181,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 
 struct ref_item {
 	char *name;
-	unsigned int kind;
+	char *dest;
+	unsigned int kind, len;
 	struct commit *commit;
 };
 
@@ -193,22 +194,47 @@ struct ref_list {
 	int kinds;
 };
 
+static char *resolve_symref(const char *src, const char *prefix)
+{
+	unsigned char sha1[20];
+	int flag;
+	const char *dst, *cp;
+
+	dst = resolve_ref(src, sha1, 0, &flag);
+	if (!(dst && (flag & REF_ISSYMREF)))
+		return NULL;
+	if (prefix && (cp = skip_prefix(dst, prefix)))
+		dst = cp;
+	return xstrdup(dst);
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
 	struct commit *commit;
-	int kind;
-	int len;
+	int kind, i;
+	const char *prefix, *orig_refname = refname;
+
+	static struct {
+		int kind;
+		const char *prefix;
+		int pfxlen;
+	} ref_kind[] = {
+		{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
+		{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
+	};
 
 	/* Detect kind */
-	if (!prefixcmp(refname, "refs/heads/")) {
-		kind = REF_LOCAL_BRANCH;
-		refname += 11;
-	} else if (!prefixcmp(refname, "refs/remotes/")) {
-		kind = REF_REMOTE_BRANCH;
-		refname += 13;
-	} else
+	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
+		prefix = ref_kind[i].prefix;
+		if (strncmp(refname, prefix, ref_kind[i].pfxlen))
+			continue;
+		kind = ref_kind[i].kind;
+		refname += ref_kind[i].pfxlen;
+		break;
+	}
+	if (ARRAY_SIZE(ref_kind) <= i)
 		return 0;
 
 	commit = lookup_commit_reference_gently(sha1, 1);
@@ -239,9 +265,14 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	newitem->name = xstrdup(refname);
 	newitem->kind = kind;
 	newitem->commit = commit;
-	len = strlen(newitem->name);
-	if (len > ref_list->maxwidth)
-		ref_list->maxwidth = len;
+	newitem->len = strlen(refname);
+	newitem->dest = resolve_symref(orig_refname, prefix);
+	/* adjust for "remotes/" */
+	if (newitem->kind == REF_REMOTE_BRANCH &&
+	    ref_list->kinds != REF_REMOTE_BRANCH)
+		newitem->len += 8;
+	if (newitem->len > ref_list->maxwidth)
+		ref_list->maxwidth = newitem->len;
 
 	return 0;
 }
@@ -250,8 +281,10 @@ static void free_ref_list(struct ref_list *ref_list)
 {
 	int i;
 
-	for (i = 0; i < ref_list->index; i++)
+	for (i = 0; i < ref_list->index; i++) {
 		free(ref_list->list[i].name);
+		free(ref_list->list[i].dest);
+	}
 	free(ref_list->list);
 }
 
@@ -292,11 +325,12 @@ static int matches_merge_filter(struct commit *commit)
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current)
+			   int abbrev, int current, char *prefix)
 {
 	char c;
 	int color;
 	struct commit *commit = item->commit;
+	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 
 	if (!matches_merge_filter(commit))
 		return;
@@ -319,7 +353,18 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = COLOR_BRANCH_CURRENT;
 	}
 
-	if (verbose) {
+	strbuf_addf(&name, "%s%s", prefix, item->name);
+	if (verbose)
+		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
+			    maxwidth, name.buf,
+			    branch_get_color(COLOR_BRANCH_RESET));
+	else
+		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
+			    name.buf, branch_get_color(COLOR_BRANCH_RESET));
+
+	if (item->dest)
+		strbuf_addf(&out, " -> %s", item->dest);
+	else if (verbose) {
 		struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
 		const char *sub = " **** invalid ref ****";
 
@@ -333,28 +378,25 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		if (item->kind == REF_LOCAL_BRANCH)
 			fill_tracking_info(&stat, item->name);
 
-		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
-		       maxwidth, item->name,
-		       branch_get_color(COLOR_BRANCH_RESET),
-		       find_unique_abbrev(item->commit->object.sha1, abbrev),
-		       stat.buf, sub);
+		strbuf_addf(&out, " %s %s%s",
+			find_unique_abbrev(item->commit->object.sha1, abbrev),
+			stat.buf, sub);
 		strbuf_release(&stat);
 		strbuf_release(&subject);
-	} else {
-		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
-		       branch_get_color(COLOR_BRANCH_RESET));
 	}
+	printf("%s\n", out.buf);
+	strbuf_release(&name);
+	strbuf_release(&out);
 }
 
 static int calc_maxwidth(struct ref_list *refs)
 {
-	int i, l, w = 0;
+	int i, w = 0;
 	for (i = 0; i < refs->index; i++) {
 		if (!matches_merge_filter(refs->list[i].commit))
 			continue;
-		l = strlen(refs->list[i].name);
-		if (l > w)
-			w = l;
+		if (refs->list[i].len > w)
+			w = refs->list[i].len;
 	}
 	return w;
 }
@@ -394,7 +436,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		item.commit = head_commit;
 		if (strlen(item.name) > ref_list.maxwidth)
 			ref_list.maxwidth = strlen(item.name);
-		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1, "");
 		free(item.name);
 	}
 
@@ -402,8 +444,11 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
+		char *prefix = (kinds != REF_REMOTE_BRANCH &&
+				ref_list.list[i].kind == REF_REMOTE_BRANCH)
+				? "remotes/" : "";
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
-			       abbrev, current);
+			       abbrev, current, prefix);
 	}
 
 	free_ref_list(&ref_list);
-- 
1.6.2.rc0.209.g7c178
