From: imre.deak@nokia.com
Subject: [PATCH] daemon: parse_host_and_port SIGSEGV if port is specified
Date: Sat, 20 Mar 2010 04:23:58 +0200
Message-ID: <1269051838-25734-1-git-send-email-imre.deak@nokia.com>
Cc: Imre Deak <imre.deak@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 03:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsoMt-0005Hs-0k
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 03:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab0CTCYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 22:24:46 -0400
Received: from smtp.nokia.com ([192.100.122.230]:25192 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0CTCYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 22:24:45 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2K2Oe9L009446;
	Sat, 20 Mar 2010 04:24:40 +0200
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by esebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 20 Mar 2010 04:24:40 +0200
Received: from mgw-sa01.ext.nokia.com ([147.243.1.47]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 20 Mar 2010 04:24:39 +0200
Received: from localhost (esdhcp040192.research.nokia.com [172.21.40.192])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2K2ObbX019277;
	Sat, 20 Mar 2010 04:24:38 +0200
X-Mailer: git-send-email 1.7.0.2
X-OriginalArrivalTime: 20 Mar 2010 02:24:39.0438 (UTC) FILETIME=[7DFFA2E0:01CAC7D4]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142675>

From: Imre Deak <imre.deak@gmail.com>

This typo will lead to git-daemon dying any time the connect
string includes a port after the host= attribute. This can lead
for example to one of the following error messages on the client
side when someone tries git clone git://...:<port>.

When the daemon is running on localhost:
  fatal: The remote end hung up unexpectedly

or when the daemon is connected through an ssh tunnel:
  fatal: protocol error: bad line length character: erro

In the latter case 'erro' comes from the daemon's reply:
  error: git-daemon died of signal 11

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 3769b6f..7d9e1c0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -420,7 +420,7 @@ static void parse_host_and_port(char *hostport, char **host,
 		*host = hostport;
 		*port = strrchr(hostport, ':');
 		if (*port) {
-			*port = '\0';
+			**port = '\0';
 			++*port;
 		}
 	}
-- 
1.7.0.2
