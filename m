From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/4 v8] Let core.attributesfile default to $XDG_CONFIG_HOME/git/ignore
Date: Fri, 22 Jun 2012 11:03:25 +0200
Message-ID: <1340355806-6894-4-git-send-email-Matthieu.Moy@imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 22 11:04:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shzma-0008S2-P4
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761808Ab2FVJD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 05:03:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60550 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761803Ab2FVJD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:03:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5M93FAs001358
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 11:03:15 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ShzmI-0003hJ-Un; Fri, 22 Jun 2012 11:03:42 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ShzmI-0001nx-Ta; Fri, 22 Jun 2012 11:03:42 +0200
X-Mailer: git-send-email 1.7.11.rc3.235.gd0d1d08
In-Reply-To: <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jun 2012 11:03:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5M93FAs001358
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340960600.35898@vmeAoslopzAsAdGGPgZQgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200428>

From: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>

To use the feature of core.attributesfile, the user needs:

 1. to create such a file,

 2. and add configuration variable to point at it.

Instead, we can make this a one-step process by choosing a default value
which points to a filename in the user's $HOME, that is unlikely to
already exist on the system, and only use the presence of the file as a
cue that the user wants to use that feature.

We use "${XDG_CONFIG_HOME:-$HOME/.config/git}/ignore" as a default value.
It goes in the same directory as the newly added configuration
file ("${XDG_CONFIG_HOME:-$HOME/.config/git}/config), and follows the XDG
specification.

Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

The commit message is amlost identical to the previous one to make the
patch self-contained, but this can be changed to something shorter
like "like the previous patch, we set the default avlue ..." if needed.

 Documentation/config.txt        |  4 +++-
 Documentation/gitattributes.txt |  2 ++
 attr.c                          | 17 ++++++++++-------
 t/t1306-xdg-files.sh            | 29 +++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 20e9531..db07459 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -500,7 +500,9 @@ core.attributesfile::
 	In addition to '.gitattributes' (per-directory) and
 	'.git/info/attributes', git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
-	way as for `core.excludesfile`.
+	way as for `core.excludesfile`. Its default value is
+	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
+	set or empty, $HOME/.config/git/attributes is used instead.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 80120ea..e16f3e1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -75,6 +75,8 @@ repositories (i.e., attributes of interest to all users) should go into
 `.gitattributes` files. Attributes that should affect all repositories
 for a single user should be placed in a file specified by the
 `core.attributesfile` configuration option (see linkgit:git-config[1]).
+Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME
+is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
diff --git a/attr.c b/attr.c
index 303751f..aef93d8 100644
--- a/attr.c
+++ b/attr.c
@@ -497,6 +497,7 @@ static int git_attr_system(void)
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
+	char *xdg_attributes_file;
 
 	if (attr_stack)
 		return;
@@ -515,13 +516,15 @@ static void bootstrap_attr_stack(void)
 		}
 	}
 
-	if (git_attributes_file) {
-		elem = read_attr_from_file(git_attributes_file, 1);
-		if (elem) {
-			elem->origin = NULL;
-			elem->prev = attr_stack;
-			attr_stack = elem;
-		}
+	if (!git_attributes_file) {
+		home_config_paths(NULL, &xdg_attributes_file, "attributes");
+		git_attributes_file = xdg_attributes_file;
+	}
+	elem = read_attr_from_file(git_attributes_file, 1);
+	if (elem) {
+		elem->origin = NULL;
+		elem->prev = attr_stack;
+		attr_stack = elem;
 	}
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 05103f5..e8cd78a 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -96,4 +96,33 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 '
 
 
+test_expect_success 'Checking attributes in the XDG attributes file' '
+	echo foo >f &&
+	git check-attr -a f >actual &&
+	test_line_count -eq 0 actual &&
+	echo "f attr_f" >"$HOME"/.config/git/attributes &&
+	echo "f: attr_f: set" >expected &&
+	git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'Checking attributes in both XDG and local attributes files' '
+	echo "f -attr_f" >.gitattributes &&
+	echo "f: attr_f: unset" >expected &&
+	git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'Checking attributes in a non-XDG global attributes file' '
+	test_might_fail rm .gitattributes &&
+	echo "f attr_f=test" >"$HOME"/my_gitattributes &&
+	git config core.attributesfile "$HOME"/my_gitattributes &&
+	echo "f: attr_f: test" >expected &&
+	git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
+
 test_done
-- 
1.7.11.rc3.235.gd0d1d08
