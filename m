From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/14] credential-cache--daemon: delete socket from main()
Date: Mon,  8 Jun 2015 11:07:44 +0200
Message-ID: <315f2dd7b119c5d7ec440ed3e49fbef5ec60ed06.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2r-0002mi-Og
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbbFHJIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:31 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45964 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752838AbbFHJIH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:07 -0400
X-AuditID: 12074411-f796c6d000000bc9-f4-55755b77d0da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D1.DB.03017.77B55755; Mon,  8 Jun 2015 05:08:07 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojb010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:06 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqFseXRpqcHKauEXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74+H7XSwF
	X9kq5r/tZ2lgPMPaxcjJISFgInH6Uh+ULSZx4d56ti5GLg4hgcuMEr+fb2AHSQgJnGCSaJvg
	A2KzCehKLOppZgKxRQQcJU48uA7WzCzgILH5cyMjiC0s4CWxaflzNhCbRUBVYvfe5ywgNq9A
	lMSXX/3MEMvkJM4f/wlmcwpYSPz6ugtoJgfQLnOJH3NZJzDyLmBkWMUol5hTmqubm5iZU5ya
	rFucnJiXl1qka6qXm1mil5pSuokREjyCOxhnnJQ7xCjAwajEw3tgUUmoEGtiWXFl7iFGSQ4m
	JVHejxGloUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJksgHK8KYmVValF+TApaQ4WJXFeviXq
	fkIC6YklqdmpqQWpRTBZGQ4OJQle8yigRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKS
	jHhQXMQXAyMDJMUDtLcBpJ23uCAxFygK0XqKUZfjzpT/i5iEWPLy81KlxHm/RQIVCYAUZZTm
	wa2ApYpXjOJAHwvz2oCM4gGmGbhJr4CWMAEt+f61GGRJSSJCSqqBUa0k7PWhn0mf+wUEpCUv
	Lm1YMSMt4th+r5NvbTTOb88zk188iXH1Wva2jBXXd0keZQt3kRDU+Bxm/lwo1+GT/b95T/58
	mMI0i/NLtHWCZjrTavcCwc0clt8llcwK7ti2p9ZXcqrMuNAsZ1O2T088lFH7wnXT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271005>

main() is responsible for cleaning up the socket in the case of
errors, so it is reasonable to also make it responsible for cleaning
it up when there are no errors. This change also makes the next step
easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 credential-cache--daemon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index c2f0049..a671b2b 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -221,7 +221,6 @@ static void serve_cache(const char *socket_path, int debug)
 		; /* nothing */
 
 	close(fd);
-	unlink(socket_path);
 }
 
 static const char permissions_advice[] =
@@ -280,5 +279,7 @@ int main(int argc, const char **argv)
 
 	serve_cache(socket_path, debug);
 
+	unlink(socket_path);
+
 	return 0;
 }
-- 
2.1.4
