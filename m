From: Christian Jaeger <chrjae@gmail.com>
Subject: [PATCH] gitk: Refresh the index
Date: Sun, 27 Sep 2009 19:43:11 -0400
Message-ID: <b53c9c0e96f4967935f6c36cd4b2655d22de7cef.1254093602.git.chrjae@gmail.com>
Cc: Christian Jaeger <chrjae@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 01:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms3PP-0003eq-2i
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 01:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZI0Xnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 19:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZI0Xni
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 19:43:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:55737 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZI0Xni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 19:43:38 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1432757qwd.37
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6FkpUtiC/d9ro3MDn8k/1W/TyDOlO2PltCUFGETUznY=;
        b=JhLcI7IoOmrhqyVHpNUMDYVodVr7CM9p1L2hR0DoMqcAsuy9nmUM9mVlttEjVNfQ3b
         r/dsiNkYAS3aIz2jq4dDQezxj57xsdkx0U8bXz1pqsXlk+vnygcYeVmy+fQNW5b+//Xr
         pRT/CNHmqtpeUnZtbHrRQVmC/KLitlJ7iPAK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rnQfF8v5EhCXqer7rU3gAIhfR8Dv7O/yoW1G6hQ1fVM82fax394oek1oSiToqq4boQ
         LLEdCHYp3CNIlQm81NeWhS3xz3fr6nOD+Jlxcy0mKzVMo3/76QVY2Cu5zSHSXxAKOXHj
         VaqJ2cJbhnkZYwF+0Ok/FfpQ4nwyV2X/Dci6s=
Received: by 10.224.70.133 with SMTP id d5mr2126526qaj.211.1254095021951;
        Sun, 27 Sep 2009 16:43:41 -0700 (PDT)
Received: from localhost.localdomain (69-196-152-229.dsl.teksavvy.com [69.196.152.229])
        by mx.google.com with ESMTPS id 26sm6975784qwa.9.2009.09.27.16.43.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 27 Sep 2009 16:43:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129221>

If one or more tracked files changed non-tracked metadata like mtime,
gitk would report it as "Local uncommitted changes, not checked in to
index" even if no actual changes have been made. (Clicking on the
"Local uncommitted changes.." entry would show the file but without
any diff.)

This refreshes the index in readdiffindex to avoid this and make gitk
behave more like "git status" instead.

Signed-off-by: Christian Jaeger <chrjae@gmail.com>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

 * NOTE: I'm not subscribed to the mailing list. *

diff --git a/gitk b/gitk
index a0214b7..bb0e8e1 100755
--- a/gitk
+++ b/gitk
@@ -4898,6 +4898,7 @@ proc readdiffindex {fd serial inst} {
     }
 
     # now see if there are any local changes not checked in to the index
+    exec git update-index -q --refresh
     set cmd "|git diff-files"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
-- 
1.6.4.4
