From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] ls-files: Don't require exclude files to end with a newline.
Date: Sat, 18 Mar 2006 11:27:45 +0100
Message-ID: <8764mccaji.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 18 11:28:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKYfB-0004K2-KL
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 11:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWCRK16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 05:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCRK16
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 05:27:58 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58058 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751206AbWCRK16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 05:27:58 -0500
Received: from adsl-62-167-67-224.adslplus.ch ([62.167.67.224] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FKYez-0001Qd-7u
	for git@vger.kernel.org; Sat, 18 Mar 2006 04:27:57 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id E0C2D4F657; Sat, 18 Mar 2006 11:27:45 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 62.167.67.224
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL,SPF_HELO_SOFTFAIL autolearn=no 
	version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17695>

Without this patch, the last line of an exclude file is silently
ignored if it doesn't end with a newline.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 ls-files.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

9c5a78851bcf3b541364f818f6b397c29a8f4592
diff --git a/ls-files.c b/ls-files.c
index df25c8c..e42119c 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -92,11 +92,12 @@ static int add_excludes_from_file_1(cons
 		close(fd);
 		return 0;
 	}
-	buf = xmalloc(size);
+	buf = xmalloc(size+1);
 	if (read(fd, buf, size) != size)
 		goto err;
 	close(fd);
 
+	buf[size++] = '\n';
 	entry = buf;
 	for (i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
-- 
1.2.4.g5a1f-dirty

-- 
Alexandre Julliard
julliard@winehq.org
