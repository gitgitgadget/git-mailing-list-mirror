From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] git-remote: fixed missing .uploadpack usage for show command
Date: Thu, 25 Jun 2009 17:21:35 -0400
Message-ID: <20090625212135.GA28935@foursquare.net>
References: <20090625090036.GA32650@foursquare.net> <7vmy7wcgge.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:22:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJwOd-0002Xs-F5
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 23:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbZFYVWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 17:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbZFYVWE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 17:22:04 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:45920 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbZFYVWC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 17:22:02 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id n5PLLZQv029326;
	Thu, 25 Jun 2009 17:21:35 -0400
Content-Disposition: inline
In-Reply-To: <7vmy7wcgge.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-1.8, required 5, autolearn=not spam,
	ALL_TRUSTED -1.80)
X-Net-Direct-Inc-MailScanner-From: cdfrey@foursquare.net
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122245>

For users pulling from machines with self compiled git installs,
in non-PATH locations, they can set the config option
remote.<name>.uploadpack to set the location of git-upload-pack.

When using 'git remote show <name>', the remote HEAD check
did not use the uploadpack configuration setting, and would stall.

In builtin-remote.c, the config setting is already loaded
with the call to remote_get(), so this patch passes that remote
along to transport_get().

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---

A possibly clearer description...


 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 658d578..ec1f903 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -787,7 +787,7 @@ static int get_remote_ref_states(const char *name,
 	read_branches();
 
 	if (query) {
-		transport = transport_get(NULL, states->remote->url_nr > 0 ?
+		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
-- 
1.6.2.5
