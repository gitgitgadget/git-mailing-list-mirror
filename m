From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: [PATCH] Fix remote_get so it will return NULL when no remote is
	found.
Date: Thu, 05 Jun 2008 09:48:11 -0300
Message-ID: <1212670091.30293.3.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 14:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Eu0-00064l-F3
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104AbYFEMsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 08:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbYFEMsT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:48:19 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:58307 "EHLO
	spunkymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756968AbYFEMsS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 08:48:18 -0400
Received: from [127.0.0.1] (unknown [139.82.86.2])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by spunkymail-a6.g.dreamhost.com (Postfix) with ESMTP id DF813109F2B
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 05:48:17 -0700 (PDT)
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83918>

>From 0cf45f264cf7f1b3aa3a8875109fbf4c03d56126 Mon Sep 17 00:00:00 2001
From: Victor Bogado <victor@bogado.net>
Date: Thu, 5 Jun 2008 09:36:41 -0300
Subject: [PATCH] Fix remote_get so it will return NULL when no remote is
found.

remote_get should return NULL when there is no remote with that name, at
least this is what remote.c's rm() function seems to think. As this is a
reasonable assumption, and it seems that the function remote_get is
acutally trying to do this, I fixed the test so it will test if the URL
is equal to the name of the remote.
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 91e3b11..62b3611 100644
--- a/remote.c
+++ b/remote.c
@@ -598,7 +598,7 @@ struct remote *remote_get(const char *name)
 	}
 	if (!ret->url)
 		add_url_alias(ret, name);
-	if (!ret->url)
+	if (!strcmp(*ret->url,ret->name))
 		return NULL;
 	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr,
ret->fetch_refspec);
 	ret->push = parse_push_refspec(ret->push_refspec_nr,
ret->push_refspec);
-- 
1.5.5
