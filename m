From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Introduce a hook to run after formatting patches
Date: Fri, 14 Nov 2014 16:47:40 -0800
Message-ID: <1416012460-4459-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 01:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpRWn-0006DV-LA
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 01:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934338AbaKOArp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 19:47:45 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46123 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbaKOAro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 19:47:44 -0500
Received: by mail-ie0-f182.google.com with SMTP id rd18so19002964iec.27
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 16:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wmpmDRBJlb5UEpZG2SkgFsuVJGOTgYj0aQmiSoaPgAA=;
        b=cvVWCKBwWfDHxNDfFURhZWDsNS787V07Zitj2z28MTp1NNcXOYAyJiB2ON5LoOEOhc
         1w6anlnYuLXgshh4j4MMcWCgnRFkgEFyI2D69RVhWVFg3hhP05NTNwtXtZTRDt1I8A2U
         sQo1zNQA2HVNN2+2Sm9RUyXi/EfP+j6kkm+IP90XWi4KVxKxBsLblLNVeM0Eh7Oh1or9
         9vUfzcN7y0qUjURy0I93n8Y50RQYsjgeCMOEwBLbA9Hj7gM0KoXU0aKcmyrD7/gL2WX2
         97XlMBd5VwydaJ+nMj+RWofMYkJqGqQbT4E9td0y1AeEuCeHg/eqDilfTJMf07dWTS9Z
         3x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wmpmDRBJlb5UEpZG2SkgFsuVJGOTgYj0aQmiSoaPgAA=;
        b=WoHVY3TskRhgKMHWwBkBpyHyyXY9X13xDMBoMIYZI1eOAa6MAv9+PGg13vmO29iG3c
         XV9oZTooXZ0gf79GNgUTOJ3Kkjpi3xahVo4UqtT09gfdgqTOSpPIuyvfqIyssmlGQZGg
         rnzooqs1hJ08L8qobg80nMoLFDEiYqkYcXS4+F1ptIH/9H9oA1kmvhWFHOvgCuxdaqSL
         xLTHZ7RqFJ/uzxcvyxrO+zFfbbhPESaJeh8ZWgylf7L4+q+oCpe7kAtokPdZEAjbfj0Z
         TIGJO9+4OGFcvkeyqXO5UDqV1WBTAVR9xM5KSCcIt6ngWisNPkzkedNdU6bA520haAVN
         dTMw==
X-Gm-Message-State: ALoCoQkwWPnTMMuFi0CNBblvF46y2eReoUsmyD36nD/et/zVsNmqvUed4Bpk9bJF0jaIG0gV1Fwu
X-Received: by 10.43.170.134 with SMTP id nq6mr14503893icc.30.1416012464058;
        Fri, 14 Nov 2014 16:47:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b40a:35e:8323:2257])
        by mx.google.com with ESMTPSA id ig10sm2121036igb.18.2014.11.14.16.47.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 16:47:43 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.24.g562add4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comes in handy if you want to post-process formatted patches.
One examplary use case would be removing ChangeIds, which are used
in Gerrit, a program sitting on top of Git, used for tracking
different versions of a patch.

Another use case would be checking if all your commits are signed off,
or have another kind of property.

So in my case a hook like the following will help a lot.

	# Run with on formatted patches. The first argument is the filename to the patch.
	sed --in-place '/^Change-Id:/d' $1

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Hi Git people,
 I haven't sent a patch for some time now, but I intend to change that
 soon, as I'll be overtaking the transactions series from Ronnie Sahlberg.

 The patch series I intend to overtake has been reviewed on this list
 as well as https://code-review.googlesource.com/#/q/project:git
 using Gerrit. Gerrit uses Change-Ids, which I want to reliably 
 remove before sending them on the list. And for reliability 
 you better trust a machine than a human like me.

 Documentation/githooks.txt |  9 +++++++++
 builtin/log.c              | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9ef2469..b4f06a9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -69,6 +69,15 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of 'git am'.
 
+post-format-patch
+~~~~~~~~~~~~
+
+This hook is called after format-patch created a patch and it is 
+invoked with the filename of the patch as the first parameter.
+
+This hook can be used to alter the created patch, such as removing
+or adding Sign-Offs or similar information.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/log.c b/builtin/log.c
index 734aab3..863fcef 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -761,7 +761,8 @@ static const char *output_directory = NULL;
 static int outdir_offset;
 
 static int reopen_stdout(struct commit *commit, const char *subject,
-			 struct rev_info *rev, int quiet)
+			 struct rev_info *rev, int quiet,
+			 struct strbuf *choosen_filename)
 {
 	struct strbuf filename = STRBUF_INIT;
 	int suffix_len = strlen(rev->patch_suffix) + 1;
@@ -788,6 +789,11 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 	if (freopen(filename.buf, "w", stdout) == NULL)
 		return error(_("Cannot open patch file %s"), filename.buf);
 
+	if (choosen_filename) {
+		strbuf_reset(choosen_filename);
+		strbuf_addstr(choosen_filename, filename.buf);
+	}
+
 	strbuf_release(&filename);
 	return 0;
 }
@@ -921,7 +927,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	committer = git_committer_info(0);
 
 	if (!use_stdout &&
-	    reopen_stdout(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
+	    reopen_stdout(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet, NULL))
 		return;
 
 	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
@@ -1176,6 +1182,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf filename = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
 	int reroll_count = -1;
@@ -1531,7 +1538,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!use_stdout &&
-		    reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
+		    reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, quiet, &filename))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
 		free_commit_buffer(commit);
@@ -1552,8 +1559,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			else
 				print_signature();
 		}
-		if (!use_stdout)
+		if (!use_stdout) {
 			fclose(stdout);
+			run_hook_le(NULL, "post-format-patch", filename.buf, NULL);
+		}
 	}
 	free(list);
 	free(branch_name);
-- 
2.2.0.rc1.24.g562add4
