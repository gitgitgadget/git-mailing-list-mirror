From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Replace uses of "git-var" with "git var"
Date: Wed, 30 Jul 2008 13:48:33 -0400
Message-ID: <20080730174833.GZ5655@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 19:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOFnz-0005VK-Im
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 19:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYG3Rsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 13:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbYG3Rsk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 13:48:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbYG3Rsi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 13:48:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 976643C08B;
	Wed, 30 Jul 2008 13:48:36 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-69-248-23-23.hsd1.pa.comcast.net
 [69.248.23.23]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTPSA id 11E343C089; Wed, 30 Jul 2008 13:48:34 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: BC5C3AC4-5E5F-11DD-BE1D-CE28B26B55AE-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90822>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I noticed while reading the git send-email documentation that it mentioned
git-var -l.  I have hopefully fixed up all the places where git-var is used and
not broken anything.

 Documentation/git-send-email.txt |    2 +-
 contrib/examples/git-commit.sh   |    6 +++---
 contrib/examples/git-tag.sh      |    2 +-
 git-am.sh                        |    2 +-
 ident.c                          |    2 +-
 perl/Git.pm                      |    2 +-
 var.c                            |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index afbb294..e2437f3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -56,7 +56,7 @@ The --cc option must be repeated for each user you want on the cc list.
 
 --from::
 	Specify the sender of the emails.  This will default to
-	the value GIT_COMMITTER_IDENT, as returned by "git-var -l".
+	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
 	The user will still be prompted to confirm this entry.
 
 --in-reply-to::
diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 2c4a406..5c72f65 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -443,7 +443,7 @@ fi | git stripspace >"$GIT_DIR"/COMMIT_EDITMSG
 
 case "$signoff" in
 t)
-	sign=$(git-var GIT_COMMITTER_IDENT | sed -e '
+	sign=$(git var GIT_COMMITTER_IDENT | sed -e '
 		s/>.*/>/
 		s/^/Signed-off-by: /
 		')
@@ -535,8 +535,8 @@ esac
 
 case "$no_edit" in
 '')
-	git-var GIT_AUTHOR_IDENT > /dev/null  || die
-	git-var GIT_COMMITTER_IDENT > /dev/null  || die
+	git var GIT_AUTHOR_IDENT > /dev/null  || die
+	git var GIT_COMMITTER_IDENT > /dev/null  || die
 	git_editor "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
diff --git a/contrib/examples/git-tag.sh b/contrib/examples/git-tag.sh
index e9f3a22..2c15bc9 100755
--- a/contrib/examples/git-tag.sh
+++ b/contrib/examples/git-tag.sh
@@ -164,7 +164,7 @@ git check-ref-format "tags/$name" ||
 
 object=$(git rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git cat-file -t $object) || exit 1
-tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
+tagger=$(git var GIT_COMMITTER_IDENT) || exit 1
 
 test -n "$username" ||
 	username=$(git config user.signingkey) ||
diff --git a/git-am.sh b/git-am.sh
index 6aa8192..8f91a97 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -291,7 +291,7 @@ fi
 ws=`cat "$dotest/whitespace"`
 if test "$(cat "$dotest/sign")" = t
 then
-	SIGNOFF=`git-var GIT_COMMITTER_IDENT | sed -e '
+	SIGNOFF=`git var GIT_COMMITTER_IDENT | sed -e '
 			s/>.*/>/
 			s/^/Signed-off-by: /'
 		`
diff --git a/ident.c b/ident.c
index b35504a..09cf0c9 100644
--- a/ident.c
+++ b/ident.c
@@ -204,7 +204,7 @@ const char *fmt_ident(const char *name, const char *email,
 		if ((warn_on_no_name || error_on_no_name) &&
 		    name == git_default_name && env_hint) {
 			fprintf(stderr, env_hint, au_env, co_env);
-			env_hint = NULL; /* warn only once, for "git-var -l" */
+			env_hint = NULL; /* warn only once, for "git var -l" */
 		}
 		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
diff --git a/perl/Git.pm b/perl/Git.pm
index d99e778..087d3d0 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -730,7 +730,7 @@ This suite of functions retrieves and parses ident information, as stored
 in the commit and tag objects or produced by C<var GIT_type_IDENT> (thus
 C<TYPE> can be either I<author> or I<committer>; case is insignificant).
 
-The C<ident> method retrieves the ident information from C<git-var>
+The C<ident> method retrieves the ident information from C<git var>
 and either returns it as a scalar string or as an array with the fields parsed.
 Alternatively, it can take a prepared ident string (e.g. from the commit
 object) and just parse it.
diff --git a/var.c b/var.c
index 724ba87..f1eb314 100644
--- a/var.c
+++ b/var.c
@@ -5,7 +5,7 @@
  */
 #include "cache.h"
 
-static const char var_usage[] = "git-var [-l | <variable>]";
+static const char var_usage[] = "git var [-l | <variable>]";
 
 struct git_var {
 	const char *name;
-- 
1.6.0.rc1


-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I am not young enough to know everything.
    -- Oscar Wilde (1854-1900)
