From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 5/8] t7201.24: Add refspec to keep --track working
Date: Sun, 21 Apr 2013 23:52:03 +0200
Message-ID: <1366581126-3880-6-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2By-0000Ui-GA
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab3DUVwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:54 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:54260 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3DUVww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:52 -0400
Received: by mail-la0-f46.google.com with SMTP id ep20so1066087lab.19
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2YcRQdJlDAfpms4Pj4gqHOzIK3BGrEtNKk+8IEfwfR4=;
        b=aReqzXrOHKIV/em1qfu2fZ9rFzGSa7GKpmMFYQzbmerFl59tn/Ifq3ZkIAICD/V4Ke
         cACta4PnW4IXe4T9rxHGKuaxJyhW7oBZfFftDFYrpa1CmA5NlCpS9F2Y0qlPm7FOaZW5
         CjA+6Bczjn5A1sOOIVEZpv+XTkbFZKMnXZAW/Il6pt4tERDB7bp0T33htwQJMQFZzE47
         G4OWzcbxGjSdmaGIWnSs6DfNEoxDWE3TKIZ83ZWXHDa/vpdiM/1LXabA7qWQZpBKwgMz
         XSGfllswTElLzG7K3Fm9bpS63Kojo8LSUD1SAsx6ujS9L0Y+Fyt/9IDWY7Nlkw5moAe7
         F23w==
X-Received: by 10.112.173.169 with SMTP id bl9mr11693618lbc.37.1366581171108;
        Sun, 21 Apr 2013 14:52:51 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221974>

We are formalizing a requirement that any remote-tracking branch to be used
as an upstream (i.e. as an argument to --track), _must_ "belong" to a
configured remote by being matched by the "dst" side of a fetch refspec.

Without this patch, this test would start failing when the new behavior is
introduced.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7201-co.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index be9672e..0c9ec0a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -431,6 +431,7 @@ test_expect_success 'detach a symbolic link HEAD' '
 
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
+    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
     git update-ref refs/remotes/origin/koala/bear renamer &&
 
     git checkout --track origin/koala/bear &&
-- 
1.8.1.3.704.g33f7d4f
