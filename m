From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] fix sample update hook, disable overwriting of existing
	tags
Date: Thu, 7 May 2009 18:40:23 +0200
Message-ID: <20090507164023.GB5807@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 18:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M26eB-0002C8-2Z
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 18:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbZEGQk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 12:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbZEGQk0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 12:40:26 -0400
Received: from darksea.de ([83.133.111.250]:53391 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752299AbZEGQkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 12:40:25 -0400
Received: (qmail 2303 invoked from network); 7 May 2009 18:40:13 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 May 2009 18:40:13 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118491>

Because no special rule for this existed it was allowed by default

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 templates/hooks--update.sample |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index f8bf490..68da609 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -82,6 +82,12 @@ case "$refname","$newrev_type" in
 		;;
 	refs/tags/*,tag)
 		# annotated tag
+		if [ "$allowdeletetag" != "true" ] && git rev-parse $refname > /dev/null 2>&1
+		then
+			echo "*** Tag '$refname' already exists." >&2
+			echo "*** Overwriting a tag is not allowed in this repository." >&2
+			exit 1
+		fi
 		;;
 	refs/heads/*,commit)
 		# branch
-- 
1.6.2.1.423.g442d
