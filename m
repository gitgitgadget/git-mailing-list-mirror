From: Ted Pavlic <ted@tedpavlic.com>
Subject: [StGit PATCH 2/2] Make bash completion fail to bashdefault before default completion.
Date: Thu, 22 Jan 2009 11:44:22 -0500
Message-ID: <1232642662-12851-1-git-send-email-ted@tedpavlic.com>
References: <4978A0F1.9080703@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 22 17:47:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2hz-00061K-Id
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbZAVQob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756787AbZAVQob
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:44:31 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:34086 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756732AbZAVQoa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 11:44:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BD94F80D8045;
	Thu, 22 Jan 2009 11:38:31 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hc8V73PWzRsl; Thu, 22 Jan 2009 11:38:31 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A894F80D8030;
	Thu, 22 Jan 2009 11:38:31 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
In-Reply-To: <4978A0F1.9080703@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106765>

If "-o bashdefault" isn't possible, use old "-o default" only.

(this patch inspired by similar mechanism in Mercurial bash completion
script)

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---

This patch corrects a bug in the previous one of the same name. In
particular, the second "complete" lacked the "||" in front of it needed
for proper operation. The first complete command should fail over to the
second if "bashdefault" isn't available.

 stgit/completion.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/completion.py b/stgit/completion.py
index b3fd282..38f0670 100644
--- a/stgit/completion.py
+++ b/stgit/completion.py
@@ -129,7 +129,8 @@ def main_switch(commands):
         'esac')
 
 def install():
-    return ['complete -o default -F _stg stg']
+    return ['complete -o bashdefault -o default -F _stg stg 2>/dev/null \\', [
+            '|| complete -o default -F _stg stg' ] ]
 
 def write_completion(f):
     commands = stgit.commands.get_commands(allow_cached = False)
-- 
1.6.1.213.g28da8
