From: Sebastian Thiel <byronimo@gmail.com>
Subject: [PATCH] git-update-index: report(...) now flushes stdout after printing the report line
Date: Thu, 19 Nov 2009 21:17:41 +0000 (UTC)
Message-ID: <loom.20091119T221732-624@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 22:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBEQo-0000y7-0h
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 22:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbZKSVUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 16:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbZKSVUB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 16:20:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:38274 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbZKSVT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 16:19:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NBEQ8-0000fg-Ci
	for git@vger.kernel.org; Thu, 19 Nov 2009 22:20:04 +0100
Received: from 91-64-163-25-dynip.superkabel.de ([91.64.163.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 22:20:04 +0100
Received: from byronimo by 91-64-163-25-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 22:20:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.163.25 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.15) Gecko/2009102814 Ubuntu/8.10 (intrepid) Firefox/3.0.15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133255>

This makes it equivalent to the behavior of git-hash-object and allows tools to
write one path
to stdin, flush and assure the work is done once it reads the corresponding
report line.
Previously attempting to do that would result in the program blocking as
git-update-index
did not flush its report line (yet). External programs use the git-hash-object
like behavior
to precisely control when which work is done while providing just-in-time
feedback to the end-user.
---
 builtin-update-index.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..08bf933 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -37,6 +37,7 @@ static void report(const char *fmt, ...)
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
+	maybe_flush_or_die(stdout, "line to stdout");
 	va_end(vp);
 }
 
-- 
1.6.5.3.172.g9e796
