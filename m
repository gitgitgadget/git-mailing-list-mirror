From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 04/14] t/t5505-remote: remove dependency on $origin_url
Date: Sat, 22 Jun 2013 13:28:11 +0530
Message-ID: <1371887901-5659-5-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIlf-0007xk-7S
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423726Ab3FVIBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:51 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:61110 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423719Ab3FVIBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:50 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro2so8773000pbb.41
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nQyAGTFMvsSM7zo3ggdaR9mHT4wlCaIUOP1d3QIlJzA=;
        b=Wov4KgaL0/cQpM0wTT9WWLlGTPnK1bz3HKPCPH60QBM1PkpX6ZXO0+4NU1y8XhDlmC
         5w+9BjbR54yJa/JKuxrAq5J4e6QSfeNL0jom60kIjTB6AZ5rvL6Mp06IxcEA9xZfHS2p
         y/f2QsgG4qFHfrBEc4G0rzEoPe4KUcTwDH87v3KIZDiIPUBX0Jt5Ra/WaO7nZykdLQms
         rCKjEEAYq8jBtmR5bhb6MRZMUZ6Q1lJ+CbqgvWLpldvw6VEO33VzQENXnCs/2xXcwLnp
         lxTf8YOhIorM8cQbCXZv2eykTuf4cCSD3x9so/jXLVys5PsJhyXAO8arfTx0rMNy1Qii
         GNmg==
X-Received: by 10.68.222.233 with SMTP id qp9mr15526668pbc.63.1371888109680;
        Sat, 22 Jun 2013 01:01:49 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228680>

In the tests "migrate a remote from named file in
$GIT_DIR/{remotes,branches}", we are only checking that a configuration
is migrated successfully; it has no correspondence with whether or not
those values do something sensible with other git
operations (fetch/push).  Therefore, there is no need to determine
$origin_url: just substitute it with the constant value "quux".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d688662..13199d1 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -733,14 +733,13 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 '
 
 cat >remotes_origin <<-EOF
-URL: $(pwd)/one
+URL: quux
 Push: refs/heads/master:refs/heads/upstream
 Pull: refs/heads/master:refs/heads/origin
 EOF
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
-	origin_url=$(pwd)/one &&
 	(
 		cd five &&
 		git remote remove origin &&
@@ -748,7 +747,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 		cat ../remotes_origin >.git/remotes/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/remotes/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
+		test "$(git config remote.origin.url)" = "quux" &&
 		test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
 		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
 	)
@@ -756,14 +755,13 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	git clone one six &&
-	origin_url=$(pwd)/one &&
 	(
 		cd six &&
 		git remote rm origin &&
-		echo "$origin_url" >.git/branches/origin &&
+		echo "quux" >.git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
-		test "$(git config remote.origin.url)" = "$origin_url" &&
+		test "$(git config remote.origin.url)" = "quux" &&
 		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
 		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
 	)
-- 
1.8.3.1.498.gacf2885
