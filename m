From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH] Invoke "gc --auto" from git commit
Date: Tue, 25 Nov 2008 17:15:53 +0100
Message-ID: <492C24B9.6090200@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 17:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L50bJ-0001UV-8f
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 17:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYKYQP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 11:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbYKYQP5
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 11:15:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:45560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbYKYQP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 11:15:57 -0500
Received: (qmail invoked by alias); 25 Nov 2008 16:15:54 -0000
Received: from 70-46.78-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.78.46.70]
  by mail.gmx.net (mp009) with SMTP; 25 Nov 2008 17:15:54 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18EDYtNYbcEvds65x+u6BiHw6xTUyPqmwhqwmpTOu
	qOsoI9q/T5OA7T
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101667>

This feature was lost during the port of git commit to C.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
 builtin-commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 591d16b..209805b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -947,6 +947,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	int allow_fast_forward = 1;
+	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 
 	git_config(git_commit_config, NULL);
 
@@ -1068,6 +1069,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover.");
 
 	rerere();
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (!quiet)
 		print_summary(prefix, commit_sha1);
-- 
1.6.0.4
