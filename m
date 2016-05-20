From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/11] completion: zsh: improve main function selection
Date: Thu, 19 May 2016 23:58:42 -0500
Message-ID: <1463720325-8853-9-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWe-0001bo-57
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbcETE65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35803 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcETE6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id w198so21095970oiw.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HLpYeCU6c16QhfSUc/TabDgs2xBXlYwvY3DVqhbtU2c=;
        b=pRThVgGXxKCB3bOwcd8aqLLDUHP3wDZl73sNQwNk+JNPTDsKWTyF1eCV1SNQgycz5b
         0tMEBbvFToXnrc1ioghZ3OMzqkUo1OwJjFpysXRQlRYJy/CqTThD1E4MQfw+Zh0TTzlq
         jBCTyXOoxTVUWO/yJgZAl5gRaawaX2kVqliglnZ1NOZOWIYJUMd4rdYwNE+sfUOPr4F2
         HZ3EsvhQpZ/iQFTwVm2gr7xL0QGe5u1AkJbK/dtl/whT2UvbZADXk/PE6aX1GY+Be01U
         Rt5m8X8o58HQxXSN52Ia60RjwVZ8OjTF5B8DgNydkhD0lywIaHM3dqp4lZR2Biut2NLw
         d+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HLpYeCU6c16QhfSUc/TabDgs2xBXlYwvY3DVqhbtU2c=;
        b=VTDQT/1qFBeBqpig5FRwa2QQWCIiLNI2L3L2qIaErxOYK0qHXJeJzD/gJAwfXsvQ8Q
         PATtP+o/ONQ7qDanzMR+0+m+LiDljftR+x4zqjfW5wPFOjPRwmfVv666Vpu1QUS4/0xJ
         H9w+z3gSU+qFnqJD9bWlzsO+iPnx5+3tB3XF6ayroTNBpPq8b2Jf8LbY8VVBYmbZElkI
         v1dANiZ9VfG2gLIMaUTykFhmrXzggklSGwKukrCArnwqKTt7lKwGgvGWbYVowAjbtPEc
         JoF+23dmN4kbSRgUyHlOZsIa9MO6FfF23EEUrgpZfc6Y+WObSQTxIdJ/PyD7P6mUbu/W
         U4MQ==
X-Gm-Message-State: AOPr4FV/cnqiZCjW3YknQv0INxLt83dm1pyUubkNmjYINyZKrVw/kxY2S7cDsahzbR5Pfg==
X-Received: by 10.157.31.78 with SMTP id x14mr624458otx.15.1463720334355;
        Thu, 19 May 2016 21:58:54 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id zb6sm4927900obb.29.2016.05.19.21.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295144>

Sometimes we want to use the function directly (e.g. _git_checkout), for
example when zsh has the option 'complete_aliases', this way, we can do
something like:

  compdef _git gco=git_checkout

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 317b8eb..1f786cc 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -204,8 +204,10 @@ _git ()
 
 	if (( $+functions[__${service}_zsh_main] )); then
 		__${service}_zsh_main
-	else
+	elif (( $+functions[__${service}_main] )); then
 		emulate ksh -c __${service}_main
+	elif (( $+functions[_${service}] )); then
+		emulate ksh -c _${service}
 	fi
 
 	let _ret && _default && _ret=0
-- 
2.8.0+fc1
