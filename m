From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/5] NUL hack to create_file()
Date: Wed, 28 May 2008 17:17:26 -0700
Message-ID: <1212020246-26480-7-git-send-email-gitster@pobox.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <1212020246-26480-2-git-send-email-gitster@pobox.com>
 <1212020246-26480-3-git-send-email-gitster@pobox.com>
 <1212020246-26480-4-git-send-email-gitster@pobox.com>
 <1212020246-26480-5-git-send-email-gitster@pobox.com>
 <1212020246-26480-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VrD-0004LH-A7
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYE2ASN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYE2ASL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:18:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbYE2ASH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:18:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 601C02B65
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:18:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C21502B64 for <git@vger.kernel.org>; Wed, 28 May 2008 20:18:06 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
In-Reply-To: <1212020246-26480-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B66784CE-2D14-11DD-B0EA-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83161>

This is not meant for application to the mainline.  It allows your git to
refuse to create a blob whose name is "nul".

---
 entry.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/entry.c b/entry.c
index 222aaa3..d24b803 100644
--- a/entry.c
+++ b/entry.c
@@ -81,6 +81,14 @@ static void remove_subtree(const char *path)
 
 static int create_file(const char *path, unsigned int mode)
 {
+	if (1) {
+		size_t len = strlen(path);
+		if (3 <= len && !strcmp(path + len - 3, "nul") &&
+		    (3 == len || path[len - 4] == '/')) {
+			errno = EPERM;
+			return -1;
+		}
+	}
 	mode = (mode & 0100) ? 0777 : 0666;
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
-- 
1.5.6.rc0.43.g823ea
