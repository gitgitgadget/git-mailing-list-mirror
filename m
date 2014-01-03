From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Fri,  3 Jan 2014 13:30:30 +0530
Message-ID: <1388736031-6068-4-git-send-email-artagnon@gmail.com>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 09:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyzgX-0005Md-S9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 09:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaACIAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 03:00:47 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36208 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaACIAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 03:00:45 -0500
Received: by mail-pa0-f41.google.com with SMTP id lf10so15587012pab.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 00:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ty517OIAigdkQ7E+PNhE9AIGbyIi0T8sPYKaLY2bz+o=;
        b=JYtO6kPh/7agy8Vv+R4uC6askSlVOyELEdn1JXvrk/3FjOV/0dm3E9eZnfRqXodsTR
         Th3iTGXNRNcrsIo1H4lwSTuN0JiFSqhnxoVxuz1vJCEUU9hjU75iKL0rWdVaQk5ej1l4
         sISeGksDQa2Osakq1rhyjZuWVapRixX6PBRB1iBWBSp0xBCdPgPcWvLso7tTn/yJAnh9
         2NbOp1tjcKcXPECYmWe8EwE6CqgBTESqwsDlyJyJp4TJCIoWTYSpOkHrS7XDYjqC5gNc
         0jBzDywySq+xzK6JFtF1H4CnxIsI127xiXoQTegSRQvdRdUh+ie+yidNrOr9MOpKYgNm
         vvLw==
X-Received: by 10.66.182.199 with SMTP id eg7mr93764983pac.135.1388736043380;
        Fri, 03 Jan 2014 00:00:43 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id gf5sm106943913pbc.22.2014.01.03.00.00.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 00:00:42 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239908>

When attempting to complete

  $ git config branch.auto<TAB>

'autosetupmerge' and 'autosetuprebase' don't come up. This is because
"$cur" is matched with "branch.*" and a list of branches are
completed. Add 'autosetup(merge|rebase)' to the list of branches using
__gitcomp_2 ().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64b20b8..cbb4eca 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1856,7 +1856,9 @@ _git_config ()
 		;;
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_2 "$(__git_heads)" "
+			autosetupmerge autosetuprebase
+			" "$pfx" "$cur_" "."
 		return
 		;;
 	guitool.*.*)
-- 
1.8.5.2.227.g53f3478
