From: Michel Marti <mma@objectxp.com>
Subject: [PATCH] git-diff: don't use colors when stdout is not a tty.
Date: Fri, 06 Jul 2007 17:35:10 +0200
Message-ID: <468E612E.2070903@objectxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 18:05:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qIp-0005u4-AJ
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761098AbXGFQE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760891AbXGFQE6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:04:58 -0400
Received: from automatix.objectxp.com ([62.2.156.210]:59548 "EHLO
	automatix.objectxp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760418AbXGFQE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:04:58 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2007 12:04:58 EDT
Received: from [192.168.0.56] (max.office.objectxp.com [192.168.0.56])
	by automatix.objectxp.com (Postfix) with ESMTP id 0634E5A3358E
	for <git@vger.kernel.org>; Fri,  6 Jul 2007 17:35:11 +0200 (CEST)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
OpenPGP: id=F3EACEBF
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51769>

Currently, with diff-coloring enabled, git-diff outputs color escape
sequences even if stdout is redirected (not a tty). This is rather annoying
when trying to further process the output. This patch teaches the diff command
to only do its coloring stuff when a pager is in use or stdout is a tty.

Signed-off-by: Michel Marti <mma@objectxp.com>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 1958970..988e741 100644
--- a/diff.c
+++ b/diff.c
@@ -451,7 +451,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)

 const char *diff_get_color(int diff_use_color, enum color_diff ix)
 {
-       if (diff_use_color)
+       if (diff_use_color && (pager_in_use || isatty(STDOUT_FILENO)))
                return diff_colors[ix];
        return "";
 }
--
1.5.2.2
