From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] fast_export.c: Fix a compiler warning
Date: Sun, 19 Aug 2012 16:29:02 +0100
Message-ID: <5031063E.3090405@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: florian.achleitner.2.6.31@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 19 21:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3B00-0008A0-GN
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 21:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab2HSTQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 15:16:45 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:40721 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab2HSTQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 15:16:32 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id A799EA0C083;
	Sun, 19 Aug 2012 20:16:31 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id EE705A0C07F;	Sun, 19 Aug 2012 20:16:30 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sun, 19 Aug 2012 20:16:30 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203731>


In particular, gcc complains thus:

        CC vcs-svn/fast_export.o
    vcs-svn/fast_export.c: In function 'fast_export_begin_note':
    vcs-svn/fast_export.c:77: warning: long long unsigned int format, \
        different type arg (arg 2)

In order to fix the warning, we cast the second size_t argument in
the call to printf to uintmax_t.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Florian,

If you need to re-roll your patches in the 'fa/remote-svn' branch, could
you please squash this fix into them. [This was implemented on top of
commit 2ce959ba, but you will probably want to make the equivalent change
to commit d319a37c ("Create a note for every imported commit containing
svn metadata", 17-08-2012) instead. Note that, because of the context
lines in the patch, it won't apply as-is.]

Thanks!

ATB,
Ramsay Jones

 vcs-svn/fast_export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index c780d32..dd09c7d 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -74,7 +74,7 @@ void fast_export_begin_note(uint32_t revision, const char *author,
 	size_t loglen = strlen(log);
 	printf("commit %s\n", note_ref);
 	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
-	printf("data %"PRIuMAX"\n", loglen);
+	printf("data %"PRIuMAX"\n", (uintmax_t) loglen);
 	fwrite(log, loglen, 1, stdout);
 	if (firstnote) {
 		if (revision > 1)
-- 
1.7.11.2
