From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 1/4] config.c: Add git_config_bool_or_int to handle bool/int variable
Date: Sat, 12 Apr 2008 23:05:30 +0800
Message-ID: <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 12 17:06:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhJN-0003cF-EL
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYDLPFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbYDLPFi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:05:38 -0400
Received: from mail.qikoo.org ([60.28.205.235]:45353 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752624AbYDLPFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:05:37 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 47C7C470AB; Sat, 12 Apr 2008 23:05:33 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79357>

With git_config_bool_or_int, the caller can differentiate boolean true
and integer 1 etc.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 config.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 0624494..e614456 100644
--- a/config.c
+++ b/config.c
@@ -316,6 +316,21 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }
 
+int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+{
+	*is_bool = 1;
+	if (!value)
+		return 1;
+	if (!*value)
+		return 0;
+	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
+		return 1;
+	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
+		return 0;
+	*is_bool = 0;
+	return git_config_int(name, value);
+}
+
 int git_config_string(const char **dest, const char *var, const char *value)
 {
 	if (!value)
-- 
1.5.5.23.g2a5f
