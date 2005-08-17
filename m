From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] commit-id, tree-id fail on tags
Date: Wed, 17 Aug 2005 00:27:38 -0400
Message-ID: <1124252858.26240.31.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 17 06:29:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5FWo-0002OV-FV
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 06:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVHQE1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 00:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVHQE1p
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 00:27:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:40597 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750817AbVHQE1o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 00:27:44 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E5FTt-0002hl-Kf
	for git@vger.kernel.org; Wed, 17 Aug 2005 00:24:49 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E5FWe-0001j2-N4; Wed, 17 Aug 2005 00:27:40 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7H4Rc2p006633;
	Wed, 17 Aug 2005 00:27:38 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@ucw.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Tag names don't work with current cogito because commit-id and tree-id
don't parse the cg-Xnormid output properly.

Namely, if $type is empty (which is the case for tags), $normid is used
before the trailing space is stripped from it.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/commit-id b/commit-id
--- a/commit-id
+++ b/commit-id
@@ -9,8 +9,9 @@
 
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${normid#* }; [ "$type" ] || type=$(git-cat-file -t "$normid")
+type=${normid#* }
 normid=${normid% *}
+[ "$type" ] || type=$(git-cat-file -t "$normid")
 
 if [ "$type" != "commit" ]; then
 	echo "Invalid commit id: $normid" >&2
diff --git a/tree-id b/tree-id
--- a/tree-id
+++ b/tree-id
@@ -7,8 +7,9 @@
 
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${normid#* }; [ "$type" ] || type=$(git-cat-file -t "$normid")
+type=${normid#* }
 normid=${normid% *}
+[ "$type" ] || type=$(git-cat-file -t "$normid")
 
 if [ "$type" = "commit" ]; then
 	normid=$(git-cat-file commit "$normid" | sed -e 's/tree //;q')


-- 
Regards,
Pavel Roskin
