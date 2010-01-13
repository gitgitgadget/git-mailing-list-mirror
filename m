From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Tue, 12 Jan 2010 22:57:08 -0800
Message-ID: <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
 <20100112162355.GB25092@coredump.intra.peff.net>
 <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
 <20100112182550.GA15696@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gareth Adams <gareth.adams@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUxAT-0001IC-E3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab0AMG5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978Ab0AMG5V
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:57:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab0AMG5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:57:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C56A90040;
	Wed, 13 Jan 2010 01:57:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=s6EnUvN70Qf8yrGBbxdo/Dfdjd0=; b=iBYQrU7GMb6kULsdlwVboPt
	EBiG0zit9f69mUyvOUat5Zf7ed+6Kn0yqSM6y/jB4USDBeZSnEOUoNAReVUjJuWg
	xACBSbHUe3P7vChbchx55+B4SlNdxPfUEM8UlsHt8+wtO3hrD5wKNXFtiNTU2LMa
	JTmHfEakKU8E/N4BI1Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VsA+K7itmaHRHOhrvN/MW0Dbp3LO3/2BGaYbgx/25uBteqE/Y
	OhfiaDg0Leb5WDQ+3v72sJsN59khAOKrMD+wkHg/3y49ggYfoGolpPTX/YChhrz8
	zP3BH6M5+bCk5HpfaRTbytX/sjTE5/oXuD/RDXVih0/9voaTg2HZASVW3Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA9F79003F;
	Wed, 13 Jan 2010 01:57:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9261B9003D; Wed, 13 Jan
 2010 01:57:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1A10E96-0010-11DF-97E4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136785>

Jeff King <peff@peff.net> writes:

> Ah, right. I remembered hating "%" even as I typed it, but I had
> forgotten about the followup discussion. Looking at it again, I note:
>
>   1. The last posted patch still has a misplaced free() (patch below),
>      but I think otherwise is not buggy.
>
>   2. We don't complain on "git show @{usptream}" and we probably should.
>      I remember there being some complications because the contents of
>      @{} were passed to approxidate, but I think we can get around that
>      by letting approxidate complain if _nothing_ in the date was
>      useful. So "git show @{2.weeks.and.7.hot.dogs.ago}" would still
>      work, but "git show @{totally.bogus.input}" would complain.
>
>   3. I have actually been running with Dscho's patch for the last couple
>      of months, and I don't remember using it once. So perhaps it is not
>      as useful as I might have thought. :)

I presume we are discussing this patch?

    http://article.gmane.org/gmane.comp.version-control.git/128121

I'll squash the free() fix; thanks.

I wondered why it doesn't hook into interpret_branch_name(), and instead
adds itself to the static substitute_branch_name(); it forbids the use of
the syntax from by callers of strbuf_branchname().

I agree with your point #2 above.

Regarding your point #3, I don't think the notation should be that useful
if your workflow is sane.  The original use case that triggered the
resurrection of the patch went like this:

        git fetch &&
        for local in my set of local branches
        do
                git checkout $local &&
                git merge $local@{upstream} || {
                        echo failed to merge on $local
                        break
                }
        done

and the new notation might look useful in the scenario.  But the thing is,
constantly merging with the other side, even if you haven't added anything
of value since you merged from there last time, is a bad practice to begin
with.  I added one use case that is sane _and_ will be helped by the new
notation to the rewritten version of Dscho's patch (below).

Just to refresh our memory from the old thread and make sure we are
discussing the same patch, here is what I am planning to queue.  The log
message and documentation are somewhat updated to avoid the word "track"
because it seems that everybody gets confused and starts talking different
things whenever that word is used.  For the same reason, the test script
was renamed.

In this set-up, for example:

    [remote "filfre"]
        url = ...
        fetch = +refs/heads/nitfol:refs/heads/rezrov
    [branch "frotz"]
        remote = filfre
        merge = refs/heads/nitfol

some people say rezrov tracks nitfol from filfre but Dscho's patch says
frotz tracks nitfol from filfre.  They _may_ both track, but they "track"
the other in a quite differently way, so the word has become meaningless.

I've been trying to be careful and used different words to disambiguate
whenever I had to talk about these concepts:

 - The purpose of rezrov is to keep a tab on the progress of the nitfol
   branch at the remote end.  We say rezrov is a remote tracking branch
   for nitfol from filfre.

 - On the other hand, we have branch frotz that forked from nitfol that
   came from filfre.  It builds on top of that history by occasionally
   merging with it at key points in the history.  So we say frotz builds
   on top of nitfol from filfre.  We also say nitfol at filfre is the
   upstream of frotz.

-- >8 --
Date: Thu, 10 Sep 2009 17:25:57 +0200
Subject: [PATCH] Introduce <branch>@{upstream} notation

