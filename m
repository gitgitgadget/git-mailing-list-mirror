From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] builtin-replace: use "usage_msg_opt" to give better
 error messages
Date: Mon, 2 Feb 2009 06:13:06 +0100
Message-ID: <20090202061306.d7eaa24f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 06:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTr8t-0005cZ-Q2
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 06:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbZBBFNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 00:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbZBBFNT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 00:13:19 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:36765 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbZBBFNT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 00:13:19 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 75A5194004D;
	Mon,  2 Feb 2009 06:13:11 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 77363940024;
	Mon,  2 Feb 2009 06:13:09 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108047>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-replace.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin-replace.c b/builtin-replace.c
index e3767b9..b15f709 100644
--- a/builtin-replace.c
+++ b/builtin-replace.c
@@ -124,30 +124,36 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, options, git_replace_usage, 0);
 
 	if (list && delete)
-		usage_with_options(git_replace_usage, options);
+		usage_msg_opt("-l and -d cannot be used together",
+			      git_replace_usage, options);
 
 	if (force && (list || delete))
-		usage_with_options(git_replace_usage, options);
+		usage_msg_opt("-f cannot be used with -d or -l",
+			      git_replace_usage, options);
 
 	/* Delete refs */
 	if (delete) {
 		if (argc < 1)
-			usage_with_options(git_replace_usage, options);
+			usage_msg_opt("-d needs at least one argument",
+				      git_replace_usage, options);
 		return for_each_replace_name(argv, delete_replace_ref);
 	}
 
 	/* Replace object */
 	if (!list && argc) {
 		if (argc != 2)
-			usage_with_options(git_replace_usage, options);
+			usage_msg_opt("bad number of arguments",
+				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 	}
 
 	/* List refs, even if "list" is not set */
 	if (argc > 1)
-		usage_with_options(git_replace_usage, options);
+		usage_msg_opt("only one pattern can be given with -l",
+			      git_replace_usage, options);
 	if (force)
-		usage_with_options(git_replace_usage, options);
+		usage_msg_opt("-f needs some arguments",
+			      git_replace_usage, options);
 
 	return list_replace_refs(argv[0]);
 }
-- 
1.6.1.2.353.g99fdd.dirty
