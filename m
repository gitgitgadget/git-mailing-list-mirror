From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH][next] log --format: don't ignore %w() at the start of format
 string
Date: Sun, 08 Nov 2009 02:04:21 +0100
Message-ID: <4AF61915.70806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 02:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6wCi-0001uT-Cr
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 02:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbZKHBES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 20:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZKHBES
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 20:04:18 -0500
Received: from india601.server4you.de ([85.25.151.105]:49842 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbZKHBER (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 20:04:17 -0500
Received: from [10.0.1.101] (p57B7DAAC.dip.t-dialin.net [87.183.218.172])
	by india601.server4you.de (Postfix) with ESMTPSA id 496A12F807C;
	Sun,  8 Nov 2009 02:04:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132381>

This fixes e.g. --format='%w(72)%s'.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5c3b47b..2e031e6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -619,7 +619,7 @@ static void rewrap_message_tail(struct strbuf *sb,
 	if (c->width == new_width && c->indent1 == new_indent1 &&
 	    c->indent2 == new_indent2)
 		return;
-	if (c->wrap_start && c->wrap_start < sb->len)
+	if (c->wrap_start < sb->len)
 		strbuf_wrap(sb, c->wrap_start, c->width, c->indent1, c->indent2);
 	c->wrap_start = sb->len;
 	c->width = new_width;