A new notation '<branch>@{upstream}' refers to the branch <branch> is set
to build on top of.  Missing <branch> (i.e. '@{upstream}') defaults to the
current branch.

This allows you to run, for example,

	for l in list of local branches
	do
		git log --oneline --left-right $l...$l@{upstream}
	done

to inspect each of the local branches you are interested in for the
divergence from its upstream.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rev-parse.txt |    4 ++
 sha1_name.c                     |   39 ++++++++++++++++++++--
 t/t1506-rev-parse-upstream.sh   |   69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100755 t/t1506-rev-parse-upstream.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 82045a2..923b56a 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -231,6 +231,10 @@ when you run 'git-merge'.
 * The special construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
+* The suffix '@{upstream}' to a ref (short form 'ref@{u}') refers to
+  the branch the ref is set to build on top of.  Missing ref defaults
+  to the current branch.
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/sha1_name.c b/sha1_name.c
index 44bb62d..fb4e214 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "remote.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -238,9 +239,24 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
+static inline int tracked_suffix(const char *string, int len)
+{
+	const char *suffix[] = { "@{upstream}", "@{u}" };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		int suffix_len = strlen(suffix[i]);
+		if (len >= suffix_len && !memcmp(string + len - suffix_len,
+					suffix[i], suffix_len))
+			return suffix_len;
+	}
+	return 0;
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is of the form @{-<n>}.
+ * later free()ing) if the string passed in is of the form @{-<n>} or
+ * of the form <branch>@{upstream}.
  */
 static char *substitute_branch_name(const char **string, int *len)
 {
@@ -254,6 +270,21 @@ static char *substitute_branch_name(const char **string, int *len)
 		return (char *)*string;
 	}
 
+	ret = tracked_suffix(*string, *len);
+	if (ret) {
+		char *ref = xstrndup(*string, *len - ret);
+		struct branch *tracking = branch_get(*ref ? ref : NULL);
+
+		if (!tracking)
+			die ("No tracking branch found for '%s'", ref);
+		free(ref);
+		if (tracking->merge && tracking->merge[0]->dst) {
+			*string = xstrdup(tracking->merge[0]->dst);
+			*len = strlen(*string);
+			return (char *)*string;
+		}
+	}
+
 	return NULL;
 }
 
@@ -340,8 +371,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && str[len-1] == '}') {
 		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
-				reflog_len = (len-1) - (at+2);
-				len = at;
+				if (!tracked_suffix(str + at, len - at)) {
+					reflog_len = (len-1) - (at+2);
+					len = at;
+				}
 				break;
 			}
 		}
diff --git a/t/t1506-rev-parse-upstream.sh b/t/t1506-rev-parse-upstream.sh
new file mode 100755
index 0000000..5abdc13
--- /dev/null
+++ b/t/t1506-rev-parse-upstream.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='test <branch>@{upstream} syntax'
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup' '
+
+	test_commit 1 &&
+	git checkout -b side &&
+	test_commit 2 &&
+	git checkout master &&
+	git clone . clone &&
+	test_commit 3 &&
+	(cd clone &&
+	 test_commit 4 &&
+	 git branch --track my-side origin/side)
+
+'
+
+full_name () {
+	(cd clone &&
+	 git rev-parse --symbolic-full-name "$@")
+}
+
+commit_subject () {
+	(cd clone &&
+	 git show -s --pretty=format:%s "$@")
+}
+
+test_expect_success '@{upstream} resolves to correct full name' '
+	test refs/remotes/origin/master = "$(full_name @{upstream})"
+'
+
+test_expect_success '@{u} resolves to correct full name' '
+	test refs/remotes/origin/master = "$(full_name @{u})"
+'
+
+test_expect_success 'my-side@{upstream} resolves to correct full name' '
+	test refs/remotes/origin/side = "$(full_name my-side@{u})"
+'
+
+test_expect_success 'my-side@{u} resolves to correct commit' '
+	git checkout side &&
+	test_commit 5 &&
+	(cd clone && git fetch) &&
+	test 2 = "$(commit_subject my-side)" &&
+	test 5 = "$(commit_subject my-side@{u})"
+'
+
+test_expect_success 'not-tracking@{u} fails' '
+	test_must_fail full_name non-tracking@{u} &&
+	(cd clone && git checkout --no-track -b non-tracking) &&
+	test_must_fail full_name non-tracking@{u}
+'
+
+test_expect_success '<branch>@{u}@{1} resolves correctly' '
+	test_commit 6 &&
+	(cd clone && git fetch) &&
+	test 5 = $(commit_subject my-side@{u}@{1})
+'
+
+test_expect_success '@{u} without specifying branch fails on a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_must_fail git rev-parse @{u}
+'
+
+test_done
-- 
1.6.6.280.ge295b7.dirty
