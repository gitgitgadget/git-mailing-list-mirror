From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 2/3] Testing: XDG config files: Use "$HOME" and
                              "$XDG_CONFIG_HOME" explicitly
Date: Tue, 17 Jul 2012 16:41:21 -0000
Message-ID: <e118f47351094d4fb45dd34bc08b9e9b-mfwitten@gmail.com>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:45:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrBpY-0000w1-9V
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 19:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab2GQRo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 13:44:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32915 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab2GQRo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 13:44:57 -0400
Received: by wibhr14 with SMTP id hr14so655085wib.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=DwGxZr4f2o3y+xfzsogp95ea34exntpiT/hoFM2JsAc=;
        b=eQ8UdetN6kALPacxgx95oh2TajUmdGPFaVy4Bxd5NpV33+kCIC3f4A4TlVuakKGxQf
         LwAN4OOgZV8Kb/Vr32Pvkg3Cv+NRbE8kf2/28YXzsgCd4WoGX7kwcjwDaEzAK7dY506B
         dWDOCTSY9dQwHz1nQTHBp4RbGqK8nhALfB0svUtGfxFxAZDfEm0DDQ/MWGJbBiL2Th7j
         8RmAwkbM5n9myqcQue8OIRA2zqnRVQkCDQXcLocPQNpLjDOJuabEuLRTNQOgX4e4i4BP
         fqT28uDIL5Oe27g6ZkGXJsy6L8NHYDKD4N7uNttcfw8vDX5AF+1Jns+uFFm9n0JMJ9tD
         MvkQ==
Received: by 10.216.200.201 with SMTP id z51mr1969157wen.0.1342547095762;
        Tue, 17 Jul 2012 10:44:55 -0700 (PDT)
Received: from gmail.com (saito.countshockula.com. [65.183.151.13])
        by mx.google.com with ESMTPS id b7sm41500188wiz.9.2012.07.17.10.44.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 10:44:55 -0700 (PDT)
In-Reply-To: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201612>

The tests in:

  t/t1306-xdg-files.sh

relied on brittle conventions:

  * "$HOME" and "$XDG_CONFIG_HOME" having certain values.

  * The testing commands having a certain current working
    directory; at least one test failed as a result.

This commit mitigates the problem by using the variables "$HOME"
and "$XDG_CONFIG_HOME" explicitly.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 t/t1306-xdg-files.sh | 69 +++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 3c75c3f..2327047 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -9,58 +9,60 @@ test_description='Compatibility with $XDG_CONFIG_HOME/git/ files'
 
 . ./test-lib.sh
 
+GIT_CONFIG_DIR=$XDG_CONFIG_HOME/git
+
-test_expect_success 'read config: xdg file exists and ~/.gitconfig doesn'\''t' '
+test_expect_success 'read config: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
-	mkdir -p .config/git &&
+	mkdir -p "$GIT_CONFIG_DIR" &&
-	echo "[alias]" >.config/git/config &&
+	echo "[alias]" >"$GIT_CONFIG_DIR"/config &&
-	echo "	myalias = !echo in_config" >>.config/git/config &&
+	echo "	myalias = !echo in_config" >>"$GIT_CONFIG_DIR"/config &&
 	echo in_config >expected &&
 	git myalias >actual &&
 	test_cmp expected actual
 '
 
 
-test_expect_success 'read config: xdg file exists and ~/.gitconfig exists' '
+test_expect_success 'read config: xdg file exists and "$HOME"/.gitconfig exists' '
-	>.gitconfig &&
+	>"$HOME"/.gitconfig &&
-	echo "[alias]" >.gitconfig &&
+	echo "[alias]" >"$HOME"/.gitconfig &&
-	echo "	myalias = !echo in_gitconfig" >>.gitconfig &&
+	echo "	myalias = !echo in_gitconfig" >>"$HOME"/.gitconfig &&
 	echo in_gitconfig >expected &&
 	git myalias >actual &&
 	test_cmp expected actual
 '
 
 
-test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''t' '
+test_expect_success 'read with --get: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
-	rm .gitconfig &&
+	rm "$HOME"/.gitconfig &&
-	echo "[user]" >.config/git/config &&
+	echo "[user]" >"$GIT_CONFIG_DIR"/config &&
-	echo "	name = read_config" >>.config/git/config &&
+	echo "	name = read_config" >>"$GIT_CONFIG_DIR"/config &&
 	echo read_config >expected &&
 	git config --get user.name >actual &&
 	test_cmp expected actual
 '
 
 
