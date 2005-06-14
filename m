From: Pavel Roskin <proski@gnu.org>
Subject: [COGITO PATCH] Optimized print_help()
Date: Tue, 14 Jun 2005 19:26:16 -0400
Message-ID: <1118791576.3890.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 15 01:22:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiKjF-0003TB-H0
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 01:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFNX0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 19:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFNX0n
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 19:26:43 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:3998 "EHLO
	dv.roinet.com") by vger.kernel.org with ESMTP id S261412AbVFNX0U
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 19:26:20 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j5ENQG7Y006344
	for <git@vger.kernel.org>; Tue, 14 Jun 2005 19:26:16 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j5ENQGHH006341
	for git@vger.kernel.org; Tue, 14 Jun 2005 19:26:16 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

print_help() in cg-Xlib should not be calling "which" 3 times.  It's an
external command.  The patch caches the result in a local variable.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -130,10 +130,11 @@ update_index () {
 
 
 print_help () {
-	which "cg-$1" >/dev/null 2>&1 || exit 1
-	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' < $(which cg-$1) 
+	local toolpath=$(which cg-$1 2>/dev/null)
+	[ -z "$toolpath" ] && exit 1
+	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' < $toolpath
 	echo
-	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
+	cat $toolpath | sed -n '3,/^$/s/^# *//p'
 	exit
 }
 

-- 
Regards,
Pavel Roskin

