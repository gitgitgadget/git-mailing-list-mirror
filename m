From: Rutger Nijlunsing <rutger@nospam.com>
Subject: [PATCH] http-push: Make WebDAV work with (broken?) default apache2 WebDAV module
Date: Wed, 9 Aug 2006 20:54:23 +0200
Organization: M38c
Message-ID: <20060809185423.GB7841@nospam.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 09 20:54:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAtCK-0001cO-SY
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 20:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWHISy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWHISy1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 14:54:27 -0400
Received: from post-26.mail.nl.demon.net ([194.159.73.196]:48586 "EHLO
	post-26.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751081AbWHISy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 14:54:26 -0400
Received: from wingding.demon.nl ([82.161.27.36]:56034)
	by post-26.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GAtCD-0000Sx-5e
	for git@vger.kernel.org; Wed, 09 Aug 2006 18:54:25 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GAtCB-0000Q2-F2
	for git@vger.kernel.org; Wed, 09 Aug 2006 20:54:23 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25133>

WebDAV on Debian unstable cannot handle renames on WebDAV from
file.ext to newfile (without ext) when newfile* already
exists. Normally, git creates a file like 'objects/xx/sha1.token',
which is renamed to 'objects/xx/sha1' when transferred completely.

Just use '_' instead of '.' so WebDAV doesn't see it as an extension
change.

Signed-off-by: Rutger Nijlunsing <git@tux.tmfweb.nl>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 4021e7d..d45733e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -530,7 +530,7 @@ static void start_put(struct transfer_re
 	request->dest = xmalloc(strlen(request->url) + 14);
 	sprintf(request->dest, "Destination: %s", request->url);
 	posn += 38;
-	*(posn++) = '.';
+	*(posn++) = '_';
 	strcpy(posn, request->lock->token);
 
 	slot = get_active_slot();
-- 
1.4.2.rc2.g7cb1


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
