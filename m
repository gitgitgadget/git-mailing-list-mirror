From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$ to be consistent with other VCSs
Date: Mon, 14 May 2007 14:37:25 +0100
Message-ID: <200705141437.25528.andyparkins@gmail.com>
References: <200705141429.58412.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 15:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnakZ-0006Au-O6
	for gcvg-git@gmane.org; Mon, 14 May 2007 15:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbXENNhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 09:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbXENNhe
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 09:37:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58358 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbXENNhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 09:37:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1339692uga
        for <git@vger.kernel.org>; Mon, 14 May 2007 06:37:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=dseeLv9lVwBQAteyuBb9MeGcPxVfl5y9J97QMZWBWGXXUoBgSR5Ym2RVWniJjxTc5lN8KOObtkf+vyL2jFfJU8U8io2+S0jzjIw4W2dXAxhkhGoe4Uvwhu5sVaOi5bEtKYNhvvVuZqQ/3Ek4H4Q2uIYzPCs9sqdt0MsZps1jab4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=IehQ3tFGO2Enxz1xME5kqRCM9G9BYgtiRxZsHtQXpweYxVZYQI4JFBfKUvk1fi3WY7MM1RNVSDuaUAVFfumDOtyfdNPdNTqIEq/4VYGV8F9Sg+3eV/xEpEOWJ9eZtIicjs86NNh0lQO5QtVGOmMAi1NtBniAYDdqBjCuVVYoj2M=
Received: by 10.82.100.1 with SMTP id x1mr1672415bub.1179149850474;
        Mon, 14 May 2007 06:37:30 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z34sm15617231ikz.2007.05.14.06.37.28;
        Mon, 14 May 2007 06:37:28 -0700 (PDT)
In-Reply-To: <200705141429.58412.andyparkins@gmail.com>
X-TUID: 2d2f658a545442f2
X-UID: 309
X-Length: 3369
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47241>

$Id$ is present already in SVN and CVS; it would mean that people
converting their existing repositories won't have to make any changes to
the source files should they want to make use of the ident attribute.

Given that it's a feature that's meant to calm those very people, it
seems obtuse to make them edit every file just to make use of it.

I think that bzr uses $Id$; Mercurial has examples hooks for $Id$;
monotone has $Id$ on its wishlist.  I can't think of a good reason not
to stick with the de-facto standard and call ours $Id$ instead of
$ident$.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

Patch, should anyone agree with the idea.

 convert.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/convert.c b/convert.c
index 79dfbcf..23257aa 100644
--- a/convert.c
+++ b/convert.c
@@ -412,7 +412,7 @@ static void setup_convert_check(struct git_attr_check *check)
 static int count_ident(const char *cp, unsigned long size)
 {
 	/*
-	 * "$ident: 0000000000000000000000000000000000000000 $" <=> "$ident$"
+	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
 	 */
 	int cnt = 0;
 	char ch;
@@ -466,10 +466,10 @@ static char *ident_to_git(const char *path, const char *src, unsigned long *size
 	for (dst = buf; size; size--) {
 		char ch = *src++;
 		*dst++ = ch;
-		if ((ch == '$') && (6 <= size) &&
-		    !memcmp("ident:", src, 6)) {
-			unsigned long rem = size - 6;
-			const char *cp = src + 6;
+		if ((ch == '$') && (3 <= size) &&
+		    !memcmp("Id:", src, 3)) {
+			unsigned long rem = size - 3;
+			const char *cp = src + 3;
 			do {
 				ch = *cp++;
 				if (ch == '$')
@@ -478,8 +478,8 @@ static char *ident_to_git(const char *path, const char *src, unsigned long *size
 			} while (rem);
 			if (!rem)
 				continue;
-			memcpy(dst, "ident$", 6);
-			dst += 6;
+			memcpy(dst, "Id$", 3);
+			dst += 3;
 			size -= (cp - src);
 			src = cp;
 		}
@@ -511,13 +511,13 @@ static char *ident_to_worktree(const char *path, const char *src, unsigned long
 		const char *cp;
 		char ch = *src++;
 		*dst++ = ch;
-		if ((ch != '$') || (size < 6) || memcmp("ident", src, 5))
+		if ((ch != '$') || (size < 3) || memcmp("Id", src, 2))
 			continue;
 
-		if (src[5] == ':') {
+		if (src[2] == ':') {
 			/* discard up to but not including the closing $ */
-			unsigned long rem = size - 6;
-			cp = src + 6;
+			unsigned long rem = size - 3;
+			cp = src + 3;
 			do {
 				ch = *cp++;
 				if (ch == '$')
@@ -527,13 +527,13 @@ static char *ident_to_worktree(const char *path, const char *src, unsigned long
 			if (!rem)
 				continue;
 			size -= (cp - src);
-		} else if (src[5] == '$')
-			cp = src + 5;
+		} else if (src[2] == '$')
+			cp = src + 2;
 		else
 			continue;
 
-		memcpy(dst, "ident: ", 7);
-		dst += 7;
+		memcpy(dst, "Id: ", 4);
+		dst += 4;
 		memcpy(dst, sha1_to_hex(sha1), ident);
 		dst += ident;
 		*dst++ = ' ';
-- 
1.5.2.rc3.27.g43d151-dirty
