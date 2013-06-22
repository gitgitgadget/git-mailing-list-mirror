From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 12/14] t/t5510-fetch: don't use remotes-file
Date: Sat, 22 Jun 2013 13:28:19 +0530
Message-ID: <1371887901-5659-13-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqImr-0000th-T7
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935543Ab3FVIC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:58 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39005 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab3FVICH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:02:07 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so8777781pac.40
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eYrX3h1TxJb8d6HEycoPETKZGPbVNRXDU+KeoR9qFBg=;
        b=1D+z3p3YW54K9z2KnzUvWGuiCbCdnUKKqj570WK5JF5juTnFfrKrfuR8ONFDsvXyEw
         qCQjFExkFJ5EgE/OsoOkig97fELmSE43EFb80Ma63VomQpwzH27jU/YNI625XOR+Gsmx
         vf84W3kappcrPI2/+nlFDn5NuCgyKT5yQXrgg77hENzrkeVFqCw31p1ppliUjv27XY64
         hmKJI++2O+FqFF27HRd3uajqT5rZIf6zBU2qq2rF56suvVc3TzsJuQP9edY1FUMFAnav
         kRzxDUpSwP+YonWaeNNddma7N3DMFLaL2gWQ5vtgPufPXA7HRgSSi5TOpfsmIdB+D4Ca
         iZeQ==
X-Received: by 10.66.163.73 with SMTP id yg9mr18197890pab.77.1371888126778;
        Sat, 22 Jun 2013 01:02:06 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.02.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:02:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228690>

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
1.8.3.1.498.gacf2885
