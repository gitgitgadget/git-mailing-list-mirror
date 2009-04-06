From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 2/3] remote: New function remote_is_configured()
Date: Mon,  6 Apr 2009 15:41:01 +0200
Message-ID: <1239025262-16960-3-git-send-email-finnag@pvv.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com, Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp70-0002xr-Sl
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbZDFNlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbZDFNll
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:41:41 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:56650 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbZDFNlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:41:39 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lqp4p-0004Pq-2b; Mon, 06 Apr 2009 15:41:32 +0200
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115826>

Previously, there was no beautiful way to check for the existence of
a configured remote. remote_get for example would always create the remote
"on demand".

This new function returns 1 if the remote is configured, 0 otherwise.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 remote.c |   11 +++++++++++
 remote.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index d12140e..a06761a 100644
--- a/remote.c
+++ b/remote.c
@@ -667,6 +667,17 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+int remote_is_configured(const char *name)
+{
+	int i;
+	read_config();
+
+	for (i = 0; i < remotes_nr; i++)
+		if (!strcmp(name, remotes[i]->name))
+			return 1;
+	return 0;
+}
+
 int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
diff --git a/remote.h b/remote.h
index de3d21b..99706a8 100644
--- a/remote.h
+++ b/remote.h
@@ -45,6 +45,7 @@ struct remote {
 };
 
 struct remote *remote_get(const char *name);
+int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
-- 
1.6.2.1.471.gdfdaa
