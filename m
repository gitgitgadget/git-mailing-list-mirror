From: Linus Torvalds <torvalds@osdl.org>
Subject: Handle "-" at beginning of filenames, part 3
Date: Mon, 17 Oct 2005 22:57:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510172251340.3369@g5.osdl.org>
References: <200510162114.27429.blaisorblade@yahoo.it>
 <Pine.LNX.4.64.0510171546580.3369@g5.osdl.org> <7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510171814430.3369@g5.osdl.org> <7vmzl7tv89.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510171933200.3369@g5.osdl.org> <Pine.LNX.4.64.0510172243560.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:59:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERkU7-0004nW-LG
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 07:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVJRF57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 01:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVJRF57
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 01:57:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932369AbVJRF57 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 01:57:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9I5vsFC005270
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Oct 2005 22:57:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9I5vrRB030499;
	Mon, 17 Oct 2005 22:57:53 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510172243560.3369@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10209>


This fixes the default built-in exec() of "diff" to add a "--" before the 
filenames, so that if a filename starts with a "-", the diff program won't 
think it's an option.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should complete the series. Now all the parts should be safe and pass 
on "--" properly. Knock wood.


On Mon, 17 Oct 2005, Linus Torvalds wrote:
> 
> It adds "--" to the git-diff.sh scripts, to keep any filenames that start 
> with a "-" from being confused with an option.

diff --git a/diff.c b/diff.c
index cbb8632..d6b5086 100644
--- a/diff.c
+++ b/diff.c
@@ -134,7 +134,7 @@ static void builtin_diff(const char *nam
 {
 	int i, next_at, cmd_size;
 	const char *const diff_cmd = "diff -L%s%s -L%s%s";
-	const char *const diff_arg  = "%s %s||:"; /* "||:" is to return 0 */
+	const char *const diff_arg  = "-- %s %s||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
 	const char *path0[2];
 	const char *path1[2];
