From: David Bryson <david@statichacks.org>
Subject: [PATCH] Use "git_config_string" to simplify "remote.c" code in
	"handle_config"
Date: Thu, 2 Oct 2008 20:39:37 -0700
Message-ID: <20081003033937.GA11594@eratosthenes.cryptobackpack.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 05:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlbX9-000186-Fy
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 05:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbYJCDjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 23:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYJCDjk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 23:39:40 -0400
Received: from cryptobackpack.org ([64.105.32.74]:56451 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbYJCDjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 23:39:40 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 7795910D0243; Thu,  2 Oct 2008 20:39:39 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 6DDC810D01F5
	for <git@vger.kernel.org>; Thu,  2 Oct 2008 20:39:37 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 4C3C1144E1; Thu,  2 Oct 2008 20:39:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97393>


Signed-off-by: David Bryson <david@statichacks.org>

I tried to keep with the naming/coding conventions that I found in
remote.c.  Feedback welcome.

---
 remote.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index 3f3c789..893a739 100644
--- a/remote.c
+++ b/remote.c
@@ -305,6 +305,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
 	const char *subkey;
+	const char *v;
 	struct remote *remote;
 	struct branch *branch;
 	if (!prefixcmp(key, "branch.")) {
@@ -314,15 +315,15 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (!value)
-				return config_error_nonbool(key);
-			branch->remote_name = xstrdup(value);
+			if (git_config_string(&v, key, value) ) 
+				return -1;
+			branch->remote_name = v;
 			if (branch == current_branch)
 				default_remote_name = branch->remote_name;
 		} else if (!strcmp(subkey, ".merge")) {
-			if (!value)
-				return config_error_nonbool(key);
-			add_merge(branch, xstrdup(value));
+			if (git_config_string(&v, key, value )) 
+				return 	-1;
+			add_merge(branch, v);
 		}
 		return 0;
 	}
@@ -334,9 +335,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		rewrite = make_rewrite(name, subkey - name);
 		if (!strcmp(subkey, ".insteadof")) {
-			if (!value)
-				return config_error_nonbool(key);
-			add_instead_of(rewrite, xstrdup(value));
+			if (git_config_string(&v, key, value )) 
+				return 	-1;
+			add_instead_of(rewrite, v);
 		}
 	}
 	if (prefixcmp(key,  "remote."))
-- 
1.6.0.2
