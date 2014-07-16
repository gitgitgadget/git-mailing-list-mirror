From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/12] wrapper.c: simplify warn_if_unremovable
Date: Wed, 16 Jul 2014 15:23:01 -0700
Message-ID: <1405549392-27306-2-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XcE-0004PR-Gd
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbaGPWXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:50 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:57530 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbaGPWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:16 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so477489ieb.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/PdOodCDMz5NTz7PF/yl0HmVnWaogknMdFA7Fhh+CY=;
        b=hxx/L/0x1ao5MJDGXEbTcEGPfuOeBqsnY5MbTK8VDZ2CM4wG+zXTAy0qrxHXhW87Kg
         X+ISZOh5z3PA0+iIU4cZMvWkd8VtdToI7Ua3IYlDh0E36Tbn5H9aewXpXxjKRXAkhQot
         o797DATrE/H+B24BKTCOHVth/wGcoiR1mT79G6HYGm6eHVTRJJy89FIvZMX3cFqvi0ed
         U0NWsy8mnAmKyX8meb8Xcztas8NRiVCoH8UH7Vkw+DP1aZ4xr0SKdco76K8LA98qaDFY
         bx53RMg4n3jj+EO66dHoOr7f0GbtqqoIlnuIedBAxv/99A8sMArrmxnRwON7Ucb6yVd5
         DeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/PdOodCDMz5NTz7PF/yl0HmVnWaogknMdFA7Fhh+CY=;
        b=e6ummoUWGWiwWjAWUojdX/E5LYvB5i41IbEu9R8a60EfKCz0jLuhxnlgI+XIDy6eOA
         aOZiX0Wfn27gjKjC1fPTjZ87aUcwNt2Ne7LS1e0UnYDqMah7DJBUTX/hn/LfaYpNn5iq
         flYrm9HptsFPifVbve1mAR8oJVI7HXwhzhKlT6cVjy5v/jYSkzGWsO9I/b3WV/2sRbDX
         +/8y5JhDQCgyoxp71dTcgqavW8FLWHi4TSsx8Chi7Zk4wZa9CrUGJJVYhqAfFp7eWRei
         K5XwU6jjM9Zg9ez/E490F7+TioBCQrSqb+Vu3yY8GQNjPkJZCsqua1Am3OI60gqp1T2C
         0fSA==
X-Gm-Message-State: ALoCoQkqVBYD6jgdtD1J+cqBQDB9TvDyjyjposI9xMkrK534fOk5K6N6iPAoJeeuiP5w9/QmqacZ
X-Received: by 10.182.43.196 with SMTP id y4mr15351537obl.35.1405549395896;
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si72759yhp.6.2014.07.16.15.23.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id BB7FA5A4123;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6866CE0855; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253706>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 wrapper.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..740e193 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
-	if (rc < 0) {
-		int err = errno;
-		if (ENOENT != err) {
-			warning("unable to %s %s: %s",
-				op, file, strerror(errno));
-			errno = err;
-		}
-	}
+	int err;
+	if (rc >= 0 || errno == ENOENT)
+		return rc;
+	err = errno;
+	warning("unable to %s %s: %s", op, file, strerror(errno));
+	errno = err;
 	return rc;
 }
 
-- 
2.0.1.527.gc6b782e
