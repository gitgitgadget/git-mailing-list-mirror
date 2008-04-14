From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - possibly use remote branch to describe a module
Date: Mon, 14 Apr 2008 19:52:34 -0400
Message-ID: <1208217154-992-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 01:53:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlYUJ-00079I-B0
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 01:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbYDNXwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757101AbYDNXwk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 19:52:40 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:63946 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbYDNXwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 19:52:39 -0400
Received: by an-out-0708.google.com with SMTP id d31so473049and.103
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=33X8YpgDh8v/OZs6GZqfuma31Ys8iU7gpYZalRXckR4=;
        b=Sbz7sZCSD4eMudx0ugzuB9V4lg/dnxyrsMCweiYTmTk3Kdm5RZZOa4ceQtk3B6jJpUYmOPly+p1REfBuFwP+7S4yCjanLXwR2HlAHo8fe3Slq5AqCcrufye2/sf58PrHqeJjViTMTSorJwjDb5qHdt5P4+OmEY/JIEnXKJGwKkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OwEmDMLdh2o28SZBr6JU5GCyuVOZF4JXilgZZTBu04MUpxv9KGIb8cFlmH+Q8tq6mRdqeVhT78ns8CoOeq/Cpb9yM769AXoM21ZIzHIhCvK84zO/nraDvHQLUueaoHXqxbYAUjaxYLzyacVIA/GCHaRe1p518lGGH5eXX2TJ0cw=
Received: by 10.100.248.9 with SMTP id v9mr13383049anh.86.1208217158128;
        Mon, 14 Apr 2008 16:52:38 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.252.223])
        by mx.google.com with ESMTPS id 13sm16230394wrl.39.2008.04.14.16.52.36
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 16:52:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.65.gf482
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79542>

Absent user intervention, git-submodule will maintain submodules as
headless checkouts of remote branches: such checkouts cannot be described
with reference to any local branch. So, allow describing the submodule
using remote branches before falling back on just using the commit id.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 28509ea..af195a7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -389,7 +389,8 @@ set_name_rev () {
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains --tags --always "$2"
+			git describe --contains "$2" 2>/dev/null ||
+			git describe --all --always "$2"
 		}
 	) )
 	test -z "$revname" || revname=" ($revname)"
-- 
1.5.5.65.gf482
