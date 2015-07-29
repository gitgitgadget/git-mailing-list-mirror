From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/6] connect: expose parse_connect_url()
Date: Wed, 29 Jul 2015 17:51:13 +0200
Message-ID: <1438185076-28870-4-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdk-0000rQ-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbbG2Pv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33733 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986AbbG2PvZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id D182220DA9
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:24 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 29 Jul 2015 11:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZYLf
	+V3JM4fEo3PIXeIMgiRT/iY=; b=YE54Stm6UHqkoINi7CrS/kIEq7P+PHaupiwP
	pXa6UE0M8LVszx6zMV5MH8YaPjpMReh7IrrfTMHU4kxzeZilxw8i1GlxufIj1YlH
	/yThdO5Vm5OVxkizmAdPhY6eNvINSl9wINohS2DgdYuNi4MbtpGegq/hTO2TqwMv
	7vIhYA0=
X-Sasl-enc: g46pBwXln0+UwiGfS9KziSB6Xcjg26xmP1yrFUYUag8r 1438185084
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4512868011F;
	Wed, 29 Jul 2015 11:51:24 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438185076-28870-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274902>

Expose parse_connect_url which is to be used later in this patch
series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connect.c | 13 +------------
 connect.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/connect.c b/connect.c
index c0144d8..bdbcee4 100644
--- a/connect.c
+++ b/connect.c
@@ -228,13 +228,6 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-enum protocol {
-	PROTO_LOCAL = 1,
-	PROTO_FILE,
-	PROTO_SSH,
-	PROTO_GIT
-};
-
 int url_is_local_not_ssh(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -580,11 +573,7 @@ static char *get_port(char *host)
 	return NULL;
 }
 
-/*
- * Extract protocol and relevant parts from the specified connection URL.
- * The caller must free() the returned strings.
- */
-static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
+enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 				       char **ret_path)
 {
 	char *url;
diff --git a/connect.h b/connect.h
index c41a685..245890f 100644
--- a/connect.h
+++ b/connect.h
@@ -11,4 +11,17 @@ extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
 extern int url_is_local_not_ssh(const char *url);
 
+enum protocol {
+	PROTO_LOCAL = 1,
+	PROTO_FILE,
+	PROTO_SSH,
+	PROTO_GIT
+};
+
+/*
+ * Extract protocol and relevant parts from the specified connection URL.
+ * The caller must free() the returned strings.
+ */
+extern enum protocol parse_connect_url(const char *url_orig, char **ret_host, char **ret_path);
+
 #endif
-- 
2.5.0
