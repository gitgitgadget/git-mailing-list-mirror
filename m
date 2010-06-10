From: Jim Ramsay <i.am@jimramsay.com>
Subject: [PATCH] gitk: Decode the "-n" argument properly for Edit View
Date: Thu, 10 Jun 2010 12:33:24 -0400
Message-ID: <20100610123324.0070dac2@vrm378-02.vrm378.am.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Jun 10 18:33:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMkhJ-0003BS-5q
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 18:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0FJQdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 12:33:33 -0400
Received: from mail.usask.ca ([128.233.192.26]:42206 "EHLO mail2.usask.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759546Ab0FJQdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 12:33:32 -0400
Received: from conversion-daemon.mail2.usask.ca by mail2.usask.ca
 (Sun Java(tm) System Messaging Server 6.3-6.03 (built Mar 14 2008; 32bit))
 id <0L3T0030049P2P00@mail2.usask.ca> for git@vger.kernel.org; Thu,
 10 Jun 2010 10:33:29 -0600 (CST)
Received: from vrm378-02.vrm378.am.mot.com ([144.190.95.61])
 by mail2.usask.ca (Sun Java(tm) System Messaging Server 6.3-6.03 (built Mar 14
 2008; 32bit)) with ESMTPSA id <0L3T000SA4NRUTC0@mail2.usask.ca>; Thu,
 10 Jun 2010 10:33:28 -0600 (CST)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148889>

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



-- 
Jim Ramsay
