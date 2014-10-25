From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: save a little memory as fetch progresses
Date: Sat, 25 Oct 2014 08:00:55 +0000
Message-ID: <1414224055-10184-1-git-send-email-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 20:41:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6Gp-0005Io-FD
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 20:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaJYSkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 14:40:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47561 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaJYSkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 14:40:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A4F1F454;
	Sat, 25 Oct 2014 08:00:58 +0000 (UTC)
X-Mailer: git-send-email 2.1.2.564.gaee7d04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no reason to keep entries in the %revs hash after we're
done processing a revision, so allow entries become freed as
processing continues.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN/Ra.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index e326849..5bc5b4e 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -431,7 +431,7 @@ sub gs_fetch_loop_common {
 
 		my %exists = map { $_->path => $_ } @$gsv;
 		foreach my $r (sort {$a <=> $b} keys %revs) {
-			my ($paths, $logged) = @{$revs{$r}};
+			my ($paths, $logged) = @{delete $revs{$r}};
 
 			foreach my $gs ($self->match_globs(\%exists, $paths,
 			                                   $globs, $r)) {
-- 
EW
