From: Jim Ramsay <i.am@jimramsay.com>
Subject: Repost: [PATCH] gitk: Decode the "-n" argument properly for Edit View
Date: Wed, 02 Jun 2010 11:16:57 -0400
Message-ID: <20100602111657.2e91faec@vrm378-02.vrm378.am.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 02 17:24:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpnX-0001Gz-13
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 17:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab0FBPX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 11:23:57 -0400
Received: from mail.usask.ca ([128.233.192.26]:41716 "EHLO mail2.usask.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340Ab0FBPX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 11:23:56 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2010 11:23:56 EDT
Received: from conversion-daemon.mail2.usask.ca by mail2.usask.ca
 (Sun Java(tm) System Messaging Server 6.3-6.03 (built Mar 14 2008; 32bit))
 id <0L3E00A007JRRC00@mail2.usask.ca> for git@vger.kernel.org; Wed,
 02 Jun 2010 09:17:01 -0600 (CST)
Received: from vrm378-02.vrm378.am.mot.com ([144.190.95.61])
 by mail2.usask.ca (Sun Java(tm) System Messaging Server 6.3-6.03 (built Mar 14
 2008; 32bit)) with ESMTPSA id <0L3E00AKU7SCRD00@mail2.usask.ca>; Wed,
 02 Jun 2010 09:17:01 -0600 (CST)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148262>

Running 'gitk -n 42' and selecting View > Edit View... would previously
put the '-n' half of the argument-pair in the box labeled "Additional
arguments to git log" and the '42' in "Branches & Tags".  Parse this
pair properly and use the numerical portion for the 'limit' value.

Signed-off-by: Jim Ramsay <i.am@jimramsay.com>
---
 gitk-git/gitk |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..f93e7e5 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3907,6 +3907,17 @@ proc decode_view_opts {n view_args} {
     set oargs [list]
     set refargs [list]
     foreach arg $view_args {
+	# Decode 2-argument '-n 42' as 'limit'
+	if {[info exists haslimitarg]} {
+	    set newviewopts($n,limit) $arg
+	    set found(limit) 1
+	    unset haslimitarg
+	    continue
+	}
+	if {$arg eq "-n"} {
+	    set haslimitarg 1
+	    continue
+	}
 	if {[regexp -- {^-([0-9]+)$} $arg arg cnt]
 	    && ![info exists found(limit)]} {
 	    set newviewopts($n,limit) $cnt
-- 
1.7.0.2
