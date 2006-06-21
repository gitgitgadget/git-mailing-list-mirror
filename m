From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] Fix possible out-of-bounds array access
Date: Wed, 21 Jun 2006 11:04:12 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060621090412.GA9267@informatik.uni-freiburg.de>
References: <20060620160836.GA20153@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 11:04:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsydF-0004Yv-PO
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWFUJEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWFUJEO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:04:14 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:10998 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751155AbWFUJEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 05:04:14 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FsydA-0002Bt-RB
	for git@vger.kernel.org; Wed, 21 Jun 2006 11:04:12 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5L94Cs09288
	for git@vger.kernel.org; Wed, 21 Jun 2006 11:04:12 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060620160836.GA20153@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22242>

If match is "", match[-1] is accessed.  Let pathspec_matches return 1 in that
case indicating that "" matches everything.

Incidently this fixes git-grep'ing in ".".

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
---

 builtin-grep.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 9806499..f7767bb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -29,10 +29,11 @@ static int pathspec_matches(const char *
 		int matchlen = strlen(match);
 		const char *cp, *meta;
 
-		if ((matchlen <= namelen) &&
-		    !strncmp(name, match, matchlen) &&
-		    (match[matchlen-1] == '/' ||
-		     name[matchlen] == '\0' || name[matchlen] == '/'))
+		if (!matchlen ||
+		    ((matchlen <= namelen) &&
+		     !strncmp(name, match, matchlen) &&
+		     (match[matchlen-1] == '/' ||
+		      name[matchlen] == '\0' || name[matchlen] == '/')))
 			return 1;
 		if (!fnmatch(match, name, 0))
 			return 1;
-- 
1.4.0

-- 
Uwe Zeisberger

http://www.google.com/search?q=12+mol+in+dozen
