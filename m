From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/16] t/t5505-remote: remove dependency on $origin_url
Date: Fri, 21 Jun 2013 16:42:28 +0530
Message-ID: <1371813160-4200-5-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKB-0003IJ-QA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965602Ab3FULQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:09 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54359 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965513Ab3FULQG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:06 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so7658292pbc.4
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K0ICiUZP/LrTt8Jke1cwQs6Ekod9SIEUfsbZvN5V1w8=;
        b=MT8Es3VC/16lwASdINDZHHf9Yg032V2ZEmhuZvDdr+wBMFENd4uG/NHYLJXkND3HJc
         MqhwaPmm9JgjmB1NlG4w3fX3bwbpnIM0SByyij9xnxiq3scl+rpZVBeQzyvsKoLCQ1Kk
         Y/RK/uccvRoebepAAhwK+gO7ybgDesgsf6ojbOQtoYXgiZw3ZoKlxWlQQakyi11LMh7h
         epW5zEvOMSHw2p2pscj1gUveWbjqfCHI2UjMoWh6b0jhq6rIe0YJRpahyR6Pgzo9PYKm
         A8v7lwoJt6TDQrI/8T4RIzAQY/W9kxVHfQYojc+l6FiyJ035mhm1It93849gldxl36Q+
         GMEg==
X-Received: by 10.66.131.46 with SMTP id oj14mr15663785pab.111.1371813366023;
        Fri, 21 Jun 2013 04:16:06 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228597>

In the tests "migrate a remote from named file in
$GIT_DIR/{remotes,branches}", we are only checking that a configuration
is migrated successfully; it has no correspondence with whether or not
those values do something sensible with other git
operations (fetch/push).  Therefore, there is no need to determine
$origin_url: just substitute it with the constant value "quux".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dcb6c2f..fd0a81e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -669,21 +669,20 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 '
 
 cat > remotes_origin << EOF
-URL: $(pwd)/one
+URL: quux
 Push: refs/heads/master:refs/heads/upstream
 Pull: refs/heads/master:refs/heads/origin
 EOF
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
-	origin_url=$(pwd)/one &&
 	(cd five &&
 	 git remote remove origin &&
 	 mkdir -p .git/remotes &&
 	 cat ../remotes_origin > .git/remotes/origin &&
 	 git remote rename origin origin &&
 	 test_path_is_missing .git/remotes/origin &&
-	 test "$(git config remote.origin.url)" = "$origin_url" &&
+	 test "$(git config remote.origin.url)" = "quux" &&
 	 test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
 	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
 '
@@ -694,10 +693,10 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	(
 		cd six &&
 		git remote rm origin &&
-		echo "$origin_url" > .git/branches/origin &&
+		echo quux > .git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
+		test "$(git config remote.origin.url)" = "quux" &&
 		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
 		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
 	)
-- 
1.8.3.1.499.g7ad3486.dirty
