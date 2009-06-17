From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] fetch: do not create ref from empty name
Date: Wed, 17 Jun 2009 15:38:36 +0200
Message-ID: <20090617133836.GA25155@localhost>
References: <2cfc40320906170508o4fc0fc14sca511742be03ee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 15:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGvLm-0002Mn-6H
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758475AbZFQNij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 09:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbZFQNij
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:38:39 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:29953 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779AbZFQNii (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 09:38:38 -0400
Received: from darc.dnsalias.org ([84.154.66.80]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Jun 2009 15:38:38 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MGvLY-0007dh-CH; Wed, 17 Jun 2009 15:38:36 +0200
Content-Disposition: inline
In-Reply-To: <2cfc40320906170508o4fc0fc14sca511742be03ee5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 17 Jun 2009 13:38:38.0911 (UTC) FILETIME=[EBCA84F0:01C9EF50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121744>

Previously, the refspec "<src>:" would be expanded to
"<src>:refs/heads/". Instead, treat an empty <dst> just like refspecs
without a colon.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Wed, Jun 17, 2009 at 10:08:25PM +1000, Jon Seymour wrote:
> Can someone tell me why this happens?
> 
>     error: * Ignoring funny ref 'refs/heads/' locally

This fixes it.

Note that "git fetch origin :" is short for "git fetch origin
HEAD", which stores the remote HEAD in FETCH_HEAD. You probably want "git
fetch origin", without an explicit refspec, which defaults to "git fetch
origin 'refs/heads/*:refs/remotes/origin/*'", i.e. store remote branches in
the namespace for tracking branches.

Clemens

 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 08a5964..99e7797 100644
--- a/remote.c
+++ b/remote.c
@@ -1263,7 +1263,7 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
 
 static struct ref *get_local_ref(const char *name)
 {
-	if (!name)
+	if (!name || name[0] == '\0')
 		return NULL;
 
 	if (!prefixcmp(name, "refs/"))
-- 
1.6.3.1.147.g637c3
