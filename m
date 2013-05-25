From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 27/48] remote-hg: add test for new bookmark special
Date: Fri, 24 May 2013 21:29:43 -0500
Message-ID: <1369449004-17981-28-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4ID-0002JM-BD
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab3EYCdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:07 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38864 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab3EYCdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:05 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so6841521oag.23
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uXAIHmFbqXEChSc1f0uPBvyLk99tfRZ4JlHY5l3hnfs=;
        b=THBMt8B7vHMGdYBGWCRUV7RTlHhoBuOkl6wsl5g7qZXHNcqoM9cF04oBxmb3aEZ86K
         joDekhzMnikvzNLDLW4SPR4R6aJ4zD9PwWcBMpijgf/s38zfdvpxjRkvlk7Tg+s6NUxs
         CoFBSorMVNjp27kSB0SuNloSqnui+1mG/lBCjHeFsGO8cG+KQqL1Qohm1PqnNrEfxQwD
         FkQSL3OkXBuyOUFmt5YCKchPll+lMVn/x9KLV8DYoiixjXJMJXe5HNDQWWalnYa0EHQd
         yW51JfWRiVUzISOP0WXiHUTHXCtVWk4Ja4UEeveHU7V16NFfnketIPIY53Lh/t02ohZw
         uREw==
X-Received: by 10.182.78.41 with SMTP id y9mr13326081obw.69.1369449185061;
        Fri, 24 May 2013 19:33:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20595857oep.1.2013.05.24.19.33.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225441>

>From the point of view of Mercurial, this creates a new branch head, and
requires a forced push.

Ideally, whoever, we would want it to work just like in git; new
branches can be pushed without problems.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index e059bbc..64f0849 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -370,4 +370,19 @@ test_expect_failure 'remote update bookmark diverge' '
 	check_bookmark hgrepo diverge "bump bookmark"
 '
 
+test_expect_failure 'remote new bookmark multiple branch head' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-c HEAD^ &&
+	echo feature-c > content &&
+	git commit -a -m feature-c &&
+	git push --quiet origin feature-c
+	) &&
+
+	check_bookmark hgrepo feature-c feature-c
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
