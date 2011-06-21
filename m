From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/13] revert: Rename no_replay to record_origin
Date: Tue, 21 Jun 2011 13:04:42 +0000
Message-ID: <1308661489-20080-7-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e6-00065X-TD
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab1FUNFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475Ab1FUNFE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:04 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so1674206vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QF5tQzSsqrKV3BwDe7BHv9i/Btm5v0Q1EpoiSxOJnas=;
        b=KdVVdscxiHfKs4pKnIc79Lu3+4sM8MAEMPGfWy/bLrIeVL5qJ9dxnJBqu/Culo/cq/
         fxSW/zJ8hMYOZPvIxElo16uoINyfOPuqjlkK6bJvB79lBTuredFQwTxgRXAlXCU8iB9q
         jPks03oqg+8Q2NeuiAvNyoPVhAXC4+S4rGKCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RQMbKoq3WRMRrSHkS4K0/7Pn7TU7+yZIYFDm2xF0hLoReVC6tcmfKn9usvW3MhlyAm
         ez4lPTKy0FkdxOoDydN7ucY44yXCe+OLFg58dZ4/C18QAW+i7qHFAgHv/QvK6cMJj8Ww
         PP9brmjM9WSgwvb0cmoSBivTfXatD8duzmKyw=
Received: by 10.52.94.50 with SMTP id cz18mr5219725vdb.299.1308661504004;
        Tue, 21 Jun 2011 06:05:04 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176145>

Give the variable "no_replay" a new name "record_origin", so that
there is no confusion when a "replay" structure is introduced later in
the series.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1b04b3c..cf62f93 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -35,7 +35,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
+static int edit, record_origin, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static int commit_argc;
 static const char **commit_argv;
@@ -90,7 +90,7 @@ static void parse_args(int argc, const char **argv)
 
 	if (action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
+			OPT_BOOLEAN('x', NULL, &record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
@@ -455,7 +455,7 @@ static int do_pick_commit(struct commit *commit)
 		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
 		strbuf_addstr(&msgbuf, p);
 
-		if (no_replay) {
+		if (record_origin) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -551,7 +551,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
 		if (no_commit)
 			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (no_replay)
+		if (record_origin)
 			die(_("cherry-pick --ff cannot be used with -x"));
 		if (edit)
 			die(_("cherry-pick --ff cannot be used with --edit"));
-- 
1.7.5.GIT
