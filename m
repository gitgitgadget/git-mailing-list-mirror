From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: simplify __git_complete_revlist_file
Date: Tue,  1 May 2012 20:42:56 +0200
Message-ID: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 20:43:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPI31-0004gd-81
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373Ab2EASnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 14:43:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51922 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168Ab2EASne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:43:34 -0400
Received: by wibhq7 with SMTP id hq7so4034980wib.1
        for <git@vger.kernel.org>; Tue, 01 May 2012 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rTVvR87/QkcV6UMcpqPv9g5BUe1H8JYGYvIFQ3x+noE=;
        b=kpFnJt+rwqGcIyx6zabBd1AwrU4vkDkb30Lvft0n5vfH1i7VshsCeD3mLoGWYSg10M
         C+mP0cq72yHLpKh8ItdGz3YBrZf2RalKwczgd2ERNAzGLMzyxgOAgI90uEqlpIDSz4+p
         EKADPhRsEuV2w/9nz9ZMEtCtNt3QEhmwuZKptOXkrhJgrZu3Hyc5sScXyAEBq5xFv5Hc
         sJwHVjOsm+3HUI7jSQXU0J8N+AxPzLsR2qZdZTOU0Craz5VyH0CdwdV5/gXDUOCVm8cH
         /1rbwChF8BcV55dKFY7BxrTWlrSJTAPxKWVi7/asJJA1lHTbdc4Dr0lg+AgcWpxbwfX/
         Dj8g==
Received: by 10.180.81.135 with SMTP id a7mr7219426wiy.16.1335897813452;
        Tue, 01 May 2012 11:43:33 -0700 (PDT)
Received: from localhost (gateway02.m3-connect.de. [88.79.237.12])
        by mx.google.com with ESMTPS id b3sm38347416wib.4.2012.05.01.11.43.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 11:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196725>

Use new __gitcomp_nl; this is the last place that uses COMPREPLY and
compgen directly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..d877a23 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -676,9 +676,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "$pfx" \
-			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
+		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -692,7 +690,7 @@ __git_complete_revlist_file ()
 				           s,$,/,
 				       }
 				       s/^.*	//')" \
-			-- "$cur_"))
+			"$pfx" "$cur_" ""
 		;;
 	*...*)
 		pfx="${cur_%...*}..."
-- 
1.7.10
