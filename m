From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git commit: Reformat output somewhat
Date: Tue, 30 Sep 2008 11:52:50 +0200
Message-ID: <48E1F6F2.5080302@op5.se>
References: <20080930061654.GA14584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Pieter de Bie <pdebie@ai.rug.nl>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 11:54:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkbvj-0003Hw-63
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 11:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYI3Jw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYI3Jw5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 05:52:57 -0400
Received: from mail.op5.se ([193.201.96.20]:35653 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbYI3Jw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 05:52:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 460F224B0007;
	Tue, 30 Sep 2008 11:44:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sghpikZwsQ2S; Tue, 30 Sep 2008 11:44:09 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id F0DCB24B0004;
	Tue, 30 Sep 2008 11:44:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080930061654.GA14584@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97085>

Previously, we used to print something along the lines of

	Created commit abc9056 on master: Snib the sprock

but that output was sometimes confusing, as many projects use
the "subsystem: message" style of commit subjects (just like
this commit message does). When such improvements are done on
topic-branches, it's not uncommon to name the topic-branch the
same as the subsystem, leading to output like this:

	Created commit abc9056 on i386: i386: Snib the sprock

which doesn't look very nice and can be highly confusing.
This patch alters the format so that the noise-word "commit"
is dropped except when it makes the output read better and
the commit subject is put inside parentheses. We also
emphasize the detached case so that users do not overlook it
in case the commit subject is long enough to extend to the
next line. The end result looks thusly:

	normal case
	Created abc9056 (i386: Snib the sprock) on i386

	detached head
	Created DETACHED commit abc9056 (i386: Snib the sprock)

While we're at it, we rename "initial commit" to "root-commit"
to align it with the argument to 'git log', producing this:

	initial commit
	Created root-commit abc9056 (i386: Snib the sprock) on i386

Documentation/gittutorial-2.txt is updated accordingly so that
new users recognize what they're looking at.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

According to the few entries in the discussion about showing the
branch we're on, this patch should probably go on top of next
fairly soon.

If the code-change isn't accepted, let me know and I'll fix the
documentation update to match whatever goes in builtin-commit.c.

Feel free to alter shouty-caps for detached when applying. I have
no strong opinion either way, as I never commit on detached head
anyway.

Thanks.

 Documentation/gittutorial-2.txt |   13 ++++++++-----
 builtin-commit.c                |   12 +++++-------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 6609046..8484e7a 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -32,22 +32,25 @@ Initialized empty Git repository in .git/
 $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
-Created initial commit 54196cc2703dc165cbd373a65a4dcf22d50ae7f7
+Created root-commit 54196cc (initial commit) on master
  create mode 100644 file.txt
 $ echo 'hello world!' >file.txt
 $ git commit -a -m "add emphasis"
-Created commit c4d59f390b9cfd4318117afde11d601c1085f241
+Created c4d59f3 (add emphasis) on master
 ------------------------------------------------
 
-What are the 40 digits of hex that git responded to the commit with?
+What are the 7 digits of hex that git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the git history is stored under
-such a 40-digit hex name.  That name is the SHA1 hash of the object's
+a 40-digit hex name.  That name is the SHA1 hash of the object's
 contents; among other things, this ensures that git will never store
 the same data twice (since identical data is given an identical SHA1
 name), and that the contents of a git object will never change (since
-that would change the object's name as well).
+that would change the object's name as well). The 7 char hex strings
+here are simply the abbreviation of such 40 character long strings.
+Abbreviations can be used everywhere where the 40 character strings
+can be used, so long as they are unambiguous.
 
 It is expected that the content of the commit object you created while
 following the example above generates a different SHA1 hash than
diff --git a/builtin-commit.c b/builtin-commit.c
index 161128b..f0765cc 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -884,12 +884,11 @@ static char *get_commit_format_string(void)
 	const char *head = resolve_ref("HEAD", sha, 0, NULL);
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_addstr(&buf, "format:%h");
+	/* use shouty-caps if we're on detached HEAD */
+	strbuf_addf(&buf, "format:%s", strcmp("HEAD", head) ? "" : "DETACHED commit");
+	strbuf_addstr(&buf, "%h (%s)");
 
-	/* Are we on a detached HEAD? */
-	if (!strcmp("HEAD", head))
-		strbuf_addstr(&buf, " on detached HEAD");
-	else if (!prefixcmp(head, "refs/heads/")) {
+	if (!prefixcmp(head, "refs/heads/")) {
 		const char *cp;
 		strbuf_addstr(&buf, " on ");
 		for (cp = head + 11; *cp; cp++) {
@@ -899,7 +898,6 @@ static char *get_commit_format_string(void)
 				strbuf_addch(&buf, *cp);
 		}
 	}
-	strbuf_addstr(&buf, ": %s");
 
 	return strbuf_detach(&buf, NULL);
 }
@@ -933,7 +931,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	printf("Created %scommit ", initial_commit ? "initial " : "");
+	printf("Created %s", initial_commit ? "root-commit " : "");
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
-- 
1.6.0.2.529.g37dbc.dirty
