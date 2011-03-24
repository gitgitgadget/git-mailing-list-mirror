From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] fixup! vcs-svn: improve reporting of input errors
Date: Thu, 24 Mar 2011 23:43:56 +1100
Message-ID: <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 13:44:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2jtv-0002fH-5J
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 13:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1CXMoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 08:44:25 -0400
Received: from [119.15.97.146] ([119.15.97.146]:58845 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751947Ab1CXMoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 08:44:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 6E8F4C04B;
	Thu, 24 Mar 2011 23:40:58 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f+irHe2QTm1L; Thu, 24 Mar 2011 23:40:56 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 76C36C040;
	Thu, 24 Mar 2011 23:40:56 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169914>

An excessive constraint was introduced in c9d1c8ba; when reading
svn props, it is permissible for both keys and values to contain
nul characters. Thus the test `strlen(val) != len` may fail on
such properties. This caused svn-fe to die early whilst handling
revision 59151 of the ASF repository.
---
 vcs-svn/svndump.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ea5b128..9bd4fb2 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -171,7 +171,7 @@ static void read_props(void)
 			die("invalid property line: %s\n", t);
 		len = atoi(&t[2]);
 		val = buffer_read_string(&input, len);
-		if (!val || strlen(val) != len)
+		if (!val)
 			die_short_read();
 
 		/* Discard trailing newline. */
-- 
1.7.3.2.846.gf4b062
