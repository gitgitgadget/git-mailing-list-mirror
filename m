From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/10] revert: Rename no_replay to record_origin
Date: Thu, 26 May 2011 15:53:47 +0000
Message-ID: <1306425233-504-5-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPct8-0001N6-QY
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823Ab1EZPyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:07 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43880 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab1EZPyE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:04 -0400
Received: by qwk3 with SMTP id 3so441227qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vzMrcVvy2A1HDezhZYa6lHSphQO0oOarEfluwVvn504=;
        b=ScA4l577T1mlA7RDRc57JaoEWwen0qWAkpXRZ+1MnMPn3hpTA20TWhay/Y/knlECV7
         vqphycZRX/hDPBJUk2Viul0paaxOXpFd0wUwl/xEcL0Nr41k5XcnbKHsquAufFGMVrv+
         by82a6eryzP6mwYAxQrCHS0RmwSh766WO4lC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L2TxBTSymcijL2z446xvpXcVbNydU22YIRcS3XhJydemiWjqVF8lXjWbqrmssyhoik
         iaARudMe820mDLB6cwjJZ+fD5Aym3Gtp4maWrs9FAx35p2iGzIH2ybldyNZyNIhRNFX2
         Zhr6yQw2ejbofJjX8lPO76bdQptPPENNVtkp4=
Received: by 10.229.118.69 with SMTP id u5mr713169qcq.122.1306425243668;
        Thu, 26 May 2011 08:54:03 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174529>

Give the variable "no_replay" a new name "record_origin", so that
there is no confusion when a "replay" structure is introduced later in
the series.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 745295d..e9b8533 100644
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
@@ -456,7 +456,7 @@ static int do_pick_commit(struct commit *commit)
 		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
 		strbuf_addstr(&msgbuf, p);
 
-		if (no_replay) {
+		if (record_origin) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
@@ -552,7 +552,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
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
