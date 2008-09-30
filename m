From: David Bryson <david@statichacks.org>
Subject: [PATCH] Use "git_config_string" to simplify "builtin-gc.c" code
	where "prune_expire" is set
Date: Tue, 30 Sep 2008 12:05:49 -0700
Message-ID: <20080930190549.GA9869@eratosthenes.cryptobackpack.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 21:18:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkkjL-0002dU-Kb
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYI3TQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbYI3TQp
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:16:45 -0400
Received: from cryptobackpack.org ([64.105.32.74]:58737 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYI3TQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:16:44 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Sep 2008 15:16:44 EDT
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 939E010D025B; Tue, 30 Sep 2008 12:05:50 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id C70EA10D00BA
	for <git@vger.kernel.org>; Tue, 30 Sep 2008 12:05:49 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id D3A887C19E; Tue, 30 Sep 2008 12:05:49 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97147>

Hi all,
This is a quick janitor patch and my first patch sent to the git mailing
list.  Please let me know if I have done any process of the patch
submission wrong, and if I got the Janitorial task done in the proper
fashion.

Signed-off-by: David Bryson <david@statichacks.org>
---
 builtin-gc.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index fac200e..6260652 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -57,15 +57,12 @@ static int gc_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "gc.pruneexpire")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (strcmp(value, "now")) {
+		if (value && strcmp(value, "now")) {
 			unsigned long now = approxidate("now");
 			if (approxidate(value) >= now)
 				return error("Invalid %s: '%s'", var, value);
 		}
-		prune_expire = xstrdup(value);
-		return 0;
+		return git_config_string(&prune_expire, var, value);
 	}
 	return git_default_config(var, value, cb);
 }
-- 
1.6.0.2
