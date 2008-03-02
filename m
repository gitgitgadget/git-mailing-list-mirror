From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] remote show: Clean up connection correctly if object fetch
 wasn't done
Date: Sun, 2 Mar 2008 05:31:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020531310.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 06:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVgpV-0000IL-Jg
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbYCBFcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbYCBFcn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:32:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:34823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750826AbYCBFcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:32:42 -0500
Received: (qmail invoked by alias); 02 Mar 2008 05:32:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp001) with SMTP; 02 Mar 2008 06:32:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iRRMTN64iNWDoawM+SGr8UcWAwD2mlCrmWlJGz/
	KEP2OBnk2Ghqzj
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75724>


Like in ls-remote, we have to disconnect the transport after getting
the remote refs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I did not make the connection when commenting on ls-remote, that
	builtin-remote uses the same API...

 builtin-remote.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 2ad1a8d..2405c2c 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -387,6 +387,7 @@ static int show_or_prune(int argc, const char **argv, int prune)
 		transport = transport_get(NULL, states.remote->url_nr > 0 ?
 			states.remote->url[0] : NULL);
 		ref = transport_get_remote_refs(transport);
+		transport_disconnect(transport);
 
 		read_branches();
 		got_states = get_ref_states(ref, &states);
-- 
1.5.4.3.446.gbe8932

