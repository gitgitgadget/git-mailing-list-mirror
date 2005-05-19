From: Dan Weber <dan@mirrorlynx.com>
Subject: [PATCH] Remove gitenv macro hack
Date: Thu, 19 May 2005 18:01:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191800280.16809@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri May 20 00:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYt42-000356-8D
	for gcvg-git@gmane.org; Fri, 20 May 2005 00:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVESWBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVESWBG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 18:01:06 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:16396 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S261277AbVESWA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 18:00:57 -0400
Received: from pool-68-238-242-169.phlapa.fios.verizon.net ([68.238.242.169] helo=mirrorlynx.com)
	by outbound.mailhop.org with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.51)
	id 1DYt4b-0002mA-7U
	for git@vger.kernel.org; Thu, 19 May 2005 18:00:57 -0400
Received: from dan (helo=localhost)
	by mirrorlynx.com with local-esmtp (Exim 4.34)
	id 1DYt4v-0004Od-HB
	for git@vger.kernel.org; Thu, 19 May 2005 18:01:18 -0400
To: Git Mailing List <git@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: dan@mirrorlynx.com
X-Spam-Checker-Version: SpamAssassin 3.0.0 (2004-09-13) on mirrorlynx.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=unavailable version=3.0.0
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mirrorlynx.com)
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 68.238.242.169
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: DanWeber1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Removed hacky macro for gitenv.  Often produced warnings by the compiler 
for the use of ?: without anything after the ?

Signed-off-by: Dan Weber <dan@mirrorlynx.com>

---
commit 1b48b369a152a6315a9b4e6eebf50f56176cdd82
tree 53c238f3aa788df47325c456ab16b0eb25004074
parent 5cd4c7b7686d334e341b21d92449349feda3ef65
author Dan Weber <dan@mirrorlynx.com> Thu, 19 May 2005 17:57:44 -0400
committer Dan Weber <dan@mirrorlynx.com> Thu, 19 May 2005 17:57:44 -0400

  cache.h |    8 +++++++-
  1 files changed, 7 insertions(+), 1 deletion(-)

Index: cache.h
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cache.h  (mode:100644)
+++ 53c238f3aa788df47325c456ab16b0eb25004074/cache.h  (mode:100644)
@@ -37,7 +37,13 @@
   * We accept older names for now but warn.
   */
  extern char *gitenv_bc(const char *);
-#define gitenv(e) (getenv(e) ? : gitenv_bc(e))
+static inline char* gitenv(const char* name) {
+       char* result = getenv(name);
+       if (result)
+               return result;
+       else
+               return gitenv_bc(name);
+}

  /*
   * Basic data structures for the directory cache

