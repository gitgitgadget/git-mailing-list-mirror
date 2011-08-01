From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 2/2] grep: long context options
Date: Mon, 01 Aug 2011 19:22:52 +0200
Message-ID: <4E36E0EC.1000508@lsrfire.ath.cx>
References: <4E357BE2.8030409@lsrfire.ath.cx> <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com> <4E36C840.9000808@lsrfire.ath.cx> <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:23:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwCi-0007vM-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab1HARW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 13:22:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:57296 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1HARWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 13:22:54 -0400
Received: from [192.168.2.104] (p4FFD8EFC.dip.t-dialin.net [79.253.142.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 331C62F8035;
	Mon,  1 Aug 2011 19:22:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178356>

Take long option names for -A (--after-context), -B (--before-context)
and -C (--context) from GNU grep and add a similar long option name
for -W (--function-context).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |   26 +++++++++++++++++---------
 builtin/grep.c             |    8 ++++----
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6cd0c50..af501d2 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -155,15 +155,6 @@ OPTIONS
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
--[ABC] <context>::
-	Show `context` trailing (`A` -- after), or leading (`B`
-	-- before), or both (`C` -- context) lines, and place a
-	line containing `--` between contiguous groups of
-	matches.
-
--<num>::
-	A shortcut for specifying `-C<num>`.
-
 -p::
 --show-function::
 	Show the preceding line that contains the function name of
@@ -172,7 +163,24 @@ OPTIONS
 	patch hunk headers (see 'Defining a custom hunk-header' in
 	linkgit:gitattributes[5]).
 
+-<num>::
+-C <num>::
+--context <num>::
+	Show <num> leading and trailing lines, and place a line
+	containing `--` between contiguous groups of matches.
+
+-A <num>::
+--after-context <num>::
+	Show <num> trailing lines, and place a line containing
+	`--` between contiguous groups of matches.
+
+-B <num>::
+--before-context <num>::
+	Show <num> leading lines, and place a line containing
+	`--` between contiguous groups of matches.
+
 -W::
+--function-context::
 	Show the surrounding text from the previous line containing a
 	function name up to the one before the next function name,
 	effectively showing the whole function in which the match was
diff --git a/builtin/grep.c b/builtin/grep.c
index 1fae662..1851797 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -827,18 +827,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "heading", &opt.heading,
 			"show filename only once above matches from same file"),
 		OPT_GROUP(""),
-		OPT_CALLBACK('C', NULL, &opt, "n",
+		OPT_CALLBACK('C', "context", &opt, "n",
 			"show <n> context lines before and after matches",
 			context_callback),
-		OPT_INTEGER('B', NULL, &opt.pre_context,
+		OPT_INTEGER('B', "before-context", &opt.pre_context,
 			"show <n> context lines before matches"),
-		OPT_INTEGER('A', NULL, &opt.post_context,
+		OPT_INTEGER('A', "after-context", &opt.post_context,
 			"show <n> context lines after matches"),
 		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
 			context_callback),
 		OPT_BOOLEAN('p', "show-function", &opt.funcname,
 			"show a line with the function name before matches"),
-		OPT_BOOLEAN('W', NULL, &opt.funcbody,
+		OPT_BOOLEAN('W', "function-context", &opt.funcbody,
 			"show the surrounding function"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, "file",
-- 
1.7.6
