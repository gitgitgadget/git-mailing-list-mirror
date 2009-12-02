From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 4/5] git-svn: Provide a default "empty commit message" so the metadata is not the header
Date: Wed,  2 Dec 2009 14:07:53 -0500
Message-ID: <1259780874-14706-5-git-send-email-alex@chmrr.net>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv20-0007t6-IW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbZLBThl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZLBThk
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:37:40 -0500
Received: from chmrr.net ([209.67.253.66]:56891 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895AbZLBThh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:37:37 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NFuYq-0004Rd-ES
	for git@vger.kernel.org; Wed, 02 Dec 2009 14:08:28 -0500
X-Mailer: git-send-email 1.6.6.rc0.327.g032bc
In-Reply-To: <1259780874-14706-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-02 14:08:28
X-Connected-IP: 75.147.59.54:47077
X-Message-Linecount: 35
X-Body-Linecount: 26
X-Message-Size: 1385
X-Body-Size: 944
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134386>

git-svn adds a trailing line of metadata to the commit message.  If
the commit message would otherwise be empty, this can lead to
confusing display in `gitk` and `git log --oneline`.  Thus, provide a
no-op "(empty commit message)" message for the first line of such
messages.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0731425..87462c9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3111,6 +3111,7 @@ sub make_log_entry {
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
 	parse_svk_log(\%log_entry) if $log_entry{log} =~ svk_header_regex( lenient => 1 );
+	$log_entry{log} = "(empty commit message)\n" unless $log_entry{log} =~ /\S/;
 
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
-- 
1.6.6.rc0.327.g032bc
