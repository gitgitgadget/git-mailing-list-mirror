From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/6] grep: add option -p/--show-function
Date: Thu, 02 Jul 2009 17:42:43 +0200
Message-ID: <4A4CD573.80707@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDDEA.3030005@lsrfire.ath.cx>	<7vbpo3errd.fsf@alter.siamese.dyndns.org>	<4A4C39D3.1020401@lsrfire.ath.cx> <7vy6r7d583.fsf@alter.siamese.dyndns.org> <4A4C50C7.1050303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 17:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMORA-0006rj-FI
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 17:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbZGBPmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 11:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZGBPmr
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 11:42:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:41978 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbZGBPmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 11:42:46 -0400
Received: from [10.0.1.101] (p57B7D606.dip.t-dialin.net [87.183.214.6])
	by india601.server4you.de (Postfix) with ESMTPSA id F25C22F8068;
	Thu,  2 Jul 2009 17:42:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4C50C7.1050303@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122652>

And here is the interdiff to remove the code to print == markers.

I think it makes sense to start out without them.  We can add them
back later (or something else, like colourization) if the simpler
output turns out to be difficult to read.

Comments?  Opinions?


 builtin-grep.c |    4 ++--
 grep.c         |   12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 9343cc5..ff8e51b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -285,13 +285,13 @@ static int flush_grep(struct grep_opt *opt,
 		argc -= 2;
 	}
 
-	if (opt->pre_context || opt->post_context || opt->funcname) {
+	if (opt->pre_context || opt->post_context) {
 		/*
 		 * grep handles hunk marks between files, but we need to
 		 * do that ourselves between multiple calls.
 		 */
 		if (opt->show_hunk_mark)
-			write_or_die(1, opt->funcname ? "==\n" : "--\n", 3);
+			write_or_die(1, "--\n", 3);
 		else
 			opt->show_hunk_mark = 1;
 	}
diff --git a/grep.c b/grep.c
index c47785a..5d162da 100644
--- a/grep.c
+++ b/grep.c
@@ -491,18 +491,14 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 {
 	int rest = eol - bol;
 
-	if (opt->pre_context || opt->post_context || opt->funcname) {
+	if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark)
-				fputs(opt->funcname ? "==\n" : "--\n", stdout);
+				fputs("--\n", stdout);
 			else
 				opt->show_hunk_mark = 1;
-		} else if (lno > opt->last_shown + 1) {
-			if (opt->pre_context || opt->post_context)
-				fputs((sign == '=') ? "==\n" : "--\n", stdout);
-			else if (sign == '=')
-				fputs("==\n", stdout);
-		}
+		} else if (lno > opt->last_shown + 1)
+			fputs("--\n", stdout);
 	}
 	opt->last_shown = lno;
 