-test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
+test_expect_success 'read with --get: xdg file exists and "$HOME"/.gitconfig exists' '
-	>.gitconfig &&
+	>"$HOME"/.gitconfig &&
-	echo "[user]" >.gitconfig &&
+	echo "[user]" >"$HOME"/.gitconfig &&
-	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo "	name = read_gitconfig" >>"$HOME"/.gitconfig &&
 	echo read_gitconfig >expected &&
 	git config --get user.name >actual &&
 	test_cmp expected actual
 '
 
 
-test_expect_success 'read with --list: xdg file exists and ~/.gitconfig doesn'\''t' '
+test_expect_success 'read with --list: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
-	rm .gitconfig &&
+	rm "$HOME"/.gitconfig &&
 	echo user.name=read_config >expected &&
 	git config --global --list >actual &&
 	test_cmp expected actual
 '
 
 
-test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists' '
+test_expect_success 'read with --list: xdg file exists and "$HOME"/.gitconfig exists' '
-	>.gitconfig &&
+	>"$HOME"/.gitconfig &&
-	echo "[user]" >.gitconfig &&
+	echo "[user]" >"$HOME"/.gitconfig &&
-	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo "	name = read_gitconfig" >>"$HOME"/.gitconfig &&
 	echo user.name=read_gitconfig >expected &&
 	git config --global --list >actual &&
 	test_cmp expected actual
@@ -75,8 +77,8 @@ test_expect_success 'Setup' '
 
 
 test_expect_success 'Exclusion of a file in the XDG ignore file' '
-	mkdir -p "$HOME"/.config/git/ &&
+	mkdir -p "$GIT_CONFIG_DIR" &&
-	echo to_be_excluded >"$HOME"/.config/git/ignore &&
+	echo to_be_excluded >"$GIT_CONFIG_DIR"/ignore &&
 	test_must_fail git add to_be_excluded
 '
 
@@ -89,7 +91,7 @@ test_expect_success 'Exclusion in both XDG and local ignore files' '
 
 test_expect_success 'Exclusion in a non-XDG global ignore file' '
 	rm .gitignore &&
-	echo >"$HOME"/.config/git/ignore &&
+	echo >"$GIT_CONFIG_DIR"/ignore &&
 	echo to_be_excluded >"$HOME"/my_gitignore &&
 	git config core.excludesfile "$HOME"/my_gitignore &&
 	test_must_fail git add to_be_excluded
@@ -100,7 +102,7 @@ test_expect_success 'Checking attributes in the XDG attributes file' '
 	echo foo >f &&
 	git check-attr -a f >actual &&
 	test_line_count -eq 0 actual &&
-	echo "f attr_f" >"$HOME"/.config/git/attributes &&
+	echo "f attr_f" >"$GIT_CONFIG_DIR"/attributes &&
 	echo "f: attr_f: set" >expected &&
 	git check-attr -a f >actual &&
 	test_cmp expected actual
@@ -125,18 +127,18 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 '
 
 
-test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
+test_expect_success 'write: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
-	mkdir -p "$HOME"/.config/git &&
+	mkdir -p "$GIT_CONFIG_DIR" &&
-	>"$HOME"/.config/git/config &&
+	>"$GIT_CONFIG_DIR"/config &&
 	test_might_fail rm "$HOME"/.gitconfig &&
 	git config --global user.name "write_config" &&
 	echo "[user]" >expected &&
 	echo "	name = write_config" >>expected &&
-	test_cmp expected "$HOME"/.config/git/config
+	test_cmp expected "$GIT_CONFIG_DIR"/config
 '
 
 
-test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
+test_expect_success 'write: xdg file exists and "$HOME"/.gitconfig exists' '
 	>"$HOME"/.gitconfig &&
 	git config --global user.name "write_gitconfig" &&
 	echo "[user]" >expected &&
@@ -145,14 +147,15 @@ test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
 '
 
 
-test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
+test_expect_success 'write: "$XDG_CONFIG_HOME/git" exists and config file doesn'\''t' '
 	test_might_fail rm "$HOME"/.gitconfig &&
-	test_might_fail rm "$HOME"/.config/git/config &&
+	test_might_fail rm "$GIT_CONFIG_DIR"/config &&
 	git config --global user.name "write_gitconfig" &&
 	echo "[user]" >expected &&
 	echo "	name = write_gitconfig" >>expected &&
 	test_cmp expected "$HOME"/.gitconfig
 '
 
+unset GIT_CONFIG_DIR
 
 test_done
-- 
1.7.11.1.29.gf71be5c
