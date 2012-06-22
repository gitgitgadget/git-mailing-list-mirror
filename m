From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4 v8] config: write to $XDG_CONFIG_HOME/git/config file if appropriate
Date: Fri, 22 Jun 2012 11:03:26 +0200
Message-ID: <1340355806-6894-5-git-send-email-Matthieu.Moy@imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 22 11:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shzma-0008S2-9u
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761801Ab2FVJDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 05:03:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60539 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761789Ab2FVJDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:03:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5M93Hnr001366
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 11:03:17 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ShzmK-0003hl-RR; Fri, 22 Jun 2012 11:03:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ShzmK-0001o0-QF; Fri, 22 Jun 2012 11:03:44 +0200
X-Mailer: git-send-email 1.7.11.rc3.235.gd0d1d08
In-Reply-To: <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jun 2012 11:03:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5M93Hnr001366
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340960600.36751@e41ZihuGSGTFsfAknkaHww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200426>

From: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>

Git will be able to write to $XDG_CONFIG_HOME/git/config, a new
configuration file following XDG specification, if:

 1. this file already exists, and

 2. $HOME/.gitconfig file doesn't, and

 3. The --global option is used.

Otherwise Git writes to $HOME/.gitconfig with the --global option, as
usual. If the user doesn't create $XDG_CONFIG_HOME/git/config, there is
absolutely no change. Users can use this new file only if they want.

If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/config
will be used.

Advice for users who often come back to an old version of Git: you
shouldn't create this file.

Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-config.txt |  3 ++-
 builtin/config.c             |  5 +----
 t/t1306-xdg-files.sh         | 30 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7e344a2..fb10082 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -97,7 +97,8 @@ OPTIONS
 
 --global::
 	For writing options: write to global ~/.gitconfig file rather than
-	the repository .git/config.
+	the repository .git/config, write to $XDG_CONFIG_HOME/git/config file
+	if this file exists and the ~/.gitconfig file doesn't.
 +
 For reading options: read only from global ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config rather than from all available files.
diff --git a/builtin/config.c b/builtin/config.c
index da54fd1..e8e1c0a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -387,10 +387,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		home_config_paths(&user_config, &xdg_config, "config");
 
-		if (access(user_config, R_OK) && !access(xdg_config, R_OK) &&
-		    (actions == ACTION_LIST ||
-		     actions == ACTION_GET_COLOR ||
-		     actions == ACTION_GET_COLORBOOL))
+		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
 			given_config_file = xdg_config;
 		else if (user_config)
 			given_config_file = user_config;
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index e8cd78a..3c75c3f 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -125,4 +125,34 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 '
 
 
+test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
+	mkdir -p "$HOME"/.config/git &&
+	>"$HOME"/.config/git/config &&
+	test_might_fail rm "$HOME"/.gitconfig &&
+	git config --global user.name "write_config" &&
+	echo "[user]" >expected &&
+	echo "	name = write_config" >>expected &&
+	test_cmp expected "$HOME"/.config/git/config
+'
+
+
+test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
+	>"$HOME"/.gitconfig &&
+	git config --global user.name "write_gitconfig" &&
+	echo "[user]" >expected &&
+	echo "	name = write_gitconfig" >>expected &&
+	test_cmp expected "$HOME"/.gitconfig
+'
+
+
+test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
+	test_might_fail rm "$HOME"/.gitconfig &&
+	test_might_fail rm "$HOME"/.config/git/config &&
+	git config --global user.name "write_gitconfig" &&
+	echo "[user]" >expected &&
+	echo "	name = write_gitconfig" >>expected &&
+	test_cmp expected "$HOME"/.gitconfig
+'
+
+
 test_done
-- 
1.7.11.rc3.235.gd0d1d08
