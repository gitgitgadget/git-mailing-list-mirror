From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] pre-commit.sample: don't print incidental SHA1
Date: Sat, 16 May 2009 12:21:50 +0200
Message-ID: <87y6sx1h6p.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 12:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5H1u-0007oB-Kc
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 12:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbZEPKV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 06:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZEPKV6
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 06:21:58 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38690 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbZEPKV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 06:21:58 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EB5818180B5
	for <git@vger.kernel.org>; Sat, 16 May 2009 12:21:53 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1724D81814C
	for <git@vger.kernel.org>; Sat, 16 May 2009 12:21:51 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id F02C22CAB4; Sat, 16 May 2009 12:21:50 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119351>


Make the sample pre-commit hook script discard
all git-rev-parse output, not just stderr.
Otherwise, it would print an SHA1.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
[this patch applies at least to "next"]
I enabled the sample pre-commit hook and was surprised to
see new output with every commit.  It was due to that script's
use of git-rev-parse.

Also, I noticed the use of "git-hyphen" git-rev-parse.
Perhaps that hyphen has been left in deliberately,
for portability to very old versions of git?

While the 800+ uses of "git rev-parse" far outnumber uses of the
two-hyphen version, this is far from being the only use in code
(this is on the "next" branch):

  $ git grep -l git-rev-parse|grep -vE 'Docu|command-list|\.giti'
  contrib/emacs/git.el
  contrib/examples/git-revert.sh
  git-archimport.perl
  git-cvsexportcommit.perl
  git-cvsimport.perl
  git-submodule.sh
  gitweb/gitweb.perl
  perl/Git.pm
  templates/hooks--pre-commit.sample


 templates/hooks--pre-commit.sample |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..0ba6207 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,7 +7,7 @@
 #
 # To enable this hook, rename this file to "pre-commit".

-if git-rev-parse --verify HEAD 2>/dev/null
+if git-rev-parse --verify HEAD >/dev/null 2>&1
 then
 	against=HEAD
 else
-- 
1.6.3.1.83.g37eb7
