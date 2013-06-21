From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/16] t/t5510-fetch: don't use remotes-file
Date: Fri, 21 Jun 2013 16:42:38 +0530
Message-ID: <1371813160-4200-15-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKf-0003xG-HB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416Ab3FULQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:41 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51710 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab3FULQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:28 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so7688004pac.12
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uW4nHsX8kiEzDhQR+PIiGHpIA/GZqGQQ0PXKt7sDivo=;
        b=bbNJLeBUyXUfhiuwSrI8OzZapx/ABgJsgdaShHJ9Tn8QFG7Jx4Y6/2TPkfhNjvNcoN
         otnRDEO875+98PP1mNJazVKbMshniK14ep0fHEZYpKxqhP+vIGkIJyGi/6MUYN2nO2hU
         eQup9Ut26DTbfhav10BKamYBNeO9yj3H7ZHB8sibVOAVJzekOUc9Cwtpr+0Ds2lrlUEp
         xQV0A2tFbHVWTNf0s6UzYbH4qM2ZXm3Pd5YA22Vq1Yc0YF2VStaQgsS1eYrVmQAz9X+z
         eoS+RK0fgG0VHVQXs6wB2gKa/R88ZLrgaD7M7d7Ilau7x9EK7SfZ7VSoIuvi5z0f4T/c
         sYkQ==
X-Received: by 10.68.59.98 with SMTP id y2mr11926969pbq.135.1371813387714;
        Fri, 21 Jun 2013 04:16:27 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228607>

Replace it with the equivalent gitconfig configuration, using the
results of a test in t/t5505-remote.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5510-fetch.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fde6891..47aeac2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -46,12 +46,9 @@ test_expect_success "clone and setup child repos" '
 		cd three &&
 		git config branch.master.remote two &&
 		git config branch.master.merge refs/heads/one &&
-		mkdir -p .git/remotes &&
-		{
-			echo "URL: ../two/.git/"
-			echo "Pull: refs/heads/master:refs/heads/two"
-			echo "Pull: refs/heads/one:refs/heads/one"
-		} >.git/remotes/two
+		git config remote.two.url "../two/.git/" &&
+		git config remote.two.fetch "refs/heads/master:refs/heads/two" &&
+		git config --add remote.two.fetch "refs/heads/one:refs/heads/one"
 	) &&
 	git clone . bundle &&
 	git clone . seven
-- 
1.8.3.1.499.g7ad3486.dirty
