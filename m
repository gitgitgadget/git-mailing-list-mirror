From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] rev-list: free commit_list in ... handler
Date: Tue, 4 Jul 2006 21:22:20 +0200
Message-ID: <20060704192220.GA9500@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 04 21:22:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxqTZ-0004f3-2Q
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 21:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWGDTWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 15:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWGDTWW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 15:22:22 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:48279
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751093AbWGDTWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 15:22:21 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id A65821089; Tue,  4 Jul 2006 21:22:20 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23310>

Johannes noticed the missing call to free_commit_list() in the
patch from Santi to add ... support to rev-parse.  Turns out I
forgot it too in rev-list.  This patch is against the next branch
(3b1d06a).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/revision.c b/revision.c
index 66390c9..a7750e6 100644
--- a/revision.c
+++ b/revision.c
@@ -817,6 +817,7 @@ int setup_revisions(int argc, const char
 					exclude = get_merge_bases(a, b, 1);
 					add_pending_commit_list(revs, exclude,
 					                        flags_exclude);
+					free_commit_list(exclude);
 					a->object.flags |= flags;
 				} else
 					a->object.flags |= flags_exclude;
