From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Git.pm: add specified name to tempfile template
Date: Wed, 29 Oct 2014 19:31:55 +0000
Message-ID: <20141029193155.GA2232@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:32:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYyT-0004pf-LL
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbaJ2Tb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 15:31:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48801 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbaJ2Tb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:31:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id AC6641F7C9;
	Wed, 29 Oct 2014 19:31:55 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should help me track down errors in git-svn more easily:

	write .git/Git_XXXXXX: Bad file descriptor
	 at /usr/lib/perl5/SVN/Ra.pm line 623

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Not sure you want to take this separately or in a git-svn pull.
  Still working on the error this patch is meant to help me find.

 perl/Git.pm | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 204fdc6..b5905ee 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1294,8 +1294,11 @@ sub _temp_cache {
 			$tmpdir = $self->repo_path();
 		}
 
+		my $n = $name;
+		$n =~ s/\W/_/g; # no strange chars
+
 		($$temp_fd, $fname) = File::Temp::tempfile(
-			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
+			"Git_${n}_XXXXXX", UNLINK => 1, DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
 
 		$$temp_fd->autoflush;
-- 
EW
