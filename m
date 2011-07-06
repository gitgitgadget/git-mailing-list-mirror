From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/14] revert: Rename no_replay to record_origin
Date: Wed,  6 Jul 2011 07:54:18 +0000
Message-ID: <1309938868-2028-5-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwe-0005vT-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab1GFHyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:37 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48564 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab1GFHyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:36 -0400
Received: by mail-qy0-f174.google.com with SMTP id 29so1924487qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G37NwFjDMsvrblG3IXgn/8h4XsV3chDVy72CAz2zs2A=;
        b=QSG4TGdN7q2r9GCoDA6CaLaYEm3yoCqdXqlmEJc37ZgEcikKpmuF81HqXNU8lGO4zR
         q1cVe5UzkJEC2H20BDQ0LQfBBsz1NuYrqc49ftqqyFjTjPgZFT+0RC0IhLnSGY1lKp2m
         1PcSeh+gwb5yi9czxXVjyM3lKS93JXqyvP9yE=
Received: by 10.224.182.212 with SMTP id cd20mr6660303qab.263.1309938875692;
        Wed, 06 Jul 2011 00:54:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176650>

Rename the variable corresponding to the "-x" command-line option from
"no_replay" to a more apt "record_origin".

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a6b51b1..1612911 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -35,7 +35,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
+static int edit, record_origin, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static int commit_argc;
@@ -91,7 +91,7 @@ static void parse_args(int argc, const char **argv)
 
 	if (action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
+			OPT_BOOLEAN('x', NULL, &record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
@@ -465,7 +465,7 @@ static int do_pick_commit(void)
 		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
 		strbuf_addstr(&msgbuf, p);
 
-		if (no_replay) {
+		if (record_origin) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -560,7 +560,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
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
