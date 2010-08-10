From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 1/9] stash: refactor - create pop_stash function
Date: Tue, 10 Aug 2010 10:04:40 +1000
Message-ID: <1281398688-21008-2-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicML-0001TU-5F
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336Ab0HJAGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38370 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab0HJAGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:04 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so3864421pzk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VdWp/7HcrZ2YvFPfyghtvq078VdWNw96ZVoF2zpj4nY=;
        b=dD/IXeU0/7JHit7/jxkYlVQjqy8WzVyF3ZMaxekpA//rVY8unN+IsgeFyzM0K/4UyP
         zIuXevkBsfN0YEb/OS5v6+Vynx+vgVZxCqacp46eVRwFLGDSe6M6XlAKP8TGfC9WngSn
         T2YKLtph5iRjb1wreDLBdkqRLjj6YX2oS6Ct8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WlqsVf+Lz7iwFG3DVHx2WSsSNOWDrw7DYcHvnSsVcECujaw6WsMgNifB8Mvsn7jJWP
         jRvGQFDOEKViPXlFqn4BaxAbmlVTGhbEWnsUcUHhX6+x0X5hRfwSrx/531j0DAJdwMAk
         5upxOWqw4AAjyylvOPexHSB6ummUinnKyhxUE=
Received: by 10.142.177.4 with SMTP id z4mr14565145wfe.280.1281398764470;
        Mon, 09 Aug 2010 17:06:04 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.05.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153059>

We plan to edit pop_stash later, so let's make it a first class
command by giving its own implementation function.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1d95447..31ea333 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -323,6 +323,13 @@ apply_stash () {
 	fi
 }
 
+pop_stash() {
+	if apply_stash "$@"
+	then
+		drop_stash "$applied_stash"
+	fi
+}
+
 drop_stash () {
 	have_stash || die 'No stash entries to drop'
 
@@ -422,10 +429,7 @@ drop)
 	;;
 pop)
 	shift
-	if apply_stash "$@"
-	then
-		drop_stash "$applied_stash"
-	fi
+	pop_stash "$@"
 	;;
 branch)
 	shift
-- 
1.6.5.rc3.8.g8ba5e
