From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/10] revert: Rename no_replay to record_origin
Date: Wed, 25 May 2011 14:16:59 +0000
Message-ID: <1306333025-29893-5-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEuG-0003uG-77
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673Ab1EYORb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:31 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53758 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268Ab1EYORO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:14 -0400
Received: by qwk3 with SMTP id 3so3913824qwk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OpTnJEUx00MpTnGdnblwbZJeHhpc1l8z1Ny96cpFl9w=;
        b=M9fZr1IwiqEPcgaWQ2sY930I0G/Y1Glx3Fs6QAXutTvkiePV/Ux8DLyAeVEXT08xbn
         eyw8DiHuTHFRLhbNSFyB4YHuGChnPTgqenTCXaMPvMYybmFJgv65Aw46WwbZQKZsCymt
         N7kkrqtNKmRE7tm0oND/zkNJUDhITxgPGPNM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CkwAhoQGFxGnh6EMdmC3kuoFh8z+0PDkgOYUg/7RgXF6dgW4HVkD+5CeOUnEyLAwwu
         LDFtHlMlWkWtRyEBBuwjj78dIhLwR28WMa4rvVSS3kFgPpPd3ywGxc8M9D6hM86ZAocS
         RMWoz/4BAUOkFS7c3CS8Q6Rfar0so5GKCagqE=
Received: by 10.224.214.197 with SMTP id hb5mr3961296qab.176.1306333033606;
        Wed, 25 May 2011 07:17:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174403>

Give the variable "no_replay" a new name "record_origin", so that
there is no confusion when a "replay" structure is introduced later in
the series.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 6c485f6..c48a7df 100644
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
@@ -467,7 +467,7 @@ static int do_pick_commit(struct commit *commit)
 		next = commit;
 		next_label = msg.label;
 		add_message_to_msg(commit_sha1_hex, &msgbuf, msg.message);
-		if (no_replay) {
+		if (record_origin) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -563,7 +563,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
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
