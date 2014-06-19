From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 17/48] update-ref: use err argument to get error from ref_transaction_commit
Date: Thu, 19 Jun 2014 08:52:59 -0700
Message-ID: <1403193210-6028-18-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeh3-0000VH-Js
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924AbaFSPzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:52 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:47285 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so294909pbc.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=APB3xhxW7sEkJ0DKGgUgY/YQ9HLSs8j6Uv1tQOlRtG0=;
        b=o5r36t40/EsD32qmu/tl216LIJmRcqVZmxujFVzYSR0XxVSwfGlP2NREW6asBHnmSR
         io1Gi7cHfr65aAUj7c2ydlVznblk34kkVozlOKDudykUghrd8UrJAVK4uiyBFcWZB9pL
         r2EC5NOsZ5Q8VSy04FmXob88nxlEraOMPlmXTUZdT3SaDNa31pn/RDm0zk/CZqqOTZXR
         GWUq0aiNcOkpRHS3rwpdhlSS2iMnIt6mo5fDX1hqfSns/BJvKMzGPTzFCM6zTfeiPONo
         ovpjsLoj/0xMYb/hX15S7EbvoQnVdLQ2WuIKEAxx16v1+iBhrKRJAKhwNHBL64/SvlJp
         Ij+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=APB3xhxW7sEkJ0DKGgUgY/YQ9HLSs8j6Uv1tQOlRtG0=;
        b=KvZaMVTRQ8jGzXKi5SUyDYQLpGkCNodp+hir/ss41wLh4oHoS/xFU/Dym0/xtlQetn
         HnkXpN0bYRVVnoQJI7lDWAMKhusFtRfm6Roa/Qh3V81zbPk1Z511hWvY2P/+A2Tjw0Bk
         KmJcL0tBseEZRVKTgOvmwVPZCaJQ0D0VaUO2yyos3R0sHFIQnZxt5RJfwDLWh1h2xpW8
         2Uk6VzN9P1P/uXTcvMM0v8+wUJRBUOLnrip3G64ViC/Yiqct+HzGDzWWT3jN7GN8FUfI
         3LA4l/0pU/KaOjA4qgwewOc4F8baNddgDNDmiqoMKJrv37A9SesOlLmaNSdQL/uL2tsZ
         IBgQ==
X-Gm-Message-State: ALoCoQnhYrOCaYlnkdcc7o6hO58LT0KIq/NX0vKiJR/h+8gQRXdwgzrN3dZvFzfHxVOtSIiE2QAw
X-Received: by 10.66.228.162 with SMTP id sj2mr2740437pac.11.1403193213621;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j5si420406yhi.1.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6FC035A46C2;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2B93DE24F0; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252152>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 22617af..aec9004 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,18 +360,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
-		return ret;
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.438.g337c581
