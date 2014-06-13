From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] refs.c: fix delete_ref_loose
Date: Fri, 13 Jun 2014 10:02:54 -0700
Message-ID: <1402678974-21799-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 19:03:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvUsd-00067f-21
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbaFMRDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:03:00 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:58063 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbaFMRC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:02:57 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so55506igi.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6+OJwLobirqTiKx2md1O5jJ8Xuy6QwiFDybR7Ugn6VQ=;
        b=nNZIlHTtxEn8yk4REAjAjH/GbvPOxlHObEHB5XoZarTpogXJAc/zpZVE7Po5JH8Q+O
         J1N2W5WOC81HgiQc1doV5WMGa+dFfTrrFkpCgsKUxICdQ+d1mP0CtiIrTMjtWQQCDv1u
         nWFxfoKhrPlzuj6kVLpjt0mQtg7XsI+v6qrwC42tFFS7g+HaDY3Kk+W93ZfExcRXRKqG
         0KkPR2/o9xu2zl66xqrY4IDLtwecYSU+Bh5jDk+O1uSsiLhA4zWGT7SjwU/c6t6B2wGB
         Ka0LUdkd4CGg6+1V+uFuuGd5MhKDlg03zJ9Uf0/sTL6ycu1RdVrg2Nf0xBJvIQSMP2Um
         j2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+OJwLobirqTiKx2md1O5jJ8Xuy6QwiFDybR7Ugn6VQ=;
        b=CpdCXW4mcVY3dNrvoFFqu1IYhCEdBo4e6BzPJh8uTIqygP8hVry+s73+K1l18QPU6D
         B+A2vUa3+lrufta5jyuAF4NbviNu5swtzYqxoxBrjojPY176TkNNU5RIxArj8CLWH+B9
         UTgZ3uihCdFAaYL9QzrjdZ4yl2hVX4TRD/C6k4pibH/7NHgjXbwEefJk2y3YuN5WPMsw
         cozHbuG4jHlASuz93Xh+S9xLhe/E2aEMbHkSdBSKHbqk8ol6kaVOHHTVLdiXEAkXbnIl
         LbHAFUTBrez3/1cF8frTWMlt49uX3hJ8X8qiqdJq51KofvrJ2rzykDyaUkeRqviUXHvU
         C/JA==
X-Gm-Message-State: ALoCoQkHOeLTocVM1VyQeI4cYruhNj7tAwpuHFbeJZlVeiCvKxKwueOuuFSJw+usI9oVOKG0NSEe
X-Received: by 10.182.91.79 with SMTP id cc15mr1634919obb.13.1402678977375;
        Fri, 13 Jun 2014 10:02:57 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si347039yhp.6.2014.06.13.10.02.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jun 2014 10:02:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3C6C05A4A7F;
	Fri, 13 Jun 2014 10:02:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CB1B3E0BC7; Fri, 13 Jun 2014 10:02:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251613>

Please use this to fixup the patch:
refs.c: add an err argument to delete_ref_loose

With this fix and the two previous ones the ref-transactions support in
origin/pu passes all tests.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index c9605cd..740e193 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -430,8 +430,8 @@ int xmkstemp_mode(char *template, int mode)
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
-	if (!rc || errno == ENOENT)
-		return 0;
+	if (rc >= 0 || errno == ENOENT)
+		return rc;
 	err = errno;
 	warning("unable to %s %s: %s", op, file, strerror(errno));
 	errno = err;
-- 
2.0.0.415.g8cd8cf8
