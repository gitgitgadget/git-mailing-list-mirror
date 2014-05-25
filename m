From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH] t9138-git-svn-authors-prog.sh fixups
Date: Sun, 25 May 2014 12:24:54 -0700
Message-ID: <1401045894-22711-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 21:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Woe3X-0004b2-45
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 21:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbaEYTZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 15:25:57 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61396 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaEYTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 15:25:56 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so6573729pab.28
        for <git@vger.kernel.org>; Sun, 25 May 2014 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9OXqu04kIWw8nXEM1GkgKhWg8pWNG2Yn0FaOBcI01IQ=;
        b=nxqv+AnAIl2OvDDcj1gDpp4MesiowqMR8AUy/ivUo8+aEQyvPk2tiwk+ZB7NcBPrXz
         nzMjY6nBDya9JeXndAFOCVreQbq4M8TbUqI0FnuBc7dGywtrKn2s5GowJE09zG1IYjNy
         F3pAoHrUHpGZ1aKYbMy4TgE+1Y9sBpkwnvbc+FcC7Un/UXPn8Nfx/e/gD7M1e1dlpYOa
         5WyYh3WhgUB4Z9RzJM1U5IUNW06gOY4FMhxkVMNSXf3iBU8H74v6w6vwDvXCpnDph3fX
         82pZcKx++QOrBYOlp5JlNDQ6+O34MbdCL4MM45qKydFhmVCsz1NsSr7eqGW+dZaZtn9a
         G9XQ==
X-Received: by 10.68.233.37 with SMTP id tt5mr22576566pbc.154.1401045956013;
        Sun, 25 May 2014 12:25:56 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wq10sm47052927pac.24.2014.05.25.12.25.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 25 May 2014 12:25:54 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 25 May 2014 12:25:50 -0700
X-Mailer: git-send-email 2.0.0.rc4.1.g4a28f16.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250087>

Several fixups of the t9138-git-svn-authors-prog.sh test script to
follow current recommendations in t/README.

  - Fixed a Perl script with a full "#!/usr/bin/perl" shebang
    to use write_script() and $PERL_PATH as per t/README.

  - Placed svn-authors data setup inside a test_expect_success.

  - Fixed trailing quotes to use the same indentation throughout.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 t/t9138-git-svn-authors-prog.sh | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 83cc5fc..d54c37a 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -7,40 +7,39 @@ test_description='git svn authors prog tests'
 
 . ./lib-git-svn.sh
 
-cat > svn-authors-prog <<'EOF'
-#!/usr/bin/perl
-$_ = shift;
-if (s/-sub$//)  {
-	print "$_ <$_\@sub.example.com>\n";
-}
-else {
-	print "$_ <$_\@example.com>\n";
-}
+write_script svn-authors-prog $PERL_PATH <<-\EOF
+	$_ = shift;
+	if (s/-sub$//)  {
+		print "$_ <$_\@sub.example.com>\n";
+	} else {
+		print "$_ <$_\@example.com>\n";
+	}
 EOF
-chmod +x svn-authors-prog
 
-cat > svn-authors <<'EOF'
-ff = FFFFFFF FFFFFFF <fFf@other.example.com>
-EOF
+test_expect_success 'svn-authors setup' '
+	cat >svn-authors <<-\EOF
+	ff = FFFFFFF FFFFFFF <fFf@other.example.com>
+	EOF
+'
 
 test_expect_success 'setup svnrepo' '
 	for i in aa bb cc-sub dd-sub ee-foo ff
 	do
 		svn mkdir -m $i --username $i "$svnrepo"/$i
 	done
-	'
+'
 
 test_expect_success 'import authors with prog and file' '
 	git svn clone --authors-prog=./svn-authors-prog \
 	    --authors-file=svn-authors "$svnrepo" x
-	'
+'
 
 test_expect_success 'imported 6 revisions successfully' '
 	(
 		cd x
 		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 6
 	)
-	'
+'
 
 test_expect_success 'authors-prog ran correctly' '
 	(
@@ -56,7 +55,7 @@ test_expect_success 'authors-prog ran correctly' '
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 | \
 		  grep "^author aa <aa@example\.com> "
 	)
-	'
+'
 
 test_expect_success 'authors-file overrode authors-prog' '
 	(
@@ -64,7 +63,7 @@ test_expect_success 'authors-file overrode authors-prog' '
 		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
 		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> "
 	)
-	'
+'
 
 git --git-dir=x/.git config --unset svn.authorsfile
 git --git-dir=x/.git config --unset svn.authorsprog
-- 
2.0.0.rc4.1.g4a28f16.dirty
