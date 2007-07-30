From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH] add series editor support.
Date: Mon, 30 Jul 2007 14:05:12 +0400
Organization: SWsoft
Message-ID: <20070730100512.GA14637@dnb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 12:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFS7N-0004zj-QQ
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbXG3KEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXG3KEr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:04:47 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:3675 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbXG3KEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:04:46 -0400
Received: from sw.ru ([192.168.3.106])
	by relay.sw.ru (8.13.4/8.13.4) with SMTP id l6UA4ZRP020008;
	Mon, 30 Jul 2007 14:04:36 +0400 (MSD)
Received: by sw.ru (nbSMTP-1.00) for uid 1008
	dmonakhov@sw.ru; Mon, 30 Jul 2007 14:05:14 +0400 (MSD)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54217>

Usually we have to edit series file directly (via editor).
I think it is not bad idea to let guilt export this service.
IMHO "guilt-series -e" it the best way to do it.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 guilt-series |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/guilt-series b/guilt-series
index 62c3bb1..7594b2e 100755
--- a/guilt-series
+++ b/guilt-series
@@ -3,7 +3,7 @@
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
-USAGE="[-v | -g]"
+USAGE="[-v | -g | -e]"
 . `dirname $0`/guilt
 
 while case "$#" in 0) break ;; esac
@@ -13,13 +13,18 @@ do
 		verbose=t ;;
 	-g)
 		gui=t ;;
+	-e)
+		edit=t ;;
 	*)
 		usage ;;
 	esac
 	shift
 done
 
-if [ ! -z "$gui" ]; then
+# edit -e ?
+if [ "$edit" = "t" ]; then 
+	$editor "$GUILT_DIR/$branch/series"
+elif [ ! -z "$gui" ]; then
 	[ -z "`get_top`" ] && die "No patches applied."
 	bottom=`head -1 $applied | cut -d: -f1`
 	top=`tail -1 $applied | cut -d: -f1`
-- 
1.5.2.2
