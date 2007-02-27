From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH] git-archimport does not cope with empty summaries
Date: Tue, 27 Feb 2007 14:34:17 +0100
Message-ID: <45E43359.3030400@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 21:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMVWh-0004Ff-2H
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 21:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXB1Ufo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 15:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXB1Ufo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 15:35:44 -0500
Received: from server.usilu.net ([195.176.178.200]:46949 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751923AbXB1Ufn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 15:35:43 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 27 Feb 2007 14:34:17 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
X-OriginalArrivalTime: 27 Feb 2007 13:34:17.0436 (UTC) FILETIME=[FA88D9C0:01C75A73]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41004>

I got this while importing bonzini@gnu.org--2004b/lightning--stable--1.2 
(archive available at 
http://www.inf.unisi.ch/phd/bonzini/webdav/bonzini@gnu.org--2004b via 
webdav).

The patch seems pretty obvious to me:

2007-02-27  Paolo Bonzini  <bonzini@gnu.org>

         * git-archimport (parselog): Cope with an empty summary.

--- /usr/bin/git-archimport     2007-01-09 21:15:39.000000000 +0100
+++ ./git-archimport    2007-02-27 14:28:33.000000000 +0100
@@ -780,7 +780,11 @@
      }

      # post-processing:
-    $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    if (defined $ps->{summary}) {
+        $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    } else {
+        $ps->{summary} = "empty summary\n";
+    }
      $ps->{message} = join("\n",@$log);

      # skip Arch control files, unescape pika-escaped files
