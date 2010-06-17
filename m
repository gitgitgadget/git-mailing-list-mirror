From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] Git.pm: better error message
Date: Fri, 18 Jun 2010 01:47:31 +0200
Message-ID: <1276818451-17003-1-git-send-email-book@cpan.org>
References: <1276477222-21465-1-git-send-email-book@cpan.org>
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 18 01:47:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPOoK-0002b5-Ss
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 01:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab0FQXrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 19:47:47 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:54760 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217Ab0FQXrq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 19:47:46 -0400
Received: from localhost ([127.0.0.1] helo=swoosh)
	by ks354402.kimsufi.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1OPOoD-0008Ew-AK; Fri, 18 Jun 2010 01:47:45 +0200
Received: from book by swoosh with local (Exim 4.71)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1OPOoD-0004Qq-0f; Fri, 18 Jun 2010 01:47:45 +0200
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1276477222-21465-1-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149334>

Provide the bad directory name alongside with $!

Note: $! is set if there is "No such file or directory",
but isn't set if the file exists but is not a directory.

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 perl/Git.pm |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 1926dc9..6cb0dd1 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -172,7 +172,7 @@ sub repository {
 	}
 
 	if (defined $opts{Directory}) {
-		-d $opts{Directory} or throw Error::Simple("Directory not found: $!");
+		-d $opts{Directory} or throw Error::Simple("Directory not found: $opts{Directory} $!");
 
 		my $search = Git->repository(WorkingCopy => $opts{Directory});
 		my $dir;
@@ -545,7 +545,7 @@ sub wc_chdir {
 		or throw Error::Simple("bare repository");
 
 	-d $self->wc_path().'/'.$subdir
-		or throw Error::Simple("subdir not found: $!");
+		or throw Error::Simple("subdir not found: $subdir $!");
 	# Of course we will not "hold" the subdirectory so anyone
 	# can delete it now and we will never know. But at least we tried.
 
-- 
1.7.0.4
