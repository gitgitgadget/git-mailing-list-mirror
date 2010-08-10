From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/lib-git-svn.sh: use $PERL_PATH for perl, not perl from $PATH
Date: Tue, 10 Aug 2010 12:14:25 +0000
Message-ID: <1281442465-27750-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	"Philippe Bruhat (BooK)" <book@cpan.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 14:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OinjM-0004w4-3a
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 14:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab0HJMOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 08:14:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60518 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0HJMOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 08:14:50 -0400
Received: by wwj40 with SMTP id 40so12787593wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=P8/0VJ8akgvupuKKsDWsS+Jnjfg/4zK5l4Q4Z8ttFWo=;
        b=amvIqgT6x0fKmkxvrnQdRL95IM3RxskrSRS7FKw8p6LInPT8MmgcqKwtDr/BHg9dce
         KSiISgfukOwD3moXDe5KcLi/EQjKmLIBfNRRI9I76csqGL5HxDR6YNCIBeO402orHm9p
         wnbbF+JBsunO1XzyuHCNf18wIT01hZqxuy1HE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=eMp7Xrt6M11H+NOTm2iQvXjhFsKsYm1/b4KivSYkGpwp8tT02ZyGCo7CVL8GQEvkZN
         /c1icnzKKJptiNiwlpp3BQCzCkwPSjzhYjFtbO7iwPrCYURhAFGtzWCGVhih6pHjpZw3
         eUXckNbv3+zI5PccDOMLajawGNM/Dilht99/0=
Received: by 10.216.235.106 with SMTP id t84mr9596342weq.46.1281442488982;
        Tue, 10 Aug 2010 05:14:48 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h37sm3264190wej.23.2010.08.10.05.14.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 05:14:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153096>

Change the git-svn tests to use $PERL_PATH, not the "perl" in $PATH.

Using perl in $PATH was added by Sam Vilain in v1.6.6-rc0~95^2~3,
Philippe Bruhat introduced $PERL_PATH to the test suite in
v1.6.6-rc0~9^2, but the lib-git-svn.sh tests weren't updated to use
the new convention.

This resulted in the git-svn tests always being skipped on my
system. My /usr/bin/perl has access to SVN::Core and SVN::Repos, but
the perl in my $PATH does not.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-git-svn.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index c3f6676..92d6d31 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -16,7 +16,6 @@ fi
 GIT_DIR=3D$PWD/.git
 GIT_SVN_DIR=3D$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=3D$GIT_SVN_DIR/svn-tree
-PERL=3D${PERL:-perl}
=20
 svn >/dev/null 2>&1
 if test $? -ne 1
@@ -30,7 +29,7 @@ export svnrepo
 svnconf=3D$PWD/svnconf
 export svnconf
=20
-$PERL -w -e "
+"$PERL_PATH" -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
@@ -130,7 +129,7 @@ stop_httpd () {
 }
=20
 convert_to_rev_db () {
-	$PERL -w -- - "$@" <<\EOF
+	"$PERL_PATH" -w -- - "$@" <<\EOF
 use strict;
 @ARGV =3D=3D 2 or die "Usage: convert_to_rev_db <input> <output>";
 open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
--=20
1.7.1
