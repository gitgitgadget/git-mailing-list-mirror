From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-remote show: Also shorten non-fast-forward refs in the 'push' listing
Date: Sat, 9 Jun 2007 22:34:16 +0200
Message-ID: <200706092234.17029.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 22:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx7dd-0007aJ-Nj
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 22:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbXFIUeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756696AbXFIUeU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 16:34:20 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:37734 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbXFIUeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 16:34:19 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 117F9BF3F3
	for <git@vger.kernel.org>; Sat,  9 Jun 2007 22:34:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BD08856D48
	for <git@vger.kernel.org>; Sat,  9 Jun 2007 22:34:17 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49613>

'git-remote show remote-name' lists the refs that are pushed to the remote
by showing the 'Push' line from the config file. But before showing it,
it shortened 'refs/heads/here:refs/heads/there' to 'here:there'. However,
if the Push line is prefixed with a plus, the ref was not shortened.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-remote.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 5763799..b59cafd 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -258,6 +258,7 @@ sub show_remote {
 	if ($info->{'PUSH'}) {
 		my @pushed = map {
 			s|^refs/heads/||;
+			s|^\+refs/heads/|+|;
 			s|:refs/heads/|:|;
 			$_;
 		} @{$info->{'PUSH'}};
-- 
1.5.2
