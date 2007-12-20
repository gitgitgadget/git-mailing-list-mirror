From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Only filter "#" comments from commits if the editor is used
Date: Fri, 21 Dec 2007 00:37:14 +0100
Message-ID: <20071220233714.GD3052@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home> <20071220233539.GC3052@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5UxU-0006C7-0i
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbXLTXhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbXLTXhU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:37:20 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:61559 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbXLTXhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:37:18 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (klopstock mo35) (RZmta 14.6)
	with ESMTP id a03c4ajBKLIGJS ; Fri, 21 Dec 2007 00:37:14 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A5577277AE;
	Fri, 21 Dec 2007 00:37:14 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A491356D22; Fri, 21 Dec 2007 00:37:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071220233539.GC3052@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69024>

Originally-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 3127247..1356d20 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -441,7 +441,7 @@ static int message_is_empty(struct strbuf *sb, int start)
 	/* See if the template is just a prefix of the message. */
 	strbuf_init(&tmpl, 0);
 	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
-		stripspace(&tmpl, 1);
+		stripspace(&tmpl, !no_edit);
 		if (start + tmpl.len <= sb->len &&
 		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) == 0)
 			start += tmpl.len;
@@ -821,7 +821,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		strbuf_setlen(&sb, p - sb.buf + 1);
 
 	if (!verbatim_message)
-		stripspace(&sb, 1);
+		stripspace(&sb, !no_edit);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
 		die("no commit message?  aborting commit.");
-- 
1.5.4.rc1.33.gbd32b
