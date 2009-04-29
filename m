From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] print unlink(2) errno in copy_or_link_directory
Date: Wed, 29 Apr 2009 23:24:52 +0200
Message-ID: <20090429212452.GA12981@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHHx-0005jQ-KC
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760955AbZD2VZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760608AbZD2VZB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:25:01 -0400
Received: from mout2.freenet.de ([195.4.92.92]:47293 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760359AbZD2VZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:25:00 -0400
Received: from [195.4.92.23] (helo=13.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1LzHH1-0003cZ-J5; Wed, 29 Apr 2009 23:24:59 +0200
Received: from x6432.x.pppool.de ([89.59.100.50]:58169 helo=tigra.home)
	by 13.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1LzHH0-0006rp-Hm; Wed, 29 Apr 2009 23:24:59 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 2A54C277D8;
	Wed, 29 Apr 2009 23:24:53 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id E200036D28; Wed, 29 Apr 2009 23:24:52 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117950>


Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 880373f..ba286e0 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -228,7 +228,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
-			die("failed to unlink %s", dest->buf);
+			die("failed to unlink %s: %s",
+			    dest->buf, strerror(errno));
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
-- 
1.6.3.rc3.39.g49fd5
