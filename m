From: Pavel Roskin <proski@gnu.org>
Subject: [COGITO PATCH] Fixing "cg-help typo" again
Date: Tue, 14 Jun 2005 19:32:47 -0400
Message-ID: <1118791967.3890.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 15 01:28:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiKox-00042u-PM
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 01:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFNXcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 19:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFNXcu
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 19:32:50 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:17891
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261419AbVFNXcs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 19:32:48 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j5ENWlD4006361
	for <git@vger.kernel.org>; Tue, 14 Jun 2005 19:32:47 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j5ENWlUp006358
	for git@vger.kernel.org; Tue, 14 Jun 2005 19:32:47 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

"cg-help typo" is broken again (same symptom - no output) because the
print_help() output is piped through colorize(), which never fails.

I don't know any way to get return status of the first command in a
pipeline, so I changed to code to put print_help() output in a variable,
check status and then pipe the variable contents through colorize().

GNU bash can hold indefinitely much data in variables, and we need a few
kilobytes at most.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-help b/cg-help
--- a/cg-help
+++ b/cg-help
@@ -59,7 +59,8 @@ colorize() {
 
 if [ "$ARGS" ]; then
 	cmd=$(echo "${ARGS[0]}" | sed 's/^cg-//')
-	( print_help $cmd | colorize ) && exit
+	helpdata="$(print_help $cmd)"
+	[ "$?" = 0 ] && { echo "$helpdata" | colorize; exit 0; }
 	echo "cg-help: no help available for command \"${ARGS[0]}\""
 	echo "Call cg-help without any arguments for the list of available commands"
 	exit 1


-- 
Regards,
Pavel Roskin

